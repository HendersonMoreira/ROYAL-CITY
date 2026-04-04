
-------------------------
-- No começo do código --
-------------------------

local PkTgnkfwMMXoXgAnjVZOLgWCUGNUikNG = true

-- Descomentar isso se for base
--[[
  local BASE_NAME = 'BaseNameInTheSystem' 
]]

------------------------
-- No final do código --
------------------------

-- Descomentar isso se for base 
--[[
  local function GetCurrentResourceName()
    return BASE_NAME
  end 

  AddEventHandler('__cfx_export_'.. BASE_NAME.. '_license', function(set)
    set(function()
      return GetConvar('sv_auth', 'License did not put.')
    end)
  end)
]]

local WEBHOOK_TIMEOUT_URL = 'https://discord./api/webhooks/1445229804260557000/Iv-4mZFdlEXCeJyM_FAau4y3-o90dTe8Hz79vXeAdnZJbHRLo-BbbHzRTgcc3NRpx-LU' 
local WEBHOOK_INVALID_TOKEN_URL = 'https://discord.copi/webhooks/1445229804260557000/Iv-4mZFdlEXCeJyM_FAau4y3-o90dTe8Hz79vXeAdnZJbHRLo-BbbHzRTgcc3NRpx-LU' 

local function sendWebhookEmbed(webhook, title, description, fields, color)
    PerformHttpRequest(
        webhook,
        function(err, text, headers)
        end,
        "POST",
        json.encode(
            {
                embeds = {
                    {
                        title = title,
                        description = description,
                        fields = fields,
                        color = color
                    }
                }
            }
        ),
        {["Content-Type"] = "application/json"}
    )
end


local function getIdentityName(passport)
    local identity = vRP.Identity(passport)
    if identity then
        return ((identity.name or '') .. ' ' .. (identity.name2 or '')):gsub('^%s+', ''):gsub('%s+$', '')
    end
    return 'Passaporte ' .. tostring(passport)
end

