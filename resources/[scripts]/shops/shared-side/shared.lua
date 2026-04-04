-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
ItemList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTARTSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Shop,v in pairs(List) do
		if not ItemList[Shop] then
			ItemList[Shop] = {}
		end

		for Item,Value in pairs(v["List"]) do
			local Number = #ItemList[Shop] + 1

			ItemList[Shop][Number] = {
				["name"] = ItemName(Item),
				["weight"] = ItemWeight(Item),
				["index"] = ItemIndex(Item),
				["rarity"] = ItemRarity(Item),
				["economy"] = ItemEconomy(Item),
				["desc"] = ItemDescription(Item),
				["key"] = Item,
				["price"] = Value
			}
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATION
-----------------------------------------------------------------------------------------------------------------------------------------
Location = {
	{ 
		["Coords"] = vec3(-542.87,-198.35,38.23),
		["Mode"] = "Identity"
	},{
		["Coords"] = vec3(-551.27,-203.09,38.23),
		["Mode"] = "Identity"
	},{
		["Coords"] = vec3(-544.76,-185.81,52.2),
		["Mode"] = "Identity2"
	},{ 
    ["Coords"] = vec3(24.9, -1346.8, 29.49),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(2556.74, 381.24, 108.61),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(1164.82, -323.65, 69.2),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-706.15, -914.53, 19.21),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-47.38, -1758.68, 29.42),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(373.1, 326.81, 103.56),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-3242.75, 1000.46, 12.82),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(1728.47, 6415.46, 35.03),
    ["Mode"] = "Departament"
	},{
    ["Coords"] = vec3(1960.2, 3740.68, 32.33),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(2677.8, 3280.04, 55.23),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(1697.31, 4923.49, 42.06),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-1819.52, 793.48, 138.08),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(1391.69, 3605.97, 34.98),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-2966.41, 391.55, 15.05),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-3039.54, 584.79, 7.9),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(1134.33, -983.11, 46.4),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(1165.28, 2710.77, 38.15),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-1486.72, -377.55, 40.15),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-1221.45, -907.92, 12.32),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(161.2, 6641.66, 31.69),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(-160.62, 6320.93, 31.58),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(548.7, 2670.73, 42.16),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(812.88, -782.08, 26.17),
    ["Mode"] = "Departament"
  },{
    ["Coords"] = vec3(1696.88, 3758.39, 34.69),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(248.17, -51.78, 69.94),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(841.18, -1030.12, 28.19),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(-327.07, 6082.22, 31.46),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(-659.18, -938.47, 21.82),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(-1309.43, -394.56, 36.7),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(-1113.41, 2698.19, 18.55),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(2564.83, 297.46, 108.73),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(-3168.32, 1087.46, 20.84),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(16.91, -1107.56, 29.79),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(814.84, -2155.14, 29.62),
    ["Mode"] = "Ammunation"
  },{
    ["Coords"] = vec3(-1083.15, -245.88, 37.76),
    ["Mode"] = "Premium"
  },{
    ["Coords"] = vec3(-1650.97,-995.93,13.01),
    ["Mode"] = "Fishing"
  },{
    ["Coords"] = vec3(1522.88, 3783.63, 34.47),
    ["Mode"] = "Fishing2"
  },{
    ["Coords"] = vec3(-695.56, 5802.12, 17.32),
    ["Mode"] = "Hunting"
  },{
    ["Coords"] = vec3(-679.13, 5839.52, 17.32),
    ["Mode"] = "Hunting2"
  },{
    ["Coords"] = vec3(-172.89, 6381.32, 31.48),
    ["Mode"] = "Pharmacy"
  },{
    ["Coords"] = vec3(1690.07, 3581.68, 35.62),
    ["Mode"] = "Pharmacy"
  },{
    ["Coords"] = vec3(326.5, -1074.43, 29.47),
    ["Mode"] = "Pharmacy"
  },{
    ["Coords"] = vec3(114.39, -4.85, 67.82),
    ["Mode"] = "Pharmacy"
  },{
    ["Coords"] = vec3(311.97, -597.66, 43.29),
    ["Mode"] = "Paramedic"
  },{
    ["Coords"] = vec3(-254.64, 6326.95, 32.82),
    ["Mode"] = "Paramedic"
  },{
    ["Coords"] = vec3(82.98, -1553.55, 29.59),
    ["Mode"] = "Recycle"
  },{
    ["Coords"] = vec3(287.77, 2843.9, 44.7),
    ["Mode"] = "Recycle"
  },{
    ["Coords"] = vec3(-413.97, 6171.58, 31.48),
    ["Mode"] = "Recycle"
  },{
    ["Coords"] = vec3(487.3, -997.08, 30.68),
    ["Mode"] = "Police"
  },{
    ["Coords"] = vec3(1838.43, 3686.29, 34.19),
    ["Mode"] = "Police"
  },{
    ["Coords"] = vec3(-447.15, 6016.51, 36.99),
    ["Mode"] = "Police"
  },{
    ["Coords"] = vec3(385.5, 799.94, 190.49),
    ["Mode"] = "Police"
  },{
    ["Coords"] = vec3(362.37, -1603.12, 25.44),
    ["Mode"] = "Police"
  },{
    ["Coords"] = vec3(-628.79, -238.7, 38.05),
    ["Mode"] = "Miners"
  },{
    ["Coords"] = vec3(475.1, 3555.28, 33.23),
    ["Mode"] = "Criminal"
  },{
    ["Coords"] = vec3(112.41, 3373.68, 35.25),
    ["Mode"] = "Criminal2"
  },{
    ["Coords"] = vec3(2013.95, 4990.88, 41.21),
    ["Mode"] = "Criminal3"
  },{
    ["Coords"] = vec3(186.9, 6374.75, 32.33),
    ["Mode"] = "Criminal4"
  },{
    ["Coords"] = vec3(-653.12, -1502.67, 5.22),
    ["Mode"] = "Criminal"
  },{
    ["Coords"] = vec3(389.71, -942.61, 29.42),
    ["Mode"] = "Criminal2"
  },{
    ["Coords"] = vec3(154.98, -1472.47, 29.35),
    ["Mode"] = "Criminal3"
  },{
    ["Coords"] = vec3(488.1, -1456.11, 29.28),
    ["Mode"] = "Criminal4"
  },{
    ["Coords"] = vec3(169.76, -1535.88, 29.25),
    ["Mode"] = "Weapons"
  },{
    ["Coords"] = vec3(301.14, -195.75, 61.57),
    ["Mode"] = "Weapons"
  },{
    ["Coords"] = vec3(836.58, -808.25, 26.35),
    ["Mode"] = "Mechanic"
  },{
    ["Coords"] = vec3(-1636.74, -1092.17, 13.08),
    ["Mode"] = "Oxy"
  },{
    ["Coords"] = vec3(-1196.9, -901.58, 13.99),
    ["Mode"] = "BurgerShot"
  },{
    ["Coords"] = vec3(806.22, -761.68, 26.77),
    ["Mode"] = "PizzaThis"
  },{
    ["Coords"] = vec3(-588.5, -1066.23, 22.34),
    ["Mode"] = "UwuCoffee"
  },{
    ["Coords"] = vec3(124.01, -1036.72, 29.27),
    ["Mode"] = "BeanMachine"
  },{
    ["Coords"] = vec3(-1127.26, -1439.35, 5.22),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(78.26, -1388.91, 29.37),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-706.73, -151.38, 37.41),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-166.69, -301.55, 39.73),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-817.5, -1074.03, 11.32),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-1197.33, -778.98, 17.32),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-1447.84, -240.03, 49.81),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-0.07, 6511.8, 31.88),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(1691.6, 4818.47, 42.06),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(123.21, -212.34, 54.56),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(621.24, 2753.37, 42.09),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(1200.68, 2707.35, 38.22),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-3172.39, 1055.31, 20.86),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-1096.53, 2711.1, 19.11),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(422.7, -810.25, 29.49),
    ["Mode"] = "Clothes"
  },{
    ["Coords"] = vec3(-1174.54, -1571.4, 4.35),
    ["Mode"] = "Weeds"
  },{
    ["Coords"] = vec3(-2075.88,-517.79,12.15),
    ["Mode"] = "Mecanica"
  },{
    ["Coords"] = vec3(-2038.5,-491.24,12.11),
    ["Mode"] = "MecanicaPublica"
  },{
	["Coords"] = vec3(1706.81,2573.33,54.02),
	["Mode"] = "PoliciaMilitar"
  }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
