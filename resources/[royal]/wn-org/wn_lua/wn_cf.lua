-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {}

-- Comandos
Config.Commands = {
    panel = {'org', 'painel'},
    adminPanel = 'paineladm',
    addBlacklist = 'addbl',
    removeBlacklist = 'rembl'
}

-- Permissões
Config.AdminPermission = 'Admin'

-- Blacklist
Config.Blacklist = {
    enabled = true,
    days = 2,
    value = 0,
    blockPayment = false
}

-- Ranking
Config.Ranking = {
    enabled = true,
    resetDays = 7
}

-- Discord
Config.Discord = {
    setPlayerOnDiscord = false,
    botToken = '',
    serverId = '',
    webhooks = {
        blacklist = 'https://discord.com/api/webhooks/1484594167165222932/ogqhqDn7aNmw3cWdbW3Q97MMBUH7LM5F6jk8wFIjx9R3Gw5Ok_HHQAkG2T4X9NXVnfVo',
        contract = 'https://discord.com/api/webhooks/1484595056924164111/Ex2yAPrCGN6Uor7gXEYGHat51dBlD8YidTQaZ_m4BdMcoEVkV8s1kYa5FtFD9lhekbEw',
        fire = 'https://discord.com/api/webhooks/1484595277146099963/TQoVuSTMTwoU51RtLtuIQodMDhQndM7_QrYtQ6zS9aVhQn85HHGx4pXUUCy0fv_33Q7N',
        promote = 'https://discord.com/api/webhooks/1484595434369581239/BdbgOWi_UGhs0oYbfBM4b86G_kqdJD3b-gSTwaRk3e3aJKohquoL1Sk8xA0jsyStNg9-',
        demote = 'https://discord.com/api/webhooks/1484595821541593088/0DTbRqP63NLMeiT02pYd8MBKWFyCfL0gw_VwcZ5ocAN6zoNuj7RmpDuWrSkTrjv4mRsq'
    }
}

