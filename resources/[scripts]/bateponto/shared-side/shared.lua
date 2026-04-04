BatePontoConfig = {
    DrawDistance = 20.0,
    InteractDistance = 1.5,
    Marker = {
        Type = 21,
        Scale = vector3(0.35,0.35,0.25),
        Color = { 0, 120, 255, 180 }
    },
    Blip = {
        Enabled = true,
        Sprite = 487,
        Color = 3,
        Scale = 0.7
    },
    Points = {
        {
            Name = "Bate Ponto Policia Militar",
            Permission = { "PoliciaMilitar", "Policiafederal", "Policia", "LSPD", "BCSO", "BCPR" },
            Coords = vector3(1699.89,2600.97,49.49)
        },
        {
            Name = "Bate Ponto Paramedico",
            Permission = "Paramedico",
            Coords = vector3(-2784.85,-78.72,18.6)
        },
        {
            Name = "Bate Ponto Mecanico",
            Permission = "Mecanica",
            Coords = vector3(-2034.58,-510.56,12.13)
        }
    }
}
