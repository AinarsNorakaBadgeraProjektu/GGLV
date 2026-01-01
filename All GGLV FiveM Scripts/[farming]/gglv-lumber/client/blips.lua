if Config.useBlips then
    CreateThread(function()
        local function CreateBlip(coords, sprite, display, scale, color, label)
            if Config.debug then
                print(coords)
            end
            local blip = AddBlipForCoord(coords)
            SetBlipSprite(blip, sprite)
            SetBlipDisplay(blip, display)
            SetBlipScale(blip, scale)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, color)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(label)
            EndTextCommandSetBlipName(blip)
        end

        CreateBlip(vector3(1167.403, -1347.203, 34.913), 632, 6, 0.8, 5, Lang.blip1)
        CreateBlip(vector3(-555.627, 5314.729, 74.302), 77, 6, 0.8, 5, Lang.blip2)
        CreateBlip(vector3(1129.9534, -1304.9520, 33.7407), 47, 6, 0.8, 5, Lang.blip3)
        CreateBlip(vector3(1158.5851, -1310.1917, 33.9330), 47, 6, 0.8, 5, Lang.blip3)
        CreateBlip(vector3(-605.7922, 5311.1572, 70.4190), 47, 6, 0.5, 5, Lang.blip4)
        CreateBlip(vector3(-828.1899, 5419.2910, 34.4050), 47, 6, 0.5, 5, Lang.blip5) 
        CreateBlip(vector3(39.31, -1005.54, 29.48), 280, 6, 0.5, 5, Lang.blip6)
    end)
end