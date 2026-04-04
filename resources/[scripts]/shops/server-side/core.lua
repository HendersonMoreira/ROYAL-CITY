-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("shops",Creative)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Name)
	local source = source
	local Passport = vRP.Passport(source)

	return Passport and List[Name] and (not List[Name]["Permission"] or (List[Name]["Permission"] and vRP.HasService(Passport,List[Name]["Permission"]))) or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Mount(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Name and List[Name] then
		local Primary = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			if (v["amount"] <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],v["amount"],false)
			else
				v["name"] = ItemName(v["item"])
				v["weight"] = ItemWeight(v["item"])
				v["index"] = ItemIndex(v["item"])
				v["amount"] = parseInt(v["amount"])
				v["rarity"] = ItemRarity(v["item"])
				v["economy"] = ItemEconomy(v["item"])
				v["desc"] = ItemDescription(v["item"])
				v["key"] = v["item"]
				v["slot"] = Index

				local Split = splitString(v["item"],"-")

				if not v["desc"] then
					if Split[1] == "vehiclekey" and Split[2] then
						v["desc"] = "Placa do Veículo: <common>"..Split[2].."</common>"
					elseif Split[1] == "identity" or Split[1] == "fidentity" or string.sub(v["item"],1,5) == "badge" and Split[2] then
						if Split[1] == "identity" or Split[1] == "fidentity" or string.sub(v["item"],1,5) == "badge" then
							v["desc"] = "Passaporte: <rare>"..Dotted(Split[2]).."</rare><br>Nome: <rare>"..vRP.FullName(Split[2]).."</rare><br>Telefone: <rare>"..vRP.Phone(Passport).."</rare>"
						else
							v["desc"] = "Propriedade: <common>"..vRP.FullName(Split[2]).."</common>"
						end
					end
				end

				if Split[2] then
					local Loaded = ItemLoads(v["item"])
					if Loaded then
						v["charges"] = parseInt(Split[2] * (100 / Loaded))
					end

					if ItemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - Split[2])
						v["days"] = ItemDurability(v["item"])
					end
				end

				Primary[Index] = v
			end
		end

		return Primary,vRP.CheckWeight(Passport)
	end
end
---------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Amount,Target,Name)
	local source = source
	local Target = tostring(Target)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Item and Target and List[Name] and List[Name]["Type"] and List[Name]["List"] and List[Name]["List"][Item] then
		if Amount > 1 and ItemLoads(Item) then
			Amount = 1
		end

		local Inventory = vRP.Inventory(Passport)
		if not vRP.MaxItens(Passport,Item,Amount) and vRP.InventoryWeight(Passport,Item,Amount) and (not Inventory[Target] or (Inventory[Target] and Inventory[Target]["item"] == Item)) then
			if List[Name]["Type"] == "Cash" then
				local Price = List[Name]["List"][Item] * Amount
				local Paid = false

				if Name == "Pharmacy" then
					if vRP.TakeItem(Passport,"dollar",Price,true) then
						Paid = true
					elseif vRP.PaymentBank and vRP.PaymentBank(Passport,Price) then
						Paid = true
					end
				else
					Paid = vRP.PaymentFull(Passport,Price)
				end

				if Paid then
					vRP.GenerateItem(Passport,Item,Amount,false,Target)
				else
					if Name == "Pharmacy" then
						TriggerClientEvent("inventory:Notify",source,"Aviso","Dinheiro em mãos/conta insuficiente.","amarelo")
					else
						TriggerClientEvent("inventory:Notify",source,"Aviso","Dinheiro insuficiente.","amarelo")
					end
				end
			elseif List[Name]["Type"] == "Consume" and List[Name]["Item"] then
				if vRP.TakeItem(Passport,List[Name]["Item"],List[Name]["List"][Item] * Amount) then
					vRP.GenerateItem(Passport,Item,Amount,false,Target)
				else
					TriggerClientEvent("inventory:Notify",source,"Atenção","<b>"..ItemName(List[Name]["Item"]).."</b> insuficiente.","vermelho")
				end
			end
		end
	end

	TriggerClientEvent("inventory:Update",source)
end
---------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
local CriminalShops = { Criminal = true, Criminal2 = true, Criminal3 = true, Criminal4 = true, Weapons = true, Oxy = true }

function Creative.Store(Item,Amount,Slot,Name)
	local source = source
	local Split = SplitOne(Item,"-")
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and List[Name] and List[Name]["List"] and List[Name]["Type"] and List[Name]["List"][Split] and not vRP.CheckDamaged(Item) then
		local Sold = false

		if List[Name]["Type"] == "Cash" then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GenerateItem(Passport,"dollar",List[Name]["List"][Split] * Amount,false)
				Sold = true
			end
		elseif List[Name]["Type"] == "Consume" then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GenerateItem(Passport,List[Name]["Item"],List[Name]["List"][Split] * Amount,false)
				Sold = true
			end
		end

		if Sold and CriminalShops[Name] then
			exports["alerta"]:AlertaVenda(source,"Venda Suspeita",30,16)
		end
	end

	TriggerClientEvent("inventory:Update",source)
end