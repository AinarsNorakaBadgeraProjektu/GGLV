-- READ THE DOCS BEFORE USING THIS SCRIPT: https://docs.av-scripts.com/
Config = {}
Config.Debug = false
Config.RefreshItems = 60 -- Every X minutes, server will refresh the item list and show possible new items based in probability, false to disable it (Config.RandomizeItems = false)
Config.App = {
    name = "darkmarket",
    label = "Dark Market", -- You can rename the app by editing this field
    isEnabled = function()
        return exports['av_laptop']:hasItem('x_device')
    end
}
Config.MoneyAccounts = { -- Money accounts used to buy items
    {name = "crypto", label = "Crypto", icon = "fa-brands fa-ethereum"},
}

--[[
    This is an example of the fields that each item should contain:
    
    probability = Chance (0-100%) for the item to be available in market.
    {
        name = "drug_package", -- item name
        label = "Drug Ingredients", -- item label
        metadata = {purity = "100%", strain = "AV Scripts"}, -- If u don't want metadata just leave it empty: metadata = {}
        stock = 5, -- stock per server restart
        price = 1, -- price
        account = "cosmo", -- account used for purchase 
        accountLabel = "Cosmo", -- account label for UI
        probability = 100, -- From 0 to 100%, prob from getting the item added to the shop in every refresh
        image? = "url.png" -- or false, image url just in case u don't want to use the one from your inventory path
        extension? = "webp"-- or false, the image file extension, just in case you have a mix between png and webp images in your inv, png is used by default
    },
]]

Config.Categories = {
    ['utilities'] = { 
        label = "Black Market", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            return true
        end,
        items = {
            {name = "nitrogen", label = "Nitrogen", metadata = {}, stock = 5, price = 50000, account = "crypto", accountLabel = "Crypto", probability = 100},
            {name = "hydrochloric_acid", label = "Hydrochloric Acid", metadata = {}, stock = 2, price = 8000, account = "crypto", accountLabel = "Crypto", probability = 40},
            {name = "x_device", label = "Flapper Hero", metadata = {}, stock = 1, price = 5000, account = "crypto", accountLabel = "Crypto", probability = 100},
            {name = "fakeplate", label = "Fake Plate", metadata = {}, stock = 5, price = 500, account = "crypto", accountLabel = "Crypto", probability = 0},
            {name = "weapon_smokegrenade", label = "Smoke Grenade", metadata = {}, stock = 1, price = 10000, account = "crypto", accountLabel = "Crypto", probability = 100},
            {name = "nitrous_bottle", label = "Nitros Bottle", metadata = {}, stock = 1, price = 5000, account = "bank", accountLabel = "Bank", probability = 100},
            {name = "weapon_stickybomb", label = "Some device", metadata = {}, stock = 1, price = 100000, account = "crypto", accountLabel = "Crypto", probability = 50},
            {name = "kq_meth_pills", label = "Meth Pills", metadata = {}, stock = 50, price = 400, account = "crypto", accountLabel = "Crypto", probability = 30},
            {name = "hacking_device", label = "Hacking Device", metadata = {}, stock = 3, price = 4000, account = "bank", accountLabel = "Bank", probability = 100},
            {name = "transponder", label = "Transponder", metadata = {}, stock = 2, price = 7500, account = "bank", accountLabel = "Bank", probability = 100},
            {name = "boosting_usb", label = "Boosting USB", metadata = {}, stock = 2, price = 1200, account = "bank", accountLabel = "Bank", probability = 100},
        }
    },
    --[[["weapons"] = { 
        label = "Weapons", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            if GetResourceState('av_gangs') ~= "started" then
                return false
            end
            local gang = exports['av_gangs']:getGang()
            if gang and gang['name'] == "ballas" then -- If is member of Ballas gang can access
                return true
            end
            return false
        end,
        items = {
            {name = "weapon_pistol", label = "Pistol", metadata = {}, stock = 5, price = 5000, account = "cosmo", accountLabel = "Cosmo", probability = 100},
        }
    },]]
}