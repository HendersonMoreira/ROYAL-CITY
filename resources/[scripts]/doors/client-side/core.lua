-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("doors")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Display = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(GlobalState["Doors"]) do
		local DoorId = tonumber(Number) or Number

		if IsDoorRegisteredWithSystem(DoorId) then
			RemoveDoorFromSystem(DoorId)
		end

		AddDoorToSystem(DoorId,v["Hash"],v["Coords"].x,v["Coords"].y,v["Coords"].z,false,false,false)

		DoorSystemSetOpenRatio(DoorId,0.0,false,true)
		DoorSystemSetAutomaticDistance(DoorId,0.0,false,true)
		DoorSystemSetAutomaticRate(DoorId,5.0,false,true)
		DoorSystemSetDoorState(DoorId,v["Lock"] and 1 or 0,true)

		if v["Lock"] then
			local Entity = GetClosestObjectOfType(v["Coords"].x,v["Coords"].y,v["Coords"].z,3.5,v["Hash"],false,false,false)
			if DoesEntityExist(Entity) then
				SetEntityAsMissionEntity(Entity,true,false)
				FreezeEntityPosition(Entity,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Doors",nil,function(Name,Key,Value)
	for Number,v in pairs(Value) do
		local DoorId = tonumber(Number) or Number
		DoorSystemSetOpenRatio(DoorId,0.0,false,true)
		DoorSystemSetAutomaticDistance(DoorId,0.0,false,true)
		DoorSystemSetAutomaticRate(DoorId,5.0,false,true)
		DoorSystemSetDoorState(DoorId,v["Lock"] and 1 or 0,true)

		local Entity = GetClosestObjectOfType(v["Coords"].x,v["Coords"].y,v["Coords"].z,3.5,v["Hash"],false,false,false)
		if DoesEntityExist(Entity) then
			if v["Lock"] then
				SetEntityAsMissionEntity(Entity,true,false)
				FreezeEntityPosition(Entity,true)
			else
				SetEntityAsNoLongerNeeded(Entity)
				FreezeEntityPosition(Entity,false)
			end
		end

		if v["Other"] then
			local OtherDoorId = tonumber(v["Other"]) or v["Other"]
			DoorSystemSetOpenRatio(OtherDoorId,0.0,false,true)
			DoorSystemSetAutomaticDistance(OtherDoorId,0.0,false,true)
			DoorSystemSetAutomaticRate(OtherDoorId,5.0,false,true)
			DoorSystemSetDoorState(OtherDoorId,v["Lock"] and 1 or 0,true)
		end

		if Display[Number] then
			SendNUIMessage({ Action = "Show", Payload = { "E","Pressione",v["Lock"] and "para destrancar" or "para trancar" } })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(GlobalState["Doors"]) do
			if not v["Disabled"] then
				if #(Coords - v["Coords"]) <= v["Distance"] then
					TimeDistance = 1

					if not Display[Number] then
						SendNUIMessage({ Action = "Show", Payload = { "E","Pressione",v["Lock"] and "para destrancar" or "para trancar" } })
						Display[Number] = true
					end

					if IsControlJustPressed(1,38) then
						vSERVER.Permission(Number)
					end
				else
					if Display[Number] then
						SendNUIMessage({ Action = "Hide" })
						Display[Number] = nil
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)

CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(GlobalState["Doors"]) do
			if not v["Disabled"] and #(Coords - v["Coords"]) <= (v["Distance"] + 15.0) then
				local DoorId = tonumber(Number) or Number

				local LockRadius = math.max(3.5,v["Distance"] + 2.0)
				local Entity = GetClosestObjectOfType(v["Coords"].x,v["Coords"].y,v["Coords"].z,LockRadius,v["Hash"],false,false,false)

				if v["Lock"] then
					DoorSystemSetDoorState(DoorId,1,false,false)
					DoorSystemSetOpenRatio(DoorId,0.0,false,true)
					DoorSystemSetAutomaticDistance(DoorId,0.0,false,true)
					if DoesEntityExist(Entity) then
						SetEntityAsMissionEntity(Entity,true,false)
						FreezeEntityPosition(Entity,true)
					end
				else
					DoorSystemSetDoorState(DoorId,0,false,false)
					DoorSystemSetAutomaticDistance(DoorId,0.0,false,true)
					if DoesEntityExist(Entity) then
						SetEntityAsNoLongerNeeded(Entity)
						FreezeEntityPosition(Entity,false)
					end
				end
			end
		end

		Wait(200)
	end
end)