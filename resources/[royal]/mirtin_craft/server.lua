local function parseInt(value)
    value = tonumber(value)
    if value then
        return math.floor(value)
    end
    return 0
end

local function toInventoryAmount(value)
    if type(value) == "table" then
        return tonumber(value[1] or value.amount or value.quantidade or value["amount"] or 0) or 0
    end

    return tonumber(value) or 0
end

local function safeStr(value, default)
	if value == nil then
		return default or "Desconhecido"
	end
	return tostring(value)
end


local function GetUserId(source)
    if not source then return nil end

    if vRP then
        if vRP.Passport then
            local ok,id = pcall(vRP.Passport, source)
            if ok and id then return id end
        end

        if vRP.getUserId then
            local ok,id = pcall(vRP.getUserId, source)
            if ok and id then return id end
        end

        if vRP.UserId then
            local ok,id = pcall(vRP.UserId, source)
            if ok and id then return id end
        end
    end

    return nil
end


local block_fabricar = {}
local fabricando = {}
local delay = {}

local playerCraft = {}
local itemAmount = {}
local itemTime = {}

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.craftItem = function(craftid, item, spawnID, amount)
    local source = source
    local user_id = GetUserId(source)
    if user_id then

        local idCraft = craftid        
        if delay[idCraft] ~= nil then
            config.lang['waitCraft'](source, delay[idCraft])
            return
        end

        if fabricando[user_id] then
            config.lang['fabricandoItem'](source)
            return
        end

        if config.table[tostring(idCraft)].isDominas then -- SE A ZONA FOR DOMINACAO ( OBRIGADO ARMAZEM )
            local craft = config.table[tostring(idCraft)]
            if craft.armazem then
                delay[idCraft] = config.delayCraft

                spawnID = config.table[tostring(idCraft)].craft[tostring(item)].spawnID or false
            
                if not spawnID then
                    print("error")
                    return
                end
    
                playerCraft[user_id] = {
                    idItem = item,
                    idSpawn = spawnID,
                    idAmount = amount
                }

                local groupID = vRP.getUserGroupOrg(user_id)
                if groupID then
                    local data = vRP.getSData("armazem:"..groupID)
                    local items = json.decode(data) or {}

                    if items then
                        local checkItem = craft.craft[playerCraft[user_id].idItem]
                        if checkItem ~= nil then
                            local canCarry = src.checkInventoryWeight(user_id, playerCraft[user_id].idSpawn, playerCraft[user_id].idAmount)
                            if not canCarry then
                                config.lang['backpackFull'](source)
                                return
                            end

                            local getItens = checkItem.requires
                            local mensagem = ""

                            for k,v in pairs(getItens) do
                                requireItem = v.item
                                requireAmount = parseInt(v.amount * playerCraft[user_id].idAmount)

                                if items[tostring(requireItem)] ~= nil then
                                    itemAmount[user_id] = items[tostring(requireItem)].amount

                                    if itemAmount[user_id] < requireAmount then
                                        block_fabricar[parseInt(user_id)] = true
                                        mensagem = mensagem.."Item: <b>"..safeStr(src.getItemName(requireItem), safeStr(requireItem, "Item")).. "</b> na quantidade <b>"..itemAmount[user_id].."/"..requireAmount.."</b><br>"
                                    end
                                else
                                    if items[tostring(requireItem)] == nil then
                                        itemAmount[user_id] = 0
                                    end

                                    block_fabricar[parseInt(user_id)] = true
                                    mensagem = mensagem.."Item: <b>"..safeStr(src.getItemName(requireItem), safeStr(requireItem, "Item")).. "</b> na quantidade <b>"..itemAmount[user_id].."/"..requireAmount.."</b><br>"
                                end
                            end

                            if not block_fabricar[parseInt(user_id)] then
                                for k,v in pairs(getItens) do
                                    requireItem = v.item
                                    requireAmount = parseInt(v.amount * playerCraft[user_id].idAmount)
                                    itemAmount[user_id] = items[tostring(requireItem)].amount

                                    if itemAmount[user_id] >= requireAmount then
                                        items[tostring(requireItem)].amount =  itemAmount[user_id] - requireAmount

                                        if itemAmount[user_id] <= 0 then
                                            itemAmount[user_id] = 0
                                        end
                                    else
                                        block_fabricar[parseInt(user_id)] = true
                                    end
                                end

                                if not block_fabricar[parseInt(user_id)] then
                                    itemAmount[user_id] = checkItem.customAmount * playerCraft[user_id].idAmount
                                    itemTime[user_id] = checkItem.tempo * playerCraft[user_id].idAmount

                                    corpoHook = { { ["color"] = config.weebhook['color'], ["title"] = "**".. ":man_construction_worker: | Craft de Item " .."**\n", ["thumbnail"] = { ["url"] = config.weebhook['logo'] }, ["description"] = "**USER_ID:**\n```cs\n"..user_id.."```\n**CRAFTOU:** ```css\n".. safeStr(src.getItemName(playerCraft[user_id].idSpawn), safeStr(playerCraft[user_id].idSpawn, "Item")) .." " .. safeStr(parseInt(itemAmount[user_id]), "0") .."x```\n**MESA:**\n ```cs\n"..safeStr(idCraft, "Mesa desconhecida").."```", ["footer"] = { ["text"] = config.weebhook['footer'], }, } }

                                    if itemTime[user_id] == 0 then
                                        src.giveInventoryItem(user_id, playerCraft[user_id].idSpawn, itemAmount[user_id])
                                        sendToDiscord(craft.weebhook, corpoHook)
                                    else
                                        src.progressBar(user_id, itemTime[user_id])
                                        src.playAnim(source, checkItem.anim[1],checkItem.anim[2])
                                        fabricando[user_id] = true

                                        SetTimeout(itemTime[user_id]*1000, function() 
                                            fabricando[user_id] = nil
                                            src.giveInventoryItem(user_id, playerCraft[user_id].idSpawn, itemAmount[user_id])
                                            src.stopAnim(source)
                                            vCLIENT._blockAnimation(source, checkItem.anim, itemTime[user_id], false)
                                            
                                            sendToDiscord(craft.weebhook, corpoHook)
                                        end)

                                        vCLIENT._blockAnimation(source, checkItem.anim, itemTime[user_id], true)
                                    end

                                    vRP.setSData("armazem:"..groupID, json.encode(items))
                                else
                                    config.lang['erroFabricar'](source)
                                end
                            end

                            if mensagem ~= "" then
                                config.lang['notArmazemItem'](source, mensagem, "armazem")
                            end

                            block_fabricar[parseInt(user_id)] = nil
                        else
                            print("Erro: O Item "..item.." não foi encontrado na mesa ("..safeStr(idCraft, "Mesa desconhecida").. ").")
                        end
                    end
                else
                    print("Erro: Armazem ("..safeStr(idCraft, "Mesa desconhecida").. ") grupo não encontrado ( "..groupID.." ).")
                end
            end
        else -- SE FOR CRAFT NORMAL
            local craft = config.table[tostring(idCraft)]
            if craft ~= nil then
                delay[idCraft] = config.delayCraft
    
                playerCraft[user_id] = {
                    idItem = item,
                    idSpawn = spawnID,
                    idAmount = amount
                }
                
                if craft.armazem then
                    if config.armazemLocations[idCraft] then
                        local data = vRP.getSData("armazem:"..idCraft)
                        local items = json.decode(data) or {}
                        if items then
                            local checkItem = craft.craft[playerCraft[user_id].idItem]
                            if checkItem ~= nil then
                                if fabricando[user_id] then
                                    config.lang['fabricandoItem'](source)
                                    return
                                end
    
                                if not src.checkInventoryWeight(user_id, playerCraft[user_id].idSpawn, playerCraft[user_id].idAmount) then
                                    config.lang['backpackFull'](source)
                                    return
                                end
    
                                local getItens = checkItem.requires
                                local mensagem = ""
    
                                for k,v in pairs(getItens) do
                                    requireItem = v.item
                                    requireAmount = parseInt(v.amount * playerCraft[user_id].idAmount)
    
                                    if items[tostring(requireItem)] ~= nil then
                                        itemAmount[user_id] = items[tostring(requireItem)].amount
    
                                        if itemAmount[user_id] < requireAmount then
                                            block_fabricar[parseInt(user_id)] = true
                                            mensagem = mensagem.."Item: <b>"..safeStr(src.getItemName(requireItem), safeStr(requireItem, "Item")).. "</b> na quantidade <b>"..itemAmount[user_id].."/"..requireAmount.."</b><br>"
                                        end
                                    else
                                        if items[tostring(requireItem)] == nil then
                                            itemAmount[user_id] = 0
                                        end
    
                                        block_fabricar[parseInt(user_id)] = true
                                        mensagem = mensagem.."Item: <b>"..safeStr(src.getItemName(requireItem), safeStr(requireItem, "Item")).. "</b> na quantidade <b>"..itemAmount[user_id].."/"..requireAmount.."</b><br>"
                                    end
                                end
    
                                if not block_fabricar[parseInt(user_id)] then
                                    for k,v in pairs(getItens) do
                                        requireItem = v.item
                                        requireAmount = parseInt(v.amount * playerCraft[user_id].idAmount)
                                        itemAmount[user_id] = items[tostring(requireItem)].amount
    
                                        if itemAmount[user_id] >= requireAmount then
                                            items[tostring(requireItem)].amount =  itemAmount[user_id] - requireAmount
    
                                            if itemAmount[user_id] <= 0 then
                                                itemAmount[user_id] = 0
                                            end
                                        else
                                            block_fabricar[parseInt(user_id)] = true
                                        end
                                    end
    
                                    if not block_fabricar[parseInt(user_id)] then
                                        itemAmount[user_id] = checkItem.customAmount * playerCraft[user_id].idAmount
                                        itemTime[user_id] = checkItem.tempo * playerCraft[user_id].idAmount
    
                                        corpoHook = { { ["color"] = config.weebhook['color'], ["title"] = "**".. ":man_construction_worker: | Craft de Item " .."**\n", ["thumbnail"] = { ["url"] = config.weebhook['logo'] }, ["description"] = "**USER_ID:**\n```cs\n"..user_id.."```\n**CRAFTOU:** ```css\n".. safeStr(src.getItemName(playerCraft[user_id].idSpawn), safeStr(playerCraft[user_id].idSpawn, "Item")) .." " .. safeStr(parseInt(itemAmount[user_id]), "0") .."x```\n**MESA:**\n ```cs\n"..safeStr(idCraft, "Mesa desconhecida").."```", ["footer"] = { ["text"] = config.weebhook['footer'], }, } }
    
                                        if itemTime[user_id] == 0 then
                                            src.giveInventoryItem(user_id, playerCraft[user_id].idSpawn, itemAmount[user_id])
                                            sendToDiscord(craft.weebhook, corpoHook)
                                        else
                                            src.progressBar(user_id, itemTime[user_id])
                                            src.playAnim(source, checkItem.anim[1],checkItem.anim[2])
                                            fabricando[user_id] = true
    
                                            SetTimeout(itemTime[user_id]*1000, function() 
                                                fabricando[user_id] = nil
                                                src.giveInventoryItem(user_id, playerCraft[user_id].idSpawn, itemAmount[user_id])
                                                src.stopAnim(source)
                                                vCLIENT._blockAnimation(source, checkItem.anim, itemTime[user_id], false)
                                                
                                                sendToDiscord(craft.weebhook, corpoHook)
                                            end)
    
                                            vCLIENT._blockAnimation(source, checkItem.anim, itemTime[user_id], true)
                                        end
    
                                        vRP.setSData("armazem:"..idCraft, json.encode(items))
                                    else
                                        config.lang['erroFabricar'](source)
                                    end
                                end
    
                                if mensagem ~= "" then
                                    config.lang['notArmazemItem'](source, mensagem, "armazem")
                                end
    
                                block_fabricar[parseInt(user_id)] = nil
                            else
                                print("Erro: O Item "..item.." não foi encontrado na mesa ("..safeStr(idCraft, "Mesa desconhecida").. ").")
                            end
                        end
                    else
                        print("Erro: Armazem ("..safeStr(idCraft, "Mesa desconhecida").. ") não foi encontrada.")
                    end
                else
                    local checkItem = craft.craft[playerCraft[user_id].idItem]
                    if checkItem ~= nil then
                        if fabricando[user_id] then
                            config.lang['fabricandoItem'](source)
                            return
                        end
                        
                        local canCarry = src.checkInventoryWeight(user_id, playerCraft[user_id].idSpawn, playerCraft[user_id].idAmount)
                        if not canCarry then
                            config.lang['backpackFull'](source)
                            return
                        end
    
                        local getItens = checkItem.requires
                        local mensagem = ""
    
                        for k,v in pairs(getItens) do
                            requireItem = v.item
                            requireAmount = parseInt(v.amount * playerCraft[user_id].idAmount)
    
                            local amount = toInventoryAmount(src.getInventoryItemAmount(user_id, requireItem))
                            if amount < requireAmount then
                                mensagem = mensagem.."Item: <b>"..safeStr(src.getItemName(requireItem), safeStr(requireItem, "Item")).. "</b> na quantidade <b>"..amount.."/"..requireAmount.."</b><br>"
                                block_fabricar[parseInt(user_id)] = true
                            end
                        end
    
                        if not block_fabricar[parseInt(user_id)] then
                            for k,v in pairs(getItens) do
                                requireItem = v.item
                                requireAmount = parseInt(v.amount * playerCraft[user_id].idAmount)
                               
                                local amount = toInventoryAmount(src.getInventoryItemAmount(user_id, requireItem))
                                if amount >= requireAmount then
                                    src.tryGetInventoryItem(user_id, requireItem, requireAmount)
                                else
                                    block_fabricar[parseInt(user_id)] = true
                                end
                            end
    
                            if not block_fabricar[parseInt(user_id)] then
                                itemAmount[user_id] = checkItem.customAmount * playerCraft[user_id].idAmount
                                itemTime[user_id] = checkItem.tempo * playerCraft[user_id].idAmount
    
                                corpoHook = { { ["color"] = config.weebhook['color'], ["title"] = "**".. ":man_construction_worker: | Craft de Item " .."**\n", ["thumbnail"] = { ["url"] = config.weebhook['logo'] }, ["description"] = "**USER_ID:**\n```cs\n"..user_id.."```\n**CRAFTOU:** ```css\n".. safeStr(src.getItemName(playerCraft[user_id].idSpawn), safeStr(playerCraft[user_id].idSpawn, "Item")) .." " .. safeStr(parseInt(itemAmount[user_id]), "0") .."x```\n**MESA:**\n ```cs\n"..safeStr(idCraft, "Mesa desconhecida").."```\n**DATA:** ```cs\n"..os.date("\n%d/%m/%Y as %H:%M:%S").."```", ["footer"] = { ["text"] = config.weebhook['footer'], }, } }
    
                                if itemTime[user_id] == 0 then
                                    src.giveInventoryItem(user_id, playerCraft[user_id].idSpawn, itemAmount[user_id])
                                    sendToDiscord(craft.weebhook, corpoHook)
                                else
                                    src.progressBar(user_id, itemTime[user_id])
                                    src.playAnim(source, checkItem.anim[1],checkItem.anim[2])
                                    fabricando[user_id] = true
    
                                    SetTimeout(itemTime[user_id]*1000, function() 
                                        fabricando[user_id] = nil
                                        src.giveInventoryItem(user_id, playerCraft[user_id].idSpawn, itemAmount[user_id])
                                        src.stopAnim(source)
                                        vCLIENT._blockAnimation(source, checkItem.anim, itemTime[user_id], false)
                                        
                                        sendToDiscord(craft.weebhook, corpoHook)
                                    end)
    
                                    vCLIENT._blockAnimation(source, checkItem.anim, itemTime[user_id], true)
                                end
    
                            else
                                config.lang['erroFabricar'](source)
                            end
                        end
    
                        if mensagem ~= "" then
                            config.lang['notArmazemItem'](source, mensagem, "pessoal")
                        end
    
                        block_fabricar[parseInt(user_id)] = nil
                    end
                end
            else
                print("Erro: Mesa de Craft ("..safeStr(idCraft, "Mesa desconhecida").. ") não foi encontrada.")
            end
        end
    end
