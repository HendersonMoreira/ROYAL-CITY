-----------------------------------------------------------------------------------------------------------------------------------------
-- vRp
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("bus")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Selected = 1
local Active = false
local CurrentWork = "bus"
local CarryingPizza = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bus:Init")
AddEventHandler("bus:Init",function()
	ToggleWork("bus")
end)

RegisterNetEvent("ifood:Init")
AddEventHandler("ifood:Init",function()
	ToggleWork("ifood")
end)

exports["target"]:AddCircleZone("bus:Init",vec3(453.55,-602.28,28.59),0.5,{
	name = "bus:Init",
	heading = 0.0,
	useZ = true
},{
	Distance = 1.25,
	options = {
		{
			event = "bus:Init",
			label = "Iniciar Trabalho",
			tunnel = "client"
		}
	}
})

exports["target"]:AddCircleZone("ifood:Init",vec3(-1183.22,-884.28,13.75),0.5,{
    name = "ifood:Init",
    heading = 0.0,
    useZ = true
},{
    Distance = 1.25,
    options = {
        {
            event = "ifood:Init",
            label = "Iniciar Trabalho",
            tunnel = "client"
        }
    }
})
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active then
			local Work = Works[CurrentWork]
			local Ped = PlayerPedId()
			if Work then
				if CurrentWork == "ifood" then
					TimeDistance = HandleIfoodWork(Ped,Work)
				elseif IsPedInAnyVehicle(Ped) then
					local Vehicle = GetVehiclePedIsUsing(Ped)
					if IsValidVehicle(Vehicle,Work["vehicles"]) then
						local Coords = GetEntityCoords(Ped)
						local Distance = #(Coords - Work["locations"][Selected])

						if Distance <= 200 then
							TimeDistance = 1

							DrawMarker(22,Work["locations"][Selected]["x"],Work["locations"][Selected]["y"],Work["locations"][Selected]["z"] + 3.0,0.0,0.0,0.0,0.0,180.0,0.0,7.5,7.5,5.0,245,10,70,100,0,0,0,1)
							DrawMarker(1,Work["locations"][Selected]["x"],Work["locations"][Selected]["y"],Work["locations"][Selected]["z"] - 3.0,0.0,0.0,0.0,0.0,0.0,0.0,15.0,15.0,10.0,255,255,255,50,0,0,0,0)

							if Distance <= 10 then
								CompleteService()
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)

function HandleIfoodWork(Ped,Work)
	local TimeDistance = 999
	local Coords = GetEntityCoords(Ped)
	local DeliveryCoords = Work["locations"][Selected]

	if CarryingPizza then
		local Distance = #(Coords - DeliveryCoords)
		if Distance <= 30 then
			TimeDistance = 1
			DrawMarker(21,DeliveryCoords["x"],DeliveryCoords["y"],DeliveryCoords["z"] + 0.2,0.0,0.0,0.0,0.0,180.0,0.0,0.35,0.35,0.25,245,10,70,125,0,0,0,1)

			if Distance <= 1.25 then
				DrawText3D(DeliveryCoords["x"],DeliveryCoords["y"],DeliveryCoords["z"] + 0.35,"Pressione ~g~E~w~ para entregar")

				if IsControlJustPressed(0,38) then
					vRP.Destroy("one")
					CarryingPizza = false
					CompleteService()
				end
			end
		end
	else
		local Vehicle = GetNearestWorkVehicle(Ped,Work["vehicles"])
		if Vehicle and DoesEntityExist(Vehicle) then
			local PickupCoords = GetPizzaPickupCoords(Vehicle)
			local Distance = #(Coords - PickupCoords)

			if Distance <= 10 then
				TimeDistance = 1
				DrawMarker(21,PickupCoords["x"],PickupCoords["y"],PickupCoords["z"] + 0.05,0.0,0.0,0.0,0.0,180.0,0.0,0.35,0.35,0.25,255,120,0,125,0,0,0,1)

				if Distance <= 1.25 and not IsPedInAnyVehicle(Ped) then
					DrawText3D(PickupCoords["x"],PickupCoords["y"],PickupCoords["z"] + 0.35,"Pressione ~g~E~w~ para pegar pizza")

					if IsControlJustPressed(0,38) then
						CarryingPizza = true
						ExecuteCommand("e caixa")
						TriggerEvent("Notify","amarelo","Leve a pizza ate o local da entrega.",5000)
					end
				end
			end
		end
	end

	return TimeDistance
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	local Work = Works[CurrentWork]
	if not Work then
		return
	end

	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Work["locations"][Selected]["x"],Work["locations"][Selected]["y"],Work["locations"][Selected]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipHighDetail(Blip,true)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,Work["blipColor"])
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Work["blipName"])
	EndTextCommandSetBlipName(Blip)
