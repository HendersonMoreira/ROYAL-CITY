-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Objects = {}
local Active = false
local DropRadiusBlip = nil
local DropCenterBlip = nil
local Interactions = {}
local LastHeatNotice = 0

local function IsHelicrashHot()
	return Active and GlobalState["HelicrashHot"]
end

local function ShowHelicrashNotification(Message)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(Message)
	EndTextCommandThefeedPostTicker(false,true)
end

local function RemoveDropZoneBlips()
	if DoesBlipExist(DropRadiusBlip) then
		RemoveBlip(DropRadiusBlip)
		DropRadiusBlip = nil
	end

	if DoesBlipExist(DropCenterBlip) then
		RemoveBlip(DropCenterBlip)
		DropCenterBlip = nil
	end
end

local function CreateDropZoneBlips(Number)
	if not Number or not Components[Number] then
		return
	end

	local CrashCoords = Components[Number]["1"][1]

	DropRadiusBlip = AddBlipForRadius(CrashCoords.x,CrashCoords.y,CrashCoords.z,140.0)
	SetBlipColour(DropRadiusBlip,1)
	SetBlipAlpha(DropRadiusBlip,110)

	DropCenterBlip = AddBlipForCoord(CrashCoords.x,CrashCoords.y,CrashCoords.z)
	SetBlipSprite(DropCenterBlip,43)
	SetBlipDisplay(DropCenterBlip,2)
	SetBlipAsShortRange(DropCenterBlip,false)
	SetBlipColour(DropCenterBlip,1)
	SetBlipScale(DropCenterBlip,0.85)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Area de Risco - Helicrash Ativo")
	EndTextCommandSetBlipName(DropCenterBlip)
end

local function ClearHelicrash()
	Active = false
	RemoveDropZoneBlips()

	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	if Objects["1"] then
		for Number,_ in pairs(Objects) do
			if Number ~= "1" and Interactions[Number] then
				exports["target"]:RemCircleZone("Helicrash:"..Number)
				Interactions[Number] = nil
			end

			if DoesEntityExist(Objects[Number]) then
				DeleteEntity(Objects[Number])
			end

			Objects[Number] = nil
		end
	end
end

local function ActivateHelicrash(Number)
	if not Number or not Components[Number] then
		return
	end

	ClearHelicrash()
	Active = Number
	HeliBlip(Number)
	CreateDropZoneBlips(Number)
	ShowHelicrashNotification("Helicrash caiu e foi marcado no mapa. Aguarde as caixas esfriarem antes de abrir.")
end

CreateThread(function()
	while true do
		if UseGameClock and LocalPlayer and LocalPlayer["state"] and LocalPlayer["state"]["Active"] then
			TriggerServerEvent("helicrash:SyncClock",GetClockHours(),GetClockMinutes())
			Wait(1000)
		else
			Wait(5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Active and Components[Active] then
			local Ped = PlayerPedId()
			local Crashed = Components[Active]
			local Coords = GetEntityCoords(Ped)
			local Distance = #(Coords - Crashed["1"][1])
			local Hot = IsHelicrashHot()

			if Distance <= 250 then
				for Number,v in pairs(Crashed) do
					if not Objects[Number] and LoadModel(v[3]) then
						local Model = type(v[3]) == "string" and GetHashKey(v[3]) or v[3]
						Objects[Number] = CreateObjectNoOffset(Model,v[1].x,v[1].y,v[1].z,false,false,false)

						if DoesEntityExist(Objects[Number]) then
							SetEntityCoordsNoOffset(Objects[Number],v[1].x,v[1].y,v[1].z,false,false,false)
							PlaceObjectOnGroundProperly(Objects[Number])
							FreezeEntityPosition(Objects[Number],true)
							SetEntityLodDist(Objects[Number],0xFFFF)
							SetEntityHeading(Objects[Number],v[2])
						end

						if Number ~= "1" and not Hot and not Interactions[Number] then
							exports["target"]:AddBoxZone("Helicrash:"..Number,v[1],1.25,2.0,{
								name = "Helicrash:"..Number,
								heading = v[2],
								minZ = v[1]["z"] - 1.00,
								maxZ = v[1]["z"] + 0.25
							},{
								shop = "Helicrash"..Number,
								Distance = 1.75,
								options = {
									{
										event = "chest:Open",
										label = "Abrir",
										tunnel = "client",
										service = "Custom"
									}
								}
							})
							Interactions[Number] = true
						end
					end

					if Number ~= "1" and Hot then
						if Interactions[Number] then
							exports["target"]:RemCircleZone("Helicrash:"..Number)
							Interactions[Number] = nil
						end

						if #(Coords - v[1]) <= (HelicrashHotRadius or 2.25) and GetEntityHealth(Ped) > 100 then
							SetEntityHealth(Ped,0)
							if GetGameTimer() >= LastHeatNotice then
								ShowHelicrashNotification("As caixas ainda estao quentes. Aguarde 10 minutos para esfriarem.")
								LastHeatNotice = GetGameTimer() + 5000
							end
						end
					elseif Number ~= "1" and not Interactions[Number] and Objects[Number] then
						exports["target"]:AddBoxZone("Helicrash:"..Number,v[1],1.25,2.0,{
							name = "Helicrash:"..Number,
							heading = v[2],
							minZ = v[1]["z"] - 1.00,
							maxZ = v[1]["z"] + 0.25
						},{
							shop = "Helicrash"..Number,
							Distance = 1.75,
							options = {
								{
									event = "chest:Open",
									label = "Abrir",
									tunnel = "client",
									service = "Custom"
								}
							}
						})
						Interactions[Number] = true
					end
				end
			else
				if Objects["1"] then
					for Number,v in pairs(Objects) do
						if Interactions[Number] then
							exports["target"]:RemCircleZone("Helicrash:"..Number)
							Interactions[Number] = nil
						end

						DeleteEntity(Objects[Number])
						Objects[Number] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Helicrash",nil,function(Name,Key,Value)
	if not Value then
		ClearHelicrash()
	else
		ActivateHelicrash(Value)
	end
end)

RegisterNetEvent("helicrash:Start")
AddEventHandler("helicrash:Start",function(Number)
	ActivateHelicrash(Number)
end)

RegisterNetEvent("helicrash:Stop")
AddEventHandler("helicrash:Stop",function()
	ClearHelicrash()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELIBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function HeliBlip(Number)
	if Components[Number] then
		local CrashCoords = Components[Number]["1"][1]
		Blip = AddBlipForCoord(CrashCoords.x,CrashCoords.y,CrashCoords.z)
		SetBlipSprite(Blip,43)
		SetBlipDisplay(Blip,2)
		SetBlipAsShortRange(Blip,false)
		SetBlipColour(Blip,5)
		SetBlipScale(Blip,0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Helicrash Ativo")
		EndTextCommandSetBlipName(Blip)
	end
end