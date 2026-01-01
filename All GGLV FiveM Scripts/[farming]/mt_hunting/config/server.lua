---@class serverConfig
---@field stove table stove settings
---@field tournaments table tournaments settings
return {
    stove = {
        slots = 5,
        weight = 100 * 1000,
        cookTime = 30, -- cook time in seconds
    },

    tournaments = {
        prize = { -- tournaments money prizes
            min = 1500,
            max = 5000
        },
        duration = 5 -- duration in days
    }
}
