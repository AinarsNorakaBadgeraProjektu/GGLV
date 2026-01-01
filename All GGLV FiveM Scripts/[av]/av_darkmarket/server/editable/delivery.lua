RegisterServerEvent('av_darkmarket:getDelivery', function()
    local src = source
    local count = 0
    local identifier = exports['av_laptop']:getIdentifier(src)
    local message = {}
    print("getDelivery")
    if shopItems and shopItems[identifier] then
        print("player have pending items...")
        for k, v in pairs(shopItems[identifier]) do
            print(v['name'], v['amount'])
            local added = exports['av_laptop']:addItem(src, v['name'], v['amount'], v['metadata'])
            if added then
                shopItems[identifier][k] = nil
                count = count + 1
                message[#message+1] = "x"..v['amount'].. " "..v['name']
                print("item added")
            else
                print("addItem returned false, item doesn't exist in your inventory/framework or inv is full (?)")
            end
        end
        deliveryLog(src, message)
    end
    if count >= 1 then
        SaveResourceFile(GetCurrentResourceName(), "shop.json", json.encode(shopItems), -1)
        TriggerClientEvent('av_laptop:notification', src, Lang['app_title'], Lang['delivery_success'], "success")
    else
        TriggerClientEvent('av_laptop:notification', src, Lang['app_title'], Lang['delivery_error'], "error")
    end
end)