-----------------------------------------------------------------------------------------------------------------------------------------
-- vRp
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Quebrada = {}
Tunnel.bindInterface("bus",Quebrada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Quebrada.Payment(WorkName,Service)
    local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Work = Works[WorkName]
		if not Work then
			return
		end

		local Experience = vRP.GetExperience(Passport,Work["experience"])
		local Category = ClassCategory(Experience)
		local Valuation = Work["payment"]

		if Category == 2 then
            Valuation = Valuation + 2
        elseif Category == 3 then
            Valuation = Valuation + 4
        elseif Category == 4 then
            Valuation = Valuation + 6
        elseif Category == 5 then
            Valuation = Valuation + 8
        elseif Category == 6 then
            Valuation = Valuation + 10
		elseif Category == 7 then
            Valuation = Valuation + 12
		elseif Category == 8 then
            Valuation = Valuation + 15
		elseif Category == 9 then
            Valuation = Valuation + 20
		elseif Category == 10 then
            Valuation = Valuation + 25
        end

		if Buffs["Dexterity"][Passport] then
			if Buffs["Dexterity"][Passport] > os.time() then
				Valuation = Valuation + (Valuation * 0.1)
			end
		end

		Valuation = parseInt(Valuation)

		vRP.PutExperience(Passport,Work["experience"],1)
		vRP.GenerateItem(Passport,"dollar",Valuation,true)
		TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",Valuation)
	end
end
