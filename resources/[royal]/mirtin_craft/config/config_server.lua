local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("mirtin_craft",src)
Proxy.addInterface("mirtin_craft",src)

vCLIENT = Tunnel.getInterface("mirtin_craft")
local function parseInt(value)
    return tonumber(value) and math.floor(tonumber(value)) or 0
end

local function GetUserId(source)
    if not source then return nil end

    if vRP then
        if vRP.Passport then
            local ok,id = pcall(vRP.Passport, source)
            if ok and id then return id end
        end

        if vRP.getUserId then
            local ok,id = pcall(vRP.getUserId, source)
            if ok and id then return id end
        end

        if vRP.UserId then
            local ok,id = pcall(vRP.UserId, source)
            if ok and id then return id end
        end
    end

    return nil
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config = {}
config.license = "main"  -- não mexa aqui ( isso serve para updates exclusivos )
config.delayCraft = 5 -- Segundos ( Delay de cada mesa de craft, para evitar floods )
config.weebdump = "" -- WEEBHOOK QUANDO NEGO TENTAR DUMPAR DESLIGANDO A INTERNET. 

config.weebhook = {
    logo = "", -- LOGO do Servidor
    color =  6356736,
    footer = "© Mirt1n Store",
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG CRAFT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.table = { 
   
    ["Medellin"] = { -- DROGA
        armazem = false, -- Caso coloque true, configure a localização do armazem. ( false os items precisam está no inventario .)
        weebhook = "https://discord.com/api/webhooks/1485784872583692489/DX1v9P8fknqwPm3EVg2ED9K9_t5sl4nJnMN6ry6T_lNc8ejrlAqIciEvulTM_gdyjMlw", -- WEEBHOOK DAS TRANSACOES FEITAS AQUI [ CRAFT / ARMAZEM ] [ PASSAR PARA SERVER SIDE AQUI TUDO ]
        isDominas = false,

        craft = {
            ["Heroína"] = {
                spawnID = "heroina", -- SPAWN DO ITEM
                nameItem = "heroina", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 0, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "pastaquimica" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "materiabase" , amount = 1 },  
                    { item = "qheroina" , amount = 1 }, 
                }
            },

            ["Maconha"] = {
                spawnID = "maconha", -- SPAWN DO ITEM
                nameItem = "maconha", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 0, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "pastaquimica" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "materiabase" , amount = 1 },
                    { item = "qmaconha" , amount = 1},
                }
            },
        
            ["Crack"] = {
                spawnID = "crack", -- SPAWN DO ITEM
                nameItem = "crack", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 0, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "materiabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "pastaquimica" , amount = 1 },
                    { item = "qcrack" , amount = 1 },
                    
                }
            },
        
            ["Cocaína"] = {
                spawnID = "cocaine", -- SPAWN DO ITEM
                nameItem = "cocaina", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 0, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "materiabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "pastaquimica" , amount = 1 },
                    { item = "qcocaina" , amount = 1 },
                }
            },
            
            ["Metanfetamina"] = {
                spawnID = "meth", -- SPAWN DO ITEM
                nameItem = "Metanfetamina", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 0, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                     { item = "materiabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "pastaquimica" , amount = 1 },
                    { item = "qmetafetamina" , amount = 1 },
                }
            },
        }
    },
   
    ["Elements"] = { -- MUNICAO
        armazem = false, -- Caso coloque true, configure a localização do armazem. ( false os items precisam está no inventario .)
        weebhook = "https://discord.com/api/webhooks/1485784872583692489/DX1v9P8fknqwPm3EVg2ED9K9_t5sl4nJnMN6ry6T_lNc8ejrlAqIciEvulTM_gdyjMlw", -- WEEBHOOK DAS TRANSACOES FEITAS AQUI [ CRAFT / ARMAZEM ] [ PASSAR PARA SERVER SIDE AQUI TUDO ]
        isDominas = false,

        craft = {
            ["Munição Pistola Fajuta"] = {
                spawnID = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                nameItem = "M. Pistola-Fajuta", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 0, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 100 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 100 },  
                }
            },
        
            ["Munição Pistola MK2"] = {
                spawnID = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                nameItem = "M. Pistola MK2", -- NOME DO ITEM
                maxAmount = 2, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 100, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 100 },  
                    
                }
            },
        
            ["Munição AK-47"] = {
                spawnID = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                nameItem = "M. AK-47", -- NOME DO ITEM
                maxAmount = 2, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 100, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 100 },
                }
            },
            
            
            ["Munição MP5"] = {
                spawnID = "AMMO_SMG", -- SPAWN DO ITEM
                nameItem = "M. MP5", -- NOME DO ITEM
                maxAmount = 2, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 100, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 100 }, 
                }
            },
        

            ["Munição TEC-9"] = {
                spawnID = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                nameItem = "M. TEC-9", -- NOME DO ITEM
                maxAmount = 2, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 100, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 100 }, 
                }
            },
        


            ["Munição AK-47 MK2"] = {
                spawnID = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                nameItem = "M. AK-47 MK2", -- NOME DO ITEM
                maxAmount = 2, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 100, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 100 },
                }
            },
        
            
            ["Munição G3"] = {
                spawnID = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                nameItem = "M. G3", -- NOME DO ITEM
                maxAmount = 2, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 100, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 100 },
                }
            },
        }
    },

    ["Distrito22"] = { -- ARMAS
        armazem = false, -- Caso coloque true, configure a localização do armazem. ( false os items precisam está no inventario .)
        weebhook = "https://discord.com/api/webhooks/1486848143822946375/dU4oouRLfUON38fcvNNuiPAGMID-58aHtYvQPv3sh7bqPwPgsLDjrwGuaZwTH60ODCI0", -- WEEBHOOK DAS TRANSACOES FEITAS AQUI [ CRAFT / ARMAZEM ] [ PASSAR PARA SERVER SIDE AQUI TUDO ]
        isDominas = false,

        craft = {
            ["G3 MK2"] = {
                spawnID = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                nameItem = "G3 MK2", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 800 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 500 },
                }
            },

            ["G3"] = {
                spawnID = "WEAPON_SPECIALCARBINE", -- SPAWN DO ITEM
                nameItem = "G3", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 700 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 450 },
                }
            },

            ["AK-47"] = {
                spawnID = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK-47", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 650 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 420 },
                }
            },

            ["AK Compacta"] = {
                spawnID = "WEAPON_COMPACTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK Compacta", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 600 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 380 },
                }
            },

            ["AP Pistol"] = {
                spawnID = "WEAPON_APPISTOL", -- SPAWN DO ITEM
                nameItem = "AP Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 350 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 250 },
                }
            },

            ["Combat Pistol"] = {
                spawnID = "WEAPON_COMBATPISTOL", -- SPAWN DO ITEM
                nameItem = "Combat Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 320 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 220 },
                }
            },

            ["Assault SMG"] = {
                spawnID = "WEAPON_ASSAULTSMG", -- SPAWN DO ITEM
                nameItem = "Assault SMG", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 500 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 320 },
                }
            },
        }
    },
