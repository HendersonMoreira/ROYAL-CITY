local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local src = {}
Tunnel.bindInterface("wn_cambio",src)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AUXILIARES
-----------------------------------------------------------------------------------------------------------------------------------------
local function parseInt(value)
	value = tonumber(value)
	if value then
		return math.floor(value)
	end
	return 0
end

local function safeToNumber(value)
	if value == nil then
		return 0
	end

	if type(value) == "table" then
		return tonumber(value[1] or value.amount or value.count or value.quantidade or 0) or 0
	end

	return tonumber(value) or 0
end

local function getLocationById(id)
	for _,v in pairs(Config.Locations) do
		if v.id == id then
			return v
		end
	end
	return nil
end

local function extractAmount(value)
	if type(value) == "table" then
		return tonumber(value.amount or value[1] or value.quantidade or value.count or 0) or 0
	end

	return tonumber(value) or 0
end

local function getInventoryItemAmount(Passport,item)
	if vRP.InventoryItemAmount then
		return parseInt(extractAmount(vRP.InventoryItemAmount(Passport,item)))
	end

	if vRP.GetItemAmount then
		return parseInt(extractAmount(vRP.GetItemAmount(Passport,item)))
	end

	if vRP.ItemAmount then
		return parseInt(extractAmount(vRP.ItemAmount(Passport,item)))
	end

	if vRP.Inventory then
		local Inventory = vRP.Inventory(Passport)
		if Inventory then
			for _,data in pairs(Inventory) do
				if data then
					local itemName = data.item or data.name or data.key or data.index
					local itemAmount = data.amount or data.quantidade or data.count or 0

					if itemName == item then
						return parseInt(itemAmount)
					end
				end
			end
		end
	end

	return 0
end

local function itemWeight(item)
	if vRP.ItemWeight then
		return safeToNumber(vRP.ItemWeight(item))
	end

	if vRP.GetItemWeight then
		return safeToNumber(vRP.GetItemWeight(item))
	end

	return 0
end

local function getInventoryWeight(Passport)
	if vRP.InventoryWeight then
		return safeToNumber(vRP.InventoryWeight(Passport))
	end

	if vRP.GetWeight then
		return safeToNumber(vRP.GetWeight(Passport))
	end

	return 0
end

local function getMaxWeight(Passport)
	if vRP.GetBackpack then
		return safeToNumber(vRP.GetBackpack(Passport))
	end

	if vRP.getBackpack then
		return safeToNumber(vRP.getBackpack(Passport))
	end

	if vRP.Backpack then
		return safeToNumber(vRP.Backpack(Passport))
	end

	return 999999
end


local function addBankMoney(Passport,amount)
	if amount <= 0 then
		return true
	end

	if vRP.GiveBank then
		vRP.GiveBank(Passport,amount)
		return true
	end

	if vRP.AddBank then
		vRP.AddBank(Passport,amount)
		return true
	end

	if vRP.GiveBankMoney then
		vRP.GiveBankMoney(Passport,amount)
		return true
	end

	if vRP.AddBankMoney then
		vRP.AddBankMoney(Passport,amount)
		return true
	end

	if vRP.Deposit then
		vRP.Deposit(Passport,amount)
		return true
	end

	return false
end

local function giveInventoryItem(Passport,item,amount)
	if not item or item == "" or amount <= 0 then
		return true
	end

	if vRP.GenerateItem then
		vRP.GenerateItem(Passport,item,amount,true)
		return true
	end

	if vRP.GiveItem then
		vRP.GiveItem(Passport,item,amount,true)
		return true
	end

	return false
end

local function removeInventoryItem(Passport,item,amount)
	if not item or item == "" or amount <= 0 then
		return true
	end

	if vRP.TakeItem then
		return vRP.TakeItem(Passport,item,amount,true)
	end

	if vRP.RemoveItem then
		return vRP.RemoveItem(Passport,item,amount,true)
	end

	return false
end

local function rewardMode(location)
	local mode = tostring(location.receiveMode or "item"):lower()
	if mode ~= "bank" then
		mode = "item"
	end
	return mode
end

local function canReceiveReward(Passport,location,receiveAmount)
	if rewardMode(location) == "bank" then
		return true
	end

	local currentWeight = getInventoryWeight(Passport)
	local maxWeight = getMaxWeight(Passport)
	local weightPerItem = itemWeight(location.toItem)
	local addWeight = weightPerItem * receiveAmount
	local finalWeight = currentWeight + addWeight

	return finalWeight <= maxWeight
end

local function giveReward(Passport,location,receiveAmount)
	if rewardMode(location) == "bank" then
		return addBankMoney(Passport,receiveAmount), Config.Texts.noBankFunction
	end

	return giveInventoryItem(Passport,location.toItem,receiveAmount), "Função de item não encontrada na sua base."
