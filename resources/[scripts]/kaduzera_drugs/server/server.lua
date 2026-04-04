local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Kaduzera = {}
Tunnel.bindInterface("kaduzera_drugs",Kaduzera)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO DRUGS QUE PODERÁ SER VENDIDA
-----------------------------------------------------------------------------------------------------------------------------------------
local DrugsList = {
    ["heroina"] = {
        ["price"] = 300,
        ["rand"] = { 1, 3 }
    },
    ["maconha"] = {
        ["price"] = 300,
        ["rand"] = { 1, 3 }
    },
    ["crack"] = {
        ["price"] = 300,
        ["rand"] = { 1, 3 }
    },
    ["cocaine"] = {
        ["price"] = 300,
        ["rand"] = { 1, 3 }
    },
    ["meth"] = {
        ["price"] = 300,
        ["rand"] = { 1, 3 }
    },
    ["superdrug"] = {
        ["price"] = 600,
        ["rand"] = { 1, 2 }
    }
}

function Kaduzera.reward(drugType)
    local source = source
    local Passport = vRP.Passport(source)
    
    if Passport and drugType and DrugsList[drugType] then
        local v = DrugsList[drugType]
        local random = math.random(v.rand[1],v.rand[2])
        local consultItem = vRP.InventoryItemAmount(Passport, drugType)
        
        if consultItem[1] >= parseInt(random) then
            vRPC.CreateObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
            TriggerClientEvent("Progress",source,"Vendendo",5000)
            Citizen.Wait(5000)
            
            -- Tenta tirar exatamente a droga que o jogador escolheu vender no NPC
            if vRP.TakeItem(Passport, drugType, random, true) then
                TriggerClientEvent("sounds:source",source,"cash",0.05)
                
                local randomPlusPrice = v.price * random
                
                vRP.GenerateItem(Passport,"dirtydollar",randomPlusPrice,true)
                
                vRP.UpgradeStress(Passport,2)
                vRPC.Destroy(source)

                if math.random(100) <= 95 then
                    local ped = GetPlayerPed(source)
                    local coords = GetEntityCoords(ped)
                
                    local policeResult = vRP.NumPermission("Police")
                    for k,vPol in pairs(policeResult) do
                        async(function()
                            TriggerClientEvent("NotifyPush",vPol,{ code = "QRU", title = "Venda de Drogas", x = coords["x"], y = coords["y"], z = coords["z"], time = "Recebido às "..os.date("%H:%M"), blipColor = 5 })
                        end)
                    end
                end

                return true
            end
        else
            TriggerClientEvent("Notify", source, "vermelho", "Você não tem <b>"..drugType.."</b> suficiente.", 5000)
        end
    end
    return false
end