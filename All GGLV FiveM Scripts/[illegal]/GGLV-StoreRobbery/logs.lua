Logs = {}

-- What logging service do you want to use?
-- Available options: 'fivemanage', 'fivemerr', 'discord' & 'none'
-- It is highly recommended to use a proper logging service such as Fivemanage or Fivemerr
Logs.Service = 'discord'

-- Do you want to include screenshots with your logs?
-- This is only applicable to Fivemanage and Fivemerr
Logs.Screenshots = false

-- You can enable (true) or disable (false) specific player events to log here
Logs.Events = {
    -- register_robbed is when a register has been robbed.. shocker, right?
    register_robbed = true,
    -- safe_robbed is when.. come on now, you gotta know..
    safe_robbed = true
}

-- If Logs.Service = 'discord', you can customize the webhook data here
-- If not using Discord, this section can be ignored
Logs.Discord = {
    -- The name of the webhook
    name = '24/7 Robbery Logs',
    -- The webhook link
    link = 'https://discord.com/api/webhooks/1415348609066467489/x8jV1eUuB-0NjmxMdb9gQC1mZ73_PbUg3h-axgMAYO1vHsnQ-TFC9jnpeEE9wSEvdbeO',
    -- The webhook profile image
    image = 'https://i.imgur.com/ILTkWBh.png',
    -- The webhook footer image
    footer = 'https://i.imgur.com/ILTkWBh.png'
}