if Config.Billing ~= "okokBilling" then
    return
end

function getBills(source, data)
    local results = MySQL.query.await(
        "SELECT * FROM okokbilling WHERE receiver_identifier = @identifier AND society IN (@society1, @society2) ORDER BY id DESC LIMIT 100;",
        {
            ['@identifier'] = data.identifier,
            ['@society1'] = GetJobName(source) or '',
            ['@society2'] = 'society_' .. GetJobName(source)

        })
    local bills = {}
    for key, value in ipairs(results) do

        local status = value["status"]
        if status == 'paid' then
            status = 'paid'
        elseif status == 'unpaid' then
            status = 'unpayed'
        else
            status = 'unknown'
        end

        table.insert(
            bills,
            {
                ["author_name"] = value["author_name"] or 'Not defined',       -- value["row_name of author name in your SQL"]
                ["timestamp"] = value["sent_date"] or os.time(os.date("!*t")), -- value["row_name of timestamp in your SQL"]
                ["status"] = status,                     -- value["row_name of status in your SQL"]
                ["item"] = value["item"] or 'Not defined',                     -- value["row_name of item/text in your SQL"]
            }
        )
    end
    DebugPrint(bills)
    return bills
end

lib.callback.register('qs-dispatch:server:getBills', getBills)


function CreateBill(target, label, amount)
    local ident = GetPlayerIdentifier(target)
    local data = getPlayerByIdentifier(target, { playerID = ident })
    -- data --
    -- | - identifier
    -- | - name
    -- | - lastname
    -- | - sex
    -- MySQL.Async.execute(
    --     'INSERT INTO okokbilling (receiver_identifier, author_name, item, invoice_value, society_name, status) VALUES (@identifier, @sender, @label, @invoice_value, @target_type, "Unpaid")',
    --     {
    --         ['@identifier'] = ident,
    --         ['@sender'] = ident,
    --         ['@label'] = label,
    --         ['@invoice_value'] = amount,
    --         ['@target_type'] = GetJobName(target) or ''
    --     }
    -- )
    -- the sender is LSPD and the receiver is the playerm set the society_name to society_police and the receiver_identifier to the player's identifier

    local ident = GetPlayerIdentifier(target)
    local random = math.random(10000000, 90000000)
    local refid = "QS" .. random
    local MaxPayDay = 13 -- 13 hours
    local limit_pay_date = os.date("%Y-%m-%d %H:%M:%S", os.time() + (MaxPayDay * 24 * 60 * 60))

    MySQL.Async.execute(
        'INSERT INTO okokbilling (ref_id, receiver_identifier, receiver_name, author_identifier, author_name, society, society_name, item, invoice_value, status, sent_date, fees_amount, limit_pay_date, notes) VALUES (@ref_id, @receiver_identifier, @receiver_name, @author_identifier, @author_name, @society, @society_name, @item, @invoice_value, @status, @sent_date, @fees_amount, @limit_pay_date, @notes)',
        {
            ['@ref_id'] = refid,
            ['@receiver_identifier'] = data.identifier,
            ['@receiver_name'] = data.name,
            ['@author_identifier'] = ident,
            ['@author_name'] = GetPlayerName(target),
            ['@society'] = 'society_police',
            ['@society_name'] = 'society_police',
            ['@item'] = label,
            ['@notes'] = label,
            ['@invoice_value'] = amount,
            ['@status'] = 'unpaid',
            ['@sent_date'] = os.date('%Y-%m-%d %H:%M:%S'),
            ['@fees_amount'] = 0,
            ['@limit_pay_date'] = limit_pay_date
        })
end
