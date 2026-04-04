-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("wn_org")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local wnORG = {}
Tunnel.bindInterface("wn_org", wnORG)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTADO
-----------------------------------------------------------------------------------------------------------------------------------------
local panelOpen = false
local currentOrgData = nil
local resourceName = GetCurrentResourceName()

-----------------------------------------------------------------------------------------------------------------------------------------
-- AUXILIARES
-----------------------------------------------------------------------------------------------------------------------------------------
local function debugPrint(...)
    -- print("[wn_org]", ...)
end

local function safeSetNuiFocus(hasFocus, hasCursor)
    SetNuiFocus(hasFocus, hasCursor)
    SetNuiFocusKeepInput(false)
end

local function notify(msgType, message)
    -- tenta alguns eventos comuns de notify sem quebrar a base
    TriggerEvent("Notify", msgType or "aviso", message or "")
    TriggerEvent("notify", msgType or "aviso", message or "")
    TriggerEvent("vrp_sound:source", "notify", 0.2)
end

local function openPanelWithData(orgData)
    if not orgData then return end

    panelOpen = true
    currentOrgData = orgData

    safeSetNuiFocus(true, true)
    SendNUIMessage({
        action = "openPanel",
        data = orgData
    })
end

local function updatePanelData(orgData)
    if not orgData then return end

    currentOrgData = orgData
    SendNUIMessage({
        action = "updateData",
        data = orgData
    })
end

local function closePanelInternal()
    panelOpen = false
    currentOrgData = nil

    safeSetNuiFocus(false, false)
    SendNUIMessage({ action = "closePanel" })
end

local function getPlayerCustomization()
    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then
        return nil
    end

    local data = {
        model = GetEntityModel(ped),
        components = {},
        props = {}
    }

    for componentId = 0, 11 do
        data.components[componentId + 1] = {
            component_id = componentId,
            drawable = GetPedDrawableVariation(ped, componentId),
            texture = GetPedTextureVariation(ped, componentId),
            palette = GetPedPaletteVariation(ped, componentId)
        }
    end

    for propId = 0, 7 do
        data.props[propId + 1] = {
            prop_id = propId,
            drawable = GetPedPropIndex(ped, propId),
            texture = GetPedPropTextureIndex(ped, propId)
        }
    end

    return data
end

local function applyCustomization(customization)
    if type(customization) ~= "table" then
        return false
    end

    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then
        return false
    end

    if customization.components then
        for _, comp in pairs(customization.components) do
            if comp and comp.component_id ~= nil and comp.drawable ~= nil then
                SetPedComponentVariation(
                    ped,
                    tonumber(comp.component_id) or 0,
                    tonumber(comp.drawable) or 0,
                    tonumber(comp.texture) or 0,
                    tonumber(comp.palette) or 0
                )
            end
        end
    end

    if customization.props then
        for _, prop in pairs(customization.props) do
            if prop and prop.prop_id ~= nil then
                local drawable = tonumber(prop.drawable) or -1
                local texture = tonumber(prop.texture) or 0

                if drawable < 0 then
                    ClearPedProp(ped, tonumber(prop.prop_id) or 0)
                else
                    SetPedPropIndex(
                        ped,
                        tonumber(prop.prop_id) or 0,
                        drawable,
                        texture,
                        true
                    )
                end
            end
        end
    end

    return true
end

local function setRadioFrequency(frequency)
    local freqNumber = tonumber(frequency)
    if not freqNumber then
        return false
    end

    local ok = false

    if GetResourceState("pma-voice") == "started" then
        ok = pcall(function()
            exports["pma-voice"]:setRadioChannel(freqNumber)
        end)
    end

    if not ok then
        pcall(function()
            MumbleSetRadioChannel(freqNumber)
            ok = true
        end)
    end

    return ok
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERFACE SERVER > CLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.OpenPanel(orgData)
    openPanelWithData(orgData)
end

function wnORG.GetCurrentClothes()
    return getPlayerCustomization()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("wn_org:Notify")
AddEventHandler("wn_org:Notify", function(msgType, message)
    notify(msgType, message)
end)

RegisterNetEvent("wn_org:SetRadioFrequency")
AddEventHandler("wn_org:SetRadioFrequency", function(frequency)
    local success = setRadioFrequency(frequency)
    if success then
        notify("sucesso", "Rádio configurada para frequência " .. tostring(frequency))
    else
        notify("amarelo", "Não foi possível configurar a rádio automaticamente.")
    end
end)

