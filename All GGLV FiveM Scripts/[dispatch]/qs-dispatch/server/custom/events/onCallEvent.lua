local PoliceWebhookURL = 'https://discordapp.com/api/webhooks/1343221001680588880/rJPSaKnzllKnW39G18Bpooh06Bgxy2Rogo7CPE3D2OWN7_L-oE3JH4d13D1JE69IG3Xx' -- webhook URL HERE!!!!!!!!!!
local AmbulanceWebhookURL = 'https://discordapp.com/api/webhooks/1343221113718833305/fOySLQfW7QENnjrxsy3KpmRp1CfWQi1IVMuzxHbNQuRr1f1EfUqjpQn1eObYUn_EbDfS' -- webhook URL HERE!!!!!!!!

function OnCallEvent(job, callLocation, callCode, message, flashes, image, ThisCount)

    if Contains(job, "police") then

        if PoliceWebhookURL == '' then return WarningPrint('You dont have a configured webhook (police), please go to "server/custom/envents/onCallEvent.lua" an set it.') end
        exports['qs-dispatch']:SendWebhook(PoliceWebhookURL, 'Police Call', '#3246a8', message, image)

    elseif Contains(job, "ambulance") then

        if AmbulanceWebhookURL == '' then return WarningPrint('You dont have a configured webhook (ambulance), please go to "server/custom/envents/onCallEvent.lua" an set it.') end
        exports['qs-dispatch']:SendWebhook(AmbulanceWebhookURL, 'Ambulance Call', '#ff0040', message, image)

    end
end


function JailEvent(job, message, image)

    -- you can implement your things here

end