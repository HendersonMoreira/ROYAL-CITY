-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vCLIENT = Tunnel.getInterface("inventory")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("chest",Creative)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
local DEBUG_CHEST = false

local function DebugChest(Action,Data)
	if not DEBUG_CHEST then
		return
	end

	print("^3[CHEST DEBUG]^7 "..tostring(Action))

	if Data then
		for Key,Value in pairs(Data) do
			print("   "..tostring(Key).." = "..tostring(Value))
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
local ChestWebhooks = {
	["LSPD"] = "COLE_AQUI_WEBHOOK_LSPD",
	["Paramedico"] = "COLE_AQUI_WEBHOOK_PARAMEDICO",
	["Restaurante"] = "COLE_AQUI_WEBHOOK_RESTAURANTE",
	["MedellinLider"] = "https://discord.com/api/webhooks/1486136333754826892/ZrSABBNyotiBUK_rypAXMQLWDooLoESApbi9x9jnNy3q0EVa6zMzjGeMc6da8uh-EwO2",
	["MedellinMembro"] = "https://discord.com/api/webhooks/1486136478122643618/9W_qgxb40jwBN075Fy-_hnHKUlXg8eM3W5j-fkyvxU0wl7zuO9P6m3PpQcWyitqDEBFK",
	["BarragemLider"] = "",
	["BarragemMembro"] = ""
}

local function getIdentityName(Passport)
	local Identity = nil

	if vRP.Identity then
		Identity = vRP.Identity(Passport)
	elseif vRP.GetIdentity then
		Identity = vRP.GetIdentity(Passport)
	end

	if Identity then
		local Name = Identity.name or Identity.Name or "SemNome"
		local Name2 = Identity.name2 or Identity.Lastname or Identity.lastname or "SemSobrenome"
		return tostring(Name).." "..tostring(Name2)
	end

	return "Passaporte "..tostring(Passport)
end

local function getItemLabel(Item)
	if ItemName then
		return ItemName(Item) or tostring(Item)
	end

	return tostring(Item)
end

local function SendDiscordWebhook(Webhook,Message,Action)
	if not Webhook or Webhook == "" or string.find(Webhook,"COLE_AQUI_WEBHOOK",1,true) then
		return
	end

	local Color = 5814783

	if Action == "Retirou" then
		Color = 16711680
	elseif Action == "Guardou" then
		Color = 3447003
	end

	PerformHttpRequest(Webhook,function() end,"POST",json.encode({
		username = "Chest Logs",
		embeds = {
			{
				title = "Registro de Baú",
				description = Message,
				color = Color,
				footer = {
					text = os.date("%d/%m/%Y %H:%M:%S")
				}
			}
		}
	}),{ ["Content-Type"] = "application/json" })
end

local function getOpenChestBaseName(Passport)
	if not Open[Passport] then
		return nil
	end

	local FullName = tostring(Open[Passport]["Name"] or "")
	FullName = FullName:gsub("^Chest:","")
	return FullName:match("([^:]+)")
end

