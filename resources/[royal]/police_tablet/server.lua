local frameworkResource = nil
if GetResourceState("vrp") == "started" then
    frameworkResource = "vrp"
elseif GetResourceState("rp") == "started" then
    frameworkResource = "rp"
end

if module and frameworkResource then
    local okProxy, loadedProxy = pcall(module, frameworkResource, "lib/Proxy")
    if okProxy and loadedProxy then
        Proxy = Proxy or loadedProxy
    end

    local okTunnel, loadedTunnel = pcall(module, frameworkResource, "lib/Tunnel")
    if okTunnel and loadedTunnel then
        Tunnel = Tunnel or loadedTunnel
    end
end

local vRP = Proxy and Proxy.getInterface and Proxy.getInterface("vRP") or nil
if not vRP then
    error(("vRP/Proxy não encontrado. Framework detectado: %s. Ajuste o fxmanifest para carregar o utils.lua correto (@vrp/lib/utils.lua ou @rp/lib/utils.lua)."):format(frameworkResource or "nenhum"))
end

local RequestInterface = Tunnel and Tunnel.getInterface and Tunnel.getInterface("request") or nil

local resourceName = GetCurrentResourceName()
local pendingMemberInvites = {}


local function askPlayerToJoin(source, groupName, role, officerName)
    if source and RequestInterface and RequestInterface.Function then
        local title = "Convite de contratação"
        local message = ("%s convidou você para entrar em %s como %s."):format(
            tostring(officerName ~= nil and officerName ~= "" and officerName or "Um oficial"),
            tostring(groupName ~= nil and groupName ~= "" and groupName or "Corporação"),
            tostring(role ~= nil and role ~= "" and role or "Membro")
        )
        local ok, accepted = pcall(RequestInterface.Function, source, title, message)
        if ok then
            return accepted and true or false, "request"
        end
    end

    return nil, "fallback"
end



local function decodeData(data)
    if type(data) == "table" then return data end
    if type(data) == "string" and data ~= "" then
        local ok, result = pcall(json.decode, data)
        if ok and type(result) == "table" then
            return result
        end
    end
    return {}
end

local function getSData(key)
    if vRP.GetSrvData then return vRP.GetSrvData(key) or "{}" end
    if vRP.GetSData then return vRP.GetSData(key) or "{}" end
    if vRP.getSData then return vRP.getSData(key) or "{}" end
    if vRP.GetServerData then return vRP.GetServerData(key) or "{}" end
    return "{}"
end

local function setSData(key, value)
    if vRP.SetSrvData then return vRP.SetSrvData(key, value) end
    if vRP.SetSData then return vRP.SetSData(key, value) end
    if vRP.setSData then return vRP.setSData(key, value) end
    if vRP.SetServerData then return vRP.SetServerData(key, value) end
    return false
end

local function parseInt(value)
    local number = tonumber(value)
    if number then return math.floor(number) end
    return 0
end

local function sanitizeText(value)
    value = tostring(value or "")
    value = value:gsub("^%s+",""):gsub("%s+$","")
    return value
end

local function safeValue(value, fallback)
    if value == nil or value == "" then return fallback or "---" end
    return tostring(value)
end

local function formatMoney(value)
    value = parseInt(value)
    local formatted = tostring(value)
    while true do
        local changed
        formatted, changed = formatted:gsub("^(%-?%d+)(%d%d%d)", "%1.%2")
        if changed == 0 then break end
    end
    return "R$ "..formatted
end

local function identityByPassport(passport)
    local data = nil
    if vRP.Identity then data = vRP.Identity(passport)
    elseif vRP.UserIdentity then data = vRP.UserIdentity(passport)
    elseif vRP.getUserIdentity then data = vRP.getUserIdentity(passport) end
    return data
end

local function fullName(identity)
    if not identity then return "---" end
    local name = identity.name or identity.Name or identity.firstname or identity.FirstName or ""
    local lastname = identity.name2 or identity.Name2 or identity.lastname or identity.LastName or ""
    local fullname = (tostring(name).." "..tostring(lastname)):gsub("^%s+",""):gsub("%s+$",""):gsub("%s+"," ")
    if fullname == "" then
        fullname = identity.fullname or identity.FullName or "---"
    end
    return fullname
end

local function phoneNumber(identity)
    if not identity then return "---" end
    return safeValue(identity.Phone or identity.phone or identity.telefone or identity.Cellphone or identity.cellphone, "---")
end

local function sexLabel(identity)
    if not identity then return "---" end
    local sex = tostring(identity.Sex or identity.sex or identity.genre or identity.gender or "---")
    if sex == "M" or sex == "m" then return "Masculino" end
    if sex == "F" or sex == "f" then return "Feminino" end
    return sex
end

local function tableRows(query, params)
    local ok, result = pcall(function()
        return MySQL.query.await(query, params or {})
    end)
    if ok and result then return result end
    print(("[%s] SQL query error: %s"):format(resourceName, result))
    return {}
end

local function tableSingle(query, params)
    local ok, result = pcall(function()
        return MySQL.single.await(query, params or {})
    end)
    if ok then return result end
    print(("[%s] SQL single error: %s"):format(resourceName, result))
    return nil
end

local function tableInsert(query, params)
    local ok, result = pcall(function()
        return MySQL.insert.await(query, params or {})
    end)
    if ok then return result end
    print(("[%s] SQL insert error: %s"):format(resourceName, result))
    return nil
end

local function tableUpdate(query, params)
    local ok, result = pcall(function()
        return MySQL.update.await(query, params or {})
    end)
    if ok then return result end
    print(("[%s] SQL update error: %s"):format(resourceName, result))
    return 0
end

local function getActiveBlacklist(passport)
    passport = parseInt(passport)
    if passport <= 0 then return nil end

    local row = tableSingle([[
        SELECT id, passport, org, reason, added_by, expire_date
        FROM wn_org_blacklist
        WHERE passport = ?
          AND (expire_date IS NULL OR expire_date >= NOW())
        ORDER BY expire_date DESC, id DESC
        LIMIT 1
    ]], { passport })

    return row
end

local function addOrgBlacklist(passport, orgName, reason, addedBy)
    passport = parseInt(passport)
    addedBy = parseInt(addedBy)
    if passport <= 0 then return false end

    local existing = getActiveBlacklist(passport)
    if existing then
        tableUpdate([[
            UPDATE wn_org_blacklist
            SET org = ?, reason = ?, added_by = ?, expire_date = DATE_ADD(NOW(), INTERVAL 7 DAY)
            WHERE id = ?
        ]], {
            safeValue(orgName, "Desconhecida"),
            safeValue(reason, "Exonerado da organização"),
            addedBy > 0 and addedBy or nil,
            existing.id
        })
        return true
    end

    local inserted = tableInsert([[
        INSERT INTO wn_org_blacklist (passport, org, reason, added_by, expire_date)
        VALUES (?, ?, ?, ?, DATE_ADD(NOW(), INTERVAL 7 DAY))
    ]], {
        passport,
        safeValue(orgName, "Desconhecida"),
        safeValue(reason, "Exonerado da organização"),
        addedBy > 0 and addedBy or nil
    })

    return inserted ~= nil
end


local function setPlayerPrisonState(source, status)
    if source and Player(source) and Player(source).state then
        Player(source).state.Prison = status and true or false
    end
    TriggerClientEvent("wn_prisoncmd:setPrisonState", source, status and true or false)
end

local function sendPlayerToPrison(source)
    if not source then return end
    TriggerClientEvent("wn_prisoncmd:teleportToPrison", source)
    setPlayerPrisonState(source, true)
