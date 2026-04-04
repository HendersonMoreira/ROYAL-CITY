-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("admin",Creative)
vSERVER = Tunnel.getInterface("admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportWay()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		Ped = GetVehiclePedIsUsing(Ped)
    end

	local Wayblip = GetFirstBlipInfoId(8)
	local Coordsblip = GetBlipCoords(Wayblip)
	if DoesBlipExist(Wayblip) then
		for Number = 1,1000 do
			SetEntityCoordsNoOffset(Ped,Coordsblip["x"],Coordsblip["y"],Number + 0.0,1,0,0)

			RequestCollisionAtCoord(Coordsblip["x"],Coordsblip["y"],Coordsblip["z"])
			while not HasCollisionLoadedAroundEntity(Ped) do
				Wait(1)
			end

			if GetGroundZFor_3dCoord(Coordsblip["x"],Coordsblip["y"],Number + 0.0) then
				break
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportLimbo()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,Node = GetNthClosestVehicleNode(Coords["x"],Coords["y"],Coords["z"],1,0,0,0)

	SetEntityCoords(Ped,Node["x"],Node["y"],Node["z"] + 1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:Tuning")
AddEventHandler("admin:Tuning",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)

		SetVehicleModKit(Vehicle,0)
		ToggleVehicleMod(Vehicle,18,true)
		SetVehicleMod(Vehicle,11,GetNumVehicleMods(Vehicle,11) - 1,false)
		SetVehicleMod(Vehicle,12,GetNumVehicleMods(Vehicle,12) - 1,false)
		SetVehicleMod(Vehicle,13,GetNumVehicleMods(Vehicle,13) - 1,false)
		SetVehicleMod(Vehicle,15,GetNumVehicleMods(Vehicle,15) - 1,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
	if not NetworkIsInSpectatorMode() then
		local Pid = GetPlayerFromServerId(source)
		local Ped = GetPlayerPed(Pid)

		LocalPlayer["state"]:set("Spectate",true,false)
		NetworkSetInSpectatorMode(true,Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false)
		LocalPlayer["state"]:set("Spectate",false,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Quake",nil,function(Name,Key,Value)
	ShakeGameplayCam("SKY_DIVING_SHAKE",1.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Limparea(Coords)
	ClearAreaOfPeds(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearAreaOfCops(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearAreaOfObjects(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearAreaOfProjectiles(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearArea(Coords["x"],Coords["y"],Coords["z"],100.0,true,false,false,false)
	ClearAreaOfVehicles(Coords["x"],Coords["y"],Coords["z"],100.0,false,false,false,false,false)
	ClearAreaLeaveVehicleHealth(Coords["x"],Coords["y"],Coords["z"],100.0,false,false,false,false)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG PERMANENTE 3D
-----------------------------------------------------------------------------------------------------------------------------------------
local DebugActive = false

RegisterNetEvent("admin:ToggleDebug")
AddEventHandler("admin:ToggleDebug",function()
	DebugActive = not DebugActive
	TriggerEvent("Notify","Debug",DebugActive and "Debug ATIVADO ✓" or "Debug DESATIVADO ✗","default",3000)
end)

local function DrawText3D(x,y,z,text,r,g,b)
	local onScreen, screenX, screenY = World3dToScreen2d(x, y, z)
	if onScreen then
		SetTextColour(r or 255, g or 255, b or 255, 255)
		SetTextFont(0)
		SetTextScale(0.30, 0.30)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(screenX, screenY)
	end
end

local function DrawPanel(x,y,w,h,r,g,b,a)
	DrawRect(x + (w * 0.5), y + (h * 0.5), w, h, r or 10, g or 16, b or 28, a or 140)
end

local function DrawText2D(x,y,text,scale,r,g,b,a)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(scale or 0.28,scale or 0.28)
	SetTextColour(r or 255,g or 255,b or 255,a or 220)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

local function GetEntityLabel(entity)
	local entityType = GetEntityType(entity)
	if entityType == 1 then
		return "PED"
	elseif entityType == 2 then
		return "VEICULO"
	elseif entityType == 3 then
		return "OBJETO"
	end

	return "ENTIDADE"
end

local function IsDoorLikeModel(modelHash)
	if not modelHash or modelHash == 0 then
		return false
	end

	local minDim, maxDim = GetModelDimensions(modelHash)
	local sizeX = math.abs(maxDim.x - minDim.x)
	local sizeY = math.abs(maxDim.y - minDim.y)
	local sizeZ = math.abs(maxDim.z - minDim.z)

	-- Heuristica de porta/portao: alto, relativamente fino e com area frontal minima.
	if sizeZ < 1.4 or sizeZ > 7.5 then
		return false
	end

	if sizeX < 0.35 or sizeX > 12.0 then
		return false
	end

	if sizeY > 2.8 then
		return false
	end

	if (sizeX * sizeZ) < 0.8 then
		return false
	end

	return true
end

local function GetLookedEntity(maxDistance)
	local ped = PlayerPedId()
	local cam = GetGameplayCamCoord()
	local camRot = GetGameplayCamRot(2)

	local rotX = math.rad(camRot.x)
	local rotZ = math.rad(camRot.z)
	local dir = vector3(
		-math.sin(rotZ) * math.abs(math.cos(rotX)),
		 math.cos(rotZ) * math.abs(math.cos(rotX)),
		 math.sin(rotX)
	)

	local dst = cam + (dir * (maxDistance or 20.0))
	local rayHandle = StartShapeTestLosProbe(cam.x,cam.y,cam.z,dst.x,dst.y,dst.z,511,ped,7)
	local _, hit, hitCoords, _, hitEntity = GetShapeTestResult(rayHandle)

	if hit == 1 and hitEntity and hitEntity ~= 0 and DoesEntityExist(hitEntity) then
		return hitEntity, hitCoords
	end

	return nil,nil
end

local function GetNearestFrontDoorLikeObject(maxDistance)
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local forward = GetEntityForwardVector(ped)
	local nearestObject = nil
	local nearestCoords = nil
	local nearestDistance = maxDistance or 2.5

	local objects = GetGamePool("CObject")
	for _,obj in ipairs(objects) do
		if DoesEntityExist(obj) then
			local model = GetEntityModel(obj)
			if not IsDoorLikeModel(model) then
				goto continue
			end

			local objCoords = GetEntityCoords(obj)
			local dx = objCoords.x - pedCoords.x
			local dy = objCoords.y - pedCoords.y
			local dz = objCoords.z - pedCoords.z
			local dist = math.sqrt(dx * dx + dy * dy + dz * dz)

			if dist <= nearestDistance then
				local len = math.sqrt(dx * dx + dy * dy)
				if len > 0.001 then
					local dirX = dx / len
					local dirY = dy / len
					local dot = (forward.x * dirX) + (forward.y * dirY)

					-- Somente objetos na frente do jogador.
					if dot > 0.35 then
						nearestDistance = dist
						nearestObject = obj
						nearestCoords = objCoords
					end
				end
			end
		end
		::continue::
	end

	return nearestObject,nearestCoords
end

local function GetNearestDoorFromSystem(coords,maxDistance)
	local nearestNumber = nil
	local nearestDoor = nil
	local nearestDistance = maxDistance
	local doors = GlobalState["Doors"]

	if doors then
		for Number,v in pairs(doors) do
			if v and v["Coords"] and v["Hash"] then
				local dist = #(coords - v["Coords"])
				if dist <= nearestDistance then
					nearestNumber = Number
					nearestDoor = v
					nearestDistance = dist
				end
			end
		end
	end

	return nearestNumber,nearestDoor,nearestDistance
end

local function GetCurrentVehicle()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped,false)
	if vehicle and vehicle ~= 0 then
		return vehicle
	end

	vehicle = GetVehiclePedIsUsing(ped)
	if vehicle and vehicle ~= 0 then
		return vehicle
	end

	return nil
end

local function GetVehicleDebug(vehicle)
	if not vehicle then
		return nil
	end

	local speedKmh = GetEntitySpeed(vehicle) * 3.6
	local body = GetVehicleBodyHealth(vehicle)
	local engine = GetVehicleEngineHealth(vehicle)
	local lockStatus = GetVehicleDoorLockStatus(vehicle)

	return {
		hash = GetEntityModel(vehicle),
		plate = GetVehicleNumberPlateText(vehicle),
		speed = speedKmh,
		body = body,
		engine = engine,
		lock = lockStatus
	}
end

CreateThread(function()
	while true do
		if DebugActive then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			local lookedEntity, lookedCoords = GetLookedEntity(25.0)
			local lookedHash = nil
			local lookedType = nil
			local lookedDistance = nil

			if lookedEntity and lookedCoords then
				lookedHash = GetEntityModel(lookedEntity)
				lookedType = GetEntityLabel(lookedEntity)
				lookedDistance = #(coords - lookedCoords)
			end

			local nearDoorEntity, nearDoorCoords = GetNearestFrontDoorLikeObject(4.2)
			local nearDoorHash = nearDoorEntity and GetEntityModel(nearDoorEntity) or nil

			local doorNumber, doorData, doorDistance = GetNearestDoorFromSystem(coords,7.0)

			local currentVehicle = GetCurrentVehicle()
			local vehicleDebug = GetVehicleDebug(currentVehicle)

			-- Floating tags no mundo
			DrawText3D(coords.x, coords.y, coords.z + 1.1,
				"X:"..string.format("%.0f",coords.x).." Y:"..string.format("%.0f",coords.y).." Z:"..string.format("%.0f",coords.z),255,220,120)

			if currentVehicle and vehicleDebug then
				local vehCoords = GetEntityCoords(currentVehicle)
				DrawText3D(vehCoords.x,vehCoords.y,vehCoords.z + 0.95,
					"SEU CARRO\nHash: "..tostring(vehicleDebug.hash).."\nPlaca: "..tostring(vehicleDebug.plate),110,200,255)
			end

			if nearDoorEntity and nearDoorCoords and nearDoorHash then
				DrawText3D(nearDoorCoords.x,nearDoorCoords.y,nearDoorCoords.z + 0.45,
					"PORTA/PORTAO\nHash: "..tostring(nearDoorHash),120,255,130)
			end

			if doorNumber and doorData then
				local dCoords = doorData["Coords"]
				DrawText3D(dCoords.x,dCoords.y,dCoords.z + 0.85,
					"PORTA SISTEMA\nID: "..tostring(doorNumber).."\nHash: "..tostring(doorData["Hash"]),80,170,255)
			end

			if lookedEntity and lookedCoords and lookedHash then
				DrawText3D(lookedCoords.x,lookedCoords.y,lookedCoords.z + 0.35,
					"ALVO: "..tostring(lookedType).."\nHash: "..tostring(lookedHash),255,215,120)
			end

			-- Painel design tipo ferramenta
			DrawPanel(0.012,0.025,0.29,0.265,8,14,25,145)
			DrawText2D(0.020,0.032,"DEBUG TOOL - HASH/DOORS",0.31,115,205,255,240)

			DrawText2D(0.020,0.058,"[PLAYER]",0.28,255,224,120,235)
			DrawText2D(0.020,0.076,"Coord: "..string.format("%.0f %.0f %.0f",coords.x,coords.y,coords.z),0.26)
			DrawText2D(0.020,0.092,"Heading: "..string.format("%.1f",heading),0.26)

			DrawText2D(0.020,0.115,"[VEICULO]",0.28,110,200,255,235)
			if vehicleDebug then
				DrawText2D(0.020,0.133,"Hash: "..tostring(vehicleDebug.hash),0.26)
				DrawText2D(0.020,0.149,"Placa: "..tostring(vehicleDebug.plate),0.26)
				DrawText2D(0.020,0.165,"Vel: "..string.format("%.1f km/h",vehicleDebug.speed),0.26)
				DrawText2D(0.020,0.181,"Body/Engine: "..string.format("%.0f / %.0f",vehicleDebug.body,vehicleDebug.engine),0.26)
			else
				DrawText2D(0.020,0.133,"Fora do veiculo",0.26,190,190,190,220)
			end

			DrawText2D(0.020,0.205,"[PORTAS]",0.28,120,255,130,235)
			if nearDoorHash then
				DrawText2D(0.020,0.223,"Porta/portao proximo: "..tostring(nearDoorHash),0.26)
			else
				DrawText2D(0.020,0.223,"Porta/portao proximo: nao detectado",0.26,190,190,190,220)
			end

			if doorNumber and doorData then
				DrawText2D(0.020,0.239,"Sistema Doors ID/Hash: "..tostring(doorNumber).." / "..tostring(doorData["Hash"]),0.26)
				DrawText2D(0.020,0.255,"Distancia da porta: "..string.format("%.2f",doorDistance),0.26)
			else
				DrawText2D(0.020,0.239,"Sistema Doors: nenhuma porta proxima",0.26,190,190,190,220)
			end

			DrawText2D(0.020,0.273,"[ALVO NA MIRA]",0.28,255,215,120,235)
			if lookedHash then
				DrawText2D(0.020,0.291,"Tipo/Hash: "..tostring(lookedType).." / "..tostring(lookedHash),0.26)
				DrawText2D(0.020,0.307,"Distancia alvo: "..string.format("%.2f",lookedDistance or 0.0),0.26)
			else
				DrawText2D(0.020,0.291,"Sem alvo na mira",0.26,190,190,190,220)
			end
		end
		Wait(0)
	end
end)