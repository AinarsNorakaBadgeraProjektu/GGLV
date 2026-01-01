local locale = SD.Locale.T
local ratFollowPed = nil
local atKing = false

--- Calculates the rat's level based on its XP.
--- @param xp number The rat's current XP.
--- @return number The calculated rat level.
local CalculateRatLevel = function(xp)
    xp = tonumber(xp) or 0
    for level, settings in ipairs(Config.RatLevels) do
        if settings.XPThreshold and xp < settings.XPThreshold then
            return level
        end
    end
    return #Config.RatLevels
end

--- Calculates the progress percentage towards the next rat level.
--- @param currentLevel number The rat's current level.
--- @param ratXP number The rat's current XP.
--- @return number The progress percentage.
local GetRatProgress = function(currentLevel, ratXP)
    local previousThreshold = 0
    if currentLevel > 1 and Config.RatLevels[currentLevel - 1] and Config.RatLevels[currentLevel - 1].XPThreshold then
        previousThreshold = Config.RatLevels[currentLevel - 1].XPThreshold
    end

    local nextThreshold = (Config.RatLevels[currentLevel] and Config.RatLevels[currentLevel].XPThreshold) or (previousThreshold + 100)
    local xpIntoThisLevel = math.max(0, ratXP - previousThreshold)
    local xpRangeForThisLevel = nextThreshold - previousThreshold
    local progressPercent = 0
    if xpRangeForThisLevel > 0 then
        progressPercent = (xpIntoThisLevel / xpRangeForThisLevel) * 100
    end
    return math.floor(progressPercent + 0.5)
end

--- Opens the Rat Stats menu to display rat-specific statistics.
--- @param ratData table The player's rat data.
--- @param atKing boolean whether the player is at the king or not
local OpenRatStatsMenu = function(ratData, atKing)
    local options = {}
    if ratData.stats then
        for statKey, statValue in pairs(ratData.stats) do
            if statKey == "expedition" and type(statValue) == "table" then
                if statValue.expeditionAmount then
                    options[#options + 1] = {
                        title = locale('rat.expeditions_completed_title'),
                        description = locale('rat.expeditions_completed_desc', { value = tostring(statValue.expeditionAmount) }),
                        readOnly = true,
                        icon = 'fas fa-route'
                    }
                end
                if statValue.timesInjured then
                    options[#options + 1] = {
                        title = locale('rat.times_injured_title'),
                        description = locale('rat.times_injured_desc', { value = tostring(statValue.timesInjured) }),
                        readOnly = true,
                        icon = 'fas fa-heart-broken'
                    }
                end
                for subKey, subValue in pairs(statValue) do
                    if subKey ~= "expeditionAmount" and subKey ~= "timesInjured" then
                        local title, description, icon
                        local meta = Config.ItemsMetadata[subKey]
                        if meta then
                            title = meta.label
                            icon = meta.icon
                        else
                            title = subKey
                            icon = 'fas fa-box'
                        end
                        description = locale('rat.item_recovered', { value = tostring(subValue), item = title })
                        options[#options + 1] = {
                            title = title,
                            description = description,
                            readOnly = true,
                            icon = icon
                        }
                    end
                end
            else
                options[#options + 1] = {
                    title = statKey,
                    description = locale('rat.stat_value', { stat = statKey, value = tostring(statValue) }),
                    readOnly = true,
                    icon = 'fas fa-chart-bar'
                }
            end
        end
    end
    if #options == 0 then
        options[#options + 1] = {
            title = locale('rat.no_stats_title'),
            description = locale('rat.no_stats_desc'),
            disabled = true,
            icon = 'fas fa-exclamation-circle'
        }
    end
    options[#options + 1] = {
        title = locale('rat.return'),
        icon = 'fas fa-arrow-left',
        onSelect = function()
            TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
        end,
    }
    lib.registerContext({
        id = 'rat_stats_menu',
        title = locale('rat.stats_menu_title'),
        options = options,
        onExit = function() 
            TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
        end
    })
    lib.showContext('rat_stats_menu')
end

local function escapePercents(str)
    return tostring(str):gsub("%%", "%%%%")
end

