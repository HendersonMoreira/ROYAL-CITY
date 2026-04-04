-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE (SQL)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Regista a query para atualizar a coluna whitelist na tabela accounts conforme a tua base de dados
vRP.Prepare("japa/set_whitelist", "UPDATE accounts SET whitelist = @whitelist WHERE id = @id")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
-- Coloca o link da tua Webhook do Discord entre as aspas
local webhook_whitelist = "https://discord.com/api/webhooks/1482124735625166869/wypU3HE2ecD9Q78UCcxLzLf1pcepPNL6vVJEPZPxG2Y9o9LNO8si5qd-qMZkwpWGRD0i"

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO DE LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWLDiscord(message)
    if webhook_whitelist ~= "" then
        PerformHttpRequest(webhook_whitelist, function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                {
                    title = "REGISTO DE WHITELIST",
                    description = message,
                    color = 3066993,
                    footer = { text = "Data: "..os.date("%d/%m/%Y %H:%M:%S") }
                }
            }
        }), { ['Content-Type'] = 'application/json' })
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA ADICIONAR WL (/wl ID)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl", function(source, Message)
    -- Obtém o passaporte (ID) de quem executou o comando
    local Passport = vRP.Passport(source)
    
    if Passport then
        -- Verifica se tem o grupo Admin nível 2 (igual ao teu comando de ban)
        if vRP.HasGroup(Passport, "Admin", 3) then
            local OtherPassport = parseInt(Message[1])
            
            if OtherPassport > 0 then
                -- Executa a query para dar a WL (valor 1)
                vRP.Query("japa/set_whitelist", { id = OtherPassport, whitelist = 1 })
                
                -- Notifica quem deu o comando (formato verde conforme a tua base)
                TriggerClientEvent("Notify", source, "Sucesso", "Passaporte <b>"..OtherPassport.."</b> adicionado à whitelist.", "verde", 5000)
                
                -- Envia log para o Discord
                SendWLDiscord("O Admin **ID: "..Passport.."** adicionou o **ID: "..OtherPassport.."** à Whitelist.")
            else
                TriggerClientEvent("Notify", source, "Negado", "Deves especificar um ID válido. Exemplo: /wl 1", "vermelho", 5000)
            end
        else
            -- Mensagem caso não tenha permissão
            TriggerClientEvent("Notify", source, "Negado", "Não tens permissão para usar este comando.", "vermelho", 5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA REMOVER WL (/unwl ID)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl", function(source, Message)
    local Passport = vRP.Passport(source)
    
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 3) then
            local OtherPassport = parseInt(Message[1])
            
            if OtherPassport > 0 then
                -- Executa a query para remover a WL (valor 0)
                vRP.Query("japa/set_whitelist", { id = OtherPassport, whitelist = 0 })
                
                TriggerClientEvent("Notify", source, "Sucesso", "Passaporte <b>"..OtherPassport.."</b> removido da whitelist.", "verde", 5000)
                
                -- Envia log para o Discord
                SendWLDiscord("O Admin **ID: "..Passport.."** removeu a Whitelist do **ID: "..OtherPassport.."**")

                -- Se o jogador estiver online, expulsa-o (Kick)
                local OtherSource = vRP.Source(OtherPassport)
                if OtherSource then
                    vRP.Kick(OtherSource, "A tua Whitelist foi removida pela administração.")
                end
            else
                TriggerClientEvent("Notify", source, "Negado", "Deves especificar um ID válido. Exemplo: /unwl 1", "vermelho", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "Negado", "Não tens permissão para usar este comando.", "vermelho", 5000)
        end
    end
end)