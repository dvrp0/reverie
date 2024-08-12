Reverie.atlases = {
    {
        key = "modicon",
        path = "icon.png",
        px = 34,
        py = 34
    },
    {
        key = "Cine",
        path = "cines.png",
        px = 71,
        py = 95
    },
    {
        key = "cine_jokers",
        path = "jokers.png",
        px = 71,
        py = 95
    },
    {
        key = "cine_boosters",
        path = "boosters.png",
        px = 71,
        py = 95
    },
    {
        key = "cine_vouchers",
        path = "vouchers.png",
        px = 71,
        py = 95
    },
    {
        key = "cine_tags",
        path = "tags.png",
        px = 34,
        py = 34
    },
    {
        key = "cine_backs",
        path = "backs.png",
        px = 71,
        py = 95
    }
}

for _, v in pairs(Reverie.atlases) do
    SMODS.Atlas(v)
end