local locale = SD.Locale.T -- Variable to abbreviate the locale function/translation
local adviceGiven = {} -- Table to track if advice has already been given per player
local NeedlePrickCooldowns = {} -- Table to store if the player has already been pricked by a needle
local HoboAttackCooldowns = {} -- Table to store if the player has already been attacked by a hobo
local dumpsterZones = {} -- Dumpster Zones
local lastLockAttempt = false -- Tracks if a lock attempt was recently made
local lootedEmptyBags = {} -- Table to track empty bags that have been looted
local dumpsterSearchAttempts = {} -- Table to track dumpster search attempts

-- Populate the dumpsterZones table with zones using lib.zones.poly
if Config.Zones.Enable then
    for _, zoneData in ipairs(Config.Zones) do
        local zone = lib.zones.poly({
            points = zoneData.points,
            thickness = zoneData.thickness or 10,
            debug = zoneData.debug,
            name = zoneData.name,
        })
        table.insert(dumpsterZones, zone)
    end
end

-- Function to get the leaderboard
--- Retrieves the top 5 players globally.
--- @param cb function The callback receiving the leaderboard data
local GetLeaderboard = function(cb)
    SD.Callback('gglv-dumpsters:server:getLeaderboard', false, function(data)
        local leaderboard = data or {}
        cb(leaderboard)
    end)
end

-- Helper function to get a specific player's score
local GetPlayerScore = function(cb)
    SD.Callback('gglv-dumpsters:server:getPlayerScore', false, function(score)
        cb(score or 0)
    end)
end

-- Function to get player level and XP
--- Retrieves the player's current level and XP.
--- @param cb function The callback receiving (level, xp)
local GetPlayerInfo = function(cb)
    SD.Callback('gglv-dumpsters:server:getPlayerInfo', false, function(data)
        local level = (data and data.level) or 1
        local xp = (data and data.xp) or 0
        cb(level, xp)
    end)
end

-- Function to get player stats
--- Retrieves the player's stats from the server.
--- @param cb function Callback function that receives the stats table as argument
local GetPlayerStats = function(cb)
    SD.Callback('gglv-dumpsters:server:getPlayerStats', false, function(stats)
        if stats then
            cb(stats)
        else
            cb({})
        end
    end)
end

-- Function to get player milestones
--- Retrieves the player's stats and milestones from the server.
--- @param cb function Callback function that receives a table with stats and milestones
local GetPlayerMilestones = function(cb)
    SD.Callback('gglv-dumpsters:server:getPlayerMilestones', false, function(data)
        if data then
            cb(data)
        else
            cb({ stats = {}, milestones = {} })
        end
    end)
end

-- Function to open a confirmation dialog for buying or selling
--- Displays a confirmation dialog before completing a transaction.
--- @param actionType string 'buy' or 'sell'
--- @param product string The item name (internal identifier)
--- @param productLabel string The item label (display name)
--- @param quantity number The quantity of items
--- @param totalCost number The total cost or earnings of the transaction
--- @param serverEvent string The server event to trigger
local OpenConfirmationDialog = function(actionType, product, productLabel, quantity, totalCost, serverEvent)
    local dialogTitle = locale('hobo.transaction_confirmation_title')
    
    local baseMessageKey = actionType == 'buy' and 'hobo.confirm_purchase' or 'hobo.confirm_sale'
    local baseMessage = locale(baseMessageKey)
    
    local formattedTotalCost
    if Config.Payout == 'caps' then
        formattedTotalCost = totalCost .. ' ' .. locale('hobo.caps')
    else
        formattedTotalCost = '$' .. totalCost
    end

    local confirmMessage = baseMessage:gsub("{quantity}", quantity)
    confirmMessage = confirmMessage:gsub("{product}", productLabel)
    confirmMessage = confirmMessage:gsub("{totalCost}", formattedTotalCost)
    local icon = (actionType == 'buy' and 'fas fa-shopping-cart' or 'fas fa-hand-holding-usd')
    
    lib.registerContext({
        id = 'hobo_confirmation_dialog',
        title = dialogTitle,
        options = {
            {
                title = (actionType == 'buy' and locale('hobo.confirm_purchase_button') or locale('hobo.confirm_sale_button')),
                description = confirmMessage,
                icon = icon,
                onSelect = function()
                    TriggerServerEvent(serverEvent, product, quantity)
                    lib.hideContext()
                end
            },
            {
                title = locale('hobo.cancel_transaction'),
                icon = 'fas fa-times',
                onSelect = function()
                    lib.hideContext()
                end
            }
        }
    })
    
    lib.showContext('hobo_confirmation_dialog')
end

-- Function to open the Buy menu
--- @param playerLevel number The player's current level
local OpenBuyMenu = function(playerLevel)
    local shopItems = Config.Shop.Buy

    local options = {}
    for itemName, itemData in pairs(shopItems) do
        local itemMetadata = Config.ItemsMetadata[itemName] or { label = itemName, icon = 'fas fa-box' }
        local formattedPrice = Config.Payout == 'caps' and (itemData.price .. ' ' .. locale('hobo.caps')) or ('$' .. itemData.price)
        
        local levelRequirement = itemData.level or 0
        local isRestricted = playerLevel < levelRequirement
        local restrictionText = isRestricted and locale('hobo.item_level_restriction', { level = levelRequirement }) or ""

        options[#options + 1] = {
            title = itemMetadata.label,
            description = locale('hobo.shop_item_description', { price = formattedPrice }) .. (restrictionText ~= "" and ("\n" .. restrictionText) or ""),
            icon = itemMetadata.icon,
            disabled = isRestricted,
            onSelect = function()
                if isRestricted then return end
                local input = lib.inputDialog(locale('hobo.purchase_prompt', { item = itemMetadata.label }), {
                    { type = 'number', label = locale('hobo.quantity_label'), required = true, min = 1 }
                })
                if not input or not input[1] then return end
                local quantity = tonumber(input[1])
                if quantity and quantity > 0 then
                    local totalCost = itemData.price * quantity
                    OpenConfirmationDialog('buy', itemName, itemMetadata.label, quantity, totalCost, 'sd-dumpster:server:buyItem')
                end
            end
        }
    end

    options[#options + 1] = {
        title = locale('hobo.return_to_main_menu'),
        icon = 'fas fa-arrow-left',
        onSelect = function()
            TriggerEvent('sd-dumpster:client:openPed')
        end
    }

    lib.registerContext({
        id = 'hobo_king_buy_menu',
        title = locale('hobo.buy_menu_title'),
        options = options,
        onExit = function() end
    })

    lib.showContext('hobo_king_buy_menu')
end

