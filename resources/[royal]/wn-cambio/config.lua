Config = {}

Config.OpenKey = 38
Config.DrawDistance = 10.0
Config.InteractDistance = 1.5

Config.Texts = {
    target = "[E] ABRIR LAVAGEM",
    noPermission = "Você não tem permissão para acessar.",
    invalidAmount = "Quantidade inválida.",
    minAmount = "Quantidade abaixo do mínimo permitido.",
    stepAmount = "Quantidade inválida para essa operação.",
    noItem = "Você não possui a quantidade necessária.",
    noWeight = "Mochila sem espaço.",
    noBankFunction = "Função de banco não encontrada na sua base.",
    success = "Troca realizada com sucesso."
}

Config.Locations = {
    {
        id = "medellin",
        name = "Lavagem Medellin",
        coords = vec3(830.48,184.33,81.44),
        permission = "Medellin",
        hierarchy = 2,
        fromItem = "dirtydollar",
        toItem = "dollar",
        receiveMode = "bank",
        rate = 0.90,
        minAmount = 100,
        step = 100,
        fromLabel = "Dinheiro sujo",
        toLabel = "Dinheiro",
        requiredItems = {
            { item = "ssddrive", label = "ssddrive", amount = 1, consume = true },
            { item = "screws", label = "Chip de Lavagem", amount = 1, consume = true }
        },
        requiredPerStep = false,
        webhook = "https://discord.com/api/webhooks/1487857261488373802/qp0p3J4VAeGfqfqS0u6iSTnHvYLUlcS1S_lkRa6gdH4OGPizqhV63zzDhc-v3w5vqXkk"
    },
    {
        id = "cambio_ballas",
        name = "Câmbio Ballas",
        coords = vec3(115.85,-1950.32,20.75),
        permission = "Ballas",
        hierarchy = 3,
        fromItem = "dirtydollar",
        toItem = "dollar",
        receiveMode = "bank",
        rate = 0.75,
        minAmount = 100,
        step = 100,
        fromLabel = "Dirty Dollar",
        toLabel = "Dollar",
        requiredItem = "pendrive",
        requiredItemLabel = "Pendrive",
        requiredAmount = 1,
        requiredPerStep = false,
        consumeRequiredItem = true,
        webhook = "COLOCA_WEBHOOK_BALLAS_AQUI"
    },
    {
        id = "cambio_vagos",
        name = "Câmbio Vagos",
        coords = vec3(344.52,-2021.86,22.39),
        permission = "Vagos",
        hierarchy = 1,
        fromItem = "dirtydollar",
        toItem = "dollar",
        receiveMode = "bank",
        rate = 0.80,
        minAmount = 100,
        step = 100,
        fromLabel = "Dirty Dollar",
        toLabel = "Dollar",
        requiredItem = "pendrive",
        requiredItemLabel = "Pendrive",
        requiredAmount = 1,
        requiredPerStep = false,
        consumeRequiredItem = true,
        webhook = "COLOCA_WEBHOOK_VAGOS_AQUI"
    }
}