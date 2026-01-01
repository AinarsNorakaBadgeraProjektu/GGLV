Config = {}

Config.trucker_logistics =
    { -- Settings related to the link with the Truck Logistics script
        ['enable'] = true, -- Set this as true if you own the Truck Logistics script and want to link the jobs created in the Hire Deliveryman page with the truckers
        ['quick_jobs_page'] = true, -- true: The jobs created will appear in the Quick jobs page in the trucker logistics (it uses a rented truck). false: They will appear in the Freights page (it requires an owned truck)
        ['available_trucks'] = { -- List of trucks that are generated in contracts
            "hauler", "packer"
        },
        ['available_trailers'] = { -- List of trailers that are generated in contracts
            "trailers", "trailers2", "trailers3"
        }
    }

Config.max_stores_per_player = 1 -- Maximum number of stores that each player can have
Config.max_stores_employed = 2 -- Maximum number of stores that each player can be employed
Config.has_stock_when_unowed = true -- If true, the store stock will be full stock when there is no owner. If false, the store stock will be empty when there is no owner
Config.max_jobs = 20 -- Max amount of jobs that each store can create
Config.disable_rename_business = false -- Set this to true if you want to disable the function to rename the business
Config.group_map_blips = true -- true: will group all the blips into a single category in the map. false: all the blips will be grouped just by the name and icon
Config.charge_import_money_before = true -- true: The money will be deducted from the store balance when the player starts the job. false: The money will be deducted only after the player finishes the job

