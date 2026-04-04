Config = {}

Config.Command = "mdt"
Config.OpenKey = "M"
Config.TabletTitle = "Terminal Policial"
Config.LoadingText = "Abrindo terminal policial"
Config.LoadingSubText = "Sincronizando dados operacionais..."

Config.Database = {
    identities = {
        table = "characters",
        id = "id",
        name = "name",
        lastname = "name2",
        phone = "phone",
        bank = "bank",
        sex = "sex"
    },
    vehicles = {
        table = "vehicles",
        owner = "Passport",
        model = "vehicle",
        plate = "plate"
    }
}

Config.Polices = {
    ["pm"] = {
        label = "Polícia Militar",
        short = "PM",
        color = "#2f6dff",
        permissionKey = "PoliciaMilitar",
        groupName = "PoliciaMilitar",
        hierarchy = {
            [1] = "MINISTRO DA DEFESA",
            [2] = "SECRETARIO DA DEFESA",
            [3] = "SUPERVISOR",
            [4] = "COMANDO GERAL",
            [5] = "COMANDO",
            [6] = "SUB COMANDO",
            [7] = "TENENTE CORONEL",
            [8] = "SUB TENENTE CORONEL",
            [9] = "MAJOR",
            [10] = "1 TENENTE",
            [11] = "2 TENENTE",
            [12] = "1 SARGENTO",
            [13] = "2 SARGENTO",
            [14] = "CABO",
            [15] = "SOLDADO",
            [16] = "ALUNO",
            [17] = "PAISANA"
        },
        permissions = {
            members = {
                hire = 9,
                promote = 6,
                demote = 6,
                fire = 6
            },
            bank = {
                withdraw = 5,
                deposit = 16,
                transfer = 5
            },
            penal = {
                createOccurrence = 16,
                prison = 15
            },
            articles = {
                create = 2,
                edit = 2,
                delete = 2
            },
            notices = {
                create = 5
            },
            boletins = {
                create = 16,
                edit = 16,
                delete = 16
            },
            procurados = {
                create = 5,
                delete = 2
            },
            procurados = {
                create = 5,
                delete = 2
            }
        }
    },
    ["pf"] = {
        label = "Polícia Federal",
        short = "PF",
        color = "#d4af37",
        permissionKey = "Policiafederal",
        groupName = "Policiafederal",
        hierarchy = {
            [1] = "MINISTRO DA DEFESA",
            [2] = "SECRETARIO DA DEFESA",
            [3] = "SUPERVISOR",
            [4] = "COMANDO GERAL",
            [5] = "COMANDO",
            [6] = "PAISANA"
        },
        permissions = {
            members = {
                hire = 2,
                promote = 1,
                demote = 2,
                fire = 1
            },
            bank = {
                withdraw = 1,
                deposit = 6,
                transfer = 1
            },
            penal = {
                createOccurrence = 1,
                prison = 3
            },
            articles = {
                create = 1,
                edit = 2,
                delete = 1
            },
            notices = {
                create = 5
            },
            boletins = {
                create = 5,
                edit = 2,
                delete = 1
            },
            procurados = {
                create = 5,
                delete = 2
            }
        }
    }
}

Config.ServiceChecker = function(source, passport, policeId)
    return true
end


Config.TryApplyVRPGroupHierarchy = false
