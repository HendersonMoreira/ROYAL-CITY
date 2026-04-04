local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("routes")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local routes = {
	["Arma"] = {
		title = "Arma" , 
		perm = { "arma.permissao" },
		startPoints = {
			{ x = -2362.16, y = 1704.97, z = 234.09 },
			{ x = 2078.87, y = 3967.86, z = 36.5 }
		}
	},

	["Elements"] = {
		title = "Municao", 
		perm = { "Elements" },
		startPoints = {
			{ x = 746.97, y = 1284.9, z = 360.55 },
		}
	},

	["Distrito22"] = {
		title = "Municao", 
		perm = { "Distrito22" },
		startPoints = {
			{ x = -1755.24, y = -202.44, z = 57.85 },
		}
	},

	["Desmanche"] = {
		title = "Desmanche",
		perm = { "desmanche.permissao" }, 
		startPoints = {
			{ x = 1363.76, y = -2445.11, z = 62.18 },    
			{ x = -3084.58, y = 1476.93, z = 25.24 }
		}
	},

	["Lavagem"] = {
		title = "Lavagem", 
		perm = { "lavagem.permissao" },
		startPoints = {
			{ x = 94.3, y = -1290.85, z = 29.32 },
			{ x = 731.28, y = -799.84, z = 18.06 }
		}
	},

	["Grove"] = {
		title = "Grove", 
		perm = { "grove.permissao" },
		startPoints = {
			{ x = 1459.44, y = -991.0, z = 51.75 }
		}
	},

	["Turquia"] = {
		title = "Arma", 
		perm = { "Turquia" }, 
		startPoints = {
			{ x = 1385.35, y = -757.99, z = 78.99 }
		}
	},

	["Barragem"] = {
		title = "Armas", 
		perm = { "Barragem" }, 
		startPoints = {
			{ x = 1213.79, y = -260.39, z = 75.77 } ---- 1213.79,-260.39,75.77
		}
	},

	["Medellin"] = {
		title = "Drogas",
		perm = { "Medellin" },
		startPoints = {
			{ x = 1484.22, y = 1129.98, z = 114.33 }
		}
	},

	
	["BlackDiamond"] = {
		title = "Drogas",
		perm = { "BlackDiamond" },
		startPoints = {
			{ x = -3230.0, y = 831.16, z = 8.93 } 
		}
	},
}

