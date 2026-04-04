-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("painel",Creative)
vCLIENT = Tunnel.getInterface("painel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Information = {}
local HierarchyButtons = 2
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENGROUPPANEL
-----------------------------------------------------------------------------------------------------------------------------------------
local function OpenGroupPanel(source,Passport,Permission)
	local Members = {}
	local Entitys = vRP.DataGroups(Permission) or {}
	local Hierarchy = vRP.Hierarchy(Permission)

	if not Hierarchy then
		TriggerClientEvent("Notify",source,"Atenção","A hierarquia do grupo não foi configurada.","amarelo",5000)
		return
	end

	for Index,Number in pairs(Entitys) do
		local OtherPassport = parseInt(Index)
		local Identity = vRP.Identity(OtherPassport)
		local OtherSource = vRP.Source(OtherPassport)
		if Identity then
			local Calculated = CompleteTimers(os.time() - Identity["Login"])
			local Activated = "Inativo a "..Calculated

			if OtherSource then
				Activated = "Ativo a "..Calculated
			end

			Members[#Members + 1] = {
				["id"] = OtherPassport,
				["online"] = OtherSource,
				["name"] = Identity["name"].." "..Identity["name2"],
				["role"] = Hierarchy[Number] or "Membro",
				["phone"] = Activated,
				["role_id"] = Number
			}
		end
	end

	Information[Passport] = Permission

	vCLIENT.Open(source,{ Permission,Members,Passport,vRP.HasPermission(Passport,Permission),HierarchyButtons,#Hierarchy })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painel",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and not Player(source)["state"]["Buttons"] then
		local Permission = vRP.GetUserType(Passport,"Work")

		if Message[1] then
			Permission = Message[1]

			if vRP.GroupType(Permission) == "Work" or not vRP.HasPermission(Passport,Permission) then
				return false
			end
		end

		if Permission then
			OpenGroupPanel(source,Passport,Permission)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINELMEDICO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painelmedico",function(source)
	local Passport = vRP.Passport(source)
	if Passport and not Player(source)["state"]["Buttons"] then
		if not vRP.HasPermission(Passport,"Paramedico") and vRP.GetUserType(Passport,"Work") ~= "Paramedico" then
			TriggerClientEvent("Notify",source,"Atenção","Apenas médicos podem abrir este painel.","amarelo",5000)
			return
		end

		OpenGroupPanel(source,Passport,"Paramedico")
	end
end)

RegisterCommand("pmedico",function(source)
	local Passport = vRP.Passport(source)
	if Passport and not Player(source)["state"]["Buttons"] then
		if not vRP.HasPermission(Passport,"Paramedico") and vRP.GetUserType(Passport,"Work") ~= "Paramedico" then
			TriggerClientEvent("Notify",source,"Atenção","Apenas médicos podem abrir este painel.","amarelo",5000)
			return
		end

		OpenGroupPanel(source,Passport,"Paramedico")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMISS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Dismiss(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Information[Passport] and Passport ~= OtherPassport and vRP.HasGroup(Passport,Information[Passport],HierarchyButtons) and vRP.HasPermission(OtherPassport,Information[Passport]) >= HierarchyButtons then
		TriggerClientEvent("Notify",source,"Sucesso","Passaporte removido.","verde",5000)
		vRP.RemovePermission(OtherPassport,Information[Passport])

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Invite(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(OtherPassport)
	local OtherSource = vRP.Source(OtherPassport)
	if Passport and Identity and OtherSource and Information[Passport] and Passport ~= OtherPassport and vRP.HasGroup(Passport,Information[Passport],HierarchyButtons) then
		local Permission = Information[Passport]
		local GroupType = vRP.GroupType(Permission)

		if GroupType == "Work" and Identity["Groups"] >= os.time() then
			TriggerClientEvent("Notify",source,"Atenção","O passaporte escolhido não pode ser convidado para um grupo no momento.","amarelo",5000)

			return false
		end

		if not GroupType or GroupType ~= "Work" or (GroupType == "Work" and not vRP.GetUserType(OtherPassport,"Work")) then
			if vRP.Request(OtherSource,"Grupos","Você foi convidado(a) para participar do grupo <b>"..Permission.."</b>, gostaria de estar entrando do mesmo?") then
				vRP.SetPermission(OtherPassport,Permission)
				TriggerClientEvent("Notify",source,"Sucesso","Passaporte adicionado.","verde",5000)

				local Hierarchy = vRP.Hierarchy(Permission)
				local Number = vRP.HasPermission(OtherPassport,Permission)

				return {
					["id"] = OtherPassport,
					["online"] = vRP.Source(OtherPassport),
					["name"] = Identity["name"].." "..Identity["name2"],
					["phone"] = vRP.Phone(OtherPassport),
					["role"] = Hierarchy[Number],
					["role_id"] = Number
				}
			else
				TriggerClientEvent("Notify",source,"Atenção","Convite para o grupo recusado.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","O passaporte já pertence a outro grupo.","amarelo",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Hierarchy(OtherPassport,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Information[Passport] and Passport ~= OtherPassport and vRP.Identity(OtherPassport) and vRP.HasGroup(Passport,Information[Passport],HierarchyButtons) and ((Mode == "Demote" and vRP.HasPermission(OtherPassport,Information[Passport]) >= HierarchyButtons) or (Mode ~= "Demote" and vRP.HasPermission(OtherPassport,Information[Passport]) > HierarchyButtons)) then
		vRP.SetPermission(OtherPassport,Information[Passport],nil,Mode)
		TriggerClientEvent("Notify",source,"Sucesso","Hierarquia atualizada.","verde",5000)

		local Permission = Information[Passport]
		local Hierarchy = vRP.Hierarchy(Permission)
		local Number = vRP.HasPermission(OtherPassport,Permission)

		return { Hierarchy[Number],Number }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Information[Passport] then
		Information[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end
end)