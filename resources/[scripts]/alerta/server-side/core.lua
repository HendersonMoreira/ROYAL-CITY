local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

local ShotCooldowns = {}
local ShotCooldownTime = 10

local function GetPoliciaTargets()
    local Targets, Amount = vRP.NumPermission("Policia")
    if Amount and Amount > 0 then
        print("[alerta] NumPermission encontrou " .. Amount .. " policial(is) em servico.")
        return Targets, false
    end

    local Fallback = {}
    local Players = vRP.Players()
    local Count = 0
    for Passport, Source in pairs(Players) do
        local IsPolicia = vRP.HasGroup(Passport, "Policia") or vRP.HasPermission(Passport, "LSPD") or vRP.HasPermission(Passport, "BCSO") or vRP.HasPermission(Passport, "BCPR")
        local IsServico = vRP.HasService(Passport, "Policia")

        if Source and (IsPolicia or IsServico) then
            Fallback[Passport] = Source
            Count = Count + 1
        end
    end

    print("[alerta] fallback ativo: " .. Count .. " policial(is) online encontrados.")
    return Fallback, true
end

local function NotifyPolicia(title, code, color, x, y, z)
    local Targets, Fallback = GetPoliciaTargets()
    local Delivered = 0

    for Passport, Source in pairs(Targets) do
        async(function()
            vRPC.PlaySound(Source, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
            TriggerClientEvent("NotifyPush", Source, {
                code = code,
                title = title,
                x = x,
                y = y,
                z = z,
                color = color
            })
            TriggerClientEvent("Notify", Source, "amarelo", title .. " - use F2 para abrir a central.", 5000)
        end)
        Delivered = Delivered + 1
    end

    print("[alerta] notify enviado: " .. Delivered .. " policial(is). titulo=" .. title)
end

RegisterServerEvent("alerta:Tiro")
AddEventHandler("alerta:Tiro", function(x, y, z)
    local source = source
    local Passport = vRP.Passport(source)
    if not Passport then return end

    if ShotCooldowns[Passport] and os.time() < ShotCooldowns[Passport] then return end
    ShotCooldowns[Passport] = os.time() + ShotCooldownTime

    NotifyPolicia("Disparos Relatados", 10, 1, x, y, z)
end)

exports("AlertaVenda", function(source, nomeAcao, code, color)
    local Passport = vRP.Passport(source)
    if not Passport then return end
    local Coords = vRP.GetEntityCoords(source)
    NotifyPolicia(nomeAcao or "Atividade Suspeita", code or 30, color or 16, Coords["x"], Coords["y"], Coords["z"])
end)

RegisterCommand("testalerta", function(source)
    if source <= 0 then return end

    local Passport = vRP.Passport(source)
    if not Passport then return end

    if not vRP.HasGroup(Passport, "Policia") then
        TriggerClientEvent("Notify", source, "amarelo", "Comando restrito a policia.", 5000)
        return
    end

    local Coords = vRP.GetEntityCoords(source)
    NotifyPolicia("Teste de Disparo", 10, 1, Coords["x"], Coords["y"], Coords["z"])
    TriggerClientEvent("Notify", source, "verde", "Teste enviado para todos os policiais online.", 5000)
end)

RegisterCommand("testpush", function(source)
    if source <= 0 then return end
    local Coords = vRP.GetEntityCoords(source)
    TriggerClientEvent("NotifyPush", source, {
        code = 99,
        title = "Teste Push Direto",
        x = Coords["x"],
        y = Coords["y"],
        z = Coords["z"],
        color = 2
    })
    TriggerClientEvent("Notify", source, "verde", "Push direto enviado no seu client.", 5000)
end)

RegisterCommand("statuspolicia", function(source)
    if source <= 0 then return end

    local Passport = vRP.Passport(source)
    if not Passport then return end

    local IsGroup = vRP.HasGroup(Passport, "Policia")
    local IsLSPD = vRP.HasPermission(Passport, "LSPD")
    local IsBCSO = vRP.HasPermission(Passport, "BCSO")
    local IsBCPR = vRP.HasPermission(Passport, "BCPR")
    local InService = vRP.HasService(Passport, "Policia")

    local Msg = "Passaporte " .. Passport .. " | Policia=" .. tostring(IsGroup) .. " | LSPD=" .. tostring(IsLSPD) .. " | BCSO=" .. tostring(IsBCSO) .. " | BCPR=" .. tostring(IsBCPR) .. " | EmServico=" .. tostring(InService)
    TriggerClientEvent("Notify", source, "azul", Msg, 10000)
    print("[alerta] statuspolicia -> " .. Msg)
end)