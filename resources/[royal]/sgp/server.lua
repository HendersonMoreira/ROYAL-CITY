local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local PatrolUsers = {}

local function Notify(source, type, message, time)
    TriggerClientEvent("Notify", source, type, message, time or 5000)
end

local function SendWebhook(webhook, title, description, color)
    if not webhook or webhook == "" or webhook:find("COLOQUE_WEBHOOK") then
        return
    end

    PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({
        username = "Patrulha",
        embeds = {
            {
                title = title,
                description = description,
                color = color or 3447003,
                footer = {
                    text = os.date("%d/%m/%Y %H:%M:%S")
                }
            }
        }
    }), { ["Content-Type"] = "application/json" })
end

local function GetIdentityName(passport)
    local identity = vRP.Identity(passport)
    if identity then
        local name = identity.name or identity.Name or "SemNome"
        local name2 = identity.name2 or identity.Lastname or identity.lastname or ""
        return (name .. " " .. name2)
    end

    return "Passaporte " .. tostring(passport)
end

local function GetPlayerGroup(passport)
    for groupName, data in pairs(Config.Groups) do
        if vRP.HasGroup(passport, data.permission) then
            return groupName, data
        end
    end

    return nil, nil
end

local function BuildGroupList(groupName)
    local list = {}

    for passport, data in pairs(PatrolUsers) do
        if data.group == groupName then
            list[#list + 1] = {
                passport = passport,
                name = data.name,
                x = data.x,
                y = data.y,
                z = data.z
            }
        end
    end

    return list
end

local function SendGroupUpdate(groupName)
    local members = BuildGroupList(groupName)

    for passport, data in pairs(PatrolUsers) do
        if data.group == groupName then
            local source = vRP.Source(passport)
            if source then
                TriggerClientEvent("patrulha_blips:UpdateBlips", source, groupName, members)
            end
        end
    end
end

local function LogPatrolAction(groupName, passport, name, action, coords)
    local groupData = Config.Groups[groupName]
    if not groupData then return end

    local webhook = groupData.webhook
    local title = "Patrulha - " .. groupName
    local color = action == "ENTROU" and 5763719 or 15548997

    local description = string.format(
        "**Ação:** %s\n**Passaporte:** %s\n**Nome:** %s\n**Corporação:** %s\n**Coordenadas:** %.2f, %.2f, %.2f",
        action,
        tostring(passport),
        tostring(name),
        tostring(groupName),
        coords.x or 0.0,
        coords.y or 0.0,
        coords.z or 0.0
    )

    SendWebhook(webhook, title, description, color)
end

local function RemoveFromPatrol(passport)
    local data = PatrolUsers[passport]
    if data then
        local groupName = data.group
        local lastCoords = {
            x = data.x or 0.0,
            y = data.y or 0.0,
            z = data.z or 0.0
        }

        PatrolUsers[passport] = nil

        local source = vRP.Source(passport)
        if source then
            TriggerClientEvent("patrulha_blips:SetPatrolState", source, false, nil, nil)
            TriggerClientEvent("patrulha_blips:ClearAllBlips", source)
        end

        LogPatrolAction(groupName, passport, data.name, "SAIU", lastCoords)

        if groupName then
            SendGroupUpdate(groupName)
        end
    end
end

RegisterCommand(Config.Command, function(source)
    local passport = vRP.Passport(source)

    print("[PATRULHA] comando usado. source:", source, " passport:", passport)

    if not passport then
        print("[PATRULHA] passport nil")
        return
    end

    local groupName, groupData = GetPlayerGroup(passport)
    print("[PATRULHA] grupo detectado:", tostring(groupName))

    if not groupName or not groupData then
        Notify(source, "vermelho", Config.NotifyNoPerm)
        print("[PATRULHA] sem permissao")
        return
    end

    local ped = GetPlayerPed(source)
    if not ped or ped == 0 then
        print("[PATRULHA] ped invalido")
        return
    end

    local coords = GetEntityCoords(ped)
    local distance = #(coords - groupData.serviceCoords)

    print("[PATRULHA] distancia ate area:", distance)

    if distance > groupData.serviceRadius then
        Notify(source, "amarelo", Config.NotifyFar)
        print("[PATRULHA] fora da area")
        return
    end

    if PatrolUsers[passport] then
        local currentGroup = PatrolUsers[passport].group
        local currentName = PatrolUsers[passport].name
        local currentCoords = {
            x = PatrolUsers[passport].x or coords.x,
            y = PatrolUsers[passport].y or coords.y,
            z = PatrolUsers[passport].z or coords.z
        }

        PatrolUsers[passport] = nil
        TriggerClientEvent("patrulha_blips:SetPatrolState", source, false, nil, nil)
        TriggerClientEvent("patrulha_blips:ClearAllBlips", source)
        Notify(source, "verde", Config.NotifyLeave)

        print("[PATRULHA] saiu da patrulha:", passport)

        LogPatrolAction(currentGroup, passport, currentName, "SAIU", currentCoords)

        if currentGroup then
            SendGroupUpdate(currentGroup)
        end

        return
    end

    local fullName = GetIdentityName(passport)

    PatrolUsers[passport] = {
        group = groupName,
        name = fullName,
        x = coords.x + 0.0,
        y = coords.y + 0.0,
        z = coords.z + 0.0
    }

    TriggerClientEvent("patrulha_blips:SetPatrolState", source, true, groupName, passport)
    Notify(source, "verde", Config.NotifyEnter)

    print("[PATRULHA] entrou na patrulha:", passport, " grupo:", groupName)

    LogPatrolAction(groupName, passport, fullName, "ENTROU", {
        x = coords.x + 0.0,
        y = coords.y + 0.0,
        z = coords.z + 0.0
    })

    SendGroupUpdate(groupName)
end)

RegisterNetEvent("patrulha_blips:UpdatePosition")
AddEventHandler("patrulha_blips:UpdatePosition", function(x, y, z)
    local source = source
    local passport = vRP.Passport(source)
    if not passport or not PatrolUsers[passport] then
        return
    end

    PatrolUsers[passport].x = x + 0.0
    PatrolUsers[passport].y = y + 0.0
    PatrolUsers[passport].z = z + 0.0

    local groupName = PatrolUsers[passport].group
    if groupName then
        SendGroupUpdate(groupName)
    end
end)

AddEventHandler("playerDropped", function()
    local source = source
    local passport = vRP.Passport(source)
    if passport then
        RemoveFromPatrol(passport)
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    for passport, _ in pairs(PatrolUsers) do
        local source = vRP.Source(passport)
        if source then
            TriggerClientEvent("patrulha_blips:SetPatrolState", source, false, nil, nil)
            TriggerClientEvent("patrulha_blips:ClearAllBlips", source)
        end
    end
end)
