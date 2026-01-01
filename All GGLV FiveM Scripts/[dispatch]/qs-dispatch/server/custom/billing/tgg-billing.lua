if Config.Billing ~= "tgg-billing" then
    return
end

-- CREATE TABLE IF NOT EXISTS `tgg_billing_invoices` (
--     `id` INT AUTO_INCREMENT,
--     `uuid` VARCHAR(64) NOT NULL,
--     `timestamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
--     `last_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
--     `status` VARCHAR(12) NOT NULL, -- 'unpaid', 'paid', 'cancelled'
--     `sender` VARCHAR(64) NULL, -- Job name['police', 'mechanic', 'ambulance', ...] or `__personal`
--     `sender_id` VARCHAR(64) NOT NULL,
--     `sender_name` VARCHAR(64) NOT NULL,
--     `sender_company_name` VARCHAR(64) NULL,
--     `recipient_id` VARCHAR(64) NOT NULL,
--     `recipient_name` VARCHAR(64) NOT NULL,
--     `items` VARCHAR(4096) NOT NULL, -- The invoice items in JSON format.
--     `tax_percentage` INT NOT NULL DEFAULT 0, -- The tax percentage.
--     `total` FLOAT NOT NULL, -- The total amount of the invoice(sum of all `items`).
--     `notes` VARCHAR(300) NULL,
--     PRIMARY KEY (`id`),
--     KEY `sender` (`sender`)
-- )

function getBills(a, data)
    local results = MySQL.query.await(
        "SELECT * FROM tgg_billing_invoices WHERE recipient_id = @identifier AND sender IN (@society1, @society2) ORDER BY id DESC LIMIT 100;",
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
                ["author_name"] = value["sender_name"] or 'Not defined',       -- valor de la columna `sender_name`
                ["timestamp"] = value["timestamp"] or os.time(os.date("!*t")), -- valor de la columna `timestamp`
                ["status"] = value["status"] or 'unpaid',                      -- valor de la columna `status`
                ["item"] = value["items"] or 'Not defined',                    -- valor de la columna `items`
            }
        )
    end
    DebugPrint(bills, 'tgg_billing_invoices', data.identifier)
    return bills
end


lib.callback.register('qs-dispatch:server:getBills', getBills)



function CreateBill(target, label, amount)
    local ident = GetPlayerIdentifier(target)
    local data = getPlayerByIdentifier(target, { playerID = ident })
    local rpdata = GetCharacterRPData(target)
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

    local firstName = rpdata?.firstname or 'You'
    local lastName = rpdata?.lastname or ''

    local invoiceData = {
        items = {
            {
                key = "Police",
                label = label,
                price = amount,
                quantity = 1,
                priceChange = false,
                quantityChange = false
            }
        },
        total = amount,
        notes = label,                             -- Optional
        sender = "police",                         -- Your society job identifier e.g. 'police' or '__personal' or change to society_societyname if you need it
        senderId = target,                         -- Usually this is the player's identifier
        senderName = "Police Dept",                -- Usually this is the player's name
        recipientId = target,                      -- The recipient's identifier
        recipientName = firstName .. " " .. lastName, -- The recipient's name
        taxPercentage = 0,
        senderCompanyName = "Police Dept",         -- If sender is '__personal' might be nil
    }

    ---An export to create an invoice manually.
    ---@param invoiceData table
    ---@return table The created invoice
    local invoice = exports["tgg-billing"]:CreateInvoice(invoiceData)
end
