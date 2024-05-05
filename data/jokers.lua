local function calculate_dynamic_film(self, context)
    if context.cine_progress and not context.blueprint then
        self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod

        card_eval_status_text(self, "extra", nil, nil, nil, {
            message = localize("k_upgrade_ex"),
            colour = G.C.CHIPS,
            card = self
        })
    elseif SMODS.end_calculate_context(context) and self.ability.extra.chips > 0 then
        return {
            message = localize{
                type = "variable",
                key = "a_chips",
                vars = {
                    self.ability.extra.chips
                }
            },
            chip_mod = self.ability.extra.chips
        }
    end
end

local jokers = {
    {
        slug = "dynamic_film",
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
        unlocked = true,
        discovered = false,
        blueprint_compat = true,
        eternal_compat = true,
        loc_def = function (self)
            return {self.ability.extra.chips, self.ability.extra.chip_mod}
        end,
        calculate = calculate_dynamic_film
    }
}

table.sort(jokers, function (a, b) return a.order < b.order end)

return jokers