local routesPath = {
	
	["Barragem"] = {
		[1] = { ['x'] = 201.49, ['y'] = 2462.43, ['z'] = 55.91 },
		[2] = { ['x'] = 317.2, ['y'] = 2622.86, ['z'] = 44.45 },
		[3] = { ['x'] = 598.99, ['y'] = 2745.38, ['z'] = 42.04 },
		[4] = { ['x'] = 983.97, ['y'] = 2718.57, ['z'] = 39.5 },
		[5] = { ['x'] = 1142.33, ['y'] = 2664.1, ['z'] = 38.16 },
		[6] = { ['x'] = 2128.95, ['y'] = 2917.55, ['z'] = 47.9 },
		[7] = { ['x'] = 2998.49, ['y'] = 4099.4, ['z'] = 56.99 },
		[8] = { ['x'] = 2855.85, ['y'] = 4446.88, ['z'] = 48.53 },
		[9] = { ['x'] = 2832.77, ['y'] = 4571.31, ['z'] = 46.56 },
		[10] = { ['x'] = 1705.9, ['y'] = 6425.15, ['z'] = 32.76 },
		[11] = { ['x'] = 38.87, ['y'] = 6454.38, ['z'] = 31.42 },
		[12] = { ['x'] = 133.82, ['y'] = 6640.24, ['z'] = 31.76 },
		[13] = { ['x'] = -112.74, ['y'] = 6243.05, ['z'] = 31.32 },
		[14] = { ['x'] = -772.89, ['y'] = 5598.11, ['z'] = 33.6 },
		[15] = { ['x'] = -1490.46, ['y'] = 4980.88, ['z'] = 63.36 },
		[16] = { ['x'] = -2193.41, ['y'] = 4289.9, ['z'] = 49.17 },
		[17] = { ['x'] = -2544.11, ['y'] = 2316.03, ['z'] = 33.21 },
		[18] = { ['x'] = -1313.39, ['y'] = 2507.19, ['z'] = 21.92 },
		[19] = { ['x'] = -1105.88, ['y'] = 2696.52, ['z'] = 18.62 },
		[20] = { ['x'] = -454.16, ['y'] = 2862.47, ['z'] = 35.33 },
		[21] = { ['x'] = -40.35, ['y'] = 2859.87, ['z'] = 59.26 },
		[22] = { ['x'] = 189.06, ['y'] = 3037.49, ['z'] = 43.88 },
		[23] = { ['x'] = 464.23, ['y'] = 3565.19, ['z'] = 33.23 },
		[24] = { ['x'] = 910.96, ['y'] = 3644.71, ['z'] = 32.67 },
		[25] = { ['x'] = 347.07, ['y'] = 3406.66, ['z'] = 36.5 }
	},
	
	
	["Medellin"] = {
		[1] = { ['x'] = 201.49, ['y'] = 2462.43, ['z'] = 55.91 },
		[2] = { ['x'] = 317.2, ['y'] = 2622.86, ['z'] = 44.45 },
		[3] = { ['x'] = 598.99, ['y'] = 2745.38, ['z'] = 42.04 },
		[4] = { ['x'] = 983.97, ['y'] = 2718.57, ['z'] = 39.5 },
		[5] = { ['x'] = 1142.33, ['y'] = 2664.1, ['z'] = 38.16 },
		[6] = { ['x'] = 2128.95, ['y'] = 2917.55, ['z'] = 47.9 },
		[7] = { ['x'] = 2998.49, ['y'] = 4099.4, ['z'] = 56.99 },
		[8] = { ['x'] = 2855.85, ['y'] = 4446.88, ['z'] = 48.53 },
		[9] = { ['x'] = 2832.77, ['y'] = 4571.31, ['z'] = 46.56 },
		[10] = { ['x'] = 1705.9, ['y'] = 6425.15, ['z'] = 32.76 },
		[11] = { ['x'] = 38.87, ['y'] = 6454.38, ['z'] = 31.42 },
		[12] = { ['x'] = 133.82, ['y'] = 6640.24, ['z'] = 31.76 },
		[13] = { ['x'] = -112.74, ['y'] = 6243.05, ['z'] = 31.32 },
		[14] = { ['x'] = -772.89, ['y'] = 5598.11, ['z'] = 33.6 },
		[15] = { ['x'] = -1490.46, ['y'] = 4980.88, ['z'] = 63.36 },
		[16] = { ['x'] = -2193.41, ['y'] = 4289.9, ['z'] = 49.17 },
		[17] = { ['x'] = -2544.11, ['y'] = 2316.03, ['z'] = 33.21 },
		[18] = { ['x'] = -1313.39, ['y'] = 2507.19, ['z'] = 21.92 },
		[19] = { ['x'] = -1105.88, ['y'] = 2696.52, ['z'] = 18.62 },
		[20] = { ['x'] = -454.16, ['y'] = 2862.47, ['z'] = 35.33 },
		[21] = { ['x'] = -40.35, ['y'] = 2859.87, ['z'] = 59.26 },
		[22] = { ['x'] = 189.06, ['y'] = 3037.49, ['z'] = 43.88 },
		[23] = { ['x'] = 464.23, ['y'] = 3565.19, ['z'] = 33.23 },
		[24] = { ['x'] = 910.96, ['y'] = 3644.71, ['z'] = 32.67 },
		[25] = { ['x'] = 347.07, ['y'] = 3406.66, ['z'] = 36.5 }
	},

	["Elements"] = {
		[1] = { ['x'] = 201.49, ['y'] = 2462.43, ['z'] = 55.91 },
		[2] = { ['x'] = 317.2, ['y'] = 2622.86, ['z'] = 44.45 },
		[3] = { ['x'] = 598.99, ['y'] = 2745.38, ['z'] = 42.04 },
		[4] = { ['x'] = 983.97, ['y'] = 2718.57, ['z'] = 39.5 },
		[5] = { ['x'] = 1142.33, ['y'] = 2664.1, ['z'] = 38.16 },
		[6] = { ['x'] = 2128.95, ['y'] = 2917.55, ['z'] = 47.9 },
		[7] = { ['x'] = 2998.49, ['y'] = 4099.4, ['z'] = 56.99 },
		[8] = { ['x'] = 2855.85, ['y'] = 4446.88, ['z'] = 48.53 },
		[9] = { ['x'] = 2832.77, ['y'] = 4571.31, ['z'] = 46.56 },
		[10] = { ['x'] = 1705.9, ['y'] = 6425.15, ['z'] = 32.76 },
		[11] = { ['x'] = 38.87, ['y'] = 6454.38, ['z'] = 31.42 },
		[12] = { ['x'] = 133.82, ['y'] = 6640.24, ['z'] = 31.76 },
		[13] = { ['x'] = -112.74, ['y'] = 6243.05, ['z'] = 31.32 },
		[14] = { ['x'] = -772.89, ['y'] = 5598.11, ['z'] = 33.6 },
		[15] = { ['x'] = -1490.46, ['y'] = 4980.88, ['z'] = 63.36 },
		[16] = { ['x'] = -2193.41, ['y'] = 4289.9, ['z'] = 49.17 },
		[17] = { ['x'] = -2544.11, ['y'] = 2316.03, ['z'] = 33.21 },
		[18] = { ['x'] = -1313.39, ['y'] = 2507.19, ['z'] = 21.92 },
		[19] = { ['x'] = -1105.88, ['y'] = 2696.52, ['z'] = 18.62 },
		[20] = { ['x'] = -454.16, ['y'] = 2862.47, ['z'] = 35.33 },
		[21] = { ['x'] = -40.35, ['y'] = 2859.87, ['z'] = 59.26 },
		[22] = { ['x'] = 189.06, ['y'] = 3037.49, ['z'] = 43.88 },
		[23] = { ['x'] = 464.23, ['y'] = 3565.19, ['z'] = 33.23 },
		[24] = { ['x'] = 910.96, ['y'] = 3644.71, ['z'] = 32.67 },
		[25] = { ['x'] = 347.07, ['y'] = 3406.66, ['z'] = 36.5 }
	},
	["BlackDiamond"] = {
		[1] = { ['x'] = 201.49, ['y'] = 2462.43, ['z'] = 55.91 },
		[2] = { ['x'] = 317.2, ['y'] = 2622.86, ['z'] = 44.45 },
		[3] = { ['x'] = 598.99, ['y'] = 2745.38, ['z'] = 42.04 },
		[4] = { ['x'] = 983.97, ['y'] = 2718.57, ['z'] = 39.5 },
		[5] = { ['x'] = 1142.33, ['y'] = 2664.1, ['z'] = 38.16 },
		[6] = { ['x'] = 2128.95, ['y'] = 2917.55, ['z'] = 47.9 },
		[7] = { ['x'] = 2998.49, ['y'] = 4099.4, ['z'] = 56.99 },
		[8] = { ['x'] = 2855.85, ['y'] = 4446.88, ['z'] = 48.53 },
		[9] = { ['x'] = 2832.77, ['y'] = 4571.31, ['z'] = 46.56 },
		[10] = { ['x'] = 1705.9, ['y'] = 6425.15, ['z'] = 32.76 },
		[11] = { ['x'] = 38.87, ['y'] = 6454.38, ['z'] = 31.42 },
		[12] = { ['x'] = 133.82, ['y'] = 6640.24, ['z'] = 31.76 },
		[13] = { ['x'] = -112.74, ['y'] = 6243.05, ['z'] = 31.32 },
		[14] = { ['x'] = -772.89, ['y'] = 5598.11, ['z'] = 33.6 },
		[15] = { ['x'] = -1490.46, ['y'] = 4980.88, ['z'] = 63.36 },
		[16] = { ['x'] = -2193.41, ['y'] = 4289.9, ['z'] = 49.17 },
		[17] = { ['x'] = -2544.11, ['y'] = 2316.03, ['z'] = 33.21 },
		[18] = { ['x'] = -1313.39, ['y'] = 2507.19, ['z'] = 21.92 },
		[19] = { ['x'] = -1105.88, ['y'] = 2696.52, ['z'] = 18.62 },
		[20] = { ['x'] = -454.16, ['y'] = 2862.47, ['z'] = 35.33 },
		[21] = { ['x'] = -40.35, ['y'] = 2859.87, ['z'] = 59.26 },
		[22] = { ['x'] = 189.06, ['y'] = 3037.49, ['z'] = 43.88 },
		[23] = { ['x'] = 464.23, ['y'] = 3565.19, ['z'] = 33.23 },
		[24] = { ['x'] = 910.96, ['y'] = 3644.71, ['z'] = 32.67 },
		[25] = { ['x'] = 347.07, ['y'] = 3406.66, ['z'] = 36.5 }
	},

	["Distrito22"] = {
		[1] = { ['x'] = 201.49, ['y'] = 2462.43, ['z'] = 55.91 },
		[2] = { ['x'] = 317.2, ['y'] = 2622.86, ['z'] = 44.45 },
		[3] = { ['x'] = 598.99, ['y'] = 2745.38, ['z'] = 42.04 },
		[4] = { ['x'] = 983.97, ['y'] = 2718.57, ['z'] = 39.5 },
		[5] = { ['x'] = 1142.33, ['y'] = 2664.1, ['z'] = 38.16 },
		[6] = { ['x'] = 2128.95, ['y'] = 2917.55, ['z'] = 47.9 },
		[7] = { ['x'] = 2998.49, ['y'] = 4099.4, ['z'] = 56.99 },
		[8] = { ['x'] = 2855.85, ['y'] = 4446.88, ['z'] = 48.53 },
		[9] = { ['x'] = 2832.77, ['y'] = 4571.31, ['z'] = 46.56 },
		[10] = { ['x'] = 1705.9, ['y'] = 6425.15, ['z'] = 32.76 },
		[11] = { ['x'] = 38.87, ['y'] = 6454.38, ['z'] = 31.42 },
		[12] = { ['x'] = 133.82, ['y'] = 6640.24, ['z'] = 31.76 },
		[13] = { ['x'] = -112.74, ['y'] = 6243.05, ['z'] = 31.32 },
		[14] = { ['x'] = -772.89, ['y'] = 5598.11, ['z'] = 33.6 },
		[15] = { ['x'] = -1490.46, ['y'] = 4980.88, ['z'] = 63.36 },
		[16] = { ['x'] = -2193.41, ['y'] = 4289.9, ['z'] = 49.17 },
		[17] = { ['x'] = -2544.11, ['y'] = 2316.03, ['z'] = 33.21 },
		[18] = { ['x'] = -1313.39, ['y'] = 2507.19, ['z'] = 21.92 },
		[19] = { ['x'] = -1105.88, ['y'] = 2696.52, ['z'] = 18.62 },
		[20] = { ['x'] = -454.16, ['y'] = 2862.47, ['z'] = 35.33 },
		[21] = { ['x'] = -40.35, ['y'] = 2859.87, ['z'] = 59.26 },
		[22] = { ['x'] = 189.06, ['y'] = 3037.49, ['z'] = 43.88 },
		[23] = { ['x'] = 464.23, ['y'] = 3565.19, ['z'] = 33.23 },
		[24] = { ['x'] = 910.96, ['y'] = 3644.71, ['z'] = 32.67 },
		[25] = { ['x'] = 347.07, ['y'] = 3406.66, ['z'] = 36.5 }
	},

	["Turquia"] = {
		[1] = { ['x'] = 201.49, ['y'] = 2462.43, ['z'] = 55.91 },
		[2] = { ['x'] = 317.2, ['y'] = 2622.86, ['z'] = 44.45 },
		[3] = { ['x'] = 598.99, ['y'] = 2745.38, ['z'] = 42.04 },
		[4] = { ['x'] = 983.97, ['y'] = 2718.57, ['z'] = 39.5 },
		[5] = { ['x'] = 1142.33, ['y'] = 2664.1, ['z'] = 38.16 },
		[6] = { ['x'] = 2128.95, ['y'] = 2917.55, ['z'] = 47.9 },
		[7] = { ['x'] = 2998.49, ['y'] = 4099.4, ['z'] = 56.99 },
		[8] = { ['x'] = 2855.85, ['y'] = 4446.88, ['z'] = 48.53 },
		[9] = { ['x'] = 2832.77, ['y'] = 4571.31, ['z'] = 46.56 },
		[10] = { ['x'] = 1705.9, ['y'] = 6425.15, ['z'] = 32.76 },
		[11] = { ['x'] = 38.87, ['y'] = 6454.38, ['z'] = 31.42 },
		[12] = { ['x'] = 133.82, ['y'] = 6640.24, ['z'] = 31.76 },
		[13] = { ['x'] = -112.74, ['y'] = 6243.05, ['z'] = 31.32 },
		[14] = { ['x'] = -772.89, ['y'] = 5598.11, ['z'] = 33.6 },
		[15] = { ['x'] = -1490.46, ['y'] = 4980.88, ['z'] = 63.36 },
		[16] = { ['x'] = -2193.41, ['y'] = 4289.9, ['z'] = 49.17 },
		[17] = { ['x'] = -2544.11, ['y'] = 2316.03, ['z'] = 33.21 },
		[18] = { ['x'] = -1313.39, ['y'] = 2507.19, ['z'] = 21.92 },
		[19] = { ['x'] = -1105.88, ['y'] = 2696.52, ['z'] = 18.62 },
		[20] = { ['x'] = -454.16, ['y'] = 2862.47, ['z'] = 35.33 },
		[21] = { ['x'] = -40.35, ['y'] = 2859.87, ['z'] = 59.26 },
		[22] = { ['x'] = 189.06, ['y'] = 3037.49, ['z'] = 43.88 },
		[23] = { ['x'] = 464.23, ['y'] = 3565.19, ['z'] = 33.23 },
		[24] = { ['x'] = 910.96, ['y'] = 3644.71, ['z'] = 32.67 },
		[25] = { ['x'] = 347.07, ['y'] = 3406.66, ['z'] = 36.5 }
	},

}

