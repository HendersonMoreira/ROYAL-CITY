-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("garages", Creative)
vCLIENT = Tunnel.getInterface("garages")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Spawn = {}
local Active = {}
local Signal = {}
local Searched = {}
local Propertys = {}
local SpawnVehicle = {}
local VehicleLocks = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local WebhookGarage = "https://discord.com/api/webhooks/1483168016161046609/CS-DMbqzVq1a_OcLPmXiOfrDXh3wb0_j0JMqAsre15ipA0NhYVRoNtTqau5jRcQXrUd8"

local function SendWebhookMessage(Webhook, Message)
	if Webhook and Webhook ~= "" then
		PerformHttpRequest(Webhook, function(err, text, headers) end, "POST", json.encode({
			content = Message
		}), { ["Content-Type"] = "application/json" })
	end
end

local function GarageWithdrawLog(Passport, Name, Plate, Number, Coords)
	local Identity = vRP.Identity(Passport)

	local x, y, z, h = 0.0, 0.0, 0.0, 0.0

	if Coords then
		x = tonumber(Coords[1]) or 0.0
		y = tonumber(Coords[2]) or 0.0
		z = tonumber(Coords[3]) or 0.0
		h = tonumber(Coords[4]) or 0.0
	end

	SendWebhookMessage(WebhookGarage,
		"```prolog\n" ..
		"[GARAGEM - RETIROU VEICULO]\n\n" ..
		"PASSAPORTE: " .. Passport .. "\n" ..
		"NOME: " .. (Identity and (Identity["name"] .. " " .. Identity["name2"]) or "Indefinido") .. "\n" ..
		"VEICULO: " .. Name .. "\n" ..
		"MODELO: " .. VehicleName(Name) .. "\n" ..
		"PLACA: " .. Plate .. "\n" ..
		"GARAGEM: " .. tostring(Number) .. "\n" ..
		"COORDS: x=" .. string.format("%.2f", x) ..
		", y=" .. string.format("%.2f", y) ..
		", z=" .. string.format("%.2f", z) ..
		", h=" .. string.format("%.2f", h) .. "\n\n" ..
		"DATA: " .. os.date("%d/%m/%Y") .. "\n" ..
		"HORA: " .. os.date("%H:%M:%S") .. "\n" ..
		"```"
	)
end

