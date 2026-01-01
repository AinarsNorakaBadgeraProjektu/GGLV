Config = Config or {}
Config.Inventory = false -- false it will auto detect your inventory, or set manually your inventory name "qb-inventory", "ox_inventory", etc.
Config.OldQBInventory = false -- true if you are using old qb-inventory (check the fxmanifest.lua, version should be 1.x)
Config.InventoryPath = {
    ['ox_inventory'] = "ox_inventory/web/images/",
}

CreateThread(function()
    if Config.Inventory then return end

    if GetResourceState("ox_inventory") ~= "missing" then
        Config.Inventory = "ox_inventory"
        return
    end
    if not Config.Inventory then
        print("^1[ERROR] ^3We couldn't find a compatible inventory, this resource will just stop working...^7")
    end
end)

exports("getInventoryPath", function()
    return Config.InventoryPath[Config.Inventory]
end)