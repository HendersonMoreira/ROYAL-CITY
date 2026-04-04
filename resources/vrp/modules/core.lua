-- base.lua

Sources = {}
Characters = {}
GlobalState["Players"] = {}

local Arena = {}
local Prepare = {}
local Players = {}

-- drugs.lua

local Weed = {}
local Alcohol = {}
local Chemical = {}

-- inventory.lua

local Entitys = {}
local Returned = {}

-- player.lua

local SpawnSelected = {}
local Objects = {}

-- salary.lua

local Salary = {}

-- queue.lua

Lang = {
	["Join"] = "Entrando...",
	["Connecting"] = "Conectando...",
	["Position"] = "Você é o %d/%d da fila, aguarde sua conexão",
	["Error"] = "Conexão perdida."
}

Queue = {
	["List"] = {},
	["Players"] = {},
	["Counts"] = 0,
	["Connecting"] = {},
	["Threads"] = 0,
	["Max"] = 2048
}

-- base.lua

function vRP.Prepare(Name, Query)
    Prepare[Name] = Query
end

function vRP.Query(Name, Params)
    return exports["oxmysql"]:query_async(Prepare[Name], Params)
end

function vRP.Scalar(Name, Params)
    return exports["oxmysql"]:scalar_async(Prepare[Name], Params)
end

-- function vRP.Identities(source)
--     local Identifier = GetPlayerIdentifierByType(source, BaseMode)

--     if Identifier and string.find(Identifier, BaseMode) then
--         return splitString(Identifier, ":")[2]
--     end

--     return false
-- end

function vRP.Identities(source)
    if not source then
        return false
    end

    local total = GetNumPlayerIdentifiers(source)
    if not total or total <= 0 then
        return false
    end

    for i = 0, total - 1 do
        local identifier = GetPlayerIdentifier(source, i)
        if identifier and identifier:find("license:", 1, true) then
            return identifier:gsub("license:", "")
        end
    end

    for i = 0, total - 1 do
        local identifier = GetPlayerIdentifier(source, i)
        if identifier and identifier:find("steam:", 1, true) then
            return identifier:gsub("steam:", "")
        end
    end

    return false
end

function vRP.Archive(Archive, Text)
    local Archive = io.open(Archive, "a")

    if Archive then
        Archive:write(Text .. "\n")
        Archive:close()
    end
end

function vRP.Banned(License)
    local Consult = vRP.Query("banneds/GetBanned", { license = License })
    
    if not Consult[1] then
        return false
    end
    
    if Consult[1]["time"] <= os.time() then
        vRP.Query("banneds/RemoveBanned", { license = License })
        return false
    end
    
    return true
end

function vRP.Account(License)
    local Consult = vRP.Query("accounts/Account", { license = License })
    
    return Consult[1] or false
end

function vRP.UserData(Passport, Key)
    local Consult = vRP.Query("playerdata/GetData", { Passport = Passport, Name = Key })

    return Consult[1] and json.decode(Consult[1]["Information"]) or {}
end

function vRP.InsidePropertys(Passport, Coords)
    local Datatable = vRP.Datatable(Passport)

    if Datatable then
        Datatable["Pos"] = { x = Optimize(Coords["x"]), y = Optimize(Coords["y"]), z = Optimize(Coords["z"]) }
    end
end

function tvRP.Barbershop(Barbershop)
    local source = source
    local Ped = GetPlayerPed(source)

    local Fathers = { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,42,43,44 }
    local Mothers = { 21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,45 }

    SetPedHeadBlendData(Ped,Fathers[Barbershop[1] + 1],Mothers[Barbershop[2] + 1],0,Barbershop[5],0,0,Barbershop[3] + 0.0,0,0,false)

	SetPedEyeColor(Ped,Barbershop[4])

	SetPedComponentVariation(Ped,2,Barbershop[10],0,0)
	SetPedHairColor(Ped,Barbershop[11],Barbershop[12])

	SetPedHeadOverlay(Ped,0,Barbershop[7],1.0)
	SetPedHeadOverlayColor(Ped,0,0,0,0)

	SetPedHeadOverlay(Ped,1,Barbershop[22],Barbershop[23])
	SetPedHeadOverlayColor(Ped,1,1,Barbershop[24],Barbershop[24])

	SetPedHeadOverlay(Ped,2,Barbershop[19],Barbershop[20])
	SetPedHeadOverlayColor(Ped,2,1,Barbershop[21],Barbershop[21])

	SetPedHeadOverlay(Ped,3,Barbershop[9],1.0)
	SetPedHeadOverlayColor(Ped,3,0,0,0)

	SetPedHeadOverlay(Ped,4,Barbershop[13],Barbershop[14])
	SetPedHeadOverlayColor(Ped,4,0,0,0)

	SetPedHeadOverlay(Ped,5,Barbershop[25],Barbershop[26])
	SetPedHeadOverlayColor(Ped,5,2,Barbershop[27],Barbershop[27])

	SetPedHeadOverlay(Ped,6,Barbershop[6],1.0)
	SetPedHeadOverlayColor(Ped,6,0,0,0)

	SetPedHeadOverlay(Ped,8,Barbershop[16],Barbershop[17])
	SetPedHeadOverlayColor(Ped,8,2,Barbershop[18],Barbershop[18])

	SetPedHeadOverlay(Ped,9,Barbershop[8],1.0)
	SetPedHeadOverlayColor(Ped,9,0,0,0)

	SetPedFaceFeature(Ped,0,Barbershop[28])
	SetPedFaceFeature(Ped,1,Barbershop[29])
	SetPedFaceFeature(Ped,2,Barbershop[30])
	SetPedFaceFeature(Ped,3,Barbershop[31])
	SetPedFaceFeature(Ped,4,Barbershop[32])
	SetPedFaceFeature(Ped,5,Barbershop[33])
	SetPedFaceFeature(Ped,6,Barbershop[44])
	SetPedFaceFeature(Ped,7,Barbershop[34])
	SetPedFaceFeature(Ped,8,Barbershop[36])
	SetPedFaceFeature(Ped,9,Barbershop[35])
	SetPedFaceFeature(Ped,10,Barbershop[45])
	SetPedFaceFeature(Ped,11,Barbershop[15])
	SetPedFaceFeature(Ped,12,Barbershop[42])
	SetPedFaceFeature(Ped,13,Barbershop[46])
	SetPedFaceFeature(Ped,14,Barbershop[37])
	SetPedFaceFeature(Ped,15,Barbershop[38])
	SetPedFaceFeature(Ped,16,Barbershop[40])
	SetPedFaceFeature(Ped,17,Barbershop[39])
	SetPedFaceFeature(Ped,18,Barbershop[41])
	SetPedFaceFeature(Ped,19,Barbershop[43])
end

function tvRP.FilesDirectory(Directory)
    local Directory = Directory:gsub("/", "\\")
    local Files = {}

    for File in io.popen('dir "' .. Directory .. '" /b'):lines() do
        local Name = File:match("(.+)%..+")
        table.insert(Files, Name)
    end

    return Files
end

function vRP.Inventory(Passport)
    local Datatable = vRP.Datatable(Passport)

    if Datatable and not Datatable["Inventory"] then
        Datatable["Inventory"] = {}
    end

    return Datatable and Datatable["Inventory"] or {}
end

function vRP.SaveTemporary(Passport, source, Route)
    local Datatable = vRP.Datatable(Passport)

    if not Arena[Passport] and Datatable then
        local Ped = GetPlayerPed(source)
        local Inventory = Datatable["Inventory"]
        local Health = GetEntityHealth(Ped)
        local Armour = GetPedArmour(Ped)
        local Stress = Datatable["Stress"]
        local Hunger = Datatable["Hunger"]
        local Thirst = Datatable["Thirst"]

        Arena[Passport] = {
            Inventory = Inventory,
            Health = Health,
            Armour = Armour,
            Stress = Stress,
            Hunger = Hunger,
            Thirst = Thirst,
            route = Route
        }

        SetPedArmour(Ped, 100)
        vRPC.SetHealth(source, 200)
        vRP.UpgradeHunger(Passport, 100)
        vRP.UpgradeThirst(Passport, 100)
        vRP.DowngradeStress(Passport, 100)

        TriggerEvent("inventory:saveTemporary", Passport)

        Datatable["Inventory"] = {}

        for Number, v in pairs(ArenaItens) do
            vRP.GenerateItem(Passport, Number, v, false)
        end

        exports["vrp"]:Bucket(source,"Enter",Route)
    end
end

function vRP.ApplyTemporary(Passport, source)
    local Datatable = vRP.Datatable(Passport)

    if Arena[Passport] and Datatable then
        Datatable["Inventory"] = {}
        Datatable["Inventory"] = Arena[Passport]["Inventory"]
        Datatable["Stress"] = Arena[Passport]["Stress"]
        Datatable["Hunger"] = Arena[Passport]["Hunger"]
        Datatable["Thirst"] = Arena[Passport]["Thirst"]

        TriggerClientEvent("hud:Thirst", source, Datatable["Thirst"])
        TriggerClientEvent("hud:Hunger", source, Datatable["Hunger"])
        TriggerClientEvent("hud:Stress", source, Datatable["Stress"])
        
        local Ped = GetPlayerPed(source)
        SetPedArmour(Ped, Datatable["Armour"])
        vRPC.SetHealth(source, Datatable["Health"])

        TriggerEvent("inventory:applyTemporary", Passport)
        exports["vrp"]:Bucket(source,"Exit")

        Arena[Passport] = nil
    end
end

function vRP.SkinCharacter(Passport, Hash)
    local Datatable = vRP.Datatable(Passport)

    if Datatable then
        Datatable["Skin"] = Hash
    end
end

function vRP.Passport(source)
    return Characters[source] and Characters[source]["id"] or false
end

function vRP.Players()
    return Sources
end

function vRP.Source(Passport)
    local Passport = parseInt(Passport)

    return Sources[Passport]
end

function vRP.Datatable(Passport)
    local Source = Sources[parseInt(Passport)]
    
    return Characters[Source] and Characters[Source]["table"] or false
