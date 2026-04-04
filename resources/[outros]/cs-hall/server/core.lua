-- ===========================================
-- CS-HALL SERVER CORE - DESOFUSCADO
-- ===========================================

-- Verificação de configuração
if not config then
    error("[criticalscripts.shop] cs-hall configuration file has a syntax error, please resolve it otherwise the resource will not work.")
  return
end

-- Verificação de atualizações
if config.updatesCheck then
    local currentVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
    
    PerformHttpRequest("https://updates.criticalscripts.com/cs-hall", function(statusCode, response, headers)
        if statusCode == 200 then
            local updateData = json.decode(response)
            if updateData then
                if updateData.version ~= currentVersion then
                    print("[criticalscripts.shop] Resource \"cs-hall\" is outdated, please download the latest version through your keymaster.")
                else
                    print("[criticalscripts.shop] Resource \"cs-hall\" is up to date.")
                end
                
                if updateData.message then
                    print("[criticalscripts.shop] " .. updateData.message)
        end
      else
                print("[criticalscripts.shop] Resource \"cs-hall\" failed to perform update check.")
      end
    else
            print("[criticalscripts.shop] Resource \"cs-hall\" failed to perform update check.")
        end
    end, "GET", "", {})
end
-- ===========================================
-- VARIÁVEIS GLOBAIS
-- ===========================================

local areaQueue = {}        -- Fila de mídia para cada área
local playerAreas = {}       -- Mapeamento de jogadores para áreas
local playerControllers = {} -- Controladores de interface por jogador
local areaData = {}          -- Dados das áreas
local DEFAULT_DELAY_MS = 500 -- Delay padrão em milissegundos
local shouldSaveData = false -- Flag para salvar dados

-- ===========================================
-- INICIALIZAÇÃO DAS ÁREAS
-- ===========================================

for areaId, areaConfig in pairs(config.entries) do
    local areaInfo = {}
    
    -- Configuração de mídia
    local mediaInfo = {}
    mediaInfo.playing = false
    mediaInfo.stopped = true
    mediaInfo.time = 0
    
    -- Configurar volume padrão
    local defaultVolume = 0.5
    if areaConfig.maxVolumePercent then
        local maxVolume = areaConfig.maxVolumePercent / 100
        if defaultVolume > maxVolume then
            defaultVolume = maxVolume
        end
    end
    mediaInfo.volume = defaultVolume
    
    mediaInfo.loop = false
    mediaInfo.url = nil
    mediaInfo.thumbnailUrl = nil
    mediaInfo.thumbnailTitle = nil
    mediaInfo.title = nil
    mediaInfo.icon = nil
    mediaInfo.duration = nil
    areaInfo.media = mediaInfo
    
    -- Configuração de telas
    local screensInfo = {}
    screensInfo.advancingAt = nil
    screensInfo.advancedAt = nil
    screensInfo.retractingAt = nil
    screensInfo.retractedAt = nil
    areaInfo.screens = screensInfo
    
    -- Configuração de fumaça
    local smokeInfo = {}
    smokeInfo.lastTriggeredAt = nil
    areaInfo.smoke = smokeInfo
    
    -- Configuração de fogos de artifício
    local sparklersInfo = {}
    sparklersInfo.lastTriggeredAt = nil
    areaInfo.sparklers = sparklersInfo
    
    -- Configurações gerais
    local settingsInfo = {}
    settingsInfo.bassSmoke = false
    settingsInfo.bassSparklers = false
    settingsInfo.whiteSpotlights = false
    settingsInfo.dynamicSpotlights = false
    settingsInfo.scenesEnabled = false
    settingsInfo.photorythmicSpotlights = true
    settingsInfo.videoToggle = true
    areaInfo.settings = settingsInfo
    
    areaInfo.updater = nil
    areaInfo.controller = nil
    
    areaData[areaId] = areaInfo
    areaQueue[areaId] = {}
end
-- ===========================================
-- CARREGAMENTO DE DADOS SALVOS
-- ===========================================

local savedData = GetResourceKvpString("data")
local savedQueue = GetResourceKvpString("queue")

if savedData then
    local decodedData = json.decode(savedData)
    if decodedData then
        -- Restaurar dados das áreas
        for areaId, areaSavedData in pairs(decodedData) do
            if config.entries[areaId] and areaSavedData then
                local areaConfig = config.entries[areaId]
                
                -- Garantir que estruturas existam
                areaSavedData.media = areaSavedData.media or {}
                areaSavedData.smoke = areaSavedData.smoke or {}
                areaSavedData.sparklers = areaSavedData.sparklers or {}
                
                -- Resetar timestamps de efeitos
                if areaSavedData.smoke then
                    areaSavedData.smoke.lastTriggeredAt = nil
                end
                if areaSavedData.sparklers then
                    areaSavedData.sparklers.lastTriggeredAt = nil
                end
                
                -- Resetar estado da mídia
                areaSavedData.media.time = 0
                areaSavedData.media.duration = nil
                areaSavedData.media.stopped = true
                areaSavedData.media.playing = false
                
                -- Ajustar volume se necessário
                if areaConfig.maxVolumePercent then
                    local maxVolume = areaConfig.maxVolumePercent / 100
                    if areaSavedData.media.volume > maxVolume then
                        areaSavedData.media.volume = maxVolume
                    end
                end
                
                -- Limpar controladores
                areaSavedData.controller = nil
                areaSavedData.updater = nil
                
                -- Calcular duração máxima das telas
                local maxScreenDuration = 0
                if areaConfig.screens then
                    for i = 1, #areaConfig.screens do
                        local screenDuration = areaConfig.screens[i].advance.durationMs
                        if maxScreenDuration < screenDuration then
                            maxScreenDuration = screenDuration
                        end
                    end
                end
                -- Garantir que estrutura de telas exista
                areaSavedData.screens = areaSavedData.screens or {}
                
                -- Configurar estado das telas se necessário
                if areaSavedData.screens then
                    if areaSavedData.screens.advancedAt and not areaSavedData.screens.retractedAt then
                        -- Telas estão avançadas mas não retraídas
                        local currentTime = GetGameTimer()
                        if areaSavedData.screens.advancedAt > areaSavedData.screens.retractedAt then
                            areaSavedData.screens.advancingAt = currentTime
                            areaSavedData.screens.advancedAt = currentTime + maxScreenDuration
                            areaSavedData.screens.retractingAt = nil
                            areaSavedData.screens.retractedAt = nil
              end
            end
                else
                    -- Resetar estado das telas
                    areaSavedData.screens.advancingAt = nil
                    areaSavedData.screens.advancedAt = nil
                    local currentTime = GetGameTimer()
                    areaSavedData.screens.retractingAt = currentTime
                    areaSavedData.screens.retractedAt = currentTime + maxScreenDuration
                end
              end
            end
          end
    -- Mesclar dados salvos com dados padrão
    for areaId, areaInfo in pairs(areaData) do
        local savedAreaData = decodedData[areaId]
        if savedAreaData then
            areaData[areaId] = CopyAndMerge(areaInfo, savedAreaData)
        end
              end
            end

