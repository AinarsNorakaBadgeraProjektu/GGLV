---@class animals
---@field legal table legal animals table
---@field ilegal table ilegal animals table

-- The legal animals will spawn in the legal zones and the ilegal animals will spawn in the ilegal zones.
return {
    legal = {
        {
            label = 'Deer',
    
            model = 'a_c_deer',
            skinTime = 7500,
    
            skin = 'hunting_deer_skin',
            skinPrice = 65,
            skinQuantity = {
                min = 5,
                max = 10
            },
    
            meat = 'hunting_deer_meat',
            meatPrice = 35,
            meatQuantity = {
                min = 5,
                max = 15
            },
    
            needXp = 0,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        },
        {
            label = 'Pigeon',
    
            model = 'a_c_pigeon',
            skinTime = 3000,
    
            skin = 'hunting_pigeon_skin',
            skinPrice = 90,
            skinQuantity = {
                min = 5,
                max = 10
            },
    
            meat = 'hunting_pigeon_meat',
            meatPrice = 75,
            meatQuantity = {
                min = 1,
                max = 5
            },
    
            needXp = 10,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        },
        {
            label = 'Rabbit',
    
            model = 'a_c_rabbit_01',
            skinTime = 3000,
    
            skin = 'hunting_rabbit_skin',
            skinPrice = 95,
            skinQuantity = {
                min = 1,
                max = 5
            },
    
            meat = 'hunting_rabbit_meat',
            meatPrice = 80,
            meatQuantity = {
                min = 5,
                max = 10
            },
    
            needXp = 50,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        },
        {
            label = 'Boar',
    
            model = 'a_c_boar',
            skinTime = 7500,
    
            skin = 'hunting_boar_skin',
            skinPrice = 100,
            skinQuantity = {
                min = 1,
                max = 3
            },
    
            meat = 'hunting_boar_meat',
            meatPrice = 85,
            meatQuantity = {
                min = 5,
                max = 10
            },
    
            needXp = 150,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        }
    },

    ilegal = {
        {
            label = 'Crow',
    
            model = 'a_c_crow',
            skinTime = 2500,
    
            skin = 'hunting_crow_skin',
            skinPrice = 110,
            skinQuantity = {
                min = 1,
                max = 5
            },
    
            meat = 'hunting_crow_meat',
            meatPrice = 75,
            meatQuantity = {
                min = 1,
                max = 10
            },
    
            needXp = 350,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        },
        {
            label = 'Seagull',
    
            model = 'a_c_seagull',
            skinTime = 2500,
    
            skin = 'hunting_seagull_skin',
            skinPrice = 120,
            skinQuantity = {
                min = 1,
                max = 5
            },
    
            meat = 'hunting_seagull_meat',
            meatPrice = 75,
            meatQuantity = {
                min = 1,
                max = 10
            },
    
            needXp = 450,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        },
        {
            label = 'Coyote',
    
            model = 'a_c_coyote',
            skinTime = 5000,
    
            skin = 'hunting_coyote_skin',
            skinPrice = 130,
            skinQuantity = {
                min = 1,
                max = 3
            },
    
            meat = 'hunting_coyote_meat',
            meatPrice = 70,
            meatQuantity = {
                min = 1,
                max = 7
            },
    
            needXp = 500,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        },
        {
            label = 'Chicken Hawk',
    
            model = 'a_c_chickenhawk',
            skinTime = 2500,
    
            skin = 'hunting_chickenhawk_skin',
            skinPrice = 150,
            skinQuantity = {
                min = 1,
                max = 5
            },
    
            meat = 'hunting_chickenhawk_meat',
            meatPrice = 95,
            meatQuantity = {
                min = 1,
                max = 10
            },
    
            needXp = 500,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        },
        {
            label = 'Mountain Lion',
    
            model = 'a_c_mtlion',
            skinTime = 5000,
    
            skin = 'hunting_mtlion_skin',
            skinPrice = 175,
            skinQuantity = {
                min = 1,
                max = 3
            },
    
            meat = 'hunting_mtlion_meat',
            meatPrice = 100,
            meatQuantity = {
                min = 1,
                max = 5
            },
    
            needXp = 700,
            xpGain = {
                min = 1,
                max = 5
            },
    
            minHunger = 10,
            maxHunger = 30
        }
    }
}
