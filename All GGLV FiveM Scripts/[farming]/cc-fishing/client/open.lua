local QBCore = exports[Config.CoreName]:GetCoreObject()

function GiveVehicleKeys(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local model = GetEntityModel(vehicle)

    if Config.VehicleKeys == "qb" then
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    elseif Config.VehicleKeys == "qs" then
        exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
    elseif Config.VehicleKeys == "custom" then
        exports['Renewed-Vehiclekeys']:addKey(plate)
    else
        print("Unsupported vehicle keys system: " .. tostring(Config.VehicleKeys))
    end
end

function HasItem(item, amount)
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' then
        return exports[Config.Inventory..'-inventory']:HasItem(item, amount)
    elseif Config.Inventory == 'ox' then
        return exports.ox_inventory:GetItemCount(item) >= amount
    elseif Config.Inventory == 'qs' then
        return exports['qs-inventory']:Search(item)
    elseif Config.Inventory == "custom" then
        -- ADD YOUR CUSTOM INVENTORY EXPORT/EVENT
    else
        print("Unsupported inventory system: " .. tostring(Config.Inventory))
    end
    return false
end

function TreasureSkillCheck()
    return lib.skillCheck({'easy', 'easy', 'easy', 'easy'}, {'w', 'a', 's', 'd'})
end

function BoatFuel(boat, amount)
    SetVehicleFuelLevel(boat, amount)
end