local currentRoute = nil
local currentBlip = nil
local position = 0
local currentPathPosition = 1
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "open", title = "Rotas para "..routes[currentRoute].title, items = vSERVER.getItems(currentRoute) })
	else
		SetNuiFocus(false,false)
		SendNUIMessage({ action = "exit" })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("selectRoute", function(data,cb)
	if data.code then
		position = data.code
		TriggerServerEvent("routes:selectRoute", currentRoute, data.code)
	end

	if cb then cb("ok") end
end)

RegisterNUICallback("exit", function(data,cb)
	ToggleActionMenu()
	if cb then cb("ok") end
end)

RegisterNetEvent("routes:exit")
AddEventHandler("routes:exit", function()
	if menuactive then
		ToggleActionMenu()
	end
end)

RegisterNetEvent("routes:startRoute")
AddEventHandler("routes:startRoute", function(route, item)
	if currentBlip then
		RemoveBlip(currentBlip)
		currentBlip = nil
	end

	currentRoute = route
	currentPathPosition = 1

	if routes[currentRoute] and routesPath[currentRoute] and routesPath[currentRoute][currentPathPosition] then
		createBlip(routes[currentRoute].title, routesPath[currentRoute][currentPathPosition])
		TriggerEvent("Notify","sucesso","Iniciando rota de <b>"..item.."</b>.",5000)
	else
		TriggerEvent("Notify","negado","Rota inválida ou sem pontos configurados.",5000)
	end
end)
-------------------------------------------------------------------------------------------------
--[ GENERATE TABLE ]-----------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local processedTable = {}
Citizen.CreateThread(function()
	for routeCode, route in pairs(routes) do
		for k, v in pairs(route.startPoints) do
			table.insert(processedTable,{ x = v["x"], y = v["y"], z = v["z"], routeCode = routeCode })
		end
	end
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Wait(1500)
	while true do
		local msec = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k, v in pairs(processedTable) do
			local distance = #(coords - vec3(v["x"], v["y"], v["z"]))
			if distance <= 5.0 then
				msec = 4
				if distance <= 1.5 then
					DrawText3D(v["x"], v["y"], v["z"], "~p~E~w~   ABRIR")
					if IsControlJustPressed(0,38) then
						for indice, valor in pairs(routes[v["routeCode"]].perm) do
							if vSERVER.checkPermission(valor) then
								currentRoute = v["routeCode"]
								ToggleActionMenu()
								break
							end
						end
					end
				end
			end
		end
        
		Citizen.Wait(msec)
	end
end)

