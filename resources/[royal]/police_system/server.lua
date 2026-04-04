Config = Config or {}

local Proxy = Proxy
local Tunnel = Tunnel

if not Proxy or not Tunnel then
    pcall(function()
        Proxy = module("vrp","lib/Proxy")
        Tunnel = module("vrp","lib/Tunnel")
    end)
end

vRP = vRP or (Proxy and Proxy.getInterface and Proxy.getInterface("vRP")) or vRP

local DB = Config.Database or {}
local PrisonConfig = Config.Prison or {}
local FineConfig = Config.Fine or {}
local PrisonPermissions = Config.PrisonPermissions or {}

local function parseInt(value)
    value = tonumber(value)
    if value then return math.floor(value) end
    return 0
end

local function sanitizeString(str)
    if not str then return "" end
    str = tostring(str)
    str = str:gsub("^%s+","")
    str = str:gsub("%s+$","")
    return str
end

local function notify(source,color,message,time)
    TriggerClientEvent("Notify",source,color or "amarelo",message or "",time or 5000)
end

local function vrpReady()
    return type(vRP) == "table"
end

local function getPassport(source)
    if not vrpReady() then return nil end
    if vRP.Passport then
        local passport = vRP.Passport(source)
        if passport then return passport end
    end
    if vRP.getUserId then
        local passport = vRP.getUserId(source)
        if passport then return passport end
    end
    return nil
end

local function getSourceByPassport(passport)
    if not vrpReady() then return nil end
    passport = parseInt(passport)
    if passport <= 0 then return nil end
    if vRP.Source then
        local source = vRP.Source(passport)
        if source then return source end
    end
    if vRP.getUserSource then
        local source = vRP.getUserSource(passport)
        if source then return source end
    end
    return nil
end

local function getUserGroups(passport)
    if not vrpReady() then return {} end
    if vRP.getUserGroups then return vRP.getUserGroups(passport) or {} end
    if vRP.GetUserGroups then return vRP.GetUserGroups(passport) or {} end
    return {}
end

local function hasGroupHierarchy(passport,groupName,maxHierarchy)
    if not passport or not groupName then return false end

    local groups = getUserGroups(passport)
    maxHierarchy = tonumber(maxHierarchy) or 0

    for group,level in pairs(groups) do
        if tostring(group):lower() == tostring(groupName):lower() then
            level = tonumber(level) or 99
            if maxHierarchy <= 0 or level <= maxHierarchy then
                return true
            end
        end
    end

    if vrpReady() and vRP.HasGroup then
        if maxHierarchy > 0 then
            for hierarchy = 1,maxHierarchy do
                if vRP.HasGroup(passport,groupName,hierarchy) then
                    return true
                end
            end
        else
            if vRP.HasGroup(passport,groupName) then
                return true
            end
        end
    end

    if vrpReady() and vRP.HasPermission then
        return vRP.HasPermission(passport,groupName)
    end

    if vrpReady() and vRP.hasPermission then
        return vRP.hasPermission(passport,groupName)
    end

    return false
end

local function hasPermissionList(passport,list)
    if not passport or not list then return false end
    for _,perm in pairs(list) do
        if hasGroupHierarchy(passport,perm.Group or perm.group,perm.MaxHierarchy or perm.hierarchy) then
            return true
        end
    end
    return false
end

local function getIdentity(passport)
    if not vrpReady() then return nil end
    if vRP.Identity then
        local identity = vRP.Identity(passport)
        if identity then return identity end
    end
    if vRP.getUserIdentity then
        local identity = vRP.getUserIdentity(passport)
        if identity then return identity end
    end
    return nil
end

local function identityName(passport)
    local identity = getIdentity(passport)
    if not identity then
        return "Passaporte " .. tostring(passport)
    end

    local name = identity.name or identity.Name or identity.firstname or identity.firstName or identity.nome or ""
    local name2 = identity.name2 or identity.Name2 or identity.lastname or identity.lastName or identity.sobrenome or ""
    local full = sanitizeString((tostring(name) .. " " .. tostring(name2)):gsub("%s%s+"," "))

    if full == "" then
        full = tostring(identity[1] or ("Passaporte " .. tostring(passport)))
    end

    return full
end

