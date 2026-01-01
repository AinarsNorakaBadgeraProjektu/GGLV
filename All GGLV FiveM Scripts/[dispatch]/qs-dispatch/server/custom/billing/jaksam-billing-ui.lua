if Config.Billing ~= "jaksam-billing-ui" then
    return
end

function getBills(a, data)
    local results = MySQL.query.await(
        "SELECT * FROM billing WHERE receiver_identifier = @identifier AND target IN (@society1, @society2) ORDER BY id DESC LIMIT 100;",
        {
            ['@identifier'] = data.identifier,
            ['@society1'] = GetJobName(a) or '',
            ['@society2'] = 'society_' .. GetJobName(a)

        })
    local bills = {}
    for key, value in ipairs(results) do
        table.insert(
            bills,
            {
                ["author_name"] = value["sender"] or 'Not defined',           -- value["row_name of author name in your SQL"]
                ["timestamp"] = value["date"] or os.time(os.date("!*t")),     -- value["row_name of timestamp in your SQL"]
                ["status"] = value["status"] or 'unpayed',                    -- value["row_name of status in your SQL"]
                ["item"] = value["item"] or 'Not defined',                    -- value["row_name of item/text in your SQL"]
            }
        )
    end
    DebugPrint(bills)
    return bills
end

lib.callback.register('qs-dispatch:server:getBills', getBills)


function CreateBill(target, label, amount)
    local ident = GetPlayerIdentifier(target)

    MySQL.Async.execute(
        'INSERT INTO billing (receiver_identifier, sender, item, invoice_value, target, status, date) VALUES (@identifier, @sender, @label, @invoice_value, @target_type, "Unpaid", @date)',
        {
            ['@identifier'] = ident,
            ['@sender'] = ident,
            ['@label'] = label,
            ['@invoice_value'] = amount,
            ['@target_type'] = GetJobName(target) or '',
            ['@date'] = os.time(os.date("!*t"))
        }
    )
end
