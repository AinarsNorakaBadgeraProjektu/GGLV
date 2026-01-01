if Config.Housing ~= "qs-housing" then
    return
end


function GetPlayerHouses(identifier) 

    local results = MySQL.query.await("SELECT house, id FROM player_houses WHERE `owner` = @cid;", { ["@cid"] = identifier })
    local houses = {}
    for key, value in ipairs(results) do
        local houseData = MySQL.single.await("SELECT coords FROM houselocations WHERE `name` = @name;", { ["@name"] = value["house"] })
        houseData = json.decode(houseData["coords"])

        table.insert(
            houses,
            {
                ["name"] = value["house"],
                ["id"] = value["id"],
                ["coords"] = houseData?.enter
            }
        )
    end
    DebugPrint(houses)
    return houses
end