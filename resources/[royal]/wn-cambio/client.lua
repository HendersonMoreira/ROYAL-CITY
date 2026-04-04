local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local src = {}
Tunnel.bindInterface("wn_cambio",src)
vSERVER = Tunnel.getInterface("wn_cambio")

local nuiOpen = false
local currentLocation = nil

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAW TEXT 3D
-----------------------------------------------------------------------------------------------------------------------------------------
local function DrawText3D(x,y,z,text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    if onScreen then
        SetTextFont(4)
        SetTextScale(0.35,0.35)
        SetTextColour(255,255,255,215)
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 999
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if not nuiOpen then
            for _,v in pairs(Config.Locations) do
                local distance = #(coords - v.coords)

                if distance <= Config.DrawDistance then
                    timeDistance = 1

                    if distance <= Config.InteractDistance then
                        DrawText3D(v.coords.x,v.coords.y,v.coords.z + 0.15,Config.Texts.target)

                        if IsControlJustPressed(0,Config.OpenKey) then
                            local allowed = vSERVER.CheckPermission(v.id)
                            if allowed then
                                currentLocation = v.id
                                nuiOpen = true
                                SetNuiFocus(true,true)

                                local requiredItemsText = "Nenhum"
                                if v.requiredItems and #v.requiredItems > 0 then
                                    local list = {}
                                    for _,item in ipairs(v.requiredItems) do
                                        local itemAmount = tonumber(item.amount or 1) or 1
                                        list[#list + 1] = string.format("%sx %s",itemAmount,item.label or item.item)
                                    end
                                    requiredItemsText = table.concat(list,", ")
                                elseif v.requiredItem and v.requiredItem ~= "" then
                                    requiredItemsText = string.format("%sx %s",tonumber(v.requiredAmount or 1) or 1,v.requiredItemLabel or v.requiredItem)
                                end

                                SendNUIMessage({
                                    action = "open",
                                    location = {
                                        id = v.id,
                                        name = v.name,
                                        fromLabel = v.fromLabel,
                                        toLabel = v.toLabel,
                                        rate = v.rate,
                                        minAmount = v.minAmount,
                                        step = v.step,
                                        requiredItem = v.requiredItem,
                                        requiredItemLabel = v.requiredItemLabel,
                                        requiredAmount = v.requiredAmount,
                                        consumeRequiredItem = v.consumeRequiredItem,
                                        requiredItems = v.requiredItems,
                                        requiredItemsText = requiredItemsText
                                    }
                                })
                            else
                                TriggerEvent("Notify","vermelho",Config.Texts.noPermission,5000)
                            end
                        end
                    end
                end
            end
        end

        Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data,cb)
    SetNuiFocus(false,false)
    nuiOpen = false
    currentLocation = nil
    cb("ok")
end)

RegisterNUICallback("preview",function(data,cb)
    if not currentLocation then
        cb({ ok = false })
        return
    end

    local amount = tonumber(data.amount) or 0
    local result = vSERVER.Preview(currentLocation,amount)
    cb(result)
end)

RegisterNUICallback("exchange",function(data,cb)
    if not currentLocation then
        cb({ ok = false, message = "Local inválido." })
        return
    end

    local amount = tonumber(data.amount) or 0
    local result = vSERVER.Exchange(currentLocation,amount)

    if result and result.ok then
        TriggerEvent("Notify","verde",result.message or Config.Texts.success,5000)
    else
        TriggerEvent("Notify","vermelho",(result and result.message) or "Erro ao realizar troca.",5000)
    end

    cb(result or { ok = false })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESC FECHA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 999

        if nuiOpen then
            timeDistance = 1

            DisableControlAction(0,1,true)
            DisableControlAction(0,2,true)
            DisableControlAction(0,142,true)
            DisableControlAction(0,18,true)
            DisableControlAction(0,322,true)
            DisableControlAction(0,106,true)

            if IsControlJustPressed(0,322) then
                SetNuiFocus(false,false)
                nuiOpen = false
                currentLocation = nil
                SendNUIMessage({ action = "close" })
            end
        end

        Wait(timeDistance)
    end
end)