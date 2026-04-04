-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy = module("lib/Proxy")
Tunnel = module("lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = {}
tvRP = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
DEVICE = Tunnel.getInterface("device")
MEMORY = Tunnel.getInterface("memory")
REQUEST = Tunnel.getInterface("request")
TASKBAR = Tunnel.getInterface("taskbar")
SURVIVAL = Tunnel.getInterface("survival")
SAFECRACK = Tunnel.getInterface("safecrack")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetMapName(ServerName)
	SetGameType(ServerName)
	SetRoutingBucketEntityLockdownMode(0, "relaxed")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPhone(Phone)
	return vRP.Query("characters/getPhone",{ phone = Phone })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Phone(Passport)
	local PhoneNumber = "Inativo"
	local source = vRP.Source(Passport)

	if Characters[source] and Characters[source]["phone"] then
		PhoneNumber = Characters[source]["phone"]
	else
		local Query = vRP.Query("characters/Person", { Passport = Passport })
		if Query[1] and Query[1]["phone"] then
			PhoneNumber = Query[1]["phone"]

			if Characters[source] then
				Characters[source]["phone"] = PhoneNumber
			end
		else
			PhoneNumber = GeneratePhone()
			vRP.Query("characters/updatePhone",{ Passport = Passport, phone = PhoneNumber })
		end
	end

	return PhoneNumber
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CleanPhone(Passport)
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:SERVICE_REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("smartphone:service_request",function(Data)
	local Answered = false
	local Service = vRP.NumPermission(Data["service"]["permission"])

	for Passport,Sources in pairs(Service) do
		async(function()
			TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Chamado", text = Data["content"], name = Data["name"], phone = Data["phone"], x = Data["location"][1], y = Data["location"][2], z = Data["location"][3], color = 2 })

			if vRP.Request(Sources,"Chamado","Aceitar o chamado de <b>"..Data["name"].."?") then
				if not Answered then
					Answered = true
					TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_RESPONSE",{})
					TriggerClientEvent("smartphone:pusher",Sources,"GPS",{ location = Data["location"] })
				else
					TriggerClientEvent("Notify",Sources,"Sucesso","Chamado atendido.","verde",5000)
				end
			end
		end)
	end

	SetTimeout(30000,function()
		if not Answered then
			TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_REJECT",{})
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:IS_SERVICE_CUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("smartphone:is_service_custom",function(_,Reply)
	Reply(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Request(source,Title,Message)
	return REQUEST.Function(source,Title,Message)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Revive(source,Health,Arena)
	return SURVIVAL.Revive(source,Health,Arena)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.TASK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Task(source,Amount,Speed)
	return TASKBAR.Task(source,Amount,Speed)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.MEMORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Memory(source)
	return MEMORY.Memory(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.SAFECRACK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Safecrack(source,Number)
	return SAFECRACK.Safecrack(source,Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.DEVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Device(source,Seconds)
    return DEVICE.Device(source,Seconds)
end