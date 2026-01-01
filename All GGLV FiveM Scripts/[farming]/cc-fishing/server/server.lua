local QBCore = exports[Config.CoreName]:GetCoreObject()

local debug = Config.Debug
local fishingStatus = {}
local fishCaught = 0
local gameTime = nil
local playerZones = {}
local playerRods = {}
local potentialCatches = {}
local rentedBoats = {}
local activeTreasureHunts = {}
local busyLocations = {}



-- Item Creation


for rodType, _ in pairs(Config.Rods) do
    QBCore.Functions.CreateUseableItem(rodType, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        local playerId = Player.PlayerData.citizenid
        local level, experience = GetFishingLevel(playerId)
        if Config.FishingEquipment[rodType].requireLevelForUse and level < Config.FishingEquipment[rodType].level then
            Notify(source, locale('level_too_low_use', Config.FishingEquipment[rodType].level), 'error')
            return
        end
        UseRod(source, rodType)
    end)
end

QBCore.Functions.CreateUseableItem("fishingnet", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = Player.PlayerData.citizenid
    local level, experience = GetFishingLevel(playerId)
    if Config.FishingEquipment["fishingnet"].requireLevelForUse and level < Config.FishingEquipment["fishingnet"].level then
        Notify(source, locale('level_too_low_use', Config.FishingEquipment["fishingnet"].level), 'error')
        return
    end
    TriggerClientEvent('fishing:client:useFishingNet', source)
end)

QBCore.Functions.CreateUseableItem("bait_shovel", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = Player.PlayerData.citizenid
    local level, experience = GetFishingLevel(playerId)
    if Config.FishingEquipment["bait_shovel"].requireLevelForUse and level < Config.FishingEquipment["bait_shovel"].level then
        Notify(source, locale('level_too_low_use', Config.FishingEquipment["bait_shovel"].level), 'error')
        return
    end
    TriggerClientEvent('fishing:client:useShovel', source)
end)

QBCore.Functions.CreateUseableItem("logbook", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = Player.PlayerData.citizenid
    local level, experience = GetFishingLevel(playerId)
    if Config.FishingEquipment["logbook"].requireLevelForUse and level < Config.FishingEquipment["logbook"].level then
        Notify(source, locale('level_too_low_use', Config.FishingEquipment["logbook"].level), 'error')
        return
    end
    TriggerClientEvent('fishing:client:useLogbook', source)
end)

QBCore.Functions.CreateUseableItem("anchor", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = Player.PlayerData.citizenid
    local level, experience = GetFishingLevel(playerId)
    if Config.FishingEquipment["anchor"].requireLevelForUse and level < Config.FishingEquipment["anchor"].level then
        Notify(source, locale('level_too_low_use', Config.FishingEquipment["anchor"].level), 'error')
        return
    end
    TriggerClientEvent("fishing:client:useAnchor", source)
end)

QBCore.Functions.CreateUseableItem("fishinghat", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local item = Player.Functions.GetItemByName("fishinghat")
    
    if not item then return end

    local playerId = Player.PlayerData.citizenid
    local level, experience = GetFishingLevel(playerId)
    if Config.FishingEquipment["fishinghat"].requireLevelForUse and not level >= Config.FishingEquipment["fishinghat"].level then
        Notify(source, locale('level_too_low_use', Config.FishingEquipment["fishinghat"].level), 'error')
        return
    end

    if Player.PlayerData.metadata["fishinghat"] then
        Player.PlayerData.metadata["fishinghat"] = false
        Player.Functions.SetMetaData("fishinghat", false)
        TriggerClientEvent('fishing:client:toggleFishingHat', source, false)
    else
        Player.PlayerData.metadata["fishinghat"] = true
        Player.Functions.SetMetaData("fishinghat", true)
        TriggerClientEvent('fishing:client:toggleFishingHat', source, true)
    end
end)

QBCore.Functions.CreateUseableItem("treasure_map", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    RemoveItem(source, {
        item = "treasure_map",
        amount = 1
    })
    StartNewTreasureHunt(source)
end)



-- Leveling Logic

function GetFishingLevel(playerId)
    local result = MySQL.Sync.fetchAll('SELECT skill_level, experience FROM fishing_stats WHERE player_id = @playerId', {
        ['@playerId'] = playerId
    })
    if result[1] then
        return result[1].skill_level, result[1].experience
    else
        MySQL.Async.execute('INSERT INTO fishing_stats (player_id, skill_level, experience, logbook) VALUES (@playerId, 1, 0, \'{}\')', {
            ['@playerId'] = playerId
        })
        return 1, 0
    end
end

function UpdateFishingExperience(playerId, expGained)
    if not playerId or not expGained then
        return nil, nil
    end

    local currentLevel, currentExp = GetFishingLevel(playerId)
    if not currentLevel or not currentExp then
        print("Error: Failed to get current fishing level for player " .. playerId)
        return nil, nil
    end

    local newExp = currentExp + expGained
    local newLevel = currentLevel
    
    local expThresholds = Config.LevelThresholds
    
    while newLevel < #expThresholds and newExp >= expThresholds[newLevel + 1] do
        newLevel = newLevel + 1
    end
    
    local success = MySQL.Sync.execute('UPDATE fishing_stats SET skill_level = @skillLevel, experience = @experience WHERE player_id = @playerId', {
        ['@playerId'] = playerId,
        ['@skillLevel'] = newLevel,
        ['@experience'] = newExp
    })

    if not success then
        print("Error: Failed to update fishing skills in database for player " .. playerId)
        return nil, nil
    end
    
    if newLevel > currentLevel then
        Notify(playerId, locale('fishing_level_up', newLevel), 'success')
    end
    
    return newLevel, newExp
end

QBCore.Functions.CreateCallback('fishing:server:getFishingLevelData', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = Player.PlayerData.citizenid
    local level, experience = GetFishingLevel(playerId)

    local expThresholds = Config.LevelThresholds

    local currentLevelExp = expThresholds[level] or 0
    local nextLevelExp = expThresholds[level + 1] or experience

    local progress = 0
    if nextLevelExp and currentLevelExp and nextLevelExp > currentLevelExp then
        progress = math.floor(((experience - currentLevelExp) / (nextLevelExp - currentLevelExp)) * 100)
    end

    cb(level, experience, progress)
end)



-- Tournament Logic