end

function vRP.Kick(source, Reason)
    DropPlayer(source, Reason)
end

AddEventHandler("playerDropped", function(Reason)
    local source = source
    local Ped = GetPlayerPed(source)
    local Health = GetEntityHealth(Ped)
    local Armour = GetPedArmour(Ped)
    local Coords = GetEntityCoords(Ped)

    if Characters[source] and DoesEntityExist(Ped) then
        Disconnect(source, Health, Armour, Coords, Reason)
    end
end)

function Disconnect(source, Health, Armour, Coords, Reason)
    local Passport = vRP.Passport(source)

    if Passport then
        exports["discord"]:Embed("Disconnect", string.format("**Source:** %s **Passaporte:** %s **Health:** %s **Armour:** %s **Cds:** %s **Motivo:** %s", source, Passport, Health, Armour, Coords, Reason), 3092790)
        
        local Datatable = vRP.Datatable(Passport)
        if Datatable then
            if Arena[Passport] then
                Datatable["Stress"] = Arena[Passport]["Stress"]
                Datatable["Hunger"] = Arena[Passport]["Hunger"]
                Datatable["Thirst"] = Arena[Passport]["Thirst"]
                Datatable["Armour"] = Arena[Passport]["Armour"]
                Datatable["Health"] = Arena[Passport]["Health"]
                Datatable["Inventory"] = Arena[Passport]["Inventory"]
                Datatable["Pos"] = { x = ArenaCoords["x"], y = ArenaCoords["y"], z = ArenaCoords["z"] }

                TriggerEvent("arena:Players", "-", Arena[Passport]["route"])
                Arena[Passport] = nil
            else
                Datatable["Health"] = Health
                Datatable["Armour"] = Armour
                Datatable["Pos"] = { x = Optimize(Coords["x"]), y = Optimize(Coords["y"]), z = Optimize(Coords["z"]) }
            end

            if Datatable["Health"] <= 100 then
                TriggerClientEvent("hud:Textform", -1, Coords, string.format("<b>Passaporte:</b> %s<br><b>Motivo:</b> %s", Passport, Reason), 3 * 60000)
            end

            TriggerEvent("Disconnect", Passport, source)

            vRP.Query("playerdata/SetData", { Passport = Passport, Name = "Datatable", Information = json.encode(Datatable) })
            
            Characters[source] = nil
            Sources[Passport] = nil

            if GlobalState["Players"][source] then
                GlobalState["Players"][source] = nil
                GlobalState:set("Players", GlobalState["Players"], true)
            end
        end
    end
end

AddEventHandler("SaveServer", function()
    for Number in pairs(Sources) do
        local Datatable = vRP.Datatable(Number)

        if Datatable then
            vRP.Query("playerdata/SetData", { Passport = Number, Name = "Datatable", Information = json.encode(Datatable) })
        end
    end
end)

AddEventHandler("Queue:Connecting", function(source, Identifiers, Deferrals)
    Deferrals.defer()

    if not source then
        Deferrals.done("Conexão perdida.")
        return
    end

    local Identities = vRP.Identities(source)
    if not Identities then
        print("[vRP DEBUG] Falha ao pegar identidade do player:", source)
        Deferrals.done("Erro ao identificar jogador.")
        return
    end

    local Account = vRP.Account(Identities)
    if not Account then
        vRP.Query("accounts/newAccount", { license = Identities })
    end

    if Maintenance then
        if MaintenanceLicenses[Identities] then
            Deferrals.done()
        else
            Deferrals.done(MaintenanceText)
        end
    elseif vRP.Banned(Identities) then
        Deferrals.done("Banido" .. ".")
    elseif Whitelisted then
        local Account = vRP.Account(Identities)
        if Account["whitelist"] then
            Deferrals.done()
        else
            Deferrals.done("\n\nEfetue sua liberação através do link: <b>"  .. ServerLink .. "</b> enviando o número <b>" .. Account["id"] .. "</b>")
        end
    else
        Deferrals.done()
    end

    TriggerEvent("Queue:Remove", Identifiers)
end)

function vRP.CharacterChosen(source, Passport, Model)
    local Barbershop = false
    Sources[Passport] = source

    if not Characters[source] then
        local Consult = vRP.Query("characters/Person", { id = Passport })[1]
        local Identities = vRP.Identities(source)
        local Account = vRP.Account(Identities)
        
        Characters[source] = {
            bank = Consult["bank"],
            id = Consult["id"],
            sex = Consult["sex"],
            blood = Consult["blood"],
            Medic = Consult["Medic"],
            prison = Consult["prison"],
            fines = Consult["fines"],
            phone = Consult["phone"],
            name = Consult["name"],
            name2 = Consult["name2"],
            license = Consult["license"],
            premium = Account["premium"],
            Level = Account["Level"],
            Login = Consult["Login"],
            discord = Account["discord"],
            chars = Account["chars"],
            table = vRP.UserData(Passport, "Datatable")
        }
        
        Players[source] = Passport
        GlobalState["Players"] = Players
        GlobalState:set("Players", GlobalState["Players"], true)
        
        if Model then
            Barbershop = true
            Characters[source]["table"]["Skin"] = Model
            Characters[source]["table"]["Inventory"] = {}
            vRP.GenerateItem(Passport, "identity-" .. Passport, 1, false)

            for Number, v in pairs(CharacterItens) do
                vRP.GenerateItem(Passport, Number, v, false)
            end

            vRP.Query("playerdata/SetData", { Passport = Passport, Name = "Barbershop", Information = json.encode(BarbershopInit[Model]) })
            vRP.Query("playerdata/SetData", { Passport = Passport, Name = "Clothings", Information = json.encode(SkinshopInit[Model]) })
            vRP.Query("playerdata/SetData", { Passport = Passport, Name = "Datatable", Information = json.encode(Characters[source].table) })
        end

        if Account["gems"] > 0 then
            TriggerClientEvent("hud:AddGemstone", source, Account["gems"])
        end

        vRP.Query("characters/LastLogin",{ Passport = Passport })

        exports["discord"]:Embed("Connect", string.format("**Source:** %s **Passaporte:** %s **Ip:** %s", source, Passport, GetPlayerEndpoint(source)), 3092790)
    end
    
    TriggerEvent("CharacterChosen", Passport, source, Barbershop)
end

-- drugs.lua

function vRP.WeedReturn(Passport)
    local WeedTime = Weed[Passport]

    if WeedTime then
        local RemainingTime = WeedTime - os.time()

        if RemainingTime > 0 then
            return parseInt(RemainingTime)
        else
            Weed[Passport] = nil
        end
    end

    return 0
end

function vRP.WeedTimer(Passport, Time)
    Weed[Passport] = (Weed[Passport] or os.time()) + Time * 60
end

function vRP.ChemicalReturn(Passport)
    local TimeLeft = Chemical[Passport] and Chemical[Passport] - os.time() or 0

    if TimeLeft > 0 then
        return parseInt(TimeLeft)
    else
        Chemical[Passport] = nil
        return 0
    end
end

function vRP.ChemicalTimer(Passport, Time)
    Chemical[Passport] = (Chemical[Passport] or os.time()) + Time * 60
end

function vRP.AlcoholReturn(Passport)
    local TimeLeft = Alcohol[Passport] and Alcohol[Passport] - os.time() or 0

    if TimeLeft > 0 then
        return parseInt(TimeLeft)
    else
        Alcohol[Passport] = nil
        return 0
    end
end

function vRP.AlcoholTimer(Passport, Time)
    Alcohol[Passport] = (Alcohol[Passport] or os.time()) + Time * 60
end

-- groups.lua

function vRP.Groups()
    return Groups
end

function vRP.DataGroups(Permission)
    return vRP.GetSrvData("Permissions:" .. Permission)
end

function vRP.GetUserType(Passport, Type)
    local Passport = tostring(Passport)

    for Permission, Group in pairs(Groups) do
        if Group["Type"] == Type then
            local Datatable = vRP.GetSrvData("Permissions:" .. Permission)

            if Datatable[Passport] then
                return Permission
            end
        end
    end

    return nil
end

function vRP.Hierarchy(Permission)
    return Groups[Permission] and Groups[Permission]["Hierarchy"] or false
end

function vRP.NumPermission(Permission)
    local Amount = 0
    local Sources = {}

    if Groups[Permission] and Groups[Permission]["Permission"] then
        for Index in pairs(Groups[Permission]["Permission"]) do
            local Service = Groups[Index] and Groups[Index]["Service"]

            if Service then
                for Passport, Source in pairs(Service) do
                    if Source and Characters[Source] and not Sources[Passport] then
                        Sources[Passport] = Source
                        Amount = Amount + 1
                    end
                end
            end
        end
    end

    return Sources, Amount
end

function vRP.ServiceToggle(Source, Passport, Permission, Silenced)
    local Passport = tostring(Passport)
    local PermissionGroup = splitString(Permission, "-")[1]

    if Characters[Source] and Groups[PermissionGroup] and Groups[PermissionGroup]["Service"] then
        if Groups[PermissionGroup]["Service"][Passport] then
            vRP.ServiceLeave(Source, Passport, PermissionGroup, Silenced)
        elseif vRP.HasPermission(Passport, PermissionGroup) then
            vRP.ServiceEnter(Source, Passport, PermissionGroup, Silenced)
        end
    end
end

function vRP.ServiceEnter(Source, Passport, Permission, Silenced)
    local Passport = tostring(Passport)

    if not Characters[Source] then return end

    if Groups[Permission]["Client"] then
        Player(Source)["state"][Permission] = true
        TriggerClientEvent("service:Client",Source,Permission)
    end

    if Groups[Permission]["Markers"] then
        TriggerEvent("blipsystem:Enter", Source, Permission, true)
    end

    if Groups[Permission] and Groups[Permission]["Salary"] then
        TriggerEvent("Salary:Add", Passport, Permission)
    end

    Groups[Permission]["Service"][Passport] = Source

    if not Silenced then
        TriggerClientEvent("Notify",Source,"Sucesso","Entrou em serviço.","verde",5000)
    end