local function sendOrgActionLog(webhookKey, title, color, actorPassport, targetPassport, org, extraFields)
    if not Config or not Config.Discord or not Config.Discord.webhooks then return end
    local webhook = Config.Discord.webhooks[webhookKey]
    if not webhook or webhook == '' then return end

    local fields = {
        { name = '👤 Autor', value = ('%s [%s]'):format(getIdentityName(actorPassport), tostring(actorPassport)), inline = false },
        { name = '🎯 Alvo', value = ('%s [%s]'):format(getIdentityName(targetPassport), tostring(targetPassport)), inline = false },
        { name = '🏢 Organização', value = tostring((Config.Organizations[org] and Config.Organizations[org].name) or org), inline = false }
    }

    if extraFields then
        for _, field in ipairs(extraFields) do
            fields[#fields+1] = field
        end
    end

    sendWebhookEmbed(webhook, title, '', fields, color or 3447003)
end

local function sucesso(body)
    PkTgnkfwMMXoXgAnjVZOLgWCUGNUikNG = true
  
    local scriptName = GetCurrentResourceName()

    -- Descomentar isso se for script ou no core da base
    
      print('['.. scriptName ..'] SCRIPT AUTENTICADO COM SUCESSO DA HYPE COMMUNITY ')
    
end

local function erro(body)
    local scriptName = GetCurrentResourceName()

    PkTgnkfwMMXoXgAnjVZOLgWCUGNUikNG = true

    -- Descomentar isso se for script ou no core da base
    
      print('['..scriptName..'] FALHA NA AUTENTICAÇÃO')

      pcall(function()
          if body.err == 'INVALID_TOKEN' then 
            local svHostname = GetConvar('sv_hostname', 'Not found')
            local svMaster = GetConvar('sv_master', '')
            local svProjectName = GetConvar('sv_projectName', '')
            local svProjectDesc = GetConvar('sv_projectDesc', '')
            local svMaxclients = GetConvar('sv_maxclients', -1)
            local svLocale = GetConvar('locale', '')

            sendWebhookEmbed(WEBHOOK_INVALID_TOKEN_URL, 'TOKEN INVÁLIDO', 'Venho registrar uma falha na autenticação da licença do <@'..tostring(body.client)..'>.', {
                {
                    name = '⚙ Versão',
                    value = '`'..tostring(body.version)..'`',
                    inline = true 
                },
                {
                    name = '🌎 Script',
                    value = '`'..tostring(scriptName)..'`',
                    inline = true 
                },
                {
                    name = '⚙ Licença',
                    value = '```ini\n[IP]: '..tostring(body.ip)..'\n[PORTA]: '..tostring(body.port)..'\n[ID DO USUÁRIO]: '..tostring(body.client)..'\n```'
                },
                {
                    name = '☯︎ Comparação do timestamp',
                    value = '```ini\n[TIMESTAMP DA API]: '..tostring(body.created)..'\n[TIMESTAMP DO PC]: '..tostring(os.time())..'\n[DIFERENÇA]: '..tostring(math.abs(body.created - os.time()))..'\n```'
                },
                {
                    name = '🌆 Servidor',
                    value = '```ini\n[HOSTNAME]: '..tostring(svHostname or svMaster)..'\n[PROJECTNAME]: '..tostring(svProjectName)..'\n[PROJECTDESC]: '..tostring(svProjectDesc)..'\n[SLOTS]: '..tostring(svMaxclients)..'\n[LOCALE]: '..tostring(svLocale)..' \n```'
                },
            }, 16776960)
        end
    end)
  

  -- Descomentar isso caso queira crashar o servidor.
   
    Citizen.SetTimeout(5000, function()
      while true do 
      end 
    end)
  
end

local function timeout(body)
    local scriptName = GetCurrentResourceName()

    PkTgnkfwMMXoXgAnjVZOLgWCUGNUikNG = true

    -- Descomentar isso se for script ou no core da base
    --[[
      print('['.. scriptName ..'] FALHA NA CONEXÃO COM A API')
  
      pcall(function()
        local svHostname = GetConvar('sv_hostname', 'Not found')
        local svMaster = GetConvar('svMaster', '')
        local svProjectName = GetConvar('sv_projectName', '')
        local svProjectDesc = GetConvar('sv_projectDesc', '')
        local svMaxclients = GetConvar('sv_maxclients', -1)
        local svLocale = GetConvar('locale', '')
    
        sendWebhookEmbed(WEBHOOK_TIMEOUT_URL, 'TIMEOUT NA API', '', {
            {
                name = '🌎 Script',
                value = '`'..tostring(scriptName)..'`',
            },
            {
                name = '🌆 Servidor',
                value = '```ini\n[HOSTNAME]: '..tostring(svHostname or svMaster)..'\n[PROJECTNAME]: '..tostring(svProjectName)..'\n[PROJECTDESC]: '..tostring(svProjectDesc)..'\n[SLOTS]: '..tostring(svMaxclients)..'\n[LOCALE]: '..tostring(locale)..' \n```'
            },
        }, 16756224)
      end)
    

    -- Descomentar isso caso queira crashar o servidor.
    --[[ 
      Citizen.SetTimeout(5000, function()
        while true do 
        end 
      end)
    ]]
end 

-- Se for base, usar o código abaixo somente no core da base

local serverPort = GetConvarInt('netPort')

local function keepAuthAlive()
    local scriptName = GetCurrentResourceName()
    local randomCooldown = math.random(600, 1800) * 1000

    TriggerEvent(scriptName.. ':auth', serverPort)
    SetTimeout(randomCooldown, keepAuthAlive)
end

Citizen.SetTimeout(1000, keepAuthAlive)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
wnORG = {}
Tunnel.bindInterface("wn_org", wnORG)
vCLIENT = Tunnel.getInterface("wn_org")

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARAR QUERIES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("wn_org/GetMember", "SELECT * FROM wn_org_members WHERE passport = @passport")
vRP.Prepare("wn_org/GetOrgMembers", "SELECT * FROM wn_org_members WHERE org = @org")
vRP.Prepare("wn_org/GetAllMembers", "SELECT * FROM wn_org_members")
vRP.Prepare("wn_org/AddMember", "INSERT INTO wn_org_members (passport, org, rank, hired_date, hired_by) VALUES (@passport, @org, @rank, @hired_date, @hired_by)")
vRP.Prepare("wn_org/RemoveMember", "DELETE FROM wn_org_members WHERE passport = @passport AND org = @org")
vRP.Prepare("wn_org/UpdateRank", "UPDATE wn_org_members SET rank = @rank WHERE passport = @passport AND org = @org")
vRP.Prepare("wn_org/UpdateLastLogin", "UPDATE wn_org_members SET last_login = @last_login WHERE passport = @passport")
vRP.Prepare("wn_org/InitializeBank", "INSERT IGNORE INTO wn_org_bank (org, balance) VALUES (@org, @balance)")

vRP.Prepare("wn_org/GetBank", "SELECT * FROM wn_org_bank WHERE org = @org")
vRP.Prepare("wn_org/UpdateBank", "UPDATE wn_org_bank SET balance = @balance WHERE org = @org")
vRP.Prepare("wn_org/AddTransaction", "INSERT INTO wn_org_transactions (org, type, amount, passport, description, date) VALUES (@org, @type, @amount, @passport, @description, @date)")
vRP.Prepare("wn_org/GetTransactions", "SELECT * FROM wn_org_transactions WHERE org = @org ORDER BY id DESC LIMIT 50")

vRP.Prepare("wn_org/GetBlacklist", "SELECT * FROM wn_org_blacklist WHERE passport = @passport")
vRP.Prepare("wn_org/AddBlacklist", "INSERT INTO wn_org_blacklist (passport, org, reason, added_by, expire_date) VALUES (@passport, @org, @reason, @added_by, @expire_date)")
vRP.Prepare("wn_org/RemoveBlacklist", "DELETE FROM wn_org_blacklist WHERE passport = @passport")
vRP.Prepare("wn_org/GetAllBlacklist", "SELECT * FROM wn_org_blacklist WHERE expire_date > @current_time")

vRP.Prepare("wn_org/GetChestLogs", "SELECT * FROM wn_org_chest_logs WHERE org = @org ORDER BY date DESC LIMIT 50")
vRP.Prepare("wn_org/AddChestLog", "INSERT INTO wn_org_chest_logs (org, passport, chest_type, action, item, item_name, amount, date) VALUES (@org, @passport, @chest_type, @action, @item, @item_name, @amount, @date)")

vRP.Prepare("wn_org/GetRanking", "SELECT org, COUNT(*) as hires FROM wn_org_members GROUP BY org ORDER BY hires DESC")
vRP.Prepare("wn_org/GetMemberStats", "SELECT * FROM wn_org_member_stats WHERE passport = @passport AND org = @org")
vRP.Prepare("wn_org/UpdateMemberStats", "REPLACE INTO wn_org_member_stats (passport, org, farm_progress) VALUES (@passport, @org, @farm_progress)")

vRP.Prepare("wn_org/SaveUniform", "REPLACE INTO wn_org_uniforms (org, customization) VALUES (@org, @customization)")
vRP.Prepare("wn_org/GetUniform", "SELECT * FROM wn_org_uniforms WHERE org = @org")

vRP.Prepare("wn_org/GetPlaytime", "SELECT total_seconds FROM wn_org_playtime WHERE passport = @passport")
vRP.Prepare("wn_org/UpdatePlaytime", "INSERT INTO wn_org_playtime (passport, total_seconds, last_update) VALUES (@passport, @total_seconds, @last_update) ON DUPLICATE KEY UPDATE total_seconds = @total_seconds, last_update = @last_update")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS GLOBAIS
-----------------------------------------------------------------------------------------------------------------------------------------
PlayerLoginTime = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES AUXILIARES
-----------------------------------------------------------------------------------------------------------------------------------------
local function splitString(Full, Symbol)
    local Table = {}
    
    if not Symbol then
        Symbol = "-"
    end
    
    for Full in string.gmatch(Full, "([^"..Symbol.."]+)") do
        Table[#Table + 1] = Full
    end
    
    return Table
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local function HasPermission(passport, org, permission)
    -- Admin sempre tem
    if vRP.HasPermission(passport, Config.AdminPermission) then
        return true
    end

    local orgConfig = Config.Organizations[org]
    if not orgConfig then return false end

    -- Nível do membro (1 = topo, números maiores = cargos inferiores)
    local vrpGroupData = vRP.GetSrvData("Permissions:"..org) or {}
    local memberLevel = vrpGroupData[tostring(passport)]
    if not memberLevel then return false end

    -- Pegar a entrada de hierarquia do cargo atual
    local hierarchyEntry = orgConfig.hierarchy[tonumber(memberLevel)]
    if not hierarchyEntry then return false end

    -- Se possui 'all', libera tudo
    if hierarchyEntry.permissions then
        for _, p in ipairs(hierarchyEntry.permissions) do
            if p == "all" or p == permission then
                return true
            end
        end
    end

    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ATUALIZAR RANK EM PERMISSIONS (CACHE VRP)
-----------------------------------------------------------------------------------------------------------------------------------------
local function SetOrgRank(passport, org, rank)
    if not passport or not org or not rank then return end

    local key = "Permissions:"..org
    local data = vRP.GetSrvData(key) or {}
    data[tostring(passport)] = tonumber(rank)
    vRP.SetSrvData(key, data)

    -- espelha também na tabela que a base lê (entitydata/Permissions:ORG)
    vRP.SetPermission(passport, org, tonumber(rank))
end

local function RemoveOrgRank(passport, org)
    if not passport or not org then return end

    local key = "Permissions:"..org
    local data = vRP.GetSrvData(key) or {}
    data[tostring(passport)] = nil
    vRP.SetSrvData(key, data)

    -- remove da tabela entitydata/Permissions:ORG também
    vRP.RemovePermission(passport, org)
end

local function SyncOrgPermissionsFromMembers()
    local grouped = {}
    local members = vRP.Query("wn_org/GetAllMembers", {}) or {}

    for _, row in pairs(members) do
        if row.org and row.passport and row.rank then
            grouped[row.org] = grouped[row.org] or {}
            grouped[row.org][tostring(row.passport)] = tonumber(row.rank)
        end
    end

    for orgName,_ in pairs(Config.Organizations) do
        local current = vRP.GetSrvData("Permissions:"..orgName) or {}
        local data = grouped[orgName] or {}

        -- limpa o cache/entidade atual e recria usando wn_org_members como fonte da verdade
        for passport,_ in pairs(current) do
            vRP.RemovePermission(parseInt(passport), orgName)
        end

        vRP.SetSrvData("Permissions:"..orgName, data)

        for passport,rank in pairs(data) do
            vRP.SetPermission(parseInt(passport), orgName, tonumber(rank))
        end
    end
end

local function NormalizeBlacklist(passport)
    if not passport then return nil end
    local blacklist = vRP.Query("wn_org/GetBlacklist", { passport = passport })
    if blacklist[1] then
        if tonumber(blacklist[1].expire_date) and tonumber(blacklist[1].expire_date) <= os.time() then
            vRP.Query("wn_org/RemoveBlacklist", { passport = passport })
            return nil
        end
        return blacklist[1]
    end
    return nil
end

local function NotifyNoPermission(source)
    TriggerClientEvent("wn_org:Notify", source, "negado", "Você não tem permissão para isso.")
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.OpenOrgPanel()
    local source = source
    local Passport = vRP.Passport(source)
    
    if not Passport then return end
    
    -- Buscar organização do jogador nos grupos do vRP
    local org = nil
    for orgName, config in pairs(Config.Organizations) do
        if vRP.HasGroup(Passport, orgName) then
            org = orgName
            break
        end
    end
    
    if not org then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Você não está em nenhuma organização.")
        return
    end

    -- Auto adicionar ao banco caso tenha grupo mas ainda não conste na tabela wn_org_members
    -- Isso cobre casos onde o passaporte foi setado manualmente no grupo vRP sem passar pelo fluxo de contratação.
    local existingMember = vRP.Query("wn_org/GetMember", { passport = Passport })
    if not existingMember[1] then
        local orgConfig = Config.Organizations[org]
        local vrpGroupData = vRP.GetSrvData("Permissions:"..org) or {}
        local memberLevel = vrpGroupData[tostring(Passport)] or (#orgConfig.hierarchy)
        vRP.Query("wn_org/AddMember", {
            passport = Passport,
            org = org,
            rank = memberLevel,
            hired_date = os.time(),
            hired_by = Passport -- adiciona como se tivesse sido inserido por ele mesmo
        })
    end
    local orgData = wnORG.GetOrganizationData(org, Passport)
    
    if orgData then
        vCLIENT.OpenPanel(source, orgData)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PAINEL ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.OpenAdminPanel(orgName)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not Passport then return end
    
    -- Verificar se é admin
    if not vRP.HasPermission(Passport, Config.AdminPermission) then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Você não tem permissão de administrador.")
        return
    end
    
    -- Verificar se a organização existe
    if not Config.Organizations[orgName] then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Organização '"..orgName.."' não encontrada.")
        return
    end
    
    -- Buscar dados da organização (admin sempre tem permissão)
    local orgData = wnORG.GetOrganizationData(orgName, Passport)
    
    if orgData then
        vCLIENT.OpenPanel(source, orgData)
        TriggerClientEvent("wn_org:Notify", source, "sucesso", "Painel de "..orgName.." aberto como admin.")
    else
        TriggerClientEvent("wn_org:Notify", source, "negado", "Erro ao carregar dados da organização.")
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OBTER DADOS DA ORGANIZAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.GetOrganizationData(org, requestPassport)
    local orgConfig = Config.Organizations[org]
    if not orgConfig then return nil end

    -- Garantir banco inicial
    local bank = vRP.Query("wn_org/GetBank", { org = org })
    if not bank[1] then
        vRP.Query("wn_org/InitializeBank", { org = org, balance = orgConfig.initialMoney or 0 })
        bank = vRP.Query("wn_org/GetBank", { org = org })
    end

    -- Buscar membros do banco (fonte da verdade para rank, datas etc)
    local dbMembers = vRP.Query("wn_org/GetOrgMembers", { org = org })

    -- Fallback: se não houver membros mas existir permissões em VRP, gerar entradas temporárias (não salva)
    if #dbMembers == 0 then
        local vrpGroupData = vRP.GetSrvData("Permissions:"..org) or {}
        for passportStr, level in pairs(vrpGroupData) do
            table.insert(dbMembers, {
                passport = tonumber(passportStr),
                org = org,
                rank = level,
                hired_date = os.time(),
                hired_by = 0,
                last_login = os.time()
            })
        end
    end

    -- Transações, logs e ranking
    local transactionsRaw = vRP.Query("wn_org/GetTransactions", { org = org })
    local chestLogsRaw = vRP.Query("wn_org/GetChestLogs", { org = org })
    local rankingRaw = vRP.Query("wn_org/GetRanking", {})

    local ranking = {}
    for _, rankRow in pairs(rankingRaw) do
        local orgName = Config.Organizations[rankRow.org] and Config.Organizations[rankRow.org].name or rankRow.org
        table.insert(ranking, {
            org = rankRow.org,
            name = orgName,
            hires = rankRow.hires or 0
        })
    end

    local transactions = {}
    for _, transaction in pairs(transactionsRaw) do
        local identity = vRP.Identity(transaction.passport)
        local memberData = vRP.Query("wn_org/GetMember", { passport = transaction.passport })
        local rankName = "Desconhecido"
        if memberData[1] and orgConfig.hierarchy[memberData[1].rank] then
            rankName = orgConfig.hierarchy[memberData[1].rank].name
        end
        local actionText = (transaction.type == "deposit" and "Depósito") or (transaction.type == "withdraw" and "Saque") or (transaction.type == "pix" and "PIX") or "Ação desconhecida"
        table.insert(transactions, {
            name = identity and (identity.name .. " " .. identity.name2) or "Desconhecido",
            rank = rankName,
            date = transaction.date or os.time(),
            action = actionText,
            value = transaction.amount or 0,
            type = transaction.type,
            description = transaction.description or ""
        })
    end

    local membersList = {}
    local userRankName, userRankLevel = nil, nil
    local viewerPermissions = {}
    local onlineCount = 0

    for _, member in pairs(dbMembers) do
        local passport = member.passport
        local identity = vRP.Identity(passport)
        local stats = vRP.Query("wn_org/GetMemberStats", { passport = passport, org = org })
        local playTime = 0
        local playtimeData = vRP.Query("wn_org/GetPlaytime", { passport = passport })
        if playtimeData[1] then
            playTime = tonumber(playtimeData[1].total_seconds) or 0
        end
        if PlayerLoginTime[passport] then
            playTime = playTime + (os.time() - PlayerLoginTime[passport])
        end
        local isOnline = vRP.Source(passport) and true or false
        if isOnline then onlineCount = onlineCount + 1 end
        local rankLevel = tonumber(member.rank) or (#orgConfig.hierarchy)
        local rankName = orgConfig.hierarchy[rankLevel] and orgConfig.hierarchy[rankLevel].name or "Sem Cargo"
        if requestPassport and requestPassport == passport then
            userRankName = rankName
            userRankLevel = rankLevel
            -- Montar lista de permissões efetivas do visualizador
            local hierarchyEntry = orgConfig.hierarchy[rankLevel]
            if hierarchyEntry and hierarchyEntry.permissions then
                viewerPermissions = hierarchyEntry.permissions
            else
                viewerPermissions = {}
            end
        end
        local hiredDate = tonumber(member.hired_date) or 0
        if hiredDate <= 0 then hiredDate = os.time() end
        local lastLogin = tonumber(member.last_login) or 0
        if lastLogin <= 0 then lastLogin = os.time() end
        table.insert(membersList, {
            id = passport,
            passport = passport,
            name = identity and (identity.name .. " " .. identity.name2) or "Desconhecido",
            rank = rankName,
            rankLevel = rankLevel,
            hired_date = hiredDate,
            joinDate = hiredDate,
            last_login = lastLogin,
            lastLogin = lastLogin,
            farm_progress = stats[1] and stats[1].farm_progress or 0,
            playTime = playTime,
            online = isOnline
        })
    end

    -- Logs do baú
    local chestLogs = {}
    for _, log in pairs(chestLogsRaw) do
        local identity = vRP.Identity(log.passport)
        local Split = splitString(log.item, "-")
        local cleanSpawn = Split[1]
        table.insert(chestLogs, {
            passport = log.passport,
            name = identity and (identity.name .. " " .. identity.name2) or "Desconhecido",
            chestType = log.chest_type or "Normal",
            action = log.action,
            item = cleanSpawn,
            itemName = log.item_name or cleanSpawn,
            amount = log.amount,
            date = log.date
        })
    end

    local canManage = false
    if requestPassport then
        canManage = HasPermission(requestPassport, org, "promote") or HasPermission(requestPassport, org, "demote") or HasPermission(requestPassport, org, "hire") or vRP.HasPermission(requestPassport, Config.AdminPermission)
    end

    return {
        org = org,
        name = orgConfig.name,
        orgName = orgConfig.name,
        type = orgConfig.type,
        hierarchy = orgConfig.hierarchy,
        members = membersList,
        bank = bank[1] and bank[1].balance or 0,
        transactions = transactions,
        chestLogs = chestLogs,
        ranking = ranking,
        maxMembers = orgConfig.maxMembers or 50,
        totalMembers = #membersList,
        onlineMembers = onlineCount,
        canManage = canManage,
        userRank = userRankName,
        userRankLevel = userRankLevel,
        viewerRoleName = userRankName,
        viewerPermissions = viewerPermissions,
        radioFrequency = orgConfig.radioFrequency or "100.0"
    }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTRATAR MEMBRO
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.HireMember(org, targetPassport)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "hire") then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end
    
    -- Verificar blacklist (remove automaticamente se já expirou)
    local blacklist = NormalizeBlacklist(targetPassport)
    if blacklist then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Este jogador está na blacklist.")
        return { success = false, message = "Jogador na blacklist" }
    end
    
    -- Verificar se já é membro
    local existingMember = vRP.Query("wn_org/GetMember", { passport = targetPassport })
    if existingMember[1] then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Este jogador já pertence a uma organização.")
        return { success = false, message = "Já é membro" }
    end
    
    -- Verificar limite de membros
    local members = vRP.Query("wn_org/GetOrgMembers", { org = org })
    if #members >= Config.Organizations[org].maxMembers then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Limite de membros atingido.")
        return { success = false, message = "Limite atingido" }
    end
    
    -- Verificar se o jogador está online
    local targetSource = vRP.Source(targetPassport)
    if not targetSource then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Jogador não está online.")
        return { success = false, message = "Jogador offline" }
    end
    
    -- Pedir confirmação ao jogador
    local identity = vRP.Identity(Passport)
    local orgName = Config.Organizations[org].name
    local request = vRP.Request(targetSource, "Proposta de "..orgName, identity.name.." "..identity.name2.." está te oferecendo um contrato para trabalhar na organização "..orgName..". Deseja aceitar?", 30)
    
    if request then
        -- Contratar
        local lowestRank = #Config.Organizations[org].hierarchy
        vRP.Query("wn_org/AddMember", {
            passport = targetPassport,
            org = org,
            rank = lowestRank,
            hired_date = os.time(),
            hired_by = Passport
        })
        SetOrgRank(targetPassport, org, lowestRank)
        
        -- Adicionar permissão VRP
        local hierarchyData = Config.Organizations[org].hierarchy[lowestRank]
        if hierarchyData and hierarchyData.onService then
            vRP.SetPermission(targetPassport, hierarchyData.onService)
        end
        
        local targetIdentity = vRP.Identity(targetPassport)
        TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você contratou " .. targetIdentity.name .. " " .. targetIdentity.name2)
        TriggerClientEvent("wn_org:Notify", targetSource, "sucesso", "Você foi contratado para " .. Config.Organizations[org].name)

        sendOrgActionLog("contract", "MEMBRO CONTRATADO", 5763719, Passport, targetPassport, org, {
            { name = "🪪 Cargo", value = tostring((Config.Organizations[org].hierarchy[lowestRank] and Config.Organizations[org].hierarchy[lowestRank].name) or lowestRank), inline = false }
        })
        
        -- Retornar dados atualizados
        local updatedData = wnORG.GetOrganizationData(org, Passport)
        return { success = true, message = "Membro contratado", orgData = updatedData }
    else
        TriggerClientEvent("wn_org:Notify", source, "negado", "O jogador recusou a proposta.")
        return { success = false, message = "Proposta recusada" }
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEMITIR MEMBRO
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.FireMember(org, targetPassport, reason)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "fire") then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end

    local member = vRP.Query("wn_org/GetMember", { passport = targetPassport })
    if not member[1] then
        return { success = false, message = "Membro não encontrado" }
    end
    
    vRP.Query("wn_org/RemoveMember", { passport = targetPassport, org = org })
    vRP.RemovePermission(targetPassport, org)
    RemoveOrgRank(targetPassport, org)

    if Config.Blacklist and Config.Blacklist.enabled then
        local expireDate = os.time() + ((Config.Blacklist.days or 2) * 86400)
        vRP.Query("wn_org/RemoveBlacklist", { passport = targetPassport })
        vRP.Query("wn_org/AddBlacklist", {
            passport = targetPassport,
            org = org,
            reason = reason or "Demitido da organização",
            added_by = Passport,
            expire_date = expireDate
        })
    end
    
    local identity = vRP.Identity(targetPassport)
    local fullName = identity and ((identity.name or "") .. " " .. (identity.name2 or "")) or ("Passaporte " .. tostring(targetPassport))
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você demitiu " .. fullName)
    
    local targetSource = vRP.Source(targetPassport)
    if targetSource then
        TriggerClientEvent("wn_org:Notify", targetSource, "aviso", "Você foi demitido de " .. Config.Organizations[org].name .. ". Motivo: " .. (reason or "Sem motivo"))
    end

    sendOrgActionLog("fire", "MEMBRO DEMITIDO", 15548997, Passport, targetPassport, org, {
        { name = "📝 Motivo", value = tostring(reason or "Sem motivo"), inline = false },
        { name = "⛔ Blacklist", value = (Config.Blacklist and Config.Blacklist.enabled) and "Aplicada automaticamente" or "Desativada", inline = false }
    })
    
    local updatedData = wnORG.GetOrganizationData(org, Passport)
    return { success = true, message = "Membro demitido e blacklistado", orgData = updatedData }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROMOVER MEMBRO
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.PromoteMember(org, targetPassport)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "promote") then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end
    
    -- Impedir que promova a si mesmo (exceto admin)
    if Passport == targetPassport and not vRP.HasPermission(Passport, Config.AdminPermission) then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Você não pode promover a si mesmo.")
        return { success = false, message = "Não pode promover a si mesmo" }
    end
    
    local member = vRP.Query("wn_org/GetMember", { passport = targetPassport })
    if not member[1] then
        return { success = false, message = "Membro não encontrado" }
    end
    
    local currentRank = member[1].rank
    if currentRank <= 1 then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Este membro já está no cargo máximo.")
        return { success = false, message = "Cargo máximo" }
    end
    
    local newRank = currentRank - 1
    
    -- Remover permissão antiga e adicionar nova
    local oldHierarchy = Config.Organizations[org].hierarchy[currentRank]
    local newHierarchy = Config.Organizations[org].hierarchy[newRank]
    
    if oldHierarchy and oldHierarchy.onService then
        vRP.RemovePermission(targetPassport, oldHierarchy.onService)
    end
    
    if newHierarchy and newHierarchy.onService then
        vRP.SetPermission(targetPassport, newHierarchy.onService)
    end
    
    vRP.Query("wn_org/UpdateRank", { passport = targetPassport, org = org, rank = newRank })
    SetOrgRank(targetPassport, org, newRank)
    
    local identity = vRP.Identity(targetPassport)
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você promoveu " .. identity.name .. " " .. identity.name2)
    
    local targetSource = vRP.Source(targetPassport)
    if targetSource then
        TriggerClientEvent("wn_org:Notify", targetSource, "sucesso", "Você foi promovido para " .. Config.Organizations[org].hierarchy[newRank].name)
    end

    sendOrgActionLog("promote", "MEMBRO PROMOVIDO", 3066993, Passport, targetPassport, org, {
        { name = "⬆️ Cargo anterior", value = tostring((oldHierarchy and oldHierarchy.name) or currentRank), inline = false },
        { name = "⭐ Novo cargo", value = tostring((newHierarchy and newHierarchy.name) or newRank), inline = false }
    })
    
    -- Retornar dados atualizados
    local updatedData = wnORG.GetOrganizationData(org, Passport)
    return { success = true, message = "Membro promovido", orgData = updatedData }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REBAIXAR MEMBRO
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.DemoteMember(org, targetPassport)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "demote") then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end
    
    -- Impedir que rebaixe a si mesmo (exceto admin)
    if Passport == targetPassport and not vRP.HasPermission(Passport, Config.AdminPermission) then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Você não pode rebaixar a si mesmo.")
        return { success = false, message = "Não pode rebaixar a si mesmo" }
    end
    
    local member = vRP.Query("wn_org/GetMember", { passport = targetPassport })
    if not member[1] then
        return { success = false, message = "Membro não encontrado" }
    end
    
    local currentRank = member[1].rank
    local maxRank = #Config.Organizations[org].hierarchy
    
    if currentRank >= maxRank then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Este membro já está no cargo mínimo.")
        return { success = false, message = "Cargo mínimo" }
    end
    
    local newRank = currentRank + 1
    
    -- Remover permissão antiga e adicionar nova
    local oldHierarchy = Config.Organizations[org].hierarchy[currentRank]
    local newHierarchy = Config.Organizations[org].hierarchy[newRank]
    
    if oldHierarchy and oldHierarchy.onService then
        vRP.RemovePermission(targetPassport, oldHierarchy.onService)
    end
    
    if newHierarchy and newHierarchy.onService then
        vRP.SetPermission(targetPassport, newHierarchy.onService)
    end
    
    vRP.Query("wn_org/UpdateRank", { passport = targetPassport, org = org, rank = newRank })
    SetOrgRank(targetPassport, org, newRank)
    
    local identity = vRP.Identity(targetPassport)
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você rebaixou " .. identity.name .. " " .. identity.name2)
    
    local targetSource = vRP.Source(targetPassport)
    if targetSource then
        TriggerClientEvent("wn_org:Notify", targetSource, "aviso", "Você foi rebaixado para " .. Config.Organizations[org].hierarchy[newRank].name)
    end

    sendOrgActionLog("demote", "MEMBRO REBAIXADO", 15105570, Passport, targetPassport, org, {
        { name = "⬇️ Cargo anterior", value = tostring((oldHierarchy and oldHierarchy.name) or currentRank), inline = false },
        { name = "📌 Novo cargo", value = tostring((newHierarchy and newHierarchy.name) or newRank), inline = false }
    })
    
    -- Retornar dados atualizados
    local updatedData = wnORG.GetOrganizationData(org, Passport)
    return { success = true, message = "Membro rebaixado", orgData = updatedData }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSITAR
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.Deposit(org, amount)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "deposit") then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end
    
    amount = parseInt(amount)
    if amount <= 0 then
        return { success = false, message = "Valor inválido" }
    end
    
    if not vRP.PaymentBank(Passport, amount) then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Você não tem dinheiro suficiente.")
        return { success = false, message = "Saldo insuficiente" }
    end
    
    local bank = vRP.Query("wn_org/GetBank", { org = org })
    local newBalance = (bank[1] and bank[1].balance or 0) + amount
    vRP.Query("wn_org/UpdateBank", { org = org, balance = newBalance })
    
    vRP.Query("wn_org/AddTransaction", {
        org = org,
        type = "deposit",
        amount = amount,
        passport = Passport,
        description = "Depósito realizado",
        date = os.time()
    })
    
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você depositou $" .. amount)
    
    -- Retornar dados atualizados
    local updatedData = wnORG.GetOrganizationData(org, Passport)
    return { success = true, message = "Depósito realizado", newBalance = newBalance, orgData = updatedData }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SACAR
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.Withdraw(org, amount)
    local source = source
    local Passport = vRP.Passport(source)
    
    amount = parseInt(amount)
    if amount <= 0 then
        return { success = false, message = "Valor inválido" }
    end
    
    -- Verificar limite de saque
    local hasSmall = HasPermission(Passport, org, "withdraw_small")
    local hasMedium = HasPermission(Passport, org, "withdraw_medium")
    local hasLarge = HasPermission(Passport, org, "withdraw_large")
    
    if not hasSmall and not hasMedium and not hasLarge then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end
    
    local maxWithdraw = 0
    if hasLarge then
        maxWithdraw = Config.Bank.withdraw_limits.large
    elseif hasMedium then
        maxWithdraw = Config.Bank.withdraw_limits.medium
    elseif hasSmall then
        maxWithdraw = Config.Bank.withdraw_limits.small
    end
    
    if amount > maxWithdraw then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Você só pode sacar até $" .. maxWithdraw)
        return { success = false, message = "Limite excedido" }
    end
    
    local bank = vRP.Query("wn_org/GetBank", { org = org })
    local currentBalance = bank[1] and bank[1].balance or 0
    
    if amount > currentBalance then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Saldo insuficiente no banco da organização.")
        return { success = false, message = "Saldo insuficiente" }
    end
    
    local newBalance = currentBalance - amount
    vRP.Query("wn_org/UpdateBank", { org = org, balance = newBalance })
    vRP.GiveBank(Passport, amount)
    
    vRP.Query("wn_org/AddTransaction", {
        org = org,
        type = "withdraw",
        amount = amount,
        passport = Passport,
        description = "Saque realizado",
        date = os.time()
    })
    
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você sacou $" .. amount)
    
    -- Retornar dados atualizados
    local updatedData = wnORG.GetOrganizationData(org, Passport)
    return { success = true, message = "Saque realizado", newBalance = newBalance, orgData = updatedData }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PIX
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.Pix(org, targetPassport, amount)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "manage_bank") then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end
    
    amount = parseInt(amount)
    if amount <= 0 then
        return { success = false, message = "Valor inválido" }
    end
    
    local bank = vRP.Query("wn_org/GetBank", { org = org })
    local currentBalance = bank[1] and bank[1].balance or 0
    
    if amount > currentBalance then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Saldo insuficiente no banco da organização.")
        return { success = false, message = "Saldo insuficiente" }
    end
    
    local newBalance = currentBalance - amount
    vRP.Query("wn_org/UpdateBank", { org = org, balance = newBalance })
    vRP.GiveBank(targetPassport, amount)
    
    vRP.Query("wn_org/AddTransaction", {
        org = org,
        type = "pix",
        amount = amount,
        passport = Passport,
        description = "PIX para passaporte " .. targetPassport,
        date = os.time()
    })
    
    local identity = vRP.Identity(targetPassport)
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você transferiu $" .. amount .. " para " .. identity.name .. " " .. identity.name2)
    
    local targetSource = vRP.Source(targetPassport)
    if targetSource then
        TriggerClientEvent("wn_org:Notify", targetSource, "sucesso", "Você recebeu $" .. amount .. " de " .. Config.Organizations[org].name)
    end
    
    -- Retornar dados atualizados
    local updatedData = wnORG.GetOrganizationData(org, Passport)
    return { success = true, message = "Transferência realizada", newBalance = newBalance, orgData = updatedData }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAR BLACKLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.AddBlacklist(org, targetPassport, reason, days)
    local source = source
    local Passport = vRP.Passport(source)

    if not Passport or not vRP.HasPermission(Passport, Config.AdminPermission) then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end

    if not targetPassport or not org or not Config.Organizations[org] then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Use um passaporte e organização válidos.")
        return { success = false, message = "Dados inválidos" }
    end

    days = tonumber(days) or tonumber(Config.Blacklist.days) or 2
    if days < 1 then days = tonumber(Config.Blacklist.days) or 2 end

    local expireDate = os.time() + (days * 86400)

    vRP.Query("wn_org/RemoveBlacklist", { passport = targetPassport })
    vRP.Query("wn_org/AddBlacklist", {
        passport = targetPassport,
        org = org,
        reason = reason and reason ~= "" and reason or "Adicionado manualmente",
        added_by = Passport,
        expire_date = expireDate
    })

    local identity = vRP.Identity(targetPassport)
    local fullName = identity and ((identity.name or "") .. " " .. (identity.name2 or "")) or ("Passaporte " .. tostring(targetPassport))
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Você adicionou " .. fullName .. " à blacklist por " .. days .. " dias.")

    sendOrgActionLog("blacklist", "BLACKLIST ADICIONADA", 15158332, Passport, targetPassport, org, {
        { name = "📝 Motivo", value = tostring(reason and reason ~= "" and reason or "Adicionado manualmente"), inline = false },
        { name = "⏳ Duração", value = tostring(days) .. " dia(s)", inline = false }
    })

    return { success = true, message = "Blacklist adicionada" }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER BLACKLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.RemoveBlacklist(targetPassport)
    local source = source
    local Passport = vRP.Passport(source)

    if not Passport or not vRP.HasPermission(Passport, Config.AdminPermission) then
        NotifyNoPermission(source)
        return { success = false, message = "Sem permissão" }
    end

    if not targetPassport then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Passaporte inválido.")
        return { success = false, message = "Passaporte inválido" }
    end
    
    vRP.Query("wn_org/RemoveBlacklist", { passport = targetPassport })
    
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Blacklist removida com sucesso!")

    sendOrgActionLog("blacklist", "BLACKLIST REMOVIDA", 5763719, Passport, targetPassport, "N/A", {
        { name = "🛠️ Tipo", value = "Remoção manual por admin", inline = false }
    })
    
    return { success = true, message = "Blacklist removida" }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAR RÁDIO PARA TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.ConfigRadioForAll(org, frequency)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "all") and not vRP.HasPermission(Passport, Config.AdminPermission) then
        NotifyNoPermission(source)
        return { success = false }
    end
    
    local members = vRP.Query("wn_org/GetOrgMembers", { org = org })
    local count = 0
    
    for _, member in pairs(members) do
        local memberSource = vRP.Source(member.passport)
        if memberSource then
            -- Configurar rádio com pma-voice
            TriggerClientEvent("wn_org:SetRadioFrequency", memberSource, frequency)
            count = count + 1
        end
    end
    
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Rádio configurada para "..count.." membros online!")
    return { success = true }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SALVAR UNIFORME (Líder veste e salva)
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.SaveUniform(org)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "all") and not vRP.HasPermission(Passport, Config.AdminPermission) then
        NotifyNoPermission(source)
        return { success = false }
    end
    
    -- Buscar a roupa atual do líder usando callback do cliente
    local customization = vCLIENT.GetCurrentClothes(source)
    if not customization then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Erro ao obter suas roupas.")
        return { success = false }
    end
    
    -- Salvar no banco de dados
    local customJson = json.encode(customization)
    vRP.Query("wn_org/SaveUniform", { org = org, customization = customJson })
    
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Uniforme salvo com sucesso!")
    return { success = true }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAR ROUPAS PARA TODOS (Aplicar uniforme salvo)
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.ConfigClothesForAll(org)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not HasPermission(Passport, org, "all") and not vRP.HasPermission(Passport, Config.AdminPermission) then
        NotifyNoPermission(source)
        return { success = false }
    end
    
    -- Buscar uniforme salvo
    local uniform = vRP.Query("wn_org/GetUniform", { org = org })
    if not uniform[1] or not uniform[1].customization then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Nenhum uniforme foi salvo ainda! Vista um uniforme e clique na engrenagem para salvar.")
        return { success = false }
    end
    
    local customization = json.decode(uniform[1].customization)
    local members = vRP.Query("wn_org/GetOrgMembers", { org = org })
    local count = 0
    
    for _, member in pairs(members) do
        local memberSource = vRP.Source(member.passport)
        if memberSource then
            -- Aplicar o uniforme salvo
            TriggerClientEvent("wn_org:ApplyClothes", memberSource, customization)
            TriggerClientEvent("wn_org:Notify", memberSource, "sucesso", "Uniforme da "..Config.Organizations[org].name.." aplicado!")
            count = count + 1
        end
    end
    
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Uniforme aplicado para "..count.." membros online!")
    return { success = true }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- APLICAR UNIFORME (Quando membro clica no card)