function StartNewTournament()
    local fishTypes = {}
    for fishName, _ in pairs(Config.FishTypes) do
        table.insert(fishTypes, fishName)
    end
    local chosenFish = fishTypes[math.random(#fishTypes)]
    local endTime = os.time() + (Config.TournamentDuration * 24 * 60 * 60)
    
    MySQL.Async.insert('INSERT INTO fishing_tournaments (fish_type, end_time, status) VALUES (@fishType, FROM_UNIXTIME(@endTime), "active")', {
        ['@fishType'] = chosenFish,
        ['@endTime'] = endTime
    }, function(tournamentId)
        if tournamentId > 0 then
            Notify(-1, locale('tournament_started', chosenFish), 'success')
        end
    end)
end

function CheckTournamentStatus()
    MySQL.Async.fetchAll('SELECT *, UNIX_TIMESTAMP(end_time) as end_timestamp FROM fishing_tournaments WHERE status = "active"', {}, function(activeTournaments)
        if #activeTournaments == 0 then
            StartNewTournament()
        else
            MySQL.Async.execute('UPDATE fishing_tournaments SET status = "completed" WHERE status = "active" AND end_time <= NOW()', {}, function(rowsChanged)
                if rowsChanged > 0 then
                    print(rowsChanged .. " tournament(s) marked as completed")
                    for _, tournament in ipairs(activeTournaments) do
                        if os.time() >= tournament.end_timestamp then
                            EndTournament(tournament.id)
                        end
                    end
                end
                
                MySQL.Async.fetchAll('SELECT * FROM fishing_tournaments WHERE status = "active"', {}, function(remainingActiveTournaments)
                    if #remainingActiveTournaments == 0 then
                        Wait(15000)
                        StartNewTournament()
                    end
                end)
            end)
        end
    end)
end

function EndTournament(tournamentId)
    MySQL.Async.fetchAll('SELECT * FROM fishing_tournament_catches WHERE tournament_id = @tournamentId ORDER BY fish_length DESC LIMIT 3', {
        ['@tournamentId'] = tournamentId
    }, function(winners)
        for place, winner in ipairs(winners) do
            local reward = Config.TournamentRewards[place]
            
            if AddMoney(nil, 'tournament_reward', reward, 'fishing-tournament', winner.player_id) then
                local Player = QBCore.Functions.GetPlayerByCitizenId(winner.player_id)
                if Player then
                    Notify(Player.PlayerData.source, locale('tournament_win', place, reward), 'success')
                else
                    print(string.format("Offline player %s won place %d in fishing tournament. Reward: $%d", winner.player_id, place, reward))
                end
            else
                print("Failed to add money to player: " .. winner.player_id)
            end
        end

        MySQL.Async.execute('UPDATE fishing_tournaments SET status = "completed" WHERE id = @tournamentId', {
            ['@tournamentId'] = tournamentId
        }, function(rowsChanged)
            if rowsChanged > 0 then
                Notify(-1, locale('tournament_ended'), 'success')
            else
                print("Failed to update tournament status for tournament " .. tournamentId)
            end

            CheckTournamentStatus()
        end)
    end)
end

RegisterServerEvent('fishing:server:checkTournamentStatus')
AddEventHandler('fishing:server:checkTournamentStatus', function()
    CheckTournamentStatus()
end)

QBCore.Functions.CreateCallback('fishing:server:getCurrentTournamentData', function(source, cb)
    if not Config.Modules.tournaments then
        return cb({}, nil)
    end
    MySQL.Async.fetchAll('SELECT *, UNIX_TIMESTAMP(end_time) as end_timestamp FROM fishing_tournaments WHERE status = "active" AND end_time > NOW() ORDER BY start_time DESC LIMIT 1', {}, function(tournamentInfo)
        if #tournamentInfo > 0 then
            local tournamentId = tournamentInfo[1].id
            local tournamentFishType = tournamentInfo[1].fish_type
            local endTimestamp = tonumber(tournamentInfo[1].end_timestamp)

            MySQL.Async.fetchAll('SELECT *, UNIX_TIMESTAMP(catch_time) as catch_timestamp FROM fishing_tournament_catches WHERE tournament_id = @tournamentId AND fish_type = @fishType ORDER BY fish_length DESC', {
                ['@tournamentId'] = tournamentId,
                ['@fishType'] = tournamentFishType
            }, function(catchesResult)
                local tournamentData = {}
                for i, v in ipairs(catchesResult) do
                    local playerName = locale('unknown_player')
                    local Player = QBCore.Functions.GetPlayerByCitizenId(v.player_id)
                    
                    if Player then
                        playerName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
                    else
                        local OfflinePlayer = QBCore.Player.GetOfflinePlayer(v.player_id)
                        if OfflinePlayer then
                            playerName = OfflinePlayer.PlayerData.charinfo.firstname .. ' ' .. OfflinePlayer.PlayerData.charinfo.lastname
                        end
                    end
                    
                    v.player_name = playerName
                    v.fish_label = GetItemData(v.fish_type) and GetItemData(v.fish_type).label or v.fish_type
                    v.rank = i
                    v.since_catch = formatTimeSinceCatch(tonumber(v.catch_timestamp))
                    table.insert(tournamentData, v)
                end

                local currentTime = os.time()
                local remainingTime = endTimestamp - currentTime
                
                local days = math.floor(remainingTime / (24 * 60 * 60))
                local hours = math.floor((remainingTime % (24 * 60 * 60)) / (60 * 60))
                local minutes = math.floor((remainingTime % (60 * 60)) / 60)

                local tournamentDetails = {
                    fish_type = tournamentInfo[1].fish_type,
                    fish_label = GetItemData(tournamentInfo[1].fish_type) and GetItemData(tournamentInfo[1].fish_type).label or tournamentInfo[1].fish_type,
                    end_time = os.date(Config.DateFormat, endTimestamp),
                    remaining_time = locale('tournament_time_left', days, hours, minutes)
                }

                cb(tournamentData, tournamentDetails)
            end)
        else
            cb({}, nil)
        end
    end)
end)

QBCore.Functions.CreateCallback('fishing:server:getCurrentTournamentDetails', function(source, cb)
    if not Config.Modules.tournaments then
        return cb(nil)
    end
    MySQL.Async.fetchAll('SELECT *, UNIX_TIMESTAMP(end_time) as end_timestamp FROM fishing_tournaments WHERE status = "active" AND end_time > NOW() ORDER BY start_time DESC LIMIT 1', {}, function(tournamentInfo)
        if #tournamentInfo > 0 then
            local tournamentId = tournamentInfo[1].id
            local tournamentFishType = tournamentInfo[1].fish_type
            local endTimestamp = tonumber(tournamentInfo[1].end_timestamp)

            local currentTime = os.time()
            local remainingTime = endTimestamp - currentTime
            
            local days = math.floor(remainingTime / (24 * 60 * 60))
            local hours = math.floor((remainingTime % (24 * 60 * 60)) / (60 * 60))
            local minutes = math.floor((remainingTime % (60 * 60)) / 60)

            local tournamentDetails = {
                fish_label = GetItemData(tournamentInfo[1].fish_type) and GetItemData(tournamentInfo[1].fish_type).label or tournamentInfo[1].fish_type,
                remaining_time = locale('tournament_time_left', days, hours, minutes)
            }
            cb(tournamentDetails)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback('fishing:server:getPreviousTournamentResults', function(source, cb)
    MySQL.Async.fetchAll('SELECT *, UNIX_TIMESTAMP(end_time) as end_timestamp FROM fishing_tournaments WHERE status = "completed" ORDER BY end_time DESC LIMIT 10', {}, function(tournaments)
        local formattedResults = {}
        for _, tournament in ipairs(tournaments) do
            MySQL.Async.fetchAll('SELECT * FROM fishing_tournament_catches WHERE tournament_id = @tournamentId ORDER BY fish_length DESC LIMIT 10', {
                ['@tournamentId'] = tournament.id
            }, function(catches)
                local currentTournament = {
                    fish_type = tournament.fish_type,
                    fish_label = GetItemData(tournament.fish_type) and GetItemData(tournament.fish_type).label or tournament.fish_type,
                    end_timestamp = os.date(Config.DateFormat, tournament.end_timestamp),
                    results = {}
                }

                for _, catch in ipairs(catches) do
                    local playerName = locale('unknown_player')
                    local Player = QBCore.Functions.GetPlayerByCitizenId(catch.player_id)
                    
                    if Player then
                        playerName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
                    else
                        local OfflinePlayer = QBCore.Player.GetOfflinePlayer(catch.player_id)
                        if OfflinePlayer then
                            playerName = OfflinePlayer.PlayerData.charinfo.firstname .. ' ' .. OfflinePlayer.PlayerData.charinfo.lastname
                        end
                    end

                    table.insert(currentTournament.results, {
                        player_name = playerName,
                        fish_length = catch.fish_length
                    })
                end

                table.insert(formattedResults, currentTournament)

                if #formattedResults == #tournaments then
                    cb(formattedResults)
                end
            end)
        end

        if #tournaments == 0 then
            cb({})
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(60000)
        CheckTournamentStatus()
    end
end)



-- Challenge Logic

RegisterNetEvent('fishing:server:RequestDailyChallenges')
AddEventHandler('fishing:server:RequestDailyChallenges', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        GeneratePlayerDailyChallenges(Player.PlayerData.citizenid)
    end
end)

function GeneratePlayerDailyChallenges(playerId)
    local date = os.date("%Y-%m-%d")
    
    MySQL.Async.fetchAll('SELECT * FROM fishing_challenges WHERE player_id = @playerId AND date = @date', {
        ['@playerId'] = playerId,
        ['@date'] = date
    }, function(result)
        if #result == 0 then
            local challenges = {}
            local allChallenges = table.deepcopy(Config.DailyChallenges)
            
            for i = 1, 3 do
                if #allChallenges > 0 then
                    local index = math.random(1, #allChallenges)
                    local challenge = allChallenges[index]
                    table.insert(challenges, challenge)
                    table.remove(allChallenges, index)
                    
                    MySQL.Async.execute('INSERT INTO fishing_challenges (player_id, challenge_id, date) VALUES (@playerId, @challengeId, @date)', {
                        ['@playerId'] = playerId,
                        ['@challengeId'] = challenge.id,
                        ['@date'] = date
                    })
                end
            end
            
            TriggerClientEvent('fishing:client:receiveDailyChallenges', playerId, challenges)
        else
            -- Challenges already exist, send them to the client
            TriggerClientEvent('fishing:client:receiveDailyChallenges', playerId, FormatChallenges(result))
        end
    end)
end

function FormatChallenges(dbChallenges)
    local formattedChallenges = {}
    for _, dbChallenge in ipairs(dbChallenges) do
        for _, configChallenge in ipairs(Config.DailyChallenges) do
            if configChallenge.id == dbChallenge.challenge_id then
                table.insert(formattedChallenges, {
                    id = configChallenge.id,
                    description = configChallenge.description,
                    requiredAmount = configChallenge.requiredAmount,
                    reward = configChallenge.reward,
                    progress = tonumber(dbChallenge.progress),
                    completed = dbChallenge.completed == 1 or dbChallenge.completed == true or dbChallenge.completed == 'true',
                    rewarded = dbChallenge.rewarded == 1 or dbChallenge.rewarded == true or dbChallenge.rewarded == 'true'
                })
                break
            end
        end
    end
    return formattedChallenges
end

local function DeleteOldChallenges(playerId)
    local today = os.date("%Y-%m-%d")
    
    MySQL.Async.execute('DELETE FROM fishing_challenges WHERE player_id = @playerId AND date < @today', {
        ['@playerId'] = playerId,
        ['@today'] = today
    }, function(rowsAffected)
        if rowsAffected > 0 then
            print(string.format("Deleted %d old challenges for player %s", rowsAffected, playerId))
        end
    end)
end

function UpdateChallengeProgress(playerId, fishType, fishCategory, fishLength, earnings, isCatching)
    local date = os.date("%Y-%m-%d")
    
    MySQL.Async.fetchAll('SELECT * FROM fishing_challenges WHERE player_id = @playerId AND date = @date', {
        ['@playerId'] = playerId,
        ['@date'] = date
    }, function(result)
        for _, challenge in ipairs(result) do
            local configChallenge = nil
            for _, cfg in ipairs(Config.DailyChallenges) do
                if cfg.id == challenge.challenge_id then
                    configChallenge = cfg
                    break
                end
            end
            
            if configChallenge then
                
                local shouldUpdate = false
                local updateAmount = 1

                if isCatching then
                    if configChallenge.fishType and configChallenge.fishType == fishType then
                        shouldUpdate = true
                    elseif configChallenge.fishCategory and configChallenge.fishCategory == fishCategory then
                        shouldUpdate = true
                    elseif not configChallenge.fishType and not configChallenge.fishCategory and not configChallenge.specialCondition then
                        shouldUpdate = true
                    elseif configChallenge.specialCondition then
                        if type(configChallenge.specialCondition) == "function" then
                            local success, result = pcall(function()
                                return configChallenge.specialCondition({type = fishType, category = fishCategory, length = fishLength})
                            end)
                            if success then
                                shouldUpdate = result
                            else
                                print("Error in special condition function:", result)
                            end
                        elseif configChallenge.specialCondition == "atNight" then
                            shouldUpdate = (gameTime >= 22 or gameTime < 6)
                        end
                    end
                else
                    if configChallenge.specialCondition == "earnings" and earnings then
                        shouldUpdate = true
                        updateAmount = earnings
                    end
                end
                
                if shouldUpdate then
                    local newProgress = challenge.progress + updateAmount
                    local completed = newProgress >= configChallenge.requiredAmount
                    
                    MySQL.Async.execute('UPDATE fishing_challenges SET progress = @progress, completed = @completed WHERE id = @id', {
                        ['@progress'] = newProgress,
                        ['@completed'] = completed and 1 or 0,
                        ['@id'] = challenge.id
                    })
                    
                    TriggerClientEvent('fishing:client:updateChallengeProgress', playerId, challenge.challenge_id, newProgress, completed)
                end
            end
        end
    end)
end

function CollectChallengeReward(source, playerId, challengeId)
    local Player = QBCore.Functions.GetPlayer(source)
    local date = os.date("%Y-%m-%d")
    MySQL.Async.fetchAll('SELECT * FROM fishing_challenges WHERE player_id = @playerId AND challenge_id = @challengeId AND date = @date', {
        ['@playerId'] = playerId,
        ['@challengeId'] = challengeId,
        ['@date'] = date
    }, function(result)
        if #result > 0 and result[1].completed == true and result[1].rewarded == false then
            local challenge = nil
            for _, cfg in ipairs(Config.DailyChallenges) do
                if cfg.id == challengeId then
                    challenge = cfg
                    break
                end
            end
            if challenge then
                AddMoney(source, 'challenge_reward', challenge.reward, 'fishing-reward')
                
                MySQL.Async.execute('UPDATE fishing_challenges SET rewarded = 1 WHERE id = @id', {
                    ['@id'] = result[1].id
                })
                
                Notify(playerId, locale('collect_reward', challenge.reward), 'success')
                TriggerClientEvent('fishing:client:challengeRewarded', playerId, challengeId)
            end
        else
            Notify(playerId, locale('unable_to_collect'), 'error')
        end
    end)
end

QBCore.Functions.CreateCallback('fishing:server:getDailyChallenges', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb({}) end

    local playerId = Player.PlayerData.citizenid
    local date = os.date("%Y-%m-%d")
    local challenges = {}

    DeleteOldChallenges(playerId)

    MySQL.Async.fetchAll('SELECT * FROM fishing_challenges WHERE player_id = @playerId AND date = @date', {
        ['@playerId'] = playerId,
        ['@date'] = date
    }, function(result)
        if #result == 0 then
            local allChallenges = table.deepcopy(Config.DailyChallenges)
            for i = 1, 3 do
                if #allChallenges > 0 then
                    local index = math.random(1, #allChallenges)
                    local challenge = allChallenges[index]
                    table.insert(challenges, challenge)
                    table.remove(allChallenges, index)
                    
                    MySQL.Async.execute('INSERT INTO fishing_challenges (player_id, challenge_id, date) VALUES (@playerId, @challengeId, @date)', {
                        ['@playerId'] = playerId,
                        ['@challengeId'] = challenge.id,
                        ['@date'] = date
                    })
                end
            end
        else
            for _, challenge in ipairs(result) do
                for _, configChallenge in ipairs(Config.DailyChallenges) do
                    if configChallenge.id == challenge.challenge_id then
                        local challengeData = {
                            id = configChallenge.id,
                            description = configChallenge.description,
                            requiredAmount = configChallenge.requiredAmount,
                            reward = configChallenge.reward,
                            progress = tonumber(challenge.progress),
                            completed = challenge.completed == 1 or challenge.completed == true or challenge.completed == 'true',
                            rewarded = challenge.rewarded == 1 or challenge.rewarded == true or challenge.rewarded == 'true'
                        }
                        table.insert(challenges, challengeData)
                        break
                    end
                end
            end
        end
        
        cb(challenges)
    end)
end)

RegisterNetEvent('fishing:server:collectChallengeReward')
AddEventHandler('fishing:server:collectChallengeReward', function(challengeId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        CollectChallengeReward(src, Player.PlayerData.citizenid, challengeId)
    end
end)



-- Fishing Logic

function UseRod(source, rodType)
    local Player = QBCore.Functions.GetPlayer(source)
    local rodItem = Player.Functions.GetItemByName(rodType)

    if debug then print("[DEBUG] 616 - UseRod", json.encode(rodItem)) end
    
    if rodItem and not rodItem.info or not rodItem.info.rod_durability then
        SetItemData(source, {
            slot = rodItem.slot,
            key = "rod_durability",
            val = Config.Rods[rodType].durability
        })
    end

    if fishingStatus[source] then
        fishingStatus[source] = false
        playerRods[source] = nil
        TriggerClientEvent('fishing:client:stopFishing', source)
    else
        playerRods[source] = rodType
        TriggerClientEvent("fishing:client:getGameTime", source, rodType)
    end
end

function updateRodDurability(source, rodType)
    local Player = QBCore.Functions.GetPlayer(source)
    local rodItem = Player.Functions.GetItemByName(rodType)
    
    if rodItem then
        if debug then print("[DEBUG] 641 - updateRodDurability", json.encode(rodItem)) end
        local currentDurability = rodItem.info.rod_durability or Config.Rods[rodType].durability
        local newDurability = math.max(0, currentDurability - 1)
        
        if rodItem.info.rod_durability == nil then
            SetItemData(source, {
                slot = rodItem.slot,
                key = "rod_durability",
                val = newDurability
            })
        end

        SetItemData(source, {
            slot = rodItem.slot,
            key = "rod_durability",
            val = newDurability
        })
        
        if newDurability == 0 then
            RemoveItem(source, {
                item = rodType,
                amount = 1,
                slot = rodItem.slot
            })
            Notify(source, locale('rod_broken'), "error")
            return false
        elseif newDurability <= 10 then
            Notify(source, locale('rod_worn'), "error")
        end
    end
    return true
end

function getFishType(baitPower, rodType)
    local hour = gameTime
    local availableFish = {}
    local inZone = false
    local zoneMultiplier = 1

    for _, zone in ipairs(Config.Zones) do
        if zone.name == playerZones[source] then
            inZone = true
            zoneMultiplier = zone.zoneMultiplier
            zoneBlacklist = zone.fishBlacklist
            break
        end
    end

    local rodConfig = Config.Rods[rodType] or {}
    local rodFish = rodConfig.fish or {}
    local rodMultiplier = rodConfig.catchMultiplier or 1
    local blacklistedFish = rodConfig.blacklistedFish or {}

    for fishName, fishData in pairs(Config.FishTypes) do
        if hour >= fishData.startHour and hour < fishData.endHour and not table.contains(blacklistedFish, fishName) and not (zoneBlacklist and table.contains(zoneBlacklist, fishName)) then
            local catchChance = 100  -- Base catch chance of 100%
            
            if inZone and table.contains(zone.fishBoost, fishName) then
                catchChance = catchChance * zoneMultiplier
            end
            if table.contains(rodFish, fishName) then
                catchChance = catchChance * rodMultiplier
            end
            
            if fishData.rarity <= baitPower then
                table.insert(availableFish, {
                    name = fishName, 
                    data = {
                        rarity = fishData.rarity,
                        catchChance = catchChance
                    }
                })
            end
        end
    end

    if #availableFish == 0 then
        return nil
    else
        table.sort(availableFish, function(a, b) return a.data.rarity < b.data.rarity end)

        local totalWeight = 0
        for _, fish in ipairs(availableFish) do
            totalWeight = totalWeight + (fish.data.catchChance / fish.data.rarity)
        end
        
        local randomValue = math.random() * totalWeight
        local currentWeight = 0
        
        for _, fish in ipairs(availableFish) do
            currentWeight = currentWeight + (fish.data.catchChance / fish.data.rarity)
            if randomValue <= currentWeight then
                return fish.name
            end
        end
        
        return availableFish[1].name  -- Fallback in case of any issues
    end
end

function calculateFishRarity(fishLength, minLength, maxLength)
    local range = maxLength - minLength
    local normalizedLength = (fishLength - minLength) / range
    
    local rarity = math.floor((normalizedLength ^ 1.5) * 100)
    
    if rarity < 50 then
        rarity = math.floor(rarity * 0.7)
    else
        rarity = math.floor(50 + (rarity - 50) * 1.5)
    end
    
    return math.max(1, math.min(rarity, 99))
end

function CalculateWaitTime(skillLevel, baitWaitMultiplier, hasLuckyHat)
    local luckBoost = hasLuckyHat and Config.FishingEquipment.fishinghat.luckBoost or 0
    local baseWaitTime = math.random(Config.FishingWaitTime.min, Config.FishingWaitTime.max)
    local waitTimeReduction = skillLevel * Config.FishingWaitTimeReduction
    local waitTime = ((baseWaitTime - waitTimeReduction) * baitWaitMultiplier) * ((100 - luckBoost) / 100)
    return math.max(Config.FishingMinWaitTime, waitTime) * 1000
end

function generateFishLength(minLength, maxLength)
    local range = maxLength - minLength
    local r = math.random()
    local beta = r ^ 3
    local fishLength = minLength + (beta * range)
    return math.floor(fishLength * 100) / 100
end

function getDifficultyFromFishType(fishType)
    local fishData = Config.FishTypes[fishType]
    if fishData then
        for _, category in ipairs(Config.FishCategories) do
            if category.name == fishData.category then
                return category.difficulty
            end
        end
    end
    return 1
end

RegisterNetEvent("fishing:server:receiveGameTime")
AddEventHandler("fishing:server:receiveGameTime", function(hour, zone, rodType)
    local source = source
    fishingStatus[source] = true
    gameTime = hour
    playerZones[source] = zone
    playerRods[source] = rodType
end)

function startFishing(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local rodType = playerRods[source] or "fishingrod"

    potentialCatches[source] = nil

    if not HasItem(source, rodType, 1) then
        Notify(source, locale('rod_needed'), "error")
        return
    end

    if not updateRodDurability(source, rodType) then
        fishingStatus[source] = false
        playerRods[source] = nil
        return
    end

    local rodConfig = Config.Rods[rodType]
    local breakChance = rodConfig.breakChance or 0.0

    if Config.RandomRodBreak and (breakChance > 0 and math.random() < breakChance) then
        RemoveItem(source, {
            item = rodType,
            amount = 1
        })
        Notify(source, locale('rod_broke_casting'), "error")
        TriggerClientEvent('fishing:client:stopFishing', source)
        fishingStatus[source] = false
        playerRods[source] = nil
        return
    end

    local hasBait = false
    local baitPower = 0
    local baitWaitMultiplier = 1.5
    local isTreasureHunterBait = false

    for _, baitType in ipairs(Config.BaitTypes) do
        if HasItem(source, baitType.name, 1) then
            hasBait = true
            baitPower = baitType.power
            baitWaitMultiplier = baitType.waitTimeMultiplier
            isTreasureHunterBait = baitType.isTreasureHunterBait or false
            RemoveItem(source, {item = baitType.name, amount = 1})
            break
        end
    end

    if not hasBait then
        Notify(source, locale('bait_needed'), "error")
        Wait(500)
        TriggerClientEvent('fishing:client:stopFishing', source)
        fishingStatus[source] = false
        playerRods[source] = nil
        return
    end

    local playerId = Player.PlayerData.citizenid
    local fishingSkillLevel, _ = GetFishingLevel(playerId)
    local hasLuckyHat = Player.PlayerData.metadata["fishinghat"] or false
    local treasureChance = Config.BaseTreasureChance + (fishingSkillLevel * Config.TreasureChancePerLevel)

    for _, zone in ipairs(Config.Zones) do
        if zone.name == playerZones[source] then
            inZone = true
            if zone.treasureMultiplier then 
                treasureChance = treasureChance * zone.treasureMultiplier
            end
            break
        end
    end

    if isTreasureHunterBait then
        treasureChance = treasureChance * Config.TreasureHunterBaitBonus
    end

    local waitTime = CalculateWaitTime(fishingSkillLevel, baitWaitMultiplier, hasLuckyHat)

    local attemptId = os.time() .. source
    potentialCatches[source] = {
        id = attemptId,
        fishType = getFishType(baitPower, rodType),
        treasure = (math.random() < (treasureChance / 100)) and GetRandomTreasure() or nil
    }

    SetTimeout(waitTime, function()
        if fishingStatus[source] and potentialCatches[source] and potentialCatches[source].id == attemptId then
            local difficulty = getDifficultyFromFishType(potentialCatches[source].fishType)
            local timeLimit = Config.MinigameTime
            if HasItem(source, "illegal_hook") then
                timeLimit = timeLimit + Config.IllegalHookTime
            end

            TriggerClientEvent("fishing:client:fishBite", source, difficulty, timeLimit, attemptId)
        end
    end)

    fishingStatus[source] = true
end

function GetRandomTreasure()
    local totalChance = 0
    for _, treasure in ipairs(Config.Treasures) do
        totalChance = totalChance + treasure.chance
    end

    local roll = math.random() * totalChance
    local currentSum = 0

    for _, treasure in ipairs(Config.Treasures) do
        currentSum = currentSum + treasure.chance
        if roll <= currentSum then
            return treasure
        end
    end

    return Config.Treasures[1]
end

RegisterNetEvent("fishing:server:startFishing")
AddEventHandler("fishing:server:startFishing", function()
    local source = source
    startFishing(source)
end)

RegisterNetEvent("fishing:server:fishingResult")
AddEventHandler("fishing:server:fishingResult", function(success, attemptId)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        print("Error: Player not found for source " .. source)
        return
    end

    if not fishingStatus[source] or not potentialCatches[source] or potentialCatches[source].id ~= attemptId then return end

    local playerId = Player.PlayerData.citizenid
    local rodType = playerRods[source] or "fishingrod"

    if not updateRodDurability(source, rodType) then
        fishingStatus[source] = false
        playerRods[source] = nil
        TriggerClientEvent('fishing:client:stopFishing', source)
        return
    end

    fishingStatus[source] = false
    playerRods[source] = nil

    if success then
        local potentialCatch = potentialCatches[source]
        if not potentialCatch then
            print("No potential catch found for player " .. playerId)
            return
        end

        local fishType = potentialCatch.fishType
        local treasure = potentialCatch.treasure

        if fishType and Config.FishTypes[fishType] then
            local fishData = Config.FishTypes[fishType]
            local fishLength = generateFishLength(fishData.minLength, fishData.maxLength)
            local fishRarity = calculateFishRarity(fishLength, fishData.minLength, fishData.maxLength)

            local info = {
                length = fishLength,    -- Store the raw value for calculations
                rarity = fishRarity     -- Store the raw value for calculations
            }
            
            if Config.Inventory == "ox" then
                info.format_length = string.format("%.2f\"", fishLength)
                info.format_rarity = string.format("%d%%", fishRarity)
            end
            
            if treasure then
                Notify(source, locale('treasure_discovered', GetItemData(treasure.item).label), "success")
                AddItem(source, {
                    item = treasure.item,
                    amount = 1
                })
            end

            AddItem(source, {
                item = fishType,
                amount = 1,
                info = info
            })

            updateLogbook(playerId, fishType, fishLength)
            updateFishingLeaderboard(playerId, fishType, fishLength)
            UpdateChallengeProgress(playerId, fishType, Config.FishTypes[fishType].category, fishLength, false, true)
            
            local expGained = Config.FishTypes[fishType].expGain or 10
            local newLevel, newExp = UpdateFishingExperience(playerId, expGained)

            if not newLevel or not newExp then
                print("Error: Failed to update fishing experience for player " .. playerId)
                return
            end
            
            TriggerClientEvent('fishing:client:updateExperience', source, newLevel, newExp)

            Notify(source, locale('fish_caught', GetItemData(fishType).label), "success")
        else
            Notify(source, locale('fish_nothing'), "error")
        end
    else
        Notify(source, locale('fish_got_away'), "error")
    end

    potentialCatches[source] = nil
    TriggerClientEvent("fishing:client:stopFishing", source)
end)

RegisterNetEvent("fishing:server:stopFishing")
AddEventHandler("fishing:server:stopFishing", function()
    local source = source
    fishingStatus[source] = false
    playerRods[source] = nil
    potentialCatches[source] = nil
end)



-- Miscellanous

function DigForBait(source, groundHash)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    if math.random(100) > Config.DiggingChance then
        Notify(source, locale('no_bait_found'), "error")
        return
    end

    local totalRarity = 0
    for _, bait in ipairs(Config.BaitTypes) do
        local adjustedRarity = bait.rarity
        if bait.bestSoil == groundHash then
            adjustedRarity = adjustedRarity * Config.BestSoilBonus
        end
        totalRarity = totalRarity + adjustedRarity
    end

    local randomNumber = math.random(totalRarity)
    local cumulativeRarity = 0

    for _, bait in ipairs(Config.BaitTypes) do
        local adjustedRarity = bait.rarity
        if bait.bestSoil == groundHash then
            adjustedRarity = adjustedRarity * Config.BestSoilBonus
        end
        cumulativeRarity = cumulativeRarity + adjustedRarity
        if randomNumber <= cumulativeRarity then
            local amount = math.random(bait.minAmount, bait.maxAmount)
            AddItem(source, {
                item = bait.name,
                amount = amount
            })
            Notify(source, locale('bait_found', amount, GetItemData(bait.name).label), "success")
            return
        end
    end
end

RegisterNetEvent("fishing:server:digForBait")
AddEventHandler("fishing:server:digForBait", function(groundHash)
    DigForBait(source, groundHash)
end)

RegisterNetEvent('fishing:server:updateFishingHatMetadata')
AddEventHandler('fishing:server:updateFishingHatMetadata', function(isWearing)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        Player.PlayerData.metadata["fishinghat"] = isWearing
        Player.Functions.SetMetaData("fishinghat", isWearing)
    end
end)



-- Logbook Logic

function updateLogbook(playerId, fishType, fishLength)
    MySQL.Async.fetchAll('SELECT logbook FROM fishing_stats WHERE player_id = @playerId', {
        ['@playerId'] = playerId
    }, function(result)
        if result[1] then
            local logbook = json.decode(result[1].logbook)
            if not logbook[fishType] then
                logbook[fishType] = {count = 0, max_length = 0}
            end
            logbook[fishType].count = logbook[fishType].count + 1
            logbook[fishType].max_length = math.max(logbook[fishType].max_length, fishLength)
            
            MySQL.Async.execute('UPDATE fishing_stats SET logbook = @logbook WHERE player_id = @playerId', {
                ['@playerId'] = playerId,
                ['@logbook'] = json.encode(logbook)
            })
        else
            local logbook = {}
            logbook[fishType] = {count = 1, max_length = fishLength}
            MySQL.Async.execute('INSERT INTO fishing_stats (player_id, logbook) VALUES (@playerId, @logbook)', {
                ['@playerId'] = playerId,
                ['@logbook'] = json.encode(logbook)
            })
        end
    end)
end

QBCore.Functions.CreateCallback('fishing:server:getLogbookData', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = Player.PlayerData.citizenid

    MySQL.Async.fetchAll('SELECT logbook FROM fishing_stats WHERE player_id = @playerId', {
        ['@playerId'] = playerId
    }, function(result)
        if result[1] and result[1].logbook then
            local logbook = json.decode(result[1].logbook)
            local formattedLogbook = {}
            for fishType, data in pairs(logbook) do
                table.insert(formattedLogbook, {
                    fish_type = fishType,
                    count = data.count,
                    max_length = data.max_length
                })
            end
            cb(formattedLogbook)
        else
            cb({})
        end
    end)
end)



-- Leaderboard Logic

function updateFishingLeaderboard(playerId, fishType, fishLength)
    MySQL.Async.fetchAll('SELECT * FROM fishing_leaderboard WHERE fish_type = @fishType', {
        ['@fishType'] = fishType
    }, function(result)
        if result[1] then
            if fishLength > result[1].fish_length then
                MySQL.Async.execute('UPDATE fishing_leaderboard SET fish_length = @fishLength, catch_time = CURRENT_TIMESTAMP WHERE fish_type = @fishType', {
                    ['@fishType'] = fishType,
                    ['@fishLength'] = fishLength
                })
            end
        else
            MySQL.Async.insert('INSERT INTO fishing_leaderboard (player_id, fish_type, fish_length) VALUES (@playerId, @fishType, @fishLength)', {
                ['@playerId'] = playerId,
                ['@fishType'] = fishType,
                ['@fishLength'] = fishLength
            })
        end
    end)

    MySQL.Async.fetchAll('SELECT * FROM fishing_leaderboard WHERE player_id = @playerId AND fish_type = @fishType', {
        ['@playerId'] = playerId,
        ['@fishType'] = fishType
    }, function(result)
        if result[1] then
            if fishLength > result[1].fish_length then
                Notify(playerId, locale('new_pb', fishType, fishLength), 'success')
            end
        end
    end)

    if Config.RecordNotifyAll then
        MySQL.Async.fetchAll('SELECT * FROM fishing_leaderboard WHERE fish_type = @fishType ORDER BY fish_length DESC LIMIT 1', {
            ['@fishType'] = fishType
        }, function(result)
            if result[1] then
                if fishLength > result[1].fish_length then
                    Notify(-1, locale('new_record', fishType, fishLength), 'success')
                end
            end
        end)
    end

    MySQL.Async.fetchAll('SELECT id, fish_type FROM fishing_tournaments WHERE end_time > NOW() ORDER BY start_time DESC LIMIT 1', {}, function(tournamentResult)
        if #tournamentResult > 0 and tournamentResult[1].fish_type == fishType then
            local tournamentId = tournamentResult[1].id
            MySQL.Async.insert('INSERT INTO fishing_tournament_catches (player_id, fish_type, fish_length, tournament_id) VALUES (@playerId, @fishType, @fishLength, @tournamentId)', {
                ['@playerId'] = playerId,
                ['@fishType'] = fishType,
                ['@fishLength'] = fishLength,
                ['@tournamentId'] = tournamentId
            })
        end
    end)
end

QBCore.Functions.CreateCallback('fishing:server:getLeaderboardData', function(source, cb, page)
    local allTimeData = {}
    page = page > 0 and page or 1
    MySQL.Async.fetchAll('SELECT * FROM fishing_leaderboard ORDER BY fish_length DESC LIMIT ? OFFSET ?', {Config.EntriesPerPage.leaderboard, ((page*Config.EntriesPerPage.leaderboard)-Config.EntriesPerPage.leaderboard)}, function(allTimeResult)
        for i, v in ipairs(allTimeResult) do
            local playerName = locale('unknown_player')
            local Player = QBCore.Functions.GetPlayerByCitizenId(v.player_id)
            
            if Player then
                playerName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
            else
                local OfflinePlayer = QBCore.Player.GetOfflinePlayer(v.player_id)
                if OfflinePlayer then
                    playerName = OfflinePlayer.PlayerData.charinfo.firstname .. ' ' .. OfflinePlayer.PlayerData.charinfo.lastname
                end
            end
            
            v.player_name = playerName
            
            local item = GetItemData(v.fish_type)
            v.fish_label = item and item.label or v.fish_type

            table.insert(allTimeData, v)
        end

        cb(allTimeData)
    end)
end)



-- Helper Functions

function formatTimeSinceCatch(catchTimestamp)
    local currentTime = os.time()
    local timeDiff = currentTime - catchTimestamp

    local days = math.floor(timeDiff / (24 * 60 * 60))
    local hours = math.floor((timeDiff % (24 * 60 * 60)) / (60 * 60))
    local minutes = math.floor((timeDiff % (60 * 60)) / 60)

    local result = ""
    if days > 0 then
        result = locale('days', days)
        if hours > 0 or minutes > 0 then
            result = result .. ", " .. locale('hours', hours)
        end
        if minutes > 0 then
            result = result .. ", " .. locale('minutes', minutes)
        end
    elseif hours > 0 then
        result = locale('hours', hours)
        if minutes > 0 then
            result = result .. ", " .. locale('minutes', minutes)
        end
    else
        result = locale('minutes', minutes)
    end

    return result .. " " .. locale('ago')
end

function GetTreasureConfig(itemName)
    for _, treasure in ipairs(Config.Treasures) do
        if treasure.item == itemName then
            return treasure
        end
    end
    return nil
end

function table.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[table.deepcopy(orig_key)] = table.deepcopy(orig_value)
        end
        setmetatable(copy, table.deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end



-- Treasure Logic

function StartNewTreasureHunt(source)
    local availableLocations = GetAvailableTreasureLocations()
    if #availableLocations == 0 then
        Notify(source, locale('no_available_locations'), "error")
        return
    end

    local safeLocation = availableLocations[math.random(#availableLocations)]
    local huntId = GenerateUniqueHuntId()

    local offsetX = math.random(-50, 50)
    local offsetY = math.random(-50, 50)
    local blipCoords = vector3(safeLocation.x + offsetX, safeLocation.y + offsetY, safeLocation.z)

    activeTreasureHunts[huntId] = {
        location = safeLocation,
        blipCoords = blipCoords,
        startTime = os.time()
    }
    busyLocations[GetLocationKey(safeLocation)] = true

    TriggerClientEvent("fishing:client:startTreasureHunt", source, huntId, safeLocation, blipCoords)
end

function GetAvailableTreasureLocations()
    local available = {}
    for _, location in ipairs(Config.TreasureSafeLocations) do
        if not busyLocations[GetLocationKey(location)] then
            table.insert(available, location)
        end
    end
    return available
end

function GetLocationKey(location)
    return string.format("%.2f,%.2f,%.2f", location.x, location.y, location.z)
end

function GenerateUniqueHuntId()
    return os.time() .. math.random(1000, 9999)
end

QBCore.Functions.CreateCallback('fishing:server:getPawnshopItems', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local pawnshopItems = {}

    local treasureItems = {}
    for _, treasure in ipairs(Config.Treasures) do
        table.insert(treasureItems, treasure.item)
    end

    local items = GetItems(source, treasureItems)

    if Config.Inventory == "ox" then
        for _, slot in pairs(items) do
            for _, item in ipairs(slot) do
                if item and item.name then
                    local treasureConfig = GetTreasureConfig(item.name)
                    if treasureConfig then
                        table.insert(pawnshopItems, {
                            name = item.name,
                            amount = item.count,
                            info = item.metadata,
                            label = GetItemData(item.name).label,
                            description = GetItemData(item.name).description,
                            price = treasureConfig.price or 100,
                            slot = item.slot
                        })
                    end
                end
            end
        end
    else
        for _, items in pairs(items) do
            for _, item in ipairs(items) do
                if item and item.name then
                    local treasureConfig = GetTreasureConfig(item.name)
                    if treasureConfig then
                        table.insert(pawnshopItems, {
                            name = item.name,
                            amount = item.amount,
                            info = item.info,
                            label = GetItemData(item.name).label,
                            description = GetItemData(item.name).description,
                            price = treasureConfig.price or 100,
                            slot = item.slot
                        })
                    end
                end
            end
        end
    end

    cb(pawnshopItems)
end)

RegisterNetEvent('fishing:server:sellAllTreasures')
AddEventHandler('fishing:server:sellAllTreasures', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalEarnings = 0

    for _, treasure in ipairs(Config.Treasures) do
        local item = Player.Functions.GetItemByName(treasure.item)
        if item then
            local price = treasure.price or 100 -- Default price if not specified
            local earnings = price * item.amount
            Player.Functions.RemoveItem(item.name, item.amount)
            totalEarnings = totalEarnings + earnings
        end
    end

    if totalEarnings > 0 then
        AddMoney(src, 'sell_treasure', totalEarnings, 'fishing-sellalltreasure')
        Notify(src, locale('treasures_sold_all', totalEarnings), 'success')
    else
        Notify(src, locale('no_treasures_to_sell'), 'error')
    end
end)

RegisterNetEvent('fishing:server:sellTreasure')
AddEventHandler('fishing:server:sellTreasure', function(itemName, amount, price, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.Functions.RemoveItem(itemName, amount, slot) then
        local totalPrice = price * amount
        AddMoney(src, 'sell_treasure', totalPrice, 'fishing-selltreasure')
        Notify(src, locale('treasure_sold', amount, GetItemData(itemName).label, totalPrice), 'success')
    else
        Notify(src, locale('treasure_sale_failed'), 'error')
    end
end)

function GetSafeCoordinatesWithinRadius(center, radius)
    local angle = math.random() * 2 * math.pi
    local distance = math.sqrt(math.random()) * radius
    local x = center.x + distance * math.cos(angle)
    local y = center.y + distance * math.sin(angle)
    local z = center.z - math.random(1, 5)
    return vector3(x, y, z)
end

RegisterServerEvent('fishing:server:claimTreasureLoot')
AddEventHandler('fishing:server:claimTreasureLoot', function(huntId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local lootClaimed = false

    if activeTreasureHunts[huntId] then
        for _, lootItem in ipairs(Config.TreasureMapLoot) do
            if math.random(100) <= lootItem.chance then
                local amount = math.random(lootItem.amount.min, lootItem.amount.max)
                AddItem(src, {
                    item = lootItem.item,
                    amount = amount
                })
                lootClaimed = true
            end
        end

        if lootClaimed then
            Notify(src, locale('treasure_found'), "success")
        else
            Notify(src, locale('safe_empty'), "error")
        end

        EndTreasureHunt(huntId)
    else
        Notify(src, locale('invalid_treasure_hunt'), "error")
    end
end)

function EndTreasureHunt(huntId)
    if activeTreasureHunts[huntId] then
        local locationKey = GetLocationKey(activeTreasureHunts[huntId].location)
        busyLocations[locationKey] = nil
        activeTreasureHunts[huntId] = nil
        TriggerClientEvent('fishing:client:endTreasureHunt', -1, huntId)
    end
end

CreateThread(function()
    while true do
        Wait(60000) -- Check every minute
        local currentTime = os.time()
        for huntId, huntData in pairs(activeTreasureHunts) do
            if currentTime - huntData.startTime > Config.TreasureHuntExpiration then
                EndTreasureHunt(huntId)
            end
        end
    end
end)



-- Market Logic

function calculatePrice(basePrice, rarity, multiplier)
    if not multiplier then
        return math.floor((basePrice * (1 + (rarity / 100))))
    end

    return math.floor((basePrice * (1 + (rarity / 100))) * multiplier)
end

function InitializeFishMarketData()
    for fishName, _ in pairs(Config.FishTypes) do
        MySQL.Async.execute('INSERT IGNORE INTO fishing_supply (fish_type) VALUES (@fishType)', {
            ['@fishType'] = fishName
        })
    end
end

function UpdateFishPrices()
    if not Config.UseDynamicPrices then return end

    MySQL.Async.fetchAll('SELECT * FROM fishing_supply', {}, function(result)
        for _, fishData in ipairs(result) do
            local supply = fishData.supply
            local demand = fishData.demand

            local changeAmount = math.random(1, 5) * Config.DynamicPriceSettings.SupplyDemandImpact
            local newSupply = math.max(50, supply - changeAmount)
            local newDemand = math.min(150, demand + changeAmount)

            local priceMultiplier = newDemand / newSupply

            priceMultiplier = math.max(Config.DynamicPriceSettings.MinPriceMultiplier, math.min(Config.DynamicPriceSettings.MaxPriceMultiplier, priceMultiplier))

            MySQL.Async.execute('UPDATE fishing_supply SET supply = @supply, demand = @demand, current_multiplier = @multiplier WHERE fish_type = @fishType', {
                ['@supply'] = newSupply,
                ['@demand'] = newDemand,
                ['@multiplier'] = priceMultiplier,
                ['@fishType'] = fishData.fish_type
            })
        end
    end)
end

function GetCurrentPriceMultiplier(fishType, cb)
    if not Config.UseDynamicPrices then
        return cb(1.0)
    end

    MySQL.Async.fetchScalar('SELECT current_multiplier FROM fishing_supply WHERE fish_type = @fishType', {
        ['@fishType'] = fishType
    }, function(multiplier)
        cb(multiplier or 1.0)
    end)
end

function UpdateSupplyDemand(fishType, amount)
    if not Config.UseDynamicPrices then return end

    local impact = amount * Config.DynamicPriceSettings.SupplyDemandImpact

    MySQL.Async.execute('UPDATE fishing_supply SET supply = supply + @impact, demand = GREATEST(50, demand - @impact) WHERE fish_type = @fishType', {
        ['@impact'] = impact,
        ['@fishType'] = fishType
    })
end

function SimulateFishConsumption()
    if not Config.UseDynamicPrices then return end

    MySQL.Async.fetchAll('SELECT fish_type FROM fishing_supply', {}, function(result)
        for _, fishData in ipairs(result) do
            local consumptionAmount = math.random(1, 5) * Config.DynamicPriceSettings.SupplyDemandImpact
            MySQL.Async.execute('UPDATE fishing_supply SET supply = GREATEST(50, supply - @amount), demand = LEAST(150, demand + @amount) WHERE fish_type = @fishType', {
                ['@amount'] = consumptionAmount,
                ['@fishType'] = fishData.fish_type
            })
        end
    end)
end

function GetDemandLevel(demand)
    if demand < 75 then
        return locale('demand_low')
    elseif demand > 125 then
        return locale('demand_high')
    else
        return locale('demand_normal')
    end
end

QBCore.Functions.CreateCallback('fishing:server:getPlayerFish', function(source, cb)
    local playerFish = {}

    MySQL.Async.fetchAll('SELECT * FROM fishing_supply', {}, function(marketData)
        local marketDataMap = {}
        for _, data in ipairs(marketData) do
            marketDataMap[data.fish_type] = data
        end

        local fishTypes = {}
        for fishName, _ in pairs(Config.FishTypes) do
            table.insert(fishTypes, fishName)
        end

        local fishItems = GetItems(source, fishTypes)

        if Config.Inventory == "ox" then
            for _, slot in pairs(fishItems) do
                for _, item in ipairs(slot) do
                    if item and item.name and Config.FishTypes[item.name] then
                        local marketInfo = marketDataMap[item.name] or {current_multiplier = 1.0, demand = 100}
                        local basePrice = Config.FishTypes[item.name].price or 0
                        local price = calculatePrice(basePrice, item.metadata.rarity or 1, marketInfo.current_multiplier)
                        local demandLevel = GetDemandLevel(marketInfo.demand)
                        
                        table.insert(playerFish, {
                            name = item.name,
                            amount = item.count,
                            info = item.metadata,
                            slot = item.slot,
                            price = price,
                            demand = demandLevel
                        })
                    else
                        print("Warning: Invalid fish item found:", json.encode(item))
                    end
                end
            end
        else
            for _, items in pairs(fishItems) do
                for _, item in ipairs(items) do
                    if item and item.name and Config.FishTypes[item.name] then
                        local marketInfo = marketDataMap[item.name] or {current_multiplier = 1.0, demand = 100}
                        local basePrice = Config.FishTypes[item.name].price or 0
                        local metadata = item.info or {}
                        local price = calculatePrice(basePrice, metadata.rarity or 1, marketInfo.current_multiplier)
                        local demandLevel = GetDemandLevel(marketInfo.demand)
                        
                        table.insert(playerFish, {
                            name = item.name,
                            amount = item.amount,
                            info = metadata,
                            slot = item.slot,
                            price = price,
                            demand = demandLevel
                        })
                    else
                        print("Warning: Invalid fish item found:", json.encode(item))
                    end
                end
            end
        end

        cb(playerFish)
    end)
end)

RegisterNetEvent('fishing:server:sellFish')
AddEventHandler('fishing:server:sellFish', function(fishName, amount, price, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local playerId = Player.PlayerData.citizenid
    
    if not Config.FishTypes[fishName] then
        print("Invalid fish type attempted to be sold: " .. tostring(fishName))
        return
    end

    if not HasItem(src, fishName, amount) then
        Notify(src, locale('fish_sale_failed'), 'error')
        return
    end

    local fishItems = GetItems(src, {fishName})
    
    local fishItem
    for _, item in ipairs(fishItems) do
        if item.slot == slot then
            fishItem = item
            break
        end
    end

    if not fishItem then
        print("Fish item not found in slot: " .. tostring(slot))
        return
    end

    local metadata = fishItem.info or fishItem.metadata or {}

    GetCurrentPriceMultiplier(fishName, function(multiplier)
        local basePrice = Config.FishTypes[fishName].price
        local calculatedPrice = calculatePrice(basePrice, metadata.rarity or 1, multiplier)
        
        if math.abs(calculatedPrice - price) > 0.01 then -- Allow for small float discrepancies
            print("Price mismatch for fish: " .. fishName .. ". Expected: " .. calculatedPrice .. ", Received: " .. price)
            return
        end

        local totalPrice = calculatedPrice * amount

        RemoveItem(src, {
            item = fishName, 
            amount = amount, 
            slot = slot
        })
        AddMoney(src, 'sell_fish', totalPrice, 'fishing-sellfish')
        UpdateSupplyDemand(fishName, amount)
        UpdateChallengeProgress(playerId, false, false, false, totalPrice, false)
        Notify(src, locale('fish_sold', amount, GetItemData(fishName).label, totalPrice), 'success')
    end)
end)

RegisterNetEvent('fishing:server:sellAllFish')
AddEventHandler('fishing:server:sellAllFish', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerId = Player.PlayerData.citizenid
    local totalEarnings = 0

    local fishTypes = {}
    for fishName, _ in pairs(Config.FishTypes) do
        table.insert(fishTypes, fishName)
    end

    local fishItems = GetItems(src, fishTypes)

    MySQL.Async.fetchAll('SELECT * FROM fishing_supply', {}, function(marketData)
        local marketDataMap = {}
        for _, data in ipairs(marketData) do
            marketDataMap[data.fish_type] = data
        end

        for fishName, items in pairs(fishItems) do
            for _, item in ipairs(items) do
                local basePrice = Config.FishTypes[fishName].price
                local metadata = item.info or item.metadata or {}
                local marketInfo = marketDataMap[fishName] or {current_multiplier = 1.0, demand = 100}
                local price = calculatePrice(basePrice, metadata.rarity or 1, marketInfo.current_multiplier)
                local amount = item.amount or item.count
                local fishEarnings = price * amount
                RemoveItem(src, {
                    item = fishName, 
                    amount = amount,
                    slot = item.slot
                })
                totalEarnings = totalEarnings + fishEarnings
            end
        end

        if totalEarnings > 0 then
            AddMoney(src, 'sell_fish', totalEarnings, 'fishing-sellallfish')
            UpdateChallengeProgress(playerId, false, false, false, totalEarnings, false)
            Notify(src, locale('fish_sold_all', totalEarnings), 'success')
        else
            Notify(src, locale('no_fish_to_sell'), 'error')
        end
    end)
end)

RegisterNetEvent('fishing:server:buyEquipment')
AddEventHandler('fishing:server:buyEquipment', function(item, quantity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local equipment = Config.FishingEquipment[item]

    local level, _ = GetFishingLevel(Player.PlayerData.citizenid)
    
    if level < equipment.level then
        Notify(src, locale('level_too_low', equipment.level), "error")
        return
    end

    if equipment and RemoveMoney(src, 'buy_equipment', equipment.price * quantity, 'fishing-buy') then
        AddItem(src, {
            item = item,
            amount = quantity
        })
        Notify(src, locale('equipment_bought', quantity, equipment.label), "success")
    else
        Notify(src, locale('equipment_no_money'), "error")
    end
end)



-- Net Logic

function PlaceFishingNet(source, coords, rotation, zoneName, zoneData)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    if not HasItem(source, "fishingnet") then
        Notify(source, locale('no_fishing_net'), "error")
        return
    end

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM fishing_nets WHERE owner = @owner', {
        ['@owner'] = Player.PlayerData.citizenid
    }, function(result)
        if result[1].count > 0 then
            Notify(source, locale('too_many_nets'), "error")
            return
        end

        local zoneInfo = zoneName and { name = zoneName, data = zoneData } or nil

        MySQL.Async.insert('INSERT INTO fishing_nets (owner, location_x, location_y, location_z, rotation_x, rotation_y, rotation_z, zone_info) VALUES (@owner, @x, @y, @z, @rx, @ry, @rz, @zoneInfo)', {
            ['@owner'] = Player.PlayerData.citizenid,
            ['@x'] = coords.x,
            ['@y'] = coords.y,
            ['@z'] = coords.z,
            ['@rx'] = rotation.x,
            ['@ry'] = rotation.y,
            ['@rz'] = rotation.z,
            ['@zoneInfo'] = json.encode(zoneInfo)
        }, function(netId)
            if netId > 0 then
                Notify(source, locale('placed_net'), "success")
                TriggerClientEvent('fishing:client:spawnNetProp', -1, netId, coords, rotation)
                RemoveItem(source, {
                    item = 'fishingnet', 
                    amount = 1
                })
            else
                print("Failed to insert fishing net into database")
                Notify(source, locale('placed_net_failed'), "error")
            end
        end)
    end)
end

function LoadAllNets()
    MySQL.Async.fetchAll('SELECT * FROM fishing_nets', {}, function(nets)
        for _, net in ipairs(nets) do
            local coords = vector3(net.location_x, net.location_y, net.location_z)
            local rotation = vector3(net.rotation_x, net.rotation_y, net.rotation_z)
            TriggerClientEvent('fishing:client:spawnNetProp', -1, net.id, coords, rotation)
        end
    end)
end

RegisterNetEvent('fishing:server:RequestNetData')
AddEventHandler('fishing:server:RequestNetData', function()
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM fishing_nets', {}, function(nets)
        TriggerClientEvent('fishing:client:LoadNets', src, nets)
    end)
end)

-- RegisterNetEvent('fishing:server:placeFishingNet')
-- AddEventHandler('fishing:server:placeFishingNet', function(coords, rotation, zoneName, zoneData)
--     PlaceFishingNet(source, coords, rotation, zoneName, zoneData)
-- end)

RegisterNetEvent('fishing:server:placeFishingNet')
AddEventHandler('fishing:server:placeFishingNet', function(coords, rotation, zoneName, zoneData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not HasItem(src, "fishingnet") then
        Notify(src, locale('no_fishing_net'), "error")
        return
    end

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM fishing_nets WHERE owner = @owner', {
        ['@owner'] = Player.PlayerData.citizenid
    }, function(result)
        if result[1].count > 0 then
            Notify(src, locale('too_many_nets'), "error")
            return
        end

        local zoneInfo = zoneName and { name = zoneName, data = zoneData } or nil

        MySQL.Async.insert('INSERT INTO fishing_nets (owner, location_x, location_y, location_z, rotation_x, rotation_y, rotation_z, zone_info) VALUES (@owner, @x, @y, @z, @rx, @ry, @rz, @zoneInfo)', {
            ['@owner'] = Player.PlayerData.citizenid,
            ['@x'] = coords.x,
            ['@y'] = coords.y,
            ['@z'] = coords.z,
            ['@rx'] = rotation.x,
            ['@ry'] = rotation.y,
            ['@rz'] = rotation.z,
            ['@zoneInfo'] = json.encode(zoneInfo)
        }, function(netId)
            if netId > 0 then
                Notify(src, locale('placed_net'), "success")
                TriggerClientEvent('fishing:client:spawnNetProp', -1, netId, coords, rotation)
                RemoveItem(src, {
                    item = 'fishingnet', 
                    amount = 1
                })
            else
                print("Failed to insert fishing net into database")
                Notify(src, locale('placed_net_failed'), "error")
            end
        end)
    end)
end)

function ProcessNetCatches()
    MySQL.Async.fetchAll('SELECT * FROM fishing_nets', {}, function(nets)
        for _, net in ipairs(nets) do
            local bait = json.decode(net.bait or '{}')
            local catches = json.decode(net.catches or '[]')
            local totalBait = 0
            for _, v in pairs(bait) do totalBait = totalBait + v end

            if totalBait > 0 then
                local catchChance = CalculateCatchChance(net, totalBait)
                
                if math.random() < catchChance then
                    local fishType = GetRandomFishForNet(net, bait)
                    local fishLength = generateFishLength(Config.FishTypes[fishType].minLength, Config.FishTypes[fishType].maxLength)
                    
                    table.insert(catches, {
                        fish_type = fishType,
                        fish_length = fishLength,
                        catch_time = os.time()
                    })

                    local durabilityLoss = math.random(1, 3)
                    local newBait = ReduceBait(bait)
                    MySQL.Async.execute('UPDATE fishing_nets SET durability = durability - @loss, bait = @bait, catches = @catches WHERE id = @netId', {
                        ['@loss'] = durabilityLoss,
                        ['@bait'] = json.encode(newBait),
                        ['@catches'] = json.encode(catches),
                        ['@netId'] = net.id
                    })

                    TriggerClientEvent('fishing:client:updateNetBait', -1, net.id, newBait)
                    TriggerClientEvent('fishing:client:updateNetCatches', -1, net.id, catches)
                end
            end
        end
    end)
end

function ReduceBait(bait)
    local baitTypes = {}
    for baitType, amount in pairs(bait) do
        if amount > 0 then
            table.insert(baitTypes, baitType)
        end
    end
    if #baitTypes > 0 then
        local chosenBait = baitTypes[math.random(#baitTypes)]
        bait[chosenBait] = bait[chosenBait] - 1
    end
    return bait
end

function CalculateCatchChance(net, totalBait)
    local baseChance = Config.NetChanceBase
    local baitMultiplier = GetBaitMultiplier(totalBait)
    local locationMultiplier = GetLocationMultiplier(net)
    local durabilityMultiplier = GetDurabilityMultiplier(net.durability)

    local finalChance = baseChance * baitMultiplier * locationMultiplier * durabilityMultiplier

    return math.min(finalChance, Config.NetChanceCap)
end

function GetBaitMultiplier(totalBait)
    return 1 + (totalBait / Config.MaxNetBaitCapacity) * 0.5
end

function GetLocationMultiplier(net)
    local zoneInfo = json.decode(net.zone_info)
    local zoneMultiplier = zoneInfo and zoneInfo.data.zoneMultiplier or 1.0
    
    if not zoneInfo then
        zoneMultiplier = 0.5
    end
    return zoneMultiplier
end

function GetDurabilityMultiplier(durability)
    return 0.5 + (durability / 100) * 0.5
end

function GetRandomFishForNet(net, bait)
    local zoneInfo = json.decode(net.zone_info)
    local availableFish = zoneInfo and zoneInfo.data.availableFish or {}
    
    if #availableFish == 0 then
        for fishName, _ in pairs(Config.FishTypes) do
            table.insert(availableFish, fishName)
        end
    end

    local totalWeight = 0
    local fishWeights = {}

    for _, fishName in ipairs(availableFish) do
        local fishData = Config.FishTypes[fishName]
        if fishData then
            local weight = CalculateFishWeight(fishName, fishData, bait)
            if weight > 0 then
                fishWeights[fishName] = weight
                totalWeight = totalWeight + weight
            end
        end
    end

    if totalWeight == 0 then
        return GetFallbackFish()
    end

    local randomValue = math.random() * totalWeight
    local currentWeight = 0

    for fishName, weight in pairs(fishWeights) do
        currentWeight = currentWeight + weight
        if randomValue <= currentWeight then
            return fishName
        end
    end

    return GetFallbackFish()
end

function CalculateFishWeight(fishName, fishData, bait)
    local baseWeight = 100 / fishData.rarity
    local baitMultiplier = GetBaitEffectiveness(fishName, bait)
    local baitPower = GetMaxBaitPower(bait)
    
    local adjustedWeight = baseWeight * (baitPower / 100)
    
    if fishData.category == "Very Rare" or fishData.category == "Legendary" then
        adjustedWeight = adjustedWeight * (baitMultiplier * 0.1)
    else
        adjustedWeight = adjustedWeight * baitMultiplier
    end
    
    return adjustedWeight
end

function GetMaxBaitPower(bait)
    local maxPower = 0
    for baitType, amount in pairs(bait) do
        if amount > 0 then
            local baitData = GetBaitDataByName(baitType)
            if baitData and baitData.power > maxPower then
                maxPower = baitData.power
            end
        end
    end
    return maxPower
end

function GetBaitEffectiveness(fishName, bait)
    local effectiveness = 1
    for baitType, amount in pairs(bait) do
        if amount > 0 then
            local baitData = GetBaitDataByName(baitType)
            if baitData then
                effectiveness = effectiveness * (1 + (baitData.power / 100))
            end
        end
    end
    return effectiveness
end

function GetBaitDataByName(baitName)
    for _, baitData in ipairs(Config.BaitTypes) do
        if baitData.name == baitName then
            return baitData
        end
    end
    return nil
end

function GetFallbackFish()
    return "salmon"
end

function AddBaitToNet(source, netId, baitType, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    MySQL.Async.fetchAll('SELECT * FROM fishing_nets WHERE id = @netId', {
        ['@netId'] = netId
    }, function(result)
        if result[1] and result[1].owner == Player.PlayerData.citizenid then
            local currentBait = json.decode(result[1].bait or '{}')
            local totalBait = 0
            for _, v in pairs(currentBait) do totalBait = totalBait + v end

            if totalBait + amount > Config.MaxNetBaitCapacity then
                Notify(source, locale('bait_capacity_exceeded'), "error")
                return
            end

            if HasItem(source, baitType, amount) then
                RemoveItem(source, {
                    item = baitType, 
                    amount = amount
                })
                currentBait[baitType] = (currentBait[baitType] or 0) + amount
                MySQL.Async.execute('UPDATE fishing_nets SET bait = @bait WHERE id = @netId', {
                    ['@bait'] = json.encode(currentBait),
                    ['@netId'] = netId
                })
                Notify(source, locale('bait_added_to_net', amount, GetItemData(baitType).label), "success")
                TriggerClientEvent('fishing:client:updateNetBait', -1, netId, currentBait)
            else
                Notify(source, locale('not_enough_bait', baitType), "error")
            end
        else
            Notify(source, locale('net_not_owned'), "error")
        end
    end)
end

RegisterNetEvent('fishing:server:addBaitToNet')
AddEventHandler('fishing:server:addBaitToNet', function(netId, baitType, amount)
    AddBaitToNet(source, netId, baitType, amount)
end)

function GetNetData(netId)
    local netData = nil
    local fishCaught = {}

    MySQL.Async.fetchAll('SELECT * FROM fishing_nets WHERE id = @netId', {
        ['@netId'] = netId
    }, function(result)
        if result[1] then
            netData = result[1]
            netData.bait = json.decode(netData.bait or '{}')
            fishCaught = json.decode(netData.catches or '[]')
        end
    end)

    while netData == nil do Wait(0) end
    return netData, fishCaught
end

RegisterNetEvent('fishing:server:checkFishingNet')
AddEventHandler('fishing:server:checkFishingNet', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local netId = type(data) == "table" and data.netId or data
    local netData, fishCaught = GetNetData(netId)
    
    if Config.PrivateNets then
        if netData.owner ~= Player.PlayerData.citizenid then
            Notify(src, locale('net_not_owned'), "error")
            return
        end
    end

    TriggerClientEvent('fishing:client:showNetMenu', src, netData, fishCaught)
end)

RegisterNetEvent('fishing:server:removeFishingNet')
AddEventHandler('fishing:server:removeFishingNet', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local netId = type(data) == "table" and data.netId or data

    MySQL.Async.fetchAll('SELECT * FROM fishing_nets WHERE id = @netId', {
        ['@netId'] = netId
    }, function(result)
        if result[1] then
            if not Config.PrivateNets or result[1].owner == Player.PlayerData.citizenid then
                MySQL.Async.execute('DELETE FROM fishing_nets WHERE id = @netId', {
                    ['@netId'] = netId
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        AddItem(src, {
                            item = 'fishingnet',
                            amount = 1
                        })
                        Notify(src, locale('net_removed'), "success")
                        TriggerClientEvent('fishing:client:removeNetData', -1, netId)
                    else
                        Notify(src, locale('net_remove_failed'), "error")
                    end
                end)
            else
                Notify(src, locale('net_not_owned'), "error")
            end
        else
            Notify(src, locale('net_not_found'), "error")
        end
    end)
end)

function RepairFishingNet(source, data)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    if not HasItem(source, Config.NetRepair.RepairItem) then
        Notify(source, locale('repair_kit_needed', Config.NetRepair.RepairItem), "error")
        return
    end

    local netId = type(data) == "table" and data.netId or data

    MySQL.Async.fetchAll('SELECT * FROM fishing_nets WHERE id = @netId', {
        ['@netId'] = netId
    }, function(result)
        if result[1] then
            if not Config.PrivateNets or result[1].owner == Player.PlayerData.citizenid then
                local currentDurability = result[1].durability
                local newDurability = math.min(currentDurability + Config.NetRepair.RepairAmount, Config.NetRepair.MaxDurability)
                
                MySQL.Async.execute('UPDATE fishing_nets SET durability = @durability WHERE id = @netId', {
                    ['@durability'] = newDurability,
                    ['@netId'] = netId
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        RemoveItem(source, {
                            item = Config.NetRepair.RepairItem, 
                            amount = 1
                        })
                        Notify(source, locale('net_repaired', newDurability), "success")
                        TriggerClientEvent('fishing:client:updateNetDurability', -1, netId, newDurability)
                    else
                        Notify(source, locale('net_repair_failed'), "error")
                    end
                end)
            else
                Notify(source, locale('net_not_owned'), "error")
            end
        else
            Notify(source, locale('net_not_found'), "error")
        end
    end)
end

RegisterNetEvent('fishing:server:repairFishingNet')
AddEventHandler('fishing:server:repairFishingNet', function(netId)
    RepairFishingNet(source, netId)
end)

RegisterNetEvent('fishing:server:collectFish')
AddEventHandler('fishing:server:collectFish', function(netId, fishIndex)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    MySQL.Async.fetchAll('SELECT * FROM fishing_nets WHERE id = @netId', {
        ['@netId'] = netId
    }, function(result)
        if result[1] then
            local catches = json.decode(result[1].catches or '[]')
            if catches[fishIndex] then
                local fish = catches[fishIndex]
                local fishType = fish.fish_type
                local fishLength = fish.fish_length
                
                local fishConfig = Config.FishTypes[fishType]
                local fishRarity = calculateFishRarity(fishLength, fishConfig.minLength, fishConfig.maxLength)

                local info = {
                    length = fishLength,    -- Store the raw value for calculations
                    rarity = fishRarity     -- Store the raw value for calculations
                }
                
                if Config.Inventory == "ox" then
                    info.format_length = string.format("%.2f\"", fishLength)
                    info.format_rarity = string.format("%d%%", fishRarity)
                end

                AddItem(src, {
                    item = fishType,
                    amount = 1,
                    info = info
                })
                
                table.remove(catches, fishIndex)
                
                MySQL.Async.execute('UPDATE fishing_nets SET catches = @catches WHERE id = @netId', {
                    ['@catches'] = json.encode(catches),
                    ['@netId'] = netId
                })
                
                Notify(src, locale('fish_collected', fishType, fishLength), "success")
                
                TriggerClientEvent('fishing:client:updateNetCatch', -1, netId, catches)
            else
                Notify(src, locale('fish_not_found'), "error")
            end
        else
            Notify(src, locale('net_not_found'), "error")
        end
    end)
end)



-- Rental Logic

RegisterServerEvent('fishing:server:RentBoat')
AddEventHandler('fishing:server:RentBoat', function(location)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if RemoveMoney(src, 'boat_rental', Config.RentalPrice, 'boat-rental') then
        rentedBoats[src] = true
        TriggerClientEvent('fishing:client:SpawnRentedBoat', src, location)
        Notify(src, locale('boat_rented', Config.RentalPrice), "success")
    else
        Notify(src, locale('boat_no_money'), "error")
    end
end)

RegisterServerEvent('fishing:server:ReturnBoat')
AddEventHandler('fishing:server:ReturnBoat', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if rentedBoats[src] then
        local refundAmount = math.floor(Config.RentalPrice * Config.BoatReturnRefund)
        AddMoney(src, 'boat_rental', refundAmount, 'boat-return')
        rentedBoats[src] = nil
        Notify(src, locale('boat_returned_refund', refundAmount), "success")
    else
        Notify(src, locale('boat_return_error'), "error")
    end
end)



-- Threads

CreateThread(function()
    while true do
        Wait(Config.NetCatchDelay * 60 * 1000)
        ProcessNetCatches()
    end
end)

CreateThread(function()
    while true do
        Wait(Config.DynamicPriceSettings.UpdateInterval * 1000)
        UpdateFishPrices()
    end
end)

CreateThread(function()
    while true do
        Wait(900000)
        SimulateFishConsumption()
    end
end)



-- Event Handlers

AddEventHandler('playerDropped', function(reason)
    local source = source
    if fishingStatus[source] then
        fishingStatus[source] = nil
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    CheckTournamentStatus()
    InitializeFishMarketData()
    Wait(2000)
    LoadAllNets()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    fishingStatus = {}
end)
