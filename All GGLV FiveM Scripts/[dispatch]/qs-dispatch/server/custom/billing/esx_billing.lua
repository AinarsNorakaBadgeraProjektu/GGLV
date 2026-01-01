if Config.Billing ~= "esx_billing" then
    return
end






-- CREATE TABLE `billing` (
-- 	`id` int NOT NULL AUTO_INCREMENT,
-- 	`identifier` varchar(60) NOT NULL,
-- 	`sender` varchar(60) NOT NULL,
-- 	`target_type` varchar(50) NOT NULL,
-- 	`target` varchar(60) NOT NULL,
-- 	`label` varchar(255) NOT NULL,
-- 	`amount` int NOT NULL,

-- 	PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

function getBills(source, data)
    local results = MySQL.query.await(
        'SELECT * FROM billing WHERE identifier = @identifier AND target_type = @t_type AND (target = @society1 OR target = @society2) ORDER BY id DESC LIMIT 100;',
        {
            ['@identifier'] = data.identifier,
            ['@society1'] = GetJobName(source) or '',
            ['@society2'] = 'society_' .. GetJobName(source),
            ['@t_type'] = 'society_' .. GetJobName(source)
        })
    local bills = {}
    DebugPrint(results)
    for key, value in ipairs(results) do
        table.insert(
            bills,
            {
                ["author_name"] = value["sender"] or 'Not defined',
                ["timestamp"] = value["id"] or os.time(os.date("!*t")),
                ["status"] = 'unpaid',
                ["item"] = value["label"] or 'Not defined',
            }
        )
    end
    DebugPrint(bills)
    return bills
end

lib.callback.register('qs-dispatch:server:getBills', getBills)



function CreateBill(target, label, amount)
    local ident = GetPlayerIdentifier(target)

    -- MySQL.Async.execute(
    --     'INSERT INTO billing (identifier, sender, label, amount, target_type) VALUES (@identifier, @sender, @label, @amount, @target_type)',
    --     {
    --         ['@identifier'] = ident,
    --         ['@sender'] = ident,
    --         ['@label'] = label or "",
    --         ['@amount'] = amount or 100,
    --         ['@target_type'] = 'society_police'
    --     }
    -- )

    MySQL.Async.execute(
        'INSERT INTO billing (identifier, sender, label, amount, target_type, target) VALUES (@identifier, @sender, @label, @amount, @target_type, @target)',
        {
            ['@identifier'] = ident,
            ['@sender'] = ident,
            ['@label'] = label or "",
            ['@amount'] = amount or 100,
            ['@target_type'] = 'society_police',
            ['@target'] = 'society_police'
        }
    )
end
