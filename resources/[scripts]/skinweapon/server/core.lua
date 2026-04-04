-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("skinweapon", Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERSKINS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.UserSkins()
    local Source = source
    local Passport = vRP.Passport(Source)
    local Identity = vRP.Identity(Passport)
    local Account = vRP.Account(Identity["license"])

    if Passport then
        local SkinsData = vRP.UserData(Passport, "Skins")

        if not SkinsData then
            SkinsData = {}
            vRP.Query("playerdata/GetData",{ Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })
        end

        TriggerClientEvent("skinweapon:SetGems", Source, Account["gems"])

        return SkinsData
    end

    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.BuySkin(Data)  
    local Source = source
    local Passport = vRP.Passport(Source)
    local Identity = vRP.Identity(Passport)
    local Account = vRP.Account(Identity["license"])

    if Passport then
        if Account["gems"] >= Data["price"] then
            local SkinsData = vRP.UserData(Passport, "Skins")
            local NewGems = Account["gems"] - Data["price"]

            for k,v in pairs(SkinsData) do
                if v == Data["id"] then
                    TriggerClientEvent("Notify", Source, "vermelha", "Você já possui esta skin.", 10000)        

                    return false
                end
            end

            table.insert(SkinsData, Data["id"])
    
            vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })
            vRP.UpgradeGemstone(Passport, NewGems)

            TriggerClientEvent("skinweapon:SetGems", Source, NewGems)
            TriggerClientEvent("Notify", Source, "verde", "Skin adquirida com sucesso.", 10000)
    
            return true
        else
            TriggerClientEvent("Notify", Source, "vermelha", "Você não possui gemas o suficiente.", 10000)
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ActiveSkin(Weapon, Component)
    local Source = source
    local Passport = vRP.Passport(Source)

    if Passport then
        if Weapon then
            local SkinsData = vRP.UserData(Passport, "Skins")
    
            SkinsData[Weapon] = Component
    
            vRP.Query("playerdata/GetData",{ Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })
    
            return true
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TransferSkin(Target, Data)
    local Source = source
    local Passport = vRP.Passport(Source)

    if Passport then
        if Target and Data then
            local SkinsData = vRP.UserData(Passport, "Skins") or {}
            local TargetSkinsData = vRP.UserData(Target, "Skins") or {}

            if not TargetSkinsData then
                TargetSkinsData = {}
            end

            for k,v in pairs(TargetSkinsData) do
                if v == Data["id"] then
                    TriggerClientEvent("Notify", Source, "vermelha", "O jogador já possui esta Skin.", 10000)        

                    return false
                end
            end

            for k,v in pairs(SkinsData) do
                if v == Data["id"] then
                    table.remove(SkinsData, k)
                end
            end

            table.insert(TargetSkinsData, Data["id"])

            vRP.Query("playerdata/SetData",{ Passport = Target, Name = "Skins", Information = json.encode(TargetSkinsData) })
            vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(SkinsData) })

            TriggerClientEvent("Notify", Source, "verde", "Você transferiu a Skin <b>"..Data["name"].."</b> para o jogador de ID: <b>"..Target.."</b>", 10000)        

            return true
        end
    end
    
    return false
end