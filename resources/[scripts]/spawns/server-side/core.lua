-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("spawn",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Licensed = {}
local Connected = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Characters()
	local Characters = {}
	local source = source
	local License = vRP.Identities(source)

	exports["vrp"]:Bucket(source,"Enter",50000 + source)

	local Consult = vRP.Query("characters/Characters",{ license = License })
	for _,v in ipairs(Consult) do
		local Datatable = vRP.UserData(v["id"],"Datatable")
		if Datatable then
		local Passport = tonumber(v.id)

		table.insert(Characters,{
			Passport = Passport,
			Skin = Datatable.Skin,
			Nome = v.name.." "..v.name2,
			Sexo = v.sex,
			Banco = v.bank,
			Blood = Sanguine(v.blood),
			Clothes = vRP.UserData(Passport,"Clothings"),
			Barber = vRP.UserData(Passport,"Barbershop"),
			Tattoos = vRP.UserData(Passport,"Tattooshop")
		})
	end
end

	return Characters
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CharacterChosen(Passport)
	local source = source
	local license = vRP.Identities(source)
	local Consult = vRP.Query("characters/UserLicense", { id = Passport, license = license})
	if Consult and Consult[1] then		
		exports["vrp"]:Bucket(source,"Exit")	 
	  vRP.CharacterChosen(source, Passport)
	  return true
	else
	  DropPlayer(source,"Conectando em personagem irregular.")
	end	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.NewCharacter(Name,Lastname,Sex)
	local source = source
	if Active[source] then
		return false
	end

	Active[source] = true

	local License = vRP.Identities(source)
	local Account = vRP.Account(License)
	local Characters = vRP.Query("characters/countPersons",{ license = License })

	if parseInt(Account["chars"]) <= parseInt(Characters[1]["qtd"]) then
		TriggerClientEvent("Notify",source,"Atenção","Limite de personagem atingido.","amarelo",5000)
		Active[source] = nil

		return false
	end

	local Sexo = "M"
	if Sex == "mp_f_freemode_01" then
		Sexo = "F"
	end

	vRP.Query("characters/newCharacter",{ license = License, name = Name, name2 = Lastname, sex = Sexo, phone = GeneratePhone(), blood = math.random(4) })

	local Consult = vRP.Query("characters/lastCharacters",{ license = License })
	if Consult[1] then
		exports["vrp"]:Bucket(source,"Exit")
		vRP.CharacterChosen(source,Consult[1]["id"],Sex)
	end

	Active[source] = nil

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	local License = Connected[Passport]
	if License then
		Connected[Passport] = nil
		Licensed[License] = nil
	end

	if Active[source] then
		Active[source] = nil
	end
end)