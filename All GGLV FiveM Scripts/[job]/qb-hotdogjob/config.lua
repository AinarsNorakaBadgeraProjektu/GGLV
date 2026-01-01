Config = Config or {}
Config.UseTarget = true
-- Config --

Config.StandDeposit = 5

Config.MyLevel = 1
Config.MaxReputation = 200

Config.Locations = {
    ["take"] = {
        coords = vector4(39.31, -1005.54, 29.48, 240.57),
    },
    ["spawn"] = {
        coords = vector4(38.15, -1001.65, 29.44, 342.5),
    },
}

Config.Stock = {
    ["exotic"] = {
        Current = 0,
        Max = {
            [1] = 15,
            [2] = 30,
            [3] = 45,
            [4] = 60,
        },
        Label = Lang:t("info.label_a"),
        Price = {
            [1] = {
                min = 10,
                max = 14,
            },
            [2] = {
                min = 11,
                max = 15,
            },
            [3] = {
                min = 12,
                max = 16,
            },
            [4] = {
                min = 13,
                max = 17,
            },
        }
    },
    ["rare"] = {
        Current = 0,
        Max = {
            [1] = 15,
            [2] = 30,
            [3] = 45,
            [4] = 60,
        },
        Label = Lang:t("info.label_b"),
        Price = {
            [1] = {
                min = 8,
                max = 11,
            },
            [2] = {
                min = 9,
                max = 12,
            },
            [3] = {
                min = 10,
                max = 13,
            },
            [4] = {
                min = 11,
                max = 14,
            },
        }
    },
    ["common"] = {
        Current = 0,
        Max = {
            [1] = 15,
            [2] = 30,
            [3] = 45,
            [4] = 60,
        },
        Label = Lang:t('info.label_c'),
        Price = {
            [1] = {
                min = 6,
                max = 8,
            },
            [2] = {
                min = 7,
                max = 9,
            },
            [3] = {
                min = 8,
                max = 11,
            },
            [4] = {
                min = 11,
                max = 14,
            },
        }
    },
}
