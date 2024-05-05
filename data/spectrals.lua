return {
    {
        slug = "reverie",
        order = 1,
        name = "Reverie",
        pos = {
            x = 1,
            y = 1
        },
        config = {},
        cost = 4,
        unlocked = true,
        discovered = false,
        can_use = function(self)
            return G.STATE == G.STATES.SHOP and G.shop
        end
    }
}