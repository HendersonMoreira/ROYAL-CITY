local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("desmanche")

local Desmanche = {}
Tunnel.bindInterface("desmanche", Desmanche)

local Stage = 0
local CurrentVehicle = nil
local CurrentPlate = nil
local CurrentModel = nil
local CurrentNet = nil
local DismantleEndTime = 0
local NextDamageStep = 0
local DamageStep = 0

local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if not onScreen then return end

    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 180)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370
    DrawRect(_x, _y + 0.0125, 0.01 + factor, 0.03, 0, 0, 0, 80)
end

local function DrawSimpleMarker(x, y, z)
    DrawMarker(21, x, y, z - 0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 255, 255, 120, false, false, 2, false, nil, nil, false)
end

local function DrawRedParkingCircle(x, y, z)
    DrawMarker(1, x, y, z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.8, 3.8, 0.30, 255, 0, 0, 140, false, false, 2, false, nil, nil, false)
end

local function Notify(tipo, msg, timer)
    TriggerEvent("Notify", tipo, msg, timer or 5000)
end

local function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(10)
        end
    end
end

local function StopScenarioOrAnim(ped)
    ClearPedTasks(ped)
    ClearPedSecondaryTask(ped)
end

local function PlayInVehicleAnim()
    local ped = PlayerPedId()
    loadAnimDict("veh@std@ds@base")
    TaskPlayAnim(ped, "veh@std@ds@base", "hotwire", 8.0, -8.0, -1, 49, 0.0, false, false, false)
end

local function ResetDesmanche(cancelVehicle)
    local ped = PlayerPedId()

    StopScenarioOrAnim(ped)

    if cancelVehicle and CurrentVehicle and DoesEntityExist(CurrentVehicle) then
        FreezeEntityPosition(CurrentVehicle, false)
    end

    Stage = 0
    CurrentVehicle = nil
    CurrentPlate = nil
    CurrentModel = nil
    CurrentNet = nil
    DismantleEndTime = 0
    NextDamageStep = 0
    DamageStep = 0
end

local function DeleteVehicleEntity(vehicle)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    end
end

local function GetVehicleData()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local vehicle = nil
    if IsPedInAnyVehicle(ped) then
        vehicle = GetVehiclePedIsIn(ped, false)
    else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if not vehicle or vehicle == 0 or not DoesEntityExist(vehicle) then
        return nil
    end

    local plate = GetVehicleNumberPlateText(vehicle) or ""
    plate = plate:gsub("^%s*(.-)%s*$", "%1")

    local modelHash = GetEntityModel(vehicle)
    local modelName = GetDisplayNameFromVehicleModel(modelHash)
    modelName = string.lower(modelName or "")

    if modelName == "" then
        return nil
    end

    return vehicle, VehToNet(vehicle), plate, modelName
end

local function ApplyDismantleStep(vehicle, step)
    if not vehicle or not DoesEntityExist(vehicle) then
        return
    end

    if step == 1 then
        SetVehicleTyreBurst(vehicle, 0, true, 1000.0)
    elseif step == 2 then
        SetVehicleTyreBurst(vehicle, 1, true, 1000.0)
    elseif step == 3 then
        SetVehicleTyreBurst(vehicle, 4, true, 1000.0)
    elseif step == 4 then
        SetVehicleTyreBurst(vehicle, 5, true, 1000.0)
    elseif step == 5 then
        SetVehicleDoorBroken(vehicle, 0, true)
    elseif step == 6 then
        SetVehicleDoorBroken(vehicle, 1, true)
    end
