---@diagnostic disable: undefined-global, need-check-nil
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")

-- Configurações de Grupos e Aces com permissão
local ALLOWED_GROUPS = { "Admin", "CEO", "Ceo", "ceo" }
local ALLOWED_ACES = { "npcmenu.use" }

-- Função auxiliar para checar ACE permission
local function hasAllowedAce(src)
    for _, ace in ipairs(ALLOWED_ACES) do
        if IsPlayerAceAllowed(src, ace) then
            return true
        end
    end
    return false
end

-- Função auxiliar para checar Grupo vRP
local function hasAllowedGroup(passport)
    for _, group in ipairs(ALLOWED_GROUPS) do
        if vRP.HasGroup(passport, group) then
            return true
        end
    end
    return false
end

-- Função centralizada de verificação de permissão
local function checkPlayerPermission(src, passport)
    if hasAllowedGroup(passport) then return true, "grupo" end
    if hasAllowedAce(src) then return true, "ace" end
    return false, "sem_permissao"
end

-- O cliente pede permissão para abrir o menu
RegisterNetEvent("npcmenu:requestPermission", function()
    local src = source
    local passport = vRP.Passport(src)

    if not passport then
        TriggerClientEvent("npcmenu:permissionResult", src, false, "sem_passaporte")
        return
    end

    local allowed, reason = checkPlayerPermission(src, passport)
    TriggerClientEvent("npcmenu:permissionResult", src, allowed, reason)
end)

-- O cliente pede o save original de roupas (botão Voltar)
RegisterNetEvent("npcmenu:requestCharacterSkin", function()
    local src = source
    local passport = vRP.Passport(src)
    local skin = nil

    if passport then
        local datatable = vRP.Datatable(passport)
        if datatable and datatable["Skin"] then
            -- Puxa o save original do banco de dados (o RG do cidadão)
            skin = datatable["Skin"]
        end
    end

    TriggerClientEvent("npcmenu:characterSkinResult", src, skin)
end)

-- O jogador escolhe um NPC no grid (valida permissão e manda aplicar)
RegisterNetEvent("npcmenu:applyNpcModel", function(modelToApply)
    local src = source
    local passport = vRP.Passport(src)

    if not passport then return end

    -- Verifica se quem clicou ainda tem permissão (segurança contra trigger hack)
    local allowed = checkPlayerPermission(src, passport)
    
    if allowed then
        TriggerClientEvent("npcmenu:confirmModelChange", src, modelToApply)
    else
        print("[NPC-MENU] ALERTA: Passaporte " .. tostring(passport) .. " tentou forçar uma troca de NPC sem permissão!")
    end
end)

-- ==========================================
-- SISTEMA DO PAINEL ADMIN (SETAR SKIN EM ID COM TEMPO)
-- ==========================================
RegisterNetEvent("npcmenu:setTargetSkin", function(targetId, model, timeMins)
    local src = source
    local passport = vRP.Passport(src)

    if not passport then return end

    -- Verifica se quem clicou no botão do painel tem permissão
    local allowed = checkPlayerPermission(src, passport)
    if not allowed then
        print("[NPC-MENU] ALERTA: Passaporte " .. tostring(passport) .. " tentou setar skin em outro jogador sem permissão!")
        return
    end

    -- Busca a Source (Sessão) do jogador alvo pelo ID (Passaporte)
    local targetSrc = vRP.Source(targetId)
    
    if targetSrc then
        -- Manda o cliente do alvo aplicar a skin
        TriggerClientEvent("npcmenu:confirmModelChange", targetSrc, model)
        TriggerClientEvent("Notify", src, "sucesso", "Skin aplicada no Passaporte " .. targetId .. " por " .. timeMins .. " minutos.", 5000)
        
        -- Calcula o tempo: Minutos * 60 segundos * 1000 milissegundos
        local timeInMillis = timeMins * 60 * 1000
        
        -- Inicia o cronômetro do servidor para reverter
        SetTimeout(timeInMillis, function()
            -- Busca a source de novo pra garantir que ele não deslogou e voltou com outra source
            local currentTargetSrc = vRP.Source(targetId)
            if currentTargetSrc then
                -- Manda o cliente do alvo voltar ao normal
                TriggerClientEvent("npcmenu:revertSkin", currentTargetSrc)
            end
        end)
    else
        TriggerClientEvent("Notify", src, "negado", "O Passaporte " .. targetId .. " está offline.", 5000)
    end
end)