-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Boxes = 0
local Cooldown = os.time()
local LastScheduleKey = nil
local LastGameScheduleKey = nil
local HelicrashEndsAt = 0
local HelicrashHotUntil = 0

local function GetScheduleTime()
	local Offset = TimerTimezoneOffset or 0
	local Timestamp = os.time() + (Offset * 3600)
	return os.date("!%H:%M",Timestamp),os.date("!%Y-%m-%d %H:%M",Timestamp)
end

local function StopHelicrash()
	if GlobalState["Helicrash"] then
		GlobalState["Helicrash"] = false
		GlobalState["HelicrashHot"] = false
		GlobalState["HelicrashEndsAt"] = 0
		GlobalState["HelicrashHotUntil"] = 0
		TriggerClientEvent("helicrash:Stop",-1)
	end

	HelicrashEndsAt = 0
	HelicrashHotUntil = 0
	Boxes = 0
end

local function StartHelicrash(Selected)
	if GlobalState["Helicrash"] then
		StopHelicrash()
	end

	Boxes = 0
	Selected = Selected or math.random(#Components)

	for Number,v in pairs(Components[Selected]) do
		if Number ~= "1" then
			Boxes = Boxes + 1

			local Loot = math.random(#Loots)
			vRP.RemSrvData("Chest:Helicrash"..Number,false)
			vRP.SetSrvData("Chest:Helicrash"..Number,Loots[Loot],false)
		end
	end

	TriggerClientEvent("Notify",-1,"azul","Um helicóptero de suprimentos da Royal caiu! Verifique o mapa (tecla M) para encontrar a localização.",5000)
	HelicrashEndsAt = os.time() + (HelicrashDuration or 1800)
	HelicrashHotUntil = os.time() + (HelicrashHotDuration or 600)
	GlobalState["Helicrash"] = Selected
	GlobalState["HelicrashHot"] = true
	GlobalState["HelicrashEndsAt"] = HelicrashEndsAt
	GlobalState["HelicrashHotUntil"] = HelicrashHotUntil
	TriggerClientEvent("helicrash:Start",-1,Selected)
	if not UseGameClock then
		Cooldown = os.time() + 3600
	end
	print("^2[helicrash]^7 Ativo no ponto "..Selected.." em "..GetScheduleTime())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Helicrash"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if GlobalState["Helicrash"] and GlobalState["HelicrashHot"] and HelicrashHotUntil > 0 and os.time() >= HelicrashHotUntil then
			GlobalState["HelicrashHot"] = false
		end

		if GlobalState["Helicrash"] and HelicrashEndsAt > 0 and os.time() >= HelicrashEndsAt then
			StopHelicrash()
		end

		if not UseGameClock then
			local CurrentMinute,CurrentScheduleKey = GetScheduleTime()
			if Timers[CurrentMinute] and LastScheduleKey ~= CurrentScheduleKey and os.time() >= Cooldown then
				LastScheduleKey = CurrentScheduleKey
				StartHelicrash()
			end
		end

		Wait(1000)
	end
end)

RegisterNetEvent("helicrash:SyncClock")
AddEventHandler("helicrash:SyncClock",function(Hours,Minutes)
	if not UseGameClock then
		return
	end

	Hours = tonumber(Hours)
	Minutes = tonumber(Minutes)

	if not Hours or not Minutes then
		return
	end

	local ScheduleKey = string.format("%02d:%02d",Hours,Minutes)
	if not Timers[ScheduleKey] then
		return
	end

	if LastGameScheduleKey == ScheduleKey then
		return
	end

	LastGameScheduleKey = ScheduleKey
	StartHelicrash()
end)

RegisterCommand("helicrashstart",function(source,Message)
	if source ~= 0 then
		return
	end

	local Selected = tonumber(Message[1])
	if Selected and not Components[Selected] then
		print("^1[helicrash]^7 Ponto invalido. Use 1 a "..#Components..".")
		return
	end

	StartHelicrash(Selected)
end)

RegisterCommand("helicrashstop",function(source)
	if source ~= 0 then
		return
	end

	StopHelicrash()
	print("^3[helicrash]^7 Evento encerrado manualmente.")
end)

RegisterCommand("helicrashstatus",function(source)
	if source ~= 0 then
		return
	end

	local Current = GlobalState["Helicrash"]
	if Current and Components[Current] then
		local CrashCoords = Components[Current]["1"][1]
		print(("^2[helicrash]^7 Ativo no ponto %s | x: %.2f y: %.2f z: %.2f"):format(Current,CrashCoords.x,CrashCoords.y,CrashCoords.z))
		print("^2[helicrash]^7 Termina em: "..math.max(0,HelicrashEndsAt - os.time()).."s | Esfria em: "..math.max(0,HelicrashHotUntil - os.time()).."s")
	else
		local CurrentMinute = GetScheduleTime()
		print("^3[helicrash]^7 Inativo. Hora calculada atual: "..CurrentMinute)
	end
	print("^3[helicrash]^7 Cooldown restante: "..math.max(0,Cooldown - os.time()).."s")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOX
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Box",function()
	if GlobalState["Helicrash"] then
		Boxes = Boxes - 1

		if Boxes <= 0 then
			StopHelicrash()
		end
	end
end)