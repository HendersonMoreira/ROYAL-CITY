Config = {}

Config.Database = {
    Table = "characters",
    Id = "id",
    Prison = "prison"
}

Config.Prison = {
    Enter = vec3(1598.25,2607.08,46.66),
    Exit = vec3(1853.35,2615.97,45.66),
    EnterHeading = 268.0,
    ExitHeading = 90.0,
    EscapeDistance = 65.0,
    ReducePerMinute = 1
}

Config.PrisonPermissions = {
    Prender = {
        { Group = "Admin", MaxHierarchy = 1 },
        { Group = "Policia", MaxHierarchy = 3 },
        { Group = "PM", MaxHierarchy = 3 }
    },
    Soltar = {
        { Group = "Admin", MaxHierarchy = 1 },
        { Group = "Policia", MaxHierarchy = 3 }
    }
}

Config.BoxSystem = {
    Pickup = vec3(1582.92,2578.86,46.91),
    Delivery = vec3(1622.33,2651.16,46.74),
    Distance = 1.5,
    MarkerDistance = 15.0,
    ReducePerBox = 2,
    Prop = "prop_cs_cardbox_01",
    Bone = 57005,
    PropPosition = { x = 0.03, y = 0.08, z = -0.28 },
    PropRotation = { x = 25.0, y = 290.0, z = 175.0 }
}

Config.Fine = {
    Command = "multa",
    CheckCommand = "vermulta",
    Permissions = {
        { Group = "PoliciaMilitar", MaxHierarchy = nil },
        { Group = "Admin", MaxHierarchy = nil }
    },
    MinValue = 1,
    MaxValue = 100000000,
    RequireReason = true,
    NotifyOfficer = true,
    NotifyTarget = true
}

Config.Logs = {
    Prender = {
        Webhook = "https://discord.com/api/webhooks/1489056595240419338/1Sczpk1yhvOJw8BRxO07XJ6TASmg3h5BnN4hAUfywPCht7mIOHHzJUcQEa7u6SLh9t8A",
        Color = 16711680
    },
    Soltar = {
        Webhook = "https://discord.com/api/webhooks/1489056683861999687/eNL061HLfFq1B5R0mLIqpgY5wChpIW2j_Xg6dW716ERDPHmnIfuJIjlXIYmlQs-F8jKL",
        Color = 65280
    },
    Multa = {
        Webhook = "https://discord.com/api/webhooks/1489387852268568667/VZFMnkgacnue4GJRUH44LHmBc3cGKPuo8NlYBP1wl_V_aje93hcM1eU5oduc6X4EhePl",
        Color = 16744192
    }
}
