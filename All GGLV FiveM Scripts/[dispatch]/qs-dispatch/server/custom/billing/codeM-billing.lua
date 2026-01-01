if Config.Billing ~= "codeM-billing" then
    return
end

function getBills(source, data)
    local results = MySQL.query.await(
        'SELECT * FROM codem_billing WHERE targetidentifier = @identifier AND societyname = @society1 OR societyname = @society2 ORDER BY id DESC LIMIT 100;',
        {
            ['@identifier'] = data.identifier,
            ['@society1'] = GetJobName(source) or '',
            ['@society2'] = 'society_' .. GetJobName(source),
        })
    local bills = {}
    DebugPrint(results)
    for key, value in ipairs(results) do
        table.insert(
            bills,
            {
                ["author_name"] = value["name"] or 'Not defined',
                ["timestamp"] = value["date"] or os.time(os.date("!*t")),
                ["status"] = value["status"],
                ["item"] = value["label"] or 'Not defined',
            }
        )
    end
    DebugPrint(bills)
    return bills
end

lib.callback.register('qs-dispatch:server:getBills', getBills)


function CreateBill(target, label, amount)
    local pData = GetCharacterRPData(target)
    -- generate a unique id standalone dont use the identifier of the player
    local uniqueId = os.time(os.date("!*t"))
    local updateResult =
        MySQL.Sync.execute(
            'INSERT INTO codem_billing (identifier, name, targetidentifier, targetname, amount, invoicelabel, status, societyname, uniqueid, date, dateupdate) VALUES (?,?,?,?,?,?,?,?,?,NOW(),NOW())',
            { pData.identifier, pData?.firstName or '??', pData.identifier, pData?.firstName or '??', amount, label,
                'unpaid', 'police', uniqueId })

    if (updateResult > 0) then
        DebugPrint('Bill created')
    else
        DebugPrint('Bill not created')
    end
end

RegisterServerCallback("qs-dispatch:server:codeMBilling:CreateBill", CreateBill)
