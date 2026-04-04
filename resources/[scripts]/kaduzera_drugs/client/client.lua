local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("kaduzera_drugs",Kaduzera)
vSERVER = Tunnel.getInterface("kaduzera_drugs")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO DOS NPCS
-----------------------------------------------------------------------------------------------------------------------------------------
local npcs = {
    -- NPC de Heroina
    { x = -439.63, y = 6337.84, z = 12.72, h = 42.52, model = "g_m_y_salvagoon_01", drug = "heroina", name = "Vender Heroina" },
    -- NPC de Maconha
    { x = 1721.11, y = 3320.22, z = 41.21, h = 195.6, model = "g_m_y_strpunk_02", drug = "maconha", name = "Vender Maconha" },
    -- NPC de Crack
    { x = 2403.74, y = 3127.8, z = 48.16, h = 255.12, model = "a_m_y_methhead_01", drug = "crack", name = "Vender Crack" },
    -- NPC da Cocaína
    { x = 492.36, y = -507.23, z = 24.77, h = 266.46, model = "mp_m_cocaine_01", drug = "cocaine", name = "Vender Cocaína" },
    -- NPC do Metanfetamina
    { x = -412.79, y = -1683.52, z = 19.02, h = 65.2, model = "mp_f_meth_0", drug = "meth", name = "Vender Metanfetamina" },
    -- NPC da Super Droga
    { x = 2428.62, y = 4970.25, z = 42.34, h = 226.78, model = "ig_claypain", drug = "superdrug", name = "Super Droga" }
}

local inService = false
local currentBlip = nil
local currentStep = 1
local activeDrug = nil

local drugsRoute = {
    { 223.3,372.77,106.36,249.45 },
    { 210.15,25.48,79.19,161.58 },
    { 581.06,139.24,99.46,337.33 },
    { -152.46,286.94,93.75,8.51 },
    { -239.55,205.69,83.84,104.89 },
    { -207.21,159.7,74.05,249.45 },
    { -37.51,170.29,95.35,124.73 },
    { -605.8,-241.38,36.56,130.4 },
    { -567.52,-441.92,34.36,0.0 },
    { -428.09,-454.68,32.52,354.34 },
    { -1066.27,-503.8,36.06,238.12 },
    { -1141.3,-433.22,35.94,107.72 },
    { 352.65,-142.83,66.69,158.75 },
    { -476.63,217.61,83.69,181.42 },
    { -570.61,310.9,84.48,178.59 },
    { -742.76,247.19,77.32,28.35 },
    { -333.3,103.09,67.62,82.21 },
    { -196.2,16.77,56.31,334.49 },
    { 14.34,84.45,74.66,68.04 },
    { -429.46,1109.49,327.68,161.58  },
    { -50.25,1911.26,195.71,274.97  },
    { -126.02,1896.57,197.33,2.84 },
    { 225.29,1170.52,225.99,102.05 },
    { 386.96,792.48,187.69,357.17 },
    { 490.37,-95.47,66.44,79.38 },
    { 406.26,91.22,101.3,133.23 },
    { 436.2,214.63,103.15,133.23 },
    { -1470.75,-135.67,51.09,201.26 },
    { -1377.25,-360.47,36.6,28.35 },
    { -849.01,-589.76,29.22,306.15 },
    { 814.91,-109.54,80.59,235.28 },
    { -794.54,351.59,87.99,181.42 },
    { 1532.04,1728.02,109.91,289.14 },
    { 1249.18,-350.51,69.2,167.25 },
    { -783.53,-390.69,37.32,337.33 },
    { -1551.53,210.16,58.86,119.06 },
    { -441.29,1595.2,358.46,28.35 },
    { 15.01,379.17,112.46,0.0 },
    { -197.38,-831.28,30.75,130.4 },
    { -1660.35,-534.02,36.02,325.99 },
    { -274.0,28.65,54.74,8.51 },
    { -73.23,80.68,71.61,161.58 },
    { 1168.81,-291.49,69.02,144.57 },
    { 1082.62,-787.46,58.35,0.0 },
    { 802.71,2174.93,53.06,155.91 },
    { 1211.27,1857.43,78.97,223.94 },
    { 1086.94,243.79,81.18,141.74 },
    { -369.19,83.61,62.92,5.67 },
    { 227.36,-284.16,49.72,255.12 },
    { -992.88,-281.67,38.18,17.01 }
}