List = {
	["Ammunation"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_COMBATPISTOL"] = 1,
			["energetico"] = 1,
			["WEAPON_STUNGUN"] = 1,
			["WEAPON_CARBINERIFLE"] = 1,
			["handcuff"] = 1,
			["WEAPON_NIGHTSTICK"] = 1,
			["WEAPON_HAMMER"] = 975
		}
	},
	["Mecanica"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Mecanica",
		["List"] = {
			["toolbox"] = 1000,
			["tyres"] = 1000,
			["WEAPON_WRENCH"] = 1000
		}
	},
	["MecanicaPublica"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["toolbox"] = 10000,
			["tyres"] = 4000,
			["WEAPON_WRENCH"] = 7000
		}
	},
	["Departament"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["postit"] = 20,
			["cigarette"] = 15,
			["lighter"] = 225,
			["water"] = 35,
			["hamburger"] = 25,
			["hotdog"] = 20,
			["soda"] = 20,
			["donut"] = 15,
			["sugarbox"] = 35,
			["condensedmilk"] = 25,
			["mayonnaise"] = 20,
			["ryebread"] = 20,
			["ricebag"] = 105,
			["cellphone"] = 200,
			["radio"] = 200,
			["backpackp"] = 500,
			["energetico"] = 250
		}
	},
	["Megamall"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["boilies"] = 5,
			["rope"] = 925,
			["scuba"] = 975,
			["notepad"] = 10,
			["suitcase"] = 275,
			["WEAPON_BRICK"] = 25,
			["WEAPON_SHOES"] = 25,
			["alliance"] = 525,
			["GADGET_PARACHUTE"] = 225,
			["axe"] = 1225,
			["pickaxe"] = 1225,
			["fishingrod"] = 1225,
			["emptypurifiedwater"] = 1275
		}
	},
	["Eletronics"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["radio"] = 975,
			["vape"] = 4750,
			["cellphone"] = 725,
			["camera"] = 425,
			["binoculars"] = 425
		}
	},
	["Clandestine"] = {
		["Mode"] = "Sell",
		["Type"] = "Consume",
		["Item"] = "dirtydollar",
		["List"] = {
			["scotchtape"] = 45,
			["insulatingtape"] = 55,
			["rammemory"] = 375,
			["powersupply"] = 475,
			["processorfan"] = 325,
			["processor"] = 725,
			["screws"] = 45,
			["screwnuts"] = 45,
			["videocard"] = 4225,
			["ssddrive"] = 525,
			["safependrive"] = 3225,
			["powercable"] = 225,
			["weaponparts"] = 125,
			["electroniccomponents"] = 375,
			["batteryaa"] = 225,
			["batteryaaplus"] = 275,
			["goldnecklace"] = 625,
			["silverchain"] = 425,
			["horsefigurine"] = 2425,
			["toothpaste"] = 175,
			["techtrash"] = 95,
			["tarp"] = 65,
			["sheetmetal"] = 65,
			["roadsigns"] = 65,
			["explosives"] = 105,
			["sulfuric"] = 75,
			["races"] = 425,
			["pistolbody"] = 275,
			["smgbody"] = 525,
			["riflebody"] = 975,
			["pager"] = 425
		}
	},
	["Coffee"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["coffeecup"] = 20
		}
	},
	["Soda"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cola"] = 20,
			["soda"] = 20,
			["water"] = 35
		}
	},
	["Donut"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["donut"] = 15,
			["chocolate"] = 20
		}
	},
	["Hamburger"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hamburger"] = 25
		}
	},
	["Hotdog"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hotdog"] = 20
		}
	},
	["Chihuahua"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hotdog"] = 20,
			["hamburger"] = 25,
			["cola"] = 20,
			["soda"] = 20,
			["water"] = 35
		}
	},
	["Water"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["water"] = 35
		}
	},
	["Cigarette"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cigarette"] = 15,
			["lighter"] = 225
		}
	},
	["Fuel"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_PETROLCAN"] = 325
		}
	},
	["Pharmacy"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["bandage"] = 115,
			["gauze"] = 75,
			["analgesic"] = 65,
			["sinkalmy"] = 185,
			["ritmoneury"] = 235,
			["medkit"] = 285,
			["adrenaline"] = 3225
		}
	},
	["Paramedico"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Paramedico",
		["List"] = {
			["syringe01"] = 45,
			["syringe02"] = 45,
			["syringe03"] = 45,
			["syringe04"] = 45,
			["bandage"] = 115,
			["gauze"] = 75,
			["gdtkit"] = 25,
			["medkit"] = 285,
			["sinkalmy"] = 185,
			["analgesic"] = 65,
			["ritmoneury"] = 235,
			["medicbag"] = 725,
			["adrenaline"] = 3225
		}
	},
	["Hunting"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["boar1star"] = 275,
			["boar2star"] = 300,
			["boar3star"] = 325,
			["deer1star"] = 275,
			["deer2star"] = 300,
			["deer3star"] = 325,
			["coyote1star"] = 275,
			["coyote2star"] = 300,
			["coyote3star"] = 325,
			["mtlion1star"] = 275,
			["mtlion2star"] = 300,
			["mtlion3star"] = 325
		}
	},
	["Hunting2"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["ration"] = 125,
			["WEAPON_MUSKET"] = 4225,
			["WEAPON_MUSKET_AMMO"] = 10
		}
	},
	["Fishing"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["sardine"] = 65,
			["smalltrout"] = 65,
			["orangeroughy"] = 65,
			["anchovy"] = 70,
			["catfish"] = 70,
			["herring"] = 75,
			["yellowperch"] = 75,
			["salmon"] = 125,
			["smallshark"] = 250
		}
	},
	["Miners"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["tin_pure"] = 40,
			["lead_pure"] = 40,
			["copper_pure"] = 42,
			["iron_pure"] = 45,
			["gold_pure"] = 50,
			["diamond_pure"] = 50,
			["ruby_pure"] = 60,
			["sapphire_pure"] = 60,
			["emerald_pure"] = 75
		}
	},
	["Police"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Policia",
		["List"] = {
			["gsrkit"] = 25,
			["gdtkit"] = 25,
			["barrier"] = 25,
			["handcuff"] = 125,
			["spikestrips"] = 275
		}
	},
	["PoliciaMilitar"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "PoliciaMilitar",
		["List"] = {
			["WEAPON_CARBINERIFLE"] = 1,
			["WEAPON_COMBATPISTOL"] = 1,
			["WEAPON_NIGHTSTICK"] = 1,
			["WEAPON_STUNGUN"] = 1,
			["handcuff"] = 1,
			["cellphone"] = 1,
			["energetico"] = 1,
			["WEAPON_PISTOL_AMMO"] = 1
		}
	}
}