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
vSERVER = Tunnel.getInterface("trunkchest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Opened = false
local OpenVehicle = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Opened then
		if OpenVehicle and DoesEntityExist(OpenVehicle) then
			SetVehicleDoorShut(OpenVehicle,5,false)
		end

		OpenVehicle = nil
		vSERVER.Close()
		Opened = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:Open")
AddEventHandler("trunkchest:Open",function()
	Opened = true
	TriggerEvent("inventory:Open",{
		Type = "Chest",
		Resource = "trunkchest"
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK DOOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:Door")
AddEventHandler("trunkchest:Door",function(Net)
	local Vehicle = NetToVeh(Net)
	if DoesEntityExist(Vehicle) then
		OpenVehicle = Vehicle
		SetVehicleDoorOpen(Vehicle,5,false,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Take(Data["slot"],Data["amount"],Data["target"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"])
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
	local Primary,Secondary,PrimaryWeight,SecondaryWeight = vSERVER.Mount()
	if Primary then
		Callback({ Primary = Primary, Secondary = Secondary, PrimaryMaxWeight = PrimaryWeight, SecondaryMaxWeight = SecondaryWeight })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGEUP TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+openTrunkPageUp",function()
	local Ped = PlayerPedId()
	if GetEntityHealth(Ped) <= 100 then
		return
	end

	if Opened then
		return
	end

	local Vehicle = 0
	local Coords = GetEntityCoords(Ped)

	if IsPedInAnyVehicle(Ped,false) then
		Vehicle = GetVehiclePedIsUsing(Ped)
	else
		Vehicle = vRP.ClosestVehicle(7)
		if not Vehicle or Vehicle == 0 or not DoesEntityExist(Vehicle) then
			return
		end

		if GetVehicleDoorLockStatus(Vehicle) > 1 then
			TriggerEvent("Notify","Aviso","Veículo trancado.","amarelo",5000)
			return
		end

		local Bone = GetEntityBoneIndexByName(Vehicle,"boot")
		if Bone == -1 then
			return
		end

		local BoneCoords = GetWorldPositionOfEntityBone(Vehicle,Bone)
		if #(Coords - BoneCoords) > 2.0 then
			TriggerEvent("Notify","Aviso","Chegue mais perto do porta-malas.","amarelo",5000)
			return
		end
	end

	local Plate = GetVehicleNumberPlateText(Vehicle)
	local Model = GetDisplayNameFromVehicleModel(GetEntityModel(Vehicle))
	local Network = NetworkGetNetworkIdFromEntity(Vehicle)

	TriggerServerEvent("trunkchest:openTrunk",{
		Plate,
		string.lower(Model),
		Vehicle,
		Network
	})
end)

RegisterCommand("-openTrunkPageUp",function()
end)

RegisterKeyMapping("+openTrunkPageUp","Abrir Porta-Malas","keyboard","PAGEUP")