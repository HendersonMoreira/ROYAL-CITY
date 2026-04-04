-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- GRAB
-----------------------------------------------------------------------------------------------------------------------------------------
local Grab = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("grab:Start")
AddEventHandler("grab:Start",function(targetId)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return
	end

	if not vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão.",5000)
		return
	end

	if not targetId or source == targetId then
		return
	end

	if Grab[source] or Grab[targetId] then
		TriggerClientEvent("Notify",source,"amarelo","Um dos jogadores já está sendo usado.",5000)
		return
	end

	Grab[source] = targetId
	Grab[targetId] = source

	TriggerClientEvent("grab:ConfirmStart",source,targetId)
	TriggerClientEvent("grab:StartCarry",targetId,source)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("grab:Stop")
AddEventHandler("grab:Stop",function(targetId)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return
	end

	if not vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão.",5000)
		return
	end

	if not targetId then
		return
	end

	Grab[source] = nil
	Grab[targetId] = nil

	TriggerClientEvent("grab:StopCarry",source)
	TriggerClientEvent("grab:StopCarry",targetId)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER DROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function()
	local source = source
	local other = Grab[source]

	if other then
		Grab[other] = nil
		TriggerClientEvent("grab:StopCarry",other)
	end

	Grab[source] = nil
end)