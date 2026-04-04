---@diagnostic disable: undefined-global
local originalSkin = nil
local characterBaseModel = nil

-- Função para verificar se é um modelo Freemode (Personagem de Roupa)
local function isFreemodeModel(hash)
    return hash == GetHashKey("mp_m_freemode_01") or hash == GetHashKey("mp_f_freemode_01")
end

-- Função para recarregar a aparência original (roupas, rosto, tattoos)
local function reloadCharacterAppearance()
    -- if GetResourceState("vrp") == "started" then exports["vrp"]:ReloadCharacter() end
    if GetResourceState("skinshop") == "started" then exports["skinshop"]:Apply() end
    if GetResourceState("barbershop") == "started" then exports["barbershop"]:Apply() end
    if GetResourceState("tattooshop") == "started" then exports["tattooshop"]:Apply() end
end

-- Função Segura para carregar e aplicar o modelo
local function safeLoadAndSetModel(model)
    if type(model) == "string" then model = GetHashKey(model) end

    -- Verifica se o modelo existe na base do jogo
    if not IsModelInCdimage(model) or not IsModelValid(model) then
        print("[NPC-MENU] Erro: O modelo solicitado nao e valido no servidor.")
        return false
    end

    -- Solicita o modelo ao jogo
    RequestModel(model)
    
    -- Aguarda o carregamento com timeout (anti-crash)
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 500 do
        Wait(10)
        timeout = timeout + 1
    end

    -- Aplica o modelo se carregou
    if HasModelLoaded(model) then
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        local ped = PlayerPedId()

        -- ========================================================
        -- FIX 1: TRAVAS DE VIDA E HIT KILL (Resolve Queda Instantanea)
        -- ========================================================
        SetPedMaxHealth(ped, 200) -- Vida de Humano
        SetEntityMaxHealth(ped, 200) -- Vida de Humano
        SetEntityHealth(ped, 200) -- Enche a vida
        SetPedSuffersCriticalHits(ped, false) -- Impede Hit Kill na cabeça ao cair

        -- ========================================================
        -- FIX 2: RESETAR MODO DE ANDAR (Resolve CJ/BOB Amassados)
        -- ========================================================
        -- Essa linha força o jogo a parar de usar qualquer estilo de andar VIP
        ResetPedMovementClipset(ped, 0.0) 
        ClearPedTasksImmediately(ped) -- Para animações que estejam rolando
        
        return true
    else
        print("[NPC-MENU] Erro: Falha ao carregar o modelo (Timeout).")
        return false
    end
end

-- Função para restaurar a skin original (Consertada para evitar erro NIL)
local function restoreToModel(targetModel)
    if not targetModel then return end

    if safeLoadAndSetModel(targetModel) then
        reloadCharacterAppearance()
    end
end

-- Captura o modelo original quando o jogador nasce
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active", function()
    SetTimeout(1000, function()
        local currentModel = GetEntityModel(PlayerPedId())
        if isFreemodeModel(currentModel) then
            characterBaseModel = currentModel
        end
    end)
end)

-- Recebe a permissão do servidor para abrir o menu
RegisterNetEvent('npcmenu:permissionResult')
AddEventHandler('npcmenu:permissionResult', function(allowed, reason)
    if not allowed then
        SetNotificationTextEntry('STRING')
        AddTextComponentString('~r~NPC MENU: sem permissao (~w~' .. tostring(reason) .. '~r~)')
        DrawNotification(false, false)
        return
    end

    -- Guarda a skin antes da transformação para o botão 'Voltar'
    if not originalSkin then
        originalSkin = GetEntityModel(PlayerPedId())
    end

    -- Atualiza o modelo base se for personagem de roupa
    local currentModel = GetEntityModel(PlayerPedId())
    if isFreemodeModel(currentModel) then
        characterBaseModel = currentModel
    end

    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'show' })
end)

-- Comando para abrir o menu
RegisterCommand('npcmenu', function()
    TriggerServerEvent('npcmenu:requestPermission')
end)

-- Evento vindo do servidor para aplicar o modelo
RegisterNetEvent("npcmenu:confirmModelChange")
AddEventHandler("npcmenu:confirmModelChange", function(model)
    safeLoadAndSetModel(model)
end)

-- Recebe o save de roupas originais do servidor (botão Voltar)
RegisterNetEvent("npcmenu:characterSkinResult")
AddEventHandler("npcmenu:characterSkinResult", function(skin)
    if skin then
        -- Restaura usando o datatable do vRP
        restoreToModel(skin)
    else
        -- Restaura usando o modelo capturado no login
        local fallbackModel = characterBaseModel or "mp_m_freemode_01"
        restoreToModel(fallbackModel)
    end

    originalSkin = nil
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hide" })
end)

-- ==========================================
-- CALLBACKS DO NUI (BOTOES DO HTML)
-- ==========================================

-- Botão "Voltar à skin original"
RegisterNUICallback("originalSkin", function(_, cb)
    local targetModel = characterBaseModel or originalSkin

    -- Se capturou o modelo base, restaura localmente (mais rápido)
    if targetModel and isFreemodeModel(targetModel) then
        restoreToModel(targetModel)
        originalSkin = nil
    else
        -- Se falhou, pede pro servidor puxar o save original do vRP
        TriggerServerEvent("npcmenu:requestCharacterSkin")
    end

    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hide" })
    cb("ok")
end)

-- Botão Fechar
RegisterNUICallback("close", function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hide" })
    cb("ok")
end)

-- Botão Escolher NPC no Grid
RegisterNUICallback("selectNPC", function(data, cb)
    TriggerServerEvent("npcmenu:applyNpcModel", data.model)
    cb("ok")
end)

-- Botão Aplicar Skin no Painel Admin
RegisterNUICallback("setSkinTarget", function(data, cb)
    TriggerServerEvent("npcmenu:setTargetSkin", data.id, data.model, data.time)
    cb("ok")
end)

-- Evento quando o tempo do cronômetro acaba
RegisterNetEvent("npcmenu:revertSkin")
AddEventHandler("npcmenu:revertSkin", function()
    -- Reverte pro modelo base original
    local targetModel = characterBaseModel or "mp_m_freemode_01"
    restoreToModel(targetModel)
    originalSkin = nil
    
    SetNotificationTextEntry('STRING')
    AddTextComponentString('~y~O tempo da sua skin expirou!~w~')
    DrawNotification(false, false)
end)