local function GarageStoreLog(Passport, Vehicle, Plate, Engine, Body, Fuel)
	local Identity = vRP.Identity(Passport)

	SendWebhookMessage(WebhookGarage,
		"```prolog\n" ..
		"[GARAGEM - GUARDOU VEICULO]\n\n" ..
		"PASSAPORTE: " .. Passport .. "\n" ..
		"NOME: " .. (Identity and (Identity["name"] .. " " .. Identity["name2"]) or "Indefinido") .. "\n" ..
		"VEICULO: " .. Vehicle .. "\n" ..
		"MODELO: " .. VehicleName(Vehicle) .. "\n" ..
		"PLACA: " .. Plate .. "\n" ..
		"ENGINE: " .. tostring(parseInt(Engine)) .. "\n" ..
		"BODY: " .. tostring(parseInt(Body)) .. "\n" ..
		"FUEL: " .. tostring(parseInt(Fuel)) .. "\n\n" ..
		"DATA: " .. os.date("%d/%m/%Y") .. "\n" ..
		"HORA: " .. os.date("%H:%M:%S") .. "\n" ..
		"```"
	)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Plates"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ServerVehicle(Model, x, y, z, Heading, Plate, Nitrox, Doors, Body, Fuel, Seatbelt, Drift)
	local Vehicle = CreateVehicle(Model, x, y, z, Heading, true, true)

	while not DoesEntityExist(Vehicle) do
		Wait(100)
	end

	if DoesEntityExist(Vehicle) then
		if Plate ~= nil then
			SetVehicleNumberPlateText(Vehicle, Plate)
		else
			Plate = vRP.GeneratePlate()
			SetVehicleNumberPlateText(Vehicle, Plate)
		end

		SetVehicleBodyHealth(Vehicle, Body + 0.0)
		
		if Doors then
			local Doors = json.decode(Doors)
			if Doors ~= nil then
				for Number, Status in pairs(Doors) do
					if Status then
						SetVehicleDoorBroken(Vehicle, parseInt(Number), true)
					end
				end
			end
		end

		Entity(Vehicle)["state"]:set("Fuel",Fuel or 100,true)
		Entity(Vehicle)["state"]:set("Nitro",Nitrox or 0,true)
		Entity(Vehicle)["state"]:set("Drift",Drift or false,true)
		Entity(Vehicle)["state"]:set("Seatbelt",Seatbelt or false,true)

		return true,NetworkGetNetworkIdFromEntity(Vehicle),Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local Garages = {
	["1"] = { name = "Garage", payment = false },
	["2"] = { name = "Garage", payment = false },
	["3"] = { name = "Garage", payment = false },
	["4"] = { name = "Garage", payment = false },
	["5"] = { name = "Garage", payment = false },
	["6"] = { name = "Garage", payment = false },
	["7"] = { name = "Garage", payment = false },
	["8"] = { name = "Garage", payment = false },
	["9"] = { name = "Garage", payment = false },
	["10"] = { name = "Garage", payment = false },
	["11"] = { name = "Garage", payment = false },
	["12"] = { name = "Garage", payment = false },
	["13"] = { name = "Garage", payment = false },
	["14"] = { name = "Garage", payment = false },
	["15"] = { name = "Garage", payment = false },
	["16"] = { name = "Garage", payment = false },
	["17"] = { name = "Garage", payment = false },
	["18"] = { name = "Garage", payment = false },
	["19"] = { name = "Garage", payment = false },
	["20"] = { name = "Garage", payment = false },
	["21"] = { name = "Garage", payment = false },
	["22"] = { name = "Garage", payment = false },
	["23"] = { name = "Garage", payment = false },
	["24"] = { name = "Garage", payment = false },
	["25"] = { name = "Garage", payment = false },
	["26"] = { name = "Garage", payment = false },
	["27"] = { name = "Garagem2", payment = false }, 

	-- Paramedic
	["41"] = { name = "Paramedico", perm = "Paramedico" },
	["42"] = { name = "Paramedico2", perm = "Paramedico" },

	-- Police
	["51"] = { name = "Policia", perm = "Policia" },
	["52"] = { name = "Policia2", perm = "Policia" },
	["53"] = { name = "Policia3", perm = "Policia" },

	-- Boats
	["121"] = { name = "Boats" },
	["122"] = { name = "Boats" },
	["123"] = { name = "Boats" },
	["124"] = { name = "Boats" },

	["131"] = { name = "Helicopters" },

	-- Works
	["141"] = { name = "Lumberman" },
	["142"] = { name = "Driver" },
	["143"] = { name = "Garbageman" },
	["144"] = { name = "Transporter" },
	["145"] = { name = "Garbageman" },
	["146"] = { name = "Garbageman" },
	["147"] = { name = "Trucker" },
	["148"] = { name = "Taxi" },
	["149"] = { name = "Grime" },
	["150"] = { name = "Towed" },
	["151"] = { name = "Milkman" },
	["152"] = { name = "Garage", payment = false }, --- GARAGEM PUBLICA MEDELLIN
	["153"] = { name = "Medellin", perm = "Medellin" }, --- GARAGEM VIP MEDELLIN
	["154"] = { name = "Medellin2", perm = "Medellin" },--- GARAGEM VIP MEDELLINheli
	["155"] = { name = "Policiafederal" },
	["156"] = { name = "Barragem" , perm = "Barragem" }, --- GARAGEM VIP BARRAGEM
	["157"] = { name = "Garage", payment = false }, --- GARAGEM PUBLICA BARRAGEM
	["158"] = { name = "Barragem2" , perm = "Barragem" }, --- GARAGEM desmache BARRAGEM
	["159"] = { name = "Garage", payment = false }, --- GARAGEM PUBLICA MEDELLIN
	["160"] = { name = "MEDICO", payment = false }, --- GARAGEM MEDICO
	["161"] = { name = "Elements", perm = "Elements" }, --- GARAGEM vip fac 
	["162"] = { name = "Garage", payment = false }, --- GARAGEM PUBLICA MEDELLIN
	["163"] = { name = "Garage", payment = false }, --- GARAGEM PUBLICA Distrito
	["164"] = { name = "Garage", payment = false }, --- GARAGEM PUBLICA Turquia
	["165"] = { name = "Turquia", perm = "Turquia" }, ---- garagem vip fac turquia 
	["166"] = { name = "Ifood", payment = false }, ---- Garagem Ifood
	["167"] = { name = "PoliciaMilitar", perm = "PoliciaMilitar" }, ---- garagem policia
	["168"] = { name = "Italia", payment = false }, --- garagem Publica italia
	["169"] = { name = "Elements", perm = "Elements" }, --- garagem Elements nova
	["170"] = { name = "Elements", perm = "Elements" }, --- garagem Elements nova 2
	["171"] = { name = "ElementsHeli", perm = "Elements" } --- heliponto Elements
}	
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:CHANGEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:ChangePlate",function(Plate)
	if GlobalState["Plates"][Plate] then
		local Plates = GlobalState["Plates"]
		Plates[Plate] = nil
		GlobalState:set("Plates", Plates, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SignalRemove", function(Plate)
	if not Signal[Plate] then
		Signal[Plate] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Works = {
	["Helicopters"] = {
		"maverick",
		"volatus",
		"supervolito",
		"havok"
	},
	["Paramedico"] = {
		"lguard",
		"blazer2",
		"firetruk",
		"ambulance2"
	},
	["Paramedico2"] = {
		"maverick2"
	},
	["police3pol"] = {
		"ballerpol",
		"elegy2pol",
		"fugitivepol",
		"komodapol",
		"kurumapol",
		"nc700pol",
		"oracle2pol",
		"polchall",
		"polchar",
		"police3pol",
		"policepol",
		"policetpol",
		"poltang",
		"polvic",
		"r1250pol",
		"schafter2pol",
		"sheriff2pol",
		"silveradopol",
		"sultanrspol",
		"tahoepol",
		"tailgater2pol",
		"tauruspol"
	},
	["Policia2"] = {
		"polas350"
	},
	["Policia3"] = {
		"pbus",
		"riot"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["Garbageman"] = {
		"trash"
	},
	["Trucker"] = {
		"packer"
	},
	["Taxi"] = {
		"taxi"
	},
	["Grime"] = {
		"boxville2"
	},
	["Towed"] = {
		"flatbed"
	},
	["Milkman"] = {
		"youga2"
	},
	["Medellin"] = {
		"mule",
		"zx6r",
		"evox"
	},
	["Medellin2"] = {
		"buzzard2"
	},

	["Policiafederal"] = {
		"corolla22pf"
	},

	["Barragem"] = {
		"buzzard2",
		"mule2"
	},

	["Barragem2"] = {
		"enduro"
	},

	["MEDICO"] = {
		"DLRS6EMS",
		"DLRAMEMS",
		"DLYAMAHAEMS"
	},
	["Elements"] = {
		"mule",
		"zx6r",
		"evox",
		"buzzard2"
	},
	["ElementsHeli"] = {
		"buzzard2"
	},
	["Turquia"] = {
		"mule",
		"zx6r",
		"evox",
		"buzzard2"
	},
	["Ifood"] = {
		"cdaavalanches",
		"cdacaddy2"
	},
	["PoliciaMilitar"] = {
		"wrx7pf"
	},
	["Garagem2"] = {
		"18rs7"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Vehicles(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Garages[Number]["perm"] then
			if not vRP.HasGroup(Passport, Garages[Number]["perm"]) then
				return false
			end
		end

		if string.sub(Number, 1, 9) == "Propertys" then
			local Consult = vRP.Query("propertys/Exist", { name = Number })
			if Consult[1] then
				if parseInt(Consult[1]["Passport"]) == Passport or vRP.InventoryFull(Passport, "propertys-" .. Consult[1]["Serial"]) then
					if os.time() > Consult[1]["Tax"] then
						TriggerClientEvent("Notify",source,"Aviso","Aluguel atrasado, procure um Corretor de Imóveis.","amarelo",5000)
						return false
					end
				else
					return false
				end
			end
		end

		local Vehicle = {}
		local Garage = Garages[Number]["name"]
		if Works[Garage] then
			for _, v in pairs(Works[Garage]) do
				local VehicleResult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = v })

				if VehicleExist(v) then
					if VehicleResult[1] then
						local TaxTime = false
						if VehicleResult[1]["tax"] >= os.time() then
							TaxTime = CompleteTimers(VehicleResult[1]["tax"] - os.time())
						end

						local RentalTime = false
						if VehicleResult[1]["rental"] ~= 0 then
							RentalTime = CompleteTimers(VehicleResult[1]["rental"] - os.time())
						end

						Vehicle[#Vehicle + 1] = {
							["Model"] = v,
							["Name"] = VehicleName(v),
							["Mode"] = VehicleMode(v),
							["Weight"] = VehicleWeight(v),
							["Tax"] = VehiclePrice(v) * 0.10,
							["TaxTime"] = TaxTime,
							["RentalTime"] = RentalTime,
							["Engine"] = VehicleResult[1]["engine"] / 10,
							["Body"] = VehicleResult[1]["body"] / 10,
							["Fuel"] = VehicleResult[1]["fuel"],
						}
					else
						Vehicle[#Vehicle + 1] = {
							["Model"] = v,
							["Name"] = VehicleName(v),
							["Mode"] = VehicleMode(v),
							["Weight"] = VehicleWeight(v),
							["Tax"] = VehiclePrice(v) * 0.10,
							["TaxTime"] = false,
							["RentalTime"] = false,
							["Engine"] = 100,
							["Body"] = 100,
							["Fuel"] = 100
						}
					end
				end
			end
		else
			local Consult = vRP.Query("vehicles/UserVehicles", { Passport = Passport })
			for _, v in pairs(Consult) do
				if VehicleExist(v["vehicle"]) then
					if v["work"] == "false" then
						local TaxTime = false
						if v["tax"] >= os.time() then
							TaxTime = CompleteTimers(v["tax"] - os.time())
						end

						local RentalTime = false
						if v["rental"] ~= 0 then
							RentalTime = CompleteTimers(v["rental"] - os.time())
						end

						Vehicle[#Vehicle + 1] = {
							["Model"] = v["vehicle"],
							["Name"] = VehicleName(v["vehicle"]),
							["Mode"] = VehicleMode(v["vehicle"]),
							["Weight"] = VehicleWeight(v["vehicle"]),
							["Tax"] = VehiclePrice(v["vehicle"]) * 0.10,
							["TaxTime"] = TaxTime,
							["RentalTime"] = RentalTime,
							["Engine"] = v["engine"] / 10,
							["Body"] = v["body"] / 10,
							["Fuel"] = v["fuel"],
						}
					end
				end
			end
		end

		return Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Impound()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicles = {}
		local Vehicle = vRP.Query("vehicles/UserVehicles", { Passport = Passport })

		for Number, v in ipairs(Vehicle) do
			if v["arrest"] >= os.time() then
				Vehicles[#Vehicles + 1] = {
					["Model"] = Vehicle[Number]["vehicle"],
					["name"] = VehicleName(Vehicle[Number]["vehicle"])
				}
			end
		end

		return Vehicles
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound", function(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local VehiclePrice = VehiclePrice(vehName)
		TriggerClientEvent("garages:Close", source)

		if vRP.Request(source, "Garagem", "A liberação do veículo tem o custo de <b>$" .. Dotted(VehiclePrice * 0.25) .. "</b> dólares, deseja prosseguir com a liberação do mesmo?") then
			if vRP.PaymentFull(Passport, VehiclePrice * 0.25) then
				vRP.Query("vehicles/paymentArrest", { Passport = Passport, vehicle = vehName })
				TriggerClientEvent("Notify",source,"Sucesso","Veículo liberado.","verde",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAX
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterServerEvent("garages:Tax")
---AddEventHandler("garages:Tax",function(Name)
	---local source = source
	---local Passport = vRP.Passport(source)
	---if Passport then
		----local Consult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
		---if Consult[1] and Consult[1]["tax"] <= os.time() then
			---local Price = VehiclePrice(Name) * 0.10

			---if vRP.PaymentFull(Passport, Price) then
				---vRP.Query("vehicles/updateVehiclesTax", { Passport = Passport, vehicle = Name })
				---TriggerClientEvent("Notify",source,"Sucesso","Pagamento concluído.","verde",5000)
			---end
		---end
	--end
---end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK VENDA
-----------------------------------------------------------------------------------------------------------------------------------------
local WebhookGarageSell = "https://discord.com/api/webhooks/1483173764865724429/Pkf0gd7waK086T68S3n6PdtXlJrJBL8FzUQ7LNVj9xegLTM3qeoPtNvUpCD_a3gR987H"

local function SendWebhookMessage(Webhook, Message)
	if Webhook and Webhook ~= "" then
		PerformHttpRequest(Webhook, function(err, text, headers) end, "POST", json.encode({
			content = Message
		}), { ["Content-Type"] = "application/json" })
	end
end

local function GarageSellLog(Passport, Name, Price)
	local Identity = vRP.Identity(Passport)

	SendWebhookMessage(WebhookGarageSell,
		"```prolog\n" ..
		"[GARAGEM - VENDEU VEICULO]\n\n" ..
		"PASSAPORTE: " .. Passport .. "\n" ..
		"NOME: " .. (Identity and (Identity["name"] .. " " .. Identity["name2"]) or "Indefinido") .. "\n" ..
		"VEICULO: " .. Name .. "\n" ..
		"MODELO: " .. VehicleName(Name) .. "\n" ..
		"VALOR: $" .. Dotted(Price) .. "\n\n" ..
		"DATA: " .. os.date("%d/%m/%Y") .. "\n" ..
		"HORA: " .. os.date("%H:%M:%S") .. "\n" ..
		"```"
	)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Sell")
AddEventHandler("garages:Sell",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Mode = VehicleMode(Name)
		if Mode == "rental" or Mode == "work" then
			return
		end

		local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if Consult[1] then
			local Price = VehiclePrice(Name) * 0.5
			if vRP.Request(source,"Vender o veículo "..VehicleName(Name).." por $"..Dotted(Price).."?","Sim, concluír venda","Não, mudei de ideia") then
				local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
				if Consult[1] then
					vRP.GiveBank(Passport,Price)
					vRP.Query("vehicles/removeVehicles",{ Passport = Passport, vehicle = Name })
					vRP.Query("entitydata/RemoveData",{ Name = "LsCustoms:"..Passport..":"..Name })
					vRP.Query("entitydata/RemoveData",{ Name = "Chest:"..Passport..":"..Name })

					GarageSellLog(Passport, Name, Price)
				end
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local WebhookTransferVehicle = "https://discord.com/api/webhooks/1483163045952884937/_UAfJ6XuOE_98g4gCd098z6OLEAH40Q-7lqkWs_oH7x4WZZqOpWB6o2EsPhL6wm7jByQ"

local function SendWebhookMessage(Webhook,Message)
	if Webhook and Webhook ~= "" then
		PerformHttpRequest(Webhook,function(err,text,headers) end,"POST",json.encode({
			content = Message
		}),{ ["Content-Type"] = "application/json" })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Transfer")
AddEventHandler("garages:Transfer",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local myVehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if myVehicle[1] then
			TriggerClientEvent("garages:Close",source)

			local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
			if Keyboard then
				local OtherPassport = parseInt(Keyboard[1])
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					if vRP.Request(source,"Transferir o veículo "..VehicleName(Name).." para "..Identity["name"].." "..Identity["name2"].."?","Sim, transferir","Não, mudei de ideia") then
						local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = OtherPassport, vehicle = Name })
						if Vehicle[1] then
							TriggerClientEvent("Notify",source,"Atenção","<b>"..vRP.FullName(OtherPassport).."</b> já possui este modelo de veículo.","amarelo",5000)
						else
							local MyIdentity = vRP.Identity(Passport)

							vRP.Query("vehicles/moveVehicles",{ Passport = Passport, OtherPassport = OtherPassport, vehicle = Name })

							local Datatable = vRP.Query("entitydata/GetData",{ Name = "LsCustoms:"..Passport..":"..Name })
							if parseInt(#Datatable) > 0 then
								vRP.Query("entitydata/SetData",{ Name = "LsCustoms:"..OtherPassport..":"..Name, Information = Datatable[1]["Information"] })
								vRP.Query("entitydata/RemoveData",{ Name = "LsCustoms:"..Passport..":"..Name })
							end

							local Datatable = vRP.GetSrvData("Chest:"..Passport..":"..Name,true)
							vRP.SetSrvData("Chest:"..OtherPassport..":"..Name,Datatable,true)
							vRP.RemSrvData("Chest:"..Passport..":"..Name,true)

							TriggerClientEvent("Notify",source,"Sucesso","Transferência concluída.","verde",5000)

							SendWebhookMessage(WebhookTransferVehicle,
								"```prolog\n"..
								"[TRANSFERENCIA DE VEICULO]\n\n"..
								"PASSAPORTE ORIGEM: "..Passport.."\n"..
								"NOME ORIGEM: "..(MyIdentity and (MyIdentity["name"].." "..MyIdentity["name2"]) or "Indefinido").."\n\n"..
								"PASSAPORTE DESTINO: "..OtherPassport.."\n"..
								"NOME DESTINO: "..Identity["name"].." "..Identity["name2"].."\n\n"..
								"VEICULO: "..Name.."\n"..
								"MODELO: "..VehicleName(Name).."\n\n"..
								"DATA: "..os.date("%d/%m/%Y").."\n"..
								"HORA: "..os.date("%H:%M:%S").."\n"..
								"```"
							)
						end
					end
				end
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Spawn")
AddEventHandler("garages:Spawn",function(Name,Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if SpawnVehicle[Number] then
			if os.time() >= SpawnVehicle[Number] then
				SpawnVehicle[Number] = os.time() + 5
			else
				TriggerClientEvent("garages:Close", source)

				local Cooldown = CompleteTimers(SpawnVehicle[Number] - os.time())
				TriggerClientEvent("Notify",source,"Aviso","Aguarde" .. Cooldown,"azul",false,5000)
				return
			end
		else
			SpawnVehicle[Number] = os.time() + 5
		end

		local Coin = "Diamantes"
		local Gemstone = VehicleGemstone(Name)
		local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })

		if not vehicle[1] then
			if parseInt(Gemstone) > 0 then
				TriggerClientEvent("garages:Close", source)

				if vRP.Request(source, "Garagem", "Alugar o veículo <b>" .. VehicleName(Name) .. "</b> por <b>" .. Gemstone .. "</b> gemas?") then
					if vRP.PaymentGemstone(Passport, Gemstone) then
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"Sucesso","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.","verde",5000)
						vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
					else
						TriggerClientEvent("Notify",source,"Aviso","Diamantes insuficiente.","amarelo",5000)
						return
					end
				else
					return
				end
			else
				TriggerClientEvent("garages:Close", source)

				local VehiclePrice = VehiclePrice(Name)
				if parseInt(VehiclePrice) > 0 then
					if vRP.Request(source, "Garagem", "Comprar <b>" .. VehicleName(Name) .. "</b> por <b>$" .. Dotted(VehiclePrice) .. "</b> dólares?") then
						if vRP.PaymentFull(Passport, VehiclePrice) then
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
							vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
						end
					else
						return
					end
				else
					vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
					vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
				end
			end
		end

		if vehicle[1] then
			local Plates = GlobalState["Plates"]
			local Plate = vehicle[1]["plate"]

			if Spawn[Plate] then
				if not Signal[Plate] then
					if not Searched[Passport] then
						Searched[Passport] = os.time()
					end

					if os.time() >= parseInt(Searched[Passport]) then
						Searched[Passport] = os.time() + 60

						local Network = Spawn[Plate][3]
						local Network = NetworkGetEntityFromNetworkId(Network)
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							vCLIENT.SearchBlip(source, GetEntityCoords(Network))
							TriggerClientEvent("Notify",source,"Atenção","Rastreador do veículo foi ativado por <b>30</b> segundos, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.","policia",10000)
						else
							if Spawn[Plate] then
								Spawn[Plate] = nil
							end

							if Plates[Plate] then
								Plates[Plate] = nil
								GlobalState:set("Plates", Plates, true)
							end

							TriggerClientEvent("Notify",source,"Sucesso","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.","policia",5000)
						end
					else
						TriggerClientEvent("Notify",source,"Aviso","Rastreador só pode ser ativado a cada <b>60</b> segundos.","policia",5000)
					end
				else
					TriggerClientEvent("Notify",source,"Aviso","Rastreador está desativado.","policia",5000)
				end
			else
				if vehicle[1]["tax"] <= os.time() then
					TriggerClientEvent("Notify",source,"Aviso","Taxa do veículo atrasada.","amarelo",5000)
				elseif vehicle[1]["arrest"] >= os.time() then
					TriggerClientEvent("Notify",source,"Aviso","Veículo apreendido, dirija-se até o Impound e efetue o pagamento da liberação do mesmo.","amarelo",10000)
				else
					if vehicle[1]["rental"] ~= 0 then
						if vehicle[1]["rental"] <= os.time() then
							if vRP.Request(source,"Atualizar o aluguel do veículo <b>"..VehicleName(Name).."</b> por <b>"..Gemstone.." gemas</b>?","Sim, concluír pagamento","Não, mudei de ideia") then
								if vRP.PaymentGems(Passport,Gemstone) then
									vRP.Query("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = Name })
									TriggerClientEvent("Notify",source,"Sucesso","Aluguel do veículo <b>"..VehicleName(Name).."</b> atualizado.","verde",5000)
								else
									TriggerClientEvent("Notify",source,"Aviso",Coin.." insuficiente.","amarelo",5000)
									return
								end
							else
								return
							end
						end
					end

					if Gemstone > 0 and vehicle[1]["rental"] ~= 0 and vehicle[1]["rental"] <= os.time() then
						TriggerClientEvent("garages:Close",source)

						if VehicleClass(Name) == "Exclusivos" then
							Coin = "Platina"
						end

						if vRP.Request(source,"Garagem","Pagar o aluguel do veículo <b>"..VehicleName(Name).."</b> por <b>"..Dotted(Gemstone).." "..Coin.."</b>?") then
							if (Coin == "Diamantes" and vRP.PaymentGems(Passport,Gemstone)) or (Coin == "Platina" and vRP.TakeItem(Passport,"platinum",Gemstone)) then
								vRP.Query("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = Name })
								TriggerClientEvent("Notify",source,"Sucesso","Aluguel do veículo <b>"..VehicleName(Name).."</b> atualizado.","verde",5000)
							else
								TriggerClientEvent("Notify",source,"Aviso","Platina insuficiente.","amarelo",5000)
								return false
							end
						else
							return false
						end
					end

					local Coords = vCLIENT.SpawnPosition(source, Number)
					if Coords then
						local Mods = nil
						local Datatable = vRP.Query("entitydata/GetData",{ Name = "LsCustoms:"..Passport..":"..Name })
						print("[DEBUG] Dados recuperados do banco para:", "LsCustoms:"..Passport..":"..Name)
						print("[DEBUG] Conteúdo do Datatable:", json.encode(Datatable))

						if parseInt(#Datatable) > 0 then
							Mods = Datatable[1]["Information"]
						end

						if Garages[Number]["payment"] then
							if vRP.UserPremium(Passport) then
								TriggerClientEvent("garages:Close", source)
								local Exist, Network = Creative.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"], vehicle[1]["fuel"], vehicle[1]["Seatbelt"], vehicle[1]["Drift"])
								if Exist then
									local Networked = NetworkGetEntityFromNetworkId(Network)

									vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"], vehicle[1]["health"], Mods, vehicle[1]["windows"], vehicle[1]["tyres"])
									SetVehicleDoorsLocked(Networked, 2)
									VehicleLocks[Plate] = true
									Spawn[Plate] = { Passport, Name, Network }

									Plates[Plate] = Passport
									GlobalState:set("Plates", Plates, true)

									GarageWithdrawLog(Passport,Name,Plate,Number,Coords)
								end

								if vehicle[1]["mode"] == "normal" then
									local VehiclePrice = VehiclePrice(Name)
									if vRP.HasGroup(Passport, "Premium") then
										local Exist, Network = Creative.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"], vehicle[1]["Seatbelt"], vehicle[1]["Drift"])

										if Exist then
											local Networked = NetworkGetEntityFromNetworkId(Network)

											vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"], vehicle[1]["health"], Mods, vehicle[1]["windows"], vehicle[1]["tyres"], vehicle[1]["fuel"])
											SetVehicleDoorsLocked(Networked, 2)
											VehicleLocks[Plate] = true
											Spawn[Plate] = { Passport, Name, Network }

											Plates[Plate] = Passport
											GlobalState:set("Plates", Plates, true)

											GarageWithdrawLog(Passport,Name,Plate,Number,Coords)
										end
									else
										if vRP.Request(source, "Garagem", "Retirar o veículo por <b>$" .. Dotted(VehiclePrice * 0.05) .. "</b> dólares?") then
											if vRP.PaymentFull(Passport, parseInt(VehiclePrice * 0.05)) then
												local Exist, Network = Creative.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"], vehicle[1]["Seatbelt"], vehicle[1]["Drift"])

												if Exist then
													local Networked = NetworkGetEntityFromNetworkId(Network)

													vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"], vehicle[1]["health"], Mods, vehicle[1]["windows"], vehicle[1]["tyres"], vehicle[1]["fuel"])
													SetVehicleDoorsLocked(Networked, 2)
													VehicleLocks[Plate] = true
													Spawn[Plate] = { Passport, Name, Network }

													Plates[Plate] = Passport
													GlobalState:set("Plates", Plates, true)

													GarageWithdrawLog(Passport,Name,Plate,Number,Coords)
												end
											else
												TriggerClientEvent("Notify",source,"Aviso","Dinheiro insuficiente.","amarelo",5000)
												return
											end
										end
									end
								end
							end
						else
							TriggerClientEvent("garages:Close", source)
							local Exist, Network = Creative.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"], vehicle[1]["Seatbelt"], vehicle[1]["Drift"])

							if Exist then
								local Networked = NetworkGetEntityFromNetworkId(Network)

								vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"], vehicle[1]["health"], Mods, vehicle[1]["windows"], vehicle[1]["tyres"], vehicle[1]["fuel"])
								SetVehicleDoorsLocked(Networked, 2)
								VehicleLocks[Plate] = true
								Spawn[Plate] = { Passport, Name, Network }

								Plates[Plate] = Passport
								GlobalState:set("Plates", Plates, true)

								GarageWithdrawLog(Passport,Name,Plate,Number,Coords)
							end
						end
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local WebhookCar = "https://discord.com/api/webhooks/1483164085347418304/XhSJXLksR4YV3hEruOz340qNIN67wj6cQfUaScOek0v3Oi8qcQB0j_Dt-N46pc4MdTgS"

local function SendWebhookMessage(Webhook, Message)
	if Webhook and Webhook ~= "" then
		PerformHttpRequest(Webhook, function(err, text, headers) end, "POST", json.encode({
			content = Message
		}), { ["Content-Type"] = "application/json" })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if (vRP.HasGroup(Passport, "Admin") or vRP.HasGroup(Passport, "Carros")) and Message[1] then
			local VehName = Message[1]
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local Heading = GetEntityHeading(Ped)
			local Plate = "VEH" .. (math.random(10000, 90000) + Passport)

			local Exist, Network, Vehicle = Creative.ServerVehicle(
				VehName,
				Coords["x"], Coords["y"], Coords["z"],
				Heading,
				Plate,
				2000,
				nil,
				1000
			)

			if not Exist then
				return
			end

			local Identity = vRP.Identity(Passport)
			local Networked = NetworkGetEntityFromNetworkId(Network)

			vCLIENT.CreateVehicle(-1, VehName, Network, 1000, 1000, nil, false, false, { 1.25, 0.75, 0.95 })

			SetVehicleDoorsLocked(Networked, 2)
			VehicleLocks[Plate] = true
			Spawn[Plate] = { Passport, VehName, Network }
			SetPedIntoVehicle(Ped, Vehicle, -1)

			local Plates = GlobalState["Plates"]
			Plates[Plate] = Passport
			GlobalState:set("Plates", Plates, true)

			SendWebhookMessage(WebhookCar,
				"```prolog\n" ..
				"[SPAWN VEICULO /CAR]\n\n" ..
				"PASSAPORTE: " .. Passport .. "\n" ..
				"NOME: " .. (Identity and (Identity["name"] .. " " .. Identity["name2"]) or "Indefinido") .. "\n" ..
				"COMANDO: /car " .. VehName .. "\n" ..
				"VEICULO: " .. VehName .. "\n" ..
				"PLACA: " .. Plate .. "\n" ..
				"COORDS: x=" .. string.format("%.2f", Coords["x"]) ..
				", y=" .. string.format("%.2f", Coords["y"]) ..
				", z=" .. string.format("%.2f", Coords["z"]) .. "\n" ..
				"HEADING: " .. string.format("%.2f", Heading) .. "\n\n" ..
				"DATA: " .. os.date("%d/%m/%Y") .. "\n" ..
				"HORA: " .. os.date("%H:%M:%S") .. "\n" ..
				"```"
			)
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local WebhookDv = "https://discord.com/api/webhooks/1483164838480842943/0x1500BjGmZNUBJNQ1_6CDbEFydq-H493HE1DFvSuaXJ8va2I9MXb0zPSFamuCdMpDsd"

local function SendWebhookMessage(Webhook, Message)
	if Webhook and Webhook ~= "" then
		PerformHttpRequest(Webhook, function(err, text, headers) end, "POST", json.encode({
			content = Message
		}), { ["Content-Type"] = "application/json" })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv", function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport, "Admin", 2) then
		local Identity = vRP.Identity(Passport)
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)

		TriggerClientEvent("garages:Delete", source)

		SendWebhookMessage(WebhookDv,
			"```prolog\n" ..
			"[COMANDO /DV]\n\n" ..
			"PASSAPORTE: " .. Passport .. "\n" ..
			"NOME: " .. (Identity and (Identity["name"] .. " " .. Identity["name2"]) or "Indefinido") .. "\n" ..
			"COMANDO: /dv\n" ..
			"COORDS: x=" .. string.format("%.2f", Coords["x"]) ..
			", y=" .. string.format("%.2f", Coords["y"]) ..
			", z=" .. string.format("%.2f", Coords["z"]) .. "\n\n" ..
			"DATA: " .. os.date("%d/%m/%Y") .. "\n" ..
			"HORA: " .. os.date("%H:%M:%S") .. "\n" ..
			"```"
		)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Key")
AddEventHandler("garages:Key", function(entity)
	local source = source
	local Plate = entity[1]
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Plates"][Plate] == Passport then
		vRP.GenerateItem(Passport, "vehiclekey-" .. Plate, 1, true, false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Lock")
AddEventHandler("garages:Lock", function(Network, Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if exports["inventory"]:IsClonePlate(Plate) then
		TriggerClientEvent("Notify",source,"Aviso","Não é possível trancar ou destrancar um veículo com placa clonada.","amarelo",5000)
		return
	end

	if Passport and GlobalState["Plates"][Plate] == Passport then
		TriggerEvent("garages:LockVehicle", source, Network, Plate)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:LockVehicle", function(source, Network, Plate)
	local Vehicle = NetworkGetEntityFromNetworkId(Network)
	if not Vehicle or Vehicle == 0 or not DoesEntityExist(Vehicle) then
		TriggerClientEvent("Notify",source,"Aviso","Veículo não encontrado.","amarelo",5000)
		return
	end

	VehicleLocks[Plate] = not VehicleLocks[Plate]

	if VehicleLocks[Plate] then
		TriggerClientEvent("Notify",source,"Aviso","Veículo trancado.","default",5000)
		TriggerClientEvent("sounds:Private", source, "locked", 0.7)
		SetVehicleDoorsLocked(Vehicle, 2)
	else
		TriggerClientEvent("Notify",source,"Aviso","Veículo destrancado.","default",5000)
		TriggerClientEvent("sounds:Private", source, "unlocked", 0.7)
		SetVehicleDoorsLocked(Vehicle, 1)
	end

	if not vRPC.InsideVehicle(source) then
		vRPC.PlayAnim(source, true, { "anim@mp_player_intmenu@key_fob@", "fob_click" }, false)
		Wait(350)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Delete(Network, Health, Engine, Body, Fuel, Doors, Windows, Tyres, Plate)
	local OriginalPlate = exports["inventory"]:GetOriginalPlate(Plate)

	if exports["inventory"]:IsClonePlate(Plate) then
		OriginalPlate = exports["inventory"]:RestoreClonePlate(Plate,Network)
		Plate = OriginalPlate
	else
		Plate = OriginalPlate
	end

	if Spawn[Plate] then
		local Networked = NetworkGetEntityFromNetworkId(Network)
		local Passport = Spawn[Plate][1]
		local Vehicle = Spawn[Plate][2]

		if parseInt(Engine) <= 100 then
			Engine = 100
		end

		if parseInt(Body) <= 100 then
			Body = 100
		end

		local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Vehicle })
		if vehicle[1] ~= nil then
			vRP.Query("vehicles/updateVehicles",{
				Passport = Passport,
				vehicle = Vehicle,
				nitro = Entity(Networked)["state"]["Nitro"] or 0,
				engine = parseInt(Engine),
				body = parseInt(Body),
				health = parseInt(Health),
				fuel = Entity(Networked)["state"]["Fuel"] or 0,
				doors = json.encode(Doors),
				windows = json.encode(Windows),
				tyres = json.encode(Tyres)
			})

			GarageStoreLog(
				Passport,
				Vehicle,
				Plate,
				Engine,
				Body,
				Entity(Networked)["state"]["Fuel"] or Fuel or 0
			)
		end
	end

	TriggerEvent("garages:Delete", Network, Plate)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Deleted")
AddEventHandler("garages:Deleted",function(Network,Plate)
	Creative.Delete(Network,{},{},Plate)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Delete")
AddEventHandler("garages:Delete", function(Network, Plate)
	if Network ~= nil and Plate ~= nil then
		if GlobalState["Plates"][Plate] then
			local Plates = GlobalState["Plates"]
			Plates[Plate] = nil
			GlobalState:set("Plates", Plates, true)
		end

		if Signal[Plate] then
			Signal[Plate] = nil
		end

		if Spawn[Plate] then
			Spawn[Plate] = nil
		end

		local Network = NetworkGetEntityFromNetworkId(Network)
		if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 and GetVehicleNumberPlateText(Network) == Plate then
			DeleteEntity(Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Propertys")
AddEventHandler("garages:Propertys",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Consult = vRP.Query("propertys/Exist",{ Name = Name })
		if Consult[1] and Consult[1]["Passport"] == Passport then
			Active[Passport] = true
			TriggerClientEvent("dynamic:Close",source)
			TriggerClientEvent("Notify",source,"Aviso","Selecione o local da garagem.","amarelo",5000)

			local Hash = "prop_offroad_tyres02"
			local Application,Coords = vRPC.ObjectControlling(source,Hash)
			if Application then
				if #(vec3(Coords[1],Coords[2],Coords[3]) - exports["propertys"]:Coords(Name)) <= 25 then
					TriggerClientEvent("Notify",source,"Aviso","Selecione o local do veículo.","amarelo",5000)

					local Open = Coords
					local Hash = "sultanrs"
					local Application,Coords = vRPC.ObjectControlling(source,Hash)
					if Application then
						if #(vec3(Coords[1],Coords[2],Coords[3]) - exports["propertys"]:Coords(Name)) <= 25 then
							local New = {
								["1"] = { Open[1],Open[2],Open[3] + 1 },
								["2"] = { Coords[1],Coords[2],Coords[3] + 1,Coords[4] }
							}

							Garages[Name] = { name = "Garage", payment = false, license = false }

							Propertys[Name] = {
								["x"] = New["1"][1],
								["y"] = New["1"][2],
								["z"] = New["1"][3],
								["1"] = New["2"]
							}

							vRP.Query("propertys/Garage",{ Name = Name, Garage = json.encode(New) })
							TriggerClientEvent("garages:Propertys",-1,Propertys)
						else
							TriggerClientEvent("Notify",source,"Error","A garagem precisa ser próximo da entrada.","vermelho",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"Error","A garagem precisa ser próximo da entrada.","vermelho",5000)
				end
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Consult = vRP.Query("propertys/Garages")
	for _, v in pairs(Consult) do
		local Name = v["Name"]
		if not Propertys[Name] and v["Garage"] ~= "{}" then
			local Table = json.decode(v["Garage"])
			Garages[Name] = { name = "Garage", payment = false, license = false }

			Propertys[Name] = {
				["x"] = Table["1"][1],
				["y"] = Table["1"][2],
				["z"] = Table["1"][3],
				["1"] = Table["2"]
			}
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Signal", function(Plate)
	return Signal[Plate]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	TriggerClientEvent("garages:Propertys", source, Propertys)
end)
