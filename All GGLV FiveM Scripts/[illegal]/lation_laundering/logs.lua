Logs = {}

-- General webhook configurations
Logs.Name = 'Laundering Logs' -- Name for the webhook
Logs.Image = 'https://i.imgur.com/ILTkWBh.png' -- Image for the webhook
Logs.Footer = 'https://i.imgur.com/ILTkWBh.png' -- Footer image for the webhook

-- Specific log type configurations
Logs.Types = {
    -- Do you want logs of users leveling up?
    levelUp = {
        enabled = true,
        webhook = 'https://discordapp.com/api/webhooks/1350200754056466572/92qD0ofrylBm88jhfB9o8V90s_VVtkom3HU2vLmGWaBccsmjgF-HRQFfZL6iPMEGYp9Z',
    },
    -- Do you want logs of users completing contracts?
    contracts = {
        enabled = true,
        webhook = 'https://discordapp.com/api/webhooks/1350200811304783934/1xQLKx2qxWqF9NUDs8pKiMp_F9J4fwXbha0vcAOtWq5CYapURqWnrCAv_QTMunA36E3K',
    },
    -- Do you want logs of users completing washes in warehouse?
    warehouse = {
        enabled = true,
        webhook = 'https://discordapp.com/api/webhooks/1350200849502179388/u7cjZoMKzbQ71G97SStHBPp7GfqAu3VmmXFNStvvcv1hZ1jZ5awsR9ODlDWC21x_vGUO'
    },
    -- Do you want logs of users counting money?
    counting = {
        enabled = true,
        webhook = 'https://discordapp.com/api/webhooks/1350200874927919155/kwFJZ7F92dHXOQD3_TBXVV-Fjo48kruuHBW2LMwc-0jreg_yXbo3-99qLb_sWXRycrL9'
    }
}