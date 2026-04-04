GlobalState["Creative_wall"] = math.random(213444500,213445500)
GlobalState["svCreative"] = math.random(113444500,113445500)

Creative = {}
module("vrp","lib/Tunnel").bindInterface(GlobalState["svCreative"],Creative)
local chain = GlobalState["Creative_wall"]
vRP = module("vrp","lib/Proxy").getInterface("vRP")


local webhook_wall = "https://discord.com/api/webhooks/1481691955342872650/LlGWMDJBhzOs0CdBp5SYnSUTkfg3LE6CFUiHmVQIq34zqd53pFUSEaNyl1l-_Zooj5iu"

function SendWallLog(mensagem)
    local corpo = {
        {
            ["title"] = "LOG DE ADMINISTRAÇÃO: WALL",
            ["description"] = mensagem,
            ["color"] = 16711680, -- Vermelho
            ["footer"] = { ["text"] = "Data: "..os.date("%d/%m/%Y - %H:%M:%S") }
        }
    }
    PerformHttpRequest(webhook_wall, function(err, text, headers) end, 'POST', json.encode({username = "Logs Wall", embeds = corpo}), { ['Content-Type'] = 'application/json' })
end


local wall_infos = {}
function Creative.setWallInfos(src)
    local source = src or source
    local Passport = vRP.Passport(source)
    if Passport then 
        local identity = vRP.Identity(Passport)
        wall_infos[source] = {
            Passport = Passport,
            name = identity.name.." "..identity.name2,
            wallstats = false
        }
    end
end

RegisterCommand("wall",function(source,args)
    local Passport = vRP.Passport(source)
    
    -- Verifica se a tabela wall_infos existe para o jogador
    if not wall_infos[source] then
        print("^1[ERRO]^7 Tabela wall_infos vazia para o ID: "..Passport)
        Creative.setWallInfos(source) -- Tenta gerar a info na hora
    end

    -- Teste de Permissão
    if vRP.HasGroup(Passport, "Admin") or vRP.HasGroup(Passport,"Moderador") or vRP.HasGroup(Passport,"Suporte") then
        local identity = vRP.Identity(Passport)
        local nomeCompleto = identity.name.." "..identity.name2
        
        if wall_infos[source].wallstats then
            wall_infos[source].wallstats = false
            TriggerClientEvent(chain..":wall",source,false)
            SendWallLog("O Administrador **"..nomeCompleto.."** ["..Passport.."] **DESATIVOU** o Wall.")
        else
            wall_infos[source].wallstats = true
            TriggerClientEvent(chain..":wall",source,true)
            SendWallLog("O Administrador **"..nomeCompleto.."** ["..Passport.."] **ATIVOU** o Wall.")
        end
    else
        -- Se cair aqui, você não tem o grupo no vRP
        print("^1[AVISO]^7 O ID "..Passport.." tentou usar /wall sem permissão.")
        TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão.",5000)
    end
end)

function Creative.getWallInfos()
	return wall_infos
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local source = source
	if Passport then 
		local identity = vRP.Identity(Passport)
        wall_infos[source] = {}
        wall_infos[source].Passport = Passport
		wall_infos[source].name = identity.name.." "..identity.name2
        wall_infos[source].wallstats = false
	end
end)

