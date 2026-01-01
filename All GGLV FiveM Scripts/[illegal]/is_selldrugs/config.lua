cfg = {}

cfg.permission = "admin"

cfg.Police = {
    job = {"police"},
    checkDuty = true,
    required = {
        retail = 2,
        wholesale = 0
    }
}

cfg.trapPhone = {
    price = 5000,
    itemName = "trap_phone"
}

cfg.commands = {
    status = "selldrugs", -- "example" or nil
    checkStats = "sd-stats",
    addRespect = "sd-addrep",
    removeRespect = "sd-removerep",
    addSkill = "sd-addskill",
    removeSkill = "sd-removeskill",
    addMole = "sd-addmole",
    removeMole = "sd-removemole",
}

cfg.Webhook = {
    adminCommands = "https://discordapp.com/api/webhooks/1350517965535051850/meolhorM3fcMSSskRNfSSgDX1CIcvbXUUG8UodNKFr7m-naFp-xPsXUo0_L6FXkp0-Yi",
    mole = "https://discordapp.com/api/webhooks/1350518043977060444/07el_7wDrKvpjc7YJYYojJFt7vkyyuqT8C3By87pfwAgQOcjkq3Zvnm0bOOY8HUTaFXm",
    retail = "https://discordapp.com/api/webhooks/1350518078710218772/0emUJzuTkh4ls_pyTD_muanF_cXDY8DAsl8EhRSiExk7qvzVkndX3CD0ne38KQQKtUaD",
    wholesale = "https://discordapp.com/api/webhooks/1350518116429332621/KLEefEOOXSAQ_rx5nEYwubPHz48cfn0-vCzXezTjJcEySUDQ2Sw0FAJbh7bLTB9mPk_X",
}

cfg.Drugs = {
    ["joint"] = { label = "Joint", price = { retail = 75, wholesale = 37 }, maxPriceMultiplier = { retail = 1.5, wholesale = 1.5 } },
    ["fullbag"] = { label = "Bag of Weed", price = { retail = 120, wholesale = 100 }, maxPriceMultiplier = { retail = 1.5, wholesale = 1.5 } },
    ["weedbrick"] = { label = "Weed Brick", price = { retail = 20000, wholesale = 15000 }, maxPriceMultiplier = { retail = 1.0, wholesale = 1.0 } },
    ["kq_meth_low"] = { label = "Meth (Low grade)", price = { retail = 550, wholesale = 125 }, maxPriceMultiplier = { retail = 1.5, wholesale = 1.5 } },
    ["kq_meth_mid"] = { label = "Meth (Medium grade)", price = { retail = 850, wholesale = 255 }, maxPriceMultiplier = { retail = 1.5, wholesale = 1.5 } },
    ["kq_meth_high"] = { label = "Meth (High grade)", price = { retail = 1500, wholesale = 750 }, maxPriceMultiplier = { retail = 1.5, wholesale = 1.5 } },
    ["oxy"] = { label = "Oxy", price = { retail = 150, wholesale = 75 }, maxPriceMultiplier = { retail = 1.5, wholesale = 1.5 } },
    ["cocainebaggy"] = { label = "Cocaine Baggy", price = { retail = 300, wholesale = 225 }, maxPriceMultiplier = { retail = 1.5, wholesale = 1.5 } },
    ["coke"] = { label = "Cocaine Brick", price = { retail = 40000, wholesale = 30000 }, maxPriceMultiplier = { retail = 1.0, wholesale = 1.0 } },
}

cfg.moneyType = "markedbills" -- "cash", "bank", "itemName"
cfg.moneyTypeItem = true -- true if "cash", "itemName" etc. is Item

cfg.respectLimit = 10000
cfg.skillLimit = 250

cfg.Retail = {
    SuccessfulSale = function(src, item, count, price)
        -- place your function here (Server Side)
    end,
    clientCooldown = 300000, -- in ms
    policeAlertChance = 25,
    policeAlertOnSale = true,
    interestInDrugs = 60,
    maxQuantity = 3,
    increase = {
        respect = 1,
        skill = 1
    },
    decrease = {
        respect = 1,
        skill = 1
    }
}

