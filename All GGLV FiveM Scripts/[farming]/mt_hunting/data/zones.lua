---@class zones
---@field legal table<string, { coords: vector3, radius: number }>
---@field ilegal table<string, { coords: vector3, radius: number }>

-- This is the GTA MAP zones where the animals will spawn.
-- Zone names based on: https://docs.fivem.net/natives/?_0x98CD1D2934B76CC1
-- The coords and radius are not 100% accurate, they are just a rough estimate.
return {
    legal = {
        ['CMSW']     = { coords = vec3(-2086.0, 2617.5, 2.0), radius = 350 },
        ['MTGORDO']  = { coords = vec3(3149.0, 4465.0, 42.0), radius = 400 },
        ['MTJOSE']   = { coords = vec3(2736.0, 5977.0, 72.0), radius = 350 },
        ['PALFOR']   = { coords = vec3(-685.0, 5830.0, 17.0), radius = 400 },
        ['SANCHIA']  = { coords = vec3(2675.0, 1492.0, 31.0), radius = 300 },
        ['CCREAK']   = { coords = vec3(-936.0, 4449.0, 15.0), radius = 350 },
        ['GREATC']   = { coords = vec3(-1000.0, 4400.0, 25.0), radius = 350 },
        ['SLAB']     = { coords = vec3(1100.0, 2650.0, 38.0), radius = 300 },
        ['TATAMO']   = { coords = vec3(-1084.0, 3585.0, 34.0), radius = 500 },
        ['WINDF']    = { coords = vec3(2246.0, 3859.0, 41.0), radius = 250 },
        ['TONGVAH']  = { coords = vec3(-1165.0, 4700.0, 220.0), radius = 300 },
        ['CHIL']     = { coords = vec3(-100.0, 4350.0, 85.0), radius = 350 },
        ['RGLEN']    = { coords = vec3(-1550.0, 4400.0, 20.0), radius = 300 },
        ['GALFISH']  = { coords = vec3(1325.0, 4300.0, 36.0), radius = 300 },
    },

    ilegal = {
        ['PALHIGH']  = { coords = vec3(-170.0, 6144.0, 42.0), radius = 400 },
        ['MTCHIL']   = { coords = vec3(450.0, 5615.0, 796.0), radius = 600 },
        ['GRAPES']   = { coords = vec3(2125.0, 4980.0, 41.0), radius = 350 },
        ['LACT']     = { coords = vec3(1690.0, 6400.0, 31.0), radius = 300 },
        ['NCHU']     = { coords = vec3(-2020.0, 1975.0, 140.0), radius = 300 },
        ['PROCOB']   = { coords = vec3(220.0, 3300.0, 41.0), radius = 300 },
        ['ZQ_UAR']   = { coords = vec3(3500.0, 3750.0, 38.0), radius = 350 }
    }
}
