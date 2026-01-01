function UpdateBet(betIndex)

end


function GetBlackjackId(data)
    for index, blackjack in ipairs(Config.Tables) do
		if(#(vector3(blackjack.coords.x, blackjack.coords.y, blackjack.coords.z) - data.coords) <= 0.5 and blackjack.model == data.model) then
			return index
		end
        if(index % 20 == 0) then
            Citizen.Wait(0)
        end
	end
end

RegisterNetEvent("sf-blackjack:gameEnd", function()
	CurrentTable.handMode = false
	SendAppAction("setBet", CurrentTable.betAmount)
	SendAppAction("setTime", CurrentTable.timeLeft)
	SendAppAction("setText", { bet = _L("bet"), last_win = _L("time_left") })
	SendAppAction("setKeys", {
		{
			keys = { "↓", "↑" },
			label = _L("change_bet")
		},
		{
			keys = { "←", "→" },
			label = _L("min_max_bet")
		},
		{
			keys = { "↵" },
			label = _L("place_bet")
		},
	})
end)

RegisterNetEvent("sf-blackjack:setHands", function(playerHand, dealerHand)
	if(not CurrentTable.handMode) then
		CurrentTable.handMode = true
		SendAppAction("setText", { bet = _L("player_hand"), last_win = _L("dealer_hand") })
	end
	if(dealerHand ~= nil) then
		SendAppAction("setTime", dealerHand)
	end
	if(playerHand ~= nil) then
		SendAppAction("setBet", playerHand)
	end
end)

function SetHUDState(state)
	if(state) then
		CurrentTable.handMode = false
		SendAppAction("setBet", 0)
		SendAppAction("setTime", "00:00")
		SendAppAction("setText", { bet = _L("bet"), last_win = _L("time_left") })
		SendAppAction("setKeys", {
			{
				keys = { "↓", "↑" },
				label = _L("change_bet")
			},
			{
				keys = { "←", "→" },
				label = _L("min_max_bet")
			},
			{
				keys = { "↵" },
				label = _L("place_bet")
			},
		})
		SendAppAction("setDisplayTop", true)
	end
	SendAppAction("setVisible", state)
end

function UpdateHUDValue(key, value)
	if(key == "bet") then
		SendAppAction("setBet", value)
	elseif(key == "time_left") then
		local minutes = math.floor(value/60)
		local seconds = value - minutes*60
		SendAppAction("setTime", string.format("%02d:%02d", minutes, seconds))
	end
end

RegisterNetEvent("sf-blackjack:addNotification", function(message)
	HudAddNotification(message)
end)

if(GetResourceState("es_extended") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("esx:showNotification", notification)
    end
elseif(GetResourceState("qb-core") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("QBCore:Notify", notification)
    end
else
	function HudAddNotification(notification)
        ShowNotification("Casino Blackjack", notification, "")
    end
end


function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('blackjackNotification', message)
    BeginTextCommandThefeedPost("blackjackNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("blackjackHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("blackjackHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("blackjackHelpNotification")
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function SendAppAction(action, payload)
    SendNUIMessage({
        event = "sendAppEvent",
        app = "os",
        action = action,
        payload = payload,
    })
end

function ShouldExit()
	-- here you can apply your own dead logic to automatically exit game (It checks every 500ms)
	return false
end

RegisterClientCallback("sf-blackjack:requestInteraction", function(canSplit, canDouble, canSurrender)
	CurrentTable.busy = true
	local keys = {
		{
			keys = { "␣" },
			label = _L("stand")
		},
		{
			keys = { "↵" },
			label = _L("hit")
		},
	}
	if(canSurrender) then
		table.insert(keys, {
			keys = { "F" },
			label = _L("surrender")
		})
	end
	if(canSplit) then
		table.insert(keys, {
			keys = { "E" },
			label = _L("split")
		})
	end
	if(canDouble) then
		table.insert(keys, {
			keys = { "R" },
			label = _L("double_down")
		})
	end
	SendAppAction("setKeys", keys)
	local time = GetGameTimer()
	local choice = "stand"
	while true do
		if(GetGameTimer() - time > (30 * 1000)) then break end
		if(IsControlJustPressed(0, Config.Controls["hit"])) then
			choice = "hit"
			break
		end
		if(IsControlJustPressed(0, Config.Controls["stand"])) then
			choice = "stand"
			break
		end
		if(IsControlJustPressed(0, Config.Controls["surrender"]) and canSurrender) then
			choice = "surrendered"
			break
		end
		if(IsControlJustPressed(0, Config.Controls["split"]) and canSplit) then
			choice = "split"
			break
		end
		if(IsControlJustPressed(0, Config.Controls["double"]) and canDouble) then
			choice = "double"
			break
		end
		Citizen.Wait(0)
	end
	CurrentTable.busy = false
	return choice
end)