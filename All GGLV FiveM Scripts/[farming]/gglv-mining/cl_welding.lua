local QBCore = exports['qb-core']:GetCoreObject()
local Config = {}

Config.Checkpoints = {
    vector3(-3.7, -2690.78, 5.83),
    vector3(-7.2, -2690.78, 5.83),
    vector3(-9.66, -2690.78, 5.83),
    vector3(-4.44, -2695.09, 5.63),
    vector3(-7.2, -2695.15, 5.63),
    vector3(-9.75, -2695.09, 5.63),
    vector3(-9.92, -2699.28, 5.24),
    vector3(-6.92, -2699.37, 5.24),
    vector3(-3.55, -2699.36, 5.24),
    vector3(-4.0, -2705.47, 4.69),
    vector3(-7.28, -2705.44, 4.69),
    vector3(-10.01, -2705.44, 4.69),
    vector3(-3.89, -2709.66, 4.48),
    vector3(-7.04, -2709.66, 4.48),
    vector3(-9.94, -2709.66, 4.48),
    vector3(-4.31, -2714.03, 4.28),
    vector3(-6.99, -2714.03, 4.28),
    vector3(-10.57, -2714.03, 4.28),
}

Config.CheckpointsStatus = {}

for i = 1, #Config.Checkpoints do
    Config.CheckpointsStatus[i] = false
end

for i, coords in ipairs(Config.Checkpoints) do
    exports.ox_target:addBoxZone({
        coords = coords,
        size = vec3(1, 1, 2),
        rotation = 0,
        debug = false,
        options = {
            {
                name = "checkpoint_" .. i,
                label = "Perform welding work",
                icon = "fas fa-tools",
                onSelect = function()
                    StartWelding(i)
                end,
                canInteract = function(entity, distance, coords)
                    return not Config.CheckpointsStatus[i]
                end,
            },
        },
    })
end

function StartWelding(index)
    local playerPed = PlayerPedId()
    if Config.CheckpointsStatus[index] then
        QBCore.Functions.Notify("This place is already taken!", "error")
        return
    end
    Config.CheckpointsStatus[index] = true
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
    QBCore.Functions.Progressbar("welding", "Welding work...", 30000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(playerPed)
        local reward = math.random(1, 100) <= 70 and "metalfrags" or "hqmetal"
        local amount = reward == "metalfrags" and math.random(2, 10) or math.random(1, 3)
        TriggerServerEvent("gglv-mining:giveReward", reward, amount)
    end, function()
        ClearPedTasks(playerPed)
        Config.CheckpointsStatus[index] = false
        QBCore.Functions.Notify("You interrupted the process!", "error")
    end)
end
