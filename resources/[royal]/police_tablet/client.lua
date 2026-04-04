local tabletOpen = false
local timeThread = false
local pendingMemberInvite = nil

local function showInviteHelp(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0,false,true,-1)
end


local function sendClock()
    local hour = GetClockHours()
    local minute = GetClockMinutes()
    local day = GetClockDayOfMonth()
    local month = GetClockMonth() + 1
    local year = GetClockYear()

    local weekdays = {
        [0] = "Domingo",
        [1] = "Segunda-feira",
        [2] = "Terça-feira",
        [3] = "Quarta-feira",
        [4] = "Quinta-feira",
        [5] = "Sexta-feira",
        [6] = "Sábado"
    }

    SendNUIMessage({
        action = "setTime",
        hour = string.format("%02d",hour),
        minute = string.format("%02d",minute),
        day = string.format("%02d",day),
        month = string.format("%02d",month),
        year = tostring(year),
        weekday = weekdays[GetClockDayOfWeek()] or "Desconhecido"
    })
end

local function startClock()
    if timeThread then return end
    timeThread = true

    CreateThread(function()
        while tabletOpen do
            sendClock()
            Wait(1000)
        end

        timeThread = false
    end)
end

RegisterNetEvent("police_tablet:memberInvite")
AddEventHandler("police_tablet:memberInvite", function(data)
    pendingMemberInvite = {
        expiresAt = GetGameTimer() + ((tonumber(data and data.timeout) or 20) * 1000),
        policeId = data and data.policeId or "---",
        groupName = data and data.groupName or "Corporação",
        role = data and data.role or "Membro",
        officerName = data and data.officerName or "Oficial"
    }

    TriggerEvent("Notify", "azul", "Convite recebido de " .. pendingMemberInvite.groupName .. ". Aperte <b>E</b> para aceitar ou <b>G</b> para recusar.", 10000)
end)

CreateThread(function()
    while true do
        if pendingMemberInvite then
            if GetGameTimer() >= pendingMemberInvite.expiresAt then
                TriggerServerEvent("police_tablet:respondMemberInvite", false)
                pendingMemberInvite = nil
            else
                showInviteHelp(("Convite para entrar em %s como %s. ~INPUT_CONTEXT~ aceitar / ~INPUT_DETONATE~ recusar"):format(pendingMemberInvite.groupName, pendingMemberInvite.role))

                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("police_tablet:respondMemberInvite", true)
                    pendingMemberInvite = nil
                elseif IsControlJustPressed(0, 47) then
                    TriggerServerEvent("police_tablet:respondMemberInvite", false)
                    pendingMemberInvite = nil
                end
            end

            Wait(0)
        else
            Wait(500)
        end
    end
end)

RegisterNetEvent("police_tablet:openDenied")
AddEventHandler("police_tablet:openDenied",function(message)
    if TriggerEvent then
        TriggerEvent("Notify","vermelho",message or "Sem permissão.",5000)
    end
end)

RegisterNetEvent("police_tablet:open")
AddEventHandler("police_tablet:open",function(initial)
    tabletOpen = true
    SetNuiFocus(true,true)
    SendNUIMessage({ action = "open", payload = initial or {} })
    sendClock()
    startClock()
end)

RegisterNetEvent("police_tablet:payload")
AddEventHandler("police_tablet:payload",function(data)
    SendNUIMessage({ action = "payload", payload = data })
end)

RegisterNUICallback("close",function(_,cb)
    tabletOpen = false
    SetNuiFocus(false,false)
    SendNUIMessage({ action = "close" })
    if cb then cb("ok") end
end)

RegisterNUICallback("unlock",function(_,cb)
    SendNUIMessage({ action = "unlock" })
    TriggerServerEvent("police_tablet:requestBootstrap")
    if cb then cb("ok") end
end)

RegisterNUICallback("request",function(data,cb)
    TriggerServerEvent("police_tablet:request",data.action,data.payload or {})
    if cb then cb("ok") end
end)

RegisterNUICallback("notify",function(data,cb)
    TriggerEvent("Notify",data.color or "amarelo",data.message or "",5000)
    if cb then cb("ok") end
end)

RegisterCommand(Config.Command,function()
    TriggerServerEvent("police_tablet:tryOpen")
end)

RegisterKeyMapping(Config.Command,"Abrir tablet policial","keyboard",Config.OpenKey)