end

function ToggleWork(WorkName)
	local Work = Works[WorkName]
	if not Work then
		return
	end

	if Active and CurrentWork == WorkName then
		StopWork()
		UpdateTargetLabel(WorkName,"Trabalhar")
		TriggerEvent("Notify","verde","Trabalho de "..Work["name"].." finalizado.",5000)
		return
	end

	if Active then
		UpdateTargetLabel(CurrentWork,"Trabalhar")
		if CarryingPizza then
			vRP.Destroy("one")
		end
	end

	CurrentWork = WorkName
	Selected = 1
	Active = true
	CarryingPizza = false
	UpdateTargetLabel(WorkName,"Finalizar")
	TriggerEvent("Notify","verde","Trabalho de "..Work["name"].." iniciado.",5000)
	MakeBlips()
end

function StopWork()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Active = false
	Selected = 1
	CarryingPizza = false
	vRP.Destroy("one")
end

function CompleteService()
	vSERVER.Payment(CurrentWork,Selected)

	if Selected >= #Works[CurrentWork]["locations"] then
		Selected = 1
	else
		Selected = Selected + 1
	end

	MakeBlips()
end

function UpdateTargetLabel(WorkName,Label)
	local Work = Works[WorkName]
	if Work and Work["zone"] then
		exports["target"]:LabelText(Work["zone"],Label)
	end
end

function IsValidVehicle(Vehicle,VehicleList)
	if not VehicleList then
		return false
	end

	local Model = GetEntityModel(Vehicle)
	for Name,_ in pairs(VehicleList) do
		if Model == GetHashKey(Name) then
			return true
		end
	end

	return false
end

function GetNearestWorkVehicle(Ped,VehicleList)
	local Vehicle = 0

	if IsPedInAnyVehicle(Ped) then
		Vehicle = GetVehiclePedIsUsing(Ped)
		if IsValidVehicle(Vehicle,VehicleList) then
			return Vehicle
		end
	end

	local Coords = GetEntityCoords(Ped)
	local ClosestDistance = 15.0

	for _,Entity in pairs(GetGamePool("CVehicle")) do
		if DoesEntityExist(Entity) and IsValidVehicle(Entity,VehicleList) then
			local Distance = #(Coords - GetEntityCoords(Entity))
			if Distance <= ClosestDistance then
				ClosestDistance = Distance
				Vehicle = Entity
			end
		end
	end

	if Vehicle ~= 0 then
		return Vehicle
	end

	return nil
end

function GetPizzaPickupCoords(Vehicle)
	local Offset = -2.0
	local Model = GetEntityModel(Vehicle)

	if IsThisModelABike(Model) or IsThisModelABicycle(Model) then
		Offset = -1.2
	end

	return GetOffsetFromEntityInWorldCoords(Vehicle,0.0,Offset,0.0)
end

function DrawText3D(x,y,z,Text)
	local OnScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
	if OnScreen then
		SetTextFont(4)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,200)
		SetTextCentre(true)
		SetTextOutline()
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringPlayerName(Text)
		EndTextCommandDisplayText(_x,_y)
	end
end
