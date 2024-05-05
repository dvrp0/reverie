local function audience_redeem(center_table)
    if center_table.name == "Audience" then
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.cine_quests then
                    G.cine_quests.config.card_limit = G.cine_quests.config.card_limit + 1
                end

                return true
            end
        }))
    end
end

return {
    v_audience = {
        order = 1,
        name = "Audience",
        config = {
            extra = 25
        },
        cost = 10,
        pos = {
            x = 0,
            y = 0
        },
        unlocked = true,
        discovered = false,
        redeem = audience_redeem
    },
    v_virtuoso = {
        order = 2,
        name = "Virtuoso",
        requires = {
            "v_audience"
        },
        cost = 10,
        pos = {
            x = 0,
            y = 1
        },
        unlocked = true,
        discovered = false
    }
}