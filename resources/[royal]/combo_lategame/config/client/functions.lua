local function comboTryLoadModule(resourceName, filePath)
    if type(module) == "function" then
        local ok, result = pcall(module, resourceName, filePath)
        if ok and result ~= nil then
            return result
        end
    end

    local code = LoadResourceFile(resourceName, filePath .. ".lua") or LoadResourceFile(resourceName, filePath)
    if not code then
        return nil
    end

    local fn, err = load(code, ("@@%s/%s"):format(resourceName, filePath))
    if not fn then
        return nil, err
    end

    local ok, result = pcall(fn)
    if not ok then
        return nil, result
    end

    return result
end

if type(import) ~= "function" then
    import = function(filePath)
        local mod = comboTryLoadModule("vrp", filePath)
        if mod ~= nil then return mod end
        mod = comboTryLoadModule("vRP", filePath)
        if mod ~= nil then return mod end
        return nil
    end
end

local function comboLoadVrpLib(filePath)
    if type(module) == "function" then
        local ok, lib = pcall(module, "vrp", filePath)
        if ok and lib ~= nil then
            return lib
        end
    end

    if type(import) == "function" then
        local lib = import(filePath)
        if lib ~= nil then
            return lib
        end
    end

    local lib = comboTryLoadModule("vrp", filePath)
    if lib ~= nil then
        return lib
    end

    lib = comboTryLoadModule("vRP", filePath)
    if lib ~= nil then
        return lib
    end

    return nil
end

local Proxy = comboLoadVrpLib('lib/Proxy')
local Tunnel = comboLoadVrpLib('lib/Tunnel')
local vRP = nil
if Proxy and Proxy.getInterface then
    vRP = Proxy.getInterface('vRP')
end

local apiConfig = {}
if Tunnel and Tunnel.bindInterface then
    Tunnel.bindInterface('combo_lategame:config', apiConfig)
end

local apiConfigServer = {}
if Tunnel and Tunnel.getInterface then
    apiConfigServer = Tunnel.getInterface('combo_lategame:config')
end

local CONTROL_TO_DISABLE = {
    [80] = true
}

local MARKERS = { 
    vec3( 169.2,-939.0,30.68),
    vec3(-1566.77, -999.36, 13.01),
    vec3(-1553.1, -1010.59, 13.01),
    vec3(-1571.34, -1046.63, 13.06),
    vec3(-1572.48, -1048.33, 13.06),
    vec3(-1573.95, -1050.03, 13.06),
}

local WEAPON_LIST = { 'WEAPON_KNIFE', 'WEAPON_KNUCKLE', 'WEAPON_NIGHTSTICK', 'WEAPON_HAMMER', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_CROWBAR', 'WEAPON_BOTTLE',
    'WEAPON_DAGGER', 'WEAPON_HATCHET', 'WEAPON_MACHETE', 'WEAPON_FLASHLIGHT', 'WEAPON_SWITCHBLADE', 'WEAPON_PROXMINE', 'WEAPON_BZGAS', 'WEAPON_SMOKEGRENADE',
    'WEAPON_MOLOTOV', 'WEAPON_FIREEXTINGUISHER', 'WEAPON_PETROLCAN', 'WEAPON_HAZARDCAN', 'WEAPON_SNOWBALL', 'WEAPON_FLARE', 'WEAPON_BALL', 'WEAPON_REVOLVER',
    'WEAPON_POOLCUE', 'WEAPON_PIPEWRENCH', 'weapon_pistol', 'WEAPON_PISTOL_MK2', 'WEAPON_COMBATPISTOL', 'WEAPON_APPISTOL', 'WEAPON_PISTOL50', 'WEAPON_SNSPISTOL',
    'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_STUNGUN', 'WEAPON_FLAREGUN', 'WEAPON_MARKSMANPISTOL', 'WEAPON_MICROSMG', 'WEAPON_MINISMG', 'WEAPON_SMG',
    'WEAPON_SMG_MK2', 'WEAPON_ASSAULTSMG', 'WEAPON_MG', 'WEAPON_COMBATMG', 'WEAPON_COMBATMG_MK2', 'WEAPON_COMBATPDW', 'WEAPON_GUSENBERG', 'WEAPON_MACHINEPISTOL',
    'WEAPON_ASSAULTRIFLE', 'WEAPON_ASSAULTRIFLE_MK2', 'WEAPON_CARBINERIFLE', 'WEAPON_CARBINERIFLE_MK2', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_SPECIALCARBINE',
    'WEAPON_BULLPUPRIFLE', 'WEAPON_COMPACTRIFLE', 'WEAPON_PUMPSHOTGUN', 'WEAPON_SWEEPERSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN', 'WEAPON_BULLPUPSHOTGUN',
    'WEAPON_ASSAULTSHOTGUN', 'WEAPON_MUSKET', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_HEAVYSNIPER_MK2',
    'WEAPON_MARKSMANRIFLE', 'WEAPON_GRENADELAUNCHER', 'WEAPON_GRENADELAUNCHER_SMOKE', 'WEAPON_RPG', 'WEAPON_MINIGUN', 'WEAPON_FIREWORK', 'WEAPON_RAILGUN',
    'WEAPON_HOMINGLAUNCHER', 'WEAPON_GRENADE', 'WEAPON_STICKYBOMB', 'WEAPON_COMPACTLAUNCHER', 'WEAPON_SNSPISTOL_MK2', 'WEAPON_REVOLVER_MK2',
    'WEAPON_DOUBLEACTION', 'WEAPON_SPECIALCARBINE_MK2', 'WEAPON_BULLPUPRIFLE_MK2', 'WEAPON_PUMPSHOTGUN_MK2', 'WEAPON_MARKSMANRIFLE_MK2', 'WEAPON_RAYPISTOL',
    'WEAPON_RAYCARBINE', 'WEAPON_RAYMINIGUN', 'WEAPON_DIGISCANNER', 'WEAPON_NAVYREVOLVER', 'WEAPON_CERAMICPISTOL', 'WEAPON_STONE_HATCHET', 'WEAPON_PIPEBOMB',
    'GADGET_PARACHUTE', 'WEAPON_GADGETPISTOL', 'WEAPON_MILITARYRIFLE', 'WEAPON_COMBATSHOTGUN', 'WEAPON_AUTOSHOTGUN' }