end

local function buildRequiredItems(location,amount)
	local items = {}
	local multiplier = 1

	if location.requiredPerStep then
		local step = parseInt(location.step or 1)
		if step <= 0 then
			step = 1
		end

		multiplier = math.max(1,math.floor(amount / step))
	end

	if type(location.requiredItems) == "table" and #location.requiredItems > 0 then
		for _,item in ipairs(location.requiredItems) do
			if item and item.item and item.item ~= "" then
				local baseAmount = parseInt(item.amount or 1)
				if baseAmount <= 0 then
					baseAmount = 1
				end

				items[#items + 1] = {
					item = item.item,
					label = item.label or item.item,
					amount = baseAmount * multiplier,
					consume = item.consume ~= false
				}
			end
		end
	elseif location.requiredItem and location.requiredItem ~= "" then
		local baseAmount = parseInt(location.requiredAmount or 1)
		if baseAmount <= 0 then
			baseAmount = 1
		end

		items[#items + 1] = {
			item = location.requiredItem,
			label = location.requiredItemLabel or location.requiredItem,
			amount = baseAmount * multiplier,
			consume = location.consumeRequiredItem == true
		}
	end

	return items
end

local function getRequiredItemCost(location,amount)
	local items = buildRequiredItems(location,amount)
	return items[1] and items[1].amount or 0
end

