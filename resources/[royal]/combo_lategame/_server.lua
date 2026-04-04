-- Script principal do servidor
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

print(("[combo_lategame] import=%s module=%s"):format(type(import), type(module)))
print(("[combo_lategame] vrp=%s vRP=%s"):format(GetResourceState("vrp"), GetResourceState("vRP")))
print(("[combo_lategame] vrp utils=%s vRP utils=%s"):format(
    LoadResourceFile("vrp", "lib/utils.lua") and "ok" or "missing",
    LoadResourceFile("vRP", "lib/utils.lua") and "ok" or "missing"
))

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
    print(("[combo_lategame] Proxy=%s Tunnel=%s (falha ao carregar vRP lib)"):format(tostring(Proxy), tostring(Tunnel)))
    return
end

local vRP = Proxy.getInterface('vRP')

local config = comboRequireLocal('config/config.lua')
local TokenSystem = comboRequireLocal('token.lua')

local function vrpGetUserId(source)
    if not vRP or not vRP.getUserId then return nil end
    local ok, res = pcall(vRP.getUserId, { source })
    if ok and res then return res end
    ok, res = pcall(vRP.getUserId, source)
    if ok and res then return res end
    return nil
end

local function vrpGetUserIdentity(user_id)
    if not vRP or not vRP.getUserIdentity then return nil end
    local ok, res = pcall(vRP.getUserIdentity, { user_id })
    if ok and res then return res end
    ok, res = pcall(vRP.getUserIdentity, user_id)
    if ok and res then return res end
    return nil
end

local function vrpGetUserSource(user_id)
    if not vRP or not vRP.getUserSource then return nil end
    local ok, res = pcall(vRP.getUserSource, { user_id })
    if ok and res then return res end
    ok, res = pcall(vRP.getUserSource, user_id)
    if ok and res then return res end
    return nil
end

-- Interface de comunicação
local apiServer = {}
Tunnel.bindInterface('combo_lategame', apiServer)
local apiClient = Tunnel.getInterface('combo_lategame')

-- Variáveis globais
local rooms = {}
local activeMatches = {}
local pendingChallenges = {}

-- Função para obter informações do player
function GetPlayerInfo(source)
    local name = GetPlayerName(source) or "Desconhecido"
    local user_id = vrpGetUserId(source)
    if not user_id then
        return {
            source = source,
            user_id = nil,
            name = name
        }
    end

    local identity = vrpGetUserIdentity(user_id)
    if not identity then
        return {
            source = source,
            user_id = user_id,
            name = name
        }
    end

    local fullname = identity.name or identity.firstname or name
    return {
        source = source,
        user_id = user_id,
        name = fullname
    }
end

-- Cria uma nova sala
function apiServer.createRoom(roomName)
    local source = source
    local playerInfo = GetPlayerInfo(source)
    if not playerInfo then
        playerInfo = { source = source, name = GetPlayerName(source) or "Desconhecido" }
    end

    if apiServer.getPlayerRoomId() ~= nil then
        config.notify(source, 1, "Você já está em uma equipe.", 5000)
        return false
    end
    
    -- Validação do nome
    if not roomName or roomName == "" then
        config.notify(source, 1, config.Language.CannotUseThisName, 5000)
        return false
    end
    
    -- Verifica se já existe uma sala com esse nome
    for _, room in pairs(rooms) do
        if room.name == roomName then
            config.notify(source, 1, config.Language.NameAlreadyExists, 5000)
            return false
        end
    end
    
    -- Cria a sala
    local roomId = #rooms + 1
    rooms[roomId] = {
        id = roomId,
        name = roomName,
        owner = source,
        ownerName = playerInfo.name,
        members = {source},
        isInVoting = false,
        currentMatch = nil,
        createdAt = os.time()
    }
    
    config.notify(source, 2, "Sala criada com sucesso!", 5000)
    return true, roomId
end

-- Entra em uma sala
function apiServer.joinRoom(roomId)
    local source = source
    local playerInfo = GetPlayerInfo(source)
    roomId = tonumber(roomId)
    
    if not playerInfo then
        return false
    end

    local currentRoomId = apiServer.getPlayerRoomId()
    if currentRoomId ~= nil then
        if currentRoomId == roomId then
            return false
        end
        config.notify(source, 1, "Você já está em uma equipe.", 5000)
        return false
    end
    
    local room = rooms[roomId]
    if not room then
        return false
    end

    for _, member in ipairs(room.members) do
        if member == source then
            return false
        end
    end
    
    -- Verifica limite de membros
    if #room.members >= config.MaximumRoomMembers then
        config.notify(source, 1, config.Language.MaximumLimitOfPlayers, 5000)
        return false
    end
    
    -- Adiciona o membro
    table.insert(room.members, source)
    config.notify(source, 2, "Você entrou na sala: " .. room.name, 5000)
    
    return true
end

-- Sai de uma sala
function apiServer.leaveRoom(roomId)
    local source = source
    roomId = tonumber(roomId)
    local room = rooms[roomId]
    
    if not room then
        return false
    end
    
    -- Remove o membro
    for i, member in ipairs(room.members) do
        if member == source then
            table.remove(room.members, i)
            break
        end
    end
    
    -- Se o dono saiu, transfere ou remove a sala
    if room.owner == source then
        if #room.members > 0 then
            room.owner = room.members[1]
        else
            rooms[roomId] = nil
        end
    end
    
    config.notify(source, 2, "Você saiu da sala", 5000)
    return true
end

function apiServer.getPlayerRoomId()
    local source = source

    for roomId, room in pairs(rooms) do
        for _, member in ipairs(room.members) do
            if member == source then
                return roomId
            end
        end
    end

    return nil
