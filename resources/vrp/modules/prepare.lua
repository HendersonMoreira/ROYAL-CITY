-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/Person","SELECT * FROM characters WHERE id = @id")
vRP.Prepare("characters/getPhone","SELECT id FROM characters WHERE phone = @phone")
vRP.Prepare("characters/updatePhone","UPDATE characters SET phone = @phone WHERE id = @id")
vRP.Prepare("characters/SetMedicplan","UPDATE characters SET Medic = @Medic WHERE id = @Passport")
vRP.Prepare("characters/UpdateMedicplan","UPDATE characters SET Medic = Medic + 2592000 WHERE id = @Passport")
vRP.Prepare("characters/removeCharacter","UPDATE characters SET deleted = 1 WHERE id = @id")
vRP.Prepare("characters/addFines","UPDATE characters SET fines = fines + @fines WHERE id = @id")
vRP.Prepare("characters/setPrison","UPDATE characters SET prison = @prison WHERE id = @Passport")
vRP.Prepare("characters/removeFines","UPDATE characters SET fines = fines - @fines WHERE id = @id")
vRP.Prepare("characters/addBank","UPDATE characters SET bank = bank + @amount WHERE id = @Passport")
vRP.Prepare("characters/remBank","UPDATE characters SET bank = bank - @amount WHERE id = @Passport")
vRP.Prepare("characters/UserLicense","SELECT * FROM characters WHERE id = @id and license = @license")
vRP.Prepare("characters/Characters","SELECT * FROM characters WHERE license = @license and deleted = 0")
vRP.Prepare("characters/LastLogin","UPDATE characters SET Login = UNIX_TIMESTAMP() WHERE id = @Passport")
vRP.Prepare("characters/removePrison","UPDATE characters SET prison = prison - @prison WHERE id = @Passport")
vRP.Prepare("characters/updateName","UPDATE characters SET name = @name, name2 = @name2 WHERE id = @Passport")
vRP.Prepare("characters/Tracking","UPDATE characters SET tracking = tracking + @tracking WHERE id = @Passport")
vRP.Prepare("characters/UpgradeSpending","UPDATE characters SET spending = spending + @spending WHERE id = @Passport")
vRP.Prepare("characters/DowngradeSpending","UPDATE characters SET spending = spending - @spending WHERE id = @Passport")
vRP.Prepare("characters/lastCharacters","SELECT id FROM characters WHERE license = @license ORDER BY id DESC LIMIT 1")
vRP.Prepare("characters/countPersons","SELECT COUNT(license) as qtd FROM characters WHERE license = @license and deleted = 0")
vRP.Prepare("characters/newCharacter","INSERT INTO characters(license,name,name2,sex,phone,blood,created) VALUES(@license,@name,@name2,@sex,@phone,@blood,UNIX_TIMESTAMP() + 259200)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("smartphone/Phone","SELECT * FROM phone_phones WHERE owner_id = @Passport")
vRP.Prepare("smartphone/CheckInstagram","SELECT * FROM phone_instagram_accounts WHERE phone_number = @Phone")
vRP.Prepare("smartphone/Instagram","UPDATE phone_instagram_accounts SET follower_count = follower_count + @Amount WHERE username = @Username")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/Account","SELECT * FROM accounts WHERE license = @license")
vRP.Prepare("accounts/newAccount","INSERT INTO accounts(license) VALUES(@license)")
vRP.Prepare("accounts/AddGems","UPDATE accounts SET gems = gems + @gems WHERE license = @license")
vRP.Prepare("accounts/setPremium","UPDATE accounts SET premium = @premium, Level = @Level WHERE license = @license")
vRP.Prepare("accounts/RemoveGems","UPDATE accounts SET gems = gems - @gems WHERE license = @license")
vRP.Prepare("accounts/infosUpdatechars","UPDATE accounts SET chars = chars + 1 WHERE license = @license")
vRP.Prepare("accounts/updatePremium","UPDATE accounts SET premium = premium + 2592000 WHERE license = @license")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("playerdata/GetData","SELECT * FROM playerdata WHERE Passport = @Passport AND Name = @Name")
vRP.Prepare("playerdata/SetData","REPLACE INTO playerdata(Passport,Name,Information) VALUES(@Passport,@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("entitydata/GetData","SELECT * FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/RemoveData","DELETE FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/SetData","REPLACE INTO entitydata(Name,Information) VALUES(@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/plateVehicles","SELECT * FROM vehicles WHERE plate = @plate")
vRP.Prepare("vehicles/PlateUsers","SELECT * FROM vehicles WHERE plate = @plate AND vehicle = @vehicle")
vRP.Prepare("vehicles/UserVehicles","SELECT * FROM vehicles WHERE Passport = @Passport")
vRP.Prepare("vehicles/Count","SELECT COUNT(vehicle) FROM vehicles WHERE vehicle = @vehicle")
vRP.Prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/selectVehicles","SELECT * FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/CoiloverVehicles","UPDATE vehicles SET Drift = 1 WHERE vehicle = @vehicle AND plate = @plate")
vRP.Prepare("vehicles/SeatbeltVehicles","UPDATE vehicles SET Seatbelt = 1 WHERE plate = @plate AND vehicle = @vehicle")
vRP.Prepare("vehicles/paymentArrest","UPDATE vehicles SET arrest = 0 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/moveVehicles","UPDATE vehicles SET Passport = @OtherPassport WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET plate = @plate WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET rental = rental + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/arrestVehicles","UPDATE vehicles SET arrest = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET rental = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,tax) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 2592000,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/InitialVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax) VALUES(@Passport,@Vehicle,@Plate,@Work,UNIX_TIMESTAMP() + (86400 * 7),UNIX_TIMESTAMP() + (86400 * 7))")
vRP.Prepare("vehicles/updateVehicles","UPDATE vehicles SET engine = @engine, body = @body, health = @health, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, nitro = @nitro WHERE Passport = @Passport AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("banneds/GetBanned","SELECT * FROM banneds WHERE license = @license")
vRP.Prepare("banneds/RemoveBanned","DELETE FROM banneds WHERE license = @license")
vRP.Prepare("banneds/InsertBanned","INSERT INTO banneds(license,time) VALUES(@license,UNIX_TIMESTAMP() + 86400 * @time)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("chests/GetChests","SELECT * FROM chests WHERE name = @name")
vRP.Prepare("chests/AddChests","INSERT IGNORE INTO chests (name,perm) VALUES (@name,@name)")
vRP.Prepare("chests/UpdateWeight","UPDATE chests SET weight = weight + (10 * @Multiplier), Slots = Slots + (5 * @Multiplier) WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("races/Result","SELECT * FROM races WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Ranking","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 5")
vRP.Prepare("races/TopFive","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 1 OFFSET 4")
vRP.Prepare("races/Records","UPDATE races SET Points = @Points, Vehicle = @Vehicle WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Insert","INSERT INTO races(Race,Passport,Name,Vehicle,Points) VALUES(@Race,@Passport,@Name,@Vehicle,@Points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fidentity/Result","SELECT * FROM fidentity WHERE id = @id")
vRP.Prepare("fidentity/GetIdentity","SELECT id FROM fidentity ORDER BY id DESC LIMIT 1")
vRP.Prepare("fidentity/NewIdentity","INSERT INTO fidentity(name,name2,blood) VALUES(@name,@name2,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("summerz/Playerdata","DELETE FROM playerdata WHERE Information = '[]' OR Information = '{}'")
vRP.Prepare("summerz/Entitydata","DELETE FROM entitydata WHERE Information = '[]' OR Information = '{}'")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("propertys/All","SELECT * FROM propertys")
vRP.Prepare("propertys/Sell","DELETE FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Exist","SELECT * FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Serial","SELECT * FROM propertys WHERE Serial = @Serial")
vRP.Prepare("propertys/Garages","SELECT * FROM propertys WHERE Garage IS NOT NULL")
vRP.Prepare("propertys/AllUser","SELECT * FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Item","UPDATE propertys SET Item = Item + 1 WHERE Name = @Name")
vRP.Prepare("propertys/Garage","UPDATE propertys SET Garage = @Garage WHERE Name = @Name")
vRP.Prepare("propertys/Credentials","UPDATE propertys SET Serial = @Serial WHERE Name = @Name")
vRP.Prepare("propertys/Count","SELECT COUNT(Passport) FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Vault","UPDATE propertys SET Vault = Vault + @Weight WHERE Name = @Name")
vRP.Prepare("propertys/Transfer","UPDATE propertys SET Passport = @Passport WHERE Name = @Name")
vRP.Prepare("propertys/Fridge","UPDATE propertys SET Fridge = Fridge + @Weight WHERE Name = @Name")
vRP.Prepare("propertys/Check","SELECT * FROM propertys WHERE Name = @Name AND Passport = @Passport")
vRP.Prepare("propertys/Minimals","SELECT * FROM propertys WHERE Tax + (86400 * 15) <= UNIX_TIMESTAMP()")
vRP.Prepare("propertys/Tax","UPDATE propertys SET Tax = UNIX_TIMESTAMP() + (86400 * 30) WHERE Name = @Name")
vRP.Prepare("propertys/Buy","INSERT INTO propertys (Name,Interior,Passport,Serial,Vault,Fridge,Tax) VALUES (@Name,@Interior,@Passport,@Serial,@Vault,@Fridge,UNIX_TIMESTAMP() + (86400 * 30))")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fines/List","SELECT * FROM fines WHERE Passport = @Passport")
vRP.Prepare("fines/Remove","DELETE FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Check","SELECT * FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Add","INSERT INTO fines(Passport,Name,Date,Hour,Value,Message) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("taxs/List","SELECT * FROM taxs WHERE Passport = @Passport")
vRP.Prepare("taxs/Remove","DELETE FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Check","SELECT * FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Add","INSERT INTO taxs(Passport,Name,Date,Hour,Value,Message) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("transactions/List","SELECT * FROM transactions WHERE Passport = @Passport ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("transactions/Add","INSERT INTO transactions(Passport,Type,Date,Value,Balance) VALUES(@Passport,@Type,@Date,@Value,@Balance)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("dependents/List","SELECT * FROM dependents WHERE Passport = @Passport")
vRP.Prepare("dependents/Remove","DELETE FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Check","SELECT * FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Add","INSERT INTO dependents(Passport,Dependent,Name) VALUES(@Passport,@Dependent,@Name)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("invoices/Remove","DELETE FROM invoices WHERE id = @id")
vRP.Prepare("invoices/Check","SELECT * FROM invoices WHERE id = @id")
vRP.Prepare("invoices/List","SELECT * FROM invoices WHERE Passport = @Passport")
vRP.Prepare("invoices/Add","INSERT INTO invoices(Passport,Received,Type,Reason,Holder,Value) VALUES(@Passport,@Received,@Type,@Reason,@Holder,@Value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("investments/Remove","DELETE FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Check","SELECT * FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Add","INSERT INTO investments(Passport,Deposit,Last) VALUES(@Passport,@Deposit,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("investments/Invest","UPDATE investments SET Deposit = Deposit + @Value, Last = UNIX_TIMESTAMP() + 86400 WHERE Passport = @Passport")
vRP.Prepare("investments/Actives","UPDATE investments SET Monthly = Monthly + FLOOR((Deposit + Liquid) * 0.10), Liquid = Liquid + FLOOR((Deposit + Liquid) * 0.025), Last = UNIX_TIMESTAMP() + 86400 WHERE Last < UNIX_TIMESTAMP()")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.Query("summerz/Playerdata")
	vRP.Query("summerz/Entitydata")
end)