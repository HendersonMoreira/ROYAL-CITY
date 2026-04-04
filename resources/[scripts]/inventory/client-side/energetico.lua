-----------------------------------------------------------------------------------------------------------------------------------------
-- ENERGETICO
-----------------------------------------------------------------------------------------------------------------------------------------
local Energetic = 0
local EnergeticTimer = 0
local EnergeticMultiplier = 1.0

RegisterNetEvent("inventory:Energetic")
AddEventHandler("inventory:Energetic",function(Seconds,Multiplier)
	if Energetic > 0 then
		TriggerEvent("Notify","Aviso","Você já está sob efeito de energético.","amarelo",5000)
		return
	end

	Energetic = Seconds or 60  --- tempo do efeito em segundos
	EnergeticMultiplier = Multiplier or 1.30 --velocidade nao colocar maisq 1.48 bugar coloca mesmo paramentro em server-side/item.lua linha 92 
	EnergeticTimer = GetGameTimer() + 1000

	RestorePlayerStamina(PlayerId(),1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),EnergeticMultiplier)
	TriggerEvent("Notify","Sucesso","Energético utilizado com sucesso.","verde",5000)

	CreateThread(function()
		while Energetic > 0 do
			local Ped = PlayerPedId()

			if GetEntityHealth(Ped) <= 100 then
				break
			end

			if GetGameTimer() >= EnergeticTimer then
				Energetic = Energetic - 1
				EnergeticTimer = GetGameTimer() + 1000
				RestorePlayerStamina(PlayerId(),1.0)
			end

			Wait(250)
		end

		Energetic = 0
		EnergeticTimer = 0
		EnergeticMultiplier = 1.0
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		TriggerEvent("Notify","Aviso","O efeito do energético acabou.","amarelo",5000)
	end)
end)
