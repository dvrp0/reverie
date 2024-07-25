local function script_redeem(center_table)
    if center_table.name == "Script" and G.GAME.current_round.used_cine
    and not G.GAME.current_round.cine_temporary_shop_card_limit then
        G.GAME.current_round.cine_temporary_shop_card_limit = true
        change_shop_size(G.P_CENTERS.v_script.config.extra)
    end
end

local function megaphone_redeem(center_table)
    if center_table.name == "Megaphone" and G.cine_quests then
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, v in ipairs(G.cine_quests.cards) do
                    if v.ability.progress then
                        v.ability.extra.goal = Reverie.halve_cine_quest_goal(v.ability.extra.goal)

                        if v.ability.progress >= v.ability.extra.goal then
                            Reverie.complete_cine_quest(v)
                        end
                    end
                end

                return true
            end
        }))
    end
end

local vouchers = {
    {
        slug = "script",
        order = 1,
        name = "Script",
        config = {
            extra = 2
        },
        cost = 10,
        pos = {
            x = 0,
            y = 0
        },
        unlocked = true,
        discovered = false,
        redeem = script_redeem
    },
    {
        slug = "megaphone",
        order = 2,
        name = "Megaphone",
        requires = {
            "v_script"
        },
        config = {
            extra = 0.5
        },
        cost = 10,
        pos = {
            x = 0,
            y = 1
        },
        unlocked = true,
        discovered = false,
        redeem = megaphone_redeem
    }
}

table.sort(vouchers, function (a, b) return a.order < b.order end)

return vouchers