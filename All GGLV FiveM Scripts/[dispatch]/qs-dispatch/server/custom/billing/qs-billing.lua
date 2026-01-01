if Config.Billing ~= "qs-billing" then
    return
end

function getBills(a, data)
    local results = MySQL.query.await(
        "SELECT * FROM qs_billing WHERE receiver_identifier = @identifier AND society_name IN (@society1, @society2) ORDER BY id DESC LIMIT 100;",
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
                ["author_name"] = value["author_name"] or 'Not defined',       -- value["row_name of author name in your SQL"]
                ["timestamp"] = value["sent_date"] or os.time(os.date("!*t")), -- value["row_name of timestamp in your SQL"]
                ["status"] = value["status"] or 'unpayed',                     -- value["row_name of status in your SQL"]
                ["item"] = value["item"] or 'Not defined',                     -- value["row_name of item/text in your SQL"]
            }
        )
    end
    DebugPrint(bills, 'qs-billing', data.identifier)
    return bills
end

lib.callback.register('qs-dispatch:server:getBills', getBills)



-- CREATE TABLE `qs_billing` (
--   `id` int(50) NOT NULL PRIMARY KEY AUTO_INCREMENT,
--   `receiver_identifier` varchar(255) NOT NULL,
--   `receiver_name` varchar(255) NOT NULL,
--   `author_identifier` varchar(255) NOT NULL,
--   `author_name` varchar(255) NULL DEFAULT NULL,
--   `society` varchar(255) NOT NULL,
--   `society_name` varchar(255) NULL DEFAULT 'none',
--   `item` varchar(255) NOT NULL,
--   `invoice_value` int(50) NOT NULL,
--   `status` varchar(50) NOT NULL,
--   `notes` varchar(255) NULL DEFAULT ' ',
--   `sent_date` varchar(255) NOT NULL,
--   `limit_pay_date` varchar(255) NULL DEFAULT NULL,
--   `fees_amount` int(50) NULL DEFAULT 0,
--   `paid_date` varchar(255) NULL DEFAULT NULL
-- );



function CreateBill(target, label, amount)
    local ident = GetPlayerIdentifier(target)
    local data = getPlayerByIdentifier(target, { playerID = ident })
    -- data --
    -- | - identifier
    -- | - name
    -- | - lastname
    -- | - sex
    -- MySQL.Async.execute(
    --     'INSERT INTO qs_billing (receiver_identifier, author_name, item, invoice_value, society_name, status) VALUES (@identifier, @sender, @label, @invoice_value, @target_type, "Unpaid")',
    --     {
    --         ['@identifier'] = ident,
    --         ['@sender'] = ident,
    --         ['@label'] = label,
    --         ['@invoice_value'] = amount,
    --         ['@target_type'] = GetJobName(target) or ''
    --     }
    -- )
    -- the sender is LSPD and the receiver is the playerm set the society_name to society_police and the receiver_identifier to the player's identifier

    MySQL.Async.execute(
        'INSERT INTO qs_billing (receiver_identifier, receiver_name, author_identifier, author_name, society, society_name, item, invoice_value, status, sent_date) VALUES (@receiver_identifier, @receiver_name, @author_identifier, @author_name, @society, @society_name, @item, @invoice_value, @status, @sent_date)',
        {
            ['@receiver_identifier'] = data.identifier,
            ['@receiver_name'] = data.name,
            ['@author_identifier'] = ident,
            ['@author_name'] = GetPlayerName(target),
            ['@society'] = 'true',
            ['@society_name'] = 'society_police',
            ['@item'] = label,
            ['@invoice_value'] = amount,
            ['@status'] = 'Unpaid',
            ['@sent_date'] = os.date('%Y-%m-%d %H:%M:%S')
        })
end
