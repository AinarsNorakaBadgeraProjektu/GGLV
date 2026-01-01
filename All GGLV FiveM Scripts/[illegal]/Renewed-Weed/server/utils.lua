local utils = {}
local Config = require 'shared.Config'

local random = math.random
local waterDurability = 100 / Config.maxWaterDurability
local maxWeight = Config.maxWeight * 1000
local stagePercent = 100 / (#Config.objectOffsets - 1)

---Returns the players Character ID
---@param src number
---@return string
function utils.getCharId(src)
    return Renewed.getCharId(src)
end

---Returns the new water level of the plant after an interval
---@param currentWater number
---@return number
function utils.minusWater(currentWater)
    local minusWater = random(Config.thirstInterval.min, Config.thirstInterval.max)

    local water = currentWater - minusWater

    return water < 0 and 0 or water
end

---Returns the new fertilizer level of the plant after an interval
---@param currentFertilizer number
---@return number
function utils.minusFertilizer(currentFertilizer)
    local minusFertilizer = random(Config.hungerInterval.min, Config.hungerInterval.max)

    local fertilizer = currentFertilizer - minusFertilizer

    return fertilizer < 0 and 0 or fertilizer
end

---Returns the new health level of the plant after an interval
---@param currentHealth number
---@return number
function utils.minusHealth(currentHealth)
    local minusHealth = random(Config.healthInterval.min, Config.healthInterval.max)

    local health = currentHealth - minusHealth

    return health < 0 and 0 or health
end

---Returns the water and durability of the watering can after watering a plant
---@param durability number
---@param currentWater number
---@return number, number
function utils.getNewWater(durability, currentWater)
    local durabilityWater = durability * waterDurability
    local waterNeeded = 100 - currentWater

    if durabilityWater > waterNeeded then
        durabilityWater -= waterNeeded
        return 100, math.ceil(durabilityWater / waterDurability)
    end

    return currentWater + durabilityWater, 0
end

---Returns the weight of the watering can based on the durability
---@param durability number
---@return number
function utils.waterCanWeight(durability)
    return (Config.canWeight * 1000) * (durability / 100)
end

-- Rounds a number to a certain amount of decimals
---@param number number
---@param decimals number
---@return number
function utils.round(number, decimals)
    local exp = decimals and 10^decimals or 1
    return math.ceil(number * exp - 0.5) / exp
end

---Returns the weight of the plant based on the health
---@param health number
---@return number
function utils.healthToWeight(health)
    return math.ceil((health / 100) * maxWeight)
end

function utils.healthToSeeds(health)
    local healthPercent = health / 100

    return math.ceil(healthPercent * Config.maxFemale), math.ceil(healthPercent * Config.maxMale)
end

---Returns the growth and stage of the plant based on the time passed
---@param currentTime number
---@param oldTime number
---@return number, number
function utils.growthTime(currentTime, oldTime)
    local timePassed = (currentTime - oldTime) / 60 -- Sees the time passed in minutes

    local growth = (timePassed / Config.GrowthTime) * 100

    growth = growth < 0 and 0 or growth > 100 and 100 or growth

    local stage = math.floor((growth / stagePercent) + 1.5)

    return utils.round(growth, 2), stage
end

---Notifies the player with a message
---@param source number
---@param notiType string
---@param message string
function utils.notify(source, notiType, message)
    TriggerClientEvent('ox_lib:notify', source, { type = notiType, description = message })
end


return utils