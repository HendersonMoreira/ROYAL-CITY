-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("admin",Creative)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("bucket",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) and Message[1] then
            local Route = parseInt(Message[1])
            if Message[2] then
                local OtherPassport = parseInt(Message[2])
                local OtherSource = vRP.Source(OtherPassport)
                if OtherSource then
                    if Route > 0 then
                        exports["vrp"]:Bucket(OtherSource,"Enter",Route)
                    else
                        exports["vrp"]:Bucket(OtherSource,"Exit")
                    end
                end
            else
                if Route > 0 then
                    exports["vrp"]:Bucket(source,"Enter",Route)
                else
                    exports["vrp"]:Bucket(source,"Exit")
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Number = 0
		local Message = ""
		local Players = vRP.Players()
		local Amounts = CountTable(Players)
		for OtherPassport in pairs(Players) do
			Number = Number + 1
			Message = Message..OtherPassport..(Number < Amounts and ", " or "")
		end

		TriggerClientEvent("chat:ClientMessage",source,"JOGADORES CONECTADOS",Message,"OOC")
		TriggerClientEvent("Notify",source,"Listagem","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),"verde",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skinshop",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("skinshop:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skinweapon",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("skinweapon:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ls",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("lscustoms:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Message[1]) > 0 then
		local Messages = ""
		local Groups = vRP.Groups()
		local OtherPassport = Message[1]
		for Permission,_ in pairs(Groups) do
			local Data = vRP.DataGroups(Permission)
			if Data[OtherPassport] then
				Messages = Messages..Permission.."<br>"
			end
		end

		if Messages ~= "" then
			TriggerClientEvent("Notify",source,"Grupos Pertencentes",Messages,"verde",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("usource",function(source,Message)
	local Passport = vRP.Passport(source)
	local OtherSource = parseInt(Message[1])
	if Passport and OtherSource and OtherSource > 0 and vRP.Passport(OtherSource) and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"Informações","<b>Passaporte:</b> "..vRP.Passport(OtherSource),"default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cam",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("freecam:Active",source,Message)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(Message[1]) > 0 then
			local Target = parseInt(Message[1])

			vRP.ClearInventory(Target)
			TriggerClientEvent("Notify",source,"Sucesso","Limpeza concluída.","verde",5000)

			exports["discord"]:Embed("ClearInv",
				"**[ADMIN]:** "..Passport..
				"\n**[PASSAPORTE LIMPO]:** "..Target..
				"\n**[COMANDO]:** /clearinv "..Target..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMA LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dima",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Amount = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				TriggerClientEvent("Notify",source,"Sucesso","Diamantes entregues.","verde",5000)
				vRP.UpgradeGemstone(Message[1],Message[2],true)
				exports["discord"]:Embed("Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			vRPC.BlipAdmin(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		if Message[1] then
			local OtherPassport = parseInt(Message[1])
			local OtherSource = vRP.Source(OtherPassport)
			if OtherSource then
				vRP.Revive(OtherSource,200)
				vRP.UpgradeThirst(OtherPassport,100)
				vRP.UpgradeHunger(OtherPassport,100)
				vRP.DowngradeStress(OtherPassport,100)
				TriggerClientEvent("paramedic:Reset",OtherSource)

				exports["discord"]:Embed("God","**[ADMIN]:** "..Passport.."\n**[PASSAPORTE]:** "..OtherPassport.."\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"))
			end
		else
			vRP.Revive(source,200)
			vRP.Armour(source,100)
			vRP.UpgradeThirst(Passport,100)
			vRP.UpgradeHunger(Passport,100)
			vRP.DowngradeStress(Passport,100)
			TriggerClientEvent("paramedic:Reset",source)

			exports["discord"]:Embed("God","**[ADMIN]:** "..Passport.."\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",2) then
		if not Message[1] then
			local Keyboard = vKEYBOARD.Item(source,"Passaporte","Item","Quantidade",{ "Jogador","Todos","Area" },"Distância")
			if Keyboard and ItemExist(Keyboard[2]) then
				local Item = Keyboard[2]
				local Action = Keyboard[4]
				local OtherPassport = Keyboard[1]
				local Amount = parseInt(Keyboard[3],true)
				local Distance = parseInt(Keyboard[5],true)

				if Action == "Jogador" then
					if vRP.Source(OtherPassport) then
						vRP.GenerateItem(OtherPassport,Item,Amount,true)
						TriggerClientEvent("Notify",source,"Sucesso","Entregue ao destinatário.","verde",5000)
					else
						local Selected = GenerateString("DDLLDDLL")
						local Consult = vRP.GetSrvData("Offline:"..OtherPassport,true)

						repeat
							Selected = GenerateString("DDLLDDLL")
						until Selected and not Consult[Selected]

						TriggerClientEvent("Notify",source,"Sucesso","Adicionado a lista de entregas.","verde",5000)
						Consult[Selected] = { ["Item"] = Item, ["Amount"] = Amount }
						vRP.SetSrvData("Offline:"..OtherPassport,Consult,true)
					end
				elseif Action == "Todos" then
					local List = vRP.Players()
					for OtherPlayer,_ in pairs(List) do
						async(function()
							vRP.GenerateItem(OtherPlayer,Item,Amount,true)
						end)
					end
				elseif Action == "Area" then
					local PlayerList = GetPlayers()
					local Coords = vRP.GetEntityCoords(source)

					for _,OtherSource in ipairs(PlayerList) do
						async(function()
							local OtherSource = parseInt(OtherSource)
							local OtherPassport = vRP.Passport(OtherSource)
							local OtherCoords = vRP.GetEntityCoords(OtherSource)

							if OtherCoords and OtherPassport and #(Coords - OtherCoords) <= Distance then
								vRP.GenerateItem(OtherPassport,Item,Amount,true)
							end
						end)
					end
				end

				exports["discord"]:Embed("Item","**[ADMIN]:** "..Passport.."\n**[PASSAPORTE]:** "..OtherPassport.."\n**[ITEM]:** "..Item.."\n**[QUANTIDADE]:** "..Amount.."x\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"))
			end
		elseif Message[1] and Message[2] then
			vRP.GenerateItem(Passport,Message[1],Message[2],true)
			exports["discord"]:Embed("Item","**[ADMIN]:** "..Passport.."\n**[ITEM]:** "..Message[1].."\n**[QUANTIDADE]:** "..Message[2].."x\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"))
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local OtherPassport = parseInt(Message[1])

			vRP.Query("characters/removeCharacter",{ id = OtherPassport })
			TriggerClientEvent("Notify",source,"Sucesso","Personagem <b>"..Message[1].."</b> deletado.","verde",5000)

			exports["discord"]:Embed("DeleteChar",
				"**[ADMIN]:** "..Passport..
				"\n**[PASSAPORTE DELETADO]:** "..OtherPassport..
				"\n**[COMANDO]:** /delete "..OtherPassport..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NC LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        -- Adicionado o 'or' para verificar a segunda permissão
        if vRP.HasGroup(Passport,"Devteste",1) or vRP.HasGroup(Passport,"Admin",10) then
            local Ped = GetPlayerPed(source)
            local Coords = GetEntityCoords(Ped)

            vRPC.noClip(source)

            exports["discord"]:Embed("NoClip",
                "**[ADMIN]:** "..Passport..
                "\n**[COMANDO]:** /nc"..
                "\n**[CDS]:** "..string.format("%.2f, %.2f, %.2f",Coords["x"],Coords["y"],Coords["z"])..
                "\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
            )
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local OtherSource = vRP.Source(OtherPassport)

			if OtherSource then
				local Ped = GetPlayerPed(OtherSource)
				local Coords = GetEntityCoords(Ped)

				TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..OtherPassport.."</b> expulso.","verde",5000)

				exports["discord"]:Embed("Kick",
					"**[ADMIN]:** "..Passport..
					"\n**[PASSAPORTE EXPULSO]:** "..OtherPassport..
					"\n**[CDS DO JOGADOR]:** "..string.format("%.2f, %.2f, %.2f",Coords["x"],Coords["y"],Coords["z"])..
					"\n**[COMANDO]:** /kick "..OtherPassport..
					"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
				)

				vRP.Kick(OtherSource,"Expulso da cidade.")
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Days = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)

			if Identity and Identity["license"] then
				local Coords = "Offline"
				local OtherSource = vRP.Source(OtherPassport)

				if OtherSource then
					local Ped = GetPlayerPed(OtherSource)
					if Ped and Ped > 0 then
						local EntityCoords = GetEntityCoords(Ped)
						Coords = string.format("%.2f, %.2f, %.2f",EntityCoords["x"],EntityCoords["y"],EntityCoords["z"])
					end
				end

				vRP.Query("banneds/InsertBanned",{ license = Identity["license"], time = Days })

				exports["discord"]:Embed("Ban",
					"**[ADMIN]:** "..Passport..
					"\n**[PASSAPORTE BANIDO]:** "..OtherPassport..
					"\n**[TEMPO]:** "..Days.." dias"..
					"\n**[CDS DO JOGADOR]:** "..Coords..
					"\n**[COMANDO]:** /ban "..OtherPassport.." "..Days..
					"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
				)

				TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.","verde",5000)

				if OtherSource then
					vRP.Kick(OtherSource,"Banido.")
				end
			else
				TriggerClientEvent("Notify",source,"Aviso","Passaporte inválido ou sem license.","amarelo",5000)
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)

			if Identity and Identity["license"] then
				vRP.Query("banneds/RemoveBanned",{ license = Identity["license"] })
				TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..OtherPassport.."</b> desbanido.","verde",5000)

				exports["discord"]:Embed("Unban",
					"**[ADMIN]:** "..Passport..
					"\n**[PASSAPORTE DESBANIDO]:** "..OtherPassport..
					"\n**[COMANDO]:** /unban "..OtherPassport..
					"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
				)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.Primary(source,"Cordenadas:")
			if Keyboard then
				local Split = splitString(Keyboard[1],",")
				vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vKEYBOARD.Copy(source,"Cordenadas:",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"])..","..Optimize(heading))
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("admin:ToggleDebug",source)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP logs
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(Message[1]) > 0 and Message[2] or Passport == 67 then
			local OtherPassport = parseInt(Message[1])
			local Permission = Message[2]
			local Level = Message[3]

			vRP.SetPermission(OtherPassport,Permission,Level)
			TriggerClientEvent("Notify",source,"Sucesso","Adicionado <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.","verde",5000)

			exports["discord"]:Embed("Group",
				"**[ADMIN]:** "..Passport..
				"\n**[PASSAPORTE]:** "..OtherPassport..
				"\n**[GRUPO]:** "..Permission..
				"\n**[NÍVEL]:** "..tostring(Level or "N/A")..
				"\n**[COMANDO]:** /group "..OtherPassport.." "..Permission..(Level and (" "..Level) or "")..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(Message[1]) > 0 and Message[2] then
			local OtherPassport = parseInt(Message[1])
			local Permission = Message[2]

			vRP.RemovePermission(OtherPassport,Permission)
			TriggerClientEvent("Notify",source,"Sucesso","Removido <b>"..Permission.."</b> do passaporte <b>"..OtherPassport.."</b>.","verde",5000)

			exports["discord"]:Embed("UnGroup",
				"**[ADMIN]:** "..Passport..
				"\n**[PASSAPORTE]:** "..OtherPassport..
				"\n**[GRUPO REMOVIDO]:** "..Permission..
				"\n**[COMANDO]:** /ungroup "..OtherPassport.." "..Permission..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME logs
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",10) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local ClosestPed = vRP.Source(OtherPassport)

			if ClosestPed then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)

				vRP.Teleport(ClosestPed,Coords["x"],Coords["y"],Coords["z"])

				exports["discord"]:Embed("TpToMe",
					"**[ADMIN]:** "..Passport..
					"\n**[PASSAPORTE PUXADO]:** "..OtherPassport..
					"\n**[CDS DESTINO]:** "..string.format("%.2f, %.2f, %.2f",Coords["x"],Coords["y"],Coords["z"])..
					"\n**[COMANDO]:** /tptome "..OtherPassport..
					"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
				)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO logs
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",10) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local ClosestPed = vRP.Source(OtherPassport)

			if ClosestPed then
				local Ped = GetPlayerPed(ClosestPed)
				local Coords = GetEntityCoords(Ped)

				vRP.Teleport(source,Coords["x"],Coords["y"],Coords["z"])

				exports["discord"]:Embed("TpTo",
					"**[ADMIN]:** "..Passport..
					"\n**[PASSAPORTE DESTINO]:** "..OtherPassport..
					"\n**[CDS DESTINO]:** "..string.format("%.2f, %.2f, %.2f",Coords["x"],Coords["y"],Coords["z"])..
					"\n**[COMANDO]:** /tpto "..OtherPassport..
					"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
				)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",10) then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) <= 100 then
		vCLIENT.teleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local vehicle = vRPC.VehicleHash(source)
			if vehicle then
				vKEYBOARD.Copy(source,"Hash:",vehicle)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING LOGS MECHE DEPOIS COM ERRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Vehicle = GetVehiclePedIsIn(Ped,false)

			local Spawn = "Fora de veículo"
			local Hash = "N/A"
			local Plate = "Sem placa"
			local Owner = "Desconhecido"

			if Vehicle and Vehicle ~= 0 then
				local Model = GetEntityModel(Vehicle)
				Spawn = GetDisplayNameFromVehicleModel(Model)
				Hash = tostring(Model)
				Plate = GetVehicleNumberPlateText(Vehicle)

				if vRP.PassportPlate then
					local VehiclePassport = vRP.PassportPlate(Plate)
					if VehiclePassport then
						Owner = VehiclePassport
					end
				elseif vRP.VehicleOwner then
					local VehiclePassport = vRP.VehicleOwner(Plate)
					if VehiclePassport then
						Owner = VehiclePassport
					end
				elseif vRP.PassportByPlate then
					local VehiclePassport = vRP.PassportByPlate(Plate)
					if VehiclePassport then
						Owner = VehiclePassport
					end
				end
			end

			TriggerClientEvent("admin:Tuning",source)

			exports["discord"]:Embed("Tuning",
				"**[ADMIN]:** "..Passport..
				"\n**[COMANDO]:** /tuning"..
				"\n**[SPAWN]:** "..tostring(Spawn)..
				"\n**[HASH]:** "..tostring(Hash)..
				"\n**[PLACA]:** "..tostring(Plate)..
				"\n**[PROPRIETÁRIO]:** "..tostring(Owner)..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Vehicle,Network,Plate = vRPC.VehicleList(source)
		if Vehicle then
			local Players = vRP.Players(source)
			for _,OtherSource in pairs(Players) do
				async(function()
					TriggerClientEvent("target:RollVehicle",OtherSource,Network)
					TriggerClientEvent("inventory:RepairAdmin",OtherSource,Network,Plate)
				end)
			end

			exports["discord"]:Embed("Fix",
				"**[ADMIN]:** "..Passport..
				"\n**[COMANDO]:** /fix"..
				"\n**[PLACA]:** "..tostring(Plate)..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.Archive(Passport..".txt",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"])..","..Optimize(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anuciar",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if not Passport then
		return
	end

	if not vRP.HasGroup(Passport,"Admin") then
		TriggerClientEvent("Notify",source,"Negado","Você não tem permissão.","vermelho",5000)
		return
	end

	local Text = table.concat(Message," ")
	if Text == "" then
		TriggerClientEvent("Notify",source,"Aviso","Digite uma mensagem.","amarelo",5000)
		return
	end

	TriggerClientEvent("Notify",-1,"Ceo",Text,"azul",60000)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"Governador",History:sub(8),"vermelho",60000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	local Passport = nil

	if source ~= 0 then
		Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin") then
			return
		end
	end

	local Total = 0
	local List = vRP.Players()
	for _,Sources in pairs(List) do
		Total = Total + 1
		vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
		Wait(100)
	end

	exports["discord"]:Embed("KickAll",
		"**[ADMIN]:** "..tostring(Passport or "Console")..
		"\n**[COMANDO]:** /kickall"..
		"\n**[TOTAL EXPULSO]:** "..tostring(Total)..
		"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
	)

	TriggerEvent("SaveServer",false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin") then
			return
		end
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAVEAUTO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(5 * 60000)
		TriggerEvent("SaveServer",true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Checkpoint = 0
function Creative.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Checkpoint = Checkpoint + 1

		vRP.Archive("races.txt","["..Checkpoint.."] = {")

		vRP.Archive("races.txt","{ "..Optimize(vehCoords["x"])..","..Optimize(vehCoords["y"])..","..Optimize(vehCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..Optimize(leftCoords["x"])..","..Optimize(leftCoords["y"])..","..Optimize(leftCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..Optimize(rightCoords["x"])..","..Optimize(rightCoords["y"])..","..Optimize(rightCoords["z"]).." }")

		vRP.Archive("races.txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		if Spectate[Passport] then
			local Ped = GetPlayerPed(Spectate[Passport])
			if DoesEntityExist(Ped) then
				SetEntityDistanceCullingRadius(Ped,0.0)
			end

			TriggerClientEvent("admin:resetSpectate",source)
			Spectate[Passport] = nil
		else
			local OtherPassport = Message[1]
			local OtherSource = vRP.Source(OtherPassport)
			if OtherSource then
				local Ped = GetPlayerPed(OtherSource)
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,999999999.0)
					Wait(1000)
					TriggerClientEvent("admin:initSpectate",source,OtherSource)
					Spectate[Passport] = OtherSource
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Quake"] = false
RegisterCommand("quake",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",1) then
		TriggerClientEvent("Notify",-1,"Terromoto","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>60</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","roxo",60000)
		GlobalState["Quake"] = true
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA logs
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Players = vRPC.Players(source)

		for _,Sources in pairs(Players) do
			async(function()
				vCLIENT.Limparea(Sources,Coords)
			end)
		end

		print("[LIMPAREA LOG] Comando usado por:",Passport)

		exports["discord"]:Embed("Limparea",
			"**[ADMIN]:** "..Passport..
			"\n**[COMANDO]:** /limparea"..
			"\n**[CDS]:** "..string.format("%.2f, %.2f, %.2f",Coords["x"],Coords["y"],Coords["z"])..
			"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
		)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VIDEO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("video",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Players = vRPC.Players(source)
		for _,Sources in pairs(Players) do
			async(function()
				TriggerClientEvent("hud:Video",Sources,Message[1])
			end)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RENAME logs
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rename",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Keyboard = vKEYBOARD.Tertiary(source,"Passaporte","Nome","Sobrenome")
		if Keyboard then
			vRP.UpgradeNames(Keyboard[1],Keyboard[2],Keyboard[3])
			TriggerClientEvent("Notify",source,"Sucesso","Nome atualizado.","verde",5000)

			print("[RENAME LOG] Admin:",Passport," Alvo:",Keyboard[1]," Nome:",Keyboard[2],Keyboard[3])

			exports["discord"]:Embed("Renamed",
				"**[ADMIN]:** "..Passport..
				"\n**[PASSAPORTE]:** "..Keyboard[1]..
				"\n**[NOME]:** "..Keyboard[2].." "..Keyboard[3]..
				"\n**[COMANDO]:** /rename"..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR log
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",1) then
		local Keyboard = vKEYBOARD.Vehicle(source,"Passaporte","Modelo",{ "Permanente" },"Adicione com Atenção.")
		if Keyboard and Keyboard[1] and Keyboard[2] and Keyboard[3] and VehicleExist(Keyboard[2]) then
			TriggerClientEvent("Notify",source,"Sucesso","Veículo <b>"..VehicleName(Keyboard[2]).."</b> entregue.","verde",5000)
			exports["discord"]:Embed("AddCar","**[ADMIN]:** "..Passport.."\n**[PASSAPORTE]:** "..Keyboard[1].."\n**[MODEL]:** "..Keyboard[2].."\n**[TIPO]:** "..Keyboard[3].."\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"))

			if Keyboard[3] == "Permanente" then
				vRP.Query("vehicles/addVehicles",{ Passport = Keyboard[1], vehicle = Keyboard[2], plate = vRP.GeneratePlate(), work = "false" })
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remcar",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",1) then
		local Keyboard = vKEYBOARD.Primary(source,"Passaporte")
		if Keyboard then
			local Vehicles = {}
			local OtherPassport = parseInt(Keyboard[1])
			local Consult = vRP.Query("vehicles/UserVehicles",{ Passport = OtherPassport })

			for _,v in pairs(Consult) do
				Vehicles[#Vehicles + 1] = v["vehicle"]
			end

			local Keyboard = vKEYBOARD.Instagram(source,Vehicles)
			if Keyboard then
				local Vehicle = Keyboard[1]
				local VehicleText = VehicleName(Vehicle)

				vRP.RemSrvData("LsCustoms:"..OtherPassport..":"..Vehicle)
				vRP.RemSrvData("Chest:"..OtherPassport..":"..Vehicle)
				vRP.Query("vehicles/removeVehicles",{ Passport = OtherPassport, vehicle = Vehicle })

				TriggerClientEvent("Notify",source,"Sucesso","Veículo <b>"..VehicleText.."</b> removido.","verde",5000)

				exports["discord"]:Embed("RemCar",
					"**[ADMIN]:** "..Passport..
					"\n**[PASSAPORTE]:** "..OtherPassport..
					"\n**[VEÍCULO]:** "..tostring(Vehicle)..
					"\n**[NOME DO VEÍCULO]:** "..tostring(VehicleText)..
					"\n**[COMANDO]:** /remcar"..
					"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
				)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nitro",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") and vRP.InsideVehicle(source) then
		local Vehicle,Network,Plate = vRPC.VehicleList(source)
		if Vehicle then
			local Networked = NetworkGetEntityFromNetworkId(Network)
			if DoesEntityExist(Networked) then
				Entity(Networked)["state"]:set("Nitro",2000,true)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kill",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",2) and Message[1] and parseInt(Message[1]) > 0 then
		local OtherPassport = parseInt(Message[1])
		local ClosestPed = vRP.Source(OtherPassport)

		if ClosestPed then
			local Ped = GetPlayerPed(ClosestPed)
			local Coords = GetEntityCoords(Ped)

			vRPC.SetHealth(ClosestPed,100)

			exports["discord"]:Embed("Kill",
				"**[ADMIN]:** "..Passport..
				"\n**[PASSAPORTE MORTO]:** "..OtherPassport..
				"\n**[CDS DO JOGADOR]:** "..string.format("%.2f, %.2f, %.2f",Coords["x"],Coords["y"],Coords["z"])..
				"\n**[COMANDO]:** /kill "..OtherPassport..
				"\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M")
			)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Spectate[Passport] then
		local Ped = GetPlayerPed(Spectate[Passport])
		if DoesEntityExist(Ped) then
			SetEntityDistanceCullingRadius(Ped,0.0)
		end

		Spectate[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHTTPHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
SetHttpHandler(function(Request,Result)
	if Request.headers.Auth == "SEUTOKENAUTH" then
		if Request.path == "/boosteron" then
			Request.setDataHandler(function(Body)
				local Table = json.decode(Body)
				local Account = vRP.Discord(Table.Discord)
				if Account then
					local Consult = vRP.Query("characters/Characters",{ license = Account.license })
					for _,v in pairs(Consult) do
						vRP.SetPermission(v.id,"Booster")
					end

					SendMessageDiscord(Result,200,"Benefícios entregues: <@"..Table.discord..">")
				else
					SendMessageDiscord(Result,404,"Usuário não encontrado.")
				end
			end)
		elseif Request.path == "/boosteroff" then
			Request.setDataHandler(function(Body)
				local Table = json.decode(Body)
				local Account = vRP.Discord(Table.Discord)
				if Account then
					local Consult = vRP.Query("characters/Characters",{ license = Account.license })
					for _,v in pairs(Consult) do
						vRP.RemovePermission(v.id,"Booster")
					end

					SendMessageDiscord(Result,200,"Benefícios removidos: <@"..Table.discord..">")
				else
					SendMessageDiscord(Result,404,"Usuário não encontrado.")
				end
			end)
		else
			SendMessageDiscord(Result,404,"Comando indisponível no momento.")
		end
	else
		SendMessageDiscord(Result,400,"Falha na autenticação.")
	end
end)

RegisterCommand("codiguin",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		local Keyboard = vKEYBOARD.Primary(source,"Cordenadas:")
		if Keyboard then
			local Split = splitString(Keyboard[1],",")
			vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
		end
	end
end)
RegisterCommand("codiguinho",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		local Keyboard = vKEYBOARD.Primary(source,"Cordenadas:")
		if Keyboard then
			local Split = splitString(Keyboard[1],",")
			vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDMESSAGEDISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
function SendMessageDiscord(Result,Code,Message)
	Result.writeHead(Code,{ ["Content-Type"] = "application/json" })
	Result.send(json.encode({ message = Message }))
end