cfg.Wholesale = {
    SuccessfulSale = function(src, item, count, price)
        -- place your function here (Server Side)
    end,
    minimumRespect = 500,
    minQuantity = 50,
    maxQuantity = 300,
    maxActiveOffers = 10,
    pedsArmorChance = 75,
    offerCurrentPlayerDrugs = false,
    pedsRobberyMoney = {min = 2500, max = 10000}, -- We get the default value of money from the agreed order (the negotiated price of the drug * quantity of the drug + a random value from this setting)
    pedsWeapons = {GetHashKey("weapon_microsmg"), GetHashKey("weapon_pumpshotgun_mk2"), GetHashKey("weapon_vintagepistol"), GetHashKey("weapon_knife")},
    playerAllowedWeapons = {GetHashKey("weapon_unarmed")},
    increase = {
        respect = 25,
        skill = 5,
    },
    decrease = {
        notAttendMeeting = {
            respect = 50,
            skill = 25,
        },
        leaveZone = {
            respect = 50,
            skill = 25,
        },
        dontHaveDrug = {
            respect = 100,
            skill = 50,
        },
        attackBuyer = {
            respect = 500,
            skill = 100,
        },
        failedNegotiation = {
            respect = 25,
            skill = 5,
        }
    },
    receiveMessage = {
        unit = "s", -- "s" - seconds or "m" - minutes or "h" - hours or "d" - days or "w" - weeks
        count = 10,
    },
    waitingForPlayer = {
        unit = "m", -- "s" - seconds or "m" - minutes or "h" - hours or "d" - days or "w" - weeks
        count = 30,
    },
    places = {
        {
            veh_coords = vector4(-1273.71, -810.19, 17.05, 306.62),
            vehicle = "sultan", -- must be 4door
            peds = {
                {offset = {x = 0.0, y = -4.0, z = 0.0}, model = "G_M_Y_SalvaGoon_03", buyer = true},
                {offset = {x = 2.5, y = -4.0, z = 0.0}, model = "G_M_M_CartelGuards_01"},
                {offset = {x = -2.5, y = -4.0, z = 0.0}, model = "G_M_M_CartelGuards_02"},
            }
        },
        {
            veh_coords = vector4(-810.38, -753.36, 22.09, 268.91),
            vehicle = "cavalcade",
            peds = {
                {offset = {x = 0.0, y = -4.0, z = 0.0}, model = "G_M_Y_SalvaBoss_01", buyer = true},
                {offset = {x = 2.5, y = -4.0, z = 0.0}, model = "G_M_Y_FamDNF_01"},
                {offset = {x = -2.5, y = -4.0, z = 0.0}, model = "G_F_Y_Families_01"},
            }
        },
        {
            veh_coords = vector4(-1539.91, -583.33, 33.34, 215.11),
            vehicle = "washington",
            peds = {
                {offset = {x = 0.0, y = -4.0, z = 0.0}, model = "a_m_m_malibu_01", buyer = true},
                {offset = {x = 2.5, y = -4.0, z = 0.0}, model = "a_m_m_hillbilly_02"},
                {offset = {x = -2.5, y = -4.0, z = 0.0}, model = "a_m_m_rurmeth_01"},
            }
        },
        {
            veh_coords = vector4(-1449.62, -380.37, 37.79, 290.71),
            vehicle = "stratum",
            peds = {
                {offset = {x = 0.0, y = -4.0, z = 0.0}, model = "a_m_m_golfer_01", buyer = true},
                {offset = {x = 2.5, y = -4.0, z = 0.0}, model = "a_m_m_eastsa_01"},
                {offset = {x = -2.5, y = -4.0, z = 0.0}, model = "a_m_m_eastsa_02"},
            }
        },
        {
            veh_coords = vector4(-320.82, -55.23, 53.95, 339.76),
            vehicle = "primo",
            peds = {
                {offset = {x = 0.0, y = -4.0, z = 0.0}, model = "a_m_y_beachvesp_02", buyer = true},
                {offset = {x = 2.5, y = -4.0, z = 0.0}, model = "a_m_y_cyclist_01"},
                {offset = {x = -2.5, y = -4.0, z = 0.0}, model = "a_m_y_eastsa_01"},
            }
        },
    }
}

cfg.Mole = {
    Peds = {
        junkie = {
            ["Joe"] = {model = "a_m_m_trampbeac_01", coords = vector4(-717.09, -905.32, 20.0, 63.43), price = 2500},
            ["Casey"] = {model = "a_m_y_hippy_01", coords = vector4(-364.35, -350.95, 31.56, 251.99), price = 2500},
            ["Jamie"] = {model = "a_m_y_methhead_01", coords = vector4(-1451.17, -579.44, 31.25, 213.6), price = 2500},
            ["Blake"] = {model = "a_m_o_genstreet_01", coords = vector4(-965.53, -1172.45, 2.15, 293.15), price = 2500},
            ["Drew"] = {model = "a_m_o_tramp_01", coords = vector4(776.65, -1194.67, 24.29, 72.89), price = 2500},
        },
        criminal = {
            ["Louis"] = {model = "a_m_m_soucent_04", coords = vector4(1141.28, -1657.09, 36.41, 34.49), price = 5000},
            ["Charlie"] = {model = "G_M_Y_PoloGoon_02", coords = vector4(152.34, -72.67, 71.86, 340.98), price = 5000},
            ["Noah"] = {model = "G_M_Y_PoloGoon_01", coords = vector4(-1590.74, -412.46, 43.06, 45.73), price = 5000},
            ["Morgan"] = {model = "G_M_M_CartelGoons_01", coords = vector4(-982.47, -270.98, 38.29, 223.28), price = 5000},
            ["Taylor"] = {model = "G_M_M_MaraGrande_01", coords = vector4(-280.89, 193.68, 85.56, 350.64), price = 5000},
        },
        professional = {
            ["Blackie"] = {model = "a_m_m_og_boss_01", coords = vector4(-26.96, -1531.43, 30.52, 314.79), price = 15000},
            ["Debony"] = {model = "G_M_Y_StrPunk_02", coords = vector4(332.55, -1990.2, 30.64, 42.54), price = 15000},
            ["Jordan"] = {model = "a_m_m_tourist_01", coords = vector4(-2005.01, -356.68, 26.1, 140.32), price = 15000},
            ["Riley"] = {model = "a_m_m_soucent_01", coords = vector4(-534.31, -2216.95, 6.39, 227.89), price = 15000},
            ["Alex"] = {model = "a_m_m_salton_02", coords = vector4(948.43, -2102.17, 30.67, 209.5), price = 15000},
        }
    },
    Blips = {
        junkie = {
            normal = {
                sprite = 280,
                scale = 1.0,
                color = 1,
                alpha = 255,
                shortRange = false,
                name = "Junkie:"
            },
            radius = {
                color = 1,
                alpha = 55,
                shortRange = false,
            }
        },
        criminal = {
            normal = {
                sprite = 280,
                scale = 1.0,
                color = 26,
                alpha = 255,
                shortRange = false,
                name = "Criminal:"
            },
            radius = {
                color = 26,
                alpha = 55,
                shortRange = false,
            }
        },
        professional = {
            normal = {
                sprite = 280,
                scale = 1.0,
                color = 2,
                alpha = 255,
                shortRange = false,
                name = "Professional:"
            },
            radius = {
                color = 2,
                alpha = 55,
                shortRange = false,
            }
        },
        police = {
            sprite = 137,
            scale = 1.0,
            color = 0,
            alpha = 255,
            shortRange = false,
            name = "Last Seen Officer",
            removeAfter = 10000
        }
    },
    Range = {
        junkie = 75.0,
        criminal = 125.0,
        professional = 200.0,
    },
    Respect = {
        junkie = 0,
        criminal = 1500,
        professional = 6000,
    },
    Subscription = {
        unit = "d", -- "s" - seconds or "m" - minutes or "h" - hours or "d" - days or "w" - weeks
        count = 3,
    }
}

cfg.Animations = {
    dialog = {
        ["male"] = {
            {dict = "anim@heists@heist_corona@team_idles@male_a", anim = "idle"},
            {dict = "anim@mp_corona_idles@male_c@idle_a", anim = "idle_a"},
            {dict = "anim@mp_corona_idles@male_d@idle_a", anim = "idle_a"},
        },
        ["female"] = {
            {dict = "anim@mp_corona_idles@female_b@idle_a", anim = "idle_a"},
            {dict = "mp_move@prostitute@m@french", anim = "idle"},
            {dict = "anim@heists@heist_corona@team_idles@female_a", anim = "idle"},
        },
    },
    trade = {
        {dict = "mp_common", anim = "givetake1_a", duration = 2000, swap = 1000},
        {dict = "mp_ped_interaction", anim = "handshake_guy_a", duration = 3000, swap = 1500}
    },
    steal = {
        {dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", duration = 2000},
    },
    putInTrunk = {
        {dict = "anim@heists@narcotics@trash", anim = "throw_b", duration = 1000}
    }
}

function dispatch(player, callingPed)
    exports['qs-dispatch']:DrugSale()
    -- place your function here
end

function clientNotify(message, duration, style)
    bridge.notification.show({
        title = false,
        message = message,
        duration = duration,
        style = style,
    })
end

function serverNotify(source, message, duration, style)
    bridge.notification.show(source, {
        title = false,
        message = message,
        duration = duration,
        style = style,
    })
end