local function DrawText3D(x,y,z,text)
    SetTextFont(4)
    SetTextCentre(1)
    SetTextEntry("STRING")
    SetTextScale(0.35,0.35)
    SetTextColour(64,224,208,150)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z,0)
    DrawText(0.0,0.0)
    local factor = (string.len(text) / 450) + 0.03
    DrawRect(0.0,0.0145,factor,0.03,40,36,52,240)
    ClearDrawOrigin()
end

local function createBlip(pos)
    if currentBlip then RemoveBlip(currentBlip) end
    currentBlip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(currentBlip,310)
    SetBlipColour(currentBlip,27)
    SetBlipScale(currentBlip,0.9)
    SetBlipAsShortRange(currentBlip,false)
    SetBlipRoute(currentBlip,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Entrega de "..activeDrug:upper())
    EndTextCommandSetBlipName(currentBlip)
end

Citizen.CreateThread(function()
    for k,v in pairs(npcs) do
        local hash = GetHashKey(v.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do Wait(10) end

        local ped = CreatePed(4, hash, v.x, v.y, v.z - 1.0, v.h, false, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetModelAsNoLongerNeeded(hash)
    end
end)

local function loadServiceThread()
    Citizen.CreateThread(function()
        while inService do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local distance = #(coords - vec3(drugsRoute[currentStep][1],drugsRoute[currentStep][2],drugsRoute[currentStep][3]))
            
            if distance <= 10 then
                DrawText3D(drugsRoute[currentStep][1],drugsRoute[currentStep][2],drugsRoute[currentStep][3],"~p~E~w~  ENTREGAR")
                
                if distance <= 2 then
                    if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                        -- Aqui enviamos qual droga o jogador está vendendo pro Servidor
                        if vSERVER.reward(activeDrug) then
                            RemoveBlip(currentBlip)

                            currentStep = currentStep + 1
                            if currentStep >= #drugsRoute then
                                currentStep = 1
                            end

                            createBlip({ drugsRoute[currentStep][1],drugsRoute[currentStep][2],drugsRoute[currentStep][3] })
                        end
                    end
                end
            end
            Citizen.Wait(4)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for k,v in pairs(npcs) do
            local distance = #(coords - vec3(v.x, v.y, v.z))
            if distance <= 3.0 then
                time = 4
                
                if not inService then
                    DrawText3D(v.x, v.y, v.z + 1.0, "~g~E~w~ INICIAR ROTAS: ~y~" .. v.name:upper())
                    
                    if IsControlJustPressed(0,38) then
                        activeDrug = v.drug
                        inService = true
                        currentStep = math.random(1, #drugsRoute)
                        TriggerEvent("Notify","verde","Rotas de <b>"..activeDrug:upper().."</b> ativadas.",5000)
                        createBlip({ drugsRoute[currentStep][1],drugsRoute[currentStep][2],drugsRoute[currentStep][3] })
                        loadServiceThread()
                    end
                else
                    DrawText3D(v.x, v.y, v.z + 1.0, "~r~E~w~ CANCELAR ROTAS")
                    
                    if IsControlJustPressed(0,38) then
                        inService = false
                        activeDrug = nil
                        if currentBlip then
                            RemoveBlip(currentBlip)
                            currentBlip = nil
                        end
                        TriggerEvent("Notify","vermelho","Rotas desativadas.",5000)
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)