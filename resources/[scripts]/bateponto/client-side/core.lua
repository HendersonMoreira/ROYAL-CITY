local nearestPoint = nil

local function DrawText3D(coords,text)
    local onScreen,x,y = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
    if not onScreen then
        return
    end

    SetTextScale(0.35,0.35)
    SetTextFont(4)
    SetTextColour(255,255,255,220)
    SetTextCentre(true)
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x,y)
end

CreateThread(function()
    if BatePontoConfig.Blip.Enabled then
        for _,point in pairs(BatePontoConfig.Points) do
            local blip = AddBlipForCoord(point.Coords.x,point.Coords.y,point.Coords.z)
            SetBlipSprite(blip,BatePontoConfig.Blip.Sprite)
            SetBlipColour(blip,BatePontoConfig.Blip.Color)
            SetBlipScale(blip,BatePontoConfig.Blip.Scale)
            SetBlipAsShortRange(blip,true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(point.Name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

CreateThread(function()
    while true do
        local waitTime = 1000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local found = nil

        for index,point in pairs(BatePontoConfig.Points) do
            local distance = #(pedCoords - point.Coords)
            if distance <= BatePontoConfig.DrawDistance then
                waitTime = 0
                DrawMarker(
                    BatePontoConfig.Marker.Type,
                    point.Coords.x,point.Coords.y,point.Coords.z - 0.9,
                    0.0,0.0,0.0,
                    0.0,0.0,0.0,
                    BatePontoConfig.Marker.Scale.x,BatePontoConfig.Marker.Scale.y,BatePontoConfig.Marker.Scale.z,
                    BatePontoConfig.Marker.Color[1],BatePontoConfig.Marker.Color[2],BatePontoConfig.Marker.Color[3],BatePontoConfig.Marker.Color[4],
                    false,false,2,false,nil,nil,false
                )

                if distance <= BatePontoConfig.InteractDistance then
                    found = index
                    DrawText3D(point.Coords + vector3(0.0,0.0,0.20),"[E] Bater ponto")
                end
            end
        end

        nearestPoint = found

        if nearestPoint and IsControlJustPressed(0,38) then
            TriggerServerEvent("bateponto:Toggle",nearestPoint)
            Wait(1000)
        end

        Wait(waitTime)
    end
end)
