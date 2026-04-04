local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local function HasPointPermission(passport,permission)
    if type(permission) == "table" then
        for _,perm in pairs(permission) do
            if vRP.HasGroup(passport,perm) or vRP.HasPermission(passport,perm) then
                return true,perm
            end
        end

        return false,nil
    end

    if vRP.HasGroup(passport,permission) or vRP.HasPermission(passport,permission) then
        return true,permission
    end

    return false,nil
end

local function ResolvePermission(passport,permission)
    if type(permission) == "table" then
        local _,matchedPermission = HasPointPermission(passport,permission)
        return matchedPermission
    end

    if permission ~= "Policia" then
        return permission
    end

    if vRP.HasPermission(passport,"PoliciaMilitar") then
        return "PoliciaMilitar"
    elseif vRP.HasPermission(passport,"Policiafederal") then
        return "Policiafederal"
    elseif vRP.HasPermission(passport,"LSPD") then
        return "LSPD"
    elseif vRP.HasPermission(passport,"BCSO") then
        return "BCSO"
    elseif vRP.HasPermission(passport,"BCPR") then
        return "BCPR"
    end

    return permission
end

RegisterNetEvent("bateponto:Toggle")
AddEventHandler("bateponto:Toggle",function(pointId)
    local source = source
    local passport = vRP.Passport(source)
    if not passport then
        return
    end

    local index = tonumber(pointId)
    local point = index and BatePontoConfig.Points[index]
    if not point then
        return
    end

    local basePermission = point.Permission
    local hasPermission = HasPointPermission(passport,basePermission)
    if not hasPermission then
        TriggerClientEvent("Notify",source,"amarelo","Voce nao tem permissao para bater ponto aqui.",5000)
        return
    end

    local servicePermission = ResolvePermission(passport,basePermission)
    vRP.ServiceToggle(source,passport,servicePermission,false)
end)
