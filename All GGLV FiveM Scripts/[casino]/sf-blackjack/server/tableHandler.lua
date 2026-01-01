local tableString = [[
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
			max = 5000
		}
	},
]]
if(Config.DevMode) then
    RegisterNetEvent("sf-blackjack:saveTable", function(model, coords, heading, texture)
        local text = LoadResourceFile(GetCurrentResourceName(), "blackjacks.txt")
        if(not text) then text = "" end
        text = text .. tableString:format(os.date("%x %X"), coords, heading, model, texture ~= nil, tostring(texture)) .. "\n"
        SaveResourceFile(GetCurrentResourceName(), "blackjacks.txt", text, -1)
    end)
end