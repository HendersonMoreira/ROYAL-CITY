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
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lasted = {}
local Camera = nil
local Default = nil
local Barbershop = {}
local Creation = false

local ReturnCoords = nil
local ReturnHeading = nil

-- LOCAL DO CREATOR
local CreatorSpawn = vec4(-1068.17,-2789.82,20.96,328.82)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local function CloseBarbershop()
	local Ped = PlayerPedId()

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	FreezeEntityPosition(Ped,false)
	SetNuiFocus(false,false)
	vRP.Destroy()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	local Ped = PlayerPedId()

	vSERVER.Update(Barbershop,Creation)

	CloseBarbershop()

	if Creation then
		SetEntityCoords(Ped,CreatorSpawn.x,CreatorSpawn.y,CreatorSpawn.z,false,false,false,false)
		SetEntityHeading(Ped,CreatorSpawn.w)
		Creation = false
	end

	TriggerEvent("hud:Active",true)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Reset",function(Data,Callback)
	local Ped = PlayerPedId()

	exports["barbershop"]:Apply(Lasted)
	vSERVER.Update(Lasted,Creation)
	Lasted = {}

	CloseBarbershop()

	if Creation then
		SetEntityCoords(Ped,CreatorSpawn.x,CreatorSpawn.y,CreatorSpawn.z,false,false,false,false)
		SetEntityHeading(Ped,CreatorSpawn.w)
		Creation = false
	end

	TriggerEvent("hud:Active",true)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	Barbershop = Data
	exports["barbershop"]:Apply(Data)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Apply")
AddEventHandler("barbershop:Apply",function(Data)
	exports["barbershop"]:Apply(Data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply",function(Data,Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Data then
		Barbershop = Data
	end

	for Number = 1,46 do
		if not Barbershop[Number] then
			Barbershop[Number] = 0
		end
	end

	vRPS.Barbershop(Barbershop)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenBarbershop(Mode)
	for Number = 1,46 do
		if not Barbershop[Number] then
			Barbershop[Number] = (Number >= 6 and Number <= 9) and -1 or 0
		end
	end

	local Ped = PlayerPedId()

	if not IsEntityVisible(Ped) then
		SetEntityVisible(Ped,true,false)
	end

	SetEntityAlpha(Ped,255,false)

	-- GUARDA POSIÇÃO ATUAL
	ReturnCoords = GetEntityCoords(Ped)
	ReturnHeading = GetEntityHeading(Ped)

	-- SÓ TELEPORTA SE FOR CREATOR
	if Creation then
		SetEntityCoords(Ped,CreatorSpawn.x,CreatorSpawn.y,CreatorSpawn.z,false,false,false,false)
		SetEntityHeading(Ped,CreatorSpawn.w)
	end

	FreezeEntityPosition(Ped,true)
	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
	TriggerEvent("hud:Active",false)
	Lasted = json.decode(json.encode(Barbershop))

	local Heading = GetEntityHeading(Ped)
	local PedCoords = GetEntityCoords(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,-0.05,1.20,0.60)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamCoord(Camera,Coords.x,Coords.y,Coords.z)
	SetCamRot(Camera,0.0,0.0,Heading + 200.0,2)
	SetCamActive(Camera,true)
	RenderScriptCams(true,false,0,false,false)

	SetEntityHeading(Ped,Heading)
	PointCamAtCoord(Camera,PedCoords.x,PedCoords.y,PedCoords.z + 0.55)

	Default = Coords.z

	SendNUIMessage({
		Action = "Open",
		Payload = {
			Barbershop,
			GetNumberOfPedDrawableVariations(Ped,2) - 1,
			Mode
		}
	})

	SetNuiFocus(true,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
	vec3(-813.37,-183.85,37.57),
	vec3(138.13,-1706.46,29.3),
	vec3(-1280.92,-1117.07,7.0),
	vec3(1930.54,3732.06,32.85),
	vec3(1214.2,-473.18,66.21),
	vec3(-33.61,-154.52,57.08),
	vec3(-276.65,6226.76,31.7)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Table = {}
	for _,Location in ipairs(Locations) do
		table.insert(Table,{ Location,2.5,"E","Pressione","para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1,#Locations do
				if #(Coords - Locations[Number]) <= 2.5 then
					TimeDistance = 1

					if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() then
						Creation = false
						OpenBarbershop(false)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATION
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Creation",function(Heading)
	local Ped = PlayerPedId()

	if not IsEntityVisible(Ped) then
		SetEntityVisible(Ped,true,false)
	end

	SetEntityAlpha(Ped,255,false)

	Creation = true
	OpenBarbershop(true)
end)