-- Carregar fila salva
if savedQueue then
    local decodedQueue = json.decode(savedQueue)
    if decodedQueue then
        -- Restaurar fila para cada área
        for areaId, queueInfo in pairs(areaQueue) do
            if config.entries[areaId] then
                local savedQueueData = decodedQueue[areaId]
                if savedQueueData then
                    areaQueue[areaId] = savedQueueData
            end
          end
          end
        end
      end
-- ===========================================
-- FUNÇÕES AUXILIARES
-- ===========================================

-- Função para verificar se string começa com prefixo
function StartsWith(str, prefix)
    return string.sub(str, 1, string.len(prefix)) == prefix
end

-- Função para copiar e mesclar tabelas
function CopyAndMerge(target, source)
    local result = {}
    
    -- Copiar dados do target
    for k, v in pairs(target) do
        result[k] = v
    end
    
    -- Mesclar dados do source
    for k, v in pairs(source) do
        if type(v) == "table" and type(result[k]) == "table" then
            result[k] = CopyAndMerge(result[k], v)
        else
            result[k] = v
    end
  end
    
    return result
end

-- Função para atualizar o atualizador atual da área
function RefreshCurrentUpdater(areaId)
    local areaInfo = areaData[areaId]
    if not areaInfo then
        return
    end
    
    -- Limpar atualizador atual
    local currentUpdater = areaInfo.updater
    if currentUpdater then
        local endpoint = GetPlayerEndpoint(currentUpdater)
        if endpoint then
            TriggerClientEvent("cs-hall:updater", currentUpdater, areaId, false)
      end
    end
    
    -- Procurar novo atualizador
    local newUpdater = nil
    for playerId, playerArea in pairs(playerAreas) do
        if playerArea == areaId then
            newUpdater = playerId
            break
  end
end
    
    -- Definir novo atualizador
    areaInfo.updater = newUpdater
    if newUpdater then
        TriggerClientEvent("cs-hall:updater", newUpdater, areaId, true)
    end
end

-- ===========================================
-- FUNÇÕES DE VERIFICAÇÃO DE PERMISSÃO
-- ===========================================

-- Verificar se jogador pode atualizar área
function IsAllowedToUpdate(areaId, playerId)
    return areaData[areaId].updater == playerId
end

-- Verificar se jogador pode controlar área
function IsAllowedToControl(areaId, playerId)
    return playerControllers[playerId] == areaId
end
-- Limpar controlador da área
function ClearController(areaId)
    local controller = areaData[areaId].controller
    if controller then
        local endpoint = GetPlayerEndpoint(controller)
        if endpoint then
            TriggerClientEvent("cs-hall:controller", controller, areaId, false)
        end
    end
    areaData[areaId].controller = nil
end
-- Definir controlador da área
function SetController(areaId, playerId)
    areaData[areaId].controller = playerId
    TriggerClientEvent("cs-hall:controller", playerId, areaId, true)
end
-- Limpar atualizador da área
function ClearUpdater(areaId)
    local updater = areaData[areaId].updater
    if updater then
        local endpoint = GetPlayerEndpoint(updater)
        if endpoint then
            TriggerClientEvent("cs-hall:updater", updater, areaId, false)
        end
    end
    areaData[areaId].updater = nil
    -- Transferir controle para outro jogador se possível
    local controller = areaData[areaId].controller
    if controller then
        if playerControllers[controller] == areaId then
            -- Transferir controle para o controlador atual
            areaData[areaId].updater = controller
        else
            -- Procurar outro jogador na área
            for playerId, playerArea in pairs(playerControllers) do
                if playerArea == areaId then
                    areaData[areaId].updater = playerId
        break
      end
    end
  end
    end
    
    -- Notificar novo atualizador se existir
    local newUpdater = areaData[areaId].updater
    if newUpdater then
        TriggerClientEvent("cs-hall:updater", newUpdater, areaId, true)
    end
end
-- Sincronizar fila com clientes
function SyncQueue(areaId, targetPlayerId)
    if targetPlayerId then
        -- Enviar para jogador específico
        TriggerClientEvent("cs-hall:queue", targetPlayerId, areaId, areaQueue[areaId])
    else
        -- Enviar para todos os jogadores na área
        shouldSaveData = true
        for playerId, playerArea in pairs(playerControllers) do
            if playerArea == areaId then
                TriggerClientEvent("cs-hall:queue", playerId, areaId, areaQueue[areaId])
            end
        end
    end
end
-- Sincronizar dados da área com clientes
function SyncData(areaId, targetPlayerId, options)
    if targetPlayerId then
        -- Enviar para jogador específico
        local queueData = options or {}
        local currentTime = GetGameTimer()
        TriggerClientEvent("cs-hall:sync", targetPlayerId, areaId, areaData[areaId], queueData, currentTime)
    else
        -- Determinar se deve salvar dados
        if options and options.adjust then
            shouldSaveData = true
        end
        
        -- Enviar para todos os jogadores na área
        for playerId, playerArea in pairs(playerControllers) do
            if playerArea == areaId then
                local queueData = options or {}
                local currentTime = GetGameTimer()
                TriggerClientEvent("cs-hall:sync", playerId, areaId, areaData[areaId], queueData, currentTime)
            end
        end
      end
    end
-- Ajustar tempo da mídia para todos os jogadores na área
function AdjustTime(areaId)
    for playerId, playerArea in pairs(playerControllers) do
        if playerArea == areaId then
            TriggerClientEvent("cs-hall:adjust", playerId, areaData[areaId].media.time)
        end
    end
end
-- Avançar telas da área
function AdvanceScreens(areaId)
    if not areaData[areaId].screens then
        return
    end
    
    local currentTime = GetGameTimer()
    areaData[areaId].screens.advancingAt = currentTime
    
    -- Calcular duração máxima
    local maxDuration = 0
    if config.entries[areaId].screens then
        for i = 1, #config.entries[areaId].screens do
            local screenDuration = config.entries[areaId].screens[i].advance.durationMs
            if maxDuration < screenDuration then
                maxDuration = screenDuration
            end
        end
    end
    
    areaData[areaId].screens.advancedAt = currentTime + maxDuration
    SyncData(areaId)
    
    if config.debug then
        print("[debug] AdvanceScreens", maxDuration, currentTime, areaData[areaId].screens.advancedAt)
    end
end
-- Retrair telas da área
function RetractScreens(areaId)
    if not areaData[areaId].screens then
        return
    end
    
    local currentTime = GetGameTimer()
    areaData[areaId].screens.retractingAt = currentTime
    
    -- Calcular duração máxima
    local maxDuration = 0
    if config.entries[areaId].screens then
        for i = 1, #config.entries[areaId].screens do
            local screenDuration = config.entries[areaId].screens[i].advance.durationMs
            if maxDuration < screenDuration then
                maxDuration = screenDuration
            end
        end
    end
    
    areaData[areaId].screens.retractedAt = currentTime + maxDuration
    SyncData(areaId)
    
    if config.debug then
        print("[debug] RetractScreens", maxDuration, currentTime, areaData[areaId].screens.retractedAt)
    end
