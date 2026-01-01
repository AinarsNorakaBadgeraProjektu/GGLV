Config = {}
Config.Lang = "en"
Config.PrimaryIdentifier = "license"
Config.CustomPrefix = "char" -- Here you can set you custom prefix for characters (ESX only)
Config.DefaultBucket = 0
Config.Debug = false
Config.EnableLicenseCheckOnConnect = true       -- Works only on ESX and checks for duplicated licenses
Config.NuiBlur = false -- Disabled by default (may cause performance drops)
Config.MoneySeparator = "." -- Used to format money ex: 1000 will be displayed as 1.000

Config.ResourcesToDisable = {
    -- QB:
    ["qb-loading"] = true,
    ["qb-multicharacter"] = true,
    ["qb-spawn"] = true,
    ["qb-clothing"] = true,

    -- ESX:
    ["esx_multicharacter"] = false,
    ["esx_identity"] = false,
    ["esx_skin"] = false,
    ["esx_loadingscreen"] = false,
    ["skinchanger"] = true,

    ["illenium-appearance"] = true
}

Config.StoresBlips = {
    ["clothing"] = {
        sprite = 366,
        scale = 0.7,
        color = 0,
    },
    ["barber"] = {
        sprite = 71,
        scale = 0.7,
        color = 0,
    },
    ["surgeon"] = {
        sprite = 403,
        scale = 0.7,
        color = 0,
    },
    ["tattoo"] = {
        sprite = 75,
        scale = 0.7,
        color = 4,
    },
}

-- Stores taken from QBCORE to support it
Config.UseTarget = true
Config.Stores = {
    [1] = {price = 50, shopType = 'clothing', coords = vector4(1693.91, 4821.81, 41.06, 109.25), ped = `a_f_y_soucent_01`, radius = 3.0, hideBlip = true },
    [2] = {price = 50, shopType = 'clothing', coords = vector4(-709.75, -153.95, 36.42, 105.44), ped = `s_m_m_movprem_01`, radius = 3.0, hideBlip = true },
    [3] = {price = 50, shopType = 'clothing', coords = vector4(-1192.41, -772.64, 16.33, 99.67), ped = `u_f_y_mistress`, radius = 3.0, hideBlip = true },
    [4] = {price = 50, shopType = 'clothing', coords = vector4(425.36, -807.41, 28.49, 101.17), ped = `a_f_y_soucent_01`, radius = 3.0, hideBlip = true },
    [5] = {price = 50, shopType = 'clothing', coords = vector4(-162.64, -301.98, 38.73, 257.59), ped = `s_m_m_movprem_01`, radius = 3.0, hideBlip = true },
    [6] = {price = 50, shopType = 'clothing', coords = vector4(75.74, -1391.67, 28.38, 265.76), ped = `a_f_y_soucent_01`, radius = 3.0, hideBlip = true },
    [7] = {price = 50, shopType = 'clothing', coords = vector4(-821.28, -1073.0, 10.33, 223.11), ped = `a_f_y_soucent_01`, radius = 3.0, hideBlip = true },
    [8] = {price = 50, shopType = 'clothing', coords = vector4(-1451.3, -238.38, 48.81, 47.66), ped = `s_m_m_movprem_01`, radius = 3.0, hideBlip = true },
    [9] = {price = 50, shopType = 'clothing', coords = vector4(4.11, 6511.94, 30.88, 46.79), ped = `a_f_y_soucent_01`, radius = 3.0, hideBlip = true },
    [10] = {price = 50, shopType = 'clothing', coords = vector4(618.55, 2761.18, 41.09, 173.39), ped = `u_f_y_mistress`, radius = 3.0, hideBlip = true },
    [11] = {price = 50, shopType = 'clothing', coords = vector4(1197.87, 2710.09, 37.22, 192.14), ped = `a_f_y_soucent_01`, radius = 3.0, hideBlip = true },
    [12] = {price = 50, shopType = 'clothing', coords = vector4(-3173.71, 1047.13, 19.86, 328.29), ped = `u_f_y_mistress`, radius = 3.0, hideBlip = true },
    [13] = {price = 50, shopType = 'clothing', coords = vector4(-1100.45, 2711.43, 18.11, 235.52), ped = `a_f_y_soucent_01`, radius = 3.0, hideBlip = true },
    [14] = {price = 50, shopType = 'clothing', coords = vector4(-1207.5, -1457.89, 3.36, 31.84), ped = `ig_g`, radius = 3.0, hideBlip = true },
    [15] = {price = 50, shopType = 'clothing', coords = vector4(120.21, -224.81, 53.56, 296.7), ped = `u_f_y_mistress`, radius = 3.0, hideBlip = true },
    [16] = {price = 15, shopType = 'barber', coords = vector4(-814.3, -183.8, 36.58, 130.43), ped = `s_f_m_fembarber`, radius = 3.0, hideBlip = true },
    [17] = {price = 15, shopType = 'barber', coords = vector4(136.8, -1708.4, 28.3, 130.43), ped = `s_f_m_fembarber`, radius = 3.0, hideBlip = true },
    [18] = {price = 15, shopType = 'barber', coords = vector4(-1282.61, -1116.82, 5.99, 80.23), ped = `s_f_m_fembarber`, radius = 3.0, hideBlip = true },
    [19] = {price = 15, shopType = 'barber', coords = vector4(1931.43, 3729.75, 31.84, 236.03), ped = `s_f_m_fembarber`, radius = 3.0, hideBlip = true },
    [20] = {price = 15, shopType = 'barber', coords = vector4(1212.87, -472.89, 65.21, 61.65), ped = `s_f_m_fembarber`, radius = 3.0, hideBlip = true },
    [21] = {price = 15, shopType = 'barber', coords = vector4(-32.97, -152.33, 56.08, 343.66), ped = `s_f_m_fembarber`, radius = 3.0, hideBlip = true },
    [22] = {price = 15, shopType = 'barber', coords = vector4(-278.02, 6228.53, 30.7, 55.18), ped = `s_f_m_fembarber`, radius = 3.0, hideBlip = true },
    -- [23] = {price = 3000, shopType = 'surgeon', coords = vector4(-451.67, -1005.64, 23.78, 17.9), ped = `s_m_m_doctor_01`, radius = 3.0, hideBlip = true },
}