-- Function to open the Sell menu
local OpenSellMenu = function()
    local sellItems = Config.Shop.Sell

    local options = {}
    for itemName, itemData in pairs(sellItems) do
        local itemMetadata = Config.ItemsMetadata[itemName] or { label = itemName, icon = 'fas fa-box' }
        local formattedPrice = Config.Payout == 'caps' and (itemData.price .. ' ' .. locale('hobo.caps')) or ('$' .. itemData.price)

        options[#options + 1] = {
            title = itemMetadata.label,
            description = locale('hobo.sell_item_description', { price = formattedPrice }),
            icon = itemMetadata.icon,
            onSelect = function()
                local input = lib.inputDialog(locale('hobo.sell_prompt', { item = itemMetadata.label }), {
                    { type = 'number', label = locale('hobo.quantity_label'), required = true, min = 1 }
                })
                if not input or not input[1] then return end
                local quantity = tonumber(input[1])
                if quantity and quantity > 0 then
                    local totalEarnings = itemData.price * quantity
                    OpenConfirmationDialog('sell', itemName, itemMetadata.label, quantity, totalEarnings, 'sd-dumpster:server:sellItem')
                end
            end
        }
    end

    options[#options + 1] = {
        title = locale('hobo.return_to_main_menu'),
        icon = 'fas fa-arrow-left',
        onSelect = function()
            TriggerEvent('sd-dumpster:client:openPed')
        end
    }

    lib.registerContext({
        id = 'hobo_king_sell_menu',
        title = locale('hobo.sell_menu_title'),
        options = options,
        onExit = function()
            PedMenu()
        end
    })

    lib.showContext('hobo_king_sell_menu')
end

-- Function to open the shop menu to choose between Buy or Sell
--- Presents the player with options to Buy or Sell items.
--- @param playerLevel number The player's current level
local OpenShopMenu = function(playerLevel)
    local options = {}
    
    options[#options + 1] = {
        title = locale('hobo.shop_buy'),
        description = locale('hobo.shop_buy_description'),
        icon = 'fas fa-shopping-bag',
        onSelect = function()
            OpenBuyMenu(playerLevel)
        end
    }
    
    options[#options + 1] = {
        title = locale('hobo.shop_sell'),
        description = locale('hobo.shop_sell_description'),
        icon = 'fas fa-hand-holding-usd',
        onSelect = function()
            OpenSellMenu()
        end
    }

    options[#options + 1] = {
        title = locale('hobo.return_to_main_menu'),
        icon = 'fas fa-arrow-left',
        onSelect = function()
            TriggerEvent('sd-dumpster:client:openPed')
        end
    }
    
    lib.registerContext({
        id = 'hobo_king_shop_menu',
        title = locale('hobo.shop_menu_title'),
        options = options,
        onExit = function()
            PedMenu()
        end
    })
    
    lib.showContext('hobo_king_shop_menu')
end

--- @param entity number The entity for which to generate a unique ID.
--- @return string|nil A unique identifier based on the entity's network ID, or nil if not found.
local RetrieveNetID = function(entity)
    local netId = nil
    if NetworkGetEntityIsNetworked(entity) then
        netId = NetworkGetNetworkIdFromEntity(entity)
    end
    if not netId then
        local coords = GetEntityCoords(entity)
        local model = GetEntityModel(entity)
        local closestEntity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.1, model, true, true, true)
        if closestEntity ~= 0 then
            netId = NetworkGetNetworkIdFromEntity(closestEntity)
        end
    end
    return netId and tostring(netId) or nil
end

