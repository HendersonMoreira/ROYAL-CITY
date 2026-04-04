-- Token de autenticação do servidor
-- Este arquivo gerencia tokens e autenticação

local TokenSystem = {}

-- Gera um token único
function TokenSystem.generateToken()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local token = ""
    
    for i = 1, 32 do
        local rand = math.random(1, #chars)
        token = token .. string.sub(chars, rand, rand)
    end
    
    return token
end

-- Valida um token
function TokenSystem.validateToken(token)
    if not token or type(token) ~= "string" then
        return false
    end
    
    if #token ~= 32 then
        return false
    end
    
    return true
end

-- Armazena tokens ativos
local activeTokens = {}

-- Cria um token para um player
function TokenSystem.createPlayerToken(source)
    local token = TokenSystem.generateToken()
    activeTokens[source] = {
        token = token,
        createdAt = os.time()
    }
    return token
end

-- Verifica se o token do player é válido
function TokenSystem.verifyPlayerToken(source, token)
    if not activeTokens[source] then
        return false
    end
    
    if activeTokens[source].token ~= token then
        return false
    end
    
    -- Token expira após 1 hora
    if os.time() - activeTokens[source].createdAt > 3600 then
        activeTokens[source] = nil
        return false
    end
    
    return true
end

-- Remove token de um player
function TokenSystem.removePlayerToken(source)
    activeTokens[source] = nil
end

-- Limpa tokens expirados
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Verifica a cada minuto
        
        local currentTime = os.time()
        for source, tokenData in pairs(activeTokens) do
            if currentTime - tokenData.createdAt > 3600 then
                activeTokens[source] = nil
            end
        end
    end
end)

-- Remove token quando player desconecta
AddEventHandler('playerDropped', function()
    local source = source
    TokenSystem.removePlayerToken(source)
end)

return TokenSystem

