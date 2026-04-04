-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Block = false
local Opened = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chests = {
	{ ["Name"] = "LSPD", ["Coords"] = vec3(-1743.52,-718.43,10.45), ["Mode"] = "1" },
	{ ["Name"] = "Paramedico", ["Coords"] = vec3(353.0,-1427.67,32.67), ["Mode"] = "2" },
	{ ["Name"] = "Restaurante", ["Coords"] = vec3(-631.68,228.32,82.17), ["Mode"] = "2" },
	{ ["Name"] = "MedellinLider", ["Coords"] = vec3(1402.21,1150.67,114), ["Mode"] = "2" },
	{ ["Name"] = "MedellinMembro", ["Coords"] = vec3(1400.04,1139.69,114.33), ["Mode"] = "4" },
	{ ["Name"] = "BarragemLider", ["Coords"] = vec3(1235.91,-250.87,79.62), ["Mode"] = "2" },
	{ ["Name"] = "BarragemMembro", ["Coords"] = vec3(1233.12,-253.5,79.62), ["Mode"] = "4" },
	{ ["Name"] = "ElementsLider", ["Coords"] = vec3(747.0,1303.03,360.55), ["Mode"] = "2" },
	{ ["Name"] = "ElementsMembro", ["Coords"] = vec3(733.19,1301.98,360.55), ["Mode"] = "4" },
	{ ["Name"] = "TurquiaLider", ["Coords"] = vec3(1547.57,-724.81,121.05), ["Mode"] = "2" },
	{ ["Name"] = "TurquiaMembro", ["Coords"] = vec3(1308.6,-794.53,79.03), ["Mode"] = "4" },
	{ ["Name"] = "BlackDiamondLider", ["Coords"] = vec3(-3225.92,811.56,8.93,31.19), ["Mode"] = "2" },
	{ ["Name"] = "BlackDiamondMembro", ["Coords"] = vec3(-3219.66,778.4,8.26,127.56), ["Mode"] = "4" }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Labels = {
	["1"] = {
		{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "client",
			service = "Normal"
		},{
			event = "chest:Open",
			label = "Compartimento Pessoal",
			tunnel = "client",
			service = "Personal"
		},{
			event = "chest:Armour",
			label = "Colete Balístico",
			tunnel = "server"
		}
	},
	["2"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "client",
			service = "Normal"
		}
	},
	["3"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "client",
			service = "Tray"
		}
	},
	["4"] = {
		{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "client",
			service = "Normal"
		},{
			event = "chest:Open",
			label = "Compartimento Pessoal",
			tunnel = "client",
			service = "Personal"
		}
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
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

		local Factor = (string.len(text) / 370)
		DrawRect(_x,_y + 0.0125,0.015 + Factor,0.03,0,0,0,120)
	end
end

local function splitString(Full,Separator)
	local Result = {}

	for Part in string.gmatch(Full,"([^"..Separator.."]+)") do
		Result[#Result + 1] = Part
	end

	return Result
end

local function OpenChestDynamic(Name)
	exports["dynamic"]:AddMenu("Baú","Escolha o compartimento.","chest")
	exports["dynamic"]:AddButton("Baú Normal","Abrir compartimento membro.","chest:dynamicOpen",Name.."-Normal","chest",false)
	exports["dynamic"]:AddButton("Baú Pessoal","Abrir compartimento pessoal.","chest:dynamicOpen",Name.."-Personal","chest",false)
	exports["dynamic"]:Open()
end

local function OpenInventoryChest(Force)
	TriggerEvent("inventory:Open",{
		Type = "Chest",
		Resource = "chest",
		Force = Force
	})
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:dynamicOpen")
AddEventHandler("chest:dynamicOpen",function(Data)
	if not Data then
		return
	end

	local Split = splitString(Data,"-")
	local Name = Split[1]
	local Mode = Split[2]

	if Name and Mode then
		TriggerEvent("dynamic:Close")
		TriggerEvent("chest:Open",Name,Mode)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN CHEST WITH E
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if not Opened and GetEntityHealth(Ped) > 100 then
			local Coords = GetEntityCoords(Ped)

			for _,chest in pairs(Chests) do
				local Distance = #(Coords - chest["Coords"])
				if Distance <= 2.0 then
					TimeDistance = 1
					DrawText3D(chest["Coords"].x,chest["Coords"].y,chest["Coords"].z + 0.15,"~g~E~w~ ABRIR BAÚ")

					if IsControlJustPressed(0,38) then
						if chest["Mode"] == "4" then
							OpenChestDynamic(chest["Name"])
						else
							local options = Labels[chest["Mode"]] or {}
							local option = options[1]

							if option then
								if option.tunnel == "server" then
									TriggerServerEvent(option.event,chest["Name"],option.service)
								else
									TriggerEvent(option.event,chest["Name"],option.service)
								end
							end
						end
					end

					break
				end
			end
		end

		Wait(TimeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Open")
AddEventHandler("chest:Open",function(Name,Mode,Item,Blocked,Force)
	if Opened then
		return
	end

	if vSERVER.Permissions(Name,Mode,Item) and GetEntityHealth(PlayerPedId()) > 100 then
		if Blocked or (SplitBoolean and SplitBoolean(Name,"Helicrash",":")) then
			Block = true
		else
			Block = false
		end

		Opened = true
		OpenInventoryChest(Force)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Item",function(Name)
	if Opened then
		return
	end

	if vSERVER.Permissions(Name,"Item") and GetEntityHealth(PlayerPedId()) > 100 then
		Opened = true
		Block = false
		OpenInventoryChest(nil)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:RECYCLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Recycle",function()
	if Opened then
		return
	end

	if vSERVER.Permissions("Tray") and GetEntityHealth(PlayerPedId()) > 100 then
		Opened = true
		Block = false
		OpenInventoryChest(nil)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Opened then
		Opened = false
		Block = false
		TriggerServerEvent("chest:Close")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Take(Data["item"],Data["slot"],Data["amount"],Data["target"])
	end

	Callback("Ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"],Block)
	end

	Callback("Ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Update(Data["slot"],Data["target"],Data["amount"])
	end

	Callback("Ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Primary,Secondary,PrimaryWeight,SecondaryWeight,SecondarySlots,PrimaryMaxWeight,SecondaryMaxWeight = vSERVER.Mount()

	Callback({
		Primary = Primary or {},
		Secondary = Secondary or {},
		PrimaryWeight = tonumber(PrimaryWeight) or 0,
		PrimaryMaxWeight = tonumber(PrimaryMaxWeight) or 0,
		SecondaryWeight = tonumber(SecondaryWeight) or 0,
		SecondaryMaxWeight = tonumber(SecondaryMaxWeight) or 0,
		SecondarySlots = tonumber(SecondarySlots) or 0
	})
end)