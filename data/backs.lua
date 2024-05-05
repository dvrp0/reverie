local backs = {
    {
        slug = "filmstrip",
        order = 1,
        name = "Filmstrip Deck",
        config = {
            cine_slot = 1
        },
        pos = {
            x = 0,
            y = 0
        },
        unlocked = true,
        discovered = false
    },
    {
        slug = "stamp",
        order = 2,
        name = "Stamp Deck",
        config = {},
        pos = {
            x = 1,
            y = 0
        },
        unlocked = true,
        discovered = false
    }
}

table.sort(backs, function (a, b) return a.order < b.order end)

return backs