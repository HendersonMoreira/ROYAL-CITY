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

local function GetDoorEntities(v,radius)
	local SearchRadius = radius or math.max(2.0,v["Distance"] + 1.0)
	local Hash = tonumber(v["Hash"]) or 0
	local Hashes = { Hash, math.abs(Hash), -math.abs(Hash) }
	local Added = {}
	local Entities = {}

	if v["ExtraHashes"] then
		for _,ExtraHash in ipairs(v["ExtraHashes"]) do
			table.insert(Hashes,tonumber(ExtraHash) or 0)
		end
	end

	for _,Model in ipairs(Hashes) do
		if Model ~= 0 and not Added[Model] then
			Added[Model] = true
			local Entity = GetClosestObjectOfType(v["Coords"].x,v["Coords"].y,v["Coords"].z,SearchRadius,Model,false,false,false)
			if DoesEntityExist(Entity) then
				table.insert(Entities,Entity)
			end
		end
	end

	return Entities
end

local function SyncDoorEntity(v,locked,radius)
	local Entities = GetDoorEntities(v,radius)
	if #Entities <= 0 then
		return
	end

	for _,Entity in ipairs(Entities) do
		if locked then
			SetEntityAsMissionEntity(Entity,true,false)
			SetEntityCollision(Entity,true,true)
			FreezeEntityPosition(Entity,true)
		else
			FreezeEntityPosition(Entity,false)
			SetEntityAsNoLongerNeeded(Entity)
		end
	end
end
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

		SyncDoorEntity(v,v["Lock"],3.5)
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

		SyncDoorEntity(v,v["Lock"],3.5)

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

				if v["Lock"] then
					DoorSystemSetDoorState(DoorId,1,false,false)
					DoorSystemSetOpenRatio(DoorId,0.0,false,true)
					DoorSystemSetAutomaticDistance(DoorId,0.0,false,true)
					SyncDoorEntity(v,true,5.0)
				else
					DoorSystemSetDoorState(DoorId,0,false,false)
					DoorSystemSetAutomaticDistance(DoorId,0.0,false,true)
					SyncDoorEntity(v,false,5.0)
				end
			end
		end

		Wait(200)
	end
end)
