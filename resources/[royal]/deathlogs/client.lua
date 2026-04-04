local DeathSent = false
local LastDamage = {
    killerServerId = 0,
    killerType = "desconhecido",
    weaponHash = 0,
    victimCoords = nil,
    killerCoords = nil
}

AddEventHandler("gameEventTriggered",function(eventName,args)
    if eventName ~= "CEventNetworkEntityDamage" then
        return
    end

    local ped = PlayerPedId()
    if args[1] ~= ped then
        return
    end

    local attacker = args[2]
    local victimCoords = GetEntityCoords(ped)

    LastDamage.victimCoords = {
        x = victimCoords.x,
        y = victimCoords.y,
        z = victimCoords.z
    }

    LastDamage.weaponHash = GetPedCauseOfDeath(ped) or 0
    LastDamage.killerServerId = 0
    LastDamage.killerType = "desconhecido"
    LastDamage.killerCoords = { x = 0.0, y = 0.0, z = 0.0 }

    if attacker and attacker ~= 0 then
        if IsEntityAPed(attacker) then
            local coords = GetEntityCoords(attacker)
            LastDamage.killerCoords = {
                x = coords.x,
                y = coords.y,
                z = coords.z
            }

            if IsPedAPlayer(attacker) then
                local killerPlayer = NetworkGetPlayerIndexFromPed(attacker)
                if killerPlayer and killerPlayer ~= -1 then
                    LastDamage.killerServerId = GetPlayerServerId(killerPlayer)
                    LastDamage.killerType = "player"
                else
                    LastDamage.killerType = "ped"
                end
            else
                LastDamage.killerType = "ped"
            end
        elseif IsEntityAVehicle(attacker) then
            local coords = GetEntityCoords(attacker)
            LastDamage.killerCoords = {
                x = coords.x,
                y = coords.y,
                z = coords.z
            }

            LastDamage.killerType = "vehicle"

            local driver = GetPedInVehicleSeat(attacker,-1)
            if driver and driver ~= 0 and IsPedAPlayer(driver) then
                local killerPlayer = NetworkGetPlayerIndexFromPed(driver)
                if killerPlayer and killerPlayer ~= -1 then
                    LastDamage.killerServerId = GetPlayerServerId(killerPlayer)
                    LastDamage.killerType = "player_vehicle"

                    local driverCoords = GetEntityCoords(driver)
                    LastDamage.killerCoords = {
                        x = driverCoords.x,
                        y = driverCoords.y,
                        z = driverCoords.z
                    }
                end
            end
        end
    end
end)

AddEventHandler("player:DeathUpdate",function(status)
    if status then
        if DeathSent then
            return
        end

        DeathSent = true

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if not LastDamage.victimCoords then
            LastDamage.victimCoords = {
                x = coords.x,
                y = coords.y,
                z = coords.z
            }
        end

        if not LastDamage.weaponHash or LastDamage.weaponHash == 0 then
            LastDamage.weaponHash = GetPedCauseOfDeath(ped) or 0
        end

        TriggerServerEvent("deathlogs:send",LastDamage)
    else
        DeathSent = false
        LastDamage = {
            killerServerId = 0,
            killerType = "desconhecido",
            weaponHash = 0,
            victimCoords = nil,
            killerCoords = nil
        }
    end
end)