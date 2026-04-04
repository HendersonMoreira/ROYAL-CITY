local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

local Desmanche = {}
Tunnel.bindInterface("desmanche", Desmanche)

local WEBHOOK_DESMANCHE = "https://discord.com/api/webhooks/1487834682006442144/Y5KQJCYsA6AW2BHAt4TjC-kHV3rrTVbIX7kVJl2pigWKFX90qz_uT8eIh0exbaE1Mx6l"

local function notify(source, color, message, timer)
    TriggerClientEvent("Notify", source, color, message, timer or 5000)
end

local function sendWebhookMessage(webhook, message)
    if not webhook or webhook == "" or webhook == "COLOQUE_SEU_WEBHOOK_AQUI" then
        return
    end

    PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({
        username = "Desmanche",
        embeds = {{
            color = 16711680,
            description = message,
            footer = {
                text = os.date("%d/%m/%Y %H:%M:%S")
            }
        }}
    }), { ["Content-Type"] = "application/json" })
end

local function getPassport(source)
    if vRP.Passport then
        local passport = vRP.Passport(source)
        if passport then return passport end
    end

    if vRP.getUserId then
        local user_id = vRP.getUserId(source)
        if user_id then return user_id end
    end

    return nil
end

local function hasPermission(source, passport, permission)
    if not permission or permission == "" then
        return true
    end

    local checks = {
        function() return vRP.HasGroup and vRP.HasGroup(passport, permission) end,
        function() return vRP.HasPermission and vRP.HasPermission(passport, permission) end,
        function() return vRP.hasPermission and vRP.hasPermission(passport, permission) end,
        function() return vRP.hasPermission and vRP.hasPermission(source, permission) end
    }

    for _, fn in ipairs(checks) do
        local ok, result = pcall(fn)
        if ok and result then
            return true
        end
    end

    return false
end

local function normalizePlate(plate)
    plate = tostring(plate or "")
    plate = plate:gsub("^%s*(.-)%s*$", "%1")
    return plate
end

local function normalizeModel(model)
    return string.lower(tostring(model or ""))
end

local function getPayment(model)
    model = normalizeModel(model)
    local value = Config.Vehicles[model]
    if not value then return nil end
    return math.floor(value * (Config.PaymentPercent or 1.0))
end

local function giveItem(passport, item, amount)
    if amount <= 0 then return false end

    local ok = false

    if vRP.GenerateItem then
        local status = pcall(function()
            vRP.GenerateItem(passport, item, amount, true)
        end)
        if status then ok = true end
    end

    if not ok and vRP.giveInventoryItem then
        local status = pcall(function()
            vRP.giveInventoryItem(passport, item, amount, true)
        end)
        if status then ok = true end
    end

    return ok
end

local function fetchVehicleByPlate(plate)
    return exports.oxmysql:singleSync("SELECT id, Passport, vehicle, plate, arrest FROM vehicles WHERE plate = ? LIMIT 1", { plate })
end

local function setVehicleDismantled(plate, vehicle)
    exports.oxmysql:updateSync("UPDATE vehicles SET arrest = 1 WHERE plate = ? AND vehicle = ?", { plate, vehicle })
end

local function getIdentity(passport)
    if not passport then
        return nil
    end

    local checks = {
        function() return vRP.Identity and vRP.Identity(passport) end,
        function() return vRP.getUserIdentity and vRP.getUserIdentity(passport) end,
        function() return vRP.UserIdentity and vRP.UserIdentity(passport) end
    }

    for _, fn in ipairs(checks) do
        local ok, result = pcall(fn)
        if ok and result then
            return result
        end
    end

    return nil
end

local function getIdentityName(passport)
    local identity = getIdentity(passport)
    if not identity then
        return "Desconhecido"
    end

    local name = identity.name or identity.Name or identity.firstname or identity.firstName or identity.nome
    local name2 = identity.name2 or identity.Name2 or identity.lastname or identity.lastName or identity.sobrenome

    if name and name2 then
        return tostring(name) .. " " .. tostring(name2)
    elseif name then
        return tostring(name)
    end

    return "Desconhecido"
end

local function getPlayerCoords(source)
    local ped = GetPlayerPed(source)
    if not ped or ped <= 0 then
        return "0.0, 0.0, 0.0"
    end

    local coords = GetEntityCoords(ped)
    if not coords then
        return "0.0, 0.0, 0.0"
    end

    return string.format("%.2f, %.2f, %.2f", coords.x, coords.y, coords.z)
end

local function sendDismantleLog(source, passport, vehicleData, payment)
    local coords = getPlayerCoords(source)
    local dismantlerName = getIdentityName(passport)
    local ownerPassport = vehicleData and vehicleData.Passport or "Desconhecido"
    local ownerName = getIdentityName(ownerPassport)

    local message = table.concat({
        "**DESMANCHE FINALIZADO**",
        "",
        "**Desmanchado por:** " .. dismantlerName .. " [" .. tostring(passport) .. "]",
        "**Proprietário:** " .. ownerName .. " [" .. tostring(ownerPassport) .. "]",
        "**Veículo:** " .. tostring(vehicleData.vehicle),
        "**Placa:** " .. tostring(vehicleData.plate),
        "**CDS:** " .. coords,
        "**Pagamento:** " .. tostring(payment) .. " " .. tostring(Config.PaymentItem)
    }, "\n")

    sendWebhookMessage(WEBHOOK_DESMANCHE, message)
end

function Desmanche.iniciar(plate, model)
    local source = source
    local passport = getPassport(source)
    if not passport then
        return false
    end

    if not hasPermission(source, passport, Config.Permission) then
        notify(source, "vermelho", Config.NotifyNoPermission, 5000)
        return false
    end

    model = normalizeModel(model)
    plate = normalizePlate(plate)

    local payment = getPayment(model)
    if not payment then
        notify(source, "vermelho", Config.NotifyNotAllowed, 5000)
        return false
    end

    local vehicle = fetchVehicleByPlate(plate)
    if not vehicle then
        notify(source, "vermelho", Config.NotifyNoRegister, 5000)
        return false
    end

    if normalizeModel(vehicle.vehicle) ~= model then
        notify(source, "vermelho", "<b>O modelo do veículo não confere</b> com o registro da placa.", 5000)
        return false
    end

    if tonumber(vehicle.arrest) == 1 then
        notify(source, "vermelho", Config.NotifyAlreadyDismantled, 5000)
        return false
    end

    return true
end

function Desmanche.finalizar(plate, model)
    local source = source
    local passport = getPassport(source)
    if not passport then
        return false
    end

    model = normalizeModel(model)
    plate = normalizePlate(plate)

    local payment = getPayment(model)
    if not payment then
        notify(source, "vermelho", Config.NotifyNotAllowed, 5000)
        return false
    end

    local vehicle = fetchVehicleByPlate(plate)
    if not vehicle then
        notify(source, "vermelho", Config.NotifyNoRegister, 5000)
        return false
    end

    if tonumber(vehicle.arrest) == 1 then
        notify(source, "vermelho", Config.NotifyAlreadyDismantled, 5000)
        return false
    end

    setVehicleDismantled(plate, model)

    if not giveItem(passport, Config.PaymentItem, payment) then
        notify(source, "vermelho", "Erro ao gerar pagamento no inventário.", 5000)
        return false
    end

    sendDismantleLog(source, passport, vehicle, payment)

    return true, payment
end