RegisterNetEvent("wn_org:ApplyClothes")
AddEventHandler("wn_org:ApplyClothes", function(customization)
    local success = applyCustomization(customization)
    if not success then
        notify("amarelo", "Não foi possível aplicar o uniforme automaticamente.")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------
for _, commandName in ipairs(Config.Commands.panel or {}) do
    RegisterCommand(commandName, function()
        vSERVER.OpenOrgPanel()
    end)
end

if Config.Commands.adminPanel then
    RegisterCommand(Config.Commands.adminPanel, function(_, args)
        local orgName = args and args[1]
        if not orgName or orgName == "" then
            notify("amarelo", "Use: /" .. tostring(Config.Commands.adminPanel) .. " [Organizacao]")
            return
        end

        vSERVER.OpenAdminPanel(orgName)
    end)
end

if Config.Commands.addBlacklist then
    RegisterCommand(Config.Commands.addBlacklist, function(_, args)
        local passport = tonumber(args and args[1])
        local org = tostring(args and args[2] or "")
        local reason = table.concat(args or {}, " ", 3)

        if not passport or org == "" then
            notify("amarelo", "Use: /" .. tostring(Config.Commands.addBlacklist) .. " [passaporte] [org] [motivo]")
            return
        end

        vSERVER.AddBlacklist(org, passport, reason, Config.Blacklist.days or 2)
    end)
end

if Config.Commands.removeBlacklist then
    RegisterCommand(Config.Commands.removeBlacklist, function(_, args)
        local passport = tonumber(args and args[1])
        if not passport then
            notify("amarelo", "Use: /" .. tostring(Config.Commands.removeBlacklist) .. " [passaporte]")
            return
        end

        vSERVER.RemoveBlacklist(passport)
    end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closePanel", function(_, cb)
    closePanelInternal()
    cb({ success = true })
end)

RegisterNUICallback("refreshData", function(data, cb)
    local org = data and data.org
    if not org then
        cb({ success = false, message = "Organização inválida." })
        return
    end

    local response = vSERVER.GetOrganizationData(org)
    if response then
        updatePanelData(response)
        cb(response)
        return
    end

    cb({ success = false, message = "Falha ao atualizar dados." })
end)

RegisterNUICallback("hireMember", function(data, cb)
    cb(vSERVER.HireMember(data.org, tonumber(data.passport)))
end)

RegisterNUICallback("fireMember", function(data, cb)
    cb(vSERVER.FireMember(data.org, tonumber(data.passport), data.reason or "Demitido pelo painel"))
end)

RegisterNUICallback("promoteMember", function(data, cb)
    cb(vSERVER.PromoteMember(data.org, tonumber(data.passport)))
end)

RegisterNUICallback("demoteMember", function(data, cb)
    cb(vSERVER.DemoteMember(data.org, tonumber(data.passport)))
end)

RegisterNUICallback("deposit", function(data, cb)
    cb(vSERVER.Deposit(data.org, tonumber(data.amount)))
end)

RegisterNUICallback("withdraw", function(data, cb)
    cb(vSERVER.Withdraw(data.org, tonumber(data.amount)))
end)

RegisterNUICallback("pix", function(data, cb)
    cb(vSERVER.Pix(data.org, tonumber(data.passport), tonumber(data.amount)))
end)

RegisterNUICallback("openRadio", function(data, cb)
    local success = setRadioFrequency(data and data.frequency)
    cb({ success = success })
end)

RegisterNUICallback("setRadioFrequency", function(data, cb)
    cb(vSERVER.ConfigRadioForAll(data.org, tostring(data.frequency)))
end)

RegisterNUICallback("openClothes", function(data, cb)
    cb(vSERVER.ApplyUniform(data.org))
end)

RegisterNUICallback("saveUniform", function(data, cb)
    cb(vSERVER.SaveUniform(data.org))
end)

RegisterNUICallback("configClothes", function(data, cb)
    cb(vSERVER.ConfigClothesForAll(data.org))
end)

-- O JS possui fluxo de metas, mas o servidor enviado no zip não tem a função correspondente.
-- Mantido apenas para não quebrar a interface.
RegisterNUICallback("saveGoals", function(_, cb)
    cb({ success = false, message = "Sistema de metas não está implementado no servidor." })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTROLES BLOQUEADOS COM NUI ABERTA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if panelOpen then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 18, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 68, true)
            DisableControlAction(0, 70, true)
            DisableControlAction(0, 91, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 322, true)
            DisableControlAction(0, 200, true)
            Wait(0)
        else
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        if panelOpen and IsPauseMenuActive() then
            SetPauseMenuActive(false)
        end
        Wait(panelOpen and 0 or 500)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FECHAR NO ESC VIA CLIENTE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if panelOpen and IsControlJustPressed(0, 322) then
            closePanelInternal()
        end
        Wait(panelOpen and 0 or 500)
    end
end)
