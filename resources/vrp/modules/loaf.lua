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
REQUEST = Tunnel.getInterface("request")
TASKBAR = Tunnel.getInterface("taskbar")
SURVIVAL = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    SetMapName(ServerName)
    SetGameType(ServerName)
    SetRoutingBucketEntityLockdownMode(0,"inactive")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Phone(Passport)
	local PhoneNumber = "Inativo"
	local source = vRP.Source(Passport)

	if Characters[source] and Characters[source]["Phone"] then
		PhoneNumber = exports["lb-phone"]:FormatNumber(Characters[source]["Phone"])
	else
		local Consult = vRP.Query("smartphone/Phone",{ Passport = Passport })
		if Consult[1] and Consult[1]["phone_number"] then
			PhoneNumber = exports["lb-phone"]:FormatNumber(Consult[1]["phone_number"])

			if Characters[source] then
				Characters[source]["Phone"] = PhoneNumber
			end
		end
	end

	return PhoneNumber
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CleanPhone(Passport)
	local PhoneNumber = false
	local Consult = vRP.Query("smartphone/Phone",{ Passport = Passport })
	if Consult[1] and Consult[1]["phone_number"] then
		PhoneNumber = Consult[1]["phone_number"]
	end

	return PhoneNumber
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Request(source,Message,Accept,Reject)
	return REQUEST.Function(source,Message,Accept or "Sim",Reject or "Não")
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
-- VRP.DEVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Device(source,Seconds)
    return DEVICE.Device(source,Seconds)
end