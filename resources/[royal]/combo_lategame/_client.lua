-- Script principal do cliente
-- Sistema de Late Game PvP

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

print(("[combo_lategame] client import=%s module=%s"):format(type(import), type(module)))

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

local function comboRequireLocal(filePath)
    local resourceName = GetCurrentResourceName()
    local key = ("@@%s/%s"):format(resourceName, filePath)

    if package and package.loaded and package.loaded[key] ~= nil then
        return package.loaded[key]
    end

    local code = LoadResourceFile(resourceName, filePath)
        or LoadResourceFile(resourceName, filePath .. ".lua")
        or LoadResourceFile(resourceName, filePath:gsub("%.", "/") .. ".lua")

    if not code then
        error(("module '%s' not found (resource=%s)"):format(filePath, resourceName))
    end

    local fn, err = load(code, key)
    if not fn then
        error(err)
    end

    local ok, result = pcall(fn)
    if not ok then
        error(result)
    end

    if package and package.loaded then
        package.loaded[key] = result
    end

    return result
end

local Proxy = comboLoadVrpLib('lib/Proxy')
local Tunnel = comboLoadVrpLib('lib/Tunnel')
if Proxy == nil or Tunnel == nil then
    print(("[combo_lategame] client Proxy=%s Tunnel=%s (falha ao carregar vRP lib)"):format(tostring(Proxy), tostring(Tunnel)))
end

local vRP = nil
if Proxy and Proxy.getInterface then
    vRP = Proxy.getInterface('vRP')
end

local config = comboRequireLocal('config/config.lua')
local clientConfig = comboRequireLocal('config/client/functions.lua')

-- Interface de comunicação
local apiClient = {}
Tunnel.bindInterface('combo_lategame', apiClient)
local apiServer = Tunnel.getInterface('combo_lategame')

-- Variáveis locais
local isInMatch = false
local currentRoom = nil
local isSpectating = false
local spectatingPlayer = nil

-- Inicialização
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if isInMatch then
            clientConfig.disableControls()
        else
            Citizen.Wait(1000)
        end
    end
end)

-- Abre o painel do lategame
RegisterCommand('lategame', function()
    print("[combo_lategame] /lategame chamado")
    if isInMatch then
        pcall(function()
            config.notify(1, config.Language.CannotOpenPanel, 5000)
        end)
        return
    end
    
    local ok1, err1 = pcall(function()
        SendNUIMessage({
            action = 'painel'
        })
    end)

    local ok2, err2 = pcall(function()
        SetNuiFocus(true, true)
    end)

    if not ok1 then
        print(("[combo_lategame] SendNUIMessage erro: %s"):format(tostring(err1)))
    end
    if not ok2 then
        print(("[combo_lategame] SetNuiFocus erro: %s"):format(tostring(err2)))
    end
end)

RegisterNUICallback('closeUi', function(data, cb)
    SetNuiFocus(false, false)
    cb({ status = true })
end)

RegisterNUICallback('painelCategories', function(data, cb)
    cb({
        data = {
            { id = "teams", label = config.Language.Teams, placeHolder = true },
            { id = "monitor", label = config.Language.Monitor },
            { id = "spectate", label = config.Language.Spectate },
            { id = "challenges", label = config.Language.Challenges }
        }
    })
end)

RegisterNUICallback('limitMembers', function(data, cb)
    cb({ limit = config.MaximumRoomMembers or 15 })
end)

RegisterNUICallback('availableTeamsToJoin', function(data, cb)
    local rooms = apiServer.getRooms()
    cb({ data = (rooms or {}) })
end)

RegisterNUICallback('tryCreateTeam', function(data, cb)
    cb({ hasVip = true, defaultName = "" })
end)

RegisterNUICallback('createTeam', function(data, cb)
    local success = false
    local name = data and data.name
    if name and name ~= "" then
        success = apiServer.createRoom(name)
    end
    cb({ status = success and true or false })
end)

RegisterNUICallback('joinTeam', function(data, cb)
    local teamId = data and tonumber(data.team)
    if not teamId then
        cb({ status = false })
        return
    end

    local success = apiServer.joinRoom(teamId)
    cb({ status = success and true or false })
end)

RegisterNUICallback('currentTeam', function(data, cb)
    local room = apiServer.getCurrentRoom()
    cb({ data = room })
end)

