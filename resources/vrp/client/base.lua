-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Proxy.addInterface("vRP",tvRP)
Tunnel.bindInterface("vRP",tvRP)
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blipmin = false
local Information = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Theme",function(Data,Callback)
	Callback(Theme)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local YTD = CreateRuntimeTxd("Textures")

	for _,Name in pairs(TexturePack) do
		local TEXTURE = CreateRuntimeTexture(YTD,Name,512,512)
		local PNG = LoadResourceFile("vrp","config/textures/"..Name..".png")
		local DICT = "data:image/png;base64,"..Base64(PNG)

		SetRuntimeTextureImage(TEXTURE,DICT)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPeds(Radius)
	local Selected = {}
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")
	local Radius = (Radius or 2.0) + 0.0001

	for _,Entitys in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entitys)
		if IsPedAPlayer(Entitys) and Index and Ped ~= Entitys and NetworkIsPlayerConnected(Index) and #(Coords - GetEntityCoords(Entitys)) <= Radius then
			Selected[#Selected + 1] = GetPlayerServerId(Index)
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPed(Radius)
	local Selected = false
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")
	local Radius = (Radius or 2.0) + 0.0001

	for _,Entitys in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entitys)
		if IsPedAPlayer(Entitys) and Index and Ped ~= Entitys and NetworkIsPlayerConnected(Index) then
			local OtherCoords = GetEntityCoords(Entitys)
			local OtherDistance = #(Coords - OtherCoords)
			if OtherDistance <= Radius then
				Selected = GetPlayerServerId(Index)
				Radius = OtherDistance
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Selected = {}
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			Selected[Entity] = GetPlayerServerId(Index)
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Players()
	return GetPlayers()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.BlipAdmin()
	Blipmin = not Blipmin

	while Blipmin do
		for Entity,v in pairs(GetPlayers()) do
			if GlobalState["Players"][v] then
				DrawText3D(GetEntityCoords(Entity),"~o~ID:~w~ "..GlobalState["Players"][v].."     ~g~H:~w~ "..GetEntityHealth(Entity).."     ~y~A:~w~ "..GetPedArmour(Entity),0.275)
			end
		end

		Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlaySound(Dict,Name)
	PlaySoundFrontend(-1,Dict,Name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTENALBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportEnable()
	if not Information and not IsPauseMenuActive() then
		Information = true

		while Information do
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for Entity,v in pairs(GetPlayers()) do
				local OtherCoords = GetEntityCoords(Entity)
				if HasEntityClearLosToEntity(Ped,Entity,17) and #(Coords - OtherCoords) <= 5 then
					DrawText3D(OtherCoords,"~w~"..GlobalState["Players"][v],0.45)
				end
			end

			Wait(0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportDisable()
	Information = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+Information",PassportEnable)
RegisterCommand("-Information",PassportDisable)
RegisterKeyMapping("+Information","Visualizar passaportes.","keyboard","F7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text,Weight)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"] + 1.10)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,150)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = string.len(Text) / 160 * Weight
		DrawRect(x,y + 0.0125,Width,0.03,15,15,15,175)
	end
end