end

local function getUserSource(passport)
    if vRP.Source then return vRP.Source(passport) end
    if vRP.getUserSource then return vRP.getUserSource(passport) end
    return nil
end

local function getPassport(source)
    if vRP.Passport then return vRP.Passport(source) end
    if vRP.getUserId then return vRP.getUserId(source) end
    return nil
end

local function normalizePermissionEntry(entry)
    local value = parseInt(entry)
    if value <= 0 then return nil, nil end

    local passport = parseInt(getPassport(value))
    if passport > 0 then
        return value, passport
    end

    local source = getUserSource(value)
    if source then
        return source, value
    end

    return nil, nil
end

local function getPendingInvite(passport)
    local invite = pendingMemberInvites[tostring(parseInt(passport))]
    if invite and invite.expiresAt and invite.expiresAt < os.time() then
        pendingMemberInvites[tostring(parseInt(passport))] = nil
        return nil
    end
    return invite
end

local function clearPendingInvite(passport)
    pendingMemberInvites[tostring(parseInt(passport))] = nil
end

local function createPendingInvite(passport, data)
    data = data or {}
    data.expiresAt = os.time() + parseInt(data.timeout or 20)
    pendingMemberInvites[tostring(parseInt(passport))] = data
    return data
end

local function getUserGroups(passport)
    if vRP.UserGroups then return vRP.UserGroups(passport) or {} end
    if vRP.getUserGroups then return vRP.getUserGroups(passport) or {} end
    return {}
end

local function hasGroup(passport, group)
    if vRP.HasGroup then return vRP.HasGroup(passport, group) end
    if vRP.hasPermission then return vRP.hasPermission(passport, group) end
    local groups = getUserGroups(passport)
    return groups[group] ~= nil
end

local function extractHierarchyFromGroups(passport, policeData)
    local groups = getUserGroups(passport)
    local groupName = tostring((policeData and (policeData.groupName or policeData.permissionKey)) or "")

    if type(groups) ~= "table" or groupName == "" then
        return nil
    end

    local direct = groups[groupName]
    if type(direct) == "number" or type(direct) == "string" then
        local value = parseInt(direct)
        if value > 0 then return value end
    elseif type(direct) == "table" then
        local value = parseInt(direct.hierarchy or direct.Hierarchy or direct.level or direct.Level or direct.rank or direct.Rank or direct[1])
        if value > 0 then return value end
    elseif direct == true then
        return nil
    end

    if policeData and type(policeData.hierarchy) == "table" then
        for level, label in pairs(policeData.hierarchy) do
            for key in pairs(groups) do
                if tostring(key):lower() == tostring(label):lower() then
                    local parsed = parseInt(level)
                    if parsed > 0 then return parsed end
                end
            end
        end
    end

    return nil
end

local function tryGetBank(passport)
    if vRP.GetBank then return parseInt(vRP.GetBank(passport) or 0) end
    if vRP.getBank then return parseInt(vRP.getBank(passport) or 0) end
    if vRP.GetMoneyBank then return parseInt(vRP.GetMoneyBank(passport) or 0) end
    return 0
end

local function paymentFull(passport, amount)
    amount = parseInt(amount)
    if amount <= 0 then return false end
    if vRP.PaymentFull then return vRP.PaymentFull(passport, amount) end
    if vRP.TryPayment then return vRP.TryPayment(passport, amount) end
    if vRP.tryFullPayment then return vRP.tryFullPayment(passport, amount) end
    return false
end

local function giveBank(passport, amount)
    amount = parseInt(amount)
    if amount <= 0 then return false end
    if vRP.GiveBank then vRP.GiveBank(passport, amount) return true end
    if vRP.addBank then vRP.addBank(passport, amount) return true end
    if vRP.GiveMoneyBank then vRP.GiveMoneyBank(passport, amount) return true end
    return false
end

local function getGroupConfig(groupName)
    if type(vRP.Groups) == "table" and vRP.Groups[groupName] then
        return vRP.Groups[groupName]
    end

    if type(Groups) == "table" and Groups[groupName] then
        return Groups[groupName]
    end

    if type(vRP.Groups) == "function" then
        local ok, result = pcall(vRP.Groups, groupName)
        if ok and type(result) == "table" then
            return result
        end
    end

    return nil
end

local function getHierarchyName(groupName, level, policeData)
    level = parseInt(level)

    if policeData and type(policeData.hierarchy) == "table" then
        return policeData.hierarchy[level] or "Sem cargo"
    end

    local cfg = getGroupConfig(groupName)
    if cfg and type(cfg.Hierarchy) == "table" then
        return cfg.Hierarchy[level] or "Sem cargo"
    end

    return "Sem cargo"
end

local function tryApplyVRPGroupHierarchy(passport, policeData, hierarchy)
    -- Desativado por seguranca nesta base.
    -- A fonte principal continua sendo a entitydata (Permissions:<org>)
    -- e a tabela police_tablet_members.
    return false
end

local function getPolicePermissions(policeData, section)
    if not policeData or type(policeData.permissions) ~= "table" then
        return {}
    end
    return policeData.permissions[section] or {}
end

local function readPermissionData(permissionKey)
    local entityName = "Permissions:" .. tostring(permissionKey or "")

    local row = tableSingle("SELECT Information FROM entitydata WHERE Name = ? LIMIT 1", { entityName })
    if row and row.Information ~= nil then
        return decodeData(row.Information)
    end

    return decodeData(getSData(entityName))
end

local function savePermissionData(permissionKey, data)
    local entityName = "Permissions:" .. tostring(permissionKey or "")
    local payload = json.encode(data or {})

    local updated = tableUpdate("UPDATE entitydata SET Information = ? WHERE Name = ?", { payload, entityName })
    if updated and updated > 0 then
        return true
    end

    local inserted = tableInsert("INSERT INTO entitydata (Name, Information) VALUES (?, ?)", { entityName, payload })
    if inserted then
        return true
    end

    return setSData(entityName, payload)
end

local function getOtherOrgMembership(targetPassport, currentPermissionKey)
    targetPassport = tostring(parseInt(targetPassport))
    currentPermissionKey = tostring(currentPermissionKey or "")

    if targetPassport == "0" or targetPassport == "" then
        return nil
    end

    local exactRows = tableRows([[
        SELECT Name, Information
        FROM entitydata
        WHERE Name LIKE 'Permissions:%'
          AND JSON_VALID(Information)
          AND JSON_EXTRACT(Information, CONCAT('$."', ?, '"')) IS NOT NULL
    ]], { targetPassport })

    local function inspectRows(rows)
        for _, row in ipairs(rows or {}) do
            local name = tostring(row.Name or row.name or "")
            local permissionKey = name:gsub('^Permissions:', '')

            if permissionKey ~= "" and permissionKey ~= currentPermissionKey and permissionKey ~= "Admin" then
                local data = decodeData(row.Information or row.information or "{}")
                local hierarchy = parseInt(data[targetPassport])

                if hierarchy > 0 then
                    return {
                        permissionKey = permissionKey,
                        hierarchy = hierarchy,
                        entityName = name
                    }
                end
            end
        end
        return nil
    end

    local found = inspectRows(exactRows)
    if found then
        return found
    end

    local rows = tableRows([[
        SELECT Name, Information
        FROM entitydata
        WHERE Name LIKE 'Permissions:%'
    ]])

    found = inspectRows(rows)
    if found then
        return found
    end

    local groups = getUserGroups(targetPassport)
    for groupName in pairs(groups or {}) do
        local normalized = tostring(groupName or "")
        if normalized ~= "" and normalized ~= currentPermissionKey and normalized ~= "Admin" then
            if Config and Config.Polices then
                for _, policeData in pairs(Config.Polices) do
                    local permissionKey = tostring(policeData.permissionKey or "")
                    local cfgGroupName = tostring(policeData.groupName or permissionKey)
                    if normalized == permissionKey or normalized == cfgGroupName then
                        return {
                            permissionKey = permissionKey ~= "" and permissionKey or normalized,
                            hierarchy = 0,
                            entityName = "group:" .. normalized
                        }
                    end
                end
            end

            if normalized:find("Policia", 1, true) or normalized:find("PM", 1, true) then
                return {
                    permissionKey = normalized,
                    hierarchy = 0,
                    entityName = "group:" .. normalized
                }
            end
        end
    end

    return nil
