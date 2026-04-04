-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIMA / HORARIO LOCAL
-----------------------------------------------------------------------------------------------------------------------------------------
local WeatherLocal = false
local ClockLocal = false

local LocalHour = 12
local LocalMinute = 0
local LastClockUpdate = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function notify(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false,false)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD CLIMA/HORARIO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 1000

		if WeatherLocal or ClockLocal then
			TimeDistance = 1

			if WeatherLocal then
				SetWeatherTypePersist("CLEAR")
				SetWeatherTypeNow("CLEAR")
				SetWeatherTypeNowPersist("CLEAR")
				SetOverrideWeather("CLEAR")
			end

			if ClockLocal then
				local GameTimer = GetGameTimer()

				if LastClockUpdate == 0 then
					LastClockUpdate = GameTimer
				end

				-- 1 minuto do jogo a cada 2 segundos reais
				if GameTimer - LastClockUpdate >= 2000 then
					LastClockUpdate = GameTimer
					LocalMinute = LocalMinute + 1

					if LocalMinute >= 60 then
						LocalMinute = 0
						LocalHour = LocalHour + 1

						if LocalHour >= 24 then
							LocalHour = 0
						end
					end
				end

				NetworkOverrideClockTime(LocalHour,LocalMinute,0)
			end
		end

		Wait(TimeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clima",function()
	WeatherLocal = true
	ClockLocal = true

	LocalHour = 12
	LocalMinute = 0
	LastClockUpdate = GetGameTimer()

	notify("Clima local ativado: CLEAR | Horário local iniciado em 12:00")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIMAOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("climaoff",function()
	WeatherLocal = false
	ClockLocal = false

	ClearOverrideWeather()
	ClearWeatherTypePersist()
	NetworkClearClockTimeOverride()

	LastClockUpdate = 0

	notify("Clima local desativado. Voltando ao padrão do servidor.")
end)