local OpenRatExpeditionMenu = function(RatData, atKing)
    RatData = RatData or {}
    local ratXP = RatData.xp or 0
    local ratLevel = CalculateRatLevel(ratXP)
    local options = {}

    local scavengerBonus = 0
    if RatData.perks and RatData.perks.scavengerSupreme and Config.RatPerks.scavengerSupreme then
        local level = RatData.perks.scavengerSupreme
        scavengerBonus = (Config.RatPerks.scavengerSupreme.levels[level] and Config.RatPerks.scavengerSupreme.levels[level].bonus) or 0
    end

    local fleetBonus = 0
    if RatData.perks and RatData.perks.fleetFooted and Config.RatPerks.fleetFooted then
        local level = RatData.perks.fleetFooted
        fleetBonus = (Config.RatPerks.fleetFooted.levels[level] and Config.RatPerks.fleetFooted.levels[level].bonus) or 0
    end

    local safetyBonus = 0
    if RatData.perks and RatData.perks.safetyPaws and Config.RatPerks.safetyPaws then
        local level = RatData.perks.safetyPaws
        safetyBonus = (Config.RatPerks.safetyPaws.levels[level] and Config.RatPerks.safetyPaws.levels[level].bonus) or 0
    end

    local luckyBonus = 0
    if RatData.perks and RatData.perks.luckyWhiskers and Config.RatPerks.luckyWhiskers then
        local level = RatData.perks.luckyWhiskers
        luckyBonus = (Config.RatPerks.luckyWhiskers.levels[level] and Config.RatPerks.luckyWhiskers.levels[level].bonus) or 0
    end

    if Config.RatExpeditions then
        for _, expedition in ipairs(Config.RatExpeditions) do
            local disabled = false
            if ratLevel < expedition.minLevel then
                disabled = true
            end

            local durationInfo = ""
            if fleetBonus > 0 then
                local adjustedDuration = expedition.duration * (1 - fleetBonus / 100)
                local adjHours = math.floor(adjustedDuration / 3600)
                local adjMinutes = math.floor((adjustedDuration % 3600) / 60)
                local baseHours = math.floor(expedition.duration / 3600)
                local baseMinutes = math.floor((expedition.duration % 3600) / 60)
                local reductionSeconds = expedition.duration - adjustedDuration
                local redHours = math.floor(reductionSeconds / 3600)
                local redMinutes = math.floor((reductionSeconds % 3600) / 60)
                local reductionStr = (redHours > 0) and (redHours .. "h " .. redMinutes .. "m") or (redMinutes .. "m")
                durationInfo = baseHours .. "h " .. baseMinutes .. "m" .. " (" .. adjHours .. "h " .. adjMinutes .. "m " .. escapePercents(locale("rat.with_bonus_desc")) .. ")"
            else
                local baseHours = math.floor(expedition.duration / 3600)
                local baseMinutes = math.floor((expedition.duration % 3600) / 60)
                durationInfo = baseHours .. "h " .. baseMinutes .. "m"
            end

            local baseRisk = expedition.risk
            local riskInfo = tostring(baseRisk) .. "%"
            if safetyBonus > 0 then
                local adjustedRisk = baseRisk - safetyBonus
                if adjustedRisk < 0 then adjustedRisk = 0 end
                riskInfo = tostring(baseRisk) .. "% (" .. tostring(adjustedRisk) .. "% " .. escapePercents(locale("rat.with_safety_desc")) .. ")"
            end

            local lootInfo = ""
            if expedition.Loot then
                local lootTable = expedition.Loot
                local normalLoot = ""
                local listSeparator = ", "
                local listNewline = "\n"
                for i, item in ipairs(lootTable.Items or {}) do
                    local meta = Config.ItemsMetadata[item.name]
                    local label = (meta and meta.label) or item.name
                    normalLoot = normalLoot .. label .. listSeparator
                end
                if #normalLoot > 0 then
                    normalLoot = normalLoot:sub(1, -(#listSeparator + 1))
                end
                lootInfo = normalLoot
                if lootTable.RareItem and lootTable.RareItem.Enable then
                    local rareChance = lootTable.RareItem.Chance
                    local rareItem = (lootTable.RareItem.Items and lootTable.RareItem.Items[1]) or nil
                    if rareItem then
                        local metaRare = Config.ItemsMetadata[rareItem.name]
                        local rareLabel = (metaRare and metaRare.label) or rareItem.name
                        if luckyBonus > 0 then
                            local adjustedChance = rareChance + luckyBonus
                            lootInfo = lootInfo .. listNewline .. locale("rat.rare_item", { 
                                item = rareLabel, 
                                chance = tostring(rareChance) .. "%%",
                                bonus = " (" .. tostring(adjustedChance) .. "%% " .. escapePercents(locale("rat.with_lucky_desc")) .. ")"
                            })
                        else
                            lootInfo = lootInfo .. listNewline .. locale("rat.rare_item", { 
                                item = rareLabel, 
                                chance = tostring(rareChance) .. "%%",
                                bonus = ""
                            })
                        end
                    end
                end
            else
                lootInfo = expedition.rewards
            end

            local replacements = {
                name = escapePercents(expedition.name),
                hours = escapePercents(durationInfo),
                minutes = "",
                risk = escapePercents(riskInfo),
                rewards = escapePercents(lootInfo),
                xpReward = tostring(expedition.xpReward or 0)
            }
            local description = locale("rat.expedition_option_desc", replacements)
            if scavengerBonus > 0 then
                description = description .. "\n" .. locale("rat.scavenger_bonus", { bonus = tostring(scavengerBonus) })
            end
            if disabled then
                description = description .. " (" .. locale("rat.expedition_level_req", { minLevel = expedition.minLevel }) .. ")"
            end

            options[#options + 1] = {
                title = escapePercents(expedition.name),
                description = description,
                icon = "fas fa-running",
                disabled = disabled,
                onSelect = function()
                    SD.Callback("gglv-dumpsters:server:generateExpeditionRoute", false, function(expeditionData)
                        SD.ShowNotification(locale("rat.expedition_sent", { expedition = escapePercents(expedition.name) }), "success")
                        Wait(500)
                        TriggerEvent("gglv-dumpsters:client:openRatMenu", atKing)
                    end, expedition.id)
                end
            }
        end
    else
        options[#options + 1] = {
            title = locale("rat.no_expeditions"),
            description = locale("rat.no_expeditions_desc"),
            readOnly = true,
            icon = "fas fa-exclamation-circle"
        }
    end

    options[#options + 1] = {
        title = locale("rat.return"),
        icon = "fas fa-arrow-left",
        onSelect = function()
            TriggerEvent("gglv-dumpsters:client:openRatMenu", atKing)
        end,
    }

    lib.registerContext({
        id = "rat_expedition_menu",
        title = locale("rat.expedition_menu_title"),
        options = options,
        onExit = function() TriggerEvent("gglv-dumpsters:client:openRatMenu", atKing) end
    })
    lib.showContext("rat_expedition_menu")
end

local OpenRatPerksMenu = function(RatData, atKing)
    SD.Callback('gglv-dumpsters:server:getAvailablePerkPoints', false, function(availablePoints)
        RatData = RatData or {}
        local ratXP = RatData.xp or 0
        local ratLevel = CalculateRatLevel(ratXP)
        local availablePerkPoints = availablePoints or (ratLevel * (Config.PerkPointPerLevel or 1))
        local assignedPerks = RatData.perks or {}
        local options = {}

        options[#options + 1] = {
            title = locale("rat.perks_available"),
            description = locale("rat.perks_available_desc", { points = availablePerkPoints }),
            icon = "fas fa-info-circle",
            readOnly = true,
        }

        for perkKey, perkConfig in pairs(Config.RatPerks) do
            local currentLevel = assignedPerks[perkKey] or 0
            local maxLevel = #perkConfig.levels
            local nextLevel = currentLevel + 1
            local optionTitle = locale(perkConfig.title) .. " (Level " .. currentLevel .. ")"
            local currentBonus, nextBonus = 0, 0
            if currentLevel == 0 then
                currentBonus = 0
                nextBonus = perkConfig.levels[1].bonus
            else
                currentBonus = perkConfig.levels[currentLevel].bonus
                if currentLevel < maxLevel then
                    nextBonus = perkConfig.levels[currentLevel + 1].bonus
                end
            end

            local bonusText = ""
            if perkKey == "scavengerSupreme" then
                if currentLevel < maxLevel then
                    bonusText = locale("rat.perk_static_bonus", { current = currentBonus, next = nextBonus })
                else
                    bonusText = locale("rat.perk_static_maxed", { bonus = currentBonus })
                end
            else
                if currentLevel < maxLevel then
                    bonusText = locale("rat.perk_bonus", { current = currentBonus, next = nextBonus })
                else
                    bonusText = locale("rat.perk_maxed", { bonus = currentBonus })
                end
            end

            local optionDesc = locale(perkConfig.shortDesc) .. "\n" .. bonusText

            local entry = {
                title = optionTitle,
                description = optionDesc,
                icon = perkConfig.icon,
            }

            if currentLevel >= maxLevel then
                entry.readOnly = true
            else
                if availablePerkPoints > 0 then
                    entry.onSelect = function()
                        SD.Callback('gglv-dumpsters:server:spendRatPerk', false, function(updatedRatData)
                            if updatedRatData then
                                TriggerEvent('gglv-dumpsters:client:openPerksMenu', updatedRatData, atKing)
                            end
                        end, perkKey)
                    end
                else
                    entry.disabled = true
                    entry.readOnly = true
                end
            end

            options[#options + 1] = entry
        end

        options[#options + 1] = {
            title = locale("rat.return"),
            icon = "fas fa-arrow-left",
            onSelect = function()
                TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
            end,
        }

        lib.registerContext({
            id = "rat_perks_menu",
            title = locale("rat.perks_menu_title"),
            options = options,
            onExit = function()
                TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
            end
        })
        lib.showContext("rat_perks_menu")
    end)
end

RegisterNetEvent('gglv-dumpsters:client:openPerksMenu', OpenRatPerksMenu)


--- Opens the main Rat Management menu.
--- This function accepts a boolean argument "atKing" to indicate whether the player is at the King.
local OpenRatMenu = function(atKing)
    SD.Callback('gglv-dumpsters:server:getRatData', false, function(RatData)
        local RatData = RatData or {}
        local options = {}

        if not RatData.owned then
            if Config.CreateExportForMenu.Enable and Config.CreateExportForMenu.OnlyAllowPurchaseAtKing and (not atKing) then
                SD.ShowNotification(locale('rat.no_rat_owned'), "error")
                return
            else
                if Config.LevelRestrict.Enable then
                    SD.Callback('gglv-dumpsters:server:getPlayerInfo', false, function(playerInfo)
                        print(playerInfo.level, Config.LevelRestrict.Level )
                        local level = playerInfo.level
                        if not level then level = 1 end
                        if level < Config.LevelRestrict.Level then
                            options[#options + 1] = {
                                title = locale('rat.buy'),
                                description = locale('rat.buy_level_restricted', { level = Config.LevelRestrict.Level }),
                                icon = 'fas fa-paw',
                                disabled = true,
                                readOnly = true,
                            }
                        else
                            options[#options + 1] = {
                                title = locale('rat.buy'),
                                description = locale('rat.buy_desc', { price = Config.PriceForRat }),
                                icon = 'fas fa-paw',
                                onSelect = function()
                                    local input = lib.inputDialog(locale('rat.name_dialog_title'), { locale('rat.name_dialog_desc') })
                                    if input and input[1] then
                                        local ratName = input[1]
                                        SD.Callback('gglv-dumpsters:server:buyRat', false, function(success)
                                            TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                                        end, ratName)
                                    else
                                        SD.ShowNotification(locale('rat.buy_cancelled'), "error")
                                        TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                                    end
                                end
                            }
                        end
                        options[#options + 1] = {
                            title = locale("hobo.return_to_main_menu"),
                            description = "",
                            icon = 'fas fa-arrow-left',
                            onSelect = function()
                                PedMenu()
                            end
                        }
                        lib.registerContext({
                            id = 'rat_menu',
                            title = locale('rat.menu_title'),
                            options = options,
                            onExit = function()
                                if atKing then
                                    PedMenu()
                                end
                            end
                        })
                        lib.showContext('rat_menu')
                    end)
                    return
                else
                    options[#options + 1] = {
                        title = locale('rat.buy'),
                        description = locale('rat.buy_desc', { price = Config.PriceForRat }),
                        icon = 'fas fa-paw',
                        onSelect = function()
                            local input = lib.inputDialog(locale('rat.name_dialog_title'), { locale('rat.name_dialog_desc') })
                            if input and input[1] then
                                local ratName = input[1]
                                SD.Callback('gglv-dumpsters:server:buyRat', false, function(success)
                                    TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                                end, ratName)
                            else
                                SD.ShowNotification(locale('rat.buy_cancelled'), "error")
                                TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                            end
                        end
                    }
                    options[#options + 1] = {
                        title = locale("hobo.return_to_main_menu"),
                        description = "",
                        icon = 'fas fa-arrow-left',
                        onSelect = function()
                            PedMenu()
                        end
                    }
                    lib.registerContext({
                        id = 'rat_menu',
                        title = locale('rat.menu_title'),
                        options = options,
                        onExit = function()
                            if atKing then
                                PedMenu()
                            end
                        end
                    })
                    lib.showContext('rat_menu')
                    return
                end
            end
        end

        SD.Callback('gglv-dumpsters:server:getServerTime', false, function(serverTime)
            local currentTime = serverTime or 0

            local ratXP = RatData.xp or 0
            local ratLevel = CalculateRatLevel(ratXP)
            local progressPercent = GetRatProgress(ratLevel, ratXP)

            -- Create rat profile option.
            local profileOption = {
                title = locale('rat.profile_title'),
                description = locale('rat.profile_desc', { level = ratLevel, name = RatData.name or locale('rat.unnamed') }),
                icon = 'fas fa-paw',
                iconColor = 'yellow',
                progress = progressPercent,
                colorScheme = 'green',
                readOnly = true
            }
            if RatData.expeditionData and RatData.expeditionData.recovering and RatData.expeditionData.recoveryEndTime then
                local remaining = math.max(0, RatData.expeditionData.recoveryEndTime - currentTime)
                local hours = math.floor(remaining / 3600)
                local minutes = math.floor((remaining % 3600) / 60)
                local seconds = remaining % 60
                profileOption.description = profileOption.description .. "\n" ..
                    locale('rat.profile_recovery_info', { hours = hours, minutes = minutes, seconds = seconds })
            end

            local statsOption = {
                title = locale('rat.stats'),
                description = locale('rat.stats_desc'),
                icon = 'fas fa-chart-bar',
                onSelect = function()
                    OpenRatStatsMenu(RatData, atKing)
                end
            }

            local expeditionActive = false
            local expeditionComplete = false
            local outcome = nil
            if RatData.expeditionData then
                if RatData.expeditionData.active then
                    expeditionActive = true
                else
                    expeditionComplete = true
                    outcome = RatData.expeditionData.outcome or {}
                    if outcome.injured == nil then outcome.injured = false end
                end
            end

            local perksOption = nil
            if expeditionActive then
                perksOption = {
                    title = locale('rat.perks'),
                    description = locale('rat.perks_disabled_desc'),
                    icon = 'fas fa-gem',
                    disabled = true,
                    readOnly = true
                }
            elseif expeditionComplete then
                if outcome.injured then
                    perksOption = {
                        title = locale('rat.perks'),
                        description = locale('rat.perks_injured_desc'),
                        icon = 'fas fa-gem',
                        disabled = true,
                        readOnly = true
                    }
                else
                    perksOption = {
                        title = locale('rat.perks'),
                        description = locale('rat.perks_desc'),
                        icon = 'fas fa-gem',
                        onSelect = function()
                            OpenRatPerksMenu(RatData, atKing)
                        end
                    }
                end
            else
                perksOption = {
                    title = locale('rat.perks'),
                    description = locale('rat.perks_desc'),
                    icon = 'fas fa-gem',
                    onSelect = function()
                        OpenRatPerksMenu(RatData, atKing)
                    end
                }
            end

            local expeditionOption = nil
            local freeOption = nil
            local refreshOption = {
                title = locale('rat.refresh'),
                description = locale('rat.refresh_desc'),
                icon = 'fas fa-sync',
                onSelect = function()
                    TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                end
            }
            local returnOption = {
                title = locale("hobo.return_to_main_menu"),
                description = "",
                icon = 'fas fa-arrow-left',
                onSelect = function()
                    PedMenu()
                end
            }

            if expeditionActive then
                local startTime = RatData.expeditionData.startTime or currentTime
                local endTime = RatData.expeditionData.endTime or currentTime
                local expeditionProgress = 0
                if endTime > startTime then
                    expeditionProgress = math.floor(math.min(100, ((currentTime - startTime) / (endTime - startTime)) * 100))
                end
                local timeLeft = math.max(0, endTime - currentTime)
                local hoursLeft = math.floor(timeLeft / 3600)
                local minutesLeft = math.floor((timeLeft % 3600) / 60)
                local secondsLeft = timeLeft % 60
                expeditionOption = {
                    title = locale('rat.expedition_active'),
                    description = locale('rat.expedition_in_progress', { progress = expeditionProgress, hours = hoursLeft, minutes = minutesLeft, seconds = secondsLeft }),
                    icon = 'fas fa-rocket',
                    progress = expeditionProgress,
                    readOnly = true
                }
                freeOption = {
                    title = locale('rat.free'),
                    description = locale('rat.free_disabled_desc'),
                    icon = 'fas fa-unlock',
                    disabled = true,
                    readOnly = true
                }
                local finalOptions = { profileOption, statsOption, perksOption, expeditionOption, freeOption, refreshOption }
                if atKing then
                    table.insert(finalOptions, returnOption)
                end
                lib.registerContext({
                    id = 'rat_menu',
                    title = locale('rat.menu_title'),
                    options = finalOptions,
                    onExit = function()
                        if atKing then
                            PedMenu()
                        end
                    end
                })
                lib.showContext('rat_menu')
                return
            elseif expeditionComplete then
                local itemCount = 0
                for _, qty in pairs(outcome.loot or {}) do
                    itemCount = itemCount + qty
                end
                if outcome.injured then
                    if RatData.expeditionData.recovering then
                        expeditionOption = {
                            title = locale('rat.expedition_injured_disabled_title'),
                            description = locale('rat.expedition_injured_disabled_desc'),
                            icon = 'fas fa-heart-broken',
                            disabled = true,
                            readOnly = true
                        }
                        freeOption = {
                            title = locale('rat.free'),
                            description = locale('rat.free_injured_desc'),
                            icon = 'fas fa-unlock',
                            disabled = true,
                            readOnly = true
                        }
                    else
                        expeditionOption = {
                            title = locale('rat.expedition_returned_injured_title'),
                            description = locale('rat.expedition_returned_injured_desc', { items = itemCount, recovery = Config.InjuryRecoveryTime or 600 }),
                            icon = 'fas fa-heart-broken',
                            onSelect = function()
                                SD.Callback('gglv-dumpsters:server:claimExpeditionRewards', false, function(success)
                                    if success then
                                        TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                                    else
                                        SD.ShowNotification(locale('rat.error_claiming_rewards'), "error")
                                    end
                                end)
                            end
                        }
                        freeOption = {
                            title = locale('rat.free'),
                            description = locale('rat.free_injured_desc'),
                            icon = 'fas fa-unlock',
                            disabled = true,
                            readOnly = true
                        }
                    end
                else
                    expeditionOption = {
                        title = locale('rat.expedition_returned_title'),
                        description = locale('rat.expedition_returned_desc', { items = itemCount }),
                        icon = 'fas fa-undo',
                        onSelect = function()
                            SD.Callback('gglv-dumpsters:server:claimExpeditionRewards', false, function(success)
                                if success then
                                    TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                                end
                            end)
                        end
                    }
                    freeOption = {
                        title = locale('rat.free'),
                        description = locale('rat.free_desc'),
                        icon = 'fas fa-unlock',
                        onSelect = function()
                            local result = lib.alertDialog({
                                header = locale('rat.free_confirm_title'),
                                content = locale('rat.free_confirm_desc'),
                                centered = true,
                                cancel = true,
                                labels = {
                                    cancel = locale('rat.free_cancel'),
                                    confirm = locale('rat.free_confirm')
                                }
                            })
                            if result == 'confirm' then
                                SD.Callback('gglv-dumpsters:server:freeRat', false, function(success)
                                    if success then
                                        TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                                    else
                                        SD.ShowNotification(locale('rat.error_releasing_rat'), "error")
                                    end
                                end)
                            else
                                TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                            end
                        end
                    }
                end
            else
                expeditionOption = {
                    title = locale('rat.expedition'),
                    description = locale('rat.expedition_desc_main'),
                    icon = 'fas fa-road',
                    onSelect = function()
                        OpenRatExpeditionMenu(RatData, atKing)
                    end
                }
                freeOption = {
                    title = locale('rat.free'),
                    description = locale('rat.free_desc'),
                    icon = 'fas fa-unlock',
                    onSelect = function()
                        local result = lib.alertDialog({
                            header = locale('rat.free_confirm_title'),
                            content = locale('rat.free_confirm_desc'),
                            centered = true,
                            cancel = true,
                            labels = {
                                cancel = locale('rat.free_cancel'),
                                confirm = locale('rat.free_confirm')
                            }
                        })
                        if result == 'confirm' then
                            SD.Callback('gglv-dumpsters:server:freeRat', false, function(success)
                                TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                            end)
                        else
                            TriggerEvent('gglv-dumpsters:client:openRatMenu', atKing)
                        end
                    end
                }
            end

            local finalOptions = { profileOption, statsOption, perksOption, expeditionOption, freeOption, refreshOption }
            if atKing then
                table.insert(finalOptions, returnOption)
            end
            lib.registerContext({
                id = 'rat_menu',
                title = locale('rat.menu_title'),
                options = finalOptions,
                onExit = function()
                    if atKing then
                        PedMenu()
                    end
                end
            })
            lib.showContext('rat_menu')
        end)
    end)
end

RegisterNetEvent('gglv-dumpsters:client:openRatMenu', OpenRatMenu)

if Config.CreateExportForMenu then exports('openRatMenu', OpenRatMenu) end

-- CallRat toggles the rat follow behavior. If a rat is already following, it is shooed away (runs off and despawns once 50 units away); otherwise, the player performs a whistle animation, a rat ped is spawned behind the player and follows them, and an interaction target is added so that when the rat is targeted it "squeaks" its name.
local CallRat = function()
    SD.Callback('gglv-dumpsters:server:getRatData', false, function(RatData)
        if not (RatData and RatData.owned) then
            SD.ShowNotification(locale('rat.no_rat_owned'), "error")
            return
        end

        local playerPed = PlayerPedId()
        if ratFollowPed and DoesEntityExist(ratFollowPed) then
            TaskSmartFleePed(ratFollowPed, playerPed, 50.0, -1, false, false)
            SetTimeout(3000, function()
                if DoesEntityExist(ratFollowPed) then
                    DeleteEntity(ratFollowPed)
                    ratFollowPed = nil
                    SD.ShowNotification(locale('rat.follow_off'), "success")
                end
            end)
        else
            Citizen.SetTimeout(2000, function() ClearPedTasks(playerPed) end)
            local playerPos = GetEntityCoords(playerPed)
            local forwardVector = GetEntityForwardVector(playerPed)
            local spawnPos = playerPos - (forwardVector * 5.0)
            local model = GetHashKey("a_c_rat")
            SD.LoadModel(model)
            ratFollowPed = CreatePed(4, model, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, false)
            SetEntityInvincible(ratFollowPed, true)
            SetBlockingOfNonTemporaryEvents(ratFollowPed, true)
            TaskFollowToOffsetOfEntity(ratFollowPed, playerPed, 0.0, 2.0, 0.0, 1.0, -1, 5.0, true)
            SetModelAsNoLongerNeeded(model)
            SD.ShowNotification(locale('rat.follow_on'), "success")
            local ratName = RatData.name or locale('rat.unnamed')
            SD.Interaction.AddTargetEntity(Config.Interaction, ratFollowPed, {
                distance = 1.5,
                options = {
                    {
                        action = function(entity)
                            SD.ShowNotification(locale('rat.squeak_name', { name = ratName }), "success")
                        end,
                        icon = 'fas fa-music',
                        label = locale('rat.squeak_label')
                    }
                }
            })
            Citizen.CreateThread(function()
                while true do
                    if ratFollowPed and DoesEntityExist(ratFollowPed) then
                        local playerPos = GetEntityCoords(PlayerPedId())
                        local ratPos = GetEntityCoords(ratFollowPed)
                        if #(playerPos - ratPos) > 50 then
                            DeleteEntity(ratFollowPed)
                            ratFollowPed = nil
                            SD.ShowNotification(locale('rat.returned_home'), "success")
                            break
                        end
                    else
                        break
                    end
                    Wait(1000)
                end
            end)
        end
    end)
end

RegisterNetEvent('gglv-dumpsters:client:callRat', CallRat)

if Config.CreateExportForFollow then exports('callRat', CallRat) end

if Config.RegisterCommandForFollow then RegisterCommand('CallRat', CallRat) end
