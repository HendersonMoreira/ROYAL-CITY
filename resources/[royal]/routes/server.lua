-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Routes = {}
Tunnel.bindInterface("routes",Routes)
vCLIENT = Tunnel.getInterface("routes")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local rotas = {

	["Medellin"] = {
		
		itens = {
			{ name = "Pasta QuimÍca", image = "pastaquimica", quantidade = 1, item = "pastaquimica" },
			{ name = "Matéria Base", image = "materiabase", quantidade = 2, item = "materiabase" },
			{ name = "QuimÍca Heroina", image = "qheroina", quantidade = 5, item = "qheroina" },  --ok
			{ name = "QuimÍca Metafetamina", image = "qmetafetamina", quantidade = 5, item = "qmetafetamina" }, --- ok
			{ name = "QuimÍca Cocaina", image = "qcocaina", quantidade = 5, item = "qcocaina" }, --- ok
			{ name = "QuimÍca Maconha", image = "qmaconha", quantidade = 5, item = "qmaconha" }, --- ok 
			{ name = "QuimÍca Crack", image = "qcrack", quantidade = 5, item = "qcrack" } ---ok
		}
	},

		["Barragem"] = {
			
		itens = {
			{ name = "Corpo de Armas", image = "smgbodyfull", quantidade = 1, item = "smgbodyfull" },
			{ name = "Mola de Armas", image = "metalspring", quantidade = 3, item = "metalspring" },
			{ name = "Ferro", image = "ferro", quantidade = 3, item = "ferro" },
			{ name = "Barro de Aço", image = "barradeaco", quantidade = 3, item = "barradeaco" },
			{ name = "Plastico", image = "plastic", quantidade = 5, item = "plastic" },
			{ name = "Gatilho", image = "gatilho", quantidade = 5, item = "gatilho" }
		}
	},

		["Elements"] = {
			
		itens = {
			{ name = "Polvora", image = "gunpowder", quantidade = 6, item = "gunpowder" },
			{ name = "Municao de Pistola", image = "WEAPON_PISTOL_AMMO", quantidade = 20, item = "WEAPON_PISTOL_AMMO" },
			{ name = "Municao de SMG", image = "WEAPON_SMG_AMMO", quantidade = 15, item = "WEAPON_SMG_AMMO" },
			{ name = "Municao de Rifle", image = "WEAPON_RIFLE_AMMO", quantidade = 10, item = "WEAPON_RIFLE_AMMO" },
			{ name = "Blueprint Municao Pistola", image = "blueprint_WEAPON_PISTOL_AMMO", quantidade = 1, item = "blueprint_WEAPON_PISTOL_AMMO" },
			{ name = "Blueprint Municao Rifle", image = "blueprint_WEAPON_RIFLE_AMMO", quantidade = 1, item = "blueprint_WEAPON_RIFLE_AMMO" }
		}
	},

		["Distrito22"] = {
			
		itens = {
			{ name = "Corpo de Armas", image = "smgbodyfull", quantidade = 1, item = "smgbodyfull" },
			{ name = "Mola de Armas", image = "metalspring", quantidade = 3, item = "metalspring" },
			{ name = "Ferro", image = "ferro", quantidade = 3, item = "ferro" },
			{ name = "Barro de Aço", image = "barradeaco", quantidade = 3, item = "barradeaco" },
			{ name = "Plastico", image = "plastic", quantidade = 5, item = "plastic" },
			{ name = "Gatilho", image = "gatilho", quantidade = 5, item = "gatilho" }
		}
	},

		["Turquia"] = {
			
		itens = {
			{ name = "Polvora", image = "gunpowder", quantidade = 6, item = "gunpowder" },
			{ name = "Municao de Pistola", image = "WEAPON_PISTOL_AMMO", quantidade = 20, item = "WEAPON_PISTOL_AMMO" },
			{ name = "Municao de SMG", image = "WEAPON_SMG_AMMO", quantidade = 15, item = "WEAPON_SMG_AMMO" },
			{ name = "Municao de Rifle", image = "WEAPON_RIFLE_AMMO", quantidade = 10, item = "WEAPON_RIFLE_AMMO" },
			{ name = "Blueprint Municao Pistola", image = "blueprint_WEAPON_PISTOL_AMMO", quantidade = 1, item = "blueprint_WEAPON_PISTOL_AMMO" },
			{ name = "Blueprint Municao Rifle", image = "blueprint_WEAPON_RIFLE_AMMO", quantidade = 1, item = "blueprint_WEAPON_RIFLE_AMMO" }
		}
	},


}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local function GetPassport(source)
	if vRP.Passport then
		return vRP.Passport(source)
	elseif vRP.getUserId then
		return vRP.getUserId(source)
	end

	return nil
end

local function HasRoutePermission(Passport,permission)
	if not Passport or not permission then
		return false
	end

	if vRP.HasGroup and vRP.HasGroup(Passport,permission) then
		return true
	end

	if vRP.hasPermission and vRP.hasPermission(Passport,permission) then
		return true
	end

	if vRP.HasPermission and vRP.HasPermission(Passport,permission) then
		return true
	end

	return false
end