end

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if Stage == 0 then
            for _, v in pairs(Config.Start) do
                local pos = vector3(v[1], v[2], v[3])
                local distance = #(coords - pos)
                if distance <= 20.0 then
                    sleep = 4
                    DrawRedParkingCircle(v[1], v[2], v[3])
                    DrawText3D(v[1], v[2], v[3] + 0.2, "~r~AREA DO DESMANCHE")

                    if distance <= 4.0 then
                        DrawText3D(v[1], v[2], v[3] + 0.45, "~w~Pare o carro no círculo vermelho e aperte ~g~E")
                        if IsControlJustPressed(0, 38) then
                            if not IsPedInAnyVehicle(ped, false) then
                                Notify("amarelo", "Você precisa iniciar o desmanche dentro do carro.", 5000)
                            else
                                local vehicle = GetVehiclePedIsIn(ped, false)
                                if GetPedInVehicleSeat(vehicle, -1) ~= ped then
                                    Notify("amarelo", "Você precisa estar no banco do motorista.", 5000)
                                else
                                    local vehicleCoords = GetEntityCoords(vehicle)
                                    if #(vehicleCoords - pos) > 2.6 then
                                        Notify("amarelo", "Pare o veículo dentro do círculo vermelho.", 5000)
                                    else
                                        local _, network, plate, model = GetVehicleData()
                                        local ok = vSERVER.iniciar(plate, model)
                                        if ok then
                                            CurrentVehicle = vehicle
                                            CurrentNet = network
                                            CurrentPlate = plate
                                            CurrentModel = model
                                            FreezeEntityPosition(CurrentVehicle, true)
                                            SetVehicleEngineOn(CurrentVehicle, false, true, true)
                                            PlayInVehicleAnim()
                                            DismantleEndTime = GetGameTimer() + 8000
                                            NextDamageStep = GetGameTimer() + 1200
                                            DamageStep = 0
                                            Stage = 1
                                            Notify("verde", "Desmanche iniciado. Aguarde terminar dentro do veículo.", 5000)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

        elseif Stage == 1 then
            sleep = 4

            if not CurrentVehicle or not DoesEntityExist(CurrentVehicle) then
                Notify("vermelho", "O veículo do desmanche não foi encontrado.", 5000)
                ResetDesmanche(false)
            elseif not IsPedInVehicle(ped, CurrentVehicle, false) then
                Notify("vermelho", "Você saiu do veículo e o desmanche foi cancelado.", 5000)
                ResetDesmanche(true)
            else
                DisableControlAction(0, 75, true)
                DisableControlAction(0, 23, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 264, true)

                if GetGameTimer() >= NextDamageStep and DamageStep < 6 then
                    DamageStep = DamageStep + 1
                    ApplyDismantleStep(CurrentVehicle, DamageStep)
                    NextDamageStep = GetGameTimer() + 1000
                end

                if GetGameTimer() >= DismantleEndTime then
                    StopScenarioOrAnim(ped)
                    FreezeEntityPosition(CurrentVehicle, false)
                    TaskLeaveVehicle(ped, CurrentVehicle, 0)
                    Stage = 2
                    Notify("verde", "Veículo desmontado. Vá vender as peças.", 5000)
                end
            end

        elseif Stage == 2 then
            sleep = 4
            for _, v in pairs(Config.Finish) do
                local distance = #(coords - vector3(v[1], v[2], v[3]))
                if distance <= 10.0 then
                    DrawSimpleMarker(v[1], v[2], v[3])
                    if distance <= 1.5 then
                        DrawText3D(v[1], v[2], v[3], "~w~[E] VENDER PEÇAS")
                        if IsControlJustPressed(0, 38) then
                            local ok, payment = vSERVER.finalizar(CurrentPlate, CurrentModel)
                            if ok then
                                DeleteVehicleEntity(CurrentVehicle)
                                Notify("verde", "Venda concluída. Recebido: " .. payment .. " dirtydollar.", 5000)
                                ResetDesmanche(false)
                            end
                        end
                    end
                end
            end
        end

        if Stage > 0 then
            sleep = 4
            if IsControlJustPressed(0, 168) then
                Notify("vermelho", "Desmanche cancelado.", 5000)
                ResetDesmanche(true)
            end
        end

        Wait(sleep)
    end
end)