end

function vRP.ServiceLeave(Source, Passport, Permission, Silenced)
    local Passport = tostring(Passport)

    if Characters[Source] then
        if Groups[Permission]["Client"] then
            Player(Source)["state"][Permission] = false
            TriggerClientEvent("service:Client",Source,Permission)
        end

        if Groups[Permission]["Markers"] then
            TriggerEvent("blipsystem:Exit", Source)
            TriggerClientEvent("radio:RadioClean", Source)
        end

        if Groups[Permission] and Groups[Permission]["Salary"] then
            TriggerEvent("Salary:Remove", Passport, Permission)
        end

        if Groups[Permission]["Service"] and Groups[Permission]["Service"][Passport] then
            Groups[Permission]["Service"][Passport] = nil
        end

        if not Silenced then
            TriggerClientEvent("Notify",Source,"Sucesso","Saiu de serviço.","verde", 5000)
        end
    end
end

function vRP.SetPermission(Passport, Permission, Level, Mode)
    local Passport = tostring(Passport)

    if Groups[Permission] then
        local Datatable = vRP.GetSrvData("Permissions:" .. Permission)

        if Mode then
            if "Demote" == Mode then
                Datatable[Passport] = Datatable[Passport] + 1
                
                if #Groups[Permission]["Hierarchy"] < Datatable[Passport] then
                    Datatable[Passport] = #Groups[Permission]["Hierarchy"]
                end
            else
                Datatable[Passport] = Datatable[Passport] - 1

                if Datatable[Passport] < 1 then
                    Datatable[Passport] = 1
                end
            end
        else
            if Level then
                Level = parseInt(Level)
                if #Groups[Permission]["Hierarchy"] < Level then
                    Level = #Groups[Permission]["Hierarchy"]
                end

                Datatable[Passport] = Level
            end

            if not Level then
                Datatable[Passport] = #Groups[Permission]["Hierarchy"]
            end
        end

        vRP.ServiceEnter(vRP.Source(Passport), Passport, Permission, true)
        vRP.SetSrvData("Permissions:" .. Permission, Datatable, true)
    end
end

function vRP.RemovePermission(Passport, Permission)
    local Passport = tostring(Passport)

    if Groups[Permission] then
        if Groups[Permission]["Service"] and Groups[Permission]["Service"][Passport] then
            Groups[Permission]["Service"][Passport] = nil
        end

        local Datatable = vRP.GetSrvData("Permissions:" .. Permission)

        if Datatable[Passport] then
            Datatable[Passport] = nil
            vRP.ServiceLeave(vRP.Source(Passport), Passport, Permission, true)
            vRP.SetSrvData("Permissions:" .. Permission, Datatable, true)
        end
    end
end

function vRP.HasPermission(Passport, Permission, Level)
    local Passport = tostring(Passport)
    local Datatable = vRP.GetSrvData("Permissions:" .. Permission)

    if Datatable[Passport] then
        if not Level or Level >= Datatable[Passport] then
            return Datatable[Passport]
        end
    end

    return false
end

function vRP.HasGroup(Passport, Permission, Level)
    local Passport = tostring(Passport)

    if Groups[Permission] then
        for Index, _ in pairs(Groups[Permission]["Permission"]) do
            local Datatable = vRP.GetSrvData("Permissions:" .. Index)

            if Datatable[Passport] then
                if not Level or Level >= Datatable[Passport] then
                    return true
                end
            end
        end
    end
    
    return false
end

function vRP.HasService(Passport, Permission)
    local Passport = tostring(Passport)

    if Groups[Permission] then
        for Index, _ in pairs(Groups[Permission]["Permission"]) do
            if Groups[Index]["Service"][Passport] then
                return true
            end
        end
    end

    return false
end

exports('CallPolice', function(Data)
    local source = Data["Source"]
    local Passport = Data["Passport"]
    local Permission = Data["Permission"]
    local Coords = Data["Coords"] or vRP.GetEntityCoords(source)

    local Service = vRP.NumPermission(Permission)
    for Passports, Sources in pairs(Service) do
        async(function()
            vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
            local NotifyData = { code = Data["Code"], title = Data["Name"], x = Coords["x"], y = Coords["y"], z = Coords["z"], color = Data["Color"] }

            if Data["Vehicle"] then
                NotifyData["vehicle"] = Data["Vehicle"]
            end

            if Data["Percentage"] then
                NotifyData["percentage"] = Data["Percentage"]
            end

            if Data["Wanted"] then
                TriggerEvent("Wanted", source, Passport, Data["Wanted"])
            end

            TriggerClientEvent("NotifyPush", Sources, NotifyData)
        end)
    end
end)

AddEventHandler("Connect", function(Passport, Source, First)
    local Passport = tostring(Passport)

    for Permission, _ in pairs(Groups) do
        if vRP.HasPermission(Passport, Permission) then
            if false ~= Groups[Permission]["Service"][Passport] then
                if not First then
                    if nil ~= Groups[Permission]["Service"][Passport] then
                        vRP.ServiceEnter(Source, Passport, Permission, true)
                    end
                end
            end
        end
    end
end)

AddEventHandler("Disconnect", function(Passport, Source)
    local Passport = tostring(Passport)

    for Permission, _ in pairs(Groups) do
        if Groups[Permission]["Service"][Passport] then
            if Groups[Permission]["Markers"] then
                TriggerEvent("blipsystem:Exit", Source)
            end

            Groups[Permission]["Service"][Passport] = false
        end

        if Groups[Permission] and Groups[Permission]["Salary"] then
            TriggerEvent("Salary:Remove", Passport, Permission)
        end
    end
end)

-- identity.lua

function vRP.FalseIdentity(Passport)
	local Consult = vRP.Query("fidentity/Result",{ id = Passport })

	return Consult[1] or false
end

function vRP.FullName(Passport)
	local Identity = vRP.Identity(Passport)

	if Identity then
		return Identity["name"] .. " " .. Identity["name2"]
	else
		return "Indivíduo Indigente"
	end
end

function vRP.Identity(Passport)
    local Source = vRP.Source(Passport)

    if Characters[Source] then
        return Characters[Source] or false
    else
        local Consult = vRP.Query("characters/Person", { id = Passport })
        return Consult[1] or false
    end
end

function vRP.InsertPrison(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)

    if Amount > 0 then
        vRP.Query("characters/setPrison", { Passport = Passport, prison = Amount })

        if Characters[Source] then
            Characters[Source]["prison"] = Amount
        end
    end
end

function vRP.UpdatePrison(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/removePrison",{ prison = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["prison"] = Characters[Source]["prison"] - parseInt(Amount)

			if 0 >= Characters[Source]["prison"] then
				Characters[Source]["prison"] = 0
                Player(Source)["state"]["Prison"] = false
				vRP.Teleport(Source, PrisonCoords["x"], PrisonCoords["y"], PrisonCoords["z"])
				TriggerClientEvent("Notify",Source, "Sucesso", "Serviços finalizados.", "verde", 5000)
			else
				TriggerClientEvent("Notify",Source, "Serviços", "Restam <b>" .. Characters[Source]["prison"] .. " serviços</b>.", "azul", 5000)
			end
		end
	end
end

function vRP.UpgradeCharacters(source)
    if Characters[source] then
        vRP.Query("accounts/infosUpdatechars", { license = Characters[source]["license"] })
        Characters[source]["chars"] = Characters[source]["chars"] + 1
    end
end

function vRP.UserGemstone(License)
    local Account = vRP.Account(License)

    return Account["gems"] or 0
end

function vRP.UpgradeGemstone(Passport, Amount)
    local Amount = parseInt(Amount)
    local License = vRP.Identity(Passport)
    local Source = vRP.Source(Passport)

    if Amount > 0 and License then
        vRP.Query("accounts/AddGems", { license = License["license"], gems = Amount })

        if Characters[Source] then
            TriggerClientEvent("hud:AddGemstone", Source, Amount)
        end
    end
end

function vRP.UpgradeNames(Passport, Name, Name2)
    local Source = vRP.Source(Passport)

    vRP.Query("characters/updateName", { Passport = Passport, name = Name, name2 = Name2 })

    if Characters[Source] then
        Characters[Source]["name2"] = Name2
        Characters[Source]["name"] = Name
    end
end

function vRP.UpgradePhone(Passport, Phone)
    local Source = vRP.Source(Passport)

    vRP.Query("characters/updatePhone", { id = Passport, phone = Phone })

    if Characters[Source] then
        Characters[Source]["phone"] = Phone
    end
end

function vRP.PassportPlate(Plate)
    local Consult = vRP.Query("vehicles/plateVehicles", { plate = Plate })

    return Consult[1] and Consult[1]["Passport"] or false
end


function vRP.GeneratePlate()
    local Plate, Exists

    repeat
        Plate = GenerateString("DDLLLDDD")
        Exists = vRP.PassportPlate(Plate)
    until not Exists

    return Plate
end

-- inventory.lua

function vRP.ArrestItens(Passport)
    if Passport then
        local Inventory = vRP.Inventory(Passport)

        for _, v in pairs(Inventory) do
            if ItemArrest(v["item"]) then
                vRP.RemoveItem(Passport, v["item"], v["amount"], true)
            end
        end
    end
end

function vRP.ConsultItem(Passport, Item, Amount)
    local Source = vRP.Source(Passport)

    Amount = Amount or 1

    if Source then
        local Consult = vRP.InventoryItemAmount(Passport, Item)
        
        if Amount > Consult[1] then
            return false
        elseif vRP.CheckDamaged(Consult[2]) then
            return false
        end
    end

    return true
end

function vRP.CheckWeight(Passport)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)

    if Source and Datatable then
        if not Datatable["Weight"] then
            Datatable["Weight"] = 30
        end

        return Datatable["Weight"]
    end

    return 0
end

function vRP.UpgradeWeight(Passport, Amount)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)

    if Source and Datatable then
        if not Datatable["Weight"] then
            Datatable["Weight"] = 30
        end

        Datatable["Weight"] = Datatable["Weight"] + Amount
    end
end