["Barragem"] = { -- ARMAS
        armazem = false, -- Caso coloque true, configure a localização do armazem. ( false os items precisam está no inventario .)
        weebhook = "https://discord.com/api/webhooks/1486129455830143071/S0D0wLOsLh4JgbpBxsMUUOLDg7dFDWp0jXxdHslIkl7kAltVPjVTC8J80796P39GzDyK", -- WEEBHOOK DAS TRANSACOES FEITAS AQUI [ CRAFT / ARMAZEM ] [ PASSAR PARA SERVER SIDE AQUI TUDO ]
        isDominas = false,

        craft = {
            ["G3 MK2"] = {
                spawnID = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                nameItem = "G3 MK2", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 800 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 500 },
                }
            },

            ["G3"] = {
                spawnID = "WEAPON_SPECIALCARBINE", -- SPAWN DO ITEM
                nameItem = "G3", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 700 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 450 },
                }
            },

            ["AK-47"] = {
                spawnID = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK-47", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 650 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 420 },
                }
            },

            ["AK Compacta"] = {
                spawnID = "WEAPON_COMPACTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK Compacta", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 600 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 380 },
                }
            },

            ["AP Pistol"] = {
                spawnID = "WEAPON_APPISTOL", -- SPAWN DO ITEM
                nameItem = "AP Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 350 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 250 },
                }
            },

            ["Combat Pistol"] = {
                spawnID = "WEAPON_COMBATPISTOL", -- SPAWN DO ITEM
                nameItem = "Combat Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 320 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 220 },
                }
            },

            ["Assault SMG"] = {
                spawnID = "WEAPON_ASSAULTSMG", -- SPAWN DO ITEM
                nameItem = "Assault SMG", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 500 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 320 },
                }
            },
        }
    },
     ["Turquia"] = { -- ARMAS
        armazem = false, -- Caso coloque true, configure a localização do armazem. ( false os items precisam está no inventario .)
        weebhook = "", -- WEEBHOOK DAS TRANSACOES FEITAS AQUI [ CRAFT / ARMAZEM ] [ PASSAR PARA SERVER SIDE AQUI TUDO ]
        isDominas = false,

        craft = {
            ["G3 MK2"] = {
                spawnID = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                nameItem = "G3 MK2", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 800 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 500 },
                }
            },

            ["G3"] = {
                spawnID = "WEAPON_SPECIALCARBINE", -- SPAWN DO ITEM
                nameItem = "G3", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 700 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 450 },
                }
            },

            ["AK-47"] = {
                spawnID = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK-47", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 650 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 420 },
                }
            },

            ["AK Compacta"] = {
                spawnID = "WEAPON_COMPACTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK Compacta", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 600 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 380 },
                }
            },

            ["AP Pistol"] = {
                spawnID = "WEAPON_APPISTOL", -- SPAWN DO ITEM
                nameItem = "AP Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 350 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 250 },
                }
            },

            ["Combat Pistol"] = {
                spawnID = "WEAPON_COMBATPISTOL", -- SPAWN DO ITEM
                nameItem = "Combat Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 320 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 220 },
                }
            },

            ["Assault SMG"] = {
                spawnID = "WEAPON_ASSAULTSMG", -- SPAWN DO ITEM
                nameItem = "Assault SMG", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 500 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 320 },
                }
            },
        }
    },