end

local function resolvePolice(passport)
    passport = tostring(passport)

    for policeId, policeData in pairs(Config.Polices) do
        local permissionKey = policeData.permissionKey or policeId
        local groupName = policeData.groupName or permissionKey

        local permissions = readPermissionData(permissionKey)
        local hierarchy = permissions[passport]

        if hierarchy ~= nil then
            hierarchy = parseInt(hierarchy)
            return policeId, policeData, groupName, {
                hierarchy = hierarchy,
                role = getHierarchyName(groupName, hierarchy, policeData)
            }
        end

        if hasGroup(passport, groupName) then
            local hierarchy = extractHierarchyFromGroups(passport, policeData)
            if hierarchy and hierarchy > 0 then
                if parseInt(permissions[passport]) ~= hierarchy then
                    permissions[passport] = hierarchy
                    savePermissionData(permissionKey, permissions)
                end

                return policeId, policeData, groupName, {
                    hierarchy = hierarchy,
                    role = getHierarchyName(groupName, hierarchy, policeData)
                }
            end

            local memberRow = tableSingle("SELECT hierarchy, role FROM police_tablet_members WHERE police_id = ? AND passport = ?", { policeId, passport })
            if memberRow and parseInt(memberRow.hierarchy) > 0 then
                return policeId, policeData, groupName, {
                    hierarchy = parseInt(memberRow.hierarchy),
                    role = safeValue(memberRow.role, getHierarchyName(groupName, parseInt(memberRow.hierarchy), policeData))
                }
            end
        end
    end

    return nil
end

local function hasPolicePermission(passport, section, action)
    local policeId, policeData, _, groupInfo = resolvePolice(passport)
    if not policeId or not policeData or not groupInfo then
        return false, nil, nil, nil
    end

    local hierarchy = parseInt(groupInfo.hierarchy)
    local sectionPermissions = getPolicePermissions(policeData, section)
    local required = parseInt(sectionPermissions[action] or 999)

    return hierarchy <= required, policeId, policeData, groupInfo
end

local function notify(source, message, color)
    TriggerClientEvent("Notify", source, color or "amarelo", message, 5000)
end

local function upsertMember(passport, policeId, role, hierarchy)
    local identity = identityByPassport(passport)
    tableInsert([[ 
        INSERT INTO police_tablet_members (police_id, passport, name, role, hierarchy, last_seen)
        VALUES (?, ?, ?, ?, ?, NOW())
        ON DUPLICATE KEY UPDATE
            name = VALUES(name),
            role = VALUES(role),
            hierarchy = VALUES(hierarchy),
            last_seen = NOW()
    ]], {
        policeId,
        passport,
        fullName(identity),
        safeValue(role, "Sem cargo"),
        parseInt(hierarchy)
    })
end

local function syncMembersFromBase(policeId)
    local policeData = Config.Polices[policeId]
    if not policeData then return end

    local permissionData = readPermissionData(policeData.permissionKey)
    local expected = {}

    for passport, hierarchy in pairs(permissionData or {}) do
        local targetPassport = parseInt(passport)
        local targetHierarchy = parseInt(hierarchy)

        if targetPassport > 0 and targetHierarchy > 0 and policeData.hierarchy[targetHierarchy] then
            expected[tostring(targetPassport)] = true
            upsertMember(
                targetPassport,
                policeId,
                getHierarchyName(policeData.groupName, targetHierarchy, policeData),
                targetHierarchy
            )
        end
    end

    local currentMembers = tableRows([[ 
        SELECT passport
        FROM police_tablet_members
        WHERE police_id = ?
    ]], { policeId })

    for _, row in ipairs(currentMembers or {}) do
        local memberPassport = parseInt(row.passport)
        local memberKey = tostring(memberPassport)

        if memberPassport > 0 and not expected[memberKey] then
            tableUpdate("DELETE FROM police_tablet_members WHERE police_id = ? AND passport = ?", { policeId, memberPassport })
        end
    end
end

local function syncOnlinePolice(policeId)
    local policeData = Config.Polices[policeId]
    if not policeData then return end

    local permissionData = readPermissionData(policeData.permissionKey)

    for passportKey, hierarchyValue in pairs(permissionData) do
        local passport = parseInt(passportKey)
        local hierarchy = parseInt(hierarchyValue)
        local source = getUserSource(passport)

        if passport > 0 and hierarchy > 0 and source then
            upsertMember(passport, policeId, getHierarchyName(policeData.groupName, hierarchy, policeData), hierarchy)
        end
    end
end

local function getPoliceBank(policeId)
    local row = tableSingle("SELECT balance FROM police_tablet_banks WHERE police_id = ?", { policeId })
    if not row then
        tableInsert("INSERT INTO police_tablet_banks (police_id, balance) VALUES (?, 0)", { policeId })
        return 0
    end
    return parseInt(row.balance)
end

local function getDashboard(source, passport, policeId)
    local policeData = Config.Polices[policeId]
    syncMembersFromBase(policeId)
    syncOnlinePolice(policeId)

    local notices = tableRows([[
        SELECT id, title, content, author_name, created_at
        FROM police_tablet_notices
        WHERE police_id = ?
        ORDER BY id DESC
        LIMIT 5
    ]], { policeId })

    local patrol = {}
    local totalOnline = 0
    local permissionData = readPermissionData(policeData.permissionKey)

    for passportKey, hierarchyValue in pairs(permissionData) do
        local officerPassport = parseInt(passportKey)
        local hierarchy = parseInt(hierarchyValue)
        local officerSource = getUserSource(officerPassport)

        if officerPassport > 0 and hierarchy > 0 and officerSource then
            local identity = identityByPassport(officerPassport)
            local onDuty = Config.ServiceChecker(officerSource, officerPassport, policeId)
            totalOnline = totalOnline + 1
            patrol[#patrol + 1] = {
                passport = officerPassport,
                name = fullName(identity),
                role = getHierarchyName(policeData.groupName, hierarchy, policeData),
                hierarchy = hierarchy,
                patrol = onDuty
            }
        end
    end

    table.sort(patrol, function(a, b)
        if a.patrol ~= b.patrol then return a.patrol and not b.patrol end
        return (a.hierarchy or 99) < (b.hierarchy or 99)
    end)

    local _, _, _, myGroupInfo = resolvePolice(passport)

    return {
        police = {
            id = policeId,
            label = policeData.label,
            short = policeData.short,
            color = policeData.color
        },
        player = {
            passport = passport,
            name = fullName(identityByPassport(passport)),
            role = myGroupInfo and myGroupInfo.role or "Sem cargo",
            hierarchy = myGroupInfo and myGroupInfo.hierarchy or 99,
            articlePermissions = {
                create = select(1, hasPolicePermission(passport, "articles", "create")) and true or false,
                edit = select(1, hasPolicePermission(passport, "articles", "edit")) and true or false,
                delete = select(1, hasPolicePermission(passport, "articles", "delete")) and true or false
            },
            boletimPermissions = {
                create = select(1, hasPolicePermission(passport, "boletins", "create")) and true or false,
                edit = select(1, hasPolicePermission(passport, "boletins", "edit")) and true or false,
                delete = select(1, hasPolicePermission(passport, "boletins", "delete")) and true or false
            },
            procuradoPermissions = {
                create = select(1, hasPolicePermission(passport, "procurados", "create")) and true or false,
                delete = select(1, hasPolicePermission(passport, "procurados", "delete")) and true or false
            }
        },
        bankBalance = getPoliceBank(policeId),
        notices = notices,
        patrol = patrol,
        patrolCount = #patrol,
        onlineCount = totalOnline
    }
