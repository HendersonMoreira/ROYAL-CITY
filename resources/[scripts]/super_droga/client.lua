RegisterNetEvent("super_droga:efeitos")
AddEventHandler("super_droga:efeitos", function()
    local ped = PlayerPedId()
    local player = PlayerId()

    -- 1. Aumentar a Vida (+50 de vida)
    local health = GetEntityHealth(ped)
    SetEntityHealth(ped, math.min(health + 50, 200))

    -- 2. Aumentar o Colete (+50 de colete)
    local armor = GetPedArmour(ped)
    SetPedArmour(ped, math.min(armor + 50, 100))

    -- 3. Aumentar a Velocidade (1.3x)
    SetRunSprintMultiplierForPlayer(player, 1.3)
    SetSwimMultiplierForPlayer(player, 1.3)

    TriggerEvent("Notify", "verde", "Super Droga consumida! Velocidade e resistência aumentadas por 90 segundos.", 5000)

    -- 4. Timer de 90 Segundos (90000 ms) para voltar ao normal
    Citizen.SetTimeout(90000, function()
        -- Reseta a velocidade para o padrão (1.0)
        SetRunSprintMultiplierForPlayer(player, 1.0)
        SetSwimMultiplierForPlayer(player, 1.0)
        
        TriggerEvent("Notify", "amarelo", "Os efeitos da Super Droga passaram.", 5000)
    end)
end)