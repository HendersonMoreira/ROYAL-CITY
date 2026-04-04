-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local NoClip = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.noClip()
	NoClip = not NoClip
	local Ped = PlayerPedId()

	if NoClip then
		SetEntityCollision(Ped,false,false)
		SetEntityVisible(Ped,false,0)
		SetEntityInvincible(Ped,true)
	else
		SetEntityCollision(Ped,true,true)
		SetEntityInvincible(Ped,false)
		SetEntityVisible(Ped,true,0)
	end

	while NoClip do
		local Speed = 1.0
		local Ped = PlayerPedId()
		local cX,cY,cZ = GetCamDirections()
		local Coords = GetEntityCoords(Ped)
		local X,Y,Z = table.unpack(Coords)

		-- Direção lateral (strafe) perpendicular à câmera
		local HeadingRad = (GetGameplayCamRelativeHeading() + GetEntityHeading(Ped)) * math.pi / 180.0
		local rX = math.cos(HeadingRad)
		local rY = math.sin(HeadingRad)

		if IsControlPressed(0,21) then -- SHIFT - velocidade
			Speed = 5.0
		end

		if IsControlPressed(0,32) then -- W - frente
			X = X + Speed * cX
			Y = Y + Speed * cY
			Z = Z + Speed * cZ
		end

		if IsControlPressed(0,33) then -- S - trás
			X = X - Speed * cX
			Y = Y - Speed * cY
			Z = Z - Speed * cZ
		end

		if IsControlPressed(0,34) then -- A - esquerda
			X = X - Speed * rX
			Y = Y - Speed * rY
		end

		if IsControlPressed(0,35) then -- D - direita
			X = X + Speed * rX
			Y = Y + Speed * rY
		end

		if IsControlPressed(0,38) then -- E - subir
			Z = Z + 0.25
		end

		if IsControlPressed(0,44) then -- Q - baixar
			Z = Z - 0.25
		end

		SetEntityCoordsNoOffset(Ped,X,Y,Z,false,false,false)

		Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCamDirections()
	local Ped = PlayerPedId()
	local Pitch = GetGameplayCamRelativePitch()
	local Heading = GetGameplayCamRelativeHeading() + GetEntityHeading(Ped)
	local x = -math.sin(Heading * math.pi / 180.0)
	local y = math.cos(Heading * math.pi / 180.0)
	local z = math.sin(Pitch * math.pi / 180.0)
	local Len = math.sqrt(x * x + y * y + z * z)
	if Len ~= 0 then
		x = x / Len
		y = y / Len
		z = z / Len
	end

	return x,y,z
end