function addZone(data)
    if Config.Debug then
        print("addZone(), Target: ", Config.Target)
    end
    while not Config.Target do Wait(50) end
    if not data then
        print("addZone() received null as argument")
        return
    end
    if data['type'] == "cashier" then
        if Config.Debug then
            print("Registering cashier zone...")
        end
        if Config.Target == "ox_target" then
            exports.ox_target:addBoxZone({
                name = data['name'],
                coords = vector3(data['coords']['x'], data['coords']['y'], data['coords']['z']),
                size = vector3(data['height'], data['width'], (data['maxZ'] - data['minZ'])),
                debug = Config.ZonesDebug,
                rotation = data['heading'],
                options = {
                    {
                        type = "client",
                        event = "av_business:cashierEmployee",
                        icon = Config.Events['cashier']['icon']['employee'],
                        label = Config.Events['cashier']['label']['employee'],
                        groups = data['job'],
                        zoneName = data['name'],
                        zoneJob = data['job'],
                        distance = tonumber(data['distance'])
                    },
                    {
                        type = "client",
                        event = "av_business:cashierCustomer",
                        icon = Config.Events['cashier']['icon']['customer'],
                        label = Config.Events['cashier']['label']['customer'],
                        zoneName = data['name'],
                        zoneJob = data['job'],
                        distance = tonumber(data['distance'])
                    },
                }
            })
        else
            exports[Config.Target]:AddBoxZone(data['name'], vector3(data['coords']['x'], data['coords']['y'], data['coords']['z']), data['width'], data['height'], {
                name = data['name'],
                heading = data['heading'],
                debugPoly = Config.ZonesDebug,
                minZ = data['minZ'],
                maxZ = data['maxZ'],
            }, {
                options = {
                    {
                        type = "client",
                        event = "av_business:cashierEmployee",
                        icon = Config.Events['cashier']['icon']['employee'],
                        label = Config.Events['cashier']['label']['employee'],
                        job = data['job'],
                        zoneName = data['name'],
                        zoneJob = data['job']
                    },
                    {
                        type = "client",
                        event = "av_business:cashierCustomer",
                        icon = Config.Events['cashier']['icon']['customer'],
                        label = Config.Events['cashier']['label']['customer'],
                        zoneName = data['name'],
                        zoneJob = data['job']
                    },
                },
                distance = tonumber(data['distance'])
            })
        end
    else
        if Config.Events[data['type']] then
            if Config.Debug then
                print("Registering zone type:", data['type'])
            end
            local job = false
            local jobConfig = Config.Events[data['type']]
            if jobConfig and jobConfig['job'] then
                job = data['job']
            end
            if Config.Target == "ox_target" then
                exports.ox_target:addBoxZone({
                    name = data['name'],
                    coords = vector3(data['coords']['x'], data['coords']['y'], data['coords']['z']),
                    size = vector3(data['height'], data['width'], (data['maxZ'] - data['minZ'])),
                    debug = Config.ZonesDebug,
                    rotation = data['heading'],
                    options = {
                        {
                            name = data['name'],
                            type = "client",
                            event = Config.Events[data['type']]['event'],
                            icon = Config.Events[data['type']]['icon'],
                            label = Config.Events[data['type']]['label'],
                            groups = job,
                            zoneJob = data['job'],
                            zoneType = data['type'],
                            distance = tonumber(data['distance'])
                        },
                    }
                })
            else
                exports[Config.Target]:AddBoxZone(data['name'], vector3(data['coords']['x'], data['coords']['y'], data['coords']['z']), data['width'], data['height'], {
                    name = data['name'],
                    heading = data['heading'],
                    debugPoly = Config.ZonesDebug,
                    minZ = data['minZ'],
                    maxZ = data['maxZ'],
                }, {
                    options = {
                        {
                            name = data['name'],
                            type = "client",
                            event = Config.Events[data['type']]['event'],
                            icon = Config.Events[data['type']]['icon'],
                            label = Config.Events[data['type']]['label'],
                            job = job,
                            zoneJob = data['job'],
                            zoneType = data['type']
                        },
                    },
                    distance = tonumber(data['distance'])
                })
            end
        else
            if Config.Debug then
                print("Zone type", data['type'], "doesn't exist in Config.Events, check your config/events.lua !")
                print("Zone type", data['type'], "doesn't exist in Config.Events, check your config/events.lua !")
                print("Zone type", data['type'], "doesn't exist in Config.Events, check your config/events.lua !")
            end
        end
    end
end

function removeZone(name)
    if Config.Target == "ox_target" then
        exports.ox_target:removeZone(name)
    else
        exports[Config.Target]:RemoveZone(name)
    end
end