Config.OutfitChangers = {
    [1] = {shopType = 'outfit', coords = vector3(1697.41, 4829.25, 41.06)},
    [2] = {shopType = 'outfit', coords = vector3(-703.83, -151.67, 36.42)},
    [3] = {shopType = 'outfit', coords = vector3(-1187.19, -768.64, 16.33)},
    [4] = {shopType = 'outfit', coords = vector3(429.5, -800.15, 28.49)},
    [5] = {shopType = 'outfit', coords = vector3(-168.21, -298.7, 38.73)},
    [6] = {shopType = 'outfit', coords = vector3(71.06, -1399.17, 28.38)},
    [7] = {shopType = 'outfit', coords = vector3(-829.72, -1073.33, 10.33)},
    [8] = {shopType = 'outfit', coords = vector3(-1447.51, -242.81, 48.82)},
    [9] = {shopType = 'outfit', coords = vector3(12.28, 6513.63, 30.88)},
    [10] = {shopType = 'outfit', coords = vector3(617.89, 2766.79, 41.09)},
    [11] = {shopType = 'outfit', coords = vector3(1190.35, 2714.51, 37.22)},
    [12] = {shopType = 'outfit', coords = vector3(-3175.64, 1041.84, 19.86)},
    [13] = {shopType = 'outfit', coords = vector3(-1108.95, 2709.37, 18.11)},
    [14] = {shopType = 'outfit', coords = vector3(-1203.79, -1454.53, 3.38)},
    [15] = {shopType = 'outfit', coords = vector3(120.44, -227.38, 53.56)}
}

-- set isGang to true if the requiredJob is a gang
Config.ClothingRooms = {
    [1] = {requiredJob = 'police', isGang = false, coords = vector3(-1081.9757, -828.3637, 19.2980)},
    [2] = {requiredJob = 'ambulance', isGang = false, coords = vector3(-469.4132, -946.1519, 23.6911)},
}


