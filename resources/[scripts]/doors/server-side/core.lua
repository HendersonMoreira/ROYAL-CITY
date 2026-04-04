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
Tunnel.bindInterface("doors",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	-- -- Boolingbroke
	-- ["1"] = { ["Coords"] = vec3(), ["Hash"] = 741314661, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Emergencia" },
	-- ["2"] = { ["Coords"] = vec3(), ["Hash"] = 741314661, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Emergencia" },
	["3"] = { ["Coords"] = vec3(1712.02,2604.18,49.49), ["Hash"] = -2051651622, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["4"] = { ["Coords"] = vec3(1712.01,2598.97,49.49), ["Hash"] = -2051651622, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["5"] = { ["Coords"] = vec3(1693.65,2595.35,54.02), ["Hash"] = -1821777087 , ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["6"] = { ["Coords"] = vec3(1693.64,2607.0,54.02), ["Hash"] = -1821777087, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["7"] = { ["Coords"] = vec3(1593.13,2571.66,46.72), ["Hash"] = -1033001619, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["8"] = { ["Coords"] = vec3(1682.26,2601.55,46.74), ["Hash"] = -2051651622, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["9"] = { ["Coords"] = vec3(1644.74,2601.64,46.66), ["Hash"] = -1156020871 , ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["10"] = { ["Coords"] = vec3(1632.16,2601.47,46.66), ["Hash"] = -1156020871, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["11"] = { ["Coords"] = vec3(1579.24,2548.69,46.72), ["Hash"] = 631614199 , ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["12"] = { ["Coords"] = vec3(1575.67,2548.66,46.72), ["Hash"] = 631614199 , ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["13"] = { ["Coords"] = vec3(1572.26,2548.73,46.72), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["14"] = { ["Coords"] = vec3(1579.17,2568.49,46.72), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["15"] = { ["Coords"] = vec3(1575.78,2568.52,46.72), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["16"] = { ["Coords"] = vec3(1579.05,2548.69,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },

	-- Police Los Santos  
	["17"] = { ["Coords"] = vec3(1575.7,2548.63,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["18"] = { ["Coords"] = vec3(1572.22,2548.62,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["19"] = { ["Coords"] = vec3(1571.98,2553.7,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["20"] = { ["Coords"] = vec3(1571.98,2557.63,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["21"] = { ["Coords"] = vec3(1572.0,2561.58,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["22"] = { ["Coords"] = vec3(1572.0,2565.57,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["23"] = { ["Coords"] = vec3(1569.0,2568.44,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["24"] = { ["Coords"] = vec3(1572.2,2568.47,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["25"] = { ["Coords"] = vec3(1575.86,2568.41,50.2), ["Hash"] = 631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["26"] = { ["Coords"] = vec3(1579.26,2568.51,50.2), ["Hash"] = -631614199, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["27"] = { ["Coords"] = vec3(480.76,-1000.51,26.47), ["Hash"] = -113421396, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["28"] = { ["Coords"] = vec3(478.24,-1000.89,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["29"] = { ["Coords"] = vec3(478.24,-997.74,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["30"] = { ["Coords"] = vec3(482.27,-996.71,26.45), ["Hash"] = -113421396, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["31"] = { ["Coords"] = vec3(484.34,-1002.88,26.56), ["Hash"] = 11515395, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["32"] = { ["Coords"] = vec3(484.34,-998.30,26.56), ["Hash"] = -300093563, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["33"] = { ["Coords"] = vec3(478.99,-987.70,26.45), ["Hash"] = -113421396, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["34"] = { ["Coords"] = vec3(477.40,-989.74,26.56), ["Hash"] = -300093563, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["35"] = { ["Coords"] = vec3(472.67,-989.74,26.56), ["Hash"] = 11515395, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["36"] = { ["Coords"] = vec3(472.67,-986.96,26.56), ["Hash"] = -300093563, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["37"] = { ["Coords"] = vec3(477.40,-986.96,26.56), ["Hash"] = 11515395, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["38"] = { ["Coords"] = vec3(481.11,-986.87,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["39"] = { ["Coords"] = vec3(485.40,-986.93,25.41), ["Hash"] = -691335480, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["40"] = { ["Coords"] = vec3(440.38,-987.22,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "41" },
	["41"] = { ["Coords"] = vec3(440.38,-989.82,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "40" },
	["42"] = { ["Coords"] = vec3(470.02,-972.02,30.84), ["Hash"] = 1239973900, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "43" },
	["43"] = { ["Coords"] = vec3(467.42,-972.02,30.84), ["Hash"] = -1095702117, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "42" },
	["44"] = { ["Coords"] = vec3(470.01,-1014.50,26.53), ["Hash"] = -158854912, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "45" },
	["45"] = { ["Coords"] = vec3(467.41,-1014.50,26.53), ["Hash"] = 794198680, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "44" },
	["46"] = { ["Coords"] = vec3(467.41,-1004.54,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "47" },
	["47"] = { ["Coords"] = vec3(470.01,-1004.54,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "46" },
	["48"] = { ["Coords"] = vec3(471.24,-1007.89,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "49" },
	["49"] = { ["Coords"] = vec3(471.24,-1005.29,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "48" },
	["50"] = { ["Coords"] = vec3(457.59,-979.61,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "51" },
	["51"] = { ["Coords"] = vec3(457.59,-982.21,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "50" },
	["52"] = { ["Coords"] = vec3(457.59,-994.26,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "53" },
	["53"] = { ["Coords"] = vec3(457.59,-991.66,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "52" },
	["54"] = { ["Coords"] = vec3(451.38,-1001.22,26.69), ["Hash"] = -246583363, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Policia" },
	["55"] = { ["Coords"] = vec3(432.54,-1001.23,26.75), ["Hash"] = -246583363, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Policia" },
	["56"] = { ["Coords"] = vec3(425.75,-998.76,30.83), ["Hash"] = 794198680, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },

	-- Police Sandy Shores -- 1842.48,2602.69,45.66,73.71
	-- ["61"] = { ["Coords"] = vec3(), ["Hash"] = -1385904007, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	-- ["62"] = { ["Coords"] = vec3(), ["Hash"] = -1919309060, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	-- ["63"] = { ["Coords"] = vec3(), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	-- ["64"] = { ["Coords"] = vec3(), ["Hash"] = -1919309060, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	-- ["65"] = { ["Coords"] = vec3(), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	-- ["66"] = { ["Coords"] = vec3(), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	-- ["67"] = { ["Coords"] = vec3(), ["Hash"] = -1919309060, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	-- ["68"] = { ["Coords"] = vec3(), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["69"] = { ["Coords"] = vec3(1348.83,1146.82,113.75), ["Hash"] = -1825581873, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Medellin" },
	["70"] = { ["Coords"] = vec3(1313.46,1189.24,106.88), ["Hash"] = -1825581873, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Medellin" }, --Medellin portas 
	-- ["71"] = { ["Coords"] = vec3(-2039.63,-490.11,12.11), ["Hash"] = 1411506275, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 50.75, ["Perm"] = "Mecanica" },

	-- BOPE
	["80"] = { ["Coords"] = vec3(-429.53,1109.31,327.68), ["Hash"] = -1860071468, ["Heading"] = 170.08, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["81"] = { ["Coords"] = vec3(-426.89,1101.37,327.68), ["Hash"] = 1114264700, ["Heading"] = 85.04, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["82"] = { ["Coords"] = vec3(-435.42,1103.66,327.68), ["Hash"] = 1114264700, ["Heading"] = 252.29, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["83"] = { ["Coords"] = vec3(-409.95,1077.64,323.85), ["Hash"] = 991901429, ["Heading"] = 340.16, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["84"] = { ["Coords"] = vec3(-419.52,1087.71,323.85), ["Hash"] = 991901429, ["Heading"] = 0.0, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["85"] = { ["Coords"] = vec3(-416.71,1086.99,323.85), ["Hash"] = 991901429, ["Heading"] = 343.0, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["86"] = { ["Coords"] = vec3(-413.68,1086.23,323.85), ["Hash"] = 991901429, ["Heading"] = 343.0, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["87"] = { ["Coords"] = vec3(-410.63,1085.53,323.85), ["Hash"] = 991901429, ["Heading"] = 334.49, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },
	["88"] = { ["Coords"] = vec3(-407.55,1084.69,323.85), ["Hash"] = 991901429, ["Heading"] = 348.67, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "BOPE" },

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Number)
	local source = source
	local Passport = vRP.Passport(source)
	local Doors = GlobalState["Doors"]
	local DoorId = tostring(Number)
	local Selected = Doors and Doors[DoorId]

	if not Passport or not Selected then
		return
	end

	if Selected["Perm"] then
		local Allowed = vRP.HasGroup(Passport,Selected["Perm"]) or vRP.HasPermission(Passport,Selected["Perm"])
		if not Allowed then
			TriggerClientEvent("Notify",source,"amarelo","Você não tem permissão. Apenas membros da "..Selected["Perm"].." podem destrancar esta porta.",5000)
			return
		end
	end

	Selected["Lock"] = not Selected["Lock"]

	if Selected["Other"] and Doors[Selected["Other"]] then
		Doors[Selected["Other"]]["Lock"] = Selected["Lock"]
	end

	GlobalState:set("Doors",Doors,true)
	TriggerClientEvent("Notify",source,"verde",Selected["Lock"] and "Porta trancada." or "Porta destrancada.",3000)
end