if(DisableCashier) then return end

RegisterServerCallback("buyChips", function(source, amountId)
    local amount = Cash.amounts[amountId]
    if(not amount) then
        return
    end
    if(not ShouldSellChips(source, amount)) then
        return false, "CASH_DESK_UNAVAILABLE"
    end
    if(Bridge.GetItemCount(source, Cash.costItem.name) < (amount * Cash.costItem.count)) then
        ShowNotification(source, _L("insufficient_count"))
        return false, "CASH_DESK_DENIAL"
    end
    if not Bridge.RemoveItem(source, Cash.costItem.name, amount * Cash.costItem.count) then
        ShowNotification(source, _L("insufficient_count"))
        return false, "CASH_DESK_DENIAL"
    end
    Bridge.AddItem(source, Cash.tradeItem, amount)
    if(Society.enable) then
        Bridge.AddSocietyMoney(Society.accountName, math.floor(amount * Cash.costItem.count * Society.addPercent))
    end
    -- here you can add logs and you society money logic
    return true, "CASH_DESK_REQUEST_CHIPS"
end)

RegisterServerCallback("sellChips", function(source, amountId)
    local amount = Cash.amounts[amountId]
    if(not amount) then
        return
    end
    if(not CheckCasinoSociety(amount)) then
        return false, "CASH_DESK_UNAVAILABLE"
    end
    if(Bridge.GetItemCount(source, Cash.tradeItem) < (amount)) then
        ShowNotification(source, _L("insufficient_count"))
        return false, "CASH_DESK_DENIAL"
    end
    Bridge.AddItem(source, Cash.costItem.name, amount * Cash.costItem.count)
    Bridge.RemoveItem(source, Cash.tradeItem, amount)
    if(Society.enable) then
        Bridge.RemoveSocietyMoney(Society.accountName, math.floor(amount * Cash.costItem.count * Society.removePercent))
    end
    -- here you can add logs and you society money logic
    local speech = "CASH_DESK_SELL_SMALL"
    if(amount > Cash.amounts[#Cash.amounts]/4+Cash.amounts[1]) then
        speech = "CASH_DESK_SELL_LARGE"
    end
    return true, speech
end)

function ShouldSellChips(source, amount)
    return true
end

function CheckCasinoSociety(amount)
    -- here you can put your society money check logic
    if(Society.enable) then
        return Bridge.GetSocietyMoney(Society.accountName) >= amount
    end
    return true
end