local function requiredItemsText(items)
	if not items or #items <= 0 then
		return "Nenhum"
	end

	local list = {}
	for _,item in ipairs(items) do
		list[#list + 1] = string.format("%sx %s",item.amount,item.label or item.item)
	end

	return table.concat(list,", ")
end

local function hasPermission(Passport,permission,hierarchy)
	if not Passport then
		return false
	end

	if vRP.HasGroup then
		return vRP.HasGroup(Passport,permission,hierarchy)
	end

	if vRP.hasPermission then
		return vRP.hasPermission(Passport,permission)
	end

	return false
end

local function formatPreview(location,amount)
	local receive = math.floor(amount * location.rate)
	local requiredItems = buildRequiredItems(location,amount)
	local firstRequired = requiredItems[1]

	return {
		ok = true,
		sendAmount = amount,
		receiveAmount = receive,
		fromLabel = location.fromLabel,
		toLabel = location.toLabel,
		rate = location.rate,
		requiredItem = firstRequired and firstRequired.item or nil,
		requiredItemLabel = firstRequired and (firstRequired.label or firstRequired.item) or "Nenhum",
		requiredAmount = firstRequired and firstRequired.amount or 0,
		consumeRequiredItem = firstRequired and firstRequired.consume or false,
		requiredItems = requiredItems,
		requiredItemsText = requiredItemsText(requiredItems)
	}
end

local function getIdentity(Passport)
	local Identity = nil

	if vRP.Identity then
		Identity = vRP.Identity(Passport)
	elseif vRP.UserIdentity then
		Identity = vRP.UserIdentity(Passport)
	elseif vRP.getUserIdentity then
		Identity = vRP.getUserIdentity(Passport)
	end

	return Identity
end

local function identityName(identity,passport)
	if identity then
		local name = identity.name or identity.Name or identity.firstname or identity.firstName or "Indefinido"
		local name2 = identity.name2 or identity.Name2 or identity.lastname or identity.lastName or ""
		local full = (tostring(name) .. " " .. tostring(name2)):gsub("^%s+",""):gsub("%s+$","")
		if full ~= "" then
			return full
		end
	end

	return tostring(passport)
end

local function sendWebhook(webhook,message)
	if webhook and webhook ~= "" then
		PerformHttpRequest(webhook,function(err,text,headers) end,"POST",json.encode({
			username = "Câmbio",
			embeds = {
				{
					color = 5763719,
					description = message,
					footer = {
						text = os.date("%d/%m/%Y %H:%M:%S")
					}
				}
			}
		}),{ ["Content-Type"] = "application/json" })
	end
end

local function logExchange(source,Passport,location,giveAmount,receiveAmount,requiredItemAmount)
	local identity = getIdentity(Passport)
	local name = identityName(identity,Passport)
	local Ped = GetPlayerPed(source)
	local Coords = GetEntityCoords(Ped)

	local message = table.concat({
		"**[SISTEMA DE CÂMBIO]**",
		"",
		"**Local:** "..tostring(location.name),
		"**Passaporte:** "..tostring(Passport),
		"**Nome:** "..tostring(name),
		"**Entregou:** "..tostring(giveAmount).."x "..tostring(location.fromItem),
		"**Recebeu:** "..tostring(receiveAmount).."x "..tostring(location.toItem),
		"**Taxa:** "..tostring(location.rate),
		"**Itens exigidos:** "..tostring(requiredItemsText(buildRequiredItems(location,giveAmount))),
		"**Consumido total:** "..tostring(requiredItemAmount or 0),
		"",
		"**Coords:** "..string.format("x: %.2f, y: %.2f, z: %.2f",Coords.x,Coords.y,Coords.z)
	},"\n")

	sendWebhook(location.webhook,message)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CheckPermission(locationId)
	local source = source
	local Passport = vRP.Passport(source)
	local location = getLocationById(locationId)

	if not Passport or not location then
		return false
	end

	return hasPermission(Passport,location.permission,location.hierarchy)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEW
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Preview(locationId,amount)
	local source = source
	local Passport = vRP.Passport(source)
	local location = getLocationById(locationId)

	if not Passport or not location then
		return { ok = false, message = "Local inválido." }
	end

	if not hasPermission(Passport,location.permission,location.hierarchy) then
		return { ok = false, message = Config.Texts.noPermission }
	end

	amount = parseInt(amount)

	if amount <= 0 then
		return { ok = false, message = Config.Texts.invalidAmount }
	end

	if amount < location.minAmount then
		return { ok = false, message = Config.Texts.minAmount }
	end

	if location.step > 0 and (amount % location.step) ~= 0 then
		return { ok = false, message = Config.Texts.stepAmount }
	end

	return formatPreview(location,amount)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EXCHANGE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Exchange(locationId,amount)
	local source = source
	local Passport = vRP.Passport(source)
	local location = getLocationById(locationId)

	if not Passport or not location then
		return { ok = false, message = "Local inválido." }
	end

	if not hasPermission(Passport,location.permission,location.hierarchy) then
		return { ok = false, message = Config.Texts.noPermission }
	end

	amount = parseInt(amount)

	if amount <= 0 then
		return { ok = false, message = Config.Texts.invalidAmount }
	end

	if amount < location.minAmount then
		return { ok = false, message = Config.Texts.minAmount }
	end

	if location.step > 0 and (amount % location.step) ~= 0 then
		return { ok = false, message = Config.Texts.stepAmount }
	end

	local haveAmount = getInventoryItemAmount(Passport,location.fromItem)
	if haveAmount < amount then
		return {
			ok = false,
			message = "Você não tem quantidade suficiente de "..location.fromLabel.."."
		}
	end

	local requiredItems = buildRequiredItems(location,amount)
	for _,required in ipairs(requiredItems) do
		local requiredHave = getInventoryItemAmount(Passport,required.item)
		if requiredHave < required.amount then
			return {
				ok = false,
				message = "Você precisa de "..tostring(required.amount).."x "..tostring(required.label or required.item).." para lavar."
			}
		end
	end

	local receiveAmount = math.floor(amount * location.rate)
	if receiveAmount <= 0 then
		return { ok = false, message = "Resultado inválido." }
	end

	if not canReceiveReward(Passport,location,receiveAmount) then
		return { ok = false, message = Config.Texts.noWeight }
	end

	local removed = removeInventoryItem(Passport,location.fromItem,amount)
	if not removed then
		return { ok = false, message = "Não foi possível remover o item da mochila." }
	end

	local consumedItems = {}
	for _,required in ipairs(requiredItems) do
		if required.consume then
			local removedRequired = removeInventoryItem(Passport,required.item,required.amount)
			if not removedRequired then
				giveInventoryItem(Passport,location.fromItem,amount)
				for _,rollback in ipairs(consumedItems) do
					giveInventoryItem(Passport,rollback.item,rollback.amount)
				end
				return { ok = false, message = "Não foi possível consumir o item exigido." }
			end

			consumedItems[#consumedItems + 1] = {
				item = required.item,
				amount = required.amount
			}
		end
	end

	local rewardSuccess,rewardError = giveReward(Passport,location,receiveAmount)
	if not rewardSuccess then
		giveInventoryItem(Passport,location.fromItem,amount)
		for _,rollback in ipairs(consumedItems) do
			giveInventoryItem(Passport,rollback.item,rollback.amount)
		end
		return { ok = false, message = rewardError or "Não foi possível entregar a recompensa." }
	end

	local consumedTotal = 0
	for _,required in ipairs(requiredItems) do
		if required.consume then
			consumedTotal = consumedTotal + required.amount
		end
	end

	logExchange(source,Passport,location,amount,receiveAmount,consumedTotal)

	return {
		ok = true,
		message = "Troca realizada com sucesso.",
		receiveAmount = receiveAmount
	}
end