function vRP.RemoveWeight(Passport, Amount)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)

    if Source and Datatable then
        if not Datatable["Weight"] then
            Datatable["Weight"] = 30
        end

        Datatable["Weight"] = Datatable["Weight"] - Amount
    end
end

function vRP.SwapSlot(Passport, Slot, Target)
    local Source = vRP.Source(Passport)
    local Inventory = vRP.Inventory(Passport)

    if Source and Inventory then
        local Target = tostring(Target)
        local Slot = tostring(Slot)

        Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]
        
        if parseInt(Target) <= 5 then
            if parseInt(Slot) > 5 then
                if "Armamento" == ItemType(Inventory[Target]["item"]) then
                    TriggerClientEvent("inventory:RemoveWeapon", Source, Inventory[Target]["item"])
                end

                if "Armamento" == ItemType(Inventory[Slot]["item"]) then
                    TriggerClientEvent("inventory:CreateWeapon", Source, Inventory[Slot]["item"])
                end
            end
        elseif parseInt(Slot) <= 5 and parseInt(Target) > 5 and "Armamento" == ItemType(Inventory[Slot]["item"]) then
            TriggerClientEvent("inventory:RemoveWeapon", Source, Inventory[Slot]["item"])
            
            if "Armamento" == ItemType(Inventory[Target]["item"]) then
                TriggerClientEvent("inventory:CreateWeapon", Source, Inventory[Target]["item"])
            end
        end
    end
end

function vRP.InventoryWeight(Passport)
    local Source = vRP.Source(Passport)
    local Weight = 0

    if Source then
        local Inventory = vRP.Inventory(Passport)

        for _, v in pairs(Inventory) do
            Weight = Weight + ItemWeight(v["item"]) * v["amount"]
        end
    end

    return Weight
end

function vRP.CheckDamaged(Item)
    if ItemDurability(Item) and SplitTwo(Item, "-") and parseInt((3600 * ItemDurability(Item) - parseInt(os.time() - SplitTwo(Item, "-"))) / (3600 * ItemDurability(Item)) * 100) <= 1 then
        return true
    end
    return false
end

function vRP.ChestWeight(Data)
    local Weight = 0

    for _, v in pairs(Data) do
        Weight = Weight + ItemWeight(v["item"]) * v["amount"]
    end

    return Weight
end

function vRP.InventoryItemAmount(Passport, Item)
    local Source = vRP.Source(Passport)

    if Source then
        local Inventory = vRP.Inventory(Passport)

        for _, v in pairs(Inventory) do
            local Split = splitString(Item, "-")
            local Split2 = splitString(v["item"], "-")

            if Split[1] == Split2[1] then
                return { v["amount"], v["item"] }
            end
        end
    end

    return { 0, "" }
end

function vRP.InventoryFull(Passport, Item)
    local Source = vRP.Source(Passport)

    if Source then
        local Inventory = vRP.Inventory(Passport)

        for _, v in pairs(Inventory) do
            if v["item"] == Item then
                return true
            end
        end
    end

    return false
end

function vRP.ItemAmount(Passport, Item)
    local Source = vRP.Source(Passport)
    local Amount = 0

    if Source then
        local Inventory = vRP.Inventory(Passport)
        local Split = splitString(Item, "-")

        for _, v in pairs(Inventory) do
            local Split2 = splitString(v["item"], "-")

            if Split2[1] == Split[1] then
                Amount = Amount + v["amount"]
            end
        end
    end

    return Amount
end

function vRP.GiveItem(Passport, Item, Amount, Notify, Slot)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    
    if Source and Amount > 0 then
        local Inventory = vRP.Inventory(Passport)
        
        if not Slot then
            local Selected = "6"
            local MaxSlots = vRP.CheckWeight(Passport)

			if MaxSlots > 100 then
				MaxSlots = 100
			end

            for i = 1, MaxSlots do
                if not Inventory[tostring(i)] or (Inventory[tostring(i)] and Inventory[tostring(i)]["item"] == Item) then
                    Selected = tostring(i)
                    break
                end
            end

            if not Inventory[Selected] then
                Inventory[Selected] = { amount = Amount, item = Item }

                if parseInt(Selected) <= 5 and "Armamento" == ItemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", Source, Item)
                end
            elseif Inventory[Selected] and Inventory[Selected]["item"] == Item then
                Inventory[Selected]["amount"] = Inventory[Selected]["amount"] + Amount
            end

            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), Amount, ItemName(Item) })
                TriggerClientEvent("inventory:Update",Source)
            end
        else
            local Slot = tostring(Slot)

            if Inventory[Slot] then
                if Inventory[Slot]["item"] == Item then
                    Inventory[Slot]["amount"] = Inventory[Slot]["amount"] + Amount
                end
            else
                Inventory[Slot] = { amount = Amount, item = Item }

                if parseInt(Slot) <= 5 and "Armamento" == ItemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", Source, Item)
                end
            end

            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), Amount, ItemName(Item) })
                TriggerClientEvent("inventory:Update",Source)
            end
        end
    end
end

function vRP.GenerateItem(Passport, Item, Amount, Notify, Slot)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)

    if Source and Amount > 0 then
        local Inventory = vRP.Inventory(Passport)

        if ItemDurability(Item) then
            Item = Item .. "-" .. os.time()
        elseif ItemLoads(Item) then
            Item = Item .. "-" .. ItemLoads(Item)
        end

        if not Slot then
            local Selected = "6"
            local MaxSlots = vRP.CheckWeight(Passport)

            if MaxSlots > 100 then
                MaxSlots = 100
            end

            for i = 1, MaxSlots do
                if not Inventory[tostring(i)] or (Inventory[tostring(i)] and Inventory[tostring(i)]["item"] == Item) then
                    Selected = tostring(i)
                    break
                end
            end

            if not Inventory[Selected] then
                Inventory[Selected] = { amount = Amount, item = Item }

                if parseInt(Selected) <= 5 and "Armamento" == ItemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", Source, Item)
                end
            elseif Inventory[Selected] and Inventory[Selected]["item"] == Item then
                Inventory[Selected]["amount"] = Inventory[Selected]["amount"] + Amount
            end

            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), Amount, ItemName(Item) })
                TriggerClientEvent("inventory:Update",Source)
            end
        else
            local Slot = tostring(Slot)

            if Inventory[Slot] then
                if Inventory[Slot]["item"] == Item then
                    Inventory[Slot]["amount"] = Inventory[Slot]["amount"] + Amount
                end
            else
                Inventory[Slot] = { amount = Amount, item = Item }

                if parseInt(Slot) <= 5 and "Armamento" == ItemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", Source, Item)
                end
            end

            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), Amount, ItemName(Item) })
                TriggerClientEvent("inventory:Update",Source)
            end
        end
    end
end

function vRP.MaxItens(Passport, Item, Amount)
    local Source = vRP.Source(Passport)

    if itemBody(Item) and Source and ItemMaxAmount(Item) then
        if vRP.HasService(Passport, "Restaurants") then
            local Amount = parseInt(Amount)

            if vRP.ItemAmount(Passport, Item) + Amount > ItemMaxAmount(Item) * 5 then
                return true
            end
        elseif vRP.ItemAmount(Passport, Item) + Amount > ItemMaxAmount(Item) then
            return true
        end
    end

    return false
end

function vRP.TakeItem(Passport, Item, Amount, Notify, Slot)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    local Returned = false

    if Source and Amount > 0 then
        local Inventory = vRP.Inventory(Passport)

        if not Slot then
            for Index, v in pairs(Inventory) do
                if v["item"] == Item and Amount <= v.amount then
                    v["amount"] = v["amount"] - Amount

                    if 0 >= v["amount"] then
                        if "Armamento" == ItemType(Item) or "Throwing" ~= ItemType(Item) then
                            TriggerClientEvent("inventory:verifyWeapon", Source, Item)
                        end
                        
                        if parseInt(Index) <= 5 then
                            TriggerClientEvent("inventory:RemoveWeapon", Source, Item)
                        end

                        Inventory[Index] = nil
                    end

                    if Notify and itemBody(Item) then
                        TriggerClientEvent("NotifyItem", Source, { "-", ItemIndex(Item), Amount, ItemName(Item) })
                        TriggerClientEvent("inventory:Update",Source)
                    end

                    Returned = true
                    break
                end
            end
        else
            local Slot = tostring(Slot)

            if Inventory[Slot] and Inventory[Slot]["item"] == Item and Amount <= Inventory[Slot]["amount"] then
                Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - Amount
                
                if 0 >= Inventory[Slot]["amount"] then
                    if "Armamento" == ItemType(Item) or "Throwing" ~= ItemType(Item) then
                        TriggerClientEvent("inventory:verifyWeapon", Source, Item)
                    end
                    
                    if 5 >= parseInt(Slot) then
                        TriggerClientEvent("inventory:RemoveWeapon", Source, Item)
                    end

                    Inventory[Slot] = nil
                end

                if Notify and itemBody(Item) then
                    TriggerClientEvent("NotifyItem", Source, { "-", ItemIndex(Item), Amount, ItemName(Item) })
                    TriggerClientEvent("inventory:Update",Source)
                end

                Returned = true
            end
        end
    end
    return Returned
end

function vRP.RemoveItem(Passport, Item, Amount, Notify)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)

    if Source and Amount > 0 then
        local Inventory = vRP.Inventory(Passport)

        for Index, v in pairs(Inventory) do
            if v["item"] == Item and Amount <= v["amount"] then
                v["amount"] = v["amount"] - Amount

                if 0 >= v["amount"] then
                    if "Armamento" == ItemType(Item) or "Throwing" ~= ItemType(Item) then
                        TriggerClientEvent("inventory:verifyWeapon", Source, Item)
                    end
                    
                    if parseInt(Index) <= 5 then
                        TriggerClientEvent("inventory:RemoveWeapon", Source, Item)
                    end

                    Inventory[Index] = nil
                end

                if Notify and itemBody(Item) then
                    TriggerClientEvent("NotifyItem", Source, { "-", ItemIndex(Item), Amount, ItemName(Item) })
                    TriggerClientEvent("inventory:Update",Source)
                end

                break
            end
        end
    end
