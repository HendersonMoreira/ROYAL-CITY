-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Rolepass = 1767225599
SalaryCooldowns = 1800
ArenaCoords = vec3(-1046.33,-473.2,36.68)
PrisonCoords = vec3(1896.15,2604.44,45.75)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERINFO
-----------------------------------------------------------------------------------------------------------------------------------------
Currency = "$"
BaseMode = "license"
Whitelisted = true
ServerName = "Royal City"
ServerLink = "https://discord.gg/royalcitygg"
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
SpawnCoords = {
	vec3( -1068.21,-2791.88,20.96)  
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTUREPACK
-----------------------------------------------------------------------------------------------------------------------------------------
TexturePack = {
	"Drop","E","H","Normal","Selected"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEME
-----------------------------------------------------------------------------------------------------------------------------------------
Theme = {
	["currency"] = Currency,
	["main"] = "#2e2e2e",
	["common"] = "#6fc66a",
	["rare"] = "#6ac6c5",
	["epic"] = "#c66a75",
	["legendary"] = "#c6986a",
	["accept"] = {
		letter = "#dcffe9",
		background = "#3fa466"
	},
	["reject"] = {
		letter = "#ffe8e8",
		background = "#ad4443"
	},
	["shadow"] = true,
	["main-text"] = "#ffffff",
	["loading-progress"] = true,
	["chat"] = {
		["Families"] = {
			background = "#ff0000",
			letter = "#ffffff"
		},
		["Ballas"] = {
			background = "#00ff00",
			letter = "#ffffff"
		},
		["Vagos"] = {
			background = "#0000ff",
			letter = "#ffffff"
		},
		["Elements"] = {
			background = "FFFF5C5C",
			letter = "#ffffff"
		}
	},
	["hud"] = {
		["modes"] = {
			info = 3, -- [ Opções disponíveis: 1,2,3 ],
			icon = "fill", -- [ Opções disponíveis: fill,line ],
			status = 10, -- [ Opções disponíveis: 1 a 12 ],
			vehicle = 3 -- [ Opções disponíveis: 1,2,3 ]
		},
		["percentage"] = true,
		["icons"] = "#FFFFFF",
		["nitro"] = "#f69d2a",
		["rpm"] = "#FFFFFF",
		["fuel"] = "#f94c54",
		["engine"] = "#ff4c55",
		["health"] = "#76B984",
		["armor"] = "#A66FED",
		["hunger"] = "#F4B266",
		["thirst"] = "#7FC8F8",
		["stress"] = "#E287C9",
		["luck"] = "#F18A7C",
		["dexterity"] = "#E4E76E",
		["repose"] = "#7FCCC7",
		["pointer"] = "#ef4444",
		["progress"] = {
			background = "#FFFFFF",
			circle = "#2e2e2e",
			letter = "#FFFFFF"
		}
	},
	["notifyitem"] = {
		add = {
			letter = "#dcffe9",
			background = "#3fa466"
		},
		remove = {
			letter = "#ffe8e8",
			background = "#ad4443"
		}
	},
	["pause"] = {
		premium = true,
		store = true,
		battlepass = true,
		boxes = true,
		marketplace = true,
		skinweapon = true,
		map = true,
		settings = true,
		disconnect = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Admin"] = {
		["Permission"] = {
			["Admin"] = true,
			["Devteste"] = true
		},
		["Hierarchy"] = { "Ceo","DiretorOper","Diretor","Coordenador","HeadStaff","HC","Administrador","Moderador","Support","Helper" },
		["Service"] = {},
		["Client"] = true
	},

	["Premium"] = {
		["Permission"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Ouro","Prata","Bronze" },
		["Salary"] = { 3750,2500,1250 },
		["Service"] = {},
		["Client"] = true,
		["Block"] = true
	},
	["LSPD"] = {
		["Permission"] = {
			["LSPD"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" },
		["Salary"] = { 3750,3625,3500,3375,3250,3125 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},

	["Policia"] = {
		["Permission"] = {
			["Policia"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" },
		["Salary"] = { 3750,3625,3500,3375,3250,3125 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
	["PoliciaMilitar"] = {
	["Permission"] = {
		["PoliciaMilitar"] = true
	},
	["Hierarchy"] = {"MINISTRO DA DEFESA","SECRETARIO DA DEFESA","COMANDO-GERAL","COMANDO","SUB-COMANDO","TENENTE CORONEL","SUB-TENENTE CORONEL","MAJOR","1-TENENTE","2-TENENTE","1-SARGENTE","2-SARGENTE","CABO","SOLDADO","ALUNO","PAISANA"
	},
	["Salary"] = { 40000,30000,35000,3375,3250,3125,1200,1200,1200,1200,100,120,120,120,120,000 }, --- DEIXA NUMERO DA ULTIMA VIRGULA ZERADO
	["Service"] = {},
	["Type"] = "Work",
	["Client"] = true,
	["Markers"] = true,
	["Chat"] = true
},
	
	["BCPR"] = {
		["Permission"] = {
			["BCPR"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" },
		["Salary"] = { 3750,3625,3500,3375,3250,3125 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
	["Paramedico"] = {
		["Permission"] = {
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe","Médico","Enfermeiro","Residente" },
		["Salary"] = { 3750,3625,3500,3375 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
	["Vagos"] = {
		["Permission"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Families"] = {
		["Permission"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Marabunta"] = {
		["Permission"] = {
			["Marabunta"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Bennys"] = {
		["Permission"] = {
			["Bennys"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Aztecas"] = {
		["Permission"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Bahamas"] = {
		["Permission"] = {
			["Bahamas"] = true
		},
		["Hierarchy"] = { "Líder","Sub-Líder","Membro","Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Restaurante"] = {
		["Permission"] = {
			["Restaurante"] = true
		},
		["Hierarchy"] = { "Chefe","Supervisor","Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Camera"] = {
		["Permission"] = {
			["Camera"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {}
	},
	["Policia"] = {
		["Permission"] = {
			["LSPD"] = true,
			["BCSO"] = true,
			["BCPR"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {}
	},
	["Emergencia"] = {
		["Permission"] = {
			["LSPD"] = true,
			["BCSO"] = true,
			["BCPR"] = true,
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {}
	},
	["Booster"] = {
		["Permission"] = {
			["Booster"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Salary"] = { 2500 },
		["Service"] = {}
	},


--------------------------------------------------------------------------------------------------------------------------------------------
---- ORGS LEGAIS
--------------------------------------------------------------------------------------------------------------------------------------------
	["PoliciaMilitar"] = {
		["Permission"] = {
			["PoliciaMilitar"] = true
		},
		["Hierarchy"] = {"MINISTRO DA DEFESA","SECRETARIO DA DEFESA","SUPERVISOR","COMANDO-GERAL","COMANDO","SUB-COMANDO","TENENTE CORONEL","SUB-TENENTE CORONEL","MAJOR","1-TENENTE","2-TENENTE","1-SARGENTE","2-SARGENTE","CABO","SOLDADO","ALUNO","PAISANA"
		},
		["Salary"] = { 40000,30000,35000,3375,3250,3125,1200,1200,1200,100,1200,100,120,120,120,120,000 }, --- DEIXA NUMERO DA ULTIMA VIRGULA ZERADO
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
	["BOPE"] = {
		["Permission"] = {
			["bope"] = true
		},
		["Hierarchy"] = { "Comandante","Sob Comando","Majo","Capitão","1 Tenent","2 Tenent","Aspirant","Subtenente","1 Sargento","2 Sargento","3 Sargento","Cabo","Soldado" },
		["Salary"] = { 12000,11000,10000,9000,8000,7000,6000,5000,4500,4000,3500,3000,2500 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
	["Policiafederal"] = {
		["Permission"] = {
			["Policiafederal"] = true
		},
		["Hierarchy"] = { "MINISTRO DA DEFESA","SECRETARIO DA DEFESA","SUPERVISOR","COMANDO-GERAL","COMANDO","PAISANA" },
		["Salary"] = { 60000,40000,32000,26000,23000,18000,00 }, --- DEIXA NUMERO DA ULTIMA VIRGULA ZERADO
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
	["Mecanica"] = {
		["Permission"] = {
			["Mecanica"] = true
		},
		["Hierarchy"] = { "Mecanico Chefe","Mecanico","Mecanico Especialista","Mecanico de manutencao","Auxiliar","Novato" },
		["Salary"] = { 5000,4000,3000,2000,1000,00 }, --- DEIXA NUMERO DA ULTIMA VIRGULA ZERADO  Auxiliar, Mec de Manu, Mec Especialista, Mec, MEc Chefe
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},

	
--------------------------------------------------------------------------------------------------------------------------------------------
---- ORGS ILEGAIS
--------------------------------------------------------------------------------------------------------------------------------------------
["Medellin"] = {
		["Permission"] = {
			["Medellin"] = true
		},
		["Hierarchy"] = { "Lider","Sub-lider","Gerente-Geral","Gerente","Membro","Novato" },
		["Salary"] = { 5000,5000,5000,5000,5000,0 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},

	["Barragem"] = {
		["Permission"] = {
			["Barragem"] = true
		},
		["Hierarchy"] = { "Lider","Sub-lider","Gerente-Geral","Gerente","Membro","Novato" },
		["Salary"] = { 5000,5000,5000,5000,5000,0 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},


["Elements"] = {
		["Permission"] = {
			["Elements"] = true
		},
		["Hierarchy"] = { "Lider","Sublider","Gerente-Geral","Gerente","Membro","Novato" },
		["Salary"] = { 5000,5000,5000,5000,5000,0 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
["Distrito22"] = {
		["Permission"] = {
			["Distrito22"] = true
		},
		["Hierarchy"] = { "Lider","SubLider","Gerente-Geral","Gerente","Membro","Novato" },
		["Salary"] = { 5000,5000,5000,5000,5000,0 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	},
["Turquia"] = {
		["Permission"] = {
			["Turquia"] = true
		},
		["Hierarchy"] = { "Lider","SubLider","Gerente-Geral","Gerente","Membro","Novato" },
		["Salary"] = { 5000,5000,5000,5000,5000,0 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Markers"] = true,
		["Chat"] = true
	}

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------
Maintenance = true
MaintenanceText = "Servidor em manutenção"
MaintenanceLicenses = {
	["9da1f290e614d23408ab16f966913ab12221d278"] = true,  ---- japa
	["6ea8afba47b53f116d38b599cb8f6e28dd9f33e2"] = true,  ---- Trem
	["884a36657d491ccc4b05e19629389402cd4de83f"] = true,  ----- kuan 
	["e7c84aba0c7cbfcae550934515e9f94c54359d60"] = true,   ----- DG
	["d68f12f42e41a872d56b19e86a8f12d4f94a8663"] = true,   ----- TioFiu
	["566540f03ca9fbf4a3f29c1ed2d59182df388743"] = true  ----- erick show 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA (Itens recebidos ao entrar na arena)
-----------------------------------------------------------------------------------------------------------------------------------------
ArenaItens = {
	["WEAPON_COMBATPISTOL"] = 1,
	["WEAPON_PISTOL_MK2"] = 1,
	["WEAPON_PISTOL_AMMO"] = 1000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS (Itens recebidos ao criar o personagem)
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = {
	["water"] = 5,
	["hamburger"] = 5,
	["cellphone"] = 1,
	["dollar"] = 25000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOPINIT
-----------------------------------------------------------------------------------------------------------------------------------------
SkinshopInit = {
	["mp_m_freemode_01"] = {
		["pants"] = { item = 4, texture = 1 },
		["arms"] = { item = 0, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 273, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 1, texture = 6 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["pants"] = { item = 4, texture = 1 },
		["arms"] = { item = 14, texture = 0 },
		["tshirt"] = { item = 3, texture = 0 },
		["torso"] = { item = 338, texture = 2 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 1, texture = 6 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOPINIT
-----------------------------------------------------------------------------------------------------------------------------------------
BarbershopInit = {
	["mp_m_freemode_01"] = { 13,25,0,3,0,-1,-1,-1,-1,13,38,38,0,0,0,0,0.5,0,0,1,0,10,1,0,1,0.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
	["mp_f_freemode_01"] = { 13,25,1,3,0,-1,-1,-1,-1,1,38,38,0,0,0,0,1,0,0,1,0,0,0,0,1,0.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
}