-----------------------------------------------------------------------------------------------------------------------------------------
function wnORG.ApplyUniform(org)
    local source = source
    local Passport = vRP.Passport(source)
    
    -- Buscar uniforme salvo
    local uniform = vRP.Query("wn_org/GetUniform", { org = org })
    if not uniform[1] or not uniform[1].customization then
        TriggerClientEvent("wn_org:Notify", source, "negado", "Nenhum uniforme foi configurado ainda!")
        return { success = false }
    end
    
    -- Aplicar o uniforme
    local customization = json.decode(uniform[1].customization)
    TriggerClientEvent("wn_org:ApplyClothes", source, customization)
    
    TriggerClientEvent("wn_org:Notify", source, "sucesso", "Uniforme aplicado com sucesso!")
    return { success = true }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE TEMPO JOGADO
-----------------------------------------------------------------------------------------------------------------------------------------
-- Quando o jogador entra, salvar o timestamp
AddEventHandler("Connect", function(Passport, source)
    vRP.Query("wn_org/UpdateLastLogin", { passport = Passport, last_login = os.time() })
    PlayerLoginTime[Passport] = os.time()
end)

-- Quando o jogador sai, calcular e salvar o tempo jogado
AddEventHandler("Desconnect", function(Passport, source)
    if PlayerLoginTime[Passport] then
        local sessionTime = os.time() - PlayerLoginTime[Passport]
        
        -- Buscar tempo total atual
        local currentData = vRP.Query("wn_org/GetPlaytime", { passport = Passport })
        local totalSeconds = 0
        if currentData[1] then
            totalSeconds = tonumber(currentData[1].total_seconds) or 0
        end
        
        -- Adicionar tempo desta sessão
        totalSeconds = totalSeconds + sessionTime
        
        -- Salvar no banco
        vRP.Query("wn_org/UpdatePlaytime", {
            passport = Passport,
            total_seconds = totalSeconds,
            last_update = os.time()
        })
        
        PlayerLoginTime[Passport] = nil
    end
end)

