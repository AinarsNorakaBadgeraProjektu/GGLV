---@class sharedConfig
---@field debug boolean enable debug mode for console messages and animals blips
---@field menuOptions table the options to show on the menu
---@field buyItems table items available for purchase
---@field animalsSpawn table animals spawn settings
return {
    debug = false, -- Enable debug mode for console messages and animals blips

    menuOptions = {
        buy = true,
        sell = true
    },

    buyItems = { -- Items for the shop tab
       { name = 'ammo-musket', price = 500, xp = 50 },
       { name = 'weapon_knife', price = 3500, xp = 0 },
    --   { name = 'hunting_stove', price = 2500, xp = 200 },
       { name = 'weapon_musket', price = 20500, xp = 350 },
    },

    animalsSpawn = { -- Animals spawn settings
        interval = 100, -- spawn interval in seconds
        despawnTime = 300, -- despawn time in seconds after animal dies
        despawnDistance = 500.0, -- the distance animal needs to be from the player to despawn

        legal = { -- zone type
            maxPerZone = 25, -- max animals per zone
            chance = 90, -- spawn chance percentage (0 - 100)
        },

        ilegal = {
            maxPerZone = 15,
            chance = 70,
        }
    }
}