Config.market_locations = {
    ["market_1"] = { -- ID
        ['buy_price'] = 540000, -- Price to buy this market
        ['sell_price'] = 220000, -- Price to sell this market
        ['coord'] = {-709.57440185547, -905.78985595703, 19.215585708618}, -- Coordinate to open the menu (vector3)
        ['garage_coord'] = {-707.13, -924.98, 19.02, 179.01}, -- Garage coordinates, where the trucks will spawn (vector4)
        ['truck_parking_location'] = {-707.95, -929.8, 19.01, 180.0}, -- Location that the trucks from Trucker Logistics script will park when delivering cargo for this store (vector3)
        ['map_blip_coord'] = {-714.77, -912.22, 19.21}, -- Map blip coordinates, where the map blip will appear (vector3)
        ['sell_blip_coords'] = { -- The coordinates where customes will buy things on this store (vector3)
            {-714.77520751953, -912.22875976562, 19.215589523315},
            {-707.40911865234, -913.48266601562, 19.215589523315},
            {-711.70471191406, -912.08258056641, 19.215587615967}
        },
        ['deliveryman_coord'] = {-714.55, -917.8, 19.22}, -- Coord where the deliveryman will take the jobs you've created
        ['type'] = '247store', -- Insert here the market type ID
        ['account'] = { -- Account settings for this store
            ['item'] = { -- Account that the money should be debited when buying item in the market (player can choose between 2)
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank' -- Account that should be used with store expenses (owner)
        }
    },
    ["market_2"] = {
        ['buy_price'] = 400000,
        ['sell_price'] = 150000,
        ['coord'] = {30.239591598511, -1339.2818603516, 29.497043609619},
        ['garage_coord'] = {15.5082, -1339.9766, 29.0966, 187.0889},
        ['truck_parking_location'] = {24.0538, -1357.3694, 29.503, 88.4017},
        ['map_blip_coord'] = {25.71, -1346.47, 29.49},
        ['sell_blip_coords'] = {
            {25.711700439453, -1346.4722900391, 29.497022628784},
            {29.209434509277, -1342.6048583984, 29.497022628784}
        },
        ['deliveryman_coord'] = {
            22.906536102295, -1350.3334960938, 29.327049255371
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_3"] = {
        ['buy_price'] = 320000,
        ['sell_price'] = 125000,
        ['coord'] = {2549.6564941406, 386.92138671875, 108.62294006348},
        ['garage_coord'] = {2588.82, 413.31, 108.46, 178.94},
        ['truck_parking_location'] = {2564.896, 366.3779, 108.7248, 177.4842},
        ['map_blip_coord'] = {2556.73, 382.11, 108.62},
        ['sell_blip_coords'] = {
            {2556.7326660156, 382.11276245117, 108.62294006348},
            {2553.4436035156, 386.15994262695, 108.62294006348}
        },
        ['deliveryman_coord'] = {
            2560.1857910156, 382.88265991211, 108.62112426758
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_4"] = {
        ['buy_price'] = 460000,
        ['sell_price'] = 180000,
        ['coord'] = {1159.861328125, -315.43588256836, 69.205146789551},
        ['garage_coord'] = {1155.32, -336.2, 68.35, 188.49},
        ['truck_parking_location'] = {1184.322, -314.0848, 69.4398, 279.8044},
        ['map_blip_coord'] = {1163.42, -322.91, 69.20},
        ['sell_blip_coords'] = {
            {1163.4259033203, -322.91970825195, 69.205146789551},
            {1157.6358642578, -321.5302734375, 69.205070495605}
        },
        ['deliveryman_coord'] = {
            1154.8171386719, -326.7705078125, 69.205146789551
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_5"] = {
        ['buy_price'] = 360000,
        ['sell_price'] = 120000,
        ['coord'] = {-1827.9733886719, 798.20367431641, 138.17694091797},
        ['garage_coord'] = {-1821.48, 777.52, 137.43, 216.69},
        ['truck_parking_location'] = {-1807.3877, 789.4099, 138.4138, 220.8947},
        ['map_blip_coord'] = {-1820.92, 793.17, 138.11},
        ['sell_blip_coords'] = {
            {-1820.92578125, 793.17431640625, 138.11315917969},
            {-1826.7426757813, 791.42193603516, 138.22721862793}
        },
        ['deliveryman_coord'] = {
            -1826.259765625, 785.52191162109, 138.28074645996
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_6"] = {
        ['buy_price'] = 400000,
        ['sell_price'] = 145000,
        ['coord'] = {380.2028503418, 332.70526123047, 103.56661224365},
        ['garage_coord'] = {366.43, 332.03, 103.51, 165.15},
        ['truck_parking_location'] = {361.3589, 319.2109, 103.9061, 76.4428},
        ['map_blip_coord'] = {374.20, 326.91, 103.56},
        ['sell_blip_coords'] = {
            {374.2092590332, 326.91537475586, 103.56636810303},
            {378.62329101563, 329.6838684082, 103.56645202637}
        },
        ['deliveryman_coord'] = {
            379.77386474609, 324.36444091797, 103.56636810303
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_7"] = {
        ['buy_price'] = 340000,
        ['sell_price'] = 120000,
        ['coord'] = {-3249.6938476563, 1006.4963378906, 12.830717086792},
        ['garage_coord'] = {-3243.39, 991.74, 12.48, 272.72},
        ['truck_parking_location'] = {-3234.5576, 1009.0838, 12.4311, 177.7641},
        ['map_blip_coord'] = {-3242.96, 1001.31, 12.83},
        ['sell_blip_coords'] = {
            {-3242.9636230469, 1001.3184204102, 12.830706596375},
            {-3246.5126953125, 1005.4541015625, 12.830707550049}
        },
        ['deliveryman_coord'] = {
            -3240.6967773438, 1007.2897338867, 12.830706596375
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_8"] = {
        ['buy_price'] = 240000,
        ['sell_price'] = 70000,
        ['coord'] = {1736.3872070312, 6419.7211914062, 35.037223815918},
        ['garage_coord'] = {1718.27, 6418.38, 33.45, 152.26},
        ['truck_parking_location'] = {1713.1648, 6410.5093, 33.6366, 155.0778},
        ['map_blip_coord'] = {1729.38, 6415.42, 35.03},
        ['sell_blip_coords'] = {
            {1729.3813476563, 6415.4287109375, 35.037223815918},
            {1734.6462402344, 6417.05078125, 35.037223815918}
        },
        ['deliveryman_coord'] = {
            1734.0440673828, 6411.107421875, 35.037223815918
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_9"] = {
        ['buy_price'] = 360000,
        ['sell_price'] = 125000,
        ['coord'] = {544.38342285156, 2662.8591308594, 42.15648651123},
        ['garage_coord'] = {533.9, 2667.9, 42.28, 8.76},
        ['truck_parking_location'] = {533.3693, 2669.5442, 42.5447, 7.0399},
        ['map_blip_coord'] = {547.74, 2671.56, 42.15},
        ['sell_blip_coords'] = {
            {547.74603271484, 2671.5610351563, 42.156494140625},
            {545.18780517578, 2666.6081542969, 42.156494140625}
        },
        ['deliveryman_coord'] = {
            541.56079101563, 2674.0302734375, 42.173282623291
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_10"] = {
        ['buy_price'] = 340000,
        ['sell_price'] = 120000,
        ['coord'] = {1961.1793212891, 3749.8298339844, 32.343872070313},
        ['garage_coord'] = {1972.04, 3746.88, 32.32, 209.52},
        ['truck_parking_location'] = {1696.6696, 3742.3357, 34.1548, 225.9438},
        ['map_blip_coord'] = {1961.35, 3741.49, 32.34},
        ['sell_blip_coords'] = {
            {1961.3522949219, 3741.4907226563, 32.343746185303},
            {1962.2821044922, 3746.6899414063, 32.343742370605}
        },
        ['deliveryman_coord'] = {
            1966.9969482422, 3742.9167480469, 32.343742370605
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_11"] = {
        ['buy_price'] = 340000,
        ['sell_price'] = 120000,
        ['coord'] = {2673.9375, 3288.3955078125, 55.241134643555},
        ['garage_coord'] = {2689.24, 3272.53, 55.25, 328.87},
        ['truck_parking_location'] = {2651.1384, 3263.427, 55.4719, 151.0635},
        ['map_blip_coord'] = {2679.80, 3286.73, 55.24},
        ['sell_blip_coords'] = {
            {2679.8056640625, 3286.7331542969, 55.241130828857},
            {2680.9682617188, 3285.2114257813, 55.241130828857}
        },
        ['deliveryman_coord'] = {
            2679.7431640625, 3276.6286621094, 55.408432006836
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_12"] = {
        ['buy_price'] = 240000,
        ['sell_price'] = 70000,
        ['coord'] = {1706.8068847656, 4921.125, 42.063636779785},
        ['garage_coord'] = {1689.02, 4919.69, 42.08, 57.01},
        ['truck_parking_location'] = {1686.8475, 4922.3828, 42.3414, 55.4782},
        ['map_blip_coord'] = {1700.00, 4925.55, 42.06},
        ['sell_blip_coords'] = {
            {1701.2, 4925.15, 42.07}, {1702.8, 4928.78, 42.1}
        },
        ['deliveryman_coord'] = {
            1700.3133544922, 4932.724609375, 42.078147888184
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_13"] = {
        ['buy_price'] = 580000,
        ['sell_price'] = 240000,
        ['coord'] = {-44.314395904541, -1749.6755371094, 29.42099571228},
        ['garage_coord'] = {-63.1, -1742.7, 29.31, 57.2},
        ['truck_parking_location'] = {-20.8732, -1767.8015, 29.4571, 231.7498},
        ['map_blip_coord'] = {-50.81, -1754.87, 29.42},
        ['sell_blip_coords'] = {
            {-50.81156539917, -1754.8782958984, 29.42099571228},
            {-51.959354400635, -1751.5548095703, 29.420993804932}
        },
        ['deliveryman_coord'] = {
            -55.720436096191, -1755.5327148438, 29.439630508423
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_14"] = {
        ['buy_price'] = 340000,
        ['sell_price'] = 120000,
        ['coord'] = {1390.8, 3600.65, 34.98}, 
        ['garage_coord'] = {1384.52, 3593.7, 34.9, 210.34},
        ['truck_parking_location'] = {1381.198, 3594.0959, 35.1478, 200.0481},
        ['map_blip_coord'] = {1398.45, 3607.05, 34.98},
        ['sell_blip_coords'] = {
            {1391.74, 3605.23, 35.1} 
        },
        ['deliveryman_coord'] = {
            1391.8991699219, 3598.4467773438, 35.031749725342
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_15"] = {
        ['buy_price'] = 320000,
        ['sell_price'] = 90000,
        ['coord'] = {-3048.3173828125, 587.68206787109, 7.9091401100159},
        ['garage_coord'] = {-3045.94, 598.67, 7.49, 287.24},
        ['truck_parking_location'] = {-3032.1746, 594.4594, 7.9666, 18.8748},
        ['map_blip_coord'] = {-3041.66, 586.27, 7.90},
        ['sell_blip_coords'] = {
            {-3041.6618652344, 586.27044677734, 7.9089336395264},
            {-3042.8251953125, 591.28076171875, 7.9089341163635}
        },
        ['deliveryman_coord'] = {
            -3038.2590332031, 593.58917236328, 7.8191342353821
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_16"] = {
        ['buy_price'] = 360000,
        ['sell_price'] = 120000,
        ['coord'] = {1163.9194335938, 2709.1730957031, 38.15767288208},
        ['garage_coord'] = {1169.43, 2694.08, 37.84, 85.41},
        ['truck_parking_location'] = {1181.8191, 2695.3115, 38.2108, 268.9558},
        ['map_blip_coord'] = {1164.06, 2707.60, 38.15},
        ['sell_blip_coords'] = {
            {1164.0694580078, 2707.6005859375, 38.157665252686},
            {1166.1302490234, 2707.2504882813, 38.157676696777}
        },
        ['deliveryman_coord'] = {
            1160.2208251953, 2702.11328125, 38.183746337891
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_17"] = {
        ['buy_price'] = 240000,
        ['sell_price'] = 70000,
        ['coord'] = {169.27001953125, 6644.1645507813, 31.71063041687},
        ['garage_coord'] = {146.9, 6634.98, 31.61, 175.81},
        ['truck_parking_location'] = {164.0575, 6625.502, 32.0364, 225.7734},
        ['map_blip_coord'] = {164.15, 6641.15, 31.71},
        ['sell_blip_coords'] = {
            {164.15994262695, 6641.15625, 31.710638046265},
            {167.01026916504, 6637.4892578125, 31.710649490356}
        },
        ['deliveryman_coord'] = {
            157.05537414551, 6641.224609375, 31.605260848999
        },
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["market_18"] = {
        ['buy_price'] = 950000,
        ['sell_price'] = 250000,
        ['coord'] = {37.96, -1782.45, 29.63},
        ['garage_coord'] = {27.01, -1790.15, 27.28, 46.01},
        ['truck_parking_location'] = {27.01, -1790.15, 27.28, 46.01},
        ['map_blip_coord'] = {43.29, -1767.81, 29.58},
        ['sell_blip_coords'] = {
            {47.49, -1755.11, 29.86}, {31.0, -1775.13, 29.85}
        },
        ['deliveryman_coord'] = {93.47, -1824.46, 26.3},
        ['type'] = '247store',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    },
    ["ammunation"] = {
        ['buy_price'] = 5000000,
        ['sell_price'] = 2000000,
        ['coord'] = {14.470663070679, -1106.0792236328, 29.797006607056},
        ['garage_coord'] = {27.71, -1113.25, 29.3, 329.89},
        ['truck_parking_location'] = {-13.8833, -1125.8661, 27.5543, 157.6875},
        ['map_blip_coord'] = {20.91, -1110.49, 29.79},
        ['sell_blip_coords'] = {{14.59, -1109.19, 29.96}},
        ['deliveryman_coord'] = {18.89, -1116.02, 29.79},
        ['type'] = 'ammunation',
        ['account'] = {
            ['item'] = {
                [1] = {['icon'] = 'img/credit_card.png', ['account'] = 'bank'},
                [2] = {['icon'] = 'img/cash.png', ['account'] = 'cash'}
            },
            ['store'] = 'bank'
        }
    }
}

-- Here you configure each type of market available to buy
Config.market_types = {
    ['247store'] = { -- Market type ID
        ['stock_capacity'] = 150, -- Max stock capacity
        ['max_employees'] = 5, -- Max employees
        ['required_job'] = {}, -- Required job do purchase goods in this store (set to {} to dont require any job here, or put the job name there like this: ['required_job'] = {'cop', 'gang', 'job_name'},)
        ['upgrades'] = { -- Definition of each upgrade
            ['stock'] = { -- Stock capacity
                ['price'] = 50000, -- Price to upgrade
                ['level_reward'] = { -- Reward of each level (max level: 5)
                    [0] = 0,
                    [1] = 50,
                    [2] = 100,
                    [3] = 150,
                    [4] = 200,
                    [5] = 300
                }
            },
            ['truck'] = { -- Truck capacity
                ['price'] = 50000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 25,
                    [2] = 50,
                    [3] = 100,
                    [4] = 200,
                    [5] = 300
                }
            },
            ['relationship'] = { -- Relationship
                ['price'] = 150000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 5,
                    [2] = 10,
                    [3] = 15,
                    [4] = 20,
                    [5] = 25
                }
            }
        },
        ['trucks'] = { -- Trucks for each level when upgrade the truck cargo
            [0] = 'speedo',
            [1] = 'gburrito',
            [2] = 'mule2',
            [3] = 'mule3',
            [4] = 'pounder',
            [5] = 'pounder2'
        },
        ['max_purchasable_categories'] = 5, -- The max amount of categories that can be purchased
        ['categories'] = { -- Here you configure the categories available to purchase in your store
            "alcohol_market", "drink_market", "food_market",
            "electronics_market", "utilities_market", "backpack_shop"
        },
        ['default_categories'] = { -- Here you can configure the categories available when the store has no owner
            "alcohol_market", "drink_market", "food_market",
            "electronics_market", "utilities_market", "backpack_shop"
        },
        ['blips'] = { -- Create the blips on map
            ['id'] = 52, -- Blip ID [Set this value 0 to dont have blip]
            ['name'] = "Market", -- Blip Name [Will be replaced when the owner rename the store]
            ['color'] = 4, -- Blip Color
            ['scale'] = 0.6 -- Blip Scale
        }
    },
    ['ammunation'] = {
        ['stock_capacity'] = 50,
        ['max_employees'] = 3,
        ['required_job'] = {},
        ['upgrades'] = {
            ['stock'] = {
                ['price'] = 16000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40,
                    [5] = 50
                }
            },
            ['truck'] = {
                ['price'] = 25000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 10,
                    [2] = 20,
                    [3] = 40,
                    [4] = 70,
                    [5] = 90
                }
            },
            ['relationship'] = {
                ['price'] = 32000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 3,
                    [2] = 5,
                    [3] = 8,
                    [4] = 10,
                    [5] = 15
                }
            }
        },
        ['trucks'] = {
            [0] = 'speedo',
            [1] = 'gburrito',
            [2] = 'mule2',
            [3] = 'mule3',
            [4] = 'pounder',
            [5] = 'pounder2'
        },
        ['max_purchasable_categories'] = 4,
        ['categories'] = {
            "melee_weapons", "pistol_weapons", "ammo_weapons", "others_weapons"
        },
        ['default_categories'] = {
            "melee_weapons", "pistol_weapons", "ammo_weapons", "others_weapons"
        },
        ['blips'] = {
            ['id'] = 110,
            ['name'] = "Ammunation",
            ['color'] = 4,
            ['scale'] = 0.6
        }
    },
    ['fishingstore'] = {
        ['stock_capacity'] = 50,
        ['max_employees'] = 5,
        ['required_job'] = {},
        ['upgrades'] = {
            ['stock'] = {
                ['price'] = 20000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40,
                    [5] = 50
                }
            },
            ['truck'] = {
                ['price'] = 25000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 10,
                    [2] = 20,
                    [3] = 40,
                    [4] = 70,
                    [5] = 90
                }
            },
            ['relationship'] = {
                ['price'] = 32000,
                ['level_reward'] = {
                    [0] = 0,
                    [1] = 3,
                    [2] = 5,
                    [3] = 8,
                    [4] = 10,
                    [5] = 15
                }
            }
        },
        ['trucks'] = {
            [0] = 'speedo',
            [1] = 'gburrito',
            [2] = 'mule2',
            [3] = 'mule3',
            [4] = 'pounder',
            [5] = 'pounder2'
        },
        ['max_purchasable_categories'] = 3,
        ['categories'] = {"drink_market", "food_market", "fishing_market"},
        ['default_categories'] = {
            "drink_market", "food_market", "fishing_market"
        },
        ['blips'] = {
            ['id'] = 52,
            ['name'] = "Fishing Shop",
            ['color'] = 4, -- Blip Color
            ['scale'] = 0.6 -- Blip Scale
        }
    }
}

Config.market_categories = {
    ['alcohol_market'] = {
        ['page_name'] = "Alcohol",
        ['page_desc'] = "Indulge in a sophisticated and diverse collection of alcoholic beverages, from premium spirits to fine wines and craft beers, all available at our supermarket to elevate your drinking experience",
        ['page_icon'] = '<img src="img/categories/alcohol-icon.png" style="padding:15px">', -- Its the icon that will appear in the page tab. "padding:12px" means that the image will be 15px smaller, use it to resize the image if needed. Tip: You can get nice images here: https://icon-icons.com/search/icons/
        -- ['page_icon'] = '<i class="fa-solid fa-burger"></i>', -- As an alternative to the page icon, you can use icons from here (https://fontawesome.com/search?m=free&s=solid)
        ['page_img'] = 'img/categories/alcohol.png', -- This is the category image in the page to buy categories
        ['category_buy_price'] = 15000, -- Price to buy the category
        ['category_sell_price'] = 7500, -- Price to sell the category
        ['items'] = {
            ['dusche_beer'] = {
                ['name'] = "Dusche Beer",
                ['price_to_customer'] = 38,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 38,
                ['price_to_owner'] = 37,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 120,
                ['img'] = 'dusche_beer.png',
                ['metadata'] = {}
            },
            ['stronzo_beer'] = {
                ['name'] = "Stronzo Beer",
                ['price_to_customer'] = 38,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 38,
                ['price_to_owner'] = 37,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 120,
                ['img'] = 'stronzo_beer.png',
                ['metadata'] = {}
            },
            ['patriot_beer'] = {
                ['name'] = "Patriot Beer",
                ['price_to_customer'] = 40,
                ['price_to_customer_min'] = 4,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 40,
                ['price_to_owner'] = 39,
                ['amount_to_owner'] = 55,
                ['amount_to_delivery'] = 110,
                ['img'] = 'patriot_beer.png',
                ['metadata'] = {}
            },
            ['wb_richards'] = {
                ['name'] = "WB Richards",
                ['price_to_customer'] = 45,
                ['price_to_customer_min'] = 5,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 45,
                ['price_to_owner'] = 44,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 100,
                ['img'] = 'wb_richards.png',
                ['metadata'] = {}
            },
            ['wb_mount'] = {
                ['name'] = "WB Mount",
                ['price_to_customer'] = 45,
                ['price_to_customer_min'] = 5,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 45,
                ['price_to_owner'] = 44,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 100,
                ['img'] = 'wb_mount.png',
                ['metadata'] = {}
            },
            ['vb_nogo'] = {
                ['name'] = "VB Nogo",
                ['price_to_customer'] = 48,
                ['price_to_customer_min'] = 6,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 48,
                ['price_to_owner'] = 47,
                ['amount_to_owner'] = 45,
                ['amount_to_delivery'] = 90,
                ['img'] = 'vb_nogo.png',
                ['metadata'] = {}
            },
            ['rb_ragga'] = {
                ['name'] = "RB Ragga",
                ['price_to_customer'] = 50,
                ['price_to_customer_min'] = 6,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 46,
                ['price_to_owner'] = 45,
                ['amount_to_owner'] = 45,
                ['amount_to_delivery'] = 90,
                ['img'] = 'rb_ragga.png',
                ['metadata'] = {}
            },
            ['cb_bleuterd'] = {
                ['name'] = "CB Bleuterd",
                ['price_to_customer'] = 55,
                ['price_to_customer_min'] = 7,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 54,
                ['price_to_owner'] = 53,
                ['amount_to_owner'] = 35,
                ['amount_to_delivery'] = 70,
                ['img'] = 'cb_bleuterd.png',
                ['metadata'] = {}
            },
            ['bb_cariaque'] = {
                ['name'] = "BB Cariaque",
                ['price_to_customer'] = 55,
                ['price_to_customer_min'] = 7,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 54,
                ['price_to_owner'] = 53,
                ['amount_to_owner'] = 35,
                ['amount_to_delivery'] = 70,
                ['img'] = 'bb_cariaque.png',
                ['metadata'] = {}
            },
            ['vodka'] = {
                ['name'] = "Vodka",
                ['price_to_customer'] = 57,
                ['price_to_customer_min'] = 12,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 56,
                ['price_to_owner'] = 55,
                ['amount_to_owner'] = 20,
                ['amount_to_delivery'] = 40,
                ['img'] = 'vodka.png',
                ['metadata'] = {}
            }
        }
    },

    ['drink_market'] = {
        ['page_name'] = "Drinks",
        ['page_desc'] = "Quench your thirst and elevate your beverage game with our diverse range of refreshing drinks, from classic favorites to innovative flavors, all waiting for you to discover at our supermarket",
        ['page_icon'] = '<img src="img/categories/drinks-icon.png" style="padding:15px">',
        ['page_img'] = 'img/categories/drinks.png',
        ['category_buy_price'] = 10000,
        ['category_sell_price'] = 7500,
        ['items'] = {
            ['ejunk'] = {
                ['name'] = "Ejunk",
                ['price_to_customer'] = 30,
                ['price_to_customer_min'] = 4,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 25,
                ['price_to_owner'] = 24,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 120,
                ['img'] = 'ejunk.png'
            },
            ['water'] = {
                ['name'] = "Bottle of Water",
                ['price_to_customer'] = 25,
                ['price_to_customer_min'] = 1,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 21,
                ['price_to_owner'] = 20,
                ['amount_to_owner'] = 100,
                ['amount_to_delivery'] = 150,
                ['img'] = 'water.png'
            },
            ['kurkakola'] = {
                ['name'] = "Cola",
                ['price_to_customer'] = 15,
                ['price_to_customer_min'] = 2,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 65,
                ['amount_to_delivery'] = 130,
                ['img'] = 'cola.png'
            }
        }
    },

    ['food_market'] = {
        ['page_name'] = "Food",
        ['page_desc'] = "Explore a delicious selection of fresh and high-quality food options that will tantalize your taste buds and satisfy your cravings, all conveniently available at our supermarket",
        ['page_icon'] = '<img src="img/categories/food-icon.png" style="padding:15px">',
        ['page_img'] = 'img/categories/food.png',
        ['category_buy_price'] = 15000,
        ['category_sell_price'] = 9500,
        ['items'] = {
            ['laserchobar'] = {
                ['name'] = "Laser Cho Bar",
                ['price_to_customer'] = 8,
                ['price_to_customer_min'] = 2,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 7,
                ['price_to_owner'] = 6,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'laserchobar.png'
            },
            ['meteoritechobar'] = {
                ['name'] = "Meteorite Cho Bar",
                ['price_to_customer'] = 9,
                ['price_to_customer_min'] = 2,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 8,
                ['price_to_owner'] = 7,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'meteoritechobar.png'
            },
            ['minipica'] = {
                ['name'] = "Mini Pizza",
                ['price_to_customer'] = 16,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'minipica.png'
            },
            ['vanillakarums'] = {
                ['name'] = "Vanilla Karums",
                ['price_to_customer'] = 12,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'vanillakarums.png'
            },
            ['sokoladeskarums'] = {
                ['name'] = "Chocolate Karums",
                ['price_to_customer'] = 12,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'sokoladeskarums.png'
            },
            ['karamelekarums'] = {
                ['name'] = "Caramel Karums",
                ['price_to_customer'] = 12,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'karamelekarums.png'
            },
            ['adazutomatu'] = {
                ['name'] = "Adazu Tomato Crisps",
                ['price_to_customer'] = 30,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'adazutomatu.png'
            },
            ['adazusiera'] = {
                ['name'] = "Adazu Cheese Crisps",
                ['price_to_customer'] = 30,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'adazusiera.png'
            },
            ['cielavina'] = {
                ['name'] = "Cielavina Cake",
                ['price_to_customer'] = 50,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 13,
                ['price_to_owner'] = 12,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'cielavina.png'
            },
            ['sandwich'] = {
                ['name'] = "Sandwich",
                ['price_to_customer'] = 20,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 17,
                ['price_to_owner'] = 16,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'sandwich.png'
            },
            ['tosti'] = {
                ['name'] = "Tosti",
                ['price_to_customer'] = 25,
                ['price_to_customer_min'] = 3,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 21,
                ['price_to_owner'] = 20,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'tosti.png'
            },
            ['milk'] = {
                ['name'] = "Milk",
                ['price_to_customer'] = 9,
                ['price_to_customer_min'] = 2,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 8,
                ['price_to_owner'] = 7,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 60,
                ['img'] = 'milk.png'
            },
            ['lemon'] = {
                ['name'] = "Fresh Lemon",
                ['price_to_customer'] = 3,
                ['price_to_customer_min'] = 2,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 3,
                ['price_to_owner'] = 2,
                ['amount_to_owner'] = 60,
                ['amount_to_delivery'] = 70,
                ['img'] = 'lemon.png'
            },
            ['ham'] = {
                ['name'] = "Cooked Ham",
                ['price_to_customer'] = 2,
                ['price_to_customer_min'] = 2,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 0,
                ['price_to_owner'] = 1,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 0,
                ['img'] = 'ham.png'
            },
            ['icecream'] = {
                ['name'] = "Vanilia Ice Cream",
                ['price_to_customer'] = 9,
                ['price_to_customer_min'] = 2,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 8,
                ['price_to_owner'] = 7,
                ['amount_to_owner'] = 3,
                ['amount_to_delivery'] = 3,
                ['img'] = 'vicecream.png'
            }
        }
    },

    ['electronics_market'] = {
        ['page_name'] = "Electronics",
        ['page_desc'] = "Experience the latest in technology with our wide range of cutting-edge electronics, from smartphones to home entertainment systems, available at our supermarket",
        ['page_icon'] = '<img src="img/categories/electronics-icon.png" style="padding:15px">',
        ['page_img'] = 'img/categories/electronics.png',
        ['category_buy_price'] = 50000,
        ['category_sell_price'] = 30000,
        ['items'] = {
            ['yphone_natural'] = {
                ['name'] = "Phone",
                ['price_to_customer'] = 700,
                ['price_to_customer_min'] = 100,
                ['price_to_customer_max'] = 1400,
                ['price_to_export'] = 680,
                ['price_to_owner'] = 679,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 7,
                ['img'] = 'phone.png'
            },
            ['radiocell'] = {
                ['name'] = "AAA Cell",
                ['price_to_customer'] = 20,
                ['price_to_customer_min'] = 20,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 17,
                ['price_to_owner'] = 16,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'radiocell.png'
            },
            ['usb_cable'] = {
                ['name'] = "USB Cable",
                ['price_to_customer'] = 75,
                ['price_to_customer_min'] = 75,
                ['price_to_customer_max'] = 120,
                ['price_to_export'] = 65,
                ['price_to_owner'] = 60,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'usb_cable.png'
            },
            ['radio'] = {
                ['name'] = "Radio",
                ['price_to_customer'] = 500,
                ['price_to_customer_min'] = 400,
                ['price_to_customer_max'] = 1000,
                ['price_to_export'] = 485,
                ['price_to_owner'] = 484,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'radio.png'
            },
            ['camera'] = {
                ['name'] = "Camera",
                ['price_to_customer'] = 50,
                ['price_to_customer_min'] = 50,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 41,
                ['price_to_owner'] = 40,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'camera.png'
            },
            ['carradio'] = {
                ['name'] = "Car Radio",
                ['price_to_customer'] = 3500,
                ['price_to_customer_min'] = 1200,
                ['price_to_customer_max'] = 7000,
                ['price_to_export'] = 3380,
                ['price_to_owner'] = 3379,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 5,
                ['img'] = 'carradio.png'
            },
            ['sim_card'] = {
                ['name'] = "Sim Card",
                ['price_to_customer'] = 70,
                ['price_to_customer_min'] = 70,
                ['price_to_customer_max'] = 140,
                ['price_to_export'] = 28,
                ['price_to_owner'] = 56,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'sim_card.png'
            },
            ['phone_module'] = {
                ['name'] = "Phone Module",
                ['price_to_customer'] = 300,
                ['price_to_customer_min'] = 300,
                ['price_to_customer_max'] = 600,
                ['price_to_export'] = 145,
                ['price_to_owner'] = 290,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'phone_module.png'
            },
            ['radio_module'] = {
                ['name'] = "Radio Module",
                ['price_to_customer'] = 125,
                ['price_to_customer_min'] = 125,
                ['price_to_customer_max'] = 250,
                ['price_to_export'] = 60,
                ['price_to_owner'] = 121,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'phone_module.png'
            }
        }
    },

    ['utilities_market'] = {
        ['page_name'] = "Utilities",
        ['page_desc'] = "Quality tools and equipment for any project, from hand tools to power tools, designed to help you achieve precision and efficiency, available at our supermarket",
        ['page_icon'] = '<img src="img/categories/utilities-icon.png" style="padding:15px">',
        ['page_img'] = 'img/categories/utilities.png',
        ['category_buy_price'] = 30000,
        ['category_sell_price'] = 1500,
        ['items'] = {
            ['rollingpaper'] = {
                ['name'] = "Rolling Paper",
             	['price_to_customer'] = 25,
            	['price_to_customer_min'] = 5,
            	['price_to_customer_max'] = 100,
            	['price_to_export'] = 16,
             	['price_to_owner'] = 15,
             	['amount_to_owner'] = 10,
             	['amount_to_delivery'] = 20,
             	['img'] = 'rollingpaper.png',
            },
            ['racing_gps'] = {
                ['name'] = "Racing GPS",
                ['price_to_customer'] = 600,
                ['price_to_customer_min'] = 500,
                ['price_to_customer_max'] = 2500,
                ['price_to_export'] = 1000,
                ['price_to_owner'] = 1200,
                ['amount_to_owner'] = 20,
                ['amount_to_delivery'] = 20,
                ['img'] = 'racing_gps.png'
            },
            ['notepad'] = {
                ['name'] = "Notepad",
                ['price_to_customer'] = 20,
                ['price_to_customer_min'] = 20,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 16,
                ['price_to_owner'] = 16,
                ['amount_to_owner'] = 20,
                ['amount_to_delivery'] = 20,
                ['img'] = 'notepad.png'
            },
            ['lighter'] = {
                ['name'] = "Lighter",
                ['price_to_customer'] = 25,
                ['price_to_customer_min'] = 25,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 20,
                ['price_to_owner'] = 20,
                ['amount_to_owner'] = 20,
                ['amount_to_delivery'] = 20,
                ['img'] = 'lighter.png'
            },
            ['drillbit'] = {
                ['name'] = "Drill Bit",
                ['price_to_customer'] = 100,
                ['price_to_customer_min'] = 75,
                ['price_to_customer_max'] = 200,
                ['price_to_export'] = 80,
                ['price_to_owner'] = 80,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'drillbit.png'
            },
            ['goldpan'] = {
                ['name'] = "Gold Pan",
                ['price_to_customer'] = 200,
                ['price_to_customer_min'] = 190,
                ['price_to_customer_max'] = 400,
                ['price_to_export'] = 194,
                ['price_to_owner'] = 194,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'goldpan.png'
            },
            ['binoculars'] = {
                ['name'] = "Binoculars",
                ['price_to_customer'] = 50,
                ['price_to_customer_min'] = 25,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 40,
                ['price_to_owner'] = 40,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'binoculars.png'
            },
            ['emptycoffee'] = {
                ['name'] = "Empty Plastic Cup",
                ['price_to_customer'] = 5,
                ['price_to_customer_min'] = 5,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 4,
                ['price_to_owner'] = 4,
                ['amount_to_owner'] = 2,
                ['amount_to_delivery'] = 2,
                ['img'] = 'coffee.png'
            },
            ['kq_winch'] = {
                ['name'] = "KQ Winch",
                ['price_to_customer'] = 500,
                ['price_to_customer_min'] = 500,
                ['price_to_customer_max'] = 1000,
                ['price_to_export'] = 485,
                ['price_to_owner'] = 485,
                ['amount_to_owner'] = 5,
                ['amount_to_delivery'] = 5,
                ['img'] = 'kq_winch.png'
            },
            ['flush_cutter'] = {
                ['name'] = "Flush Cutters",
                ['price_to_customer'] = 175,
                ['price_to_customer_min'] = 175,
                ['price_to_customer_max'] = 350,
                ['price_to_export'] = 169,
                ['price_to_owner'] = 169,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'flush_cutter.png'
            },
            ['bolt_cutter'] = {
                ['name'] = "Bolt Cutter",
                ['price_to_customer'] = 250,
                ['price_to_customer_min'] = 250,
                ['price_to_customer_max'] = 500,
                ['price_to_export'] = 242,
                ['price_to_owner'] = 242,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'bolt_cutter.png'
            },
            ['towhook'] = {
                ['name'] = "Tow Hook",
                ['price_to_customer'] = 400,
                ['price_to_customer_min'] = 400,
                ['price_to_customer_max'] = 800,
                ['price_to_export'] = 388,
                ['price_to_owner'] = 388,
                ['amount_to_owner'] = 5,
                ['amount_to_delivery'] = 5,
                ['img'] = 'towhook.png'
            },
            ['ingot_mold'] = {
                ['name'] = "Ingot Mold",
                ['price_to_customer'] = 125,
                ['price_to_customer_min'] = 85,
                ['price_to_customer_max'] = 250,
                ['price_to_export'] = 122,
                ['price_to_owner'] = 122,
                ['amount_to_owner'] = 10,
                ['amount_to_delivery'] = 10,
                ['img'] = 'ingot_mold.png'
            },
            --			['hunting_stove'] = {
            --				['name'] = "Hunting Stove",
            --				['price_to_customer'] = 600,
            --				['price_to_customer_min'] = 150,
            --				['price_to_customer_max'] = 1200,
            --				['price_to_export'] = 584,
            --				['price_to_owner'] = 584,
            --				['amount_to_owner'] = 50,
            --				['amount_to_delivery'] = 50,
            --				['img'] = 'hunting_stove.png',
            --			},
            ['weapon_wrench'] = {
                ['name'] = "Wrench",
                ['price_to_customer'] = 250,
                ['price_to_customer_min'] = 125,
                ['price_to_customer_max'] = 500,
                ['price_to_export'] = 242,
                ['price_to_owner'] = 242,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'weapon_wrench.png'
            },
            ['weapon_battleaxe'] = {
                ['name'] = "Axe",
                ['price_to_customer'] = 500,
                ['price_to_customer_min'] = 450,
                ['price_to_customer_max'] = 1000,
                ['price_to_export'] = 484,
                ['price_to_owner'] = 484,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_BATTLEAXE.png'
            },
            ['weapon_crowbar'] = {
                ['name'] = "Crowbar",
                ['price_to_customer'] = 200,
                ['price_to_customer_min'] = 125,
                ['price_to_customer_max'] = 400,
                ['price_to_export'] = 194,
                ['price_to_owner'] = 194,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'weapon_crowbar.png'
            },
            ['weapon_hammer'] = {
                ['name'] = "Hammer",
                ['price_to_customer'] = 125,
                ['price_to_customer_min'] = 120,
                ['price_to_customer_max'] = 250,
                ['price_to_export'] = 122,
                ['price_to_owner'] = 122,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'weapon_hammer.png'
            },
            ['weapon_fury_pickaxe_stone'] = {
                ['name'] = "Hand Made Pickaxe",
                ['price_to_customer'] = 200,
                ['price_to_customer_min'] = 190,
                ['price_to_customer_max'] = 400,
                ['price_to_export'] = 194,
                ['price_to_owner'] = 194,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'weapon_hammer.png'
            },
            ['shovel'] = {
                ['name'] = "Shovel",
                ['price_to_customer'] = 200,
                ['price_to_customer_min'] = 190,
                ['price_to_customer_max'] = 400,
                ['price_to_export'] = 194,
                ['price_to_owner'] = 194,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'shovel.png'
            },
            ['pitchfork'] = {
                ['name'] = "Pitch Fork",
                ['price_to_customer'] = 75,
                ['price_to_customer_min'] = 30,
                ['price_to_customer_max'] = 150,
                ['price_to_export'] = 60,
                ['price_to_owner'] = 60,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'pitchfork.png'
            },
            ['wateringcan'] = {
                ['name'] = "Watering Can",
                ['price_to_customer'] = 100,
                ['price_to_customer_min'] = 50,
                ['price_to_customer_max'] = 200,
                ['price_to_export'] = 80,
                ['price_to_owner'] = 80,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'wateringcan.png'
            },
            ['bait_shovel'] = {
                ['name'] = "Small Shovel",
                ['price_to_customer'] = 125,
                ['price_to_customer_min'] = 75,
                ['price_to_customer_max'] = 250,
                ['price_to_export'] = 122,
                ['price_to_owner'] = 122,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'bait_shovel.png'
            },
            ['nylonrope'] = {
                ['name'] = "Nylon Rope",
                ['price_to_customer'] = 100,
                ['price_to_customer_min'] = 75,
                ['price_to_customer_max'] = 200,
                ['price_to_export'] = 80,
                ['price_to_owner'] = 80,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'nylonrope.png'
            },
            ['scale'] = {
                ['name'] = "Scale",
                ['price_to_customer'] = 125,
                ['price_to_customer_min'] = 75,
                ['price_to_customer_max'] = 250,
                ['price_to_export'] = 122,
                ['price_to_owner'] = 122,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'scale.png'
            },
            ['WEAPON_SPATULA'] = {
                ['name'] = "Spatula",
                ['price_to_customer'] = 75,
                ['price_to_customer_min'] = 50,
                ['price_to_customer_max'] = 150,
                ['price_to_export'] = 60,
                ['price_to_owner'] = 60,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_SPATULA.png'
            },
            ['WEAPON_CAST_IRON'] = {
                ['name'] = "Iron Cast",
                ['price_to_customer'] = 150,
                ['price_to_customer_min'] = 75,
                ['price_to_customer_max'] = 300,
                ['price_to_export'] = 145,
                ['price_to_owner'] = 145,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_CAST_IRON.png'
            },
            ['WEAPON_ROLLING_PIN'] = {
                ['name'] = "Rolling Pin",
                ['price_to_customer'] = 50,
                ['price_to_customer_min'] = 35,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 40,
                ['price_to_owner'] = 40,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_ROLLING_PIN.png'
            },
            ['WEAPON_WOK'] = {
                ['name'] = "Wok",
                ['price_to_customer'] = 30,
                ['price_to_customer_min'] = 30,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 24,
                ['price_to_owner'] = 24,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_WOK.png'
            },
            ['WEAPON_LADLE'] = {
                ['name'] = "Ladle",
                ['price_to_customer'] = 30,
                ['price_to_customer_min'] = 30,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 24,
                ['price_to_owner'] = 24,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_LADLE.png'
            },
            ['WEAPON_PEPPERMILL'] = {
                ['name'] = "Pepper Mill",
                ['price_to_customer'] = 25,
                ['price_to_customer_min'] = 20,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 20,
                ['price_to_owner'] = 20,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_PEPPERMILL.png'
            },
            ['WEAPON_KETTLE'] = {
                ['name'] = "Kettle",
                ['price_to_customer'] = 125,
                ['price_to_customer_min'] = 75,
                ['price_to_customer_max'] = 250,
                ['price_to_export'] = 122,
                ['price_to_owner'] = 122,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'WEAPON_KETTLE.png'
            }
        }
    },

    ['backpack_shop'] = {
        ['page_name'] = "Backpacks",
        ['page_desc'] = "Explore our wide range of durable and stylish backpacks, designed for every adventure. From everyday use to outdoor expeditions, we offer the perfect bag to suit your needs.",
        ['page_icon'] = '<img src="img/categories/weapons-other-icon.png" style="padding:17px">',
        ['page_img'] = 'img/categories/weapons-other.png',
        ['category_buy_price'] = 70000,
        ['category_sell_price'] = 5000,
        ['items'] = {
            ['wallet'] = {
                ['name'] = "Wallet",
                ['price_to_customer'] = 50,
                ['price_to_customer_min'] = 40,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 40,
                ['price_to_owner'] = 40,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'wallet.png'
            },
            ['bag'] = {
                ['name'] = "Bag",
                ['price_to_customer'] = 35,
                ['price_to_customer_min'] = 1,
                ['price_to_customer_max'] = 100,
                ['price_to_export'] = 28,
                ['price_to_owner'] = 28,
                ['amount_to_owner'] = 35,
                ['amount_to_delivery'] = 35,
                ['img'] = 'bag.png'
            },
            ['backpack'] = {
                ['name'] = "Backpack",
                ['price_to_customer'] = 300,
                ['price_to_customer_min'] = 250,
                ['price_to_customer_max'] = 600,
                ['price_to_export'] = 290,
                ['price_to_owner'] = 290,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'backpack.png'
            },
            ['backpack3'] = {
                ['name'] = "Duffel Bag",
                ['price_to_customer'] = 1300,
                ['price_to_customer_min'] = 1000,
                ['price_to_customer_max'] = 2600,
                ['price_to_export'] = 1271,
                ['price_to_owner'] = 1271,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'backpack3.png'
            },
            ['kq_outfitbag'] = {
                ['name'] = "Outfit Bag",
                ['price_to_customer'] = 600,
                ['price_to_customer_min'] = 500,
                ['price_to_customer_max'] = 1200,
                ['price_to_export'] = 584,
                ['price_to_owner'] = 584,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['img'] = 'kq_outfitbag.png'
            }
        }
    },

    ['melee_weapons'] = {
        ['page_name'] = "Melee Weapons",
        ['page_desc'] = "Get up close and personal with our selection of high-quality melee weapons, including knives, swords, and clubs, perfect for any self-defense scenario",
        ['page_icon'] = '<img src="img/categories/weapons-melee-icon.png" style="padding:14px">',
        ['page_img'] = 'img/categories/weapons-melee.png',
        ['category_buy_price'] = 10000,
        ['category_sell_price'] = 5000,
        ['items'] = {
            ['weapon_knife'] = {
                ['name'] = "Knife",
                ['price_to_customer'] = 250,
                ['price_to_customer_min'] = 125,
                ['price_to_customer_max'] = 500,
                ['price_to_export'] = 242,
                ['price_to_owner'] = 242,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['is_weapon'] = false,
                ['requires_license'] = true,
                ['max_amount_to_purchase'] = 1,
                ['img'] = 'weapon_knife.png'
            },
            ['weapon_bat'] = {
                ['name'] = "Baseball Bat",
                ['price_to_customer'] = 3000,
                ['price_to_customer_min'] = 250,
                ['price_to_customer_max'] = 5000,
                ['price_to_export'] = 484,
                ['price_to_owner'] = 2000,
                ['amount_to_owner'] = 100,
                ['amount_to_delivery'] = 100,
                ['is_weapon'] = false,
                ['requires_license'] = false,
                ['max_amount_to_purchase'] = 1,
                ['img'] = 'weapon_bat.png'
            }
        }
    },

    ['pistol_weapons'] = {
        ['page_name'] = "Weapons",
        ['page_desc'] = "Experience the latest in technology with our wide range of cutting-edge electronics, from smartphones to home entertainment systems, available at our supermarket",
        ['page_icon'] = '<img src="img/categories/weapons-pistol-icon.png" style="padding:15px">',
        ['page_img'] = 'img/categories/weapons-pistol.png',
        ['category_buy_price'] = 50000,
        ['category_sell_price'] = 2500,
        ['items'] = {
            ['weapon_pistol'] = {
                ['name'] = "Pistol",
                ['price_to_customer'] = 65000,
                ['price_to_customer_min'] = 30000,
                ['price_to_customer_max'] = 100000,
                ['price_to_export'] = 25000,
                ['price_to_owner'] = 50000,
                ['amount_to_owner'] = 100,
                ['amount_to_delivery'] = 100,
                ['is_weapon'] = false,
                ['requires_license'] = true,
                ['max_amount_to_purchase'] = 1,
                ['img'] = 'weapon_pistol.png'
            },
            ['WEAPON_MUSKET'] = {
                ['name'] = "Musket",
                ['price_to_customer'] = 40000,
                ['price_to_customer_min'] = 30000,
                ['price_to_customer_max'] = 70000,
                ['price_to_export'] = 20000,
                ['price_to_owner'] = 30000,
                ['amount_to_owner'] = 100,
                ['amount_to_delivery'] = 1100,
                ['is_weapon'] = false,
                ['requires_license'] = true,
                ['max_amount_to_purchase'] = 1,
                ['img'] = 'WEAPON_MUSKET.png'
            }
        }
    },

    ['hunting_weapons'] = {
        ['page_name'] = "Hunting Weapons",
        ['page_desc'] = "Take down your prey with precision and power using our top-tier hunting weapons. Designed for accuracy, range, and reliability, these firearms ensure every shot counts in the great outdoors",
        ['page_icon'] = '<img src="img/categories/weapons-shotgun-icon.png" style="padding:15px">',
        ['page_img'] = 'img/categories/WEAPON_MUSKET.png',
        ['category_buy_price'] = 60000,
        ['category_sell_price'] = 30000,
        ['items'] = {
            ['WEAPON_MUSKET'] = {
                ['name'] = "Musket",
                ['price_to_customer'] = 30000,
                ['price_to_customer_min'] = 25000,
                ['price_to_customer_max'] = 40000,
                ['price_to_export'] = 20000,
                ['price_to_owner'] = 24000,
                ['amount_to_owner'] = 1,
                ['amount_to_delivery'] = 1,
                ['is_weapon'] = false,
                ['requires_license'] = true,
                ['max_amount_to_purchase'] = 1,
                ['img'] = 'WEAPON_MUSKET.png'
            }
        }
    },

    ['ammo_weapons'] = {
        ['page_name'] = "Ammo",
        ['page_desc'] = "Stay locked and loaded with our extensive range of high-quality ammunition, designed to deliver maximum power and accuracy to your weapon",
        ['page_icon'] = '<img src="img/categories/weapons-ammo-icon.png" style="padding:16px">',
        ['page_img'] = 'img/categories/weapons-ammo.png',
        ['category_buy_price'] = 35000,
        ['category_sell_price'] = 17500,
        ['items'] = {
            ['ammo-9'] = {
                ['name'] = "9mm Ammo",
                ['price_to_customer'] = 500,
                ['price_to_customer_min'] = 400,
                ['price_to_customer_max'] = 750,
                ['price_to_export'] = 150,
                ['price_to_owner'] = 350,
                ['amount_to_owner'] = 10000,
                ['amount_to_delivery'] = 10000,
                ['requires_license'] = true,
                ['img'] = 'ammo-9.png'
            },
            ['ammo-musket'] = {
                ['name'] = ".50 Ball Ammo",
                ['price_to_customer'] = 600,
                ['price_to_customer_min'] = 500,
                ['price_to_customer_max'] = 900,
                ['price_to_export'] = 250,
                ['price_to_owner'] = 450,
                ['amount_to_owner'] = 10000,
                ['amount_to_delivery'] = 10000,
                ['requires_license'] = true,
                ['img'] = 'ammo-musket.png'
            },
            ['ammo-22'] = {
                ['name'] = ".22 pistol Ammo",
                ['price_to_customer'] = 600,
                ['price_to_customer_min'] = 500,
                ['price_to_customer_max'] = 900,
                ['price_to_export'] = 250,
                ['price_to_owner'] = 450,
                ['amount_to_owner'] = 10000,
                ['amount_to_delivery'] = 10000,
                ['requires_license'] = true,
                ['img'] = 'ammo-22.png'
            }
        }
    },

    ['others_weapons'] = {
        ['page_name'] = "Miscellaneous",
        ['page_desc'] = "Be prepared for any outdoor adventure with our range of essential gear, including parachutes, flares, and other survival tools, available at our store",
        ['page_icon'] = '<img src="img/categories/weapons-other-icon.png" style="padding:17px">',
        ['page_img'] = 'img/categories/weapons-other.png',
        ['category_buy_price'] = 5000,
        ['category_sell_price'] = 2500,
        ['items'] = {
            ['parachute'] = {
                ['name'] = "Parachute",
                ['price_to_customer'] = 5500,
                ['price_to_customer_min'] = 4500,
                ['price_to_customer_max'] = 7500,
                ['price_to_export'] = 2000,
                ['price_to_owner'] = 4000,
                ['amount_to_owner'] = 5,
                ['amount_to_delivery'] = 5,
                ['img'] = 'parachute.png'
            },

            ['armor'] = {
                ['name'] = "Armor",
                ['price_to_customer'] = 11000,
                ['price_to_customer_min'] = 8500,
                ['price_to_customer_max'] = 15000,
                ['price_to_export'] = 4500,
                ['price_to_owner'] = 7500,
                ['amount_to_owner'] = 50,
                ['amount_to_delivery'] = 50,
                ['requires_license'] = false,
                ['max_amount_to_purchase'] = 2,
                ['img'] = 'armour.png'
            }
        }
    }
}

Config.roles_permissions = {
    ['functions'] = { -- These are the actions (when a button is clicked)
        ['createJob'] = 2,
        ['deleteJob'] = 2,
        ['renameMarket'] = 3,
        ['setPrice'] = 2,
        ['buyUpgrade'] = 2,
        ['hideBalance'] = 2,
        ['showBalance'] = 2,
        ['withdrawMoney'] = 3,
        ['depositMoney'] = 3,
        ['sellMarket'] = 4,
        ['storeProductFromInventory'] = 1,
        ['hirePlayer'] = 3,
        ['firePlayer'] = 3,
        ['changeRole'] = 3,
        ['giveComission'] = 3,
        ['startImportJob'] = 1,
        ['startExportJob'] = 1,
        ['buyCategory'] = 3,
        ['sellCategory'] = 3
    },
    ['ui_pages'] = { -- These are the UI pages
        ['main'] = 1,
        ['goods'] = 1,
        ['hire'] = 2,
        ['employee'] = 3,
        ['upgrades'] = 2,
        ['bank'] = 3
    }
}
-- Setting to remove inactive stores
Config.clear_stores = {
    ['active'] = true, -- Set to false to disable this function
    ['min_stock_amount'] = 30, -- Minimum percentage of stock to consider an inactive store. Stores that have been inactive for a long time will be removed
    ['min_stock_variety'] = 70, -- Minimum percentage of variety of products in stock to consider an inactive store. Stores that have been inactive for a long time will be removed
    ['cooldown'] = 168 -- Time (in hours) that the store needs to be below the minimum amount of stock to be removed
}

Config.route_blip =
    { -- The blip style that will appear when doing the store jobs
        ['id'] = 478, -- Blip id
        ['color'] = 5 -- Blip color
    }

-- Cargo delivery locations (vector3)
Config.delivery_locations = {
    {1233.37, -3230.95, 5.66},
    {768.57, -3203.36, 5.90},
    {254.06, -3058.38, 5.78},
    {-266.91, -2470.57, 6.00},
    {-512.66, -2199.22, 6.39},
    {-1274.58, -1359.91, 4.30},
    {-1409.42, -459.42, 34.48},
    {-443.08, 141.61, 64.66},
    {503.66, -609.55, 24.75},
    {204.09, -1854.81, 27.20},
    {2702.04, 3453.67, 55.71},
    {2900.61, 4396.14, 50.27},
    {2441.47, 5011.84, 46.60},
    {407.49, 6492.81, 28.12},
    {-342.09, 6243.64, 31.49},
    {-1041.57, 5332.64, 44.31},
    {-1921.15, 2047.37, 140.74},
    {-83.40, 1880.14, 197.28},
    {587.69, 2790.58, 42.18},
    {-2957.92, 59.33, 11.61}
}

-- Product export locations (vector3)
Config.export_locations = {
    {-758.14, 5540.96, 33.49}, {-3046.19, 143.27, 11.6},
    {-1153.01, 2672.99, 18.1}, {622.67, 110.27, 92.59},
    {-574.62, -1147.27, 22.18}, {376.31, 2638.97, 44.5},
    {1738.32, 3283.89, 41.13}, {1419.98, 3618.63, 34.91},
    {1452.67, 6552.02, 14.89}, {3472.4, 3681.97, 33.79},
    {2485.73, 4116.13, 38.07}, {65.02, 6345.89, 31.22},
    {-303.28, 6118.17, 31.5}, {-184.33, -2150.69, 16.70},
    {147.13, -2258.20, 6.10}, {-746.6, -1496.67, 5.01},
    {369.54, 272.07, 103.11}, {907.61, -44.12, 78.77},
    {-1517.31, -428.29, 35.45}, {235.04, -1520.18, 29.15},
    {34.8, -1730.13, 29.31}, {350.4, -2466.9, 6.4}, {1213.97, -1229.01, 35.35},
    {1395.7, -2061.38, 52.0}, {729.09, -2023.63, 29.31},
    {840.72, -1952.59, 28.85}, {551.76, -1840.26, 25.34},
    {723.78, -1372.08, 26.29}, {-339.92, -1284.25, 31.32},
    {1137.23, -1285.05, 34.6}, {466.93, -1231.55, 29.95},
    {442.28, -584.28, 28.5}, {1560.52, 888.69, 77.46},
    {2561.78, 426.67, 108.46}, {569.21, 2730.83, 42.07},
    {2665.4, 1700.63, 24.49}, {1120.1, 2652.5, 38.0}, {2004.23, 3071.87, 47.06},
    {2038.78, 3175.7, 45.09}, {1635.54, 3562.84, 35.23},
    {2744.55, 3412.43, 56.57}, {1972.17, 3839.16, 32.0},
    {1979.92, 3780.41, 32.18}, {1716.0, 4706.41, 42.69},
    {1691.36, 4918.42, 42.08}, {1971.07, 5165.12, 47.64},
    {1908.78, 4932.06, 48.97}, {110.46, -1172.28, 29.30},
    {-323.98, -1522.86, 27.55}, {-1060.53, -221.7, 37.84},
    {2471.47, 4463.07, 35.3}, {2699.47, 3444.81, 55.8},
    {2655.38, 3281.01, 55.24}, {2730.39, 2778.2, 36.01},
    {-2966.68, 363.37, 14.77}, {2788.89, 2816.49, 41.72},
    {-604.45, -1212.24, 14.95}, {2534.83, 2589.08, 37.95},
    {-143.31, 205.88, 92.12}, {2347.04, 2633.25, 46.67},
    {860.47, -896.87, 25.53}, {973.34, -1038.19, 40.84},
    {-43.56, -1079.20, 26.66}, {-409.04, 1200.44, 325.65},
    {-1781.04, 3126.32, 32.82}, {1246.34, 1860.78, 79.47},
    {-1827.5, 2934.11, 32.82}, {-2123.69, 3270.14, 32.82},
    {-2277.86, 3176.57, 32.81}, {-2969.0, 366.46, 14.77},
    {-1637.61, -814.53, 10.17}, {-1494.72, -891.67, 10.11},
    {-902.27, -1528.42, 5.03}, {-1173.93, -1749.87, 3.97},
    {-1087.8, -2047.55, 13.23}, {-1133.74, -2035.99, 13.21},
    {-1234.4, -2092.3, 13.93}, {-1025.97, -2223.62, 8.99},
    {850.42, 2197.69, 51.93}, {42.61, 2803.45, 57.88},
    {-1193.54, -2155.4, 13.2}, {2041.76, 3172.26, 44.98},
    {-465.48, -2169.09, 10.01}, {-3150.77, 1086.55, 20.7},
    {-433.69, -2277.29, 7.61}, {-395.18, -2182.97, 10.29},
    {-3029.7, 591.68, 7.79}, {-61.32, -1832.75, 26.8},
    {822.72, -2134.28, 29.29}, {942.22, -2487.76, 28.34},
    {729.29, -2086.53, 29.3}, {783.08, -2523.98, 20.51},
    {717.8, -2111.18, 29.22}, {787.05, -1612.38, 31.17},
    {913.52, -1556.87, 30.74}, {846.71, -2496.12, 28.34},
    {711.79, -1395.19, 26.35}, {723.38, -1286.3, 26.3},
    {983.0, -1230.77, 25.38}, {818.01, -2422.85, 23.6},
    {885.53, -1166.38, 24.99}, {700.85, -1106.93, 22.47},
    {882.26, -2384.1, 28.0}, {977.83, -1821.21, 31.17},
    {-1138.73, -759.77, 18.87}, {938.71, -1154.36, 25.38},
    {973.0, -1156.18, 25.43}, {689.41, -963.48, 23.49}, ---
    {140.72, -375.29, 43.26}, {-497.09, -62.13, 39.96},
    {-606.34, 187.43, 70.01}, {117.12, -356.15, 42.59},
    {53.91, -1571.07, 29.47}, {1528.1, 1719.32, 109.97},
    {1411.29, 1060.33, 114.34}, {1145.76, -287.73, 68.96},
    {1117.71, -488.25, 65.25}, {874.28, -949.16, 26.29},
    {829.28, -874.08, 25.26}, {725.37, -874.53, 24.67},
    {977.51, -1013.67, 41.32}, {847.06, -1397.72, 26.14},
    {830.67, -1409.13, 26.16}, {130.47, -1066.12, 29.2},
    {-131.74, -1097.38, 21.69}, {-668.65, -1182.07, 10.62},
    {-1327.81, -1027.63, 7.71}, {-1314.65, -1254.96, 4.58},
    {-1169.18, -1768.78, 3.87}, {-1343.38, -744.02, 22.28},
    {-1532.84, -578.16, 33.63}, {-1461.4, -362.39, 43.89},
    {-1457.25, -384.15, 38.51}, {-1544.42, -411.45, 41.99},
    {-1040.24, -499.88, 36.07}, {346.43, -1107.19, 29.41},
    {523.99, -2112.7, 5.99}, {977.19, -2539.34, 28.31},
    {1591.9, -1714.0, 88.16}, {2492.55, -320.89, 93.0},
    {2846.31, 1463.1, 24.56}, {3631.05, 3768.61, 28.52},
    {3572.5, 3665.53, 33.9}, {2919.03, 4337.85, 50.31},
    {2521.47, 4203.47, 39.95}, {2926.2, 4627.28, 48.55},
    {3808.59, 4463.22, 4.37}, {2133.06, 4789.57, 40.98},
    {1900.83, 4913.82, 48.87}, {381.06, 3591.37, 33.3},
    {277.33, 2884.71, 43.61}, {225.63, 1244.33, 225.46},
    {-1136.15, 4925.14, 220.01}, {-519.96, 5243.84, 79.95},
    {-299.24, 6300.27, 31.5}, {402.52, 6619.61, 28.26},
    {-247.72, 6205.46, 31.49}, {-267.5, 6043.45, 31.78},
    {-16.29, 6452.44, 31.4}, {137.29, 281.73, 109.98}, {588.37, 127.87, 98.05},
    {199.8, 2788.78, 45.66}, {708.58, -295.1, 59.19}, {581.28, 2799.43, 42.1},
    {955.85, -22.89, 78.77}
}

-- Config for npcs that will stand in the stores
Config.NPCs = {
    {
        ['model'] = 'mp_m_shopkeep_01', -- Ped model (https://docs.fivem.net/docs/game-references/ped-models/)
        ['emote'] = 'WORLD_HUMAN_STAND_MOBILE', -- Ped emote (https://wiki.rage.mp/index.php?title=Scenarios)
        ['pos'] = { -- Ped locations (vector4)
            {24.47, -1346.62, 29.5, 271.66}, {-3039.54, 584.38, 7.91, 17.27},
            {-3242.97, 1000.01, 12.83, 357.57},
            {1959.82, 3740.48, 32.34, 301.57}, {549.13, 2670.85, 42.16, 99.39},
            {2677.47, 3279.76, 55.24, 335.08},
            {2556.66, 380.84, 108.62, 356.67}, {372.66, 326.98, 103.57, 253.73},
            {-47.02, -1758.23, 29.42, 45.05}, {-706.06, -913.97, 19.22, 88.04},
            {-1820.02, 794.03, 138.09, 135.45},
            {1164.71, -322.94, 69.21, 101.72},
            {1697.87, 4922.96, 42.06, 324.71},
            {-1221.58, -908.15, 12.33, 35.49},
            {-1486.59, -377.68, 40.16, 139.51},
            {-2966.39, 391.42, 15.04, 87.48}, {1165.17, 2710.88, 38.16, 179.43},
            {1134.2, -982.91, 46.42, 277.24},
            {-1592.8110, 5197.5029, 4.3590, 23.7826}
        }
    }, {
        ['model'] = 's_m_y_ammucity_01',
        ['emote'] = 'WORLD_HUMAN_COP_IDLES',
        ['pos'] = {{23.0, -1105.67, 29.8, 162.91}}
    }
}

Config.create_table = false
