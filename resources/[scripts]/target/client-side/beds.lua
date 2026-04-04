-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
local LastTreatmentHealth = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Beds = {
	-- Medical Center Sul
	{ ["Coords"] = vec4(316.28,-1416.90,32.25,139.98), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(314.46,-1415.38,32.25,140.38), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(312.58,-1413.79,32.25,140.41), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(310.73,-1412.25,32.25,140.11), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(308.84,-1410.66,32.25,140.05), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(306.99,-1409.10,32.25,139.96), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(304.99,-1407.43,32.25,140.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(303.17,-1405.90,32.25,139.84), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(310.10,-1404.32,32.25,50.000), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(311.68,-1402.43,32.25,50.330), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(313.23,-1400.59,32.25,50.150), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(314.82,-1398.70,32.25,50.020), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(322.02,-1396.00,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(323.84,-1397.53,32.25,320.23), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(325.72,-1399.11,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(327.57,-1400.66,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(329.46,-1402.25,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(331.31,-1403.80,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(333.30,-1405.47,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(335.13,-1407.00,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(326.63,-1408.37,32.25,230.01), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(325.05,-1410.25,32.25,230.17), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(323.50,-1412.09,32.25,230.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(321.91,-1413.99,32.25,230.09), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(314.45,-1407.28,32.25,139.96), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(316.35,-1408.88,32.25,139.35), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(318.19,-1410.42,32.25,139.60), ["Invert"] = 0.0 },
	-- Boolingbroke
	{ ["Coords"] = vec4(1761.87,2591.56,45.50,272.13), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1761.87,2594.64,45.50,272.13), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1761.87,2597.73,45.50,272.13), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1771.98,2597.95,45.50,87.88), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1771.98,2594.88,45.50,87.88), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1771.98,2591.79,45.50,87.88), ["Invert"] = 180.0 },
	-- New Hospital
	{ ["Coords"] = vec4(-2769.61,-86.14,19.53,2.84), ["Invert"] = 0.0, ["Offset"] = 0.0, ["Forward"] = 0.0, ["Up"] = 0.05 },
	{ ["Coords"] = vec4(-2766.13,-85.87,19.53,2.84), ["Invert"] = 0.0, ["Offset"] = 0.0, ["Forward"] = 0.0, ["Up"] = 0.05 },
	{ ["Coords"] = vec4(-2762.62,-85.58,19.53,2.84), ["Invert"] = 0.0, ["Offset"] = 0.0, ["Forward"] = 0.0, ["Up"] = 0.05 },
	{ ["Coords"] = vec4(-2759.14,-85.3,19.53,2.84), ["Invert"] = 0.0, ["Offset"] = 0.0, ["Forward"] = 0.0, ["Up"] = 0.05 },
	{ ["Coords"] = vec4(-2755.67,-85.02,19.53,2.84), ["Invert"] = 0.0, ["Offset"] = 0.0, ["Forward"] = 0.0, ["Up"] = 0.05 },
	-- Clandestine
	{ ["Coords"] = vec4(-471.87,6287.56,13.63,53.86), ["Invert"] = 180.0 }
}

local function BedOffset(Number)
	return Beds[Number]["Offset"] or -0.5
end

local function BedNumber(Value)
	if type(Value) == "table" then
		return tonumber(Value[1]) or tonumber(Value["shop"]) or tonumber(Value["Number"]) or tonumber(Value["number"])
	end

	return tonumber(Value)
end

local function BedCoords(Number)
	local Bed = Beds[Number]
	local Coords = Bed["Coords"]
	local Heading = Coords["w"]
	local Forward = Bed["Forward"] or 0.0
	local Up = Bed["Up"] or 0.0
	local Rad = Heading * 0.0174532924

	local X = Coords["x"] + math.sin(Rad) * Forward
	local Y = Coords["y"] - math.cos(Rad) * Forward
	local Z = Coords["z"] + BedOffset(Number) + Up

	return X,Y,Z
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number,vec3(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"] - 0.35),2.4,1.4,{
			name = "Beds:"..Number,
			heading = v["Coords"]["w"],
			minZ = v["Coords"]["z"] - 1.0,
			maxZ = v["Coords"]["z"] + 1.5
		},{
			shop = Number,
			Distance = 1.50,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				},{
					event = "target:Treatment",
					label = "Tratamento",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PUTBED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:PutBed",function(Number)
	local Number = BedNumber(Number)
	if not Number or not Beds[Number] then
		return
	end

	local Ped = PlayerPedId()
	if not Previous then
		Previous = GetEntityCoords(Ped)
	end

	local X,Y,Z = BedCoords(Number)
	SetEntityCoords(Ped,X,Y,Z)
	vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
	SetEntityHeading(Ped,Beds[Number]["Coords"]["w"] - Beds[Number]["Invert"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:UpBed",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 0.5)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:Treatment",function(Number,Ignore)
	local Number = BedNumber(Number)
	if not Number then
		return
	end

	if not Previous and Beds[Number] then
		local Checkin = Ignore
		local WaitingMedic = false

		if not Ignore then
			Checkin,WaitingMedic = vSERVER.CheckIn()
		end

		if not Checkin then
			if WaitingMedic then
				TriggerEvent("target:PutBed",Number)
			end

			return
		end

		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		local X,Y,Z = BedCoords(Number)
		SetEntityCoords(Ped,X,Y,Z)
		vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
		SetEntityHeading(Ped,Beds[Number]["Coords"]["w"] - Beds[Number]["Invert"])

		LocalPlayer["state"]:set("Commands",true,true)
		LocalPlayer["state"]:set("Buttons",true,true)
		LocalPlayer["state"]:set("Cancel",true,true)
		SetEntityInvincible(Ped,false)
		SetEntityCanBeDamaged(Ped,true)
		NetworkSetFriendlyFireOption(true)
		TriggerEvent("paramedic:Reset")

		if GetEntityHealth(Ped) <= 100 then
			exports["survival"]:Revive(101)
		end

		Treatment = GetGameTimer() + 1000
		LastTreatmentHealth = GetEntityHealth(Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment",function()
	if not Treatment then
		local Ped = PlayerPedId()
		LocalPlayer["state"]:set("Commands",true,true)
		LocalPlayer["state"]:set("Buttons",true,true)
		LocalPlayer["state"]:set("Cancel",true,true)
		SetEntityInvincible(Ped,false)
		SetEntityCanBeDamaged(Ped,true)
		NetworkSetFriendlyFireOption(true)
		Treatment = GetGameTimer() + 1000
		LastTreatmentHealth = GetEntityHealth(Ped)
		TriggerEvent("paramedic:Reset")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StopTreatment")
AddEventHandler("target:StopTreatment",function(Reason)
	if Treatment then
		Treatment = false
		LastTreatmentHealth = nil
		SetEntityInvincible(PlayerPedId(),false)
		NetworkSetFriendlyFireOption(true)
		LocalPlayer["state"]:set("Cancel",false,true)
		LocalPlayer["state"]:set("Buttons",false,true)
		LocalPlayer["state"]:set("Commands",false,true)

		if Reason and Reason ~= "" then
			TriggerEvent("Notify","Centro Médico",Reason,"amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if Treatment and GetGameTimer() >= Treatment then
			TimeDistance = 100
			Treatment = GetGameTimer() + 1000
			SetEntityInvincible(Ped,false)
			SetEntityCanBeDamaged(Ped,true)
			local Health = GetEntityHealth(Ped)
			if LastTreatmentHealth and Health < LastTreatmentHealth then
				TriggerServerEvent("paramedic:CancelTreatment")
				TriggerEvent("target:StopTreatment","Tratamento cancelado por dano recebido.")
			else
				LastTreatmentHealth = Health

				if Health < 200 then
					SetEntityHealth(Ped,Health + 1)
				else
					Treatment = false
					LastTreatmentHealth = nil
					SetEntityInvincible(Ped,false)
					NetworkSetFriendlyFireOption(true)
					LocalPlayer["state"]:set("Cancel",false,true)
					LocalPlayer["state"]:set("Buttons",false,true)
					LocalPlayer["state"]:set("Commands",false,true)
					TriggerEvent("Notify","Centro Médico","Tratamento concluido.","hospital",5000)
				end
			end
		end

		if Previous and not IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
			SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 0.5)
			TimeDistance = 100
			Previous = nil
		end

		Wait(TimeDistance)
	end
end)