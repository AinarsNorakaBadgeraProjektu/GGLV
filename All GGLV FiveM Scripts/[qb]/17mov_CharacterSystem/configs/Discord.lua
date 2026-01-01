-- We moved this part of Selector.lua config there, because otherwise your Discord bot token can be easly leaked by cheaters who's using dumper
-- Here you can configure custom number of characters per specified player (based on discord roles)
Selector.Discord = {
    Enable = true,                                                                      -- Should enable system?
    Token = "MTMzMDE4MTU5NTg2NDM2NzI0Nw.GFbuMy.GSJ91AVmVKeURY3CQ1yRZdbSP3lKiFgCUos77w", -- Discord Bot token (bot must be on guild)
    Guild = "1101843939536945172",                                                       -- DiscordId of your server guild
    Roles = {                                                                           -- There you can add roles and assign number of characters
        ["696459952193273878"] = 2,
        ["902960951249231942"] = 2,
    }
}