local function GetItemWeight(item)
	local weight = 0

	if ItemWeight then
		weight = ItemWeight(item)
	elseif vRP.GetWeight then
		weight = vRP.GetWeight(item)
	elseif vRP.getItemWeight then
		weight = vRP.getItemWeight(item)
	elseif vRP.ItemWeight then
		weight = vRP.ItemWeight(item)
	end

	weight = tonumber(weight)
	if not weight then
		weight = 0
	end

	return weight
end

local function GetInventoryWeight(Passport)
	local weight = 0

	if vRP.InventoryWeight then
		weight = vRP.InventoryWeight(Passport)
	elseif vRP.computeInvWeight then
		weight = vRP.computeInvWeight(Passport)
	elseif vRP.GetInventoryWeight then
		weight = vRP.GetInventoryWeight(Passport)
	end

	weight = tonumber(weight)
	if not weight then
		weight = 0
	end

	return weight
end

local function GetMaxWeight(Passport)
	local maxWeight = 0

	if vRP.CheckWeight then
		maxWeight = vRP.CheckWeight(Passport)
	elseif vRP.GetMaxWeight then
		maxWeight = vRP.GetMaxWeight(Passport)
	elseif vRP.InventoryMaxWeight then
		maxWeight = vRP.InventoryMaxWeight(Passport)
	elseif vRP.getInventoryMaxWeight then
		maxWeight = vRP.getInventoryMaxWeight(Passport)
	elseif vRP.ComputeInvMaxWeight then
		maxWeight = vRP.ComputeInvMaxWeight(Passport)
	end

	maxWeight = tonumber(maxWeight)
	if not maxWeight then
		maxWeight = 0
	end

	return maxWeight
end

local function NotifyFull(source)
	TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua mochila está cheia.","roxo",5000)
end

local function NotifyItemLimit(source)
	TriggerClientEvent("Notify",source,"Atenção","Limite deste item atingido.","amarelo",5000)
end

local function NotifyReceived(source,amount,name)
	TriggerClientEvent("Notify",source,"verde","Você recebeu <b>"..amount.."x "..name.."</b>.",5000)
end

local function CheckCanCarry(Passport,item,amount)
	if vRP.MaxItens and vRP.MaxItens(Passport,item,amount) then
		return false,"limit"
	end

	local itemWeight = GetItemWeight(item)
	local currentWeight = GetInventoryWeight(Passport)
	local maxWeight = GetMaxWeight(Passport)

	if maxWeight > 0 and (currentWeight + (itemWeight * amount)) > maxWeight then
		return false,"weight"
	end

	return true
end

local function GiveItem(Passport,item,amount)
	if vRP.GenerateItem then
		vRP.GenerateItem(Passport,item,amount,true)
		return true
	elseif vRP.GiveItem then
		vRP.GiveItem(Passport,item,amount,true)
		return true
	elseif vRP.giveInventoryItem then
		vRP.giveInventoryItem(Passport,item,amount,true)
		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Routes.checkPermission(permission)
	local source = source
	local Passport = GetPassport(source)
	if not Passport then
		return false
	end

	return HasRoutePermission(Passport,permission)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET ITEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function Routes.getItems(routeName)
	if rotas[routeName] and rotas[routeName].itens then
		return rotas[routeName].itens
	end

	return {}
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Routes.checkPayment(currentRoute,position)
	local source = source
	local Passport = GetPassport(source)
	if not Passport then
		return false
	end

	if not currentRoute or not rotas[currentRoute] or not rotas[currentRoute].itens then
		return false
	end

	local selectedIndex = tonumber(position)
	if not selectedIndex then
		return false
	end

	selectedIndex = selectedIndex + 1

	local selectedItem = rotas[currentRoute].itens[selectedIndex]
	if not selectedItem then
		return false
	end

	local maxAmount = tonumber(selectedItem.quantidade) or 1
	if maxAmount <= 0 then
		maxAmount = 1
	end

	local amount = math.random(1,maxAmount)
	local canCarry,reason = CheckCanCarry(Passport,selectedItem.item,amount)

	if not canCarry then
		if reason == "limit" then
			NotifyItemLimit(source)
		else
			NotifyFull(source)
		end
		return false
	end

	if not GiveItem(Passport,selectedItem.item,amount) then
		return false
	end

	NotifyReceived(source,amount,selectedItem.name)
	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECT ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("routes:selectRoute")
AddEventHandler("routes:selectRoute",function(currentRoute,position)
	local source = source
	local Passport = GetPassport(source)
	if not Passport then
		return
	end

	if not currentRoute or not rotas[currentRoute] or not rotas[currentRoute].itens then
		return
	end

	local selectedIndex = tonumber(position)
	if not selectedIndex then
		return
	end

	selectedIndex = selectedIndex + 1

	local selectedItem = rotas[currentRoute].itens[selectedIndex]
	if selectedItem then
		TriggerClientEvent("routes:startRoute",source,currentRoute,selectedItem.name)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- END ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("routes:endRoute")
AddEventHandler("routes:endRoute",function()
	local source = source
	TriggerClientEvent("Notify",source,"Atenção","Rota encerrada.","amarelo",3000)
end)