end

src.getItensArmazem = function(tipo)
    local source = source
    local user_id = GetUserId(source)
    if user_id then
        local data = vRP.getSData("armazem:"..tipo)
        local items = json.decode(data) or {}
        local mensagem = ""

        if items then
            for k,v in pairs(items) do
                mensagem = mensagem.."Item: <b>"..safeStr(src.getItemName(k), safeStr(k, "Item")).."</b> Quantidade: <b>"..v.amount.."x</b><br> "
            end

            if mensagem == "" then
                config.lang['notArmazemItens'](source)
                return
            end

            config.lang['armazemItens'](source, mensagem)
        end
    end
end

src.guardarItensArmazem = function(tipo)
    local source = source
    local user_id = GetUserId(source)
    if user_id then
        if config.table[tostring(tipo)] ~= nil then
            local craft = config.table[tostring(tipo)].craft
            local itensArmazem = {}
            local mensagem = ""
            local storeMensagem = ""

            for k,v in pairs(craft) do
                for k2,v2 in pairs(v.requires) do
                    itensArmazem[v2.item] = true
                end
            end

            local data = vRP.getSData("armazem:"..tipo)
            local items = json.decode(data) or {}
            if items then
                for k,v in pairs(itensArmazem) do
                    local amount = toInventoryAmount(src.getInventoryItemAmount(user_id, k))
                    if amount > 0 then
                        if src.tryGetInventoryItem(user_id, k, amount) then
                            mensagem = mensagem.. "Item <b>"..safeStr(src.getItemName(k), safeStr(k, "Item")).."</b> quantidade <b>"..amount.."x</b><br>"
                            storeMensagem = storeMensagem.. safeStr(src.getItemName(k), safeStr(k, "Item")) .." "..amount.."x\n"

                            if items[k] ~= nil then
                                items[k] = { amount = items[k].amount + amount }
                            else
                                items[k] = { amount = amount }
                            end
                        end
                    end
                end
                

                if mensagem == "" then
                    config.lang['notStoreItens'](source)
                    return
                end

                config.lang['storeItens'](source, mensagem)
                vRP.setSData("armazem:"..tipo, json.encode(items))

                if storeMensagem ~= nil then
                    corpoHook = { { ["color"] = config.weebhook['color'], ["title"] = "**".. ":man_construction_worker: | Guardar Item " .."**\n", ["thumbnail"] = { ["url"] = config.weebhook['logo'] }, ["description"] = "**USER_ID:**\n```cs\n"..user_id.."```\n**GUARDOU:** ```css\n".. storeMensagem .."```\n**MESA:**\n ```cs\n"..tipo.."```\n**DATA:** ```cs\n"..os.date("\n%d/%m/%Y as %H:%M:%S").."```", ["footer"] = { ["text"] = config.weebhook['footer'], }, } }
                    sendToDiscord(config.table[tostring(tipo)].weebhook, corpoHook)
                end
            end
        else
            print("Erro: Mesa de Craft ("..tipo.. ") não foi encontrada.")
        end
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 3000

        for k,v in pairs(delay) do
            delay[k] = v - 3

            if delay[k] <= 0 then
                delay[k] = nil
            end
        end

        Citizen.Wait(time)
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTRAS FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.ServerConfig = function()
    return config
