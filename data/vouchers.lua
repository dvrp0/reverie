local function redeem_script(center_table)
    if center_table.name == "Script" and G.GAME.current_round.used_cine
    and not G.GAME.current_round.cine_temporary_shop_card_limit then
        G.GAME.current_round.cine_temporary_shop_card_limit = true
        change_shop_size(center_table.config.extra)
    end
end

local function redeem_megaphone(center_table)
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

Reverie.vouchers = {
    {
        key = "script",
        order = 1,
        name = "Script",
        config = {
            extra = 2
        },
        pos = {
            x = 0,
            y = 0
        },
        redeem = redeem_script,
        loc_vars = function (self, info_queue, center)
            return {vars = {center.ability.extra}}
        end
    },
    {
        key = "megaphone",
        order = 2,
        name = "Megaphone",
        requires = {
            "v_dvrprv_script"
        },
        config = {
            extra = 0.5
        },
        pos = {
            x = 0,
            y = 1
        },
        redeem = redeem_megaphone
    }
}

for _, v in pairs(Reverie.vouchers) do
    v.atlas = "cine_vouchers"

    SMODS.Voucher(v)
end