end

function vRP.GetSrvData(Key,Save)
    if not Entitys[Key] then
        local Consult = vRP.Query("entitydata/GetData", { Name = Key })

        if parseInt(#Consult) > 0 then
            Entitys[Key] = { data = json.decode(Consult[1]["Information"]), timer = os.time() + 180, save = true }
        else
            Entitys[Key] = { data = {}, timer = os.time() + 180, save = true }
        end
    end

    return Entitys[Key]["data"]
end

function vRP.SetSrvData(Key, Data, Save)
    Entitys[Key] = { data = Data, timer = os.time() + 180, save = Save }
end

function vRP.RemSrvData(Key, Save)
    Entitys[Key] = { data = {}, timer = os.time() + 180, save = Save }
end

CreateThread(function()
    while true do
        for Key,v in pairs(Entitys) do
            if os.time() <= v["timer"] and v["save"] then
                if type(v["data"]) == "string" then
                    vRP.Query("entitydata/SetData",{ Name = Key, Information = v["data"] })
                else
                    vRP.Query("entitydata/SetData",{ Name = Key, Information = json.encode(v["data"]) })
                end
                
                Entitys[Key] = nil
            end
        end
        
        Wait(60000)
    end
end)

AddEventHandler("SaveServer", function(Silenced)
    for Key, v in pairs(Entitys) do
        if v["save"] then
            vRP.Query("entitydata/SetData", { Name = Key, Information = json.encode(v["data"]) })
        end
    end

    if not Silenced then
        print("O resource ^2vRP^7 salvou os dados.")
    end
end)

function tvRP.invUpdate(Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Amount) > 0 then
		Returned[Passport] = true

		local Inventory = vRP.Inventory(Passport)
		local Slot = tostring(Slot)
		local Target = tostring(Target)
		if Inventory[Slot] then
			if Inventory[Target] then
				if Inventory[Slot]["item"] == Inventory[Target]["item"] then
					if parseInt(Amount) <= Inventory[Slot]["amount"] then
						Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)
						Inventory[Target]["amount"] = Inventory[Target]["amount"] + parseInt(Amount)

						if Inventory[Slot]["amount"] <= 0 then
							Inventory[Slot] = nil
						end

						Returned[Passport] = false
					end
				else
					if Inventory[Slot]["item"] and Inventory[Target]["item"] then
						if Inventory[Slot]["item"] == "repairkit0"..string.sub(Inventory[Slot]["item"],11,12) then
							if vRP.CheckDamaged(Inventory[Target]["item"]) and Inventory[Target]["amount"] == 1 then
								local repairItem = ItemRepair(Inventory[Target]["item"])
								if repairItem and Inventory[Slot]["item"] == "repairkit0" .. string.sub(Inventory[Slot]["item"], 11, 12) then
									if repairItem == Inventory[Slot]["item"] then
										if vRP.TakeItem(Passport, Inventory[Slot]["item"], 1, false, Slot) then
											local timeSuffix = os.time()

											if splitString(Inventory[Target]["item"], "-")[3] then
												Inventory[Target]["item"] = splitString(Inventory[Target]["item"], "-")[1] .. "-" .. timeSuffix .. "-" .. splitString(Inventory[Target]["item"], "-")[3]
											else
												Inventory[Target]["item"] = splitString(Inventory[Target]["item"], "-")[1] .. "-" .. timeSuffix
											end

											TriggerClientEvent("Notify", source, "verde", "Reparado.", "Sucesso", 5000)
										end
									else
										local repairItemName = ItemName(repairItem)
										TriggerClientEvent("Notify", source, "amarelo", "Use <b>1x " .. repairItemName .. "</b>.", "Atenção", 5000)
									end
								end
							end
						else
							Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]

							Returned[Passport] = false
						end
					end
				end
			elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot]["amount"] then
				Inventory[Target] = { item = Inventory[Slot]["item"], amount = parseInt(Amount) }
				Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)

				if Inventory[Slot]["amount"] <= 0 then
					Inventory[Slot] = nil
				end

				Returned[Passport] = false
			end
		else
			TriggerClientEvent("inventory:Update", source, "Backpack")
		end
	end
end

function vRP.TakeChest(Passport, Data, Amount, Slot, Target)
    local Amount = parseInt(Amount)
    local Slot = tostring(Slot)
    local Target = tostring(Target)
    local Source = vRP.Source(Passport)
    local Consult = vRP.GetSrvData(Data)
    local Inventory = vRP.Inventory(Passport)
    local Returned = true

    if Source and Amount > 0 and Consult[Slot] then
        if vRP.MaxItens(Passport, Consult[Slot]["item"], Amount) then
            TriggerClientEvent("Notify", Source, "Aviso", "Limite atingido.", "amarelo", 3000)
            return true
        end

        if vRP.InventoryWeight(Passport) + ItemWeight(Consult[Slot]["item"]) * Amount <= vRP.CheckWeight(Passport) then
            if Inventory[Target] then
                if Consult[Slot] and Inventory[Target]["item"] == Consult[Slot]["item"] and Amount <= Consult[Slot]["amount"] then
                    Inventory[Target]["amount"] = Inventory[Target]["amount"] + Amount
                    Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount
                    
                    if 0 >= Consult[Slot]["amount"] then
                        Consult[Slot] = nil
                    end

                    Returned = false
                end
            elseif Consult[Slot] and Amount <= Consult[Slot]["amount"] then
                Inventory[Target] = { amount = Amount, item = Consult[Slot]["item"] }
                Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount
                
                if parseInt(Target) <= 5 and "Armamento" == ItemType(Consult[Slot]["item"]) then
                    TriggerClientEvent("inventory:CreateWeapon", Source, Consult[Slot]["item"])
                end

                if 0 >= Consult[Slot]["amount"] then
                    Consult[Slot] = nil
                end

                Returned = false
            end
        end
    end
    return Returned
end

function vRP.StoreChest(Passport, Data, Amount, Weight, Slot, Target)
    local Amount = parseInt(Amount)
    local Slot = tostring(Slot)
    local Target = tostring(Target)
    local Source = vRP.Source(Passport)
    local Inventory = vRP.Inventory(Passport)
    local Consult = vRP.GetSrvData(Data)
    local Returned = true

    if Source and Amount > 0 and Inventory[Slot] and Weight >= vRP.ChestWeight(Consult) + ItemWeight(Inventory[Slot]["item"]) * Amount then
        if Consult[Target] then
            if Inventory[Slot] then
                if Inventory[Slot]["item"] ~= Consult[Target]["item"] then
                    return Returned
                end

                if not (Amount <= Inventory[Slot]["amount"]) then
                    return Returned
                end

                Consult[Target]["amount"] = Consult[Target]["amount"] + Amount
                Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - Amount

                if 0 >= Inventory[Slot]["amount"] then
                    if "Armamento" == ItemType(Inventory[Slot]["item"]) or "Throwing" ~= ItemType(Inventory[Slot]["item"]) then
                        TriggerClientEvent("inventory:verifyWeapon", Source, Inventory[Slot]["item"])
                    end
                            
                    if parseInt(Slot) <= 5 then
                        TriggerClientEvent("inventory:RemoveWeapon", Source, Inventory[Slot]["item"])
                    end

                    Inventory[Slot] = nil
                end

                Returned = false
            end
        elseif Inventory[Slot] and Amount <= Inventory[Slot]["amount"] then
            Consult[Target] = { amount = Amount, item = Inventory[Slot]["item"] }
            Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - Amount

            if 0 >= Inventory[Slot]["amount"] then
                if "Armamento" == ItemType(Inventory[Slot]["item"]) or "Throwing" ~= ItemType(Inventory[Slot]["item"]) then
                    TriggerClientEvent("inventory:verifyWeapon", Source, Inventory[Slot]["item"])
                end
                
                if parseInt((Slot)) <= 5 then
                    TriggerClientEvent("inventory:RemoveWeapon", Source, Inventory[Slot]["item"])
                end

                Inventory[Slot] = nil
            end

            Returned = false
        end
    end
    return Returned
end

function vRP.UpdateChest(Passport, Data, Slot, Target, Amount)
    local Slot = tostring(Slot)
    local Target = tostring(Target)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    local Consult = vRP.GetSrvData(Data)
    local Returned = true

    if Source and Amount > 0 and Consult[Slot] then
        if Consult[Target] then
            if Consult[Slot] then
                if Consult[Slot]["item"] == Consult[Target]["item"] then
                    if Amount <= Consult[Slot]["amount"] then
                        Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount

                        if 0 >= Consult[Slot]["amount"] then
                            Consult[Slot] = nil
                        end

                        Consult[Target]["amount"] = Consult[Target]["amount"] + Amount

                        Returned = false
                    end
                else
                    Consult[Target], Consult[Slot] = Consult[Slot], Consult[Target]
                end
            end
        elseif Consult[Slot] and Amount <= Consult[Slot]["amount"] then
            Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount
            Consult[Target] = { amount = Amount, item = Consult[Slot]["item"] }

            if 0 >= Consult[Slot]["amount"] then
                Consult[Slot] = nil
            end

            Returned = false
        end
    end
    return Returned
end

function vRP.DirectChest(Chest, Slot, Amount)
    local Amount = parseInt(Amount)
    local Consult = vRP.GetSrvData("Chest:" .. Chest)

    if Consult[Slot] then
        if "dollar" == Consult[Slot]["item"] then
            Consult[Slot]["amount"] = Consult[Slot]["amount"] + Amount
        else
            Consult[Slot] = { amount = Amount, item = "dollar" }
        end
    else
        Consult[Slot] = { amount = Amount, item = "dollar" }
    end
end

-- money.lua

function vRP.GiveBank(Passport, Amount)
    local Amount = parseInt(Amount)

    if Amount > 0 then
        vRP.Query("characters/addBank", { Passport = Passport, amount = Amount })        
        exports["bank"]:AddTransactions(Passport, "entry", Amount)

        local Source = vRP.Source(Passport)

        if Characters[Source] then
            Characters[Source]["bank"] = Characters[Source]["bank"] + Amount
            TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex("dollar"), Amount, ItemName("dollar") })
        end
    end
