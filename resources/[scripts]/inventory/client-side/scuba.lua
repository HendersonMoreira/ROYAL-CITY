-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
ScubaMask = nil
ScubaTank = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SCUBAREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ScubaRemove")
AddEventHandler("inventory:ScubaRemove",function()
	if DoesEntityExist(ScubaMask) then
		TriggerServerEvent("DeleteObject",ObjToNet(ScubaMask))
		ScubaMask = nil
	end

	if DoesEntityExist(ScubaTank) then
		TriggerServerEvent("DeleteObject",ObjToNet(ScubaTank))
		ScubaTank = nil
	end

	SetEnableScuba(PlayerPedId(),false)
	SetPedMaxTimeUnderwater(PlayerPedId(),10.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Scuba")
AddEventHandler("inventory:Scuba",function()
	if ScubaMask or ScubaTank then
		TriggerEvent("inventory:ScubaRemove")
	else
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		local Progression,Network = vRPS.CreateObject("p_s_scuba_tank_s",Coords["x"],Coords["y"],Coords["z"])
		if Progression then
			ScubaTank = LoadNetwork(Network)
			AttachEntityToEntity(ScubaTank,Ped,GetPedBoneIndex(Ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
		end

		local Progression,Network = vRPS.CreateObject("p_s_scuba_mask_s",Coords["x"],Coords["y"],Coords["z"])
		if Progression then
			ScubaMask = LoadNetwork(Network)
			AttachEntityToEntity(ScubaMask,Ped,GetPedBoneIndex(Ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
		end

		SetEnableScuba(Ped,true)
		SetPedMaxTimeUnderwater(Ped,9999.0)
	end
end)