["Barragem"] = { -- ARMAS
        armazem = false, -- Caso coloque true, configure a localização do armazem. ( false os items precisam está no inventario .)
        weebhook = "https://discord.com/api/webhooks/1486129455830143071/S0D0wLOsLh4JgbpBxsMUUOLDg7dFDWp0jXxdHslIkl7kAltVPjVTC8J80796P39GzDyK", -- WEEBHOOK DAS TRANSACOES FEITAS AQUI [ CRAFT / ARMAZEM ] [ PASSAR PARA SERVER SIDE AQUI TUDO ]
        isDominas = false,

        craft = {
            ["G3 MK2"] = {
                spawnID = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                nameItem = "G3 MK2", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 800 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 500 },
                }
            },

            ["G3"] = {
                spawnID = "WEAPON_SPECIALCARBINE", -- SPAWN DO ITEM
                nameItem = "G3", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 700 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 450 },
                }
            },

            ["AK-47"] = {
                spawnID = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK-47", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 650 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 420 },
                }
            },

            ["AK Compacta"] = {
                spawnID = "WEAPON_COMPACTRIFLE", -- SPAWN DO ITEM
                nameItem = "AK Compacta", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 600 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 380 },
                }
            },

            ["AP Pistol"] = {
                spawnID = "WEAPON_APPISTOL", -- SPAWN DO ITEM
                nameItem = "AP Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 350 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 250 },
                }
            },

            ["Combat Pistol"] = {
                spawnID = "WEAPON_COMBATPISTOL", -- SPAWN DO ITEM
                nameItem = "Combat Pistol", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 12, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 320 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 220 },
                }
            },

            ["Assault SMG"] = {
                spawnID = "WEAPON_ASSAULTSMG", -- SPAWN DO ITEM
                nameItem = "Assault SMG", -- NOME DO ITEM
                maxAmount = 1, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "polvora" , amount = 500 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    { item = "capsulas" , amount = 320 },
                }
            },
        }
    },

    
    ["BurgerShot"] = { -- RESTAURANTE
        armazem = true, -- Caso coloque true, configure a localização do armazem. ( false os items precisam está no inventario .)
        weebhook = "", -- WEEBHOOK DAS TRANSACOES FEITAS AQUI [ CRAFT / ARMAZEM ] [ PASSAR PARA SERVER SIDE AQUI TUDO ]
        isDominas = false,

        craft = {
            ["Hambúrguer"] = {
                spawnID = "hamburguer", -- SPAWN DO ITEM
                nameItem = "Hambúrguer", -- NOME DO ITEM
                maxAmount = 5, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "pao" , amount = 1 },
                    { item = "carne" , amount = 1 },
                    { item = "alface" , amount = 1 },
                }
            },

            ["Hot Dog"] = {
                spawnID = "hotdog", -- SPAWN DO ITEM
                nameItem = "Hot Dog", -- NOME DO ITEM
                maxAmount = 5, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "pao" , amount = 1 },
                    { item = "salsicha" , amount = 1 },
                }
            },

            ["Pizza"] = {
                spawnID = "pizza", -- SPAWN DO ITEM
                nameItem = "Pizza", -- NOME DO ITEM
                maxAmount = 5, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "massa" , amount = 1 },
                    { item = "tomate" , amount = 1 },
                    { item = "queijo" , amount = 1 },
                }
            },

            ["Sanduíche"] = {
                spawnID = "sanduiche", -- SPAWN DO ITEM
                nameItem = "Sanduíche", -- NOME DO ITEM
                maxAmount = 5, -- Quantidade maxima de Craft [ VALOR DA INPUT < > ]
                customAmount = 1, -- Caso queira colocar um valor x por unidade.
                tempo = 7, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                requires = {
                    { item = "pao" , amount = 1 },
                    { item = "queijo" , amount = 1 },
                }
            },
        }
    },
}

