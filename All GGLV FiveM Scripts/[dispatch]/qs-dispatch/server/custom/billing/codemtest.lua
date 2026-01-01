
if Config.Billing ~= "codeM-billingtest" then
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
    exports['codem-billing']:createBilling(target, target, amount, label, 'police')
end


RegisterServerCallback("qs-dispatch:server:codeMBilling:CreateBill", CreateBill)