end

function vRP.RemoveBank(Passport, Amount)
    local Amount = parseInt(Amount)

    if Amount > 0 then
        vRP.Query("characters/remBank", { Passport = Passport, amount = Amount })
        exports["bank"]:AddTransactions(Passport, "exit", Amount)

        local Source = vRP.Source(Passport)

        if Characters[Source] then
            Characters[Source]["bank"] = Characters[Source]["bank"] - Amount
            if 0 > Characters[Source]["bank"] then
                Characters[Source]["bank"] = 0
            end
        end
    end
end

function vRP.GetBank(source)
    if Characters[source] then
        return Characters[source]["bank"]
    end

    return 0
end

function vRP.GetFine(source)
    if Characters[source] then
        return Characters[source]["fines"]
    end

    return 0
end

function vRP.GiveFine(Passport, Amount)
    local Amount = parseInt(Amount)

    if Amount > 0 then
        local Source = vRP.Source(Passport)
        
        vRP.Query("characters/addFines", { id = Passport, fines = Amount })
        
        if Characters[Source] then
            Characters[Source]["fines"] = Characters[Source]["fines"] + Amount
        end
    end
end

function vRP.RemoveFine(Passport, Amount)
    local Amount = parseInt(Amount)

    if Amount > 0 then
        local Source = vRP.Source(Passport)

        vRP.Query("characters/removeFines", { id = Passport, fines = Amount })
        
        if Characters[Source] then
            Characters[Source]["fines"] = Characters[Source]["fines"] - Amount
            
            if 0 > Characters[Source]["fines"] then
                Characters[Source]["fines"] = 0
            end
        end
    end
end

function vRP.PaymentGems(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)

    if Amount > 0 and Characters[Source] and Amount <= vRP.UserGemstone(Characters[Source]["license"]) then
        vRP.Query("accounts/RemoveGems", { license = Characters[Source]["license"], gems = Amount })
        TriggerClientEvent("hud:RemoveGemstone", Source, Amount)
        
        return true
    end

    return false
end

function vRP.PaymentBank(Passport,Amount)
    local Source = vRP.Source(parseInt(Passport))
    if parseInt(Amount) > 0 and Characters[Source] then
        if parseInt(Amount) <= Characters[Source]["bank"] then
            vRP.RemoveBank(parseInt(Passport),parseInt(Amount),Source)
            TriggerClientEvent("NotifyItem",Source,{ "-", "dollar", Amount, ItemName("dollar") })
            return true
        end
    end
    return false
end

function vRP.PaymentFull(Passport,Amount)
    if parseInt(Amount) > 0 then
        if vRP.TakeItem(parseInt(Passport),"dollar",parseInt(Amount),true) then
            return true
        else
            return vRP.PaymentBank(parseInt(Passport),parseInt(Amount))
        end
    end
    
    return false
end

function vRP.WithdrawCash(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)

    if Amount > 0 and Characters[Source] and Amount <= Characters[Source]["bank"] then
        vRP.GenerateItem(Passport, "dollar", Amount, true)
        vRP.RemoveBank(Passport, Amount, Source)
        
        return true
    end

    return false
end

-- player.lua

AddEventHandler("CharacterChosen", function(Passport, source, First)
    local Datatable = vRP.Datatable(Passport)
    local Identity = vRP.Identity(Passport)

    if Datatable and Identity then
        if Datatable["Pos"] then
            if not (Datatable["Pos"]["x"] and Datatable["Pos"]["y"] and Datatable["Pos"]["z"]) then
                Datatable["Pos"] = { x = SpawnCoords[1]["x"], y = SpawnCoords[1]["y"], z = SpawnCoords[1]["z"] }
            end
        else
            Datatable["Pos"] = { x = SpawnCoords[1]["x"], y = SpawnCoords[1]["y"], z = SpawnCoords[1]["z"] }
        end

        if not Datatable["Skin"] then
            Datatable["Skin"] = "mp_m_freemode_01"
        end

        if not Datatable["Inventory"] then
            Datatable["Inventory"] = {}
        end

        if not Datatable["Health"] then
            Datatable["Health"] = 200
        end

        if not Datatable["Armour"] then
            Datatable["Armour"] = 0
        end

        if not Datatable["Stress"] then
            Datatable["Stress"] = 0
        end

        if not Datatable["Hunger"] then
            Datatable["Hunger"] = 100
        end

        if not Datatable["Thirst"] then
            Datatable["Thirst"] = 100
        end

        if not Datatable["Weight"] then
            Datatable["Weight"] = 30
        end

        vRPC.Skin(source, Datatable["Skin"])
        vRP.SetArmour(source, Datatable["Armour"])
        vRPC.SetHealth(source, Datatable["Health"])
        vRP.Teleport(source, Datatable["Pos"]["x"], Datatable["Pos"]["y"], Datatable["Pos"]["z"])
        
        TriggerClientEvent("barbershop:Apply", source, vRP.UserData(Passport, "Barbershop"))
        TriggerClientEvent("skinshop:Apply", source, vRP.UserData(Passport, "Clothings"))
        TriggerClientEvent("tattooshop:Apply", source, vRP.UserData(Passport, "Tattooshop"))
        TriggerClientEvent("hud:Thirst", source, Datatable["Thirst"])
        TriggerClientEvent("hud:Hunger", source, Datatable["Hunger"])
        TriggerClientEvent("hud:Stress", source, Datatable["Stress"])
        TriggerClientEvent("vRP:Active", source, Passport, Identity["name"] .. " " .. Identity["name2"])

        Player(source)["state"]["Passport"] = Passport

        if "yes" == GetResourceMetadata("vrp", "creator") then
            if 1 == vRP.UserData(Passport, "Creator") then
                if SpawnSelected[Passport] then
                    TriggerClientEvent("spawn:Finish", source, false, false)
                else
                    TriggerClientEvent("spawn:Finish", source, vec3(Datatable["Pos"]["x"], Datatable["Pos"]["y"], Datatable["Pos"]["z"]), false)
                end
            else
                TriggerClientEvent("spawn:Finish", source, false, true)
            end
        elseif SpawnSelected[Passport] then
            TriggerClientEvent("spawn:Finish", source, false, false)
        elseif First then
            TriggerClientEvent("spawn:Finish", source, false, true)
        else
            TriggerClientEvent("spawn:Finish", source, vec3(Datatable["Pos"]["x"], Datatable["Pos"]["y"], Datatable["Pos"]["z"]), false)
        end

        TriggerEvent("Connect", Passport, source, nil == SpawnSelected[Passport])
        SpawnSelected[Passport] = true
    end
end)

RegisterServerEvent("vRP:justObjects")
AddEventHandler("vRP:justObjects", function()
    local Passport = vRP.Passport(source)
    local Inventory = vRP.Inventory(Passport)

    if Passport then
        for i = 1, 5 do
            if Inventory[tostring(i)] and "Armamento" == ItemType(Inventory[tostring(i)]["item"]) then
                TriggerClientEvent("inventory:CreateWeapon", source, Inventory[tostring(i)]["item"])
            end
        end
    end
end)

RegisterServerEvent("vRP:BackpackWeight")
AddEventHandler("vRP:BackpackWeight", function(Backpack)
    local Passport = vRP.Passport(source)

    if Passport then
        local Datatable = vRP.Datatable(Passport)
        
        if Backpack then
            if not SpawnSelected[Passport] then
                Datatable["Weight"] = Datatable["Weight"] + 50
                SpawnSelected[Passport] = true
            end
        end
    end
end)

RegisterServerEvent("DeleteObject")
AddEventHandler("DeleteObject", function(Index, Object)
    local Passport = vRP.Passport(source)

    if Passport then
        if Object and Objects[Passport] and Objects[Passport][Object] then
            Index = Objects[Passport][Object]
            Objects[Passport][Object] = nil
        end
    end

    TriggerEvent("DeleteObjectServer", Index)
end)

AddEventHandler("DeleteObjectServer", function(Index)
    local Network = NetworkGetEntityFromNetworkId(Index)
    if DoesEntityExist(Network) and not IsPedAPlayer(Network) and 3 == GetEntityType(Network) then
        DeleteEntity(Network)
    end
end)

RegisterServerEvent("DeletePed")
AddEventHandler("DeletePed", function(Index)
    local Network = NetworkGetEntityFromNetworkId(Index)
    if DoesEntityExist(Network) and not IsPedAPlayer(Network) and 1 == GetEntityType(Network) then
        DeleteEntity(Network)
    end
end)

AddEventHandler("DebugObjects", function(Passport)
    if Objects[Passport] then
        for Index, _ in pairs(Objects[Passport]) do
            Objects[Passport][Index] = nil
            TriggerEvent("DeleteObjectServer", Index)
        end
    end
end)

AddEventHandler("DebugWeapons", function(Passport)
    if Objects[Passport] then
        for _, Index in pairs(Objects[Passport]) do
            TriggerEvent("DeleteObjectServer", Index)
            Objects[Passport] = nil
        end
        
        Objects[Passport] = nil
    end
end)

function vRP.ClearInventory(Passport)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)

    if Source and Datatable and Datatable["Inventory"] then
        exports["inventory"]:CleanWeapons(Passport, true)
        TriggerEvent("DebugObjects", Passport)
        TriggerEvent("DebugWeapons", Passport)
        Datatable["Inventory"] = {}
    end
end

function vRP.UpgradeThirst(Passport, Amount)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)

    if Datatable and Source then
        if not Datatable["Thirst"] then
            Datatable["Thirst"] = 0
        end

        Datatable["Thirst"] = Datatable["Thirst"] + parseInt(Amount)

        if Datatable["Thirst"] > 100 then
            Datatable["Thirst"] = 100
        end

        TriggerClientEvent("hud:Thirst", Source, Datatable["Thirst"])
    end
end