clientConfig = {
    respawnPed = function(ped)
        local pedCoords = GetEntityCoords(ped) 

        NetworkResurrectLocalPlayer(pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)

        ClearPedBloodDamage(ped)
        ClearPedTasks(ped)
        ClearPedSecondaryTask(ped)
        ClearPedTasksImmediately(ped)
        NetworkSetVoiceActive(true) -- Reativa o sistema de voz
        NetworkSetTalkerProximity(15.0) -- Ajusta a proximidade de voz para o padrão (15.0 é um valor comum)
        TriggerEvent('resetBleeding')
        TriggerEvent('resetDiagnostic')
        -- LocalPlayer['state']['Death'] = false

        TriggerEvent("vRP:playerDead",false)
        LocalPlayer['state']['BlockControls'] = false

        clientConfig.setEntityInvincible(ped, false)
        clientConfig.setPedMaxHealth(ped)
    end,
    
    getPedWeapons = function(ped)
        local loaddedAmmos = {}
        local playerWeapons = {}
    
        for _, weaponName in ipairs(WEAPON_LIST) do
            local weaponHash = GetHashKey(weaponName)
    
            if HasPedGotWeapon(ped, weaponHash) then
                local weaponAmmos = {}
    
                playerWeapons[weaponName] = weaponAmmos
    
                local ammoType = GetPedAmmoTypeFromWeapon(ped, weaponHash)
    
                if loaddedAmmos[ammoType] == nil then
                    loaddedAmmos[ammoType] = true
    
                    weaponAmmos.ammo = GetAmmoInPedWeapon(ped, weaponHash)
                else
                    weaponAmmos.ammo = 0
                end
            end
        end
    
        return playerWeapons    
    end, 

    setWeaponToPed = function(ped, weaponsTable, isInfinityAmmo)
        clientConfig.removeAllPedWeapons(ped)
        local source = tonumber(GetPlayerServerId(PlayerId()))
        if isInfinityAmmo then 
            for _, weaponName in pairs(weaponsTable) do 
                
                local weapons = { [weaponName] = { ammo = 250 } }
                apiConfigServer.setWeaponsPed(source,weapons)
           --     vRP.giveWeapons(weapons)

                SetPedInfiniteAmmo(ped, true, weaponName)
            end 
        else 
            for _, weaponName in pairs(weaponsTable) do 
                SetPedInfiniteAmmo(ped, false, weaponName)
            end 
        end
    end,

    setPedWithoutCollision = function(ped)
        for _, players in ipairs(GetActivePlayers()) do
            local otherPed = GetPlayerPed(players)
            
            if playerPed ~= otherPed then
                SetEntityNoCollisionEntity(ped, otherPed, true)
            end
        end
    end,

    removeAllPedWeapons = function(ped)
        RemoveAllPedWeapons(ped, true)
    end,

    setEntityCoords = function(...)
        local args = {...}

        local ped = table.remove(args, 1)

        SetEntityCoords(ped, table.unpack(args))
    end,

    setEntityHealth = function(ped, health)
        SetEntityHealth(ped, health)
    end,

    setPedDead = function(ped)
        clientConfig.setEntityHealth(ped, 101)
    end,
    
    isPedDead = function(ped)
        return GetEntityHealth(ped) <= 101
    end,

    setPedMaxHealth = function(ped)
        local healthToSet = GetPedMaxHealth(ped)

        clientConfig.setEntityHealth(ped, healthToSet)
        TriggerEvent('revivePlayerEvent', 300)
    end,

    setPlayerInSpectatorMode = function(toggle, playerToSpectate)
        if toggle then
            NetworkSetInSpectatorMode(true, playerToSpectate)
        else
            if NetworkIsInSpectatorMode() then
                NetworkSetInSpectatorMode(false)
            end
        end
    end,

    freezeEntityPosition = function(entity, toggleStatus)
        if toggleStatus then
            FreezeEntityPosition(entity, true)
        else
            FreezeEntityPosition(entity, false)
        end
    end,

    setEntityInvincible = function(entity, toggleStatus)
        local player = PlayerId()
        
        if toggleStatus then
            if not clientConfig.isPlayerInvincible(player) then  
                SetEntityInvincible(entity, false)
            end
        else
            if clientConfig.isPlayerInvincible(player) then  
                SetEntityInvincible(entity, false)
            end
        end
    end,

    isPlayerInvincible = function(playerId)
        return GetPlayerInvincible(playerId)
    end, 

    setEntityVisible = function(entity, toggle)
        if toggle then
            SetEntityVisible(entity, true)
        else
            SetEntityVisible(entity, false)
        end
    end,

    isEntityVisible = function(ped)
        return IsEntityVisible(ped)
    end,

    setCurrentPedWeapon = function(ped, weaponHash, forceInHand)
        SetCurrentPedWeapon(ped, GetHashKey(weaponHash), forceInHand)  
    end,

    returnPedWeapons = function(ped, weaponsTable)
   --     vRP.giveWeapons(weaponsTable, true)
    end,

    openHandler = function(handler)
        Citizen.CreateThread(function()
            while true do 
                local sleepTime = 1000 
    
                local playerPed = PlayerPedId()
                local pedCoordinated = GetEntityCoords(playerPed)
    
                for _, markerCoordinates in ipairs(MARKERS) do
                    local distanceToMarker = #(pedCoordinated - markerCoordinates)
    
                    if distanceToMarker < 7 then 
                        sleepTime = 0 
                        
                        DrawMarker(27, markerCoordinates.x, markerCoordinates.y, markerCoordinates.z - 1.0, 0, 0, 0, 0, 0.0, 0.0, 1.0, 1.0, 0.0, 255,255,255,255, 0, 0, 0, 1)
    
                        if IsControlJustPressed(0, 38) and distanceToMarker < 2 then 
                            local playerPed = PlayerPedId() -- Obtém o Ped do jogador local
                            local weaponHash = GetSelectedPedWeapon(playerPed) -- Obtém a arma atualmente equipada
                        
                            if weaponHash == GetHashKey('WEAPON_UNARMED') then
                                -- Jogador não tem nenhuma arma equipada
                                handler()
                            end
                            Citizen.Wait(1000)
                        end 
                    end 
                end 
    
                Citizen.Wait(sleepTime)
            end 
        end)

        RegisterCommand('duelo', function()
            -- handler()
            local playerPed = PlayerPedId()
            local pedCoordinated = GetEntityCoords(playerPed)

            for _, markerCoordinates in ipairs(MARKERS) do
                local distanceToMarker = #(pedCoordinated - markerCoordinates)

                if distanceToMarker < 100 then 
                    return handler()
                end 
            end
        end)
    end,

    openHandlerSpectator = function(handler)
        RegisterCommand('leaveLategameSpectator', handler)
    end,

    drawNotification = function(timer)
        SetNotificationTextEntry('STRING')
        AddTextComponentString('Aperte [HOME] para abrir o placar.')
        DrawNotification(true, false)
    end,

    disableControls = function()
        for keys, disable in pairs(CONTROL_TO_DISABLE) do
            DisableControlAction(1, keys, disable)
        end
    end
}

Citizen.CreateThread(function()
    RegisterKeyMapping('activeStatistic', 'Abrir Score Board', 'keyboard', 'HOME')
    RegisterKeyMapping('leaveLategameSpectator', 'Sair do espectador', 'keyboard', 'F7')
end)

function apiConfig.setPlayerHealth(health)
    local ped = PlayerPedId()

    clientConfig.setEntityHealth(ped, health)
end

return clientConfig