end

local function getMembers(policeId)
    syncMembersFromBase(policeId)
    syncOnlinePolice(policeId)
    local rows = tableRows([[
        SELECT id, passport, name, role, hierarchy, badge, last_seen
        FROM police_tablet_members
        WHERE police_id = ?
        ORDER BY hierarchy ASC, name ASC
    ]], { policeId })

    for _, row in ipairs(rows) do
        row.online = getUserSource(parseInt(row.passport)) ~= nil
    end

    return rows
end

local function getBankData(policeId)
    return {
        balance = getPoliceBank(policeId),
        history = tableRows([[
            SELECT id, type, amount, description, actor_passport, actor_name, created_at
            FROM police_tablet_bank_transactions
            WHERE police_id = ?
            ORDER BY id DESC
            LIMIT 50
        ]], { policeId })
    }
end

local function getOccurrences(policeId)
    return tableRows([[
        SELECT id, title, suspect_name, officer_name, created_at, status
        FROM police_tablet_occurrences
        WHERE police_id = ?
        ORDER BY id DESC
        LIMIT 100
    ]], { policeId })
end

local function getBoletins(policeId)
    return tableRows([[
        SELECT id, title, involved, officers_involved, description, officer_name, created_at
        FROM police_tablet_boletins
        WHERE police_id = ?
        ORDER BY id DESC
        LIMIT 100
    ]], { policeId })
end


local function getProcurados(policeId)
    return tableRows([[
        SELECT id, police_id, suspect_passport, suspect_name, suspect_age, suspect_sex, suspect_phone, danger_level, reason, photo_url, officer_passport, officer_name, created_at
        FROM police_tablet_procurados
        WHERE police_id = ?
        ORDER BY id DESC
        LIMIT 100
    ]], { policeId })
end

local function getArticles(policeId)
    return tableRows([[
        SELECT id, code, title, description, fine_value, jail_time, created_at
        FROM police_tablet_articles
        WHERE police_id = ? OR is_global = 1
        ORDER BY code ASC, id ASC
    ]], { policeId })
end

local function getCharacterRow(passport)
    local db = Config.Database.identities
    local query = ("SELECT * FROM `%s` WHERE `%s` = ? LIMIT 1"):format(db.table, db.id)
    return tableSingle(query, { passport })
end

local function getPrisonHistory(passport)
    return tableRows([[
        SELECT id, police_id, officer_passport, officer_name, suspect_passport, suspect_name, articles, article_codes, article_titles, total_fine, total_prison, additional_fine, additional_prison, observation, created_at
        FROM police_tablet_prison_history
        WHERE suspect_passport = ?
        ORDER BY id DESC
        LIMIT 50
    ]], { passport })
end

local function getSeizureHistory(passport)
    return tableRows([[
        SELECT id, police_id, officer_passport, officer_name, suspect_passport, suspect_name, item_name, item_amount, observation, created_at
        FROM police_tablet_seizure_history
        WHERE suspect_passport = ?
        ORDER BY id DESC
        LIMIT 50
    ]], { passport })
end

