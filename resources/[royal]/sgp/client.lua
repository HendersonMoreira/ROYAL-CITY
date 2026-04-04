local InPatrol = false
local PatrolGroup = nil
local MyPassport = nil
local GroupMembers = {}
local Blips = {}
local ServiceRadiusBlips = {}

local function RemoveAllBlips()
    for passport, blip in pairs(Blips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end

    Blips = {}
end

local function CreateServiceRadiusBlips()
    for _, blip in pairs(ServiceRadiusBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end

    ServiceRadiusBlips = {}

    for _, data in pairs(Config.Groups) do
        local radiusBlip = AddBlipForRadius(
            data.serviceCoords.x,
            data.serviceCoords.y,
            data.serviceCoords.z,
            data.serviceRadius + 0.0
        )

        SetBlipColour(radiusBlip, data.serviceBlip.color or 29)
        SetBlipAlpha(radiusBlip, data.serviceBlip.alpha or 100)

        ServiceRadiusBlips[#ServiceRadiusBlips + 1] = radiusBlip
    end
end

local function CreateOrUpdateBlip(data)
    if MyPassport and tostring(data.passport) == tostring(MyPassport) then
        if Blips[data.passport] and DoesBlipExist(Blips[data.passport]) then
            RemoveBlip(Blips[data.passport])
            Blips[data.passport] = nil
        end
        return
    end

    local cfg = Config.Groups[PatrolGroup]
    if not cfg then
        return
    end

    if not Blips[data.passport] or not DoesBlipExist(Blips[data.passport]) then
        Blips[data.passport] = AddBlipForCoord(data.x, data.y, data.z)
        SetBlipSprite(Blips[data.passport], cfg.patrolBlip.sprite or 1)
        SetBlipColour(Blips[data.passport], cfg.patrolBlip.color or 29)
        SetBlipScale(Blips[data.passport], cfg.patrolBlip.scale or 0.85)
        SetBlipAsShortRange(Blips[data.passport], false)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(cfg.patrolBlip.name or "Patrulha")
        EndTextCommandSetBlipName(Blips[data.passport])
    else
        SetBlipCoords(Blips[data.passport], data.x, data.y, data.z)
    end
end

local function RefreshBlips()
    if not InPatrol or not PatrolGroup then
        RemoveAllBlips()
        return
    end

    local valid = {}

    for _, data in ipairs(GroupMembers) do
        if not MyPassport or tostring(data.passport) ~= tostring(MyPassport) then
            valid[data.passport] = true
            CreateOrUpdateBlip(data)
        end
    end

    for passport, blip in pairs(Blips) do
        if not valid[passport] then
            if DoesBlipExist(blip) then
                RemoveBlip(blip)
            end
            Blips[passport] = nil
        end
    end
end

RegisterNetEvent("patrulha_blips:SetPatrolState")
AddEventHandler("patrulha_blips:SetPatrolState", function(status, groupName, passport)
    InPatrol = status
    PatrolGroup = groupName
    MyPassport = passport
    GroupMembers = {}

    if not status then
        MyPassport = nil
        RemoveAllBlips()
    end
end)

RegisterNetEvent("patrulha_blips:UpdateBlips")
AddEventHandler("patrulha_blips:UpdateBlips", function(groupName, members)
    if not InPatrol then
        return
    end

    if PatrolGroup ~= groupName then
        return
    end

    GroupMembers = members or {}
end)

RegisterNetEvent("patrulha_blips:ClearAllBlips")
AddEventHandler("patrulha_blips:ClearAllBlips", function()
    GroupMembers = {}
    RemoveAllBlips()
end)

CreateThread(function()
    Wait(1000)
    CreateServiceRadiusBlips()
end)

CreateThread(function()
    while true do
        local timeDistance = 1000

        if InPatrol then
            timeDistance = Config.UpdateInterval

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            TriggerServerEvent("patrulha_blips:UpdatePosition", coords.x, coords.y, coords.z)
        end

        Wait(timeDistance)
    end
end)

CreateThread(function()
    while true do
        local timeDistance = 1000

        if InPatrol then
            timeDistance = Config.RefreshBlipsInterval
            RefreshBlips()
        end

        Wait(timeDistance)
    end
end)