config.craftLocations = { 

    [1] = { type = "Franca", perm = "franca.permissao", isDominas = nil, coords = vec3( -2407.76,1803.96,208.01 ), visible = 2.0 },
    [2] = { type = "Ballas", perm = "Ballas", hierarchy = 1, isDominas = nil, coords = vec3(  93.39,-1964.67,20.74 ), visible = 2.0 },
    [3] = { type = "Medellin", perm = "Medellin", hierarchy = 3, isDominas = nil, coords = vec3( 1414.11,1107.87,114.81 ), visible = 2.0 },
    [4] = { type = "Barragem", perm = "Barragem", hierarchy = 3, isDominas = nil, coords = vec3( 1227.99,-249.71,79.62), visible = 2.0 },
    [5] = { type = "Elements", perm = "Elements", hierarchy = 3, isDominas = nil, coords = vec3( -1703.77,946.58,177.61), visible = 2.0 },
    [6] = { type = "Distrito22", perm = "Distrito22", hierarchy = 3, isDominas = nil, coords = vec3( -1760.83,-201.95,57.79), visible = 2.0 },
    [7] = { type = "Turquia", perm = "Turquia", hierarchy = 3, isDominas = nil, coords = vec3( 1352.09,-678.26,78.79), visible = 2.0 }

}