local function sendLog(kind,title,description)
    local entry = (Config.Logs and Config.Logs[kind]) or {}
    local webhook = entry.Webhook or ""
    if webhook == "" then return end

    PerformHttpRequest(webhook,function() end,"POST",json.encode({
        username = "police_system",
        embeds = {{
            title = title,
            description = description,
            color = tonumber(entry.Color) or 16777215,
            footer = { text = os.date("%d/%m/%Y %H:%M:%S") }
        }}
    }),{ ["Content-Type"] = "application/json" })
end

local function prepare(name,queryText)
    if not vrpReady() then return false end
    if vRP.Prepare then vRP.Prepare(name,queryText) return true end
    if vRP.prepare then vRP.prepare(name,queryText) return true end
    if vRP._Prepare then vRP._Prepare(name,queryText) return true end
    return false
end

local function query(name,params)
    if not vrpReady() then return nil end
    if vRP.Query then return vRP.Query(name,params) end
    if vRP.query then return vRP.query(name,params) end
    return nil
end

CreateThread(function()
    while not vrpReady() do Wait(250) end

    prepare("police_system/GetPrison","SELECT `" .. (DB.Prison or "prison") .. "` FROM `" .. (DB.Table or "characters") .. "` WHERE `" .. (DB.Id or "id") .. "` = @id LIMIT 1")
    prepare("police_system/SetPrison","UPDATE `" .. (DB.Table or "characters") .. "` SET `" .. (DB.Prison or "prison") .. "` = @prison WHERE `" .. (DB.Id or "id") .. "` = @id")
    prepare("police_system/AddPrison","UPDATE `" .. (DB.Table or "characters") .. "` SET `" .. (DB.Prison or "prison") .. "` = `" .. (DB.Prison or "prison") .. "` + @amount WHERE `" .. (DB.Id or "id") .. "` = @id")
    prepare("police_system/ReducePrison","UPDATE `" .. (DB.Table or "characters") .. "` SET `" .. (DB.Prison or "prison") .. "` = GREATEST(`" .. (DB.Prison or "prison") .. "` - @amount,0) WHERE `" .. (DB.Id or "id") .. "` = @id")
end)

local function getPrisonAmount(passport)
    passport = parseInt(passport)
    if passport <= 0 then return 0 end
    local consult = query("police_system/GetPrison",{ id = passport })
    if consult and consult[1] then
        return parseInt(consult[1][DB.Prison or "prison"] or consult[1].prison)
    end
    return 0
end

local function setPrisonAmount(passport,amount)
    passport = parseInt(passport)
    amount = parseInt(amount)
    if passport <= 0 then return 0 end
    if amount < 0 then amount = 0 end
    query("police_system/SetPrison",{ id = passport, prison = amount })
    Wait(100)
    return getPrisonAmount(passport)
end

local function addPrisonAmount(passport,amount)
    passport = parseInt(passport)
    amount = parseInt(amount)
    if passport <= 0 then return 0 end
    if amount <= 0 then return getPrisonAmount(passport) end
    query("police_system/AddPrison",{ id = passport, amount = amount })
    Wait(100)
    return getPrisonAmount(passport)
end

local function reducePrisonAmount(passport,amount)
    passport = parseInt(passport)
    amount = parseInt(amount)
    if passport <= 0 then return 0 end
    if amount <= 0 then amount = 1 end
    query("police_system/ReducePrison",{ id = passport, amount = amount })
    Wait(100)
    return getPrisonAmount(passport)
end

local function setPlayerPrisonState(source,status)
    if source and Player(source) and Player(source).state then
        Player(source).state.Prison = status and true or false
    end
    TriggerClientEvent("wn_prisoncmd:setPrisonState",source,status and true or false)
end

local function sendToPrison(source)
    TriggerClientEvent("wn_prisoncmd:teleportToPrison",source)
    setPlayerPrisonState(source,true)
end

local function sendOutPrison(source)
    TriggerClientEvent("wn_prisoncmd:teleportOutPrison",source)
    setPlayerPrisonState(source,false)
end

local function resolvePassportFromArg(value)
    local number = parseInt(value)
    if number <= 0 then return 0 end
    local targetSource = tonumber(value)
    if targetSource and GetPlayerName(targetSource) then
        local onlinePassport = getPassport(targetSource)
        if onlinePassport then return parseInt(onlinePassport) end
    end
    return number
end

