if(DisableBar) then return end

for k, v in pairs(CasinoBars) do
    v.lastPlayers = {}
    v.currentDrink = nil
    v.currentPlayer = nil
end

RegisterServerCallback("sf-casinoutils:canUseBar", function(source, barId)
    if(CasinoBars[barId] and not CasinoBars[barId].currentPlayer) then
        CasinoBars[barId].currentPlayer = source
        local speech = GetGreetSpeech(source)
        if(Player(source).state.Drunk) then
            TriggerClientEvent("sf-casinoutils:barSpeech", -1, barId, "PLAYER_DRUNK")
        else
            if(CasinoBars[barId].lastPlayers[source]) then
                local time = os.time() - CasinoBars[barId].lastPlayers[source]
                if(time > 30 and time < (60 * 60)) then
                    TriggerClientEvent("sf-casinoutils:barSpeech", -1, barId, "WELCOME_BACK_ALREADY")
                end
            else
                TriggerClientEvent("sf-casinoutils:barSpeech", -1, barId, "BARTENDER_GREET")
            end
        end
        CasinoBars[barId].lastPlayers[source] = os.time()
        return true
    end
end)

RegisterNetEvent("sf-casinoutils:exitBar", function(barId)
    if(CasinoBars[barId] and CasinoBars[barId].currentPlayer == source) then
        CasinoBars[barId].currentPlayer = nil
        TriggerClientEvent("sf-casinoutils:barSpeech", -1, barId, "GENERIC_BYE")
        Citizen.Wait(15000)
        if(not CasinoBars[barId].currentPlayer) then
            TriggerClientEvent("sf-casinoutils:setDrink", -1, barId, CasinoBars[barId].currentDrink, nil)
            CasinoBars[barId].currentDrink = nil
        end
    end
end)

RegisterNetEvent("sf-casinoutils:barBuy", function(barId, drinkId)
    local _source = source
    if(not CasinoBars[barId] or CasinoBars[barId].currentPlayer ~= _source) then return end
    local bar = CasinoBars[barId]
    local drink = BarDrinks[drinkId]
    if(not drink) then
        return
    end
    if(not ShouldSellDrink(_source, drink.name)) then
        return
    end
    if(Bridge.GetItemCount(_source, MoneyItem) < drink.price) then
        ShowNotification(_source, _L("insufficient_count"))
        return
    end
    if(bar.drinking) then return end
    bar.drinking = true
    if(Player(_source).state.TooDrunk) then
        bar.drinking = true
        ShowNotification(_source, _L("too_drunk"))
        TriggerClientEvent("sf-casinoutils:barSpeech", -1, barId, "PLAYER_DRUNK")
        Citizen.Wait(6000)
        bar.drinking = false
        return
    end
    if not Bridge.RemoveItem(_source, MoneyItem, drink.price) then
        ShowNotification(_source, _L("insufficient_count"))
        bar.drinking = false
        return
    end
    if(Society.enable) then
        Bridge.AddSocietyMoney(Society.accountName, math.floor(drink.price * Society.addPercent))
    end
    if(bar.currentDrink ~= drink.model) then
        TriggerClientEvent("sf-casinoutils:setDrink", -1, barId, bar.currentDrink, drink.model)
        Citizen.Wait(bar.currentDrink ~= nil and (13500) or 7500)
        bar.currentDrink = drink.model
    end
    TriggerClientEvent("sf-casinoutils:drink", -1, barId, bar.currentDrink, _source)
    Citizen.Wait(3 * 1000)
    TriggerClientEvent("sf-casinoutils:barSpeech", -1, barId, "BARTENDER_SERVE")
    Citizen.Wait(7 * 1000)
    TriggerClientEvent("sf-casinoutils:addDrunk", _source, drink.drunkValue)
    Citizen.Wait(4000)
    bar.drinking = false
end)

AddEventHandler("playerDropped", function()
    -- cleanup
    for k, v in pairs(CasinoBars) do
        v.lastPlayers[source] = nil
        if(v.currentPlayer == source) then
            v.currentPlayer = nil
        end
    end
end)

function ShouldSellDrink(source, drinkName)
    return true
end

function GetGreetSpeech(source)
	local rnd = math.random(1, 2)
	if(Player(source).state.Drunk) then
		return "MINIGAME_DEALER_GREET_DRUNK"
	end
	if(rnd == 2) then
		local playerPed = GetPlayerPed(source)
		if(GetEntityModel(playerPed) == `mp_f_freemode_01`) then
			return "MINIGAME_DEALER_GREET_FEMALE"
		else
			return "MINIGAME_DEALER_GREET_MALE"
		end
	end
	return "MINIGAME_DEALER_GREET"
end