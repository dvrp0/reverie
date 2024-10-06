Reverie.consumables = {
    {
        key = "reverie",
        set = "Spectral",
        atlas = "Cine",
        order = 1,
        name = "Reverie",
        pos = {
            x = 1,
            y = 1
        },
        cost = 4,
        hidden = true,
        soul_set = "Cine",
        can_use = function (self, card)
            return G.STATE == G.STATES.SHOP and G.shop
        end,
        use = Reverie.use_cine
    }
}

for _, v in pairs(Reverie.consumables) do
    SMODS.Consumable(v)
end