local function prisonPlayer(policeSource,targetPassport,services)
    local policePassport = getPassport(policeSource)
    if not policePassport then
        notify(policeSource,"vermelho","Seu passaporte não foi identificado.")
        return
    end

    if not hasPermissionList(policePassport,PrisonPermissions.Prender or {}) then
        notify(policeSource,"vermelho","Você não tem permissão para prender.")
        return
    end

    targetPassport = parseInt(targetPassport)
    services = parseInt(services)

    if targetPassport <= 0 then
        notify(policeSource,"amarelo","Passaporte inválido.")
        return
    end

    if services <= 0 then
        notify(policeSource,"amarelo","Serviços inválidos.")
        return
    end

    local total = addPrisonAmount(targetPassport,services)
    local targetSource = getSourceByPassport(targetPassport)
    local policeName = identityName(policePassport)
    local targetName = identityName(targetPassport)

    if targetSource then
        sendToPrison(targetSource)
        notify(targetSource,"vermelho","Você foi preso. Restam " .. total .. " serviços.")
    end

    notify(policeSource,"verde","Passaporte " .. targetPassport .. " preso com " .. services .. " serviços.")

    sendLog("Prender","Registro de Prisão",(
        "**Policial:** %s\n**Passaporte policial:** %s\n**Preso:** %s\n**Passaporte preso:** %s\n**Serviços aplicados:** %s\n**Total restante:** %s"
    ):format(policeName,policePassport,targetName,targetPassport,services,total))
end

local function unprisonPlayer(policeSource,targetPassport)
    local policePassport = getPassport(policeSource)
    if not policePassport then
        notify(policeSource,"vermelho","Seu passaporte não foi identificado.")
        return
    end

    if not hasPermissionList(policePassport,PrisonPermissions.Soltar or {}) then
        notify(policeSource,"vermelho","Você não tem permissão para soltar.")
        return
    end

    targetPassport = parseInt(targetPassport)
    if targetPassport <= 0 then
        notify(policeSource,"amarelo","Passaporte inválido.")
        return
    end

    setPrisonAmount(targetPassport,0)

    local targetSource = getSourceByPassport(targetPassport)
    local policeName = identityName(policePassport)
    local targetName = identityName(targetPassport)

    if targetSource then
        sendOutPrison(targetSource)
        notify(targetSource,"verde","Você foi solto da prisão.")
    end

    notify(policeSource,"verde","Passaporte " .. targetPassport .. " foi solto.")

    sendLog("Soltar","Registro de Soltura",(
        "**Policial:** %s\n**Passaporte policial:** %s\n**Solto:** %s\n**Passaporte solto:** %s"
    ):format(policeName,policePassport,targetName,targetPassport))
end

RegisterCommand("prender",function(source,args)
    if source <= 0 then return end
    local targetPassport = resolvePassportFromArg(args[1])
    local services = parseInt(args[2])
    if targetPassport <= 0 or services <= 0 then
        notify(source,"amarelo","Use: /prender [id ou passaporte] [serviços]")
        return
    end
    prisonPlayer(source,targetPassport,services)
end)

RegisterCommand("soltar",function(source,args)
    if source <= 0 then return end
    local targetPassport = resolvePassportFromArg(args[1])
    if targetPassport <= 0 then
        notify(source,"amarelo","Use: /soltar [id ou passaporte]")
        return
    end
    unprisonPlayer(source,targetPassport)
end)

RegisterNetEvent("police_system:reduceServiceBox",function(amount)
    local source = source
    local passport = getPassport(source)
    if not passport then return end

    local current = getPrisonAmount(passport)
    if current <= 0 then
        setPlayerPrisonState(source,false)
        return
    end

    amount = parseInt(amount)
    if amount <= 0 then amount = 1 end

    local newAmount = reducePrisonAmount(passport,amount)
    if newAmount > 0 then
        notify(source,"amarelo","Você entregou a caixa. Faltam " .. newAmount .. " serviços.")
    else
        setPrisonAmount(passport,0)
        sendOutPrison(source)
        notify(source,"verde","Sua pena terminou, você foi solto.")
    end
end)