end

src.sendLogDump = function()
    local source = source
    local user_id = GetUserId(source)
    if user_id then
        corpoHook = { { ["color"] = config.weebhook['color'], ["title"] = "**".. ":man_construction_worker: | ANTI DUMP " .."**\n", ["thumbnail"] = { ["url"] = config.weebhook['logo'] }, ["description"] = "**USER_ID:**\n```cs\n"..user_id.."```\n**DATA:** ```cs\n"..os.date("\n%d/%m/%Y as %H:%M:%S").."```", ["footer"] = { ["text"] = config.weebhook['footer'], }, } }
        sendToDiscord(config.weebdump, corpoHook)  
    end
end

function sendToDiscord(weebhook, message)
    PerformHttpRequest(weebhook, function(err, text, headers) end, 'POST', json.encode({embeds = message}), { ['Content-Type'] = 'application/json' })
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE DESMANCHE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local desmanchando = {}

function src.checkVehicleStatus(mPlaca,mName)
    local source = source
    local user_id = GetUserId(source)
    if user_id then
        
        if mName == "hornet" or mName == "Hornet" then
            TriggerClientEvent("Notify",source,"negado","Este veiculo nao pode ser desmanchado.")
            return
        end
        
        if desmanchando[mPlaca] or desmanchando[mPlaca] ~= nil then
            TriggerClientEvent("Notify",source,"negado","Este veiculo ja esta sendo desmanchado.")
            return
        end

        local nuser_id = vRP.getUserByRegistration(mPlaca)
        if nuser_id then
            local rows = vRP.query("vRP/get_veiculos_status", {user_id = nuser_id, veiculo = mName})
            if rows[1] then
                if rows[1].status == 0 then
                    desmanchando[mPlaca] = user_id
                    exports["vrp"]:setBlockCommand(user_id, 40)
                    return true
                else
                    TriggerClientEvent("Notify",source,"negado","Este veiculo ja se encontra detido/retido.")
                end
            end
        else
            TriggerClientEvent("Notify",source,"negado","Este veiculo nao possui nenhum proprietario.")
        end
    end