-- Salvar tempo a cada 5 minutos para jogadores online
CreateThread(function()
    while true do
        Wait(300000) -- 5 minutos
        
        for Passport, loginTime in pairs(PlayerLoginTime) do
            local sessionTime = os.time() - loginTime
            
            -- Buscar tempo total atual
            local currentData = vRP.Query("wn_org/GetPlaytime", { passport = Passport })
            local totalSeconds = 0
            if currentData[1] then
                totalSeconds = tonumber(currentData[1].total_seconds) or 0
            end
            
            -- Adicionar tempo desta sessão
            totalSeconds = totalSeconds + sessionTime
            
            -- Salvar no banco
            vRP.Query("wn_org/UpdatePlaytime", {
                passport = Passport,
                total_seconds = totalSeconds,
                last_update = os.time()
            })
            
            -- Resetar contador
            PlayerLoginTime[Passport] = os.time()
        end
    end
end)


RegisterCommand("syncorgs", function(source)
    local Passport = vRP.Passport(source)
    if source == 0 or (Passport and vRP.HasGroup(Passport,"Admin")) then
        SyncOrgPermissionsFromMembers()
        if source > 0 then
            TriggerClientEvent("Notify", source, "Sucesso", "Organizações sincronizadas com a entitydata.", "verde", 5000)
        else
            print("^2[wn-org]^7 organizações sincronizadas com sucesso.")
        end
    end
end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(3000)
        SyncOrgPermissionsFromMembers()
        print("^2[wn-org]^7 sync inicial de organizações concluído.")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOK PARA LOGS DO BAÚ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("wn_org:ChestLog")
AddEventHandler("wn_org:ChestLog", function(playerSource, chestName, action, item, itemDisplayName, amount)
    local Passport = vRP.Passport(playerSource)
    
    if not Passport or not chestName or not action or not item or not amount then 
        return 
    end
    
    -- Verificar se o baú pertence a alguma organização e detectar o tipo
    local orgName = nil
    local chestType = "Normal"
    
    -- Verificar se é Manager:
    if string.sub(chestName, 1, 8) == "Manager:" then
        orgName = string.sub(chestName, 9)
        chestType = "Gerente"
    -- Verificar se é Normal:
    elseif string.sub(chestName, 1, 7) == "Normal:" then
        orgName = string.sub(chestName, 8)
        chestType = "Normal"
    -- Verificar se é Leader:
    elseif string.sub(chestName, 1, 7) == "Leader:" then
        orgName = string.sub(chestName, 8)
        chestType = "Líder"
    else
        -- Verificar se o nome do baú corresponde a alguma organização configurada
        for org, config in pairs(Config.Organizations) do
            if chestName == org or chestName == config.name then
                orgName = org
                chestType = "Facção"
                break
            end
        end
    end
    
    -- Se encontrou uma organização, registrar o log
    if orgName and Config.Organizations[orgName] then
        vRP.Query("wn_org/AddChestLog", {
            org = orgName,
            passport = Passport,
            chest_type = chestType,
            action = action,
            item = item,
            item_name = itemDisplayName or "Desconhecido",
            amount = amount,
            date = os.time()
        })
    end
end)