function vRP.UpgradeHunger(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local Source = vRP.Source(Passport)

    if Datatable and Source then
        if not Datatable["Hunger"] then
            Datatable["Hunger"] = 0
        end

        Datatable["Hunger"] = Datatable["Hunger"] + parseInt(Amount)

        if Datatable["Hunger"] > 100 then
            Datatable["Hunger"] = 100
        end

        TriggerClientEvent("hud:Hunger", Source, Datatable["Hunger"])
    end
end

function vRP.UpgradeStress(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local Source = vRP.Source(Passport)

    if Datatable and Source then
        if not Datatable["Stress"] then
            Datatable["Stress"] = 0
        end

        Datatable["Stress"] = Datatable["Stress"] + parseInt(Amount)

        if Datatable["Stress"] > 100 then
            Datatable["Stress"] = 100
        end
        
        TriggerClientEvent("hud:Stress", Source, Datatable["Stress"])
    end
end

function vRP.DowngradeThirst(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local Source = vRP.Source(Passport)

    if Datatable and Source then
        if not Datatable["Thirst"] then
            Datatable["Thirst"] = 100
        end

        Datatable["Thirst"] = Datatable["Thirst"] - parseInt(Amount)

        if Datatable["Thirst"] < 0 then
            Datatable["Thirst"] = 0
        end
        
        TriggerClientEvent("hud:Thirst", Source, Datatable["Thirst"])
    end
end

function vRP.DowngradeHunger(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local Source = vRP.Source(Passport)

    if Datatable and Source then
        if not Datatable["Hunger"] then
            Datatable["Hunger"] = 100
        end

        Datatable["Hunger"] = Datatable["Hunger"] - parseInt(Amount)

        if Datatable["Hunger"] < 0 then
            Datatable["Hunger"] = 0
        end

        TriggerClientEvent("hud:Hunger", Source, Datatable["Hunger"])
    end
end

function vRP.DowngradeStress(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local Source = vRP.Source(Passport)

    if Datatable and Source then
        if not Datatable["Stress"] then
            Datatable["Stress"] = 0
        end

        Datatable["Stress"] = Datatable["Stress"] - parseInt(Amount)
        
        if Datatable["Stress"] < 0 then
            Datatable["Stress"] = 0
        end

        TriggerClientEvent("hud:Stress", Source, Datatable["Stress"])
    end
end

function tvRP.Foods()
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)

    if Passport and Datatable then
        if not Datatable["Thirst"] then
            Datatable["Thirst"] = 100
        end

        if not Datatable["Hunger"] then
            Datatable["Hunger"] = 100
        end

        Datatable["Hunger"] = Datatable["Hunger"] - 1
        Datatable["Thirst"] = Datatable["Thirst"] - 1

        if Datatable["Thirst"] < 0 then
            Datatable["Thirst"] = 0
        end

        if Datatable["Hunger"] < 0 then
            Datatable["Hunger"] = 0
        end
    end
end

function vRP.GetHealth(source)
    local Ped = GetPlayerPed(source)
    return GetEntityHealth(Ped)
end

function vRP.ModelPlayer(source)
    local Ped = GetPlayerPed(source)

    if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
        return "mp_f_freemode_01"
    end

    return "mp_m_freemode_01"
end

function vRP.GetExperience(Passport, Work)
    local Datatable = vRP.Datatable(Passport)

    if Datatable and not Datatable[Work] then
        Datatable[Work] = 0
    end

    return Datatable[Work] or 0
end

function vRP.PutExperience(Passport, Work, Number)
    local Datatable = vRP.Datatable(Passport)

    if Datatable then
        if not Datatable[Work] then
            Datatable[Work] = 0
        end

        Datatable[Work] = Datatable[Work] + Number
    end
end

function vRP.SetArmour(source, Amount)
    local Ped = GetPlayerPed(source)

    if GetPedArmour(Ped) + Amount > 100 then
        Amount = 100 - GetPedArmour(Ped)
    end

    SetPedArmour(Ped, GetPedArmour(Ped) + Amount)
end

function vRP.Teleport(source, x, y, z)
    local Ped = GetPlayerPed(source)
    SetEntityCoords(Ped, x + 1.0E-4, y + 1.0E-4, z + 1.0E-4, false, false, false, false)
end

function vRP.GetEntityCoords(source)
    local Ped = GetPlayerPed(source)
    return GetEntityCoords(Ped)
end

function vRP.InsideVehicle(source)
    local Ped = GetPlayerPed(source)
    return GetVehiclePedIsIn(Ped,false) ~= 0
end

function tvRP.CreatePed(Model, x, y, z, heading, typ)
    local SpawnPed = 0
    local ModelHash = GetHashKey(Model)
    local Ped = CreatePed(typ, ModelHash, x, y, z, heading, true, false)
    while DoesEntityExist(Ped) and not (SpawnPed <= 1000) do
        SpawnPed = SpawnPed + 1
        Wait(1)
    end

    if DoesEntityExist(Ped) then
        return true, NetworkGetNetworkIdFromEntity(Ped)
    end

    return false
end

function tvRP.CreateObject(Model, x, y, z, Weapon)
    local Passport = vRP.Passport(source)

    if Passport then
        local SpawnObjects = 0
        local ModelHash = GetHashKey(Model)
        local Object = CreateObject(ModelHash, x, y, z, true, true, false)

        while not DoesEntityExist(Object) and (SpawnObjects <= 1000) do
            SpawnObjects = SpawnObjects + 1
            Wait(1)
        end

        if DoesEntityExist(Object) then
            local NetworkObject = NetworkGetNetworkIdFromEntity(Object)

            if Weapon then
                if not Objects[Passport] then
                    Objects[Passport] = {}
                end
                
                Objects[Passport][Weapon] = NetworkObject
            else
                if not Objects[Passport] then
                    Objects[Passport] = {}
                end

                Objects[Passport][NetworkObject] = true
            end

            return true, NetworkObject
        end
    end

    return false
end

CreateThread(function()
    while true do
        for Passport, _ in pairs(Sources) do
            vRP.DowngradeHunger(Passport, 1)
            vRP.DowngradeThirst(Passport, 1)
        end

        Wait(30000)
    end
end)

exports('Bucket', function(source, Mode, Route)
    if "Enter" == Mode then
        Player(source)["state"]["Route"] = Route
        SetPlayerRoutingBucket(source, Route)

        if Route > 0 then
            SetRoutingBucketEntityLockdownMode(Route, "relaxed")
            SetRoutingBucketPopulationEnabled(Route, false)
        end
    else
        Player(source)["state"]["Route"] = 0
        SetPlayerRoutingBucket(source, 0)
    end
end)

AddEventHandler("Disconnect", function(Passport)
    local Datatable = vRP.Datatable(Passport)

    TriggerEvent("DebugObjects", Passport)
    TriggerEvent("DebugWeapons", Passport)
end)

-- premium.lua

function vRP.LevelPremium(source)
    return Characters[source]["Level"] or 0
end

function vRP.SetPremium(source, Passport, Hierarchy, Days)
    if Characters[source] then
        vRP.Query("accounts/setPremium", { license = Characters[source]["license"], Level = Hierarchy, premium = os.time() + 2592000 })
        Characters[source]["premium"] = parseInt(os.time() + 2592000)
        Characters[source]["Level"] = parseInt(Hierarchy)
    end
end

function vRP.UpgradePremium(source)
    if Characters[source] then
        vRP.Query("accounts/updatePremium", { license = Characters[source]["license"] })
        Characters[source]["premium"] = Characters[source]["premium"] + 2592000
        Characters[source]["Level"] = parseInt(Hierarchy)
    end
end

function vRP.UserPremium(Passport)
    local Source = vRP.Source(Passport)

    return Characters[Source] and Characters[Source]["premium"] >= os.time()
end

function vRP.LicensePremium(License)
    local Account = vRP.Account(License)

    if Account and Account["premium"] >= os.time() then
        return true
    end

    return false
end

function vRP.SetMedicPlan(Passport)
    local source = vRP.Source(Passport)
    if Characters[source] then
        vRP.Query("characters/SetMedicplan", { Passport = Passport, Medic = os.time() + 604800 })
        Characters[source]["Medic"] = parseInt(os.time() + 604800)
    end
end

function vRP.UpgradeMedicPlan(Passport)
    local source = vRP.Source(Passport)
    if Characters[source] then
        vRP.Query("characters/UpdateMedicplan", { Passport = Passport })
        Characters[source]["Medic"] = Characters[source]["Medic"] + 604800
    end
end

function vRP.Medicplan(Passport)
    local Source = vRP.Source(Passport)

    return Characters[Source] and Characters[Source]["Medic"] >= os.time()
end

-- queue.lua

function getQueue(ids,trouble,source,connect)
    for k,v in ipairs(connect and Queue.Connecting or Queue.List) do
        local inQueue = false

        if not source then
            for _,i in ipairs(v["ids"]) do
                if inQueue then
                    break
                end

                for _,o in ipairs(ids) do
                    if o == i then
                        inQueue = true
                        break
                    end
                end
            end
        else
            inQueue = ids == v["source"]
        end

        if inQueue then
            if trouble then
                return k,connect and Queue.Connecting[k] or Queue.List[k]
            end

            return true
        end
    end

    return false
end

function CheckPriority(source)
    local Priority = 0
    local Identifiers = GetPlayerIdentifiers(source)

    for _,v in pairs(Identifiers) do
        local Split = splitString(v,":")

        if string.find(v, BaseMode) and vRP.LicensePremium(Split[2]) then
            Priority = 10
            break
        end
    end

    return Priority
end

function addQueue(ids,connectTime,name,source,deferrals)
    if getQueue(ids) then
        return
    end

    local tmp = { source = source, ids = ids, name = name, firstconnect = connectTime, priority = CheckPriority(ids), timeout = 0, deferrals = deferrals }

    local _pos = false
    local queueCount = #Queue.List + 1

    for k,v in ipairs(Queue.List) do
        if tmp["priority"] then
            if not v["priority"] then
                _pos = k
            else
                if tmp["priority"] > v["priority"] then
                    _pos = k
                end
            end

            if _pos then
                break
            end
        end
    end

    if not _pos then
        _pos = #Queue.List + 1
    end

    table.insert(Queue.List,_pos,tmp)
end

function removeQueue(ids,source)
    if getQueue(ids,false,source) then
        local pos,data = getQueue(ids,true,source)
        table.remove(Queue.List,pos)
    end
end

function isConnect(ids,source,refresh)
    local k,v = getQueue(ids,refresh and true or false,source and true or false,true)

    if not k then
        return false
    end

    if refresh and k and v then
        Queue.Connecting[k]['timeout'] = 0
    end
    return true
end

function removeConnect(ids,source)
    for k,v in ipairs(Queue.Connecting) do
        local connect = false

        if not source then
            for _,i in ipairs(v["ids"]) do
                if connect then
                    break
                end

                for _,o in ipairs(ids) do
                    if o == i then
                        connect = true
                        break
                    end
                end
            end
        else
            connect = ids == v["source"]
        end

        if connect then
            table.remove(Queue.Connecting,k)
            return true
        end
    end
    return false
end

function addConnect(ids,ignorePos,autoRemove,done)
    local function removeFromQueue()
        if not autoRemove then
            return
        end

        done(Lang.Error)
        removeConnect(ids)
        removeQueue(ids)
    end

    if #Queue.Connecting >= 100 then
        removeFromQueue()
        return false
    end

    if isConnect(ids) then
        removeConnect(ids)
    end

    local pos,data = getQueue(ids,true)
    if not ignorePos and (not pos or pos > 1) then
        removeFromQueue()
        return false
    end

    table.insert(Queue.Connecting,data)
    removeQueue(ids)
    return true
end

function steamIds(source)
    if not source then
        return {}
    end

    return GetPlayerIdentifiers(source)
end

function updateData(source,ids,deferrals)
    local pos,data = getQueue(ids,true)
    Queue.List[pos]["ids"] = ids
    Queue.List[pos]["timeout"] = 0
    Queue.List[pos]["source"] = source
    Queue.List[pos]["deferrals"] = deferrals
end

function notFull(firstJoin)
    local canJoin = Queue.Counts + #Queue.Connecting < Queue.Max and #Queue.Connecting < 100
    if firstJoin and canJoin then
        canJoin = #Queue.List <= 1
    end

    return canJoin
end

function setPosition(ids,newPos)
    local pos,data = getQueue(ids,true)
    table.remove(Queue.List,pos)
    table.insert(Queue.List,newPos,data)
end

CreateThread(function()
    local function playerConnect(name,setKickReason,deferrals,source)
        if not source then
            deferrals.defer()
            deferrals.done("Conexão perdida.")
            CancelEvent()
            return
        end

        local ids = steamIds(source)
        local connectTime = os.time()
        local connecting = true

        deferrals.defer()

        local promise = exports["ThnAC"]:verifyDeferral(source)
        if promise then
            deferrals.update("Aguardando informações do ThnAC")
            Citizen.Await(promise)
        end

        CreateThread(function()
            while connecting do
                Wait(500)
                if not connecting then
                    return
                end
                deferrals.update(Lang.Connecting)
            end
        end)

        Wait(1000)

        local function done(message)
            connecting = false
            CreateThread(function()
                if message then
                    deferrals.update(tostring(message) and tostring(message) or "")
                end

                Wait(1000)

                if message then
                    deferrals.done(tostring(message) and tostring(message) or "")
                    CancelEvent()
                end
            end)
        end

        local function update(message)
            connecting = false
            deferrals.update(tostring(message) and tostring(message) or "")
        end

        if not vRP.Identities(source) then
            done(Lang["Error"])
            CancelEvent()
            return
        end

        local reason = "Removido da fila."

        local function setReason(message)
            reason = tostring(message)
        end

        TriggerEvent("Queue:playerJoinQueue",source,setReason)

        if WasEventCanceled() then
            done(reason)

            removeQueue(ids)
            removeConnect(ids)

            CancelEvent()
            return
        end

        if getQueue(ids) then
            rejoined = true
            updateData(source,ids,deferrals)
        else
            addQueue(ids,connectTime,name,source,deferrals)
        end

        if isConnect(ids,false,true) then
            removeConnect(ids)

            if notFull() then
                local added = addConnect(ids,true,true,done)
                if not added then
                    CancelEvent()
                    return
                end

                done()
                TriggerEvent("Queue:Connecting",source,ids,deferrals)

                return
            else
                addQueue(ids,connectTime,name,source,deferrals)
                setPosition(ids,1)
            end
        end

        local pos,data = getQueue(ids,true)

        if not pos or not data then
            done(Lang.error)
            RemoveFromQueue(ids)
            RemoveFromConnecting(ids)
            CancelEvent()
            return
        end

        if notFull(true) then
            local added = addConnect(ids,true,true,done)
            if not added then
                CancelEvent()
                return
            end

            done()

            TriggerEvent("Queue:Connecting",source,ids,deferrals)

            return
        end

        update(string.format(Lang.Position,pos,#Queue.List))

        CreateThread(function()
            if rejoined then
                return
            end

            Queue.Threads = Queue.Threads + 1

            while true do
                Wait(1000)

                local pos,data = getQueue(ids,true)

                if not pos or not data then
                    if data and data.deferrals then
                        data.deferrals.done(Lang.error)
                    end

                    CancelEvent()
                    removeQueue(ids)
                    removeConnect(ids)
                    Queue.Threads = Queue.Threads - 1
                    return
                end

                if pos <= 1 and notFull() then
                    local added = addConnect(ids)
                    data.deferrals.update(Lang.join)
                    Wait(500)

                    if not added then
                        data.deferrals.done(Lang.connecterror)
                        CancelEvent()
                        Queue.Threads = Queue.Threads - 1
                        return
                    end

                    data.deferrals.update("Carregando conexão com o servidor.")

                    removeQueue(ids)
                    Queue.Threads = Queue.Threads - 1

                    TriggerEvent("Queue:Connecting",source,data.ids,data.deferrals)

                    return
                end

                local message = string.format(ServerName.."\n\n"..Lang.Position.."%s\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe sua sugestão em nosso discord.",pos,#Queue.List,dots)
                data.deferrals.update(message)
            end
        end)
    end

    AddEventHandler("playerConnecting", function(name,setKickReason,deferrals)
        local src = source
        playerConnect(name,setKickReason,deferrals,src)
    end)

    local function checkTimeOuts()
        local i = 1

        while i <= #Queue.List do
            local data = Queue.List[i]
            local lastMsg = GetPlayerLastMsg(data.source)

            if lastMsg == 0 or lastMsg >= 30000 then
                data.timeout = data.timeout + 1
            else
                data.timeout = 0
            end

            if not data.ids or not data["name"] or not data.firstconnect or data.priority == nil or not data.source then
                data.deferrals.done(Lang.error)
                table.remove(Queue.List,i)
            elseif (data.timeout >= 120) and os.time() - data.firstconnect > 5 then
                data.deferrals.done(Lang.error)
                removeQueue(data.source,true)
                removeConnect(data.source,true)
            else
                i = i + 1
            end
        end

        i = 1

        while i <= #Queue.Connecting do
            local data = Queue.Connecting[i]
            local lastMsg = GetPlayerLastMsg(data.source)
            data.timeout = data.timeout + 1

            if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and os.time() - data.firstconnect > 5 then
                removeQueue(data.source, true)
                removeConnect(data.source, true)
            else
                i = i + 1
            end
        end

        SetTimeout(1000,checkTimeOuts)
    end

    checkTimeOuts()
end)

RegisterServerEvent("Queue:Connect")
AddEventHandler("Queue:Connect",function()
    local source = source

    if not Queue["Players"][source] then
        local ids = steamIds(source)

        Queue["Counts"] = Queue["Counts"] + 1
        Queue["Players"][source] = true
        removeQueue(ids)
        removeConnect(ids)
    end
end)

AddEventHandler("playerDropped",function()
    if Queue["Players"][source] then
        local ids = steamIds(source)

        Queue["Counts"] = Queue["Counts"] - 1
        Queue["Players"][source] = nil
        removeQueue(ids)
        removeConnect(ids)
    end
end)

AddEventHandler("Queue:remove",function(ids)
    removeQueue(ids)
    removeConnect(ids)
end)

-- salary.lua

AddEventHandler("Salary:Add", function(Passport, Permission)
    if not Salary[Permission] then
        Salary[Permission] = {}
    end

    if not Salary[Permission][Passport] then
        Salary[Permission][Passport] = os.time() + SalaryCooldowns
    end
end)

AddEventHandler("Salary:Remove", function(Passport, Permission)
    if Permission then
        if Salary[Permission] and Salary[Permission][Passport] then
            Salary[Permission][Passport] = nil
        end
    else
        for Permission, _ in pairs(Salary) do
            if Salary[Permission][Passport] then
                Salary[Permission][Passport] = nil
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(60000)
        
        for Permission, _ in pairs(Salary) do
            for Passport, Timer in pairs(Salary[Permission]) do
                if Timer <= os.time() then
                    local Number = vRP.HasPermission(Passport, Permission)
                    Salary[Permission][Passport] = os.time() + SalaryCooldowns

                    if Number then
                        if Groups[Permission] and Groups[Permission]["Salary"] and Groups[Permission]["Salary"][Number] then
                            vRP.GiveBank(Passport, Groups[Permission]["Salary"][Number])
                        end
                    else
                        Salary[Permission][Passport] = nil
                    end
                end
            end
        end
    end
end)

AddEventHandler("Disconnect", function(Passport)
    for Permission, _ in pairs(Salary) do
        if Salary[Permission][Passport] then
            Salary[Permission][Passport] = nil
        end
    end
end)

--vehicles.lua

RegisterServerEvent("CleanVehicle")
AddEventHandler("CleanVehicle", function(Index)
    local Network = NetworkGetEntityFromNetworkId(Index)
    if DoesEntityExist(Network) and not IsPedAPlayer(Network) and 2 == GetEntityType(Network) then
        SetVehicleDirtLevel(Network, 0)
    end
end)


