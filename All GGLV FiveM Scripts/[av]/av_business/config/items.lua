Config = Config or {}
Config.itemsWhitelist = {
    -- This whitelist is for items that already exist in your Framework and u want the business to be able to craft it on their menus
    -- value: how the item is named in your Framework/inventory
    -- label: how the business boss will see it in the app
    -- jobs: authorized jobs that can add this item to their menus
    -- type: table with ItemTypes that are compatible with this item (for example milk can be compatible with drink but also with food)
    -- override: true/false, if true it will use av_business effects/animations, if you have this same item registered in a different script leave it as false
    
    { value = "water", label = "Water", jobs = { "burgershot", "uwu_cafe", "upnatom" }, type = {"drink"}, override = false },
--    { value = "milk", label = "Milk", jobs = { "burgershot", "uwu_cafe" }, type = {"drink", "food"}, override = false },
}

-- Item types
Config.ItemTypes = { -- Used for Create Item in Laptop APP
    -- You can job restrict or use false so everyone can use it
    { value = "drink",   label = "Drink", jobs = false },
    { value = "food",    label = "Food", jobs = false  },
    { value = "joint",   label = "Joint", jobs = false  },
    { value = "others",  label = "Others", jobs = false  },
    { value = "box",     label = "Boxes", jobs = false  },
    { value = "alcohol", label = "Alcohol", jobs = false  },
    -- Kebab
    { value = "kebab_wrap",                    label = "Kebab Wrap With Salad",                  jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_wrap_cola",              label = "Kebab Wrap With Salad and Cola",         jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_salad_fries",            label = "Kebab with Salad and Fries",             jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_salad_fries_cola",       label = "Kebab with Salad, Fries and Cola",       jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_chicken_wrap",           label = "Chicken Kebab Wrap With Salad",          jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_chicken_wrap_cola",      label = "Chicken Kebab Wrap With Salad and Cola", jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_chicken_salad_fries",    label = "Chicken Kebab with Salad and Fries",     jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_chicken_salad_fries_cola", label = "Chicken Kebab with Salad, Fries and Cola", jobs = {"kebabshop"}, type = {"food"} },
    { value = "salad_plate",                  label = "Fresh Salad Plate",                      jobs = {"kebabshop"}, type = {"food"} },
    { value = "kebab_sliced",         label = "Freshly cooked Kebab",           jobs = { "kebabshop" }, type = {"food"} },
    { value = "kebab_chicken_dice",  label = "Freshly Cooked Chicken Kebab",   jobs = { "kebabshop" }, type = {"food"} },
    { value = "fries",               label = "Freshly Cooked fries",           jobs = { "kebabshop" }, type = {"food"} },
    { value = "grated_carrots",      label = "Freshly Grated Carrots",         jobs = { "kebabshop" }, type = {"food"} },
    { value = "sliced_tomato",       label = "Freshly Sliced Tomato",          jobs = { "kebabshop" }, type = {"food"} },
    { value = "sliced_cabbage",      label = "Freshly Sliced Cabbage",         jobs = { "kebabshop" }, type = {"food"} },
    { value = "fresh_fries",         label = "Freshly Cut Fries",              jobs = { "kebabshop" }, type = {"food"} },
    { value = "sliced_cucumber",     label = "Freshly Sliced Cucumber",        jobs = { "kebabshop" }, type = {"food"} },
    
--    { value = "example",    label = "Example Item Type", jobs = {"police", "ambulance"}  },
}

Config.DefaultItemWeight = 5000 -- Just in case the item type isn't defined in the following table
Config.ItemsWeight = {
    ['drink'] = 1000,           -- 1kg
    ['food'] = 1000,            -- 1kg
    ['joint'] = 1000,           -- 1kg
    ['others'] = 1000,          -- 1kg
    ['box'] = 5000,             -- 5kg
}