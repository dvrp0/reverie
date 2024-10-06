Reverie.shaders = {
    {
        key = "ticket",
        path = "ticket.fs"
    },
    {
        key = "ticket_negative",
        path = "ticket_negative.fs"
    },
    {
        key = "ticket_polychrome",
        path = "ticket_polychrome.fs"
    }
}

for _, v in pairs(Reverie.shaders) do
    SMODS.Shader(v)
end