-- This is working only on QBCore
Config.Outfits = {
    ['police'] = {
        -- Job
        ['male'] = {
            -- Gender
            [0] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [1] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [2] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [3] = {
                    -- Outfits
                    outfitLabel = 'Probationary Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -278, texture = 6, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [3] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [3] = {
                    -- Outfits
                    outfitLabel = 'Probationary Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -278, texture = 6, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [4] = {
                    -- Outfits
                    outfitLabel = 'Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 736, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [4] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [3] = {
                    -- Outfits
                    outfitLabel = 'Probationary Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -278, texture = 6, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [4] = {
                    -- Outfits
                    outfitLabel = 'Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 736, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [5] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [3] = {
                    -- Outfits
                    outfitLabel = 'Probationary Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -278, texture = 6, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [4] = {
                    -- Outfits
                    outfitLabel = 'Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 736, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [5] = {
                    -- Outfits
                    outfitLabel = 'Senior Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 737, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [6] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [3] = {
                    -- Outfits
                    outfitLabel = 'Probationary Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -278, texture = 6, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [4] = {
                    -- Outfits
                    outfitLabel = 'Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 736, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [5] = {
                    -- Outfits
                    outfitLabel = 'Senior Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 737, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [6] = {
                    -- Outfits
                    outfitLabel = 'Corporal',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 737, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -281, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [7] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [3] = {
                    -- Outfits
                    outfitLabel = 'Probationary Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -278, texture = 6, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [4] = {
                    -- Outfits
                    outfitLabel = 'Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 736, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [5] = {
                    -- Outfits
                    outfitLabel = 'Senior Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 737, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [6] = {
                    -- Outfits
                    outfitLabel = 'Corporal',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 737, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -281, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [7] = {
                    -- Outfits
                    outfitLabel = 'Corporal',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 171, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 741, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -281, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
            [8] = {
                -- Grade Level
                [1] = {
                    -- Outfits
                    outfitLabel = 'Trainees',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    -- Outfits
                    outfitLabel = 'Cadets',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 146, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [3] = {
                    -- Outfits
                    outfitLabel = 'Probationary Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 733, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -278, texture = 6, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [4] = {
                    -- Outfits
                    outfitLabel = 'Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 144, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 736, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [5] = {
                    -- Outfits
                    outfitLabel = 'Senior Officer',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 737, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -280, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [6] = {
                    -- Outfits
                    outfitLabel = 'Corporal',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 178, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 737, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -281, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [7] = {
                    -- Outfits
                    outfitLabel = 'Detective',
                    outfitData = {
                        ['pants'] = {texture = 1, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 171, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 741, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -281, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [8] = {
                    -- Outfits
                    outfitLabel = 'Sergeant',
                    outfitData = {
                        ['pants'] = {texture = 0, item = 267, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 172, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 275, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 145, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 738, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 25, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = -279, texture = 1, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 16, texture = 2, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 121, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
            },
        },
        ['female'] = {
            -- Gender
            [0] = {
                -- Grade Level
                [1] = {
                    outfitLabel = 'Short Sleeve',
                    outfitData = {
                        ['pants'] = {item = 133, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 31, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 35, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 34, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 48, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 52, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                },
                [2] = {
                    outfitLabel = 'Trooper Tan',
                    outfitData = {
                        ['pants'] = {item = 133, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['arms'] = {item = 31, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 35, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T Shirt
                        ['vest'] = {item = 34, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Body Vest
                        ['torso2'] = {item = 327, texture = 3, defaultItem = 0, defaultTexture = 0}, -- Jacket
                        ['shoes'] = {item = 52, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck Accessory
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Mask
                    }
                }
            },
        }
    },
    ['ambulance'] = {
        -- Job
        ['male'] = {            -- Gender
            [0] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Apprentice',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [1] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [2] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Senior Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [3] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic Supervisor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [4] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Consulting Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [5] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =560, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [6] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =560, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [7] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [8] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =560, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [9] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =560, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [10] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =560, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [11] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =560, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [12] = {                -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =602, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 211, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 54, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 15, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =583, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 2, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 179, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item =560, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 3, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 20, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 151, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            }
        },
        ['female'] = { -- Gender
            [0] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Apprentice',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [1] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [2] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Senior Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [3] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic Supervisor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [4] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Consulting Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [5] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 37, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 624, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 96, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [6] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 37, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 624, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 96, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [7] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [8] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 37, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 624, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 96, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [9] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 37, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 624, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 96, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [10] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 37, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 624, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 96, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [11] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 37, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 624, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 96, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            },
            [12] = { -- Grade Level
                [1] = {
                    outfitLabel = 'Paramedic',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 706, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 233, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [2] = {
                    outfitLabel = 'Junior Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 748, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                },
                [3] = {
                    outfitLabel = 'Doctor',
                    outfitData = {
                        ['arms'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Arms
                        ['t-shirt'] = {item = 37, texture = 0, defaultItem = 0, defaultTexture = 0}, -- T-Shirt
                        ['torso2'] = {item = 624, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Jackets
                        ['vest'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Vest
                        ['decals'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Decals
                        ['accessory'] = {item = 96, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Neck
                        ['bag'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Bag
                        ['pants'] = {item = 237, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Pants
                        ['shoes'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Shoes
                        ['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
                        ['hat'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Hat
                        ['glass'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Glasses
                        ['ear'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0} -- Ear accessories
                    }
                }
            }
        }
    }
}