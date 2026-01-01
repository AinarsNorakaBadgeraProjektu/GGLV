if Config.VehicleGarages ~= "esx" then
    return
end

function getVehsByPlate(source, cb, plate)
    local src = source
    MySQL.Async.fetchAll(
        "SELECT * FROM ".. Config.vehiclesTable .." WHERE TRIM(`plate`) LIKE CONCAT('%', TRIM(@plate), '%')",
        { ["@plate"] = plate },
        function(results)
            veh_datastore = {}
            for key, value in ipairs(results) do
                table.insert(
                    veh_datastore,
                    {
                        ["plate"] = value["plate"],
                        ["owner"] = value["owner"],
                        ["type"] = value["type"],
                        ["model"] = json.decode(value["vehicle"]).model
                    }
                )
            end
            cb(veh_datastore)
        end
    )
end

RegisterServerCallback("qs-dispatch:getVehsByPlate", getVehsByPlate)

function getCars(identifier)
    local results = MySQL.query.await("SELECT plate, vehicle, owner, type FROM ".. Config.vehiclesTable .." WHERE `owner` = @cid", { ["@cid"] = identifier })
    local vehicles = {}
    DebugPrint(results)
    for key, value in ipairs(results) do
        table.insert(
            vehicles,
            {
                ["plate"] = value["plate"],
                ["owner"] = value["owner"],
                ["type"] = value["type"],
                ["model"] = json.decode(value["vehicle"]).model,
            }
        )
    end
    return vehicles
end