local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local DeathCooldown = {}

local function Hash(weapon)
    return GetHashKey(weapon)
end

local WeaponNames = {
    [Hash("WEAPON_UNARMED")] = "Desarmado",
    [Hash("WEAPON_KNIFE")] = "Faca",
    [Hash("WEAPON_NIGHTSTICK")] = "Cassetete",
    [Hash("WEAPON_HAMMER")] = "Martelo",
    [Hash("WEAPON_BAT")] = "Taco",
    [Hash("WEAPON_GOLFCLUB")] = "Taco de Golf",
    [Hash("WEAPON_CROWBAR")] = "Pé de cabra",
    [Hash("WEAPON_PISTOL")] = "Pistola",
    [Hash("WEAPON_COMBATPISTOL")] = "Combat Pistol",
    [Hash("WEAPON_APPISTOL")] = "AP Pistol",
    [Hash("WEAPON_PISTOL50")] = "Pistol .50",
    [Hash("WEAPON_MICROSMG")] = "Micro SMG",
    [Hash("WEAPON_SMG")] = "SMG",
    [Hash("WEAPON_ASSAULTSMG")] = "Assault SMG",
    [Hash("WEAPON_ASSAULTRIFLE")] = "Assault Rifle",
    [Hash("WEAPON_CARBINERIFLE")] = "Carbine Rifle",
    [Hash("WEAPON_ADVANCEDRIFLE")] = "Advanced Rifle",
    [Hash("WEAPON_MG")] = "MG",
    [Hash("WEAPON_COMBATMG")] = "Combat MG",
    [Hash("WEAPON_PUMPSHOTGUN")] = "Pump Shotgun",
    [Hash("WEAPON_SAWNOFFSHOTGUN")] = "Sawed-Off Shotgun",
    [Hash("WEAPON_ASSAULTSHOTGUN")] = "Assault Shotgun",
    [Hash("WEAPON_BULLPUPSHOTGUN")] = "Bullpup Shotgun",
    [Hash("WEAPON_STUNGUN")] = "Taser",
    [Hash("WEAPON_SNIPERRIFLE")] = "Sniper Rifle",
    [Hash("WEAPON_HEAVYSNIPER")] = "Heavy Sniper",
    [Hash("WEAPON_GRENADELAUNCHER")] = "Grenade Launcher",
    [Hash("WEAPON_RPG")] = "RPG",
    [Hash("WEAPON_MINIGUN")] = "Minigun",
    [Hash("WEAPON_GRENADE")] = "Granada",
    [Hash("WEAPON_STICKYBOMB")] = "Bomba Adesiva",
    [Hash("WEAPON_SMOKEGRENADE")] = "Granada de Fumaça",
    [Hash("WEAPON_MOLOTOV")] = "Molotov",
    [Hash("WEAPON_FIREEXTINGUISHER")] = "Extintor",
    [Hash("WEAPON_PETROLCAN")] = "Galão de Combustível",
    [Hash("WEAPON_FLARE")] = "Sinalizador",
    [Hash("WEAPON_DROWNING")] = "Afogamento",
    [Hash("WEAPON_DROWNING_IN_VEHICLE")] = "Afogamento em Veículo",
    [Hash("WEAPON_BLEEDING")] = "Sangramento",
    [Hash("WEAPON_EXPLOSION")] = "Explosão",
    [Hash("WEAPON_FALL")] = "Queda",
    [Hash("WEAPON_RAMMED_BY_CAR")] = "Atropelamento",
    [Hash("WEAPON_RUN_OVER_BY_CAR")] = "Atropelamento",
    [Hash("WEAPON_HELI_CRASH")] = "Queda de Helicóptero",
    [Hash("WEAPON_FIRE")] = "Fogo"
}

local function IdentityName(passport)
    if not passport then
        return "Desconhecido"
    end

    local identity = vRP.Identity(passport)
    if identity then
        return (identity.name or "Desconhecido").." "..(identity.name2 or "")
    end

    return "Desconhecido"
end

local function FormatCoords(coords)
    if not coords then
        return "0.0, 0.0, 0.0"
    end

    return string.format("%.2f, %.2f, %.2f", coords.x or 0.0, coords.y or 0.0, coords.z or 0.0)
end

local function WeaponName(hashValue)
    if not hashValue then
        return "Desconhecida"
    end

    return WeaponNames[hashValue] or ("Hash: "..tostring(hashValue))
end

local function SendWebhook(message)
    if Config.Webhook and Config.Webhook ~= "" then
        PerformHttpRequest(Config.Webhook,function(err,text,headers) end,"POST",json.encode({
            username = "Death Logs",
            embeds = {{
                color = 16711680,
                description = message,
                footer = {
                    text = os.date("%d/%m/%Y %H:%M:%S")
                }
            }}
        }),{ ["Content-Type"] = "application/json" })
    end
end

RegisterServerEvent("deathlogs:send")
AddEventHandler("deathlogs:send",function(data)
    local source = source
    local passport = vRP.Passport(source)
    if not passport then
        return
    end

    local now = os.time()
    if DeathCooldown[passport] and DeathCooldown[passport] > now then
        return
    end

    DeathCooldown[passport] = now + (Config.Cooldown or 5)

    local killerServerId = tonumber(data and data.killerServerId or 0) or 0
    local killerType = data and data.killerType or "desconhecido"
    local weaponHash = data and data.weaponHash or 0
    local victimCoords = data and data.victimCoords or nil
    local killerCoords = data and data.killerCoords or nil

    local killerPassport = nil
    local killerName = "Desconhecido"

    if killerServerId > 0 then
        killerPassport = vRP.Passport(killerServerId)
        if killerPassport then
            killerName = IdentityName(killerPassport)
        else
            killerName = "Player sem Passport"
        end
    else
        if killerType == "vehicle" then
            killerName = "Veículo"
        elseif killerType == "ped" then
            killerName = "NPC"
        elseif killerType == "player_vehicle" then
            killerName = "Player em veículo"
        else
            killerName = "Sem agressor identificado"
        end
    end

    local victimName = IdentityName(passport)

    local message = ""
    message = message.."```prolog\n"
    message = message.."[VITIMA]: "..victimName.."\n"
    message = message.."[PASSAPORTE VITIMA]: "..passport.."\n"
    message = message.."[CDS VITIMA]: "..FormatCoords(victimCoords).."\n"
    message = message.."[ARMA/CAUSA]: "..WeaponName(weaponHash).."\n"
    message = message.."\n"
    message = message.."[MATADOR]: "..killerName.."\n"
    message = message.."[PASSAPORTE MATADOR]: "..(killerPassport or "N/A").."\n"
    message = message.."[TIPO]: "..killerType.."\n"
    message = message.."[CDS MATADOR]: "..FormatCoords(killerCoords).."\n"
    message = message.."```"

    print("[deathlogs] morte enviada:", passport, killerPassport or "N/A", killerType)
    SendWebhook(message)
end)

AddEventHandler("playerDropped",function()
    local source = source
    local passport = vRP.Passport(source)
    if passport then
        DeathCooldown[passport] = nil
    end
end)