-- Function to give Hobo King advice
--- Displays progressively aggressive advice messages to the player until the hobo tells them to leave.
local GiveHoboAdvice = function()
    local playerId = GetPlayerServerId(PlayerId())

    if not adviceGiven[playerId] then
        adviceGiven[playerId] = { stage = 0, advices = {} }
    end

    local playerData = adviceGiven[playerId]

    local helpfulAdvices = {
        locale('hobo.advice_quote_1'),
        locale('hobo.advice_quote_2'),
        locale('hobo.advice_quote_3'),
        locale('hobo.advice_quote_4'),
        locale('hobo.advice_quote_5')
    }

    local responses = {
        { message = nil, type = 'error' },
        { message = nil, type = 'error' },
        { message = locale('hobo.advice_warn'), type = 'error' },
        { message = locale('hobo.advice_final_warn'), type = 'error' },
        { message = locale('hobo.advice_piss_off'), type = 'error' }
    }

    if #playerData.advices == 0 then
        math.randomseed(GetGameTimer())
        local firstIndex = math.random(1, #helpfulAdvices)
        table.insert(playerData.advices, table.remove(helpfulAdvices, firstIndex))

        local secondIndex = math.random(1, #helpfulAdvices)
        table.insert(playerData.advices, table.remove(helpfulAdvices, secondIndex))
    end

    responses[1].message = playerData.advices[1]
    responses[2].message = playerData.advices[2]

    playerData.stage = playerData.stage + 1
    local adviceStage = playerData.stage

    if adviceStage > #responses then
        return
    end

    local response = responses[adviceStage]
    SD.ShowNotification(response.message, response.type)
end

--- Function to open the stats menu
--- Retrieves the player's stats, then shows them in a new menu.
local OpenStatsMenu = function()
    GetPlayerStats(function(stats)
        GetPlayerMilestones(function(response)
            local milestonesData = response.milestones or {}

            local statsOptions = {}

            if stats.dumpstersSearched then
                statsOptions[#statsOptions + 1] = {
                    title = locale('hobo.dumpsters_searched_title'),
                    description = locale('hobo.dumpsters_searched_desc', { value = tostring(stats.dumpstersSearched) }),
                    readOnly = true,
                    icon = 'fas fa-dumpster'
                }
                stats.dumpstersSearched = nil
            end

            if stats.hoboLooted then
                statsOptions[#statsOptions + 1] = {
                    title = locale('hobo.hobos_looted_title'),
                    description = locale('hobo.hobos_looted_desc', { value = tostring(stats.hoboLooted) }),
                    readOnly = true,
                    icon = 'fas fa-user-ninja'
                }
                stats.hoboLooted = nil
            end

            if stats.campSearched then
                statsOptions[#statsOptions + 1] = {
                    title = locale('hobo.camps_searched_title'),
                    description = locale('hobo.camps_searched_desc', { value = tostring(stats.campSearched) }),
                    readOnly = true,
                    icon = 'fas fa-campground'
                }
                stats.campSearched = nil
            end

            if stats.bagsLooted then
                statsOptions[#statsOptions + 1] = {
                    title = locale('hobo.bags_looted_title'),
                    description = locale('hobo.bags_looted_desc', { value = tostring(stats.bagsLooted) }),
                    readOnly = true,
                    icon = 'fas fa-trash-alt'
                }
                stats.bagsLooted = nil
            end

            for statName, statValue in pairs(stats) do
                local itemMetadata = Config.ItemsMetadata[statName] or { label = statName, icon = 'fas fa-clipboard-list' }

                statsOptions[#statsOptions + 1] = {
                    title = itemMetadata.label,
                    description = locale('hobo.stat_value', { value = tostring(statValue), item = itemMetadata.label }),
                    readOnly = true,
                    icon = itemMetadata.icon
                }
            end

            local redeemedCount = 0
            for milestoneName, milestoneStages in pairs(milestonesData) do
                for stageIndex, isRedeemed in ipairs(milestoneStages) do
                    if isRedeemed then
                        redeemedCount = redeemedCount + 1
                    end
                end
            end
            
            if redeemedCount > 0 then
                statsOptions[#statsOptions + 1] = {
                    title = locale('hobo.milestones_redeemed_title'),
                    description = locale('hobo.milestones_redeemed_desc', { count = redeemedCount }),
                    readOnly = true,
                    icon = 'fas fa-trophy'
                }
            end

            if #statsOptions == 0 then
                statsOptions[#statsOptions + 1] = {
                    title = locale('hobo.no_stats_title'),
                    description = locale('hobo.no_stats_desc'),
                    disabled = true,
                    icon = 'fas fa-exclamation-circle'
                }
            end

            statsOptions[#statsOptions + 1] = {
                title = locale('hobo.return_to_main_menu'),
                description = '',
                icon = 'fas fa-arrow-left',
                onSelect = function()
                    PedMenu()
                end
            }

            lib.registerContext({
                id = 'hobo_king_stats_menu',
                title = locale('hobo.stats_menu_title'),
                options = statsOptions,
                onExit = function()
                    PedMenu()
                end
            })

            lib.showContext('hobo_king_stats_menu')
        end)
    end)
end

--- Creates a milestone entry for the milestones menu.
--- @param milestoneName string The key name of the milestone.
--- @param milestoneData table The milestone data containing required amount and rewards.
--- @param current number The player's current progress for this milestone.
--- @param required number The required progress to complete the milestone.
--- @param nextProgression number The progression level of the milestone.
--- @return table The formatted milestone entry.
local CreateMilestoneEntry = function(milestoneName, milestoneData, current, required, nextProgression)
    local progressPercent = math.min(math.floor((current / required) * 100 + 0.5), 100)

    local rewardDesc = locale('hobo.generic_reward')
    if milestoneData.Reward then
        if milestoneData.Reward.Type == "item" then
            rewardDesc = tostring(milestoneData.Reward.Amount) .. " " .. (Config.ItemsMetadata[milestoneData.Reward.Name].label or milestoneData.Reward.Name)
        elseif milestoneData.Reward.Type == "xp" then
            rewardDesc = tostring(milestoneData.Reward.Amount) .. " XP"
        elseif milestoneData.Reward.Type == "money" then
            rewardDesc = "$" .. tostring(milestoneData.Reward.Amount)
        end
    end

    local overallName = (Config.Milestones[milestoneName] and Config.Milestones[milestoneName].Name) or milestoneName
    local title = locale('hobo.milestone_title', { item = overallName, level = nextProgression })
    
    local itemLabel = Config.ItemsMetadata[milestoneName] and Config.ItemsMetadata[milestoneName].label or overallName
    local description = locale('hobo.milestone_desc', { required = required, item = itemLabel, reward = rewardDesc, current = current })
    
    local canRedeem = current >= required

    return {
        title = title,
        description = description,
        readOnly = not canRedeem,
        icon = Config.ItemsMetadata[milestoneName] and Config.ItemsMetadata[milestoneName].icon or 'fas fa-check',
        progress = progressPercent,
        colorScheme = 'green',
        onSelect = canRedeem and function()
            TriggerServerEvent('sd-dumpster:server:redeemMilestone', milestoneName, nextProgression)
        end or nil
    }
end

--- Handles special milestones with unique titles and descriptions.
--- @param stats table The player's current stats.
--- @param milestonesData table The player's redeemed milestones.
--- @param milestonesOptions table The milestones options list to populate.
local HandleSpecialMilestones = function(stats, milestonesData, milestonesOptions)
    local specialMilestones = {
        { name = 'dumpstersSearched', icon = 'fas fa-dumpster', titleKey = 'hobo.dumpsters_searched_title_m', descKey = 'hobo.dumpsters_searched_desc_m' },
        { name = 'hoboLooted', icon = 'fas fa-user-ninja', titleKey = 'hobo.hobo_looted_title', descKey = 'hobo.hobo_looted_desc' },
        { name = 'campSearched', icon = 'fas fa-campground', titleKey = 'hobo.camp_searched_title', descKey = 'hobo.camp_searched_desc' },
        { name = 'bagsLooted', icon = 'fas fa-trash-alt', titleKey = 'hobo.bags_looted_title_m', descKey = 'hobo.bags_looted_desc_m' }
    }

    for _, milestone in ipairs(specialMilestones) do
        local milestoneName = milestone.name
        local milestoneConfig = Config.Milestones[milestoneName]
        if milestoneConfig then
            local nextProgression = nil
            local milestoneData = nil
            for progression, progData in ipairs(milestoneConfig) do
                local redeemed = milestonesData[milestoneName] and milestonesData[milestoneName][progression]
                if not redeemed then
                    nextProgression = progression
                    milestoneData = progData
                    break
                end
            end

            if nextProgression and milestoneData then
                local current = stats[milestoneName] or 0
                local required = milestoneData.RequiredAmount
                local progressPercent = math.min(math.floor((current / required) * 100 + 0.5), 100)

                local rewardDesc = locale('hobo.generic_reward')
                if milestoneData.Reward then
                    if milestoneData.Reward.Type == "item" then
                        rewardDesc = tostring(milestoneData.Reward.Amount) .. " " ..
                        (Config.ItemsMetadata[milestoneData.Reward.Name].label or milestoneData.Reward.Name)
                    elseif milestoneData.Reward.Type == "xp" then
                        rewardDesc = tostring(milestoneData.Reward.Amount) .. " XP"
                    elseif milestoneData.Reward.Type == "money" then
                        rewardDesc = "$" .. tostring(milestoneData.Reward.Amount)
                    end
                end

                local overallName = (Config.Milestones[milestoneName] and Config.Milestones[milestoneName].Name) or milestoneName
                local title = locale(milestone.titleKey, { level = nextProgression, item = overallName })
                local description = locale(milestone.descKey, {
                    current = current,
                    required = required,
                    reward = rewardDesc,
                    item = overallName
                })
                local canRedeem = current >= required

                local entry = {
                    title = title,
                    description = description,
                    readOnly = not canRedeem,
                    icon = milestone.icon,
                    progress = progressPercent,
                    colorScheme = 'teal'
                }

                if canRedeem then
                    entry.onSelect = function()
                        TriggerServerEvent('sd-dumpster:server:redeemMilestone', milestoneName, nextProgression)
                    end
                end

                milestonesOptions[#milestonesOptions + 1] = entry
            end
        end
    end
end

--- Opens the milestones menu.
--- @return nil
local OpenMilestonesMenu = function()
    GetPlayerMilestones(function(data)
        local milestonesOptions = {}
        local playerMilestones = data.milestones or {}
        local playerStats = data.stats or {}

        HandleSpecialMilestones(playerStats, playerMilestones, milestonesOptions)

        for milestoneName, progressions in pairs(Config.Milestones) do
            if type(progressions) == "table" 
            and milestoneName ~= 'dumpstersSearched' 
            and milestoneName ~= 'hoboLooted' 
            and milestoneName ~= 'campSearched'
            and milestoneName ~= 'bagsLooted' then
        
                local nextProgression = nil
                local milestoneData = nil
                for progression, progData in ipairs(progressions) do
                    local redeemed = playerMilestones[milestoneName] and playerMilestones[milestoneName][progression]
                    if not redeemed then
                        nextProgression = progression
                        milestoneData = progData
                        break
                    end
                end
        
                if nextProgression and milestoneData then
                    local key = milestoneName  
                    local current = playerStats[milestoneName] or 0
                    local required = milestoneData.RequiredAmount
        
                    milestonesOptions[#milestonesOptions + 1] = CreateMilestoneEntry(key, milestoneData, current, required, nextProgression)
                end
            end
        end

        if #milestonesOptions == 0 then
            milestonesOptions[#milestonesOptions + 1] = {
                title = locale('hobo.no_milestones_title'),
                description = locale('hobo.no_milestones_desc'),
                readOnly = true,
                icon = 'fas fa-exclamation-circle'
            }
        end

        milestonesOptions[#milestonesOptions + 1] = {
            title = locale('hobo.return_to_main_menu'),
            description = '',
            icon = 'fas fa-arrow-left',
            onSelect = function()
                PedMenu()
            end
        }

        lib.registerContext({
            id = 'hobo_king_milestones_menu',
            title = locale('hobo.milestones_menu_title'),
            options = milestonesOptions,
            onExit = function()
                PedMenu()
            end
        })

        lib.showContext('hobo_king_milestones_menu')
    end)
end

local OpenLeaderboardMenu = function()
    local playerIdentifier = SD.GetIdentifier()

    GetLeaderboard(function(leaderboard)
        GetPlayerScore(function(playerScore)
            local leaderboardOptions = {}

            local maxSlots = Config.Leaderboard.Amount or 5

            for rank = 1, maxSlots do
                local player = leaderboard[rank]
                if player then
                    local isCurrentPlayer = player.identifier == playerIdentifier
                    local playerLabel

                    if Config.Leaderboard.ShowNames then
                        playerLabel = player.name or locale('hobo.leaderboard_player_anonymous')
                    else
                        playerLabel = isCurrentPlayer and locale('hobo.leaderboard_player_you') or locale('hobo.leaderboard_player_anonymous')
                    end

                    leaderboardOptions[#leaderboardOptions + 1] = {
                        title = string.format("#%d %s", rank, playerLabel),
                        description = locale('hobo.leaderboard_entry', { score = player.score }),
                        icon = 'fas fa-user',
                        readOnly = true
                    }
                else
                    leaderboardOptions[#leaderboardOptions + 1] = {
                        title = string.format("#%d %s", rank, locale('hobo.leaderboard_slot_empty')),
                        description = locale('hobo.leaderboard_slot_empty_desc'),
                        icon = 'fas fa-user-slash',
                        readOnly = true
                    }
                end
            end

            leaderboardOptions[#leaderboardOptions + 1] = {
                title = locale('hobo.your_score_title'),
                description = locale('hobo.your_score_desc', { score = playerScore }),
                icon = 'fas fa-star',
                readOnly = true
            }

            leaderboardOptions[#leaderboardOptions + 1] = {
                title = locale('hobo.return_to_main_menu'),
                description = '',
                icon = 'fas fa-arrow-left',
                onSelect = function()
                    PedMenu()
                end
            }

            lib.registerContext({
                id = 'hobo_leaderboard_menu',
                title = locale('hobo.leaderboard_title'),
                options = leaderboardOptions,
                onExit = function()
                    PedMenu()
                end
            })

            lib.showContext('hobo_leaderboard_menu')
        end)
    end)
end

-- Helper to calculate the progress towards the next level
--- @param currentLevel number The player's current level
--- @param playerXP number The player's current XP
--- @return number The progress percentage for the current level
local GetLevelProgress = function(currentLevel, playerXP)
    local previousThreshold = 0
    if currentLevel > 1 and Config.Levels[currentLevel - 1] and Config.Levels[currentLevel - 1].XPThreshold then
        previousThreshold = Config.Levels[currentLevel - 1].XPThreshold
    end

    local nextThreshold = 99999999
    if Config.Levels[currentLevel] and Config.Levels[currentLevel].XPThreshold then
        nextThreshold = Config.Levels[currentLevel].XPThreshold
    end

    local xpIntoThisLevel = math.max(0, playerXP - previousThreshold)
    local xpRangeForThisLevel = nextThreshold - previousThreshold
    local progressPercent = 0

    if xpRangeForThisLevel > 0 then
        progressPercent = (xpIntoThisLevel / xpRangeForThisLevel) * 100
        if progressPercent > 100 then
            progressPercent = 100
        end
    end

    return math.floor(progressPercent + 0.5)
end

-- Function to open the Hobo King's menu
--- Displays the Hobo King's interaction menu to the player.
-- Function to open the Hobo King's menu
--- Displays the Hobo King's interaction menu to the player.
PedMenu = function()
    GetPlayerInfo(function(playerLevel, playerXP)
        local playerId = GetPlayerServerId(PlayerId())

        if not adviceGiven[playerId] then
            adviceGiven[playerId] = { stage = 0, advices = {} }
        end

        local adviceLevel = adviceGiven[playerId].stage or 0

        if adviceLevel >= 5 then
            SD.ShowNotification(locale('hobo.king_ignore'), 'error')
            return
        end

        local options = {}
        local levelProgress = GetLevelProgress(playerLevel, playerXP)

        options[#options + 1] = {
            title = locale('hobo.king_title'),
            description = locale('hobo.king_description', { level = playerLevel }),
            icon = 'fas fa-crown',
            iconColor = 'yellow',
            progress = levelProgress,
            colorScheme = 'green',
            readOnly = true
        }

        options[#options + 1] = {
            title = locale('hobo.shop_menu'),
            description = locale('hobo.shop_menu_description'),
            icon = 'fas fa-shopping-cart',
            onSelect = function()
                OpenShopMenu(playerLevel)
            end
        }

        if Config.Stats.Enable then
            options[#options + 1] = {
                title = locale('hobo.show_stats'),
                description = locale('hobo.show_stats_description'),
                icon = 'fas fa-info-circle',
                onSelect = function()
                    OpenStatsMenu()
                end
            }
        end

        if Config.Milestones.Enable then
            options[#options + 1] = {
                title = locale('hobo.show_milestones'),
                description = locale('hobo.show_milestones_description'),
                icon = 'fas fa-trophy',
                onSelect = function()
                    OpenMilestonesMenu()
                end
            }
        end

        if Config.Leaderboard.Enable then
            options[#options + 1] = {
                title = locale('hobo.global_leaderboard'),
                description = locale('hobo.leaderboard_description'),
                icon = 'fas fa-list-ol',
                onSelect = function()
                    OpenLeaderboardMenu()
                end
            }
        end

        if Config.EnableRats then 
            options[#options + 1] = {
                title = locale('hobo.rat_menu_title'),
                description = locale('hobo.rat_menu_desc'),
                icon = 'fas fa-paw',
                onSelect = function()
                    TriggerEvent('gglv-dumpsters:client:openRatMenu', true)
                end
            }
        end

        options[#options + 1] = {
            title = locale('hobo.ask_for_advice'),
            description = locale('hobo.advice_description'),
            icon = 'fas fa-comments',
            onSelect = function()
                GiveHoboAdvice()
            end
        }

        lib.registerContext({
            id = 'hobo_king_menu',
            title = locale('hobo.menu_title'),
            options = options,
            onExit = function()
            end
        })

        lib.showContext('hobo_king_menu')
    end)
end

RegisterNetEvent('sd-dumpster:client:openPed', PedMenu)

-- Function to create a ped with the pedModel on the specified coords
--- Spawns the Hobo King ped at the given coordinates with specified behavior.
--- @param pedModel string The model to create for the ped.
--- @param coords vector3 The coordinates where the ped will appear.
--- @param scenario string The scenario the ped will enact.
local CreatePedAtCoords = function(pedModel, coords, scenario)
    local options = {
        {
            action = PedMenu,
            icon = Config.Ped.Interaction.Icon,
            label = locale("target.talk_to_king"),
            canInteract = function()
                return true
            end
        }
    }

    local pedData = {
        model = pedModel,
        coords = coords,
        scenario = scenario,
        distance = 50,
        freeze = true,
        debug = false,
        targetOptions = {
            options = options,
            distance = Config.Ped.Interaction.Distance
        },
        interactionType = 'target'
    }
    SD.Ped.CreatePedAtPoint(pedData)
end

-- Thread that waits for the location to be set before triggering the CreatePedAtCoords function
CreateThread(function()
    if Config.Ped.Enable then
        while not GlobalState.HoboKingLocation do Wait(0) end
        CreatePedAtCoords(Config.Ped.Model, GlobalState.HoboKingLocation, Config.Ped.Scenario)
    end
end)

-- Blip Creation
CreateThread(function()
    if Config.Blip.Enable then
        while not GlobalState.HoboKingLocation do Wait(0) end
        local blip = AddBlipForCoord(GlobalState.HoboKingLocation.x, GlobalState.HoboKingLocation.y, GlobalState.HoboKingLocation.z)
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipDisplay(blip, Config.Blip.Display)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.Blip.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Blip.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

--- Handles the Needle Prick event, causing the player to act drunk for a specified duration.
--- @param playerPed number The player's ped ID.
local NeedlePrick = function(playerPed)
    local playerId = GetPlayerServerId(NetworkGetEntityOwner(playerPed))
    if NeedlePrickCooldowns[playerId] and NeedlePrickCooldowns[playerId] > GetGameTimer() then
        return
    end

    SD.ShowNotification(locale('dumpster.needle_poke'), 'error')
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
    RequestAnimSet("move_m@drunk@slightlydrunk")
    while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Wait(0)
    end
    SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", 1.0)
    ShakeGameplayCam("DRUNK_SHAKE", 1.0)

    CreateThread(function()
        Wait(Config.Events.NeedlePrick.Duration * 1000)
        ClearTimecycleModifier()
        SetPedMotionBlur(playerPed, false)
        ResetPedMovementClipset(playerPed, 1.0)
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedIsDrunk(playerPed, false)
    end)

    NeedlePrickCooldowns[playerId] = GetGameTimer() + (Config.Events.NeedlePrick.Cooldown * 1000)
end

--- Spawns a hostile hobo NPC near the player without significant elevation difference.
--- @param playerPed number The player's ped ID.
--- @return number The hobo ped ID.
local SpawnHoboPed = function(playerPed)
    local models = Config.Events.HoboAttack.Models
    local modelName = models[math.random(#models)]
    local hoboModel = GetHashKey(modelName)
    SD.LoadModel(hoboModel)

    local spawnRadius = 30.0
    local minSpawnDistance = 10.0
    local maxElevationDifference = 2.0
    local spawnCoords = nil
    local maxAttempts = 10
    local playerCoords = GetEntityCoords(playerPed)

    for attempt = 1, maxAttempts do
        local angle = math.random() * 2.0 * math.pi
        local distance = math.random() * (spawnRadius - minSpawnDistance) + minSpawnDistance
        local spawnX = playerCoords.x + distance * math.cos(angle)
        local spawnY = playerCoords.y + distance * math.sin(angle)
        local spawnZ = playerCoords.z + 50.0

        local foundGround, groundZ = GetGroundZFor_3dCoord(spawnX, spawnY, spawnZ, false)
        if foundGround then
            spawnCoords = vector3(spawnX, spawnY, groundZ)
            local elevationDifference = math.abs(playerCoords.z - spawnCoords.z)
            if elevationDifference <= maxElevationDifference and not IsPointObscuredByAMissionEntity(spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.5, 0.5, 0.5) then
                break
            else
                spawnCoords = nil
            end
        end
    end

    if not spawnCoords then
        return nil
    end

    local hoboPed = CreatePed(4, hoboModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, true)
    SetPedCombatAttributes(hoboPed, 46, true)
    SetPedCombatAbility(hoboPed, 100)
    SetPedAsEnemy(hoboPed, true)
    SetPedFleeAttributes(hoboPed, 0, false)

    SD.ShowNotification(locale('dumpster.hobo_attack'), 'error')

    local hoboGroup = GetHashKey("HOBO_GROUP")
    if not NetworkIsPlayerActive(hoboGroup) then
        AddRelationshipGroup("HOBO_GROUP")
    end
    SetPedRelationshipGroupHash(hoboPed, hoboGroup)
    local playerGroup = GetHashKey("PLAYER")
    SetRelationshipBetweenGroups(5, hoboGroup, playerGroup)
    SetRelationshipBetweenGroups(5, playerGroup, hoboGroup)

    GiveWeaponToPed(hoboPed, GetHashKey("WEAPON_KNIFE"), 1, false, true)

    ClearPedTasksImmediately(hoboPed)
    TaskCombatPed(hoboPed, playerPed, 0, 16)

    return hoboPed
end

--- Allows the player to loot the defeated hobo.
--- @param hoboPed number The hobo ped ID.
local LootHobo = function(hoboPed)
    local ped = PlayerPedId()
    SD.LoadAnim("pickup_object")
    TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)

    local netId = NetworkGetNetworkIdFromEntity(hoboPed)
    SD.Callback('sd-dumpster:server:lootHobo', false, function(success)
        if success then
            SD.Interaction.RemoveTargetEntity(hoboPed)
        end
    end, netId)
    
    Wait(1000)
    ClearPedTasks(ped)
end

--- Monitors the hobo NPC, adding loot interaction when defeated, or deleting it if it's too far from the player.
--- @param hoboPed number The hobo ped ID.
--- @param playerPed number The player's ped ID.
local MonitorHoboPed = function(hoboPed, playerPed)
    local maxDistance = Config.Events.HoboAttack.MaxDistance

    CreateThread(function()
        while DoesEntityExist(hoboPed) do
            Wait(1000)
            local hoboCoords = GetEntityCoords(hoboPed)
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(hoboCoords - playerCoords)

            if IsPedDeadOrDying(hoboPed, true) then
                SD.ShowNotification(locale('dumpster.hobo_defeated'), 'success')
                SetEntityAsNoLongerNeeded(hoboPed)

                if Config.HoboLoot.Enable then
                    SD.Interaction.AddTargetEntity(Config.Interaction, hoboPed, {
                        distance = 1.5,
                        options = {
                            {
                                action = function(entity) LootHobo(entity) end,
                                icon = 'fas fa-circle',
                                label = locale('target.loot'),
                                canInteract = function(entity)
                                    return IsPedDeadOrDying(entity, true)
                                end,
                            }
                        }
                    })
                end

                break
            elseif distance > maxDistance then
                SD.ShowNotification(locale('dumpster.hobo_escaped'), 'success')
                DeleteEntity(hoboPed)
                break
            end
        end
    end)
end

--- Handles the Hobo Attack event.
--- @param playerPed number The player's ped ID.
local HoboAttack = function(playerPed)
    local playerId = GetPlayerServerId(NetworkGetEntityOwner(playerPed))
    if HoboAttackCooldowns[playerId] and HoboAttackCooldowns[playerId] > GetGameTimer() then
        return
    end

    local hoboPed = SpawnHoboPed(playerPed)
    if hoboPed then
        MonitorHoboPed(hoboPed, playerPed)
    end

    HoboAttackCooldowns[playerId] = GetGameTimer() + (Config.Events.HoboAttack.Cooldown * 1000)
end

local MakeSaw = function()
    local Ped = PlayerPedId()
    local sawModel = GetHashKey("h4_prop_h4_bolt_cutter_01a")

    SD.LoadModel(sawModel)

    local sawProp = CreateObject(sawModel, 0, 0, 0, true, false, false)
    AttachEntityToEntity(sawProp, Ped, GetPedBoneIndex(Ped, 57005), 0.04, 0.06, 0.0, -100.0, 190.0, -20.0, true, true, false, false, 1, true)
    SetModelAsNoLongerNeeded(sawModel)

    return sawProp
end

local LoadDrillSound = function()
    RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
end

--- Starts the search process on a dumpster, including animations and events.
--- @param playerPed number The player's ped ID.
--- @param dumpsterID string The dumpster's unique identifier.
--- @param dumpsterCoords vector3 The coordinates of the dumpster.
--- @param duration number The duration of the search process in milliseconds.
--- @param playerLevel number The player's level.
local StartSearch = function(playerPed, dumpsterID, dumpsterCoords, duration, playerLevel, isLockedDumpster)
    TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', dumpsterID, true)
    SD.LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')

    TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 49, 1, 0, 0, 0)
    
    SD.StartProgress('searching_dumpster', locale('progress.searching_dumpster'), duration,
        function()
            TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', dumpsterID, false)

            local lootChance = Config.Levels[playerLevel] and Config.Levels[playerLevel].DumpsterLootChance or 0
            local foundLoot = isLockedDumpster or (math.random(1, 100) <= lootChance)

            SD.Callback('sd-dumpster:server:searchDumpster', false, function(result)
                if not result or not result.success then
                    SD.ShowNotification(locale('notifications.search_failed'), "error")
                else
                    if result.foundLoot then
                        if result.canCarryAll then
                            SD.ShowNotification(locale('notifications.dumpster_loot_success'), "success")
                            local events = {}
                            if Config.Events.NeedlePrick.Enable then
                                table.insert(events, { event = NeedlePrick, chance = Config.Events.NeedlePrick.Chance })
                            end
                            if Config.Events.HoboAttack.Enable then
                                table.insert(events, { event = HoboAttack, chance = Config.Events.HoboAttack.Chance })
                            end
                            if #events > 0 then
                                local selectedEventIndex = SD.Math.WeightedChance(events)
                                events[selectedEventIndex].event(playerPed)
                            end
                        else
                            SD.ShowNotification(locale('notifications.cannot_carry_all'), "error")
                        end
                    else
                        SD.ShowNotification(locale('notifications.no_loot_found'), "error")
                    end

                    dumpsterSearchAttempts[dumpsterID] = nil
                end
            end, dumpsterID, dumpsterCoords, foundLoot)

            ClearPedTasks(playerPed)
        end,
        function()
            TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', dumpsterID, false)
            ClearPedTasks(playerPed)
        end
    )
end

local HandleLockedDumpster = function(playerPed, dumpsterID, dumpsterCoords, duration, playerLevel)
    SD.Callback('gglv-dumpsters:server:checkPlayerHasItem', false, function(hasItem)
        if hasItem then
            local sawProp = MakeSaw()

            SD.LoadAnim('amb@world_human_welding@male@base')
            TaskPlayAnim(playerPed, "amb@world_human_welding@male@base", "base", 8.0, -8.0, -1, 49, 0, false, false, false)

            CreateThread(function()
                Wait(200)

                SD.LoadPtfxAsset("cut_sv")
                UseParticleFxAssetNextCall("cut_sv")
                local ptfx = StartNetworkedParticleFxLoopedOnEntity(
                    'cs_sv_cbr_train_sparks',
                    sawProp,
                    -0.6, 0.0, -0.05,
                    0.0, 90.0,
                    GetEntityHeading(playerPed) + 200,
                    0.6, false, false, false
                )

                LoadDrillSound()
                local soundId = GetSoundId()

                Wait(1000)

                PlaySoundFromEntity(soundId, "Drill", sawProp, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)

                Wait(duration - 1000)

                StopSound(soundId)
                ReleaseSoundId(soundId)

                StopParticleFxLooped(ptfx, false)
                RemoveParticleFx(ptfx, true)

                DeleteObject(sawProp)
            end)

            SD.StartProgress('unlocking_dumpster', locale('progress.unlocking_dumpster'), duration,
                function()
                    TriggerServerEvent('gglv-dumpsters:server:setDumpsterUnlocked', dumpsterID)
                    StartSearch(playerPed, dumpsterID, dumpsterCoords, duration, playerLevel, true)
                end,
                function()
                    ClearPedTasks(playerPed)
                end
            )
        else
            ClearPedTasks(playerPed)
            SD.ShowNotification(locale('notifications.missing_item'), 'error')
        end
    end, Config.Items.Grinder)
end

local HandleMinigame = function(playerPed, dumpsterID, dumpsterCoords, duration, playerLevel)
    local minigame = Config.Minigame.Dumpsters.Minigame
    local args = Config.Minigame.Dumpsters.Args[minigame] or {}

    if minigame == 'lib.skillCheck' then
        local skillCheckArgs = args[1]
        local inputs = args[2]
    
        local success = lib.skillCheck(skillCheckArgs, inputs)
        if success then
            StartSearch(playerPed, dumpsterID, dumpsterCoords, duration, playerLevel)
        else
            SD.ShowNotification(locale('notifications.minigame_failed'), 'error')
            ClearPedTasks(playerPed)
        end
    else
        SD.StartHack(minigame, function(success)
            if success then
                StartSearch(playerPed, dumpsterID, dumpsterCoords, duration, playerLevel)
            else
                SD.ShowNotification(locale('notifications.minigame_failed'), 'error')
                ClearPedTasks(playerPed)
            end
        end, table.unpack(args))
    end
end

local LootDumpster = function(entity)
    local playerPed = PlayerPedId()
    local dumpsterCoords = GetEntityCoords(entity)
    local entityModel = GetEntityModel(entity)
    local isLargeDumpster = false

    for _, model in ipairs(Config.BinProps.Large) do
        if GetHashKey(model) == entityModel then
            isLargeDumpster = true
            break
        end
    end

    SD.Callback('gglv-dumpsters:server:isDumpsterAvailable', false, function(response)
        local isAvailable = response.isAvailable
        local dumpsterID  = response.dumpsterID

        if isAvailable then
            GetPlayerInfo(function(playerLevel, playerXP)
                local levelConfig    = Config.Levels[playerLevel] or Config.Levels[1]
                local searchDuration = (levelConfig.Duration or 10) * 1000
                local lockChance     = levelConfig.LockChance
                local sawDuration    = (levelConfig.SawDuration or 5) * 1000
                local lockCooldown   = (levelConfig.LockCooldown or 30) * 60000

                TaskTurnPedToFaceEntity(playerPed, entity, 5000)

                if Config.LockedDumpster.Enable and isLargeDumpster then
                    SD.Callback('gglv-dumpsters:server:isDumpsterLocked', false, function(isLocked)
                        if isLocked then
                            HandleLockedDumpster(playerPed, dumpsterID, dumpsterCoords, sawDuration, playerLevel)
                        else
                            if dumpsterSearchAttempts[dumpsterID] == nil and not lastLockAttempt then
                                if math.random(1, 100) <= lockChance then
                                    SD.Callback('gglv-dumpsters:server:setDumpsterLocked', false, function()
                                        dumpsterSearchAttempts[dumpsterID] = true
                                        lastLockAttempt = true
                                        SetTimeout(lockCooldown, function()
                                            lastLockAttempt = false
                                        end)
                                        HandleLockedDumpster(playerPed, dumpsterID, dumpsterCoords, sawDuration, playerLevel)
                                    end, dumpsterID)
                                else
                                    dumpsterSearchAttempts[dumpsterID] = false
                                    if Config.Minigame.Dumpsters.Enable then
                                        HandleMinigame(playerPed, dumpsterID, dumpsterCoords, searchDuration, playerLevel)
                                    else
                                        StartSearch(playerPed, dumpsterID, dumpsterCoords, searchDuration, playerLevel)
                                    end
                                end
                            else
                                if Config.Minigame.Dumpsters.Enable then
                                    HandleMinigame(playerPed, dumpsterID, dumpsterCoords, searchDuration, playerLevel)
                                else
                                    StartSearch(playerPed, dumpsterID, dumpsterCoords, searchDuration, playerLevel)
                                end
                            end
                        end
                    end, dumpsterID)
                else
                    if Config.Minigame.Dumpsters.Enable then
                        HandleMinigame(playerPed, dumpsterID, dumpsterCoords, searchDuration, playerLevel)
                    else
                        StartSearch(playerPed, dumpsterID, dumpsterCoords, searchDuration, playerLevel)
                    end
                end
            end)
        else
            ClearPedTasks(playerPed)
            SD.ShowNotification(locale('notifications.dumpster_on_cooldown'), 'error')
        end
    end, RetrieveNetID(entity))
end

--- Handles the search action for Hobo Camp props with cooldown check.
--- @param playerPed number The player's ped identifier.
--- @param duration number Duration for the looting progress.
--- @param minigame string The minigame identifier.
--- @param args table Arguments for the minigame.
--- @param entity number/string The entity to get the coordinates from
local SearchHoboCamp = function(playerPed, duration, minigame, args, entity)
    local propId = RetrieveNetID(entity)
    local entityCoords = GetEntityCoords(entity)

    SD.Callback('gglv-dumpsters:server:isCampAvailable', false, function(isAvailable)
        if not isAvailable then
            SD.ShowNotification(locale('notifications.camp_looted_recently'), "error")
            return
        end

        TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', propId, true)

        if minigame == 'lib.skillCheck' then
            local skillCheckArgs = args[1]
            local inputs = args[2]
            local success = lib.skillCheck(skillCheckArgs, inputs)
            if success then
                local animDict = "anim@scripted@player@mission@tun_table_grab@gold@heeled@"
                local animName = "grab"

                SD.LoadAnim(animDict)
                TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 16, 0, false, false, false)

                SD.StartProgress('camp_loot', locale('progress.searching_camp'), duration, function()
                    TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', propId, false)
                    
                    GetPlayerInfo(function(playerLevel, xp)
                        local lootChance = Config.Levels[playerLevel] and Config.Levels[playerLevel].CampLootChance or 0
                        local foundLoot = (math.random(1, 100) <= lootChance)

                        SD.Callback('sd-dumpster:server:getLoot', false, function(result)
                            if not result or not result.success then
                                SD.ShowNotification(locale('notifications.camp_search_failed'), "error")
                            else
                                if result.foundLoot then
                                    if result.canCarryAll then
                                        SD.ShowNotification(locale('notifications.camp_loot_success'), "success")
                                    else
                                        SD.ShowNotification(locale('notifications.cannot_carry_all'), "error")
                                    end
                                else
                                    SD.ShowNotification(locale('notifications.no_loot_found'), "error")
                                end
                            end
                        end, entityCoords, propId, foundLoot)
                    end)

                    ClearPedTasks(playerPed)
                end, function()
                    TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', propId, false)
                    SD.ShowNotification(locale('notifications.camp_loot_canceled'), "error")
                    ClearPedTasks(playerPed)
                end)
            else
                SD.ShowNotification(locale('notifications.minigame_failed'), "error")
                TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', propId, false)
            end
        else
            SD.StartHack(minigame, function(success)
                if success then
                    local animDict = "anim@scripted@player@mission@tun_table_grab@gold@heeled@"
                    local animName = "grab"

                    SD.LoadAnim(animDict)
                    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 16, 0, false, false, false)

                    SD.StartProgress('camp_loot', locale('progress.searching_camp'), duration, function()
                        TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', propId, false)
                        
                        GetPlayerInfo(function(playerLevel, xp)
                            local lootChance = Config.Levels[playerLevel] and Config.Levels[playerLevel].CampLootChance or 0
                            local foundLoot = (math.random(1, 100) <= lootChance)

                            -- Same server call here
                            SD.Callback('sd-dumpster:server:getLoot', false, function(result)
                                if not result or not result.success then
                                    SD.ShowNotification(locale('notifications.camp_search_failed'), "error")
                                else
                                    if result.foundLoot then
                                        if result.canCarryAll then
                                            SD.ShowNotification(locale('notifications.camp_loot_success'), "success")
                                        else
                                            SD.ShowNotification(locale('notifications.cannot_carry_all'), "error")
                                        end
                                    else
                                        SD.ShowNotification(locale('notifications.no_loot_found'), "error")
                                    end
                                end
                            end, entityCoords, propId, foundLoot)
                        end)

                        ClearPedTasks(playerPed)
                    end, function()
                        TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', propId, false)
                        SD.ShowNotification(locale('notifications.camp_loot_canceled'), "error")
                        ClearPedTasks(playerPed)
                    end)
                else
                    TriggerServerEvent('gglv-dumpsters:server:setEntityBusy', propId, false)
                    SD.ShowNotification(locale('notifications.minigame_failed'), "error")
                end
            end, table.unpack(args))
        end
    end, propId)
end

--- Handles the interaction with a loose trash bag.
--- Checks if the bag contains valuables based on the player's level and a configured loot chance.
--- Plays an animation and shows a progress bar during inspection.
--- If valuables are found, starts monitoring for bag destruction to grant rewards.
--- If the bag is empty, it is marked to prevent further interactions.
--- @param entity number The entity ID of the trash bag being interacted with.
local HandleBagInteraction = function(entity)
    if lootedEmptyBags[entity] then
        SD.ShowNotification(locale('notifications.bag_empty'), 'error')
        return
    end

    TriggerServerEvent('gglv-dumpsters:server:bagInteracted', entity)

    GetPlayerInfo(function(playerLevel, playerXP)
        local levelConfig = Config.Levels[playerLevel] or Config.Levels[1]
        local lootChance = levelConfig.BagLootChance or 0

        local playerPed = PlayerPedId()
        SD.LoadAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@")
        TaskPlayAnim(playerPed, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_02_inspectorfemale", 8.0, 8.0, -1, 49, 0, false, false, false)

        SD.StartProgress('inspecting_bag', locale('progress.inspecting_bag'), levelConfig.Duration * 1000, 
            function()
                ClearPedTasks(playerPed)

                if math.random(1, 100) > lootChance then
                    lootedEmptyBags[entity] = true
                    SD.ShowNotification(locale('notifications.no_valuables'), 'error')
                    return
                end

                SD.ShowNotification(locale('notifications.valuables_found'), 'success')

                local monitoredEntity = entity
                CreateThread(function()
                    while DoesEntityExist(monitoredEntity) and #(GetEntityCoords(monitoredEntity) - GetEntityCoords(PlayerPedId())) < 10.0 do
                        Wait(500)

                        if not DoesEntityExist(monitoredEntity) then
                            TriggerServerEvent('gglv-dumpsters:server:bagDestroyed', monitoredEntity)
                            SD.ShowNotification(locale('notifications.bag_loot_granted'), 'success')
                            lootedEmptyBags[entity] = true
                            monitoredEntity = nil
                            return
                        end
                    end
                end)
            end, 
            function()
                ClearPedTasks(playerPed)
            end
        )
    end)
end

--- Adds target interactions to all props defined in Config.HoboCamps.
CreateThread(function()
    if not (Config.HoboCamps and Config.HoboCamps.Enable) then
        return
    end

    local models = Config.HoboCamps.Models or {}
    local duration = 10000
    local minigame = Config.Minigame.Camps.Minigame
    local args = Config.Minigame.Camps.Args[minigame] or {}
    local playerPed = PlayerPedId()

    SD.Target.AddTargetModel(models, {
        options = {
            {
                action = function(entity)
                    SearchHoboCamp(playerPed, duration, minigame, args, entity)
                end,
                icon = 'fas fa-search',
                label = locale('target.search_camp'),
                canInteract = function(entity)
                    return true
                end,
            }
        },
        distance = 2.0,
    })
end)

-- Helper function to add target interactions for bins
--- Adds target interactions for specified models with options for opening a stash.
--- @param models table A list of model hashes.
--- @param lootLabel string The label for the loot option.
--- @param stashLabel string|nil The label for the open stash option.
local AddBinTargets = function(models, lootLabel, stashLabel)
    local options = {
        {
            action = function(entity)
                LootDumpster(entity)
            end,
            icon = 'fa-solid fa-dumpster',
            label = lootLabel,
            canInteract = function(entity)
                return true
            end,
        }
    }

    if stashLabel then
        table.insert(options, {
            action = function(entity)
                TriggerServerEvent('gglv-dumpsters:server:registerStash', RetrieveNetID(entity), stashLabel)
            end,
            icon = 'fas fa-box',
            label = stashLabel,
            canInteract = function(entity)
                return true
            end,
        })
    end

    SD.Target.AddTargetModel(models, {
        options = options,
        distance = 1.5,
    })
end

--- Adds target interactions to all models specified in the bags list.
--- @param bagModels table List of prop models for loose trash bags.
--- @param label string The interaction label for searching bags.
local AddBagTargets = function(bagModels, label)
    local interactedBags = {}

    SD.Target.AddTargetModel(bagModels, {
        options = {
            {
                action = function(entity)
                    TriggerServerEvent('gglv-dumpsters:server:bagInteracted', entity)
                    HandleBagInteraction(entity)
                    interactedBags[entity] = true
                end,
                icon = 'fas fa-search',
                label = label,
                canInteract = function(entity)
                    return not interactedBags[entity]
                end,
            }
        },
        distance = 2.0,
    })
end

-- Main thread to add targets to bins and bags
CreateThread(function()
    local oxInventory = GetResourceState('ox_inventory') == 'started'

    AddBinTargets(
        Config.BinProps.Small,
        locale('target.search_trashcan'),
        oxInventory and locale('target.open_trash_stash') or nil
    )
    AddBinTargets(
        Config.BinProps.Large,
        locale('target.search_dumpster'),
        oxInventory and locale('target.open_dumpster_stash') or nil
    )

    if Config.Bags.Enable then
        AddBagTargets(
            Config.Bags.Models,
            locale('target.search_bags')
        )
    end
end)