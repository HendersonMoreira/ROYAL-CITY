Config = {}

-- Permissão/grupo necessário para usar o desmanche.
Config.Permission = "Medellin"

-- Item de pagamento.
Config.PaymentItem = "dirtydollar"

-- Porcentagem do valor da lista que será paga.
Config.PaymentPercent = 1.0

-- Locais. AREA DE DESMANCHE
Config.Start = {
    { 51.0,-873.11,30.43,184.26 }, 
    { 1257.66,-2566.27,42.01 },
    {45.28,-899.41,29.96}

}

Config.Tools = { ---------- NAO ADC NADA AQUI
    { 61.64,-870.67,30.5 }, ------------ NAO ADC NADA AQUI
    { 1242.0,-2566.41,42.71,107.72 } ------- NAO ADC NADA AQUI
}

Config.Finish = { --- FINALIZAR DESMANCHE
    { 55.53,-874.68,30.43 },
    { 1241.49,-2563.35,42.92,107.72 },
    {30.03,-900.68,29.96}
}

-- Mensagens.
Config.NotifyWork = "<b>Esse veículo não pode ser</b> desmanchado."
Config.NotifyNoPermission = "<b>Você não possui</b> permissão."
Config.NotifyNoRegister = "<b>Esse veículo não está registrado.</b>"
Config.NotifyAlreadyDismantled = "<b>Esse veículo já consta como</b> desmanchado/apreendido."
Config.NotifyNotAllowed = "<b>Esse veículo não está na lista</b> de desmanche."

-- Lista de veículos permitidos no desmanche e valor pago em dirtydollar.
-- spawn = valor
Config.Vehicles = {
    ["brioso"] = 50000,
    ["blista"] = 35000,
    ["issi2"] = 40000,
    ["dilettante"] = 30000,
    ["prairie"] = 42000,
    ["asea"] = 38000,
    ["emperor"] = 45000,
    ["ingot"] = 48000,
    ["stanier"] = 52000,
    ["premier"] = 47000,
    ["baller"] = 65000,
    ["fq2"] = 60000,
    ["granger"] = 85000,
    ["seminole"] = 58000,
    ["dubsta"] = 90000,
    ["sultan"] = 80000,
    ["buffalo"] = 95000,
    ["schafter2"] = 88000,
    ["zion"] = 70000,
    ["oracle2"] = 83000,
    ["panto"] = 15000,
    ["g63"] = 85000

}

return Config
