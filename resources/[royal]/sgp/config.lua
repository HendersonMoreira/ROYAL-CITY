Config = {}

Config.Command = "patrulha"
Config.UpdateInterval = 3000
Config.RefreshBlipsInterval = 2000

Config.NotifyEnter = "Você entrou em patrulha."
Config.NotifyLeave = "Você saiu da patrulha."
Config.NotifyNoPerm = "Você não possui permissão para entrar em patrulha."
Config.NotifyFar = "Você precisa estar dentro da área da sua corporação."

Config.Groups = {
    ["PoliciaMilitar"] = {
        permission = "PoliciaMilitar",
        serviceCoords = vec3(1701.54,2600.84,49.49),
        serviceRadius = 50.0,

        serviceBlip = {
            color = 29,
            alpha = 100
        },

        patrolBlip = {
            sprite = 1,
            color = 29,
            scale = 0.85,
            name = "PM em Patrulha"
        },

        webhook = "https://discord.com/api/webhooks/1489280526467465358/8qnsnwiwQKpJiS9R_zR82ZMxq3kNwwYGSl5ndDN5Wi7ckSg3Hv1JDnmpLDDl8CCYGfkS"
    },

    ["PoliciaCivil"] = {
        permission = "PoliciaCivil",
        serviceCoords = vec3(452.12,-980.01,30.68),
        serviceRadius = 50.0,

        serviceBlip = {
            color = 38,
            alpha = 100
        },

        patrolBlip = {
            sprite = 1,
            color = 38,
            scale = 0.85,
            name = "PC em Patrulha"
        },

        webhook = "COLOQUE_WEBHOOK_PC_AQUI"
    },

    ["PRF"] = {
        permission = "PRF",
        serviceCoords = vec3(2609.82,5348.74,47.56),
        serviceRadius = 50.0,

        serviceBlip = {
            color = 5,
            alpha = 100
        },

        patrolBlip = {
            sprite = 1,
            color = 5,
            scale = 0.85,
            name = "PRF em Patrulha"
        },

        webhook = "COLOQUE_WEBHOOK_PRF_AQUI"
    }
}