config.armazemLocations = {
    ["Mecanica"] = { perm = "mecanico.permissao", coords = vec3( 876.86, -2096.43, 30.48 ), visible = 1.3 }, -- MECANICA
    ["BurgerShot"] = { perm = "burgershot.permissao", coords = vec3( -1196.81,-901.47,13.99 ), visible = 1.3 }, -- RESTAURANTE
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function getHierarchyData(permission)
    local key = "Permissions:"..tostring(permission)
    local raw = nil

    if vRP and vRP.getSData then
        local ok, result = pcall(vRP.getSData, key)
        if ok and result and result ~= "" then
            raw = result
        end
    end

    if (not raw or raw == "") and exports and exports.oxmysql and exports.oxmysql.scalarSync then
        local ok, result = pcall(function()
            return exports.oxmysql:scalarSync("SELECT dvalue FROM entitydata WHERE dkey = ? LIMIT 1", { key })
        end)
        if ok and result and result ~= "" then
            raw = result
        end
    end

    if (not raw or raw == "") and MySQL and MySQL.scalar and MySQL.scalar.await then
        local ok, result = pcall(function()
            return MySQL.scalar.await("SELECT dvalue FROM entitydata WHERE dkey = ? LIMIT 1", { key })
        end)
        if ok and result and result ~= "" then
            raw = result
        end
    end

    if not raw or raw == "" then
        return {}
    end

    local decoded = raw
    if type(raw) == "string" then
        local ok, result = pcall(json.decode, raw)
        if ok and type(result) == "table" then
            decoded = result
        else
            decoded = {}
        end
    end

    if type(decoded) ~= "table" then
        decoded = {}
    end

    return decoded
end

src.checkPermission = function(permission, hierarchy)
    local source = source
    local user_id = GetUserId(source)
    if not user_id then
        return false
    end

    if permission == nil then
        return true
    end

    if hierarchy ~= nil then
        local permData = getHierarchyData(permission)
        local myHierarchy = tonumber(permData[tostring(user_id)] or permData[user_id])
        local needHierarchy = tonumber(hierarchy) or 1

        if myHierarchy then
            return myHierarchy <= needHierarchy
        end

        if vRP then
            if vRP.HasGroup then
                local ok,allowed = pcall(vRP.HasGroup, user_id, permission, needHierarchy)
                if ok and allowed then return true end
            end

            if vRP.hasGroup then
                local ok,allowed = pcall(vRP.hasGroup, user_id, permission, needHierarchy)
                if ok and allowed then return true end
            end
        end

        return false
    end

    if vRP then
        if vRP.hasPermission then
            local ok,allowed = pcall(vRP.hasPermission, user_id, permission)
            if ok and allowed then return true end
        end

        if vRP.HasPermission then
            local ok,allowed = pcall(vRP.HasPermission, user_id, permission)
            if ok and allowed then return true end
        end

        if vRP.HasGroup then
            local ok,allowed = pcall(vRP.HasGroup, user_id, permission)
            if ok and allowed then return true end
        end

        if vRP.hasGroup then
            local ok,allowed = pcall(vRP.hasGroup, user_id, permission)
            if ok and allowed then return true end
        end
    end

    return false
end

src.getItemName = function(item)
    if vRP.ItemName then
        local ok,result = pcall(vRP.ItemName, item)
        if ok and result then return result end
    end

    if vRP.getItemName then
        local ok,result = pcall(vRP.getItemName, item)
        if ok and result then return result end
    end

    return tostring(item)
end

src.giveInventoryItem = function(user_id, item, amount)
    amount = tonumber(amount) or 1

    if vRP.GenerateItem then
        local ok,result = pcall(vRP.GenerateItem, user_id, item, amount, true)
        if ok then return result end
    end

    if vRP.GiveItem then
        local ok,result = pcall(vRP.GiveItem, user_id, item, amount, true)
        if ok then return result end
    end

    if vRP.giveInventoryItem then
        local ok,result = pcall(vRP.giveInventoryItem, user_id, item, amount, true)
        if ok then return result end
    end

    return false
end

src.getInventoryItemAmount = function(user_id, item)
    if vRP.InventoryItemAmount then
        local ok,result = pcall(vRP.InventoryItemAmount, user_id, item)
        if ok then return result or 0 end
    end

    if vRP.getInventoryItemAmount then
        local ok,result = pcall(vRP.getInventoryItemAmount, user_id, item)
        if ok then return result or 0 end
    end

    return 0
end

src.tryGetInventoryItem = function(user_id, item, amount)
    amount = tonumber(amount) or 1

    if vRP.TakeItem then
        local ok,result = pcall(vRP.TakeItem, user_id, item, amount, true)
        if ok then return result end
    end

    if vRP.tryGetInventoryItem then
        local ok,result = pcall(vRP.tryGetInventoryItem, user_id, item, amount, true)
        if ok then return result end
    end

    return false
end

src.checkInventoryWeight = function(user_id, spawnID, amount)
    local item = tostring(spawnID)
    local itemAmount = tonumber(amount) or 1

    if vRP.MaxItens then
        local ok,maxed = pcall(vRP.MaxItens, user_id, item, itemAmount)
        if ok and maxed then
            return false, 'limit'
        end
    end

    if vRP.InventoryWeight then
        local ok,canCarry = pcall(vRP.InventoryWeight, user_id, item, itemAmount)
        if ok then
            if canCarry then
                return true
            end
            return false, 'weight'
        end
    end

    local invWeight = 0
    if vRP.InventoryWeight then
        local ok,current = pcall(vRP.InventoryWeight, user_id)
        if ok and type(current) == 'number' then
            invWeight = current
        end
    elseif vRP.computeInvWeight then
        local ok,current = pcall(vRP.computeInvWeight, user_id)
        if ok and type(current) == 'number' then
            invWeight = current
        end
    end

    local itemWeight = 0
    if _G.ItemWeight then
        local ok,current = pcall(_G.ItemWeight, item)
        if ok and type(current) == 'number' then
            itemWeight = current
        end
    elseif vRP.GetItemWeight then
        local ok,current = pcall(vRP.GetItemWeight, item)
        if ok and type(current) == 'number' then
            itemWeight = current
        end
    elseif vRP.getItemWeight then
        local ok,current = pcall(vRP.getItemWeight, item)
        if ok and type(current) == 'number' then
            itemWeight = current
        end
    end

    local maxWeight = 0
    if vRP.CheckWeight then
        local ok,current = pcall(vRP.CheckWeight, user_id)
        if ok and type(current) == 'number' then
            maxWeight = current
        end
    elseif vRP.GetWeight then
        local ok,current = pcall(vRP.GetWeight, user_id)
        if ok and type(current) == 'number' then
            maxWeight = current
        end
    elseif vRP.getInventoryMaxWeight then
        local ok,current = pcall(vRP.getInventoryMaxWeight, user_id)
        if ok and type(current) == 'number' then
            maxWeight = current
        end
    end

    if (invWeight + (itemWeight * itemAmount)) > maxWeight then
        return false, 'weight'
    end

    return true
end

src.playAnim = function(source, anim1, anim2)
    vCLIENT._playCraftAnim(source, { anim1, anim2 })
end

src.stopAnim = function(source)
    vCLIENT._stopCraftAnim(source)
end

src.progressBar = function(user_id, time)
    local source = nil

    if vRP.Source then
        local ok,result = pcall(vRP.Source, user_id)
        if ok and result then source = result end
    end

    if not source and vRP.getUserSource then
        local ok,result = pcall(vRP.getUserSource, user_id)
        if ok and result then source = result end
    end

    if source then
        TriggerClientEvent("progress", source, time)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LANGS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.lang = {
    notArmazemItem = function(source, mensagem, tipo) if tipo == "armazem" then TriggerClientEvent("Notify",source,"negado","O Armazem possui: <br>" ..mensagem) else TriggerClientEvent("Notify",source,"negado","Você possui: <br>" ..mensagem) end end,
    erroFabricar = function(source) TriggerClientEvent("Notify",source,"sucesso","Ocorreu um erro ao tentar fabricar esse item, tente novamente!") end,
    waitCraft = function(source, segundos) TriggerClientEvent("Notify",source,"sucesso","Aguarde, <b>"..segundos.." segundo(s)</b> para continuar.") end,
    armazemItens = function(source, mensagem) TriggerClientEvent("Notify",source,"importante","Itens do Armazem:<br> ".. mensagem)  end,
    notArmazemItens = function(source) TriggerClientEvent("Notify",source,"importante","Esse Armazem, não possui <b>itens</b>.")  end,
    notStoreItens = function(source) TriggerClientEvent("Notify",source,"importante","Você não possui itens que possa ser guardado no armazem.")  end,
    storeItens = function(source, mensagem) TriggerClientEvent("Notify",source,"importante","Você guardou:<br> "..mensagem)  end,
    backpackFull = function(source) TriggerClientEvent("Notify",source,"negado","Sua Mochila está cheia")  end,
    fabricandoItem = function(source) TriggerClientEvent("Notify",source,"negado","Aguarde, Você ja está fabricando um item.")  end,
}