end
-- ===========================================
-- EVENTOS DE REDE
-- ===========================================

-- Evento de reprodução de mídia
RegisterNetEvent("cs-hall:play")
AddEventHandler("cs-hall:play", function(areaId, mediaData, options)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            if mediaData then
                TriggerClientEvent("cs-hall:interfacelessFeatureUsed", playerId, areaId, "play")
                
                -- Aplicar delay se necessário
                if not options then
                    local delayMs = config.entries[areaId].featureDelayWithControllerInterfaceClosedMs
                    if delayMs then
                        Wait(delayMs)
                    else
                        Wait(DEFAULT_DELAY_MS)
                    end
                end
            end
            
            local shouldAdvanceScreens = false
            
            -- Processar fila se houver itens
            if #areaQueue[areaId] > 0 then
                if not areaData[areaId].media.url then
                    local nextMedia = areaQueue[areaId][1]
                    table.remove(areaQueue[areaId], 1)
                    
                    -- Atualizar duração se URL for diferente
                    if areaData[areaId].media.url ~= nextMedia.url then
                        areaData[areaId].media.duration = nextMedia.duration
                    end
                    
                    -- Atualizar dados de mídia
                    areaData[areaId].media.url = nextMedia.url
                    areaData[areaId].media.thumbnailUrl = nextMedia.thumbnailUrl
                    areaData[areaId].media.thumbnailTitle = nextMedia.thumbnailTitle
                    areaData[areaId].media.title = nextMedia.title
                    areaData[areaId].media.icon = nextMedia.icon
                    areaData[areaId].media.time = 0
                    shouldAdvanceScreens = true
        end
      end
            
            -- Iniciar reprodução se houver URL
            if areaData[areaId].media.url then
                if not areaData[areaId].media.playing then
                    areaData[areaId].media.playing = true
                    areaData[areaId].media.stopped = false
    end
  end
            
            -- Disparar evento de reprodução
            TriggerEvent("cs-hall:onPlay", areaId, playerId, {
                media = {
                    url = areaData[areaId].media.url,
                    thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                    thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                    title = areaData[areaId].media.title,
                    icon = areaData[areaId].media.icon
                }
            })
            
            -- Sincronizar dados
            SyncQueue(areaId)
            SyncData(areaId, nil, {
                force = shouldAdvanceScreens
            })
    end
  end
end)
-- Evento de pausa de mídia
RegisterNetEvent("cs-hall:pause")
AddEventHandler("cs-hall:pause", function(areaId, options)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            if options then
                TriggerClientEvent("cs-hall:interfacelessFeatureUsed", playerId, areaId, "pause")
                
                -- Aplicar delay se necessário
                if not options.noDelay then
                    local delayMs = config.entries[areaId].featureDelayWithControllerInterfaceClosedMs
                    if delayMs then
                        Wait(delayMs)
                    else
                        Wait(DEFAULT_DELAY_MS)
          end
        end
      end
            
            -- Pausar mídia
            if areaData[areaId].media.url then
                if areaData[areaId].media.playing then
                    areaData[areaId].media.playing = false
                end
            end
            
            -- Disparar evento de pausa
            TriggerEvent("cs-hall:onPause", areaId, playerId, {
                media = {
                    url = areaData[areaId].media.url,
                    thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                    thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                    title = areaData[areaId].media.title,
                    icon = areaData[areaId].media.icon
                }
            })
            
            -- Sincronizar dados
            SyncData(areaId)
  end
end
end)
-- Evento de parada de mídia
RegisterNetEvent("cs-hall:stop")
AddEventHandler("cs-hall:stop", function(areaId, options)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            if options then
                TriggerClientEvent("cs-hall:interfacelessFeatureUsed", playerId, areaId, "stop")
                
                -- Aplicar delay se necessário
                if not options.noDelay then
                    local delayMs = config.entries[areaId].featureDelayWithControllerInterfaceClosedMs
                    if delayMs then
                        Wait(delayMs)
                    else
                        Wait(DEFAULT_DELAY_MS)
          end
        end
      end
            
            -- Parar mídia
            if areaData[areaId].media.url then
                if areaData[areaId].media.playing then
                    -- Disparar evento de parada
                    TriggerEvent("cs-hall:onStop", areaId, playerId, {
                        media = {
                            url = areaData[areaId].media.url,
                            thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                            thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                            title = areaData[areaId].media.title,
                            icon = areaData[areaId].media.icon
                        }
                    })
                end
            end
            
            -- Resetar estado da mídia
            areaData[areaId].media.playing = false
            areaData[areaId].media.stopped = true
            areaData[areaId].media.time = 0
            areaData[areaId].media.duration = nil
            
            -- Sincronizar dados
            SyncData(areaId, nil, {
                force = true
            })
  end
end
end)
-- Evento de busca na mídia
RegisterNetEvent("cs-hall:seek")
AddEventHandler("cs-hall:seek", function(areaId, time)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            if areaData[areaId].media.duration and areaData[areaId].media.duration > 0 then
                SetController(areaId, playerId)
                
                -- Atualizar atualizador se necessário
                if areaData[areaId].updater ~= areaData[areaId].controller then
                    RefreshCurrentUpdater(areaId)
                end
                
                -- Definir tempo de busca
                if areaData[areaId].media.url then
                    areaData[areaId].media.time = time
                    SyncData(areaId, nil, {
                        media = {
                            seek = true
                        }
                    })
            return
          end
        end
      end
        
        -- Sincronizar dados mesmo se não houver controle
        SyncData(areaId)
    end
end)
-- Evento de mudança de volume
RegisterNetEvent("cs-hall:changeVolume")
AddEventHandler("cs-hall:changeVolume", function(areaId, volume)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            -- Verificar limite máximo de volume
            local maxVolume = config.entries[areaId].maxVolumePercent
            if maxVolume then
                if volume <= maxVolume then
                    areaData[areaId].media.volume = volume / 100
                else
                    areaData[areaId].media.volume = maxVolume / 100
                end
            else
                areaData[areaId].media.volume = volume / 100
            end
            
            -- Sincronizar dados
            SyncData(areaId)
        end
      end
end)
-- Evento de toggle de loop
RegisterNetEvent("cs-hall:toggleLoop")
AddEventHandler("cs-hall:toggleLoop", function(areaId)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            -- Alternar estado do loop
            areaData[areaId].media.loop = not areaData[areaId].media.loop
            
            -- Sincronizar dados
            SyncData(areaId)
  end
end
end)
-- Evento de adicionar à fila
RegisterNetEvent("cs-hall:addToQueue")
AddEventHandler("cs-hall:addToQueue", function(areaId, url, thumbnailUrl, thumbnailTitle, title, icon)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            -- Verificar se fonte é permitida
            if not config.entries[areaId].allowAllSources then
                if not StartsWith(url, "https://www.youtube.com/") and
                   not StartsWith(url, "https://www.twitch.tv/") and
                   not StartsWith(url, "https://clips.twitch.tv/") then
              return
        end
      else
                -- Verificar se é uma URL válida
                if not StartsWith(url, "http://") and not StartsWith(url, "https://") then
            return
          end
        end
        
        SetController(areaId, playerId)
        
        -- Atualizar atualizador se necessário
        if areaData[areaId].updater ~= areaData[areaId].controller then
            RefreshCurrentUpdater(areaId)
        end
        
        -- Adicionar à fila
        table.insert(areaQueue[areaId], {
            url = url,
            thumbnailUrl = thumbnailUrl,
            thumbnailTitle = thumbnailTitle,
            title = title,
            icon = icon,
            duration = nil,
            manual = true
        })
        
        -- Disparar evento de entrada na fila
        TriggerEvent("cs-hall:onEntryQueued", areaId, playerId, {
            url = url,
            thumbnailUrl = thumbnailUrl,
            thumbnailTitle = thumbnailTitle,
            title = title,
            icon = icon,
            position = #areaQueue[areaId],
            duration = nil,
            manual = true
        })
        
        -- Sincronizar fila
        SyncQueue(areaId)
        end
    end
end)
-- Evento de próxima música da fila
RegisterNetEvent("cs-hall:nextQueueSong")
AddEventHandler("cs-hall:nextQueueSong", function(areaId, options)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            if options then
                TriggerClientEvent("cs-hall:interfacelessFeatureUsed", playerId, areaId, "skip")
                
                -- Aplicar delay se necessário
                if not options.noDelay then
                    local delayMs = config.entries[areaId].featureDelayWithControllerInterfaceClosedMs
                    if delayMs then
                        Wait(delayMs)
                    else
                        Wait(DEFAULT_DELAY_MS)
          end
        end
      end
            
            -- Verificar se há itens na fila
            if #areaQueue[areaId] > 0 then
                local nextMedia = areaQueue[areaId][1]
                table.remove(areaQueue[areaId], 1)
                
                -- Atualizar duração se URL for diferente
                if areaData[areaId].media.url ~= nextMedia.url then
                    areaData[areaId].media.duration = nextMedia.duration
                end
                
                -- Atualizar dados de mídia
                areaData[areaId].media.url = nextMedia.url
                areaData[areaId].media.thumbnailUrl = nextMedia.thumbnailUrl
                areaData[areaId].media.thumbnailTitle = nextMedia.thumbnailTitle
                areaData[areaId].media.title = nextMedia.title
                areaData[areaId].media.icon = nextMedia.icon
                areaData[areaId].media.time = 0
                
                -- Disparar evento de reprodução
                TriggerEvent("cs-hall:onPlay", areaId, playerId, {
                    media = {
                        url = areaData[areaId].media.url,
                        thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                        thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                        title = areaData[areaId].media.title,
                        icon = areaData[areaId].media.icon
                    }
                })
                
                -- Sincronizar dados
                SyncQueue(areaId)
                SyncData(areaId, nil, {
                    force = true
                })
            end
        end
    end
end)
-- Evento de reproduzir música da fila agora
RegisterNetEvent("cs-hall:queueNow")
AddEventHandler("cs-hall:queueNow", function(areaId, queueIndex)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            -- Verificar se índice da fila existe
            if areaQueue[areaId][queueIndex] then
                local selectedMedia = areaQueue[areaId][queueIndex]
                table.remove(areaQueue[areaId], queueIndex)
                
                -- Atualizar duração se URL for diferente
                if areaData[areaId].media.url ~= selectedMedia.url then
                    areaData[areaId].media.duration = selectedMedia.duration
                end
                
                -- Atualizar dados de mídia
                areaData[areaId].media.url = selectedMedia.url
                areaData[areaId].media.thumbnailUrl = selectedMedia.thumbnailUrl
                areaData[areaId].media.thumbnailTitle = selectedMedia.thumbnailTitle
                areaData[areaId].media.title = selectedMedia.title
                areaData[areaId].media.icon = selectedMedia.icon
                areaData[areaId].media.time = 0
                
                -- Iniciar reprodução
                if areaData[areaId].media.url then
                    if not areaData[areaId].media.playing then
                        areaData[areaId].media.playing = true
                        areaData[areaId].media.stopped = false
        end
      end
                
                -- Disparar evento de reprodução
                TriggerEvent("cs-hall:onPlay", areaId, playerId, {
                    media = {
                        url = areaData[areaId].media.url,
                        thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                        thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                        title = areaData[areaId].media.title,
                        icon = areaData[areaId].media.icon
                    }
                })
                
                -- Sincronizar dados
                SyncQueue(areaId)
                SyncData(areaId, nil, {
                    force = true
                })
        end
      end
end
end)
-- Evento de mover música na fila para próximo
RegisterNetEvent("cs-hall:queueNext")
AddEventHandler("cs-hall:queueNext", function(areaId, queueIndex)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            -- Verificar se pode mover para próximo
            if queueIndex < #areaQueue[areaId] then
                local currentItem = areaQueue[areaId][queueIndex]
                if currentItem then
                    -- Remover item da posição atual
                    table.remove(areaQueue[areaId], queueIndex)
                    -- Inserir na próxima posição
                    table.insert(areaQueue[areaId], queueIndex + 1, currentItem)
                end
                
                SyncQueue(areaId)
    end
  end
end
end)
-- Evento de remover música da fila
RegisterNetEvent("cs-hall:queueRemove")
AddEventHandler("cs-hall:queueRemove", function(areaId, queueIndex)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            -- Verificar se índice existe na fila
            if areaQueue[areaId][queueIndex] then
                local removedItem = areaQueue[areaId][queueIndex]
                
                -- Disparar evento de remoção
                TriggerEvent("cs-hall:onEntryRemoved", areaId, playerId, {
                    url = removedItem.url,
                    thumbnailUrl = removedItem.thumbnailUrl,
                    thumbnailTitle = removedItem.thumbnailTitle,
                    title = removedItem.title,
                    icon = removedItem.icon,
                    position = queueIndex
                })
                
                -- Remover item da fila
                table.remove(areaQueue[areaId], queueIndex)
                
                -- Sincronizar fila
                SyncQueue(areaId)
            end
        end
    end
end)
-- Evento de alternar configuração
RegisterNetEvent("cs-hall:toggleSetting")
AddEventHandler("cs-hall:toggleSetting", function(areaId, settingName)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            -- Alternar configuração específica
            if areaData[areaId].settings[settingName] ~= nil then
                areaData[areaId].settings[settingName] = not areaData[areaId].settings[settingName]
                
                -- Lógica especial para holofotes
                if areaData[areaId].settings.whiteSpotlights and areaData[areaId].settings.dynamicSpotlights then
                    if settingName == "whiteSpotlights" then
                        areaData[areaId].settings.dynamicSpotlights = false
                    elseif settingName == "dynamicSpotlights" then
                        areaData[areaId].settings.whiteSpotlights = false
  end
end
                
                -- Sincronizar dados
                SyncData(areaId)
            end
          end
        end
end)
-- Evento de acionar configuração específica
RegisterNetEvent("cs-hall:triggerSetting")
AddEventHandler("cs-hall:triggerSetting", function(areaId, settingName, options, value)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToControl(areaId, playerId) then
            SetController(areaId, playerId)
            
            -- Atualizar atualizador se necessário
            if areaData[areaId].updater ~= areaData[areaId].controller then
                RefreshCurrentUpdater(areaId)
            end
            
            if options then
                TriggerClientEvent("cs-hall:interfacelessFeatureUsed", playerId, areaId, settingName)
                
                -- Aplicar delay se necessário
                if not value then
                    local delayMs = config.entries[areaId].featureDelayWithControllerInterfaceClosedMs
                    if delayMs then
                        Wait(delayMs)
                    else
                        Wait(DEFAULT_DELAY_MS)
          end
        end
      end
            
            -- Processar configuração específica
            if settingName == "triggerSmoke" then
                -- Acionar fumaça para todos os jogadores na área
                for playerId, playerArea in pairs(playerControllers) do
                    if playerArea == areaId then
                        TriggerClientEvent("cs-hall:smoke", playerId, areaId, nil)
          end
        end
            elseif settingName == "triggerSparklers" then
                -- Acionar sparklers para todos os jogadores na área
                for playerId, playerArea in pairs(playerControllers) do
                    if playerArea == areaId then
                        TriggerClientEvent("cs-hall:sparklers", playerId, areaId, nil)
          end
        end
            elseif settingName == "screenControl" then
                if config.debug then
                    print("[debug] triggered setting screenControl", areaData[areaId].screens)
                end
                
                if areaData[areaId].screens then
                    if config.debug then
                        print("[debug] screens exist", areaData[areaId].screens.advancingAt, areaData[areaId].screens.retractingAt)
                    end
                    
                    -- Determinar ação baseada no estado atual das telas
                    if areaData[areaId].screens.advancingAt then
                        if not areaData[areaId].screens.retractingAt or 
                           areaData[areaId].screens.advancingAt < areaData[areaId].screens.retractingAt then
                            AdvanceScreens(areaId)
                        else
                            RetractScreens(areaId)
                        end
                    else
                        RetractScreens(areaId)
            end
          end
        end
      end
    end
end)
-- Evento de atualizar duração da mídia
RegisterNetEvent("cs-hall:duration")
AddEventHandler("cs-hall:duration", function(areaId, duration)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToUpdate(areaId, playerId) then
            if areaData[areaId].media.playing then
                areaData[areaId].media.duration = duration
                
                -- Disparar evento de duração atualizada
                TriggerEvent("cs-hall:onDuration", areaId, playerId, duration)
            end
        end
    end
end)
-- Evento de atualizar tempo da mídia
RegisterNetEvent("cs-hall:time")
AddEventHandler("cs-hall:time", function(areaId, time, forceUpdate)
    local playerId = source
    
    if areaData[areaId] and time then
        if IsAllowedToUpdate(areaId, playerId) then
            -- Atualizar tempo apenas se estiver tocando ou for forçado
            if areaData[areaId].media.playing or forceUpdate then
                areaData[areaId].media.time = time
                
                -- Ajustar tempo automaticamente se configurado
                local areaConfig = config.entries[areaId]
                if areaConfig.autoAdjustTime then
                    if areaData[areaId].media.duration then
                        if areaData[areaId].media.duration > 0 then
                            AdjustTime(areaId)
    end
  end
end
            end
          end
        end
end)
-- Evento de ativar fumaça
RegisterNetEvent("cs-hall:smoke")
AddEventHandler("cs-hall:smoke", function(areaId, intensity)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToUpdate(areaId, playerId) then
            local areaConfig = config.entries[areaId]
            if areaConfig.bass then
                if areaConfig.bass.smoke then
                    -- Verificar cooldown da fumaça
                    if areaData[areaId].smoke.lastTriggeredAt then
                        local currentTime = GetGameTimer()
                        local timeSinceLastTrigger = currentTime - areaData[areaId].smoke.lastTriggeredAt
                        local cooldownMs = areaConfig.bass.smoke.cooldownMs
                        
                        if timeSinceLastTrigger <= cooldownMs then
                            return -- Ainda em cooldown
      end
    end
                    
                    -- Atualizar timestamp da última ativação
                    areaData[areaId].smoke.lastTriggeredAt = GetGameTimer()
                    
                    -- Disparar evento para todos os players na área
                    for playerId, playerAreaId in pairs(playerAreas) do
                        if playerAreaId == areaId then
                            TriggerClientEvent("cs-hall:smoke", playerId, areaId, intensity)
  end
end
            end
          end
            end
          end
end)
-- Evento de ativar sparklers
RegisterNetEvent("cs-hall:sparklers")
AddEventHandler("cs-hall:sparklers", function(areaId, intensity)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToUpdate(areaId, playerId) then
            local areaConfig = config.entries[areaId]
            if areaConfig.bass then
                if areaConfig.bass.sparklers then
                    -- Verificar cooldown dos sparklers
                    if areaData[areaId].sparklers.lastTriggeredAt then
                        local currentTime = GetGameTimer()
                        local timeSinceLastTrigger = currentTime - areaData[areaId].sparklers.lastTriggeredAt
                        local cooldownMs = areaConfig.bass.sparklers.cooldownMs
                        
                        if timeSinceLastTrigger <= cooldownMs then
                            return -- Ainda em cooldown
        end
      end
                    
                    -- Atualizar timestamp da última ativação
                    areaData[areaId].sparklers.lastTriggeredAt = GetGameTimer()
                    
                    -- Disparar evento para todos os players na área
                    for playerId, playerAreaId in pairs(playerAreas) do
                        if playerAreaId == areaId then
                            TriggerClientEvent("cs-hall:sparklers", playerId, areaId, intensity)
    end
  end
                end
            end
          end
    end
end)
-- Evento de fim do controle de mídia
RegisterNetEvent("cs-hall:controllerEnded")
AddEventHandler("cs-hall:controllerEnded", function(areaId)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToUpdate(areaId, playerId) then
            if areaData[areaId].media.playing then
                -- Se estiver em loop, reiniciar a mídia
                if areaData[areaId].media.loop then
                    areaData[areaId].media.time = 0
                    
                    -- Disparar evento de play
                    TriggerEvent("cs-hall:onPlay", areaId, nil, {
                        url = areaData[areaId].media.url,
                        thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                        thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                        title = areaData[areaId].media.title,
                        icon = areaData[areaId].media.icon
                    })
                else
                    -- Verificar se há próxima mídia na fila
                    if #areaQueue[areaId] > 0 then
                        local nextMedia = areaQueue[areaId][1]
                        table.remove(areaQueue[areaId], 1)
                        
                        -- Atualizar duração se for uma mídia diferente
                        if areaData[areaId].media.url ~= nextMedia.url then
                            areaData[areaId].media.duration = nextMedia.duration
                        end
                        
                        -- Atualizar dados da mídia
                        areaData[areaId].media.url = nextMedia.url
                        areaData[areaId].media.thumbnailUrl = nextMedia.thumbnailUrl
                        areaData[areaId].media.thumbnailTitle = nextMedia.thumbnailTitle
                        areaData[areaId].media.title = nextMedia.title
                        areaData[areaId].media.icon = nextMedia.icon
                        areaData[areaId].media.time = 0
                        
                        -- Disparar evento de play
                        TriggerEvent("cs-hall:onPlay", areaId, nil, {
                            url = areaData[areaId].media.url,
                            thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                            thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                            title = areaData[areaId].media.title,
                            icon = areaData[areaId].media.icon
                        })
                        
                        -- Sincronizar fila
                        SyncQueue(areaId)
                    else
                        -- Não há próxima mídia, parar reprodução
                        TriggerEvent("cs-hall:onStop", areaId, nil, {
                            url = areaData[areaId].media.url,
                            thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                            thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                            title = areaData[areaId].media.title,
                            icon = areaData[areaId].media.icon
                        })
                        
                        -- Limpar dados da mídia
                        areaData[areaId].media.url = nil
                        areaData[areaId].media.thumbnailUrl = nil
                        areaData[areaId].media.thumbnailTitle = nil
                        areaData[areaId].media.title = nil
                        areaData[areaId].media.icon = nil
                        areaData[areaId].media.playing = false
                        areaData[areaId].media.stopped = true
                        areaData[areaId].media.time = 0
                        areaData[areaId].media.duration = nil
          end
        end
                
                -- Sincronizar dados
                SyncData(areaId, nil, {force = true})
      end
    end
  end
end)
-- Evento de erro no controle de mídia
RegisterNetEvent("cs-hall:controllerError")
AddEventHandler("cs-hall:controllerError", function(areaId)
    local playerId = source
    
    if areaData[areaId] then
        if IsAllowedToUpdate(areaId, playerId) then
            if areaData[areaId].media.playing then
                -- Verificar se há próxima mídia na fila
                if #areaQueue[areaId] > 0 then
                    local nextMedia = areaQueue[areaId][1]
                    table.remove(areaQueue[areaId], 1)
                    
                    -- Atualizar duração se for uma mídia diferente
                    if areaData[areaId].media.url ~= nextMedia.url then
                        areaData[areaId].media.duration = nextMedia.duration
                    end
                    
                    -- Atualizar dados da mídia
                    areaData[areaId].media.url = nextMedia.url
                    areaData[areaId].media.thumbnailUrl = nextMedia.thumbnailUrl
                    areaData[areaId].media.thumbnailTitle = nextMedia.thumbnailTitle
                    areaData[areaId].media.title = nextMedia.title
                    areaData[areaId].media.icon = nextMedia.icon
                    areaData[areaId].media.time = 0
                    
                    -- Disparar evento de play
                    TriggerEvent("cs-hall:onPlay", areaId, nil, {
                        url = areaData[areaId].media.url,
                        thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                        thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                        title = areaData[areaId].media.title,
                        icon = areaData[areaId].media.icon
                    })
                    
                    -- Sincronizar fila
                    SyncQueue(areaId)
                else
                    -- Não há próxima mídia, parar reprodução
                    TriggerEvent("cs-hall:onStop", areaId, nil, {
                        url = areaData[areaId].media.url,
                        thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                        thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                        title = areaData[areaId].media.title,
                        icon = areaData[areaId].media.icon
                    })
                    
                    -- Limpar dados da mídia
                    areaData[areaId].media.url = nil
                    areaData[areaId].media.thumbnailUrl = nil
                    areaData[areaId].media.thumbnailTitle = nil
                    areaData[areaId].media.title = nil
                    areaData[areaId].media.icon = nil
                    areaData[areaId].media.playing = false
                    areaData[areaId].media.stopped = true
                    areaData[areaId].media.time = 0
                    areaData[areaId].media.duration = nil
        end
      end
            
            -- Sincronizar dados
            SyncData(areaId, nil, {force = true})
    end
  end
end)
-- Evento de entrada em área de sincronização
RegisterNetEvent("cs-hall:enteredSyncArea")
AddEventHandler("cs-hall:enteredSyncArea", function(areaId)
    local playerId = source
    
    if areaData[areaId] then
        -- Verificar se o player não está em nenhuma área
        if not playerAreas[playerId] then
            -- Registrar player na área
            playerAreas[playerId] = areaId
            
            -- Atualizar updater se necessário
            if not areaData[areaId].updater then
                RefreshCurrentUpdater(areaId)
            end
            
            -- Sincronizar fila e dados com o player
            SyncQueue(areaId, playerId)
            SyncData(areaId, playerId, {force = true, entered = true})
        end
    end
end)
-- Evento de saída de área de sincronização
RegisterNetEvent("cs-hall:leftSyncArea")
AddEventHandler("cs-hall:leftSyncArea", function(areaId)
    local playerId = source
    
    if areaData[areaId] then
        -- Verificar se o player está nesta área
        if playerAreas[playerId] == areaId then
            -- Remover player da área
            playerAreas[playerId] = nil
            
            -- Limpar controle se o player for o controlador
            if areaData[areaId].controller == playerId then
                ClearController(areaId)
            end
            
            -- Atualizar updater se o player for o atualizador
            if areaData[areaId].updater == playerId then
                RefreshCurrentUpdater(areaId)
            end
        end
    end
end)
-- Evento de ressincronização
RegisterNetEvent("cs-hall:resync")
AddEventHandler("cs-hall:resync", function(areaId, force)
    local playerId = source
    
    if areaData[areaId] then
        -- Verificar se o player está nesta área
        if playerAreas[playerId] == areaId then
            -- Sincronizar dados com o player
            SyncData(areaId, playerId, {force = force})
    end
  end
end)
-- Evento de handshake servidor
RegisterNetEvent("cs-hall:server")
AddEventHandler("cs-hall:server", function()
    local playerId = source
    
    -- Enviar evento de handshake para o cliente
    TriggerClientEvent("cs-hall:client", playerId)
end)
-- Evento de busca de parâmetros
RegisterNetEvent("cs-hall:fetch")
AddEventHandler("cs-hall:fetch", function()
    local playerId = source
    
    -- Enviar parâmetros para o cliente
    TriggerClientEvent("cs-hall:params", playerId, 
        config.duiUrl, 
        GetResourceMetadata(GetCurrentResourceName(), "version", 0)
    )
end)
-- Evento de alternar interface do controlador
AddEventHandler("cs-hall:toggleControllerInterface", function(playerId, enabled)
    -- Verificar se o player está em alguma área
    if not playerAreas[playerId] then
    return
  end
    
    -- Atualizar estado da interface do controlador
    playerControllers[playerId] = enabled
    
    -- Disparar evento para o cliente
    TriggerClientEvent("cs-hall:cui", playerId, false)
end)
-- Evento de desabilitar interface do controlador
AddEventHandler("cs-hall:disallowControllerInterface", function(playerId)
    -- Verificar se o player está em alguma área
    if not playerAreas[playerId] then
    return
  end
    
    -- Remover estado da interface do controlador
    playerControllers[playerId] = nil
    
    -- Disparar evento para o cliente
    TriggerClientEvent("cs-hall:cui", playerId, true)
end)
-- Evento de desconexão do player
AddEventHandler("playerDropped", function(reason)
    local playerId = source
    
    -- Limpar dados do player
    playerControllers[playerId] = nil
    playerAreas[playerId] = nil
    
    -- Verificar se o player era controlador ou atualizador de alguma área
    for areaId, areaData in pairs(areaData) do
        -- Limpar controle se o player era o controlador
        if areaData.controller == playerId then
            ClearController(areaId)
        end
        
        -- Atualizar updater se o player era o atualizador
        if areaData.updater == playerId then
            RefreshCurrentUpdater(areaId)
        end
    end
end)
-- Evento de parada do recurso
AddEventHandler("onResourceStop", function(resourceName)
    -- Verificar se é este recurso
    if resourceName ~= GetCurrentResourceName() then
    return
  end
    
    -- Salvar dados se configurado
    if shouldSaveData then
        SetResourceKvp("data", json.encode(areaData))
        SetResourceKvp("queue", json.encode(areaQueue))
    end
end)
-- Thread principal de atualização de tempo
CreateThread(function()
  while true do
        -- Iterar por todas as áreas
        for areaId, areaData in pairs(areaData) do
            if areaData then
                -- Verificar se a mídia está tocando
                if areaData.media.playing then
                    -- Incrementar tempo
                    areaData.media.time = areaData.media.time + 1
                    
                    -- Verificar se a mídia terminou
                    if areaData.media.duration then
                        if areaData.media.duration > 0 then
                            -- Verificar se o tempo excedeu a duração (com margem de 15 segundos)
                            if areaData.media.time > areaData.media.duration + 15 then
                                -- Parar reprodução
                                areaData.media.playing = false
                                areaData.media.stopped = true
                                areaData.media.time = 0
                                
                                -- Verificar se há próxima mídia na fila
                                if #areaQueue[areaId] > 0 then
                                    local nextMedia = areaQueue[areaId][1]
                                    table.remove(areaQueue[areaId], 1)
                                    
                                    -- Atualizar duração se for uma mídia diferente
                                    if areaData.media.url ~= nextMedia.url then
                                        areaData.media.duration = nextMedia.duration
                                    end
                                    
                                    -- Atualizar dados da mídia
                                    areaData.media.url = nextMedia.url
                                    areaData.media.thumbnailUrl = nextMedia.thumbnailUrl
                                    areaData.media.thumbnailTitle = nextMedia.thumbnailTitle
                                    areaData.media.title = nextMedia.title
                                    areaData.media.icon = nextMedia.icon
                                    
                                    -- Disparar evento de play
                                    TriggerEvent("cs-hall:onPlay", areaId, nil, {
                                        url = areaData.media.url,
                                        thumbnailUrl = areaData.media.thumbnailUrl,
                                        thumbnailTitle = areaData.media.thumbnailTitle,
                                        title = areaData.media.title,
                                        icon = areaData.media.icon
                                    })
                                else
                                    -- Não há próxima mídia, parar reprodução
                                    TriggerEvent("cs-hall:onStop", areaId, nil, {
                                        url = areaData.media.url,
                                        thumbnailUrl = areaData.media.thumbnailUrl,
                                        thumbnailTitle = areaData.media.thumbnailTitle,
                                        title = areaData.media.title,
                                        icon = areaData.media.icon
                                    })
                                    
                                    -- Limpar dados da mídia
                                    areaData.media.url = nil
                                    areaData.media.thumbnailUrl = nil
                                    areaData.media.thumbnailTitle = nil
                                    areaData.media.title = nil
                                    areaData.media.icon = nil
                                    areaData.media.duration = nil
                                end
                                
                                -- Sincronizar fila e dados
                                SyncQueue(areaId)
                                SyncData(areaId, nil, {force = true})
              end
            end
          end
        end
      end
    end
        
        -- Aguardar 1 segundo
        Wait(1000)
    end
end)
-- Thread de ajuste automático de tempo
CreateThread(function()
  while true do
        -- Iterar por todas as áreas
        for areaId, areaData in pairs(areaData) do
            if areaData then
                -- Verificar se há duração definida
                if areaData.media.duration then
                    if areaData.media.duration > 0 then
                        local areaConfig = config.entries[areaId]
                        -- Verificar se o ajuste automático está habilitado
                        if areaConfig.autoAdjustTime then
                            -- Verificar se a mídia está tocando
                            if areaData.media.playing then
                                -- Ajustar tempo
                                AdjustTime(areaId)
              end
            end
          end
        end
      end
    end
        
        -- Aguardar 3 segundos
        Wait(3000)
    end
end)
-- Thread de salvamento automático de dados
CreateThread(function()
  while true do
        -- Verificar se há dados para salvar
        if shouldSaveData then
            shouldSaveData = false
            
            -- Salvar dados das áreas
            SetResourceKvpNoSync("data", json.encode(areaData))
            
            -- Salvar filas
            SetResourceKvpNoSync("queue", json.encode(areaQueue))
        end
        
        -- Aguardar 15 segundos
        Wait(15000)
    end
end)
-- Enviar eventos iniciais para todos os clientes
TriggerClientEvent("cs-hall:client", -1)
TriggerClientEvent("cs-hall:params", -1, 
    config.duiUrl, 
    GetResourceMetadata(GetCurrentResourceName(), "version", 0)
)
-- Export para reproduzir mídia em uma área
exports('Play', function(areaId)
    if not areaData[areaId] then
        error("[cs-hall] export Play: Unknown area provided.")
    return
  end
    
    local forceSync = false
    
    -- Verificar se há mídia na fila
    if #areaQueue[areaId] > 0 then
        -- Verificar se não há mídia atual
        if not areaData[areaId].media.url then
            local nextMedia = areaQueue[areaId][1]
            table.remove(areaQueue[areaId], 1)
            
            -- Atualizar duração se for uma mídia diferente
            if areaData[areaId].media.url ~= nextMedia.url then
                areaData[areaId].media.duration = nextMedia.duration
            end
            
            -- Atualizar dados da mídia
            areaData[areaId].media.url = nextMedia.url
            areaData[areaId].media.thumbnailUrl = nextMedia.thumbnailUrl
            areaData[areaId].media.thumbnailTitle = nextMedia.thumbnailTitle
            areaData[areaId].media.title = nextMedia.title
            areaData[areaId].media.icon = nextMedia.icon
            areaData[areaId].media.time = 0
            forceSync = true
    end
  end
    
    -- Verificar se há mídia para reproduzir
    if areaData[areaId].media.url then
        -- Verificar se não está tocando
        if not areaData[areaId].media.playing then
            areaData[areaId].media.playing = true
            areaData[areaId].media.stopped = false
    end
  end
    
    -- Disparar evento de play
    TriggerEvent("cs-hall:onPlay", areaId, nil, {
        url = areaData[areaId].media.url,
        thumbnailUrl = areaData[areaId].media.thumbnailUrl,
        thumbnailTitle = areaData[areaId].media.thumbnailTitle,
        title = areaData[areaId].media.title,
        icon = areaData[areaId].media.icon
    })
    
    -- Sincronizar fila e dados
    SyncQueue(areaId)
    SyncData(areaId, nil, {force = forceSync})
end)
-- Export para pausar mídia em uma área
exports('Pause', function(areaId)
    if not areaData[areaId] then
        error("[cs-hall] export Pause: Unknown area provided.")
    return
  end
    
    -- Verificar se está tocando
    if areaData[areaId].media.playing then
        areaData[areaId].media.playing = false
    end
    
    -- Disparar evento de pause
    TriggerEvent("cs-hall:onPause", areaId, source, {
        url = areaData[areaId].media.url,
        thumbnailUrl = areaData[areaId].media.thumbnailUrl,
        thumbnailTitle = areaData[areaId].media.thumbnailTitle,
        title = areaData[areaId].media.title,
        icon = areaData[areaId].media.icon
    })
    
    -- Sincronizar dados
    SyncData(areaId)
end)
-- Export para parar mídia em uma área
exports('Stop', function(areaId)
    if not areaData[areaId] then
        error("[cs-hall] export Stop: Unknown area provided.")
    return
  end
    
    -- Verificar se está tocando
    if areaData[areaId].media.playing then
        -- Disparar evento de stop
        TriggerEvent("cs-hall:onStop", areaId, source, {
            url = areaData[areaId].media.url,
            thumbnailUrl = areaData[areaId].media.thumbnailUrl,
            thumbnailTitle = areaData[areaId].media.thumbnailTitle,
            title = areaData[areaId].media.title,
            icon = areaData[areaId].media.icon
        })
    end
    
    -- Parar reprodução
    areaData[areaId].media.playing = false
    areaData[areaId].media.stopped = true
    areaData[areaId].media.time = 0
    areaData[areaId].media.duration = nil
    
    -- Sincronizar dados
    SyncData(areaId, nil, {force = true})
end)
-- Export para verificar se a mídia está tocando
exports('IsPlaying', function(areaId)
    if not areaData[areaId] then
        error("[cs-hall] export IsPlaying: Unknown area provided.")
    return
  end
    
    return areaData[areaId].media.playing
end)
-- Export para definir loop da mídia
exports('SetLoop', function(areaId, loop)
    if not areaData[areaId] then
        error("[cs-hall] export SetLoop: Unknown area provided.")
    return
  end
    
    areaData[areaId].media.loop = loop
    SyncData(areaId)
end)
-- Export para adicionar mídia à fila
exports('AddToQueue', function(areaId, url, thumbnailUrl, thumbnailTitle, title, icon, duration)
    -- Adicionar à fila
    table.insert(areaQueue[areaId], {
        url = url,
        thumbnailUrl = thumbnailUrl,
        thumbnailTitle = thumbnailTitle,
        title = title,
        icon = icon,
        duration = duration,
        manual = false
    })
    
    -- Disparar evento de entrada na fila
    TriggerEvent("cs-hall:onEntryQueued", areaId, source, {
        url = url,
        thumbnailUrl = thumbnailUrl,
        thumbnailTitle = thumbnailTitle,
        title = title,
        icon = icon,
        position = #areaQueue[areaId],
        duration = duration,
        manual = false
    })
    
    -- Sincronizar fila
    SyncQueue(areaId)
end)
-- Export para reproduzir mídia da fila agora
exports('QueueNow', function(areaId, position)
    if not areaData[areaId] then
        error("[cs-hall] export QueueNow: Unknown area provided.")
    return
  end
    
    local media = areaQueue[areaId][position]
    if media then
        -- Remover da fila
        table.remove(areaQueue[areaId], position)
        
        -- Atualizar duração se for uma mídia diferente
        if areaData[areaId].media.url ~= media.url then
            areaData[areaId].media.duration = media.duration
        end
        
        -- Atualizar dados da mídia
        areaData[areaId].media.url = media.url
        areaData[areaId].media.thumbnailUrl = media.thumbnailUrl
        areaData[areaId].media.thumbnailTitle = media.thumbnailTitle
        areaData[areaId].media.title = media.title
        areaData[areaId].media.icon = media.icon
        areaData[areaId].media.time = 0
        
        -- Disparar evento de play se estiver tocando
        if areaData[areaId].media.playing then
            TriggerEvent("cs-hall:onPlay", areaId, source, {
                url = areaData[areaId].media.url,
                thumbnailUrl = areaData[areaId].media.thumbnailUrl,
                thumbnailTitle = areaData[areaId].media.thumbnailTitle,
                title = areaData[areaId].media.title,
                icon = areaData[areaId].media.icon
            })
    end
  end
    
    -- Sincronizar fila e dados
    SyncQueue(areaId)
    SyncData(areaId, nil, {force = true})
end)
-- Export para remover mídia da fila
exports('RemoveFromQueue', function(areaId, position)
    if not areaData[areaId] then
        error("[cs-hall] export RemoveFromQueue: Unknown area provided.")
    return
  end
    
    local media = areaQueue[areaId][position]
    if media then
        -- Disparar evento de remoção da fila
        TriggerEvent("cs-hall:onEntryRemoved", areaId, source, {
            url = media.url,
            thumbnailUrl = media.thumbnailUrl,
            thumbnailTitle = media.thumbnailTitle,
            title = media.title,
            icon = media.icon,
            position = position,
            manual = media.manual
        })
        
        -- Remover da fila
        table.remove(areaQueue[areaId], position)
    end
    
    -- Sincronizar fila
    SyncQueue(areaId)
end)
-- Export para obter dados do player/mídia de uma área
exports('GetPlayer', function(areaId)
    if not areaData[areaId] then
        error("[cs-hall] export GetPlayer: Unknown area provided.")
    return
  end
    return areaData[areaId].media
end)
-- ===========================================
-- EXPORTS
-- ===========================================

-- Export para obter fila de uma área
exports('GetQueue', function(areaId)
    if not areaData[areaId] then
        error("[cs-hall] export GetQueue: Unknown area provided.")
    return
  end
    return areaQueue[areaId]
end)
