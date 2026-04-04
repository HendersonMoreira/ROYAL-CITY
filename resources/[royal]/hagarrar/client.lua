-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local carrying = false
local carried = false
local targetServerId = nil
local carrierServerId = nil

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local GRAB_KEY = 74 -- H
local GRAB_DISTANCE = 2.0

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET CLOSEST PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local function GetClosestPlayer(radius)
	local players = GetActivePlayers()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	local closestDistance = -1
	local closestPlayer = -1

	for _,player in ipairs(players) do
		local targetPed = GetPlayerPed(player)

		if targetPed ~= ped then
			local targetCoords = GetEntityCoords(targetPed)
			local distance = #(coords - targetCoords)

			if closestDistance == -1 or distance < closestDistance then
				closestPlayer = player
				closestDistance = distance
			end
		end
	end

	if closestDistance ~= -1 and closestDistance <= radius then
		return closestPlayer,closestDistance
	end

	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- START CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("grab:StartCarry")
AddEventHandler("grab:StartCarry",function(sourceId)
	local ped = PlayerPedId()
	local targetPlayer = GetPlayerFromServerId(sourceId)

	if targetPlayer == -1 then
		return
	end

	local targetPed = GetPlayerPed(targetPlayer)

	carried = true
	carrierServerId = sourceId

	AttachEntityToEntity(ped,targetPed,11816,0.15,0.45,0.0,0.0,0.0,0.0,false,false,false,false,2,false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOP CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("grab:StopCarry")
AddEventHandler("grab:StopCarry",function()
	local ped = PlayerPedId()

	carrying = false
	carried = false
	targetServerId = nil
	carrierServerId = nil

	DetachEntity(ped,true,false)
	ClearPedTasksImmediately(ped)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KEY H
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(1)

		if IsControlJustPressed(0,GRAB_KEY) then
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) then
				TriggerEvent("Notify","amarelo","Você não pode agarrar dentro do veículo.",5000)
			elseif carried then
				TriggerEvent("Notify","amarelo","Você está sendo agarrado.",5000)
			else
				if carrying then
					TriggerServerEvent("grab:Stop",targetServerId)
					carrying = false
					targetServerId = nil
					ClearPedTasksImmediately(ped)
				else
					local closestPlayer = GetClosestPlayer(GRAB_DISTANCE)

					if closestPlayer then
						local serverId = GetPlayerServerId(closestPlayer)
						TriggerServerEvent("grab:Start",serverId)
					else
						TriggerEvent("Notify","vermelho","Nenhum jogador próximo.",5000)
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIRM START
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("grab:ConfirmStart")
AddEventHandler("grab:ConfirmStart",function(serverId)
	carrying = true
	targetServerId = serverId
end)