CreateThread(function()
    while true do
        Wait(60000)
        local reducePerMinute = parseInt(PrisonConfig.ReducePerMinute or 0)
        if reducePerMinute > 0 then
            for _,playerId in ipairs(GetPlayers()) do
                local source = tonumber(playerId)
                if source and source > 0 then
                    local passport = getPassport(source)
                    if passport then
                        local prisonAmount = getPrisonAmount(passport)
                        if prisonAmount > 0 then
                            local newAmount = reducePrisonAmount(passport,reducePerMinute)
                            if newAmount > 0 then
                                setPlayerPrisonState(source,true)
                                notify(source,"amarelo","Seu tempo reduziu " .. reducePerMinute .. " serviço(s). Faltam " .. newAmount .. " serviços.")
                            else
                                setPrisonAmount(passport,0)
                                sendOutPrison(source)
                                notify(source,"verde","Sua pena terminou, você foi solto.")
                            end
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local passport = parseInt(user_id)
    if passport <= 0 then return end

    CreateThread(function()
        Wait(3000)
        local prisonAmount = getPrisonAmount(passport)
        if prisonAmount > 0 then
            sendToPrison(source)
            notify(source,"vermelho","Você está preso. Restam " .. prisonAmount .. " serviços.")
        else
            setPlayerPrisonState(source,false)
        end
    end)
end)

local function applyFine(officerPassport,targetPassport,amount,reason)
    local bankOk = false

    if vRP.GiveFine then
        vRP.GiveFine(targetPassport,amount)
    elseif vRP.UpdateFines then
        vRP.UpdateFines(targetPassport,amount)
    end

    pcall(function()
        exports["bank"]:AddFines(targetPassport,officerPassport,amount,reason ~= "" and reason or "Não informado")
        bankOk = true
    end)

    return bankOk
end

RegisterCommand(FineConfig.Command or "multa",function(source,args)
    local passport = getPassport(source)
    if not passport then return end

    if not hasPermissionList(passport,FineConfig.Permissions or {}) then
        notify(source,"vermelho","Você não tem permissão para aplicar multas.")
        return
    end

    local targetPassport = parseInt(args[1])
    local amount = parseInt(args[2])

    table.remove(args,1)
    table.remove(args,1)
    local reason = sanitizeString(table.concat(args," "))

    if targetPassport <= 0 then
        notify(source,"amarelo","Use: /" .. (FineConfig.Command or "multa") .. " [id/passaporte] [valor] [motivo]")
        return
    end

    if amount < parseInt(FineConfig.MinValue or 1) then
        notify(source,"amarelo","O valor mínimo da multa é $" .. parseInt(FineConfig.MinValue or 1) .. ".")
        return
    end

    if amount > parseInt(FineConfig.MaxValue or 100000000) then
        notify(source,"amarelo","O valor máximo da multa é $" .. parseInt(FineConfig.MaxValue or 100000000) .. ".")
        return
    end

    if FineConfig.RequireReason and reason == "" then
        notify(source,"amarelo","Informe o motivo da multa.")
        return
    end

    local targetSource = getSourceByPassport(targetPassport)
    local officerName = identityName(passport)
    local targetName = identityName(targetPassport)
    local bankOk = applyFine(passport,targetPassport,amount,reason)

    if FineConfig.NotifyOfficer ~= false then
        notify(source,"verde","Você multou o passaporte <b>" .. targetPassport .. "</b> em <b>$" .. amount .. "</b>.<br><b>Motivo:</b> " .. (reason ~= "" and reason or "Não informado"))
    end

    if FineConfig.NotifyTarget ~= false and targetSource then
        notify(targetSource,"vermelho","Você recebeu uma multa de <b>$" .. amount .. "</b>.<br><b>Motivo:</b> " .. (reason ~= "" and reason or "Não informado"),8000)
    end

    sendLog("Multa","Registro de Multa",(
        "**Policial:** %s [%s]\n**Multado:** %s [%s]\n**Valor:** $%s\n**Motivo:** %s\n**Banco:** %s"
    ):format(officerName,passport,targetName,targetPassport,amount,(reason ~= "" and reason or "Não informado"),(bankOk and "Registrado no bank" or "Falhou ao registrar no bank")))
end)

RegisterCommand(FineConfig.CheckCommand or "vermulta",function(source,args)
    local passport = getPassport(source)
    if not passport then return end

    local targetPassport = parseInt(args[1])
    if targetPassport <= 0 then
        targetPassport = passport
    end

    local targetSource = getSourceByPassport(targetPassport)
    if not targetSource then
        notify(source,"amarelo","O jogador precisa estar online para consultar a multa total.")
        return
    end

    local totalFine = 0
    if vRP.GetFine then
        totalFine = parseInt(vRP.GetFine(targetSource))
    elseif vRP.GetFines then
        totalFine = parseInt(vRP.GetFines(targetPassport))
    end

    notify(source,"azul","O passaporte <b>" .. targetPassport .. "</b> possui <b>$" .. totalFine .. "</b> em multas.")
end)
