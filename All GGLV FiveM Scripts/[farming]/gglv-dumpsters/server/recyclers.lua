local insertedItems = {} -- Table to store inserted items per player
local activeRecycling = {} -- Table to store recycling state per player
local readyToCollect = {} -- Table to track if recycling is complete

--- Retrieves a unique key for the recycler, depending on whether it is shared or personal
--- @param source number The player's source ID
--- @param locId number The identifier for the recycling location
--- @return string|number The key used to track the recycler status
local GetRecyclerKey = function(source, locId)
    local src = source
    if Config.Recycling.Shared then
        return locId
    else
        return SD.GetIdentifier(src)
    end
end

-- Callback to retrieve what items the player can recycle.
SD.Callback.Register('gglv-dumpsters:server:checkRecyclingItems', function(source)
    local results = {}
    for i = 1, #Config.Recycling.Items do
        local itemData = Config.Recycling.Items[i]
        local itemName = itemData.name

        local count = SD.Inventory.HasItem(source, itemName)
        if type(count) == "table" then
            count = count.amount or count[1] or 0
        end
        count = tonumber(count) or 0

        results[#results + 1] = {
            name        = itemName,
            count       = count,
            disabled    = (count <= 0),
            recycleInto = itemData.recycleInto
        }
    end
    return results
end)

--- Callback to retrieve what items the player can recycle
--- @param source number The player's source ID
--- @return table A list of recyclable items and their quantities
SD.Callback.Register('gglv-dumpsters:server:insertItem', function(source, data)
    local key = GetRecyclerKey(source, data.locationId)
    if not key then return false end

    local itemName = data.name
    local quantity = tonumber(data.amount) or 1

    if not insertedItems[key] then
        insertedItems[key] = {}
    end

    local playerHas = SD.Inventory.HasItem(source, itemName)
    if type(playerHas) == "table" then
        playerHas = playerHas.amount or playerHas[1] or 0
    end
    playerHas = tonumber(playerHas) or 0

    if playerHas < quantity then
        return false
    end

    SD.Inventory.RemoveItem(source, itemName, quantity)
    insertedItems[key][itemName] = (insertedItems[key][itemName] or 0) + quantity
    return true
end)

--- Retrieve all inserted items from the recycler for UI display (shared or personal)
SD.Callback.Register('gglv-dumpsters:server:getInsertedItems', function(source, data)
    local key = GetRecyclerKey(source, data.locationId)
    if not key then return {} end
    return insertedItems[key] or {}
end)

--- Retrieve all inserted items from the recycler for UI display (shared or personal)
--- @param source number The player's source ID
--- @param data table Contains locationId (number) to determine recycler ownership
--- @return table A list of inserted items in the recycler
SD.Callback.Register('gglv-dumpsters:server:removeInsertedItem', function(source, data)
    local key = GetRecyclerKey(source, data.locationId)
    if not key then return false end

    if not insertedItems[key] then return false end

    local itemName = data.name
    local quantity = tonumber(data.amount) or 1

    if not insertedItems[key][itemName] then
        return false
    end

    local storedAmount = insertedItems[key][itemName]
    if storedAmount < quantity then
        return false
    end

    insertedItems[key][itemName] = storedAmount - quantity
    if insertedItems[key][itemName] <= 0 then
        insertedItems[key][itemName] = nil
    end

    SD.Inventory.AddItem(source, itemName, quantity)
    return true
end)

--- Check if recycling is active, how much time remains, or if it's ready to collect
--- @param source number The player's source ID
--- @param data table Contains locationId (number) to determine recycler ownership
--- @return table Recycling status with activity state, time left, total time, and readiness
SD.Callback.Register('gglv-dumpsters:server:getRecyclingStatus', function(source, data)
    local key = GetRecyclerKey(source, data.locationId)
    if not key then 
        return { isActive = false, timeLeft = 0, totalTime = 0, isReady = false }
    end

    local status = { isActive = false, timeLeft = 0, totalTime = 0, isReady = false }

    if activeRecycling[key] then
        local endMs    = activeRecycling[key].endTime
        local total    = activeRecycling[key].totalTime
        local currentMs= GetGameTimer()
        local diff     = endMs - currentMs

        if diff > 0 then
            status.isActive  = true
            status.timeLeft  = math.ceil(diff / 1000)
            status.totalTime = math.ceil(total / 1000)
        else
            activeRecycling[key] = nil
            readyToCollect[key] = true
            TriggerClientEvent('gglv-dumpsters:client:recyclingReady', source, data.locationId)
        end
    elseif readyToCollect[key] then
        status.isReady = true
    end

    return status
end)

--- Starts the recycling process for a given recycler
--- @param data table Contains locationId (number) to determine recycler ownership
RegisterNetEvent('gglv-dumpsters:server:startRecyclingProcess', function(data)
    local src  = source
    local key  = GetRecyclerKey(src, data.locationId)
    if not key then return end

    if not insertedItems[key] then return end

    local hasItems     = false
    local totalQuantity= 0

    for _, quantity in pairs(insertedItems[key]) do
        if quantity > 0 then
            hasItems     = true
            totalQuantity= totalQuantity + quantity
        end
    end

    if not hasItems then return end

    local useBaseTime  = Config.Recycling.ProcessingTime.useBaseTime
    local baseTime     = Config.Recycling.ProcessingTime.baseTime * 1000
    local perItemTime  = Config.Recycling.ProcessingTime.perItemTime * 1000

    local totalTime = useBaseTime and baseTime or (totalQuantity * perItemTime)

    activeRecycling[key] = {
        src      = src,
        endTime  = GetGameTimer() + totalTime,
        totalTime= totalTime
    }

    Wait(totalTime)

    readyToCollect[key] = true
    activeRecycling[key] = nil
end)

--- Callback to collect the final recycled items from the recycler when the process is complete
--- @param source number The player's source ID
--- @param data table Contains locationId (number) to determine recycler ownership
--- @return boolean Returns true if items were successfully collected, otherwise false
SD.Callback.Register('gglv-dumpsters:server:collectRecycledItems', function(source, data)
    local src = source
    local key = GetRecyclerKey(source, data.locationId)
    if not key or not readyToCollect[key] then return false end

    local recycledItems = {}

    if not insertedItems[key] then return false end

    for itemName, quantity in pairs(insertedItems[key]) do
        for _, recycleOutput in ipairs(Config.Recycling.Items) do
            if recycleOutput.name == itemName then
                for i = 1, quantity do
                    for _, product in ipairs(recycleOutput.recycleInto) do
                        local amount = math.random(product.min, product.max)
                        table.insert(recycledItems, { name = product.name, amount = amount })
                    end
                end
                break
            end
        end
    end

    insertedItems[key]   = nil
    readyToCollect[key]  = nil
    activeRecycling[key] = nil

    for _, itemData in ipairs(recycledItems) do
        SD.Inventory.AddItem(src, itemData.name, itemData.amount)
    end

    return true
end)
