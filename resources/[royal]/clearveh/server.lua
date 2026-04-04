-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local tempoParaDeletar = 20 -- Tempo em MINUTOS
local veiculosVazios = {}    -- Tabela [NetID] = Timestamp

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO AUXILIAR: VERIFICA SE ESTÁ VAZIO (SERVER-SIDE SAFE)
-----------------------------------------------------------------------------------------------------------------------------------------
function isVehicleEmpty(veh)
    -- No Server-side, checamos os assentos principais (Motorista e passageiros comuns)
    -- O índice -1 é o motorista, 0 a 6 são passageiros.
    for i = -1, 6 do 
        local ped = GetPedInVehicleSeat(veh, i)
        if ped ~= 0 then
            return false -- Encontrou alguém (Player ou NPC)
        end
    end
    return true -- Ninguém encontrado nos assentos principais
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD PRINCIPAL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(10000) -- Verifica a cada 10 segundos
        
        local allVehicles = GetAllVehicles()
        local agora = os.time()

        for _, veh in ipairs(allVehicles) do
            if DoesEntityExist(veh) then
                -- Pegamos o Network ID para identificar este veículo específico na rede
                local netId = NetworkGetNetworkIdFromEntity(veh)
                
                if isVehicleEmpty(veh) then
                    -- Se não está na lista, começa a contar
                    if not veiculosVazios[netId] then
                        veiculosVazios[netId] = agora
                    else
                        -- Se já está, verifica o tempo
                        local tempoPassado = os.difftime(agora, veiculosVazios[netId])
                        
                        if tempoPassado >= (tempoParaDeletar * 60) then
                            DeleteEntity(veh)
                            veiculosVazios[netId] = nil
                        end
                    end
                else
                    -- Se alguém entrou, remove da contagem de deleção
                    if veiculosVazios[netId] then
                        veiculosVazios[netId] = nil
                    end
                end
            end
        end

        -- Limpeza de memória da tabela
        for id, _ in pairs(veiculosVazios) do
            local ent = NetworkGetEntityFromNetworkId(id)
            if not DoesEntityExist(ent) then
                veiculosVazios[id] = nil
            end
        end
    end
end)