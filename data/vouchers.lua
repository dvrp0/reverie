local function megaphone_redeem(center_table)
    if center_table.name == "Megaphone" and G.cine_quests then
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, v in ipairs(G.cine_quests.cards) do
                    if v.ability.progress then
                        v.ability.progress_goal = Reverie.halve_cine_quest_goal(v.ability.progress_goal)

                        if v.ability.progress >= v.ability.progress_goal then
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
            extra = 1
        },
        cost = 10,
        pos = {
            x = 0,
            y = 0
        },
        unlocked = true,
        discovered = false
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