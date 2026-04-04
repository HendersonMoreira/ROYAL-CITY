local LastShot = 0
local ShotCooldown = 8000
local LastWeapon = 0
local LastAmmo = -1
local Unarmed = GetHashKey("WEAPON_UNARMED")

local function TrySendShotAlert()
    local Now = GetGameTimer()
    if Now - LastShot < ShotCooldown then
        return
    end

    LastShot = Now
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    TriggerServerEvent("alerta:Tiro", Coords.x, Coords.y, Coords.z)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETECT SHOT (EVENT)
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered", function(Name)
    if Name == "CEventGunShot" then
        TrySendShotAlert()
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DETECT SHOT (AMMO FALLBACK)
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local Weapon = GetSelectedPedWeapon(Ped)

        if Weapon ~= 0 and Weapon ~= Unarmed then
            local CurAmmo = GetAmmoInPedWeapon(Ped, Weapon)

            if Weapon == LastWeapon and CurAmmo < LastAmmo and LastAmmo >= 0 then
                TrySendShotAlert()
            end

            LastWeapon = Weapon
            LastAmmo = CurAmmo
        else
            LastWeapon = 0
            LastAmmo = -1
        end

        Wait(100)
    end
end)