RegisterNUICallback('availableTeamsToChallenge', function(data, cb)
    local myRoomId = apiServer.getPlayerRoomId()
    local rooms = apiServer.getRooms() or {}
    local result = {}
    for _, room in ipairs(rooms) do
        if myRoomId == nil or room.id ~= myRoomId then
            result[#result + 1] = room
        end
    end
    cb({ data = result })
end)

RegisterNUICallback('challengeTeam', function(data, cb)
    local teamId = data and tonumber(data.team)
    if not teamId then
        cb({ status = false })
        return
    end

    local success = apiServer.sendChallenge(teamId)
    cb({ status = success and true or false })
end)

RegisterNUICallback('deleteTeam', function(data, cb)
    local teamId = data and tonumber(data.team)
    if not teamId then
        cb({ status = false })
        return
    end

    local success = apiServer.deleteRoom(teamId)
    cb({ status = success and true or false })
end)

RegisterNUICallback('leftTeam', function(data, cb)
    local teamId = data and tonumber(data.team)
    if not teamId then
        cb({ status = false })
        return
    end

    local success = apiServer.leaveRoom(teamId)
    cb({ status = success and true or false })
end)

RegisterNUICallback('kickMember', function(data, cb)
    local id = data and tonumber(data.id)
    if not id then
        cb({ status = false })
        return
    end

    local success = apiServer.kickFromMyRoom(id)
    cb({ status = success and true or false })
end)

RegisterNUICallback('availableGamesToMonitor', function(data, cb)
    cb({ data = {} })
end)

RegisterNUICallback('monitorGame', function(data, cb)
    cb({ status = false })
end)

RegisterNUICallback('availableGamesToSpectate', function(data, cb)
    cb({ data = {} })
end)

RegisterNUICallback('spectateGame', function(data, cb)
    cb({ status = false })
end)

-- Fecha o painel NUI
RegisterNUICallback('closePanel', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Cria uma sala
RegisterNUICallback('createRoom', function(data, cb)
    local roomName = data.roomName
    
    if not roomName or roomName == "" then
        config.notify(1, config.Language.CannotUseThisName, 5000)
        cb({success = false})
        return
    end
    
    local success, roomId = apiServer.createRoom(roomName)
    
    if success then
        currentRoom = roomId
        config.notify(2, "Sala criada com sucesso!", 5000)
        cb({success = true, roomId = roomId})
    else
        cb({success = false})
    end
end)

-- Entra em uma sala
RegisterNUICallback('joinRoom', function(data, cb)
    local roomId = data.roomId
    
    if not roomId then
        cb({success = false})
        return
    end
    
    local success = apiServer.joinRoom(roomId)
    
    if success then
        currentRoom = roomId
        cb({success = true})
    else
        cb({success = false})
    end
end)

-- Sai de uma sala
RegisterNUICallback('leaveRoom', function(data, cb)
    if not currentRoom then
        cb({success = false})
        return
    end
    
    local success = apiServer.leaveRoom(currentRoom)
    
    if success then
        currentRoom = nil
        cb({success = true})
    else
        cb({success = false})
    end
end)

-- Envia um desafio
RegisterNUICallback('sendChallenge', function(data, cb)
    local targetRoomId = data.targetRoomId
    
    if not targetRoomId or not currentRoom then
        cb({success = false})
        return
    end
    
    local success = apiServer.sendChallenge(targetRoomId)
    cb({success = success})
end)

-- Aceita um desafio
RegisterNUICallback('acceptChallenge', function(data, cb)
    local challengeId = data.challengeId
    
    if not challengeId then
        cb({success = false})
        return
    end
    
    local success = apiServer.acceptChallenge(challengeId)
    cb({success = success})
end)

-- Função para entrar em modo de partida
function apiClient.enterMatch(matchData)
    isInMatch = true
    local ped = PlayerPedId()
    
    -- Prepara o player para a partida
    clientConfig.setPedMaxHealth(ped)
    clientConfig.setEntityInvincible(ped, false)
    clientConfig.freezeEntityPosition(ped, false)
    
    -- Define armas se especificado
    if matchData.weapons then
        clientConfig.setWeaponToPed(ped, matchData.weapons, matchData.infiniteAmmo or false)
    end
    
    -- Teleporta para a posição de spawn
    if matchData.spawnPosition then
        clientConfig.setEntityCoords(ped, matchData.spawnPosition.x, matchData.spawnPosition.y, matchData.spawnPosition.z)
    end
end

-- Função para sair da partida
function apiClient.exitMatch()
    isInMatch = false
    local ped = PlayerPedId()
    
    -- Remove armas
    clientConfig.removeAllPedWeapons(ped)
    
    -- Restaura estado normal
    clientConfig.setPedMaxHealth(ped)
    clientConfig.setEntityInvincible(ped, false)
end

-- Função para entrar em modo espectador
function apiClient.enterSpectatorMode(targetPlayer)
    isSpectating = true
    spectatingPlayer = targetPlayer
    
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetPlayer))
    clientConfig.setPlayerInSpectatorMode(true, targetPed)
    
    config.notify(3, config.Language.SpectatingPlayer .. targetPlayer, 5000)
end

-- Função para sair do modo espectador
function apiClient.exitSpectatorMode()
    isSpectating = false
    clientConfig.setPlayerInSpectatorMode(false)
    spectatingPlayer = nil
end

-- Função para definir saúde do player
function apiClient.setPlayerHealth(health)
    local ped = PlayerPedId()
    clientConfig.setEntityHealth(ped, health)
end

-- Função para respawnar o player
function apiClient.respawnPlayer()
    local ped = PlayerPedId()
    clientConfig.respawnPed(ped)
end

-- Thread para gerenciar o modo espectador
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if isSpectating then
            -- Mantém o modo espectador ativo
            if spectatingPlayer then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(spectatingPlayer))
                if targetPed and targetPed ~= 0 then
                    clientConfig.setPlayerInSpectatorMode(true, targetPed)
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

-- Evento quando o script inicia
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2[COMBO LATEGAME]^7 Cliente iniciado com sucesso!")
    end
end)

return apiClient