local function RegisterChestLog(Passport,Action,Item,Amount,Slot,Target)
	if not Open[Passport] then
		return
	end

	if Open[Passport]["Personal"] then
		return
	end

	local ChestBaseName = getOpenChestBaseName(Passport)
	if not ChestBaseName or ChestBaseName == "" then
		return
	end

	local Webhook = ChestWebhooks[ChestBaseName]
	if not Webhook or Webhook == "" then
		return
	end

	local Message = table.concat({
		"**Ação:** "..tostring(Action),
		"**Baú:** "..tostring(ChestBaseName),
		"**Passaporte:** "..tostring(Passport),
		"**Jogador:** "..getIdentityName(Passport),
		"**Item:** "..getItemLabel(Item),
		"**Spawn:** "..tostring(Item),
		"**Quantidade:** "..tostring(Amount),
		"**Slot:** "..tostring(Slot or "N/A"),
		"**Target:** "..tostring(Target or "N/A")
	},"\n")

	SendDiscordWebhook(Webhook,Message,Action)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chests = {
	["LSPD"] = {
		["Permission"] = { "Policia" },
		["Weight"] = 50000,
		["Slots"] = 100,
		["Mode"] = "1",
		["Save"] = true
	},
	["Paramedico"] = {
		["Permission"] = { "Paramedico" },
		["Weight"] = 50000,
		["Slots"] = 100,
		["Mode"] = "2",
		["Save"] = true
	},
	["Restaurante"] = {
		["Permission"] = { "Restaurante" },
		["Weight"] = 25000,
		["Slots"] = 50,
		["Mode"] = "2",
		["Save"] = true
	},
	["MedellinLider"] = {
		["Permission"] = { "Medellin" },
		["Hierarchy"] = 2,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "2",
		["Save"] = true
	},
	["MedellinMembro"] = {
		["Permission"] = { "Medellin" },
		["Hierarchy"] = 6,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "4",
		["Save"] = true
	},
	["BarragemLider"] = {
		["Permission"] = { "Barragem" },
		["Hierarchy"] = 2,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "2",
		["Save"] = true
	},
	["BarragemMembro"] = {
		["Permission"] = { "Barragem" },
		["Hierarchy"] = 6,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "4",
		["Save"] = true
	},
	["ElementsLider"] = {
		["Permission"] = { "Elements" },
		["Hierarchy"] = 2,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "2",
		["Save"] = true
	},
	["ElementsMembro"] = {
		["Permission"] = { "Elements" },
		["Hierarchy"] = 6,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "4",
		["Save"] = true
	},
	["TurquiaLider"] = {
		["Permission"] = { "Turquia" },
		["Hierarchy"] = 2,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "2",
		["Save"] = true
	},
	["TurquiaMembro"] = {
		["Permission"] = { "Turquia" },
		["Hierarchy"] = 6,
		["Weight"] = 10000,
		["Slots"] = 50,
		["Mode"] = "4",
		["Save"] = true
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILS
-----------------------------------------------------------------------------------------------------------------------------------------
local function splitString(Full,Separator)
	local Result = {}

	for Part in string.gmatch(Full,"([^"..Separator.."]+)") do
		Result[#Result + 1] = Part
	end

	return Result
end

local function parseInt(Value)
	return math.floor(tonumber(Value) or 0)
end

local function safeNumber(Value)
	if type(Value) == "number" then
		return Value
	elseif type(Value) == "string" then
		return tonumber(Value) or 0
	end

	return 0
end

local function hasChestPermission(Passport,Permission,Hierarchy)
	if not Passport or not Permission then
		return false
	end

	Hierarchy = tonumber(Hierarchy)

	if Hierarchy then
		if vRP.HasGroup then
			local Result = vRP.HasGroup(Passport,Permission,Hierarchy)
			if Result then
				return true
			end
		end

		if vRP.hasGroup then
			local Result = vRP.hasGroup(Passport,Permission,Hierarchy)
			if Result then
				return true
			end
		end
	end

	if vRP.GetSrvData then
		local PermissionData = vRP.GetSrvData("Permissions:"..Permission,true) or {}
		local PlayerHierarchy = PermissionData[tostring(Passport)] or PermissionData[Passport]

		if Hierarchy then
			PlayerHierarchy = tonumber(PlayerHierarchy)
			return PlayerHierarchy and PlayerHierarchy == Hierarchy or false
		else
			if PlayerHierarchy ~= nil then
				return true
			end
		end
	end

	if not Hierarchy then
		if vRP.HasGroup then
			return vRP.HasGroup(Passport,Permission)
		end

		if vRP.hasGroup then
			return vRP.hasGroup(Passport,Permission)
		end

		if vRP.HasPermission then
			return vRP.HasPermission(Passport,Permission)
		end

		if vRP.hasPermission then
			return vRP.hasPermission(Passport,Permission)
		end
	end

	return false
end

local function getInventoryWeight(Passport)
	if vRP.InventoryWeight then
		return safeNumber(vRP.InventoryWeight(Passport))
	elseif vRP.getInventoryWeight then
		return safeNumber(vRP.getInventoryWeight(Passport))
	elseif vRP.ComputeInvWeight then
		return safeNumber(vRP.ComputeInvWeight(Passport))
	end

	return 0
end

local function getInventoryMaxWeight(Passport)
	if vRP.CheckWeight then
		return safeNumber(vRP.CheckWeight(Passport))
	elseif vRP.GetWeight then
		return safeNumber(vRP.GetWeight(Passport))
	elseif vRP.InventoryMaxWeight then
		return safeNumber(vRP.InventoryMaxWeight(Passport))
	elseif vRP.GetBackpack then
		return safeNumber(vRP.GetBackpack(Passport))
	end

	return 0
end

local function getChestWeight(ChestName,Save)
	local Weight = 0
	local Result = {}

	if vRP.GetSrvData then
		Result = vRP.GetSrvData(ChestName,Save) or {}
	end

	for _,v in pairs(Result) do
		if v and v["item"] and v["amount"] then
			local ItemWeightValue = 0

			if ItemWeight then
				ItemWeightValue = ItemWeight(v["item"]) or 0
			end

			Weight = Weight + (ItemWeightValue * parseInt(v["amount"]))
		end
	end

	return Weight
end

local function getOpenChestMaxWeight(Passport)
	if not Open[Passport] then
		return 0
	end

	if Open[Passport]["Personal"] then
		return 200
	end

	return safeNumber(Open[Passport]["Weight"])
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permissions(Name,Mode,Item)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return false
	end

	local Data = Chests[Name]
	if not Data and type(Name) == "string" and Name:sub(1,9) == "Helicrash" then
		Open[Passport] = {
			["Name"] = "Chest:"..Name,
			["Weight"] = 10000,
			["Slots"] = 50,
			["Save"] = false,
			["Personal"] = false
		}

		DebugChest("PERMISSION_OK_HELICRASH",{
			passport = Passport,
			name = Name,
			mode = tostring(Mode),
			open_name = Open[Passport]["Name"]
		})

		return true
	end

	if not Data then
		DebugChest("CHEST_NAO_ENCONTRADO",{
			passport = Passport,
			name = tostring(Name),
			mode = tostring(Mode)
		})
		return false
	end

	for _,Permission in pairs(Data["Permission"] or {}) do
		if hasChestPermission(Passport,Permission,Data["Hierarchy"]) then
			local ChestName = Name
			local ChestWeight = Data["Weight"] or 0
			local ChestSlots = Data["Slots"] or 25
			local Personal = false

			if Mode == "Personal" then
				ChestName = Name..":"..Passport
				ChestWeight = 200
				Personal = true
			end

			Open[Passport] = {
				["Name"] = "Chest:"..ChestName,
				["Weight"] = ChestWeight,
				["Slots"] = ChestSlots,
				["Save"] = Data["Save"] ~= false,
				["Personal"] = Personal
			}

			DebugChest("PERMISSION_OK",{
				passport = Passport,
				name = Name,
				mode = tostring(Mode),
				permission = tostring(Permission),
				hierarchy = tostring(Data["Hierarchy"]),
				open_name = Open[Passport]["Name"],
				weight = ChestWeight,
				slots = ChestSlots,
				personal = Personal and "sim" or "nao"
			})

			return true
		end
	end

	DebugChest("PERMISSION_DENIED",{
		passport = Passport,
		name = Name,
		mode = tostring(Mode),
		required_hierarchy = tostring(Data["Hierarchy"])
	})

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Mount()
	local source = source
	local Passport = vRP.Passport(source)

	if Passport and Open[Passport] then
		local Primary = {}
		local Inv = vRP.Inventory(Passport) or {}

		for Index,v in pairs(Inv) do
			if v and v["item"] then
				if safeNumber(v["amount"]) <= 0 or (ItemExist and not ItemExist(v["item"])) then
					if vRP.RemoveItem then
						vRP.RemoveItem(Passport,v["item"],v["amount"],false)
					end
				else
					v["name"] = ItemName and ItemName(v["item"]) or v["item"]
					v["weight"] = ItemWeight and ItemWeight(v["item"]) or 0
					v["index"] = ItemIndex and ItemIndex(v["item"]) or v["item"]
					v["amount"] = parseInt(v["amount"])
					v["rarity"] = ItemRarity and ItemRarity(v["item"]) or "common"
					v["economy"] = ItemEconomy and ItemEconomy(v["item"]) or "0"
					v["desc"] = ItemDescription and ItemDescription(v["item"]) or nil
					v["key"] = v["item"]
					v["slot"] = Index
					Primary[Index] = v
				end
			end
		end

		local Secondary = {}
		local Result = {}

		if vRP.GetSrvData then
			Result = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"]) or {}
		end

		for Index,v in pairs(Result) do
			if v and v["item"] then
				if safeNumber(v["amount"]) <= 0 or (ItemExist and not ItemExist(v["item"])) then
					if vRP.RemoveChest then
						vRP.RemoveChest(Open[Passport]["Name"],Index,Open[Passport]["Save"])
					end
				else
					v["name"] = ItemName and ItemName(v["item"]) or v["item"]
					v["weight"] = ItemWeight and ItemWeight(v["item"]) or 0
					v["index"] = ItemIndex and ItemIndex(v["item"]) or v["item"]
					v["amount"] = parseInt(v["amount"])
					v["rarity"] = ItemRarity and ItemRarity(v["item"]) or "common"
					v["economy"] = ItemEconomy and ItemEconomy(v["item"]) or "0"
					v["desc"] = ItemDescription and ItemDescription(v["item"]) or nil
					v["key"] = v["item"]
					v["slot"] = Index
					Secondary[Index] = v
				end
			end
		end

		local PrimaryWeight = getInventoryWeight(Passport)
		local PrimaryMaxWeight = getInventoryMaxWeight(Passport)
		local SecondaryWeight = getChestWeight(Open[Passport]["Name"],Open[Passport]["Save"])
		local SecondaryMaxWeight = getOpenChestMaxWeight(Passport)
		local SecondarySlots = safeNumber(Open[Passport]["Slots"])

		if SecondarySlots <= 0 then
			SecondarySlots = 25
		end

		return Primary,Secondary,PrimaryWeight,SecondaryWeight,SecondarySlots,PrimaryMaxWeight,SecondaryMaxWeight
	end

	return {},{},0,0,0,0,0
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Slot,Amount,Target)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport or not Open[Passport] then
		return
	end

	if not Item or not Slot or not Amount then
		return
	end

	Amount = parseInt(Amount)
	if Amount <= 0 then
		return
	end

	if vRP.TakeChest then
		vRP.TakeChest(Passport,Open[Passport]["Name"],Amount,Slot,Target)
	elseif vRP.TakeChestItem then
		vRP.TakeChestItem(Passport,Open[Passport]["Name"],Amount,Slot,Target)
	end

	RegisterChestLog(Passport,"Retirou",Item,Amount,Slot,Target)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target,Block)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport or not Open[Passport] then
		return
	end

	if not Item or not Slot or not Amount then
		return
	end

	Amount = parseInt(Amount)
	if Amount <= 0 then
		return
	end

	local MaxWeight = getOpenChestMaxWeight(Passport)

	if vRP.StoreChest then
		vRP.StoreChest(Passport,Open[Passport]["Name"],Amount,MaxWeight,Slot,Target)
	elseif vRP.StoreChestItem then
		vRP.StoreChestItem(Passport,Open[Passport]["Name"],Amount,MaxWeight,Slot,Target)
	end

	RegisterChestLog(Passport,"Guardou",Item,Amount,Slot,Target)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport or not Open[Passport] then
		return
	end

	if not Slot or not Target then
		return
	end

	local Consult = {}
	if vRP.GetSrvData then
		Consult = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"]) or {}
	end

	Slot = tostring(Slot)
	Target = tostring(Target)

	if Consult[Slot] and Consult[Target] then
		local SlotData = Consult[Slot]
		local TargetData = Consult[Target]

		Consult[Slot] = TargetData
		Consult[Target] = SlotData

		if vRP.SetSrvData then
			vRP.SetSrvData(Open[Passport]["Name"],Consult,Open[Passport]["Save"])
		end
	elseif Consult[Slot] and not Consult[Target] then
		Consult[Target] = Consult[Slot]
		Consult[Slot] = nil

		if vRP.SetSrvData then
			vRP.SetSrvData(Open[Passport]["Name"],Consult,Open[Passport]["Save"])
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Close")
AddEventHandler("chest:Close",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Open[Passport] = nil
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Open[Passport] = nil
	end
end)

AddEventHandler("vRP:playerLeave",function(Passport,source)
	if Passport then
		Open[Passport] = nil
	end
end)