end

function apiServer.getRooms()
    local result = {}

    for roomId, room in pairs(rooms) do
        result[#result + 1] = {
            id = roomId,
            name = room.name,
            members = #room.members,
            owner = room.owner,
            verified = false,
            hasPassword = false
        }
    end

    return result
end

function apiServer.getCurrentRoom()
    local source = source
    local roomId = apiServer.getPlayerRoomId()
    if not roomId then
        return nil
    end

    local room = rooms[roomId]
    if not room then
        return nil
    end

    local myPassport = vrpGetUserId(source) or source
    local ownerPassport = vrpGetUserId(room.owner) or room.owner

    local members = {}
    for _, memberSource in ipairs(room.members) do
        local memberPassport = vrpGetUserId(memberSource) or memberSource
        members[#members + 1] = {
            id = memberPassport,
            owner = memberPassport == ownerPassport,
            myself = memberPassport == myPassport
        }
    end

    return {
        team = {
            id = roomId,
            name = room.name,
            verified = false,
            members = #room.members
        },
        members = members
    }
end

function apiServer.deleteRoom(roomId)
    local source = source
    roomId = tonumber(roomId)
    local room = rooms[roomId]
    if not room or room.owner ~= source then
        return false
    end

    rooms[roomId] = nil
    return true
end

function apiServer.kickFromMyRoom(targetSource)
    local source = source
    targetSource = tonumber(targetSource)
    local roomId = apiServer.getPlayerRoomId()
    if not roomId then
        return false
    end

    local resolvedTarget = targetSource
    local maybeSource = vrpGetUserSource(targetSource)
    if maybeSource then
        resolvedTarget = maybeSource
    end

    return apiServer.kickMember(roomId, resolvedTarget)
end

-- Expulsa um membro da sala
function apiServer.kickMember(roomId, targetSource)
    local source = source
    roomId = tonumber(roomId)
    targetSource = tonumber(targetSource)
    local room = rooms[roomId]
    
    if not room or room.owner ~= source then
        return false
    end
    
    -- Remove o membro
    for i, member in ipairs(room.members) do
        if member == targetSource then
            table.remove(room.members, i)
            config.notify(targetSource, 1, config.Language.YouWereKickedOfTheRoom, 5000)
            break
        end
    end
    
    return true
end

-- Envia um desafio
function apiServer.sendChallenge(targetRoomId)
    local source = source
    local playerInfo = GetPlayerInfo(source)
    targetRoomId = tonumber(targetRoomId)
    
    if not playerInfo then
        return false
    end
    
    local sourceRoom = nil
    for _, room in pairs(rooms) do
        for _, member in ipairs(room.members) do
            if member == source then
                sourceRoom = room
                break
            end
        end
        if sourceRoom then break end
    end
    
    if not sourceRoom then
        return false
    end
    
    if sourceRoom.id == targetRoomId then
        config.notify(source, 1, config.Language.CannotChallengeYourRoom, 5000)
        return false
    end
    
    local targetRoom = rooms[targetRoomId]
    if not targetRoom then
        return false
    end
    
    -- Cria o desafio
    local challengeId = #pendingChallenges + 1
    pendingChallenges[challengeId] = {
        id = challengeId,
        fromRoom = sourceRoom.id,
        toRoom = targetRoomId,
        fromOwner = source,
        createdAt = os.time()
    }
    
    -- Notifica o dono da sala alvo
    local message = string.format(config.Language.AcceptChallenge, sourceRoom.name, #sourceRoom.members, config.MaximumRoomMembers)
    config.notify(targetRoom.owner, 3, message, 10000)
    
    config.notify(source, 2, config.Language.RequestSent, 5000)
    return true
end

-- Aceita um desafio
function apiServer.acceptChallenge(challengeId)
    local source = source
    challengeId = tonumber(challengeId)
    local challenge = pendingChallenges[challengeId]
    
    if not challenge then
        return false
    end
    
    local targetRoom = rooms[challenge.toRoom]
    if not targetRoom or targetRoom.owner ~= source then
        return false
    end
    
    local fromRoom = rooms[challenge.fromRoom]
    if not fromRoom then
        return false
    end
    
    -- Remove o desafio
    pendingChallenges[challengeId] = nil
    
    -- Inicia a votação
    fromRoom.isInVoting = true
    targetRoom.isInVoting = true
    
    -- Notifica os membros
    for _, member in ipairs(fromRoom.members) do
        config.notify(member, 3, config.Language.StartVotation, 5000)
    end
    
    for _, member in ipairs(targetRoom.members) do
        config.notify(member, 3, config.Language.StartVotation, 5000)
    end
    
    return true
end

-- Define armas para um ped
function apiServer.setWeaponsPed(source, weapons)
    if not vRP or not vRP.giveWeapons then
        return false
    end
    
    vRP.giveWeapons({source, weapons, true})
    return true
end

-- Evento quando o script inicia
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2[COMBO LATEGAME]^7 Sistema iniciado com sucesso!")
    end
end)

-- Limpa dados quando player desconecta
AddEventHandler('playerDropped', function()
    local source = source
    
    -- Remove de todas as salas
    for roomId, room in pairs(rooms) do
        for i, member in ipairs(room.members) do
            if member == source then
                table.remove(room.members, i)
                
                if room.owner == source and #room.members > 0 then
                    room.owner = room.members[1]
                elseif room.owner == source then
                    rooms[roomId] = nil
                end
                
                break
            end
        end
    end
    
    -- Remove desafios pendentes
    for challengeId, challenge in pairs(pendingChallenges) do
        if challenge.fromOwner == source then
            pendingChallenges[challengeId] = nil
        end
    end
end)

return apiServer

