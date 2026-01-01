Config = Config or {}
-- Ingredients Config
Config.MaxIngredients = 12    -- max ingredients u can select when u register an item
Config.RequireIngredients = true -- true/false player needs at least 1 ingredient to craft food
Config.Ingredients = {       -- You need to register this items in your Framework/Inventory, this ones are just EXAMPLES
    -- value = item name (exactly how is named in your inventory/framework)
    -- label = item label 
    -- jobs = table with allowed jobs to use this ingredient or false to make it available for everyone
    -- type = table with ItemTypes, this needs to be a table
    -- For ingredient effects please check config/effects.lua

    { value = "water",     label = "Water",      jobs = { "uwucafe", "burgershot" }, type = {"drink"} },
    { value = "kurkakola",     label = "Cola",      jobs = { "uwucafe", "burgershot", "kebabshop" }, type = {"drink"} },
    { value = "sugar",     label = "Sugar",      jobs = { "uwucafe", "burgershot" }, type = {"drink", "food"} },
    { value = "chocolate", label = "Chocolate",  jobs = false, type = {"drink", "food"} },
    { value = "milk",      label = "Milk",       jobs = false, type = {"drink", "food"} },
    { value = "ice",       label = "Ice",        jobs = false, type = {"drink"} },
    { value = "banana",    label = "Banana",     jobs = false,  type = {"drink", "food"} },
    -- kebab
    { value = "kebab_sliced",         label = "Freshly cooked Kebab",           jobs = { "kebabshop" }, type = {"food"} },
    { value = "kebab_chicken_dice",  label = "Freshly Cooked Chicken Kebab",   jobs = { "kebabshop" }, type = {"food"} },
    { value = "fries",               label = "Freshly Cooked fries",           jobs = { "kebabshop" }, type = {"food"} },
    { value = "grated_carrots",      label = "Freshly Grated Carrots",         jobs = { "kebabshop" }, type = {"food"} },
    { value = "sliced_tomato",       label = "Freshly Sliced Tomato",          jobs = { "kebabshop" }, type = {"food"} },
    { value = "sliced_cabbage",      label = "Freshly Sliced Cabbage",         jobs = { "kebabshop" }, type = {"food"} },
    { value = "fresh_fries",         label = "Freshly Cut Fries",              jobs = { "kebabshop" }, type = {"food"} },
    { value = "sliced_cucumber",     label = "Freshly Sliced Cucumber",        jobs = { "kebabshop" }, type = {"food"} },
    { value = "potato", label = "Potato", jobs = { "kebabshop" }, type = {"food"} },
    { value = "carrot", label = "Carrot", jobs = { "kebabshop" }, type = {"food"} },
    { value = "tomato",          label = "Tomato",                jobs = { "kebabshop" }, type = {"food"} },
    { value = "cabbage",         label = "Cabbage",               jobs = { "kebabshop" }, type = {"food"} },
}