RegisterServerEvent('jim-mining:Crafting:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local amount = 1
	if craftable then
		if craftable["amount"] then amount = craftable["amount"] end
		for k, v in pairs(craftable[ItemMake]) do
			print(k, v)
			TriggerEvent("jim-mining:server:toggleItem", false, tostring(k), v, src)
		end
	end
	TriggerEvent("jim-mining:server:toggleItem", true, ItemMake, amount, src)
end)

RegisterServerEvent("jim-mining:Reward", function(data)
    local src = source
    local amount = 1

    if data.pan then
        for i = 1, math.random(1, 3) do
            local item = Config.PanPool[math.random(1, #Config.PanPool)]

            if exports.ox_inventory:CanCarryItem(src, item, amount) then
                exports.ox_inventory:AddItem(src, item, amount)
                TriggerClientEvent('ox_inventory:notify', src, {
                    description = "You found " .. amount .. "x " .. item,
                    type = 'success'
                })
                if Config.Debug then
                    print(string.format("^5Debug^7: ^4Reward Given^7: ^3%s^7 x^3%d^7 to Player ^3%d^7", item, amount, src))
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Your inventory is full", "error")
            end
        end
    end
end)


RegisterNetEvent('jim-mining:server:toggleItem', function(give, item, amount, newsrc)
    local src = newsrc or source
    local remamount = amount or 1

    if give == 0 or give == false then -- Noņem priekšmetu
        if exports.ox_inventory:Search(src, 'count', item) >= remamount then
            exports.ox_inventory:RemoveItem(src, item, remamount)
            TriggerClientEvent('ox_inventory:notify', src, {
                description = "Removed " .. remamount .. "x " .. item,
                type = 'error'
            })
            if Config.Debug then
                print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..item.."^7(^2x^6"..remamount.."^7)'")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough of that item!", "error")
        end
    else -- Pievieno priekšmetu
        if exports.ox_inventory:CanCarryItem(src, item, remamount) then
            exports.ox_inventory:AddItem(src, item, remamount)
            TriggerClientEvent('ox_inventory:notify', src, {
                description = "Received " .. remamount .. "x " .. item,
                type = 'success'
            })
            if Config.Debug then
                print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..item.."^7(^2x^6"..remamount.."^7)'")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Your inventory is full", "error")
        end
    end
end)

function HasItem(src, item, amount)
    amount = amount or 1
    local count = exports.ox_inventory:Search(src, 'count', item) or 0

    if count >= amount then
        if Config.Debug then
            print(string.format("^5Debug^7: ^3HasItem^7: ^5FOUND^7 x^3%d^7 ^3%s", count, tostring(item)))
        end
        return true
    else
        if Config.Debug then
            print(string.format("^5Debug^7: ^3HasItem^7: ^1NOT FOUND^7 x^3%d^7 ^3%s", amount, tostring(item)))
        end
        return false
    end
end

local PanningLimits = {}
RegisterNetEvent('jim-mining:CheckPanningLimit', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local citizenID = Player.PlayerData.citizenid
	local currentTime = os.time()
	if not PanningLimits[citizenID] then
		PanningLimits[citizenID] = { count = 0, lastReset = currentTime }
	end
	local playerData = PanningLimits[citizenID]
	if (currentTime - playerData.lastReset) >= 3600 then
		playerData.count = 0
		playerData.lastReset = currentTime
	end
	if playerData.count >= 20 then
		TriggerClientEvent('jim-mining:StartPanning', src, false)
	else
		TriggerClientEvent('jim-mining:StartPanning', src, true)
	end
end)

RegisterNetEvent('jim-mining:UpdatePanningCount', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player then return end
	local citizenID = Player.PlayerData.citizenid
	local currentTime = os.time()
	if not PanningLimits[citizenID] then
		PanningLimits[citizenID] = { count = 0, lastReset = currentTime }
	end
	PanningLimits[citizenID].count = PanningLimits[citizenID].count + 1
end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	for i = 1, #Config.PanPool do if not QBCore.Shared.Items[Config.PanPool[i]] then print("PanPool: Missing Item from QBCore.Shared.Items: '"..Config.PanPool[i].."'") end end
	local itemcheck = {}
	for _, v in pairs(Crafting) do for _, b in pairs(v) do for k, l in pairs(b) do if k ~= "amount" then itemcheck[k] = {} for j in pairs(l) do itemcheck[j] = {} end end end end end
	for k in pairs(itemcheck) do
		if not QBCore.Shared.Items[k] then print("Crafting recipe couldn't find item '"..k.."' in the shared") end
	end
end)