Citizen.CreateThread(function()
	while true do
		local AE = 500

		if currentRoute and routesPath[currentRoute] then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local currentPos = routesPath[currentRoute][currentPathPosition]

			if currentPos then
				local distance = GetDistanceBetweenCoords(currentPos.x,currentPos.y,currentPos.z,x,y,z,true)

				AE = 4
				if distance <= 1.5 then
					DrawText3D(currentPos.x,currentPos.y,currentPos.z, "~p~E~w~   COLETAR")
					
					if not IsPedInAnyVehicle(ped) then
						if IsControlJustPressed(0,38) then
							vSERVER.checkPayment(currentRoute, position)
							playPickupAnim()

							if currentBlip then
								RemoveBlip(currentBlip)
								currentBlip = nil
							end

							currentPathPosition = currentPathPosition + 1

							if currentPathPosition > #routesPath[currentRoute] then
								currentPathPosition = 1
							end

							local nextPos = routesPath[currentRoute][currentPathPosition]
							if nextPos then
								createBlip(routes[currentRoute].title, nextPos)
							end
						end
					end
				end
			else
				currentPathPosition = 1
				local restartPos = routesPath[currentRoute][currentPathPosition]
				if restartPos and routes[currentRoute] then
					if currentBlip then
						RemoveBlip(currentBlip)
						currentBlip = nil
					end
					createBlip(routes[currentRoute].title, restartPos)
				end
			end
		end

		Citizen.Wait(AE)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if currentRoute then
			if IsControlJustPressed(0, 168) then
				currentRoute = nil
				currentPathPosition = 1

				if currentBlip then
					RemoveBlip(currentBlip)
					currentBlip = nil
				end

				TriggerServerEvent("routes:endRoute")
				TriggerEvent("Notify","negado","Rota encerrada",10000)
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function playPickupAnim()
	local ped = PlayerPedId()
	RequestAnimDict("pickup_object")
	while not HasAnimDictLoaded("pickup_object") do
		Wait(10)
	end
	TaskPlayAnim(ped,"pickup_object","pickup_low",8.0,8.0,-1,48,0,false,false,false)
end

function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,40,36,52,240)
	ClearDrawOrigin()
end

function createBlip(name, pos)
	if not pos then
		return
	end

	currentBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
	SetBlipSprite(currentBlip,12)
	SetBlipColour(currentBlip,27)
	SetBlipScale(currentBlip,0.9)
	SetBlipAsShortRange(currentBlip,false)
	SetBlipRoute(currentBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rotas de "..name)
	EndTextCommandSetBlipName(currentBlip)
end
