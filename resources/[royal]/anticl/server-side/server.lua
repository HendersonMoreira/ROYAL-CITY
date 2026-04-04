    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRPS = Tunnel.getInterface("vRP")
    vRP = Proxy.getInterface("vRP")

-- Evento para registrar a saída do jogador e enviar o evento para todos os clientes
AddEventHandler("playerDropped", function(reason)
    local _source = source
    local passport = vRP.Passport(_source)  -- Obtenha o identificador do jogador (passport)

    if passport then
        print("Jogador deslogou: ID:", passport)

        local playerPed = GetPlayerPed(_source)
        local playerCoords = GetEntityCoords(playerPed)
        print("Coordenadas do jogador:", playerCoords)

        local logoutReason = reason or "Desconhecido"
        print("Motivo do logout:", logoutReason)

        -- Envia para todos os clientes a atualização
        TriggerClientEvent("update_log", -1, passport, {x = playerCoords.x, y = playerCoords.y, z = playerCoords.z}, logoutReason)
    else
        print("Erro: passaporte não encontrado para o jogador", _source)
    end
end)

RegisterCommand('versource', function(source, args)
    local Passport = vRP.Passport(source)

    if Passport and vRP.HasGroup(Passport, 'Admin') and args[1] then
        local OtherPassport = tonumber(args[1])

        if OtherPassport then
            local OtherSource = vRP.Source(OtherPassport)

            if not OtherSource then
                TriggerClientEvent('Notify',source, 'vermelho', 'Jogador não encontrado disponível', 5000)
            else
                TriggerClientEvent('Notify', source, 'verde', 'Source do jogador ' .. OtherPassport .. ' é: ' .. OtherSource, 10000)
            end
        end
    end
end)