local function buildSelectedArticles(policeId, selected)
    local parsed = {}
    local ids = {}
    if type(selected) ~= "table" then
        selected = {}
    end

    for _, value in ipairs(selected) do
        local articleId = parseInt(type(value) == "table" and (value.id or value.article_id) or value)
        if articleId > 0 and not ids[articleId] then
            ids[articleId] = true
            parsed[#parsed + 1] = articleId
        end
    end

    local rows = {}
    for _, article in ipairs(getArticles(policeId)) do
        if ids[parseInt(article.id)] then
            rows[#rows + 1] = article
        end
    end

    return rows
end

local function registerPrisonAndFine(source, officerPassport, policeId, payload)
    local targetPassport = parseInt(payload.passport)
    if targetPassport <= 0 then
        notify(source, "Passaporte inválido.")
        return
    end

    local identity = identityByPassport(targetPassport)
    local characterRow = getCharacterRow(targetPassport)
    if not identity and not characterRow then
        notify(source, "Cidadão não encontrado.")
        return
    end

    local selectedArticles = buildSelectedArticles(policeId, payload.articles or {})
    local additionalFine = parseInt(payload.additional_fine)
    local additionalPrison = parseInt(payload.additional_prison)
    local observation = safeValue(payload.observation, "---")

    local totalFine = additionalFine
    local totalPrison = additionalPrison
    local articleCodes, articleTitles, articleTextParts = {}, {}, {}

    for _, article in ipairs(selectedArticles) do
        totalFine = totalFine + parseInt(article.fine_value)
        totalPrison = totalPrison + parseInt(article.jail_time)
        articleCodes[#articleCodes + 1] = tostring(article.code or article.id)
        articleTitles[#articleTitles + 1] = tostring(article.title or "Sem título")
        articleTextParts[#articleTextParts + 1] = ("Art. %s - %s"):format(tostring(article.code or article.id), tostring(article.title or "Sem título"))
    end

    if totalPrison <= 0 then
        notify(source, "A pena total precisa ser maior que 0 para registrar a prisão.")
        return
    end

    local currentPrison = parseInt((characterRow and (characterRow.prison or characterRow.Prison)) or 0)
    local currentFine = parseInt((characterRow and (characterRow.fines or characterRow.Fines)) or 0)
    local newPrison = currentPrison + totalPrison
    local newFine = currentFine + totalFine
    local suspectName = fullName(identity or characterRow)
    local officerName = fullName(identityByPassport(officerPassport))
    local fineMessage = (#articleTextParts > 0 and table.concat(articleTextParts, ", ") or "Sem artigos")
    if additionalFine > 0 or additionalPrison > 0 then
        fineMessage = fineMessage .. (" | Adicional: %s meses / %s"):format(additionalPrison, formatMoney(additionalFine))
    end

    local updatedPrison = tableUpdate("UPDATE characters SET prison = ? WHERE id = ?", { newPrison, targetPassport })
    if updatedPrison <= 0 then
        notify(source, "Falha ao registrar prisão no police_system.")
    else
        tableInsert([[
            INSERT INTO police_tablet_prison_history
            (police_id, officer_passport, officer_name, suspect_passport, suspect_name, articles, article_codes, article_titles, total_fine, total_prison, additional_fine, additional_prison, observation)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]], {
            policeId, officerPassport, officerName, targetPassport, suspectName, json.encode(selectedArticles),
            table.concat(articleCodes, ", "), table.concat(articleTitles, ", "), totalFine, totalPrison, additionalFine, additionalPrison, observation
        })

        local targetSource = getUserSource(targetPassport)
        if targetSource then
            sendPlayerToPrison(targetSource)
            TriggerClientEvent("Notify", targetSource, "vermelho", "Você foi preso. Restam " .. newPrison .. " serviços.", 8000)
        end

        notify(source, "Prisão registrada com sucesso.", "verde")
    end

    if totalFine > 0 then
        local insertedFine = tableInsert("INSERT INTO fines (Passport, Name, Date, Hour, Value, Message) VALUES (?, ?, ?, ?, ?, ?)", {
            targetPassport, suspectName, os.date("%d/%m/%Y"), os.date("%H:%M"), totalFine, fineMessage
        })
        if not insertedFine then
            notify(source, "Falha ao registrar multa no police_system.")
        else
            tableUpdate("UPDATE characters SET fines = ? WHERE id = ?", { newFine, targetPassport })
            notify(source, "Multa registrada com sucesso.", "verde")
        end
    end
end

local function registerSeizure(source, officerPassport, policeId, payload)
    local targetPassport = parseInt(payload.passport)
    if targetPassport <= 0 then
        notify(source, "Passaporte inválido.")
        return
    end

    local identity = identityByPassport(targetPassport) or getCharacterRow(targetPassport)
    if not identity then
        notify(source, "Cidadão não encontrado.")
        return
    end

    local inserted = tableInsert([[
        INSERT INTO police_tablet_seizure_history
        (police_id, officer_passport, officer_name, suspect_passport, suspect_name, item_name, item_amount, observation)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ]], {
        policeId, officerPassport, fullName(identityByPassport(officerPassport)), targetPassport, fullName(identity),
        safeValue(payload.item_name, "Não informado"), parseInt(payload.item_amount), safeValue(payload.observation, "---")
    })

    if inserted then
        notify(source, "Apreensão registrada com sucesso.", "verde")
    else
        notify(source, "Falha ao registrar apreensão no police_system.")
    end
end

local function consultPerson(passport)
    passport = parseInt(passport)
    if passport <= 0 then return { found = false } end

    local identity = identityByPassport(passport)
    if not identity then
        local db = Config.Database.identities
        local query = ("SELECT * FROM `%s` WHERE `%s` = ? LIMIT 1"):format(db.table, db.id)
        identity = tableSingle(query, { passport })
    end

    if not identity then return { found = false } end

    local vehicleDb = Config.Database.vehicles
    local vehicles = tableRows(("SELECT `%s` AS model, `%s` AS plate FROM `%s` WHERE `%s` = ? ORDER BY `%s` ASC LIMIT 50")
        :format(vehicleDb.model, vehicleDb.plate, vehicleDb.table, vehicleDb.owner, vehicleDb.model), { passport })

    local characterRow = getCharacterRow(passport) or identity or {}

    return {
        found = true,
        passport = passport,
        name = fullName(identity),
        phone = phoneNumber(identity),
        bank = formatMoney(tryGetBank(passport) > 0 and tryGetBank(passport) or (identity[Config.Database.identities.bank] or 0)),
        sex = sexLabel(identity),
        age = safeValue(characterRow.age or characterRow.Age or identity.age or identity.Age, "---"),
        groups = getUserGroups(passport),
        vehicles = vehicles,
        prison = parseInt(characterRow.prison or characterRow.Prison or 0),
        fines = parseInt(characterRow.fines or characterRow.Fines or 0),
        prisonHistory = getPrisonHistory(passport),
        seizureHistory = getSeizureHistory(passport)
    }
end

local function consultVehicle(search)
    search = sanitizeText(search)
    if search == "" then return { found = false } end

    local vehicleDb = Config.Database.vehicles
    local row = tableSingle(([[
        SELECT `%s` AS owner, `%s` AS model, `%s` AS plate
        FROM `%s`
        WHERE `%s` = ? OR `%s` LIKE ?
        LIMIT 1
    ]]):format(vehicleDb.owner, vehicleDb.model, vehicleDb.plate, vehicleDb.table, vehicleDb.plate, vehicleDb.model), {
        search,
        "%"..search.."%"
    })

    if not row then return { found = false } end

    local identity = identityByPassport(parseInt(row.owner))
    return {
        found = true,
        plate = safeValue(row.plate),
        model = safeValue(row.model),
        ownerPassport = parseInt(row.owner),
        ownerName = fullName(identity)
    }
end

local function sendPayload(source, action, data)
    TriggerClientEvent("police_tablet:payload", source, { action = action, data = data })
end

local function refreshEverything(source, passport, policeId)
    sendPayload(source, "bootstrap", {
        dashboard = getDashboard(source, passport, policeId),
        members = getMembers(policeId),
        bank = getBankData(policeId),
        occurrences = getOccurrences(policeId),
        boletins = getBoletins(policeId),
        procurados = getProcurados(policeId),
        articles = getArticles(policeId)
    })
end

local function updateMemberPermission(policeData, targetPassport, hierarchy)
    local permissionData = readPermissionData(policeData.permissionKey)
    if hierarchy == nil then
        permissionData[tostring(targetPassport)] = nil
    else
        permissionData[tostring(targetPassport)] = parseInt(hierarchy)
    end
    savePermissionData(policeData.permissionKey, permissionData)
    tryApplyVRPGroupHierarchy(targetPassport, policeData, hierarchy)
    local policeId = nil
    for id, data in pairs(Config.Polices or {}) do
        if tostring(data.permissionKey or "") == tostring(policeData.permissionKey or "") then
            policeId = id
            break
        end
    end
    if policeId then
        syncMembersFromBase(policeId)
    end
end

RegisterNetEvent("police_tablet:tryOpen")
AddEventHandler("police_tablet:tryOpen", function()
    local source = source
    local passport = getPassport(source)
    if not passport then return end

    local policeId = resolvePolice(passport)
    if not policeId then
        TriggerClientEvent("police_tablet:openDenied", source, "Você não possui acesso ao tablet policial.")
        return
    end

    TriggerClientEvent("police_tablet:open", source, {
        title = Config.TabletTitle,
        loadingText = Config.LoadingText,
        loadingSubText = Config.LoadingSubText
    })
end)

RegisterNetEvent("police_tablet:requestBootstrap")
AddEventHandler("police_tablet:requestBootstrap", function()
    local source = source
    local passport = getPassport(source)
    if not passport then return end

    local policeId, _, _, groupInfo = resolvePolice(passport)
    if not policeId then return end

    if groupInfo then
        upsertMember(passport, policeId, groupInfo.role, groupInfo.hierarchy)
    end
    refreshEverything(source, passport, policeId)
end)

RegisterNetEvent("police_tablet:request")
AddEventHandler("police_tablet:request", function(action, payload)
    local source = source
    local passport = getPassport(source)
    if not passport then return end

    local policeId, policeData, _, groupInfo = resolvePolice(passport)
    if not policeId then return end
    payload = type(payload) == "table" and payload or {}

    if action == "refreshAll" then
        refreshEverything(source, passport, policeId)
        return
    end

    if action == "deposit" then
        local allowed = hasPolicePermission(passport, "bank", "deposit")
        if not allowed then
            notify(source, "Sem permissão para depositar no banco da corporação.")
            return
        end

        local amount = parseInt(payload.amount)
        if amount <= 0 then
            notify(source, "Digite um valor válido.")
            return
        end

        if not paymentFull(passport, amount) then
            notify(source, "Você não possui dinheiro suficiente.")
            return
        end

        tableUpdate("UPDATE police_tablet_banks SET balance = balance + ? WHERE police_id = ?", { amount, policeId })
        tableInsert([[
            INSERT INTO police_tablet_bank_transactions (police_id, type, amount, description, actor_passport, actor_name)
            VALUES (?, 'deposit', ?, ?, ?, ?)
        ]], { policeId, amount, safeValue(payload.description, "Depósito no caixa da corporação"), passport, fullName(identityByPassport(passport)) })

        sendPayload(source, "bank", getBankData(policeId))
        sendPayload(source, "dashboard", getDashboard(source, passport, policeId))
        notify(source, "Depósito realizado com sucesso.", "verde")
        return
    end

    if action == "withdraw" then
        local allowed = hasPolicePermission(passport, "bank", "withdraw")
        if not allowed then
            notify(source, "Sem permissão para sacar do banco da corporação.")
            return
        end

        local amount = parseInt(payload.amount)
        if amount <= 0 then
            notify(source, "Digite um valor válido.")
            return
        end

        local balance = getPoliceBank(policeId)
        if balance < amount then
            notify(source, "Saldo insuficiente no banco da corporação.")
            return
        end

        if not giveBank(passport, amount) then
            notify(source, "Não foi possível creditar no seu banco. Adapte a função giveBank no server.lua.")
            return
        end

        tableUpdate("UPDATE police_tablet_banks SET balance = balance - ? WHERE police_id = ?", { amount, policeId })
        tableInsert([[
            INSERT INTO police_tablet_bank_transactions (police_id, type, amount, description, actor_passport, actor_name)
            VALUES (?, 'withdraw', ?, ?, ?, ?)
        ]], { policeId, amount, safeValue(payload.description, "Saque do caixa da corporação"), passport, fullName(identityByPassport(passport)) })

        sendPayload(source, "bank", getBankData(policeId))
        sendPayload(source, "dashboard", getDashboard(source, passport, policeId))
        notify(source, "Saque realizado com sucesso.", "verde")
        return
    end

    if action == "transferBank" then
        local allowed = hasPolicePermission(passport, "bank", "transfer")
        if not allowed then
            notify(source, "Sem permissão para transferir do banco da corporação.")
            return
        end

        local targetPassport = parseInt(payload.passport)
        local amount = parseInt(payload.amount)
        if targetPassport <= 0 or amount <= 0 then
            notify(source, "Informe passaporte e valor válidos.")
            return
        end

        local balance = getPoliceBank(policeId)
        if balance < amount then
            notify(source, "Saldo insuficiente no banco da corporação.")
            return
        end

        if not giveBank(targetPassport, amount) then
            notify(source, "Não foi possível transferir para o passaporte informado.")
            return
        end

        tableUpdate("UPDATE police_tablet_banks SET balance = balance - ? WHERE police_id = ?", { amount, policeId })
        tableInsert([[
            INSERT INTO police_tablet_bank_transactions (police_id, type, amount, description, actor_passport, actor_name)
            VALUES (?, 'transfer', ?, ?, ?, ?)
        ]], { policeId, amount, "Transferência para passaporte " .. targetPassport, passport, fullName(identityByPassport(passport)) })

        sendPayload(source, "bank", getBankData(policeId))
        sendPayload(source, "dashboard", getDashboard(source, passport, policeId))
        notify(source, "Transferência realizada com sucesso.", "verde")
        return
    end

    if action == "hireMember" then
        local allowed = hasPolicePermission(passport, "members", "hire")
        if not allowed then
            notify(source, "Sem permissão para contratar.")
            return
        end

        local targetPassport = parseInt(payload.passport)
        if targetPassport <= 0 then
            notify(source, "Informe um passaporte válido.")
            return
        end

        local targetSource = getUserSource(targetPassport)
        if not targetSource then
            notify(source, "O passaporte informado precisa estar online para aceitar a contratação.")
            return
        end

        local targetHierarchy = 0
        for level in pairs(policeData.hierarchy or {}) do
            level = parseInt(level)
            if level > targetHierarchy then
                targetHierarchy = level
            end
        end

        if targetHierarchy <= 0 or not policeData.hierarchy[targetHierarchy] then
            notify(source, "Não foi possível identificar a última hierarquia da corporação.")
            return
        end

        local permissionData = readPermissionData(policeData.permissionKey)
        if parseInt(permissionData[tostring(targetPassport)]) > 0 then
            notify(source, "Este passaporte já faz parte da corporação.")
            return
        end

        local otherOrg = getOtherOrgMembership(targetPassport, policeData.permissionKey)
        if otherOrg then
            notify(source, "Este passaporte já pertence à organização " .. safeValue(otherOrg.permissionKey, "Desconhecida") .. ".", "amarelo")
            return
        end

        local blacklist = getActiveBlacklist(targetPassport)
        if blacklist then
            local orgName = safeValue(blacklist.org, "Desconhecida")
            local expireText = blacklist.expire_date and tostring(blacklist.expire_date) or "sem data"
            notify(source, "Este passaporte está na blacklist da organização " .. orgName .. " até " .. expireText .. ".", "amarelo")
            return
        end

        local officerName = fullName(identityByPassport(passport))
        local roleName = getHierarchyName(policeData.groupName, targetHierarchy, policeData)
        local accepted, mode = askPlayerToJoin(targetSource, policeData.groupName, roleName, officerName)

        if accepted == nil then
            local invite = createPendingInvite(targetPassport, {
                policeId = policeId,
                groupName = policeData.groupName,
                hierarchy = targetHierarchy,
                role = roleName,
                officerPassport = passport,
                officerSource = source,
                officerName = officerName,
                timeout = 20
            })

            TriggerClientEvent("police_tablet:memberInvite", targetSource, {
                policeId = policeId,
                groupName = policeData.groupName,
                role = invite.role,
                officerName = officerName,
                timeout = 20
            })

            notify(source, "Convite enviado. O jogador precisa aceitar para entrar na corporação.", "azul")
            return
        end

        if not accepted then
            notify(source, "O jogador recusou a contratação.", "amarelo")
            notify(targetSource, "Você recusou a contratação.", "amarelo")
            return
        end

        updateMemberPermission(policeData, targetPassport, targetHierarchy)
        upsertMember(targetPassport, policeId, roleName, targetHierarchy)

        notify(targetSource, "Você aceitou a contratação e entrou na corporação como " .. safeValue(roleName, "Membro") .. ".", "verde")
        sendPayload(source, "members", getMembers(policeId))
        notify(source, (mode == "request" and "Contratação aceita com sucesso." or "Contratação concluída com sucesso."), "verde")
        return
    end

    if action == "promoteMember" then
        local allowed = hasPolicePermission(passport, "members", "promote")
        if not allowed then
            notify(source, "Sem permissão para promover.")
            return
        end

        local targetPassport = parseInt(payload.passport)
        local permissionData = readPermissionData(policeData.permissionKey)
        local current = parseInt(permissionData[tostring(targetPassport)])
        if current <= 0 then
            notify(source, "Membro não encontrado na corporação.")
            return
        end

        if current <= 1 then
            notify(source, "Este membro já está na maior hierarquia.")
            return
        end

        current = current - 1
        updateMemberPermission(policeData, targetPassport, current)
        upsertMember(targetPassport, policeId, getHierarchyName(policeData.groupName, current, policeData), current)
        sendPayload(source, "members", getMembers(policeId))
        notify(source, "Membro promovido com sucesso.", "verde")
        return
    end

    if action == "demoteMember" then
        local allowed = hasPolicePermission(passport, "members", "demote")
        if not allowed then
            notify(source, "Sem permissão para rebaixar.")
            return
        end

        local targetPassport = parseInt(payload.passport)
        local permissionData = readPermissionData(policeData.permissionKey)
        local current = parseInt(permissionData[tostring(targetPassport)])
        local maxHierarchy = 0
        for level in pairs(policeData.hierarchy or {}) do
            if parseInt(level) > maxHierarchy then maxHierarchy = parseInt(level) end
        end

        if current <= 0 then
            notify(source, "Membro não encontrado na corporação.")
            return
        end

        if current >= maxHierarchy then
            notify(source, "Este membro já está na menor hierarquia.")
            return
        end

        current = current + 1
        updateMemberPermission(policeData, targetPassport, current)
        upsertMember(targetPassport, policeId, getHierarchyName(policeData.groupName, current, policeData), current)
        sendPayload(source, "members", getMembers(policeId))
        notify(source, "Membro rebaixado com sucesso.", "verde")
        return
    end

    if action == "fireMember" then
        local allowed = hasPolicePermission(passport, "members", "fire")
        if not allowed then
            notify(source, "Sem permissão para exonerar.")
            return
        end

        local targetPassport = parseInt(payload.passport)
        if targetPassport <= 0 then
            notify(source, "Informe um passaporte válido.")
            return
        end

        updateMemberPermission(policeData, targetPassport, nil)
        tableUpdate("DELETE FROM police_tablet_members WHERE police_id = ? AND passport = ?", { policeId, targetPassport })
        addOrgBlacklist(targetPassport, policeData.groupName or policeData.permissionKey or policeId, "Exonerado da organização", passport)
        sendPayload(source, "members", getMembers(policeId))
        notify(source, "Membro exonerado com sucesso e adicionado à blacklist por 7 dias.", "verde")
        return
    end

    if action == "createOccurrence" then
        local allowed = hasPolicePermission(passport, "penal", "createOccurrence")
        if not allowed then
            notify(source, "Sem permissão para cadastrar ocorrência.")
            return
        end

        tableInsert([[
            INSERT INTO police_tablet_occurrences (police_id, title, description, suspect_name, suspect_passport, officer_passport, officer_name, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ]], {
            policeId,
            safeValue(payload.title, "Ocorrência sem título"),
            safeValue(payload.description, "---"),
            safeValue(payload.suspect_name, "Não informado"),
            parseInt(payload.suspect_passport),
            passport,
            fullName(identityByPassport(passport)),
            safeValue(payload.status, "Aberta")
        })

        sendPayload(source, "occurrences", getOccurrences(policeId))
        notify(source, "Ocorrência cadastrada com sucesso.", "verde")
        return
    end

    if action == "createBoletim" then
        local allowed = hasPolicePermission(passport, "boletins", "create")
        if not allowed then
            notify(source, "Sem permissão para cadastrar boletim.")
            return
        end

        tableInsert([[
            INSERT INTO police_tablet_boletins (police_id, title, involved, officers_involved, description, officer_passport, officer_name)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ]], {
            policeId,
            safeValue(payload.title, "Boletim sem título"),
            safeValue(payload.involved, "Não informado"),
            safeValue(payload.officers_involved, "Não informado"),
            safeValue(payload.description, "---"),
            passport,
            fullName(identityByPassport(passport))
        })

        sendPayload(source, "boletins", getBoletins(policeId))
        notify(source, "Boletim registrado com sucesso.", "verde")
        return
    end

    if action == "updateBoletim" then
        local allowed = hasPolicePermission(passport, "boletins", "edit")
        if not allowed then
            notify(source, "Sem permissão para editar boletim.")
            return
        end

        local boletimId = parseInt(payload.boletim_id)
        if boletimId <= 0 then
            notify(source, "Boletim inválido.")
            return
        end

        tableUpdate([[
            UPDATE police_tablet_boletins
            SET title = ?, involved = ?, officers_involved = ?, description = ?
            WHERE id = ? AND police_id = ?
        ]], {
            safeValue(payload.title, "Boletim sem título"),
            safeValue(payload.involved, "Não informado"),
            safeValue(payload.officers_involved, "Não informado"),
            safeValue(payload.description, "---"),
            boletimId,
            policeId
        })

        sendPayload(source, "boletins", getBoletins(policeId))
        notify(source, "Boletim atualizado com sucesso.", "verde")
        return
    end

    if action == "deleteBoletim" then
        local allowed = hasPolicePermission(passport, "boletins", "delete")
        if not allowed then
            notify(source, "Sem permissão para excluir boletim.")
            return
        end

        local boletimId = parseInt(payload.boletim_id)
        if boletimId <= 0 then
            notify(source, "Boletim inválido.")
            return
        end

        tableUpdate("DELETE FROM police_tablet_boletins WHERE id = ? AND police_id = ?", { boletimId, policeId })
        sendPayload(source, "boletins", getBoletins(policeId))
        notify(source, "Boletim excluído com sucesso.", "verde")
        return
    end


    if action == "consultWantedTarget" then
        sendPayload(source, "wantedTarget", consultPerson(payload.passport))
        return
    end

    if action == "createProcurado" then
        local allowed = hasPolicePermission(passport, "procurados", "create")
        if not allowed then
            notify(source, "Sem permissão para cadastrar procurado.")
            return
        end

        local targetPassport = parseInt(payload.passport)
        if targetPassport <= 0 then
            notify(source, "Passaporte inválido.")
            return
        end

        local target = consultPerson(targetPassport)
        if not target or not target.found then
            notify(source, "Cidadão não encontrado.")
            return
        end

        local dangerLevel = parseInt(payload.danger_level)
        if dangerLevel < 1 or dangerLevel > 3 then
            notify(source, "Selecione o grau de periculosidade entre 1 e 3.")
            return
        end

        local reason = safeValue(payload.reason, "---")
        local photoUrl = safeValue(payload.photo_url, "")
        if photoUrl == "---" then photoUrl = "" end

        tableInsert([[
            INSERT INTO police_tablet_procurados
            (police_id, suspect_passport, suspect_name, suspect_age, suspect_sex, suspect_phone, danger_level, reason, photo_url, officer_passport, officer_name)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]], {
            policeId,
            targetPassport,
            safeValue(target.name, "---"),
            safeValue(target.age, "---"),
            safeValue(target.sex, "---"),
            safeValue(target.phone, "---"),
            dangerLevel,
            reason,
            photoUrl,
            passport,
            fullName(identityByPassport(passport))
        })

        sendPayload(source, "procurados", getProcurados(policeId))
        notify(source, "Procurado cadastrado com sucesso.", "verde")
        return
    end

    if action == "deleteProcurado" then
        local allowed = hasPolicePermission(passport, "procurados", "delete")
        if not allowed then
            notify(source, "Sem permissão para excluir procurado.")
            return
        end

        local procuradoId = parseInt(payload.procurado_id)
        if procuradoId <= 0 then
            notify(source, "Procurado inválido.")
            return
        end

        tableUpdate("DELETE FROM police_tablet_procurados WHERE id = ? AND police_id = ?", { procuradoId, policeId })
        sendPayload(source, "procurados", getProcurados(policeId))
        notify(source, "Procurado excluído com sucesso.", "verde")
        return
    end

    if action == "createNotice" then
        local allowed = hasPolicePermission(passport, "notices", "create")
        if not allowed then
            notify(source, "Sem permissão para publicar aviso.")
            return
        end

        tableInsert([[
            INSERT INTO police_tablet_notices (police_id, title, content, author_passport, author_name)
            VALUES (?, ?, ?, ?, ?)
        ]], {
            policeId,
            safeValue(payload.title, "Aviso"),
            safeValue(payload.content, "---"),
            passport,
            fullName(identityByPassport(passport))
        })

        sendPayload(source, "dashboard", getDashboard(source, passport, policeId))
        notify(source, "Aviso publicado com sucesso.", "verde")
        return
    end

    if action == "createArticle" then
        local allowed = hasPolicePermission(passport, "articles", "create")
        if not allowed then
            notify(source, "Sem permissão para cadastrar artigos.")
            return
        end

        tableInsert([[
            INSERT INTO police_tablet_articles (police_id, code, title, description, fine_value, jail_time, created_by)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ]], {
            policeId,
            safeValue(payload.code, "Sem código"),
            safeValue(payload.title, "Sem título"),
            safeValue(payload.description, "---"),
            parseInt(payload.fine_value),
            parseInt(payload.jail_time),
            passport
        })

        sendPayload(source, "articles", getArticles(policeId))
        notify(source, "Artigo cadastrado com sucesso.", "verde")
        return
    end

    if action == "updateArticle" then
        local allowed = hasPolicePermission(passport, "articles", "edit")
        if not allowed then
            notify(source, "Sem permissão para editar artigos.")
            return
        end

        local articleId = parseInt(payload.article_id)
        if articleId <= 0 then
            notify(source, "Artigo inválido.")
            return
        end

        tableUpdate([=[
            UPDATE police_tablet_articles
            SET code = ?, title = ?, description = ?, fine_value = ?, jail_time = ?
            WHERE id = ? AND (police_id = ? OR is_global = 0)
        ]=], {
            safeValue(payload.code, "Sem código"),
            safeValue(payload.title, "Sem título"),
            safeValue(payload.description, "---"),
            parseInt(payload.fine_value),
            parseInt(payload.jail_time),
            articleId,
            policeId
        })

        sendPayload(source, "articles", getArticles(policeId))
        notify(source, "Artigo atualizado com sucesso.", "verde")
        return
    end

    if action == "deleteArticle" then
        local allowed = hasPolicePermission(passport, "articles", "delete")
        if not allowed then
            notify(source, "Sem permissão para excluir artigos.")
            return
        end

        local articleId = parseInt(payload.article_id)
        if articleId <= 0 then
            notify(source, "Artigo inválido.")
            return
        end

        tableUpdate("DELETE FROM police_tablet_articles WHERE id = ? AND (police_id = ? OR is_global = 0)", { articleId, policeId })
        sendPayload(source, "articles", getArticles(policeId))
        notify(source, "Artigo excluído com sucesso.", "verde")
        return
    end

    if action == "registerPrison" then
        local allowed = hasPolicePermission(passport, "penal", "prison")
        if not allowed then
            notify(source, "Sem permissão para registrar prisão.")
            return
        end

        registerPrisonAndFine(source, passport, policeId, payload)
        sendPayload(source, "consultPerson", consultPerson(payload.passport))
        return
    end

    if action == "registerSeizure" then
        local allowed = hasPolicePermission(passport, "penal", "createOccurrence")
        if not allowed then
            notify(source, "Sem permissão para registrar apreensão.")
            return
        end

        registerSeizure(source, passport, policeId, payload)
        sendPayload(source, "consultPerson", consultPerson(payload.passport))
        return
    end

    if action == "consultPerson" then
        sendPayload(source, "consultPerson", consultPerson(payload.passport))
        return
    end

    if action == "consultVehicle" then
        sendPayload(source, "consultVehicle", consultVehicle(payload.search))
        return
    end
end)

RegisterNetEvent("police_tablet:respondMemberInvite")
AddEventHandler("police_tablet:respondMemberInvite", function(accepted)
    local source = source
    local targetPassport = getPassport(source)
    if not targetPassport then return end

    local invite = getPendingInvite(targetPassport)
    if not invite then
        notify(source, "Você não possui convite pendente.")
        return
    end

    clearPendingInvite(targetPassport)

    local officerSource = invite.officerSource
    if not accepted then
        notify(source, "Você recusou a contratação.", "amarelo")
        if officerSource then
            notify(officerSource, "O jogador recusou a contratação.", "amarelo")
        end
        return
    end

    local policeData = getPoliceData(invite.policeId)
    if not policeData then
        notify(source, "A corporação do convite não está disponível.")
        if officerSource then
            notify(officerSource, "Não foi possível concluir a contratação: corporação indisponível.")
        end
        return
    end

    local permissionData = readPermissionData(policeData.permissionKey)
    if parseInt(permissionData[tostring(targetPassport)]) > 0 then
        notify(source, "Você já faz parte da corporação.", "amarelo")
        if officerSource then
            notify(officerSource, "O jogador já faz parte da corporação.", "amarelo")
        end
        return
    end

    local otherOrg = getOtherOrgMembership(targetPassport, policeData.permissionKey)
    if otherOrg then
        notify(source, "Você não pode aceitar porque já pertence à organização " .. safeValue(otherOrg.permissionKey, "Desconhecida") .. ".", "amarelo")
        if officerSource then
            notify(officerSource, "Contratação cancelada: o jogador já pertence à organização " .. safeValue(otherOrg.permissionKey, "Desconhecida") .. ".", "amarelo")
        end
        return
    end

    local blacklist = getActiveBlacklist(targetPassport)
    if blacklist then
        local orgName = safeValue(blacklist.org, "Desconhecida")
        local expireText = blacklist.expire_date and tostring(blacklist.expire_date) or "sem data"
        notify(source, "Você não pode aceitar porque está na blacklist da organização " .. orgName .. " até " .. expireText .. ".", "amarelo")
        if officerSource then
            notify(officerSource, "Contratação cancelada: o jogador está na blacklist da organização " .. orgName .. " até " .. expireText .. ".", "amarelo")
        end
        return
    end

    updateMemberPermission(policeData, targetPassport, invite.hierarchy)
    upsertMember(targetPassport, invite.policeId, invite.role, invite.hierarchy)

    notify(source, "Você aceitou a contratação e entrou na corporação como " .. safeValue(invite.role, "Membro") .. ".", "verde")
    if officerSource then
        sendPayload(officerSource, "members", getMembers(invite.policeId))
        notify(officerSource, "Contratação aceita com sucesso.", "verde")
    end
end)


RegisterNetEvent("police_tablet:syncAllMembers")
AddEventHandler("police_tablet:syncAllMembers", function(policeId)
    local source = source
    local passport = getPassport(source)
    local allowed, myPoliceId = hasPolicePermission(passport, "members", "hire")
    if not passport or not allowed then return end

    policeId = policeId or myPoliceId
    if Config.Polices[policeId] then
        syncMembersFromBase(policeId)
        syncOnlinePolice(policeId)
        sendPayload(source, "members", getMembers(policeId))
        notify(source, "Lista de membros sincronizada com a base e com os grupos ativos.", "verde")
    end
end)

RegisterNetEvent("police_tablet:syncMember")
AddEventHandler("police_tablet:syncMember", function(targetPassport, policeId, hierarchy, role)
    local source = source
    local passport = getPassport(source)
    local allowed = hasPolicePermission(passport, "members", "hire")
    if not passport or not allowed then return end
    if Config.Polices[policeId] then
        upsertMember(parseInt(targetPassport), policeId, role, hierarchy)
    end
end)

RegisterNetEvent("police_tablet:removeMember")
AddEventHandler("police_tablet:removeMember", function(targetPassport, policeId)
    local source = source
    local passport = getPassport(source)
    local allowed = hasPolicePermission(passport, "members", "fire")
    if not passport or not allowed then return end
    tableUpdate("DELETE FROM police_tablet_members WHERE police_id = ? AND passport = ?", { policeId, parseInt(targetPassport) })
end)