end

function src.pagarDesmanche(mPlaca,mName,mPrice,mVeh)
    local source = source
    local user_id = GetUserId(source)
    if user_id then
        local nuser_id = vRP.getUserByRegistration(mPlaca)
        if nuser_id then
            if mName == "hornet" or mName == "Hornet" then
                TriggerClientEvent("Notify",source,"negado","Este veiculo nao pode ser desmanchado.")
                return
            end

            if desmanchando[mPlaca] == user_id then
                exports["vrp"]:setBlockCommand(user_id, 0)
                vRP.execute("vRP/set_status",{ user_id = nuser_id, veiculo = mName, status = 2})
                if vRP.GenerateItem then
                    vRP.GenerateItem(user_id, "dirty_money", mPrice*0.1, true)
                elseif vRP.giveInventoryItem then
                    vRP.giveInventoryItem(user_id, "dirty_money", mPrice*0.1, true)
                end

                exports['bm_module']:deleteVehicle(source, mVeh)

                desmanchando[mPlaca] = nil
                vRP.sendLog("DESMANCHE", "O ID: "..user_id.." desmanchou o veiculo do id "..nuser_id.." veiculo: "..mName.." placa: "..mPlaca.." e recebeu $ "..vRP.format(mPrice*0.1))
            else
                print(user_id, "Troxa dupando #DUPANDO")
            end
        else
            TriggerClientEvent("Notify",source,"negado","Este veiculo nao possui nenhum proprietario.")
        end
    end
end

local itensDesmanche = {
    ["molas"] = 15,
}

function src.checkItensD()
    local source = source
    local user_id = GetUserId(source)
    if user_id then
        local mensagem = ""
        local status = true

        for k,v in pairs(itensDesmanche) do
            local itemAmount = toInventoryAmount(src.getInventoryItemAmount(user_id, k))
            if itemAmount < v then
                status = false
                mensagem = mensagem .. "Você não possui "..src.getItemName(k).." na quantidade de "..v..".<br>"
            end

            if status then
                src.tryGetInventoryItem(user_id, k, v)
            end
        end

         if mensagem ~= "" then
             TriggerClientEvent("Notify",source,"negado",mensagem)
         end

         return status
    end
end