-- Organizações disponíveis
Config.Organizations = {
    ["Medellin"] = {
        name = "Medellin",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "24",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Lider", permissions = { "all" } },
            [2] = { name = "Sub-Lider", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente-Geral", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Gerente", permissions = { "deposit","farm" } },
            [5] = { name = "Membro", permissions = { "deposit","farm" } },
            [6] = { name = "Novato", permissions = { "deposit","farm" } },
        }
    },

      ["Elements"] = {
        name = "Elements",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "25",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Lider", permissions = { "all" } },
            [2] = { name = "SubLider", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente-Geral", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Gerente", permissions = { "deposit","farm" } },
            [5] = { name = "Membro", permissions = { "deposit","farm" } },
            [6] = { name = "Novato", permissions = { "deposit","farm" } },
        }
    },
    
    ["Barragem"] = {
        name = "Barragem",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "25",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Lider", permissions = { "all" } },
            [2] = { name = "SubLider", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente-Geral", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Gerente", permissions = { "deposit","farm" } },
            [5] = { name = "Membro", permissions = { "deposit","farm" } },
            [6] = { name = "Novato", permissions = { "deposit","farm" } },
        }
    },
    
    ["Distrito22"] = {
        name = "Distrito22",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "26",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Lider", permissions = { "all" } },
            [2] = { name = "SubLider", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente-Geral", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Gerente", permissions = { "deposit","farm" } },
            [5] = { name = "Membro", permissions = { "deposit","farm" } },
            [6] = { name = "Novato", permissions = { "deposit","farm" } },
        }
    },
    
   ["Turquia"] = {
        name = "Turquia",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "27",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Lider", permissions = { "all" } },
            [2] = { name = "SubLider", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente-Geral", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Gerente", permissions = { "deposit","farm" } },
            [5] = { name = "Membro", permissions = { "deposit","farm" } },
            [6] = { name = "Novato", permissions = { "deposit","farm" } },
        }
    },

     ["BlackDiamond"] = {
        name = "BlackDiamond",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "27",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Lider", permissions = { "all" } },
            [2] = { name = "SubLider", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente-Geral", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Gerente", permissions = { "deposit","farm" } },
            [5] = { name = "Membro", permissions = { "deposit","farm" } },
            [6] = { name = "Novato", permissions = { "deposit","farm" } },
        }
    },
    
    ["Policiafederal"] = {
        name = "Policiafederal",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "190",
        images = { radio = "images/radio.png", clothes ='',
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Ministro", permissions = { "all" } },
            [2] = { name = "Secretario", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Comandogeral", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Comando", permissions = { "deposit","farm" } },
            [5] = { name = "Subcomando", permissions = { "deposit","farm" } },
            [6] = { name = "Major", permissions = { "deposit","farm" } },
        }
    },
    
    ["Acari"] = {
        name = "Acari",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "29",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    ["Pedreira"] = {
        name = "Pedreira",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "30",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["Campinho"] = {
        name = "Campinho",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "31",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["Jacare"] = {
        name = "Jacaré",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "32",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["CpxDaMare"] = {
        name = "Complexo da Maré",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "33",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["Providencia"] = {
        name = "Providência",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "34",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["Mandela"] = {
        name = "Mandela",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "35",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["Fallet"] = {
        name = "Fallet",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "36",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["CpxPenha"] = {
        name = "Complexo da Penha",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "37",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["MorroDoMacaco"] = {
        name = "Morro do Macaco",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "38",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["VigarioGeral"] = {
        name = "Vigário Geral",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "39",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    
    ["Chapadao"] = {
        name = "Chapadão",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "40",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        }
    },
    ["Rocinha"] = {
        name = "Rocinha",
        type = "Work",
        maxMembers = 100,
        initialMoney = 0,
        radioFrequency = "41",
        images = { radio = "images/radio.png", clothes = "images/clothes.png" },
        permissions = { canEditMeta = 1, canChangeRoles = 3, canUseBank = 1, canChangePix = 1 },
        disable = { disableMetas = false, disableFarm = false, disableRank = false },
        hierarchy = {
            [1] = { name = "Dono", permissions = { "all" } },
            [2] = { name = "Frente", permissions = { "deposit","withdraw_medium","hire","fire","promote","demote" } },
            [3] = { name = "Gerente", permissions = { "deposit","withdraw_small","hire","fire" } },
            [4] = { name = "Vapor", permissions = { "deposit","farm" } },
            [5] = { name = "Soldado", permissions = { "deposit","farm" } },
            [6] = { name = "Radinho", permissions = { "deposit","farm" } },
        },
    }},
}



-- Configurações de Banco
Config.Bank = {
    withdraw_limits = {
        small = 50000,
        medium = 100000,
        large = 500000
    },
    transaction_log_limit = 50
}

-- Configurações de Farm/Metas
Config.Farm = {
    enabled = true,
    default_goal = 1000,
    default_reward = 10000,
    reset_time = 604800 -- 7 dias em segundos
}

-- Itens de Farm (exemplo)
Config.FarmItems = {
    ["capsula"] = "Cápsula",
    ["algemas"] = "Algemas",
    ["lockpick"] = "Lockpick",
    ["cocaina"] = "Cocaína",
    ["metanfetamina"] = "Metanfetamina",
    ["maconha"] = "Maconha"
}

-- Permissões do sistema
Config.Permissions = {
    ["all"] = { "deposit", "withdraw_small", "withdraw_medium", "withdraw_large", "hire", "fire", "promote", "demote", "blacklist", "set_goal", "manage_bank", "view_logs" },
    ["deposit"] = "Depositar no banco",
    ["withdraw_small"] = "Sacar até 50000",
    ["withdraw_medium"] = "Sacar até 100000",
    ["withdraw_large"] = "Sacar até 500000",
    ["hire"] = "Contratar membros",
    ["fire"] = "Demitir membros",
    ["promote"] = "Promover membros",
    ["demote"] = "Rebaixar membros",
    ["blacklist"] = "Gerenciar blacklist",
    ["set_goal"] = "Definir metas",
    ["manage_bank"] = "Gerenciar banco",
    ["view_logs"] = "Ver logs",
    ["farm"] = "Fazer farm"
}
