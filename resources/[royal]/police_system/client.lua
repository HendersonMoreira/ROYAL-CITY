local Config = Config or {}

local InPrison = false
local IsReviving = false
local LastEscapeTick = 0

local CarryingBox = false
local BoxObject = nil

local PrisonConfig = Config.Prison or {}
local BoxConfig = Config.BoxSystem or {}

local PrisonEnter = vector3(
    PrisonConfig.Enter and PrisonConfig.Enter.x or 1598.25,
    PrisonConfig.Enter and PrisonConfig.Enter.y or 2607.08,
    PrisonConfig.Enter and PrisonConfig.Enter.z or 46.66
)

local PrisonExit = vector3(
    PrisonConfig.Exit and PrisonConfig.Exit.x or 1853.35,
    PrisonConfig.Exit and PrisonConfig.Exit.y or 2615.97,
    PrisonConfig.Exit and PrisonConfig.Exit.z or 45.66
)

local PrisonHeading = PrisonConfig.EnterHeading or 268.0
local ExitHeading = PrisonConfig.ExitHeading or 90.0
local EscapeDistance = PrisonConfig.EscapeDistance or 45.0

local function DrawText3D(x,y,z,text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    if onScreen then
        SetTextFont(4)
        SetTextScale(0.35,0.35)
        SetTextColour(255,255,255,215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function LoadModel(model)
    local hash = type(model) == "number" and model or GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    return hash
end

local function RemoveBox()
    local ped = PlayerPedId()

    if BoxObject and DoesEntityExist(BoxObject) then
        DetachEntity(BoxObject,false,false)
        SetEntityAsMissionEntity(BoxObject,true,true)
        DeleteObject(BoxObject)
    end

    BoxObject = nil
    CarryingBox = false

    ClearPedSecondaryTask(ped)
    StopAnimTask(ped,"anim@heists@box_carry@","idle",1.0)
end

local function AttachBox(force)
    if CarryingBox and not force and BoxObject and DoesEntityExist(BoxObject) then
        return
    end

    local ped = PlayerPedId()
    LoadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(ped,"anim@heists@box_carry@","idle",8.0,8.0,-1,49,0,false,false,false)

    if BoxObject and DoesEntityExist(BoxObject) then
        DeleteObject(BoxObject)
        BoxObject = nil
    end

    local model = LoadModel(BoxConfig.Prop or "prop_cs_cardbox_01")
    local coords = GetEntityCoords(ped)

    BoxObject = CreateObject(model,coords.x,coords.y,coords.z,true,true,false)
    SetEntityAsMissionEntity(BoxObject,true,true)
    SetEntityCollision(BoxObject,false,false)
    SetEntityCompletelyDisableCollision(BoxObject,false,false)
    SetEntityInvincible(BoxObject,true)

    AttachEntityToEntity(
        BoxObject,
        ped,
        GetPedBoneIndex(ped,BoxConfig.Bone or 57005),
        (BoxConfig.PropPosition and BoxConfig.PropPosition.x) or 0.03,
        (BoxConfig.PropPosition and BoxConfig.PropPosition.y) or 0.08,
        (BoxConfig.PropPosition and BoxConfig.PropPosition.z) or -0.28,
        (BoxConfig.PropRotation and BoxConfig.PropRotation.x) or 25.0,
        (BoxConfig.PropRotation and BoxConfig.PropRotation.y) or 290.0,
        (BoxConfig.PropRotation and BoxConfig.PropRotation.z) or 175.0,
        true,true,false,true,1,true
    )

    SetModelAsNoLongerNeeded(model)
    CarryingBox = true
end

local function TeleportToPrison()
    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    if IsPedInAnyVehicle(ped,false) then
        local vehicle = GetVehiclePedIsIn(ped,false)
        TaskLeaveVehicle(ped,vehicle,4160)
        Wait(1200)
    end

    RemoveBox()

    SetEntityCoordsNoOffset(ped,PrisonEnter.x,PrisonEnter.y,PrisonEnter.z,false,false,false)
    SetEntityHeading(ped,PrisonHeading)

    Wait(500)
    DoScreenFadeIn(800)

    InPrison = true
end

local function TeleportOutPrison()
    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    if IsPedInAnyVehicle(ped,false) then
        local vehicle = GetVehiclePedIsIn(ped,false)
        TaskLeaveVehicle(ped,vehicle,4160)
        Wait(1200)
    end

    RemoveBox()

    SetEntityCoordsNoOffset(ped,PrisonExit.x,PrisonExit.y,PrisonExit.z,false,false,false)
    SetEntityHeading(ped,ExitHeading)

    Wait(500)
    DoScreenFadeIn(800)

    InPrison = false
    IsReviving = false
end

local function FullHealPed(ped)
    SetPedMaxHealth(ped,200)
    SetEntityHealth(ped,200)
    Wait(150)
    SetPedMaxHealth(ped,200)
    SetEntityHealth(ped,200)
    SetPedArmour(ped,0)
    ClearPedBloodDamage(ped)
    ClearPedTasksImmediately(ped)
    ClearPedSecondaryTask(ped)
    ResetPedRagdollTimer(ped)
    ClearEntityLastDamageEntity(ped)
end

local function ReviveInPrison()
    if IsReviving then return end
    IsReviving = true

    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    SetPlayerInvincible(PlayerId(),true)
    FreezeEntityPosition(ped,true)

    RemoveBox()

    NetworkResurrectLocalPlayer(PrisonEnter.x,PrisonEnter.y,PrisonEnter.z,PrisonHeading,true,true,false)
    Wait(200)

    SetEntityCoordsNoOffset(ped,PrisonEnter.x,PrisonEnter.y,PrisonEnter.z,false,false,false)
    SetEntityHeading(ped,PrisonHeading)

    FullHealPed(ped)

    if GetResourceState("survival") == "started" then
        exports["survival"]:Revive(200,false)
    end

    Wait(200)
    FullHealPed(ped)

    if LocalPlayer and LocalPlayer["state"] then
        LocalPlayer["state"]:set("Dead",false,true)
        LocalPlayer["state"]:set("Crawl",false,true)
        LocalPlayer["state"]:set("Bleeding",0,true)
        LocalPlayer["state"]:set("Injuries",0,true)
    end

    TriggerEvent("player:DeathUpdate",false)
    TriggerEvent("hud:Active",true)
    TriggerEvent("paramedic:Reset")

    SetNuiFocus(false,false)
    Wait(300)

    SetEntityCoordsNoOffset(ped,PrisonEnter.x,PrisonEnter.y,PrisonEnter.z,false,false,false)
    SetEntityHeading(ped,PrisonHeading)

    FreezeEntityPosition(ped,false)
    SetPlayerInvincible(PlayerId(),false)

    DoScreenFadeIn(800)
    TriggerEvent("Notify","amarelo","Você foi revivido na prisão.",5000)

    InPrison = true
    IsReviving = false
end

RegisterNetEvent("wn_prisoncmd:teleportToPrison",function()
    TeleportToPrison()
end)

RegisterNetEvent("wn_prisoncmd:teleportOutPrison",function()
    TeleportOutPrison()
end)

RegisterNetEvent("wn_prisoncmd:setPrisonState",function(status)
    InPrison = status and true or false

    if not InPrison then
        RemoveBox()
        IsReviving = false
    end
end)

CreateThread(function()
    while true do
        local time = 1000

        if InPrison then
            time = 500

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local distance = #(coords - PrisonEnter)

            if distance > EscapeDistance and GetGameTimer() >= LastEscapeTick then
                LastEscapeTick = GetGameTimer() + 2000
                RemoveBox()
                SetEntityCoordsNoOffset(ped,PrisonEnter.x,PrisonEnter.y,PrisonEnter.z,false,false,false)
                SetEntityHeading(ped,PrisonHeading)
                TriggerEvent("Notify","vermelho","Você tentou fugir e foi retornado para a prisão.",5000)
            end
        end

        Wait(time)
    end
end)

CreateThread(function()
    while true do
        local time = 1000

        if InPrison and not IsReviving then
            local ped = PlayerPedId()
            local deadState = false

            if LocalPlayer and LocalPlayer["state"] and LocalPlayer["state"]["Dead"] then
                deadState = true
            end

            if deadState or IsEntityDead(ped) or GetEntityHealth(ped) <= 101 then
                Wait(2000)
                if InPrison then
                    ReviveInPrison()
                end
            end
        end

        Wait(time)
    end
end)

CreateThread(function()
    while true do
        local time = 1000

        if CarryingBox then
            time = 300
            local ped = PlayerPedId()

            if not IsEntityPlayingAnim(ped,"anim@heists@box_carry@","idle",3) then
                LoadAnimDict("anim@heists@box_carry@")
                TaskPlayAnim(ped,"anim@heists@box_carry@","idle",8.0,8.0,-1,49,0,false,false,false)
            end

            if not BoxObject or not DoesEntityExist(BoxObject) then
                AttachBox(true)
            elseif not IsEntityAttachedToEntity(BoxObject,ped) then
                AttachBox(true)
            end
        end

        Wait(time)
    end
end)

CreateThread(function()
    while true do
        local time = 1000

        if InPrison then
            time = 5

            local coords = GetEntityCoords(PlayerPedId())
            local pickup = BoxConfig.Pickup
            local delivery = BoxConfig.Delivery
            local markerDistance = BoxConfig.MarkerDistance or 15.0
            local interactDistance = BoxConfig.Distance or 1.5

            local distPickup = #(coords - vector3(pickup.x,pickup.y,pickup.z))
            local distDelivery = #(coords - vector3(delivery.x,delivery.y,delivery.z))

            if not CarryingBox then
                if distPickup <= markerDistance then
                    DrawMarker(21,pickup.x,pickup.y,pickup.z - 0.6,0.0,0.0,0.0,0.0,180.0,130.0,0.45,0.45,0.30,255,255,255,120,1,0,0,1)
                    if distPickup <= interactDistance then
                        DrawText3D(pickup.x,pickup.y,pickup.z,"~w~[~g~E~w~] PEGAR CAIXA")
                        if IsControlJustPressed(0,38) then
                            AttachBox(true)
                            TriggerEvent("Notify","amarelo","Leve a caixa até o ponto de entrega.",5000)
                        end
                    end
                end
            else
                if distDelivery <= markerDistance then
                    DrawMarker(21,delivery.x,delivery.y,delivery.z - 0.6,0.0,0.0,0.0,0.0,180.0,130.0,0.45,0.45,0.30,0,200,0,120,1,0,0,1)
                    if distDelivery <= interactDistance then
                        DrawText3D(delivery.x,delivery.y,delivery.z,"~w~[~g~E~w~] ENTREGAR CAIXA")
                        if IsControlJustPressed(0,38) then
                            RemoveBox()
                            TriggerServerEvent("police_system:reduceServiceBox",BoxConfig.ReducePerBox or 1)
                        end
                    end
                end
            end
        end

        Wait(time)
    end
end)

AddEventHandler("playerSpawned",function()
    Wait(3000)
    if LocalPlayer and LocalPlayer["state"] and LocalPlayer["state"]["Prison"] then
        InPrison = true
    end
end)

AddEventHandler("onResourceStop",function(resourceName)
    if resourceName == GetCurrentResourceName() then
        RemoveBox()
    end
end)
