local rouletteString = [[
    -- %s
    {
		coords = %s,
		heading = %s,
		model = %s,
		spawn = %s,
		texture = %s,
		type = "normal",
		bets = {
			min = 10,
			max = 5000,
			chipAmount = 8
		}
	},
]]
if(Config.DevMode) then
    RegisterNetEvent("sf-roulette:saveRoulette", function(model, coords, heading, texture)
        local text = LoadResourceFile(GetCurrentResourceName(), "roulettes.txt")
        if(not text) then text = "" end
        text = text .. rouletteString:format(os.date("%x %X"), coords, heading, model, texture ~= nil, tostring(texture)) .. "\n"
        SaveResourceFile(GetCurrentResourceName(), "roulettes.txt", text, -1)
    end)
end