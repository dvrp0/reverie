local function calculate_dynamic_film(self, card, context)
    if context.cine_progress and not context.blueprint then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod

        card_eval_status_text(card, "extra", nil, nil, nil, {
            message = localize("k_upgrade_ex"),
            colour = G.C.CHIPS,
            card = card
        })
    elseif context.joker_main and card.ability.extra.chips > 0 then
        return {
            message = localize{
                type = "variable",
                key = "a_chips",
                vars = {
                    card.ability.extra.chips
                }
            },
            chip_mod = card.ability.extra.chips
        }
    end
end

Reverie.jokers = {
    {
        key = "dynamic_film",
        order = 1,
        name = "Dynamic Film",
        config = {
            extra = {
                chips = 0,
                chip_mod = 15
            }
        },
        rarity = 1,
        cost = 4,
        blueprint_compat = true,
        loc_vars = function (self, info_queue, center)
            return {vars = {center.ability.extra.chips, center.ability.extra.chip_mod}}
        end,
        calculate = calculate_dynamic_film
    }
}

for _, v in ipairs(Reverie.jokers) do
    v.atlas = "cine_jokers"

    SMODS.Joker(v)
end