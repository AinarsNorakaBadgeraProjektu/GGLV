if Config.Housing ~= "qb-housing" then
    return
end


function GetPlayerHouses(identifier) 

    local results = MySQL.query.await("SELECT house, id FROM player_houses WHERE `citizenid` = @cid OR `identifier` = @cid;", { ["@cid"] = identifier })
    local houses = {}
    for key, value in ipairs(results) do
        local houseData = MySQL.single.await("SELECT coords FROM houselocations WHERE `id` = @id;", { ["@id"] = value["id"] })
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