-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	SetDiscordAppId(1343013616806264862)
	SetDiscordRichPresenceAsset("lipe")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetText("Lipe Network")
	SetDiscordRichPresenceAssetSmall("lipe")
	SetDiscordRichPresenceAssetSmallText("Lipe Network")
	SetDiscordRichPresenceAction(0,"Discord","https://discord.gg/yzuUJTgXfx")
end)