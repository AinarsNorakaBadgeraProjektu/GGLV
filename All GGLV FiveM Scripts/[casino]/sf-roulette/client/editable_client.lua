function UpdateBet(betIndex)

end


function GetRouletteId(data)
    for index, roulette in ipairs(Config.Tables) do
		if(#(vector3(roulette.coords.x, roulette.coords.y, roulette.coords.z) - data.coords) <= 0.5 and roulette.model == data.model) then
			return index
		end
        if(index % 20 == 0) then
            Citizen.Wait(0)
        end
	end
end

function SetHUDState(state)
	if(state) then
		local segments = {
			{
				title = _L("bet"),
				content = 0
			},
			{
				title = _L("time_left"),
				content = 0
			},
		}
		if(Config.ShowTotalBet) then
			table.insert(segments, 1, {
				title = _L("bet_sum"),
				content = 0
			})
		end
		SendAppAction("setTopSegments", segments)
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
				keys = { "R"},
				label = _L("change_camera")
			}
		})
		SendAppAction("setLastWins", {})
		SendAppAction("setLastWinsVisible", Config.ShowLastNumbers)
		SendAppAction("setDisplayTop", true)
	end
	SendAppAction("setVisible", state)
end

function UpdateHUDValue()
	local timeLeft = math.floor((CurrentRoulette.timeLeft - GetGameTimer()) / 1000)
	local segments = {
		{
			title = _L("bet"),
			content = CurrentRoulette.betAmount
		},
		{
			title = _L("time_left"),
			content = timeLeft < 0 and GetTime(0) or GetTime(timeLeft)
		},
	}
	if(Config.ShowTotalBet) then
		table.insert(segments, 1, {
			title = _L("bet_sum"),
			content = CurrentRoulette.betTotal
		})
	end
	if(Config.ShowLastNumbers and CurrentRoulette.lastNumbers) then
		SendAppAction("setLastWins", CurrentRoulette.lastNumbers)
	end
	SendAppAction("setTopSegments", segments)
end

function GetTime(value)
	local minutes = math.floor(value/60)
	local seconds = value - minutes*60
	return string.format("%02d:%02d", minutes, seconds)
end

RegisterNetEvent("sf-roulette:addNotification", function(message)
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
        ShowNotification("Casino Roulette", notification, "")
    end
end


function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('rouletteNotification', message)
    BeginTextCommandThefeedPost("rouletteNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("rouletteHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("rouletteHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("rouletteHelpNotification")
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