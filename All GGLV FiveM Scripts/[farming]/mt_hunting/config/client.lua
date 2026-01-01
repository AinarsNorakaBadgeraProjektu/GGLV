---@class clientConfig
---@field aimblock boolean blocks hunting weapon's aiming at players
---@field shops table shops locations
---@field stove table stove config
return {
    aimblock = true, -- blocks hunting weapon's aiming at players

    shops = { -- Shops locations
        {
            coords = vec4(-679.07, 5834.46, 16.33, 132.2),
            model = 'cs_hunter',
            anim = {
                scenario = 'WORLD_HUMAN_CLIPBOARD'
            },
        },
    },

    stove = {
        model = 'prop_hobo_stove_01'
    }
}