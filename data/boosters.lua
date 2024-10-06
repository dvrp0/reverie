local crazy_pack_sparkles = {
    timer = 0.05,
    scale = 0.1,
    lifespan = 2.5,
    speed = 0.7,
    padding = -3,
    colours = {G.C.WHITE, lighten(Reverie.badge_colour, 0.4), lighten(G.C.RED, 0.2)}
}
local film_pack_meteors = {
    timer = 0.035,
    scale = 0.1,
    lifespan = 1.5,
    speed = 4,
    colours = {lighten(Reverie.badge_colour, 0.2), G.C.WHITE}
}

local function create_tag_pack_card(self, card)
    return Reverie.create_tag_as_card(G.pack_cards, true, Reverie.booster_excludes)
end

local function ease_tag_pack_colour(self)
    ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.SECONDARY_SET.Tag, G.C.BLACK, 0.9))
    ease_background_colour{new_colour = G.C.SECONDARY_SET.Tag, special_colour = G.C.BLACK, contrast = 2}
end

local function create_crazy_pack_card(self, card)
    return Reverie.create_crazy_random_card(G.pack_cards, Reverie.booster_excludes)
end

local function ease_crazy_pack_colour(self)
    ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.SECONDARY_SET.Cine, G.C.BLACK, 0.9))
    ease_background_colour{new_colour = darken(G.C.RED, 0.2), special_colour = darken(G.C.SECONDARY_SET.Cine, 0.4), tertiary_colour = darken(G.C.BLACK, 0.2), contrast = 3}
end

local function create_film_pack_card(self, card)
    return create_card(card.ability.name:find("Mega") and "Cine" or "Cine_Quest", G.pack_cards, nil, nil, true, true, nil, "film")
end

local function ease_film_pack_colour(self)
    ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.SECONDARY_SET.Cine, G.C.BLACK, 0.9))
    ease_background_colour{new_colour = G.C.SECONDARY_SET.Cine, special_colour = G.C.BLACK, contrast = 2}
end

local function loc_vars(self, info_queue, center)
    local key = nil

    if self.name == "Tag Pack" then key = "p_dvrprv_tag_normal"
    elseif self.name == "Jumbo Tag Pack" then key = "p_dvrprv_tag_jumbo"
    elseif self.name == "Mega Tag Pack" then key = "p_dvrprv_tag_mega"
    elseif self.name == "Pack" then key = "p_dvrprv_crazy_lucky"
    elseif self.name == "Film Pack" then key = "p_dvrprv_film_normal"
    elseif self.name == "Jumbo Film Pack" then key = "p_dvrprv_film_jumbo"
    elseif self.name == "Mega Film Pack" then key = "p_dvrprv_film_mega"
    end

    return {
        vars = {Reverie.get_var_object(center, self).choose, Reverie.get_var_object(center, self).extra},
        key = key
    }
end

local function generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    local info = self:loc_vars(info_queue, card)

    if not full_UI_table.name then
        full_UI_table.name = localize{type = "name", set = "Other", key = info.key, nodes = full_UI_table.name}
    end

    localize{type = "other", key = info.key, nodes = desc_nodes, vars = info.vars}
end

local function generate_detailed_tooltip(self, info_queue, card, desc_nodes)
    desc_nodes.name = localize{type = "name_text", set = "Other", key = self:loc_vars(info_queue, card).key}
end

Reverie.boosters = {
    {
        key = "tag_normal_1",
        group_key = "k_dvrprv_tag_pack",
        order = 1,
        name = "Tag Pack",
        config = {
            extra = 2,
            choose = 1
        },
        weight = 1,
        kind = "Tag",
        cost = 4,
        yes_pool_flag = "Tag or Die",
        pos = {
            x = 0,
            y = 0
        },
        create_card = create_tag_pack_card,
        ease_background_colour = ease_tag_pack_colour
    },
    {
        key = "tag_normal_2",
        group_key = "k_dvrprv_tag_pack",
        order = 2,
        name = "Tag Pack",
        config = {
            extra = 2,
            choose = 1
        },
        weight = 1,
        kind = "Tag",
        cost = 4,
        yes_pool_flag = "Tag or Die",
        pos = {
            x = 1,
            y = 0
        },
        create_card = create_tag_pack_card,
        ease_background_colour = ease_tag_pack_colour
    },
    {
        key = "tag_jumbo_1",
        group_key = "k_dvrprv_tag_pack",
        order = 3,
        name = "Jumbo Tag Pack",
        config = {
            extra = 4,
            choose = 1
        },
        weight = 1,
        kind = "Tag",
        cost = 6,
        yes_pool_flag = "Tag or Die",
        pos = {
            x = 2,
            y = 0
        },
        create_card = create_tag_pack_card,
        ease_background_colour = ease_tag_pack_colour
    },
    {
        key = "tag_mega_1",
        group_key = "k_dvrprv_tag_pack",
        order = 4,
        name = "Mega Tag Pack",
        config = {
            extra = 4,
            choose = 2
        },
        weight = 0.25,
        kind = "Tag",
        cost = 8,
        yes_pool_flag = "Tag or Die",
        pos = {
            x = 3,
            y = 0
        },
        create_card = create_tag_pack_card,
        ease_background_colour = ease_tag_pack_colour
    },
    {
        key = "crazy_lucky_1",
        group_key = "k_dvrprv_crazy_pack",
        order = 6,
        name = "Pack",
        config = {
            extra = 4,
            choose = 1,
            weights = {
                ["Joker"] = 1,
                ["Consumeables"] = 0.75,
                ["Playing"] = 1,
                ["Tag"] = 0.15,
                ["Voucher"] = 0.05,
                ["Cine"] = 0.01
            }
        },
        weight = 1,
        kind = "Crazy",
        cost = 6,
        yes_pool_flag = "Crazy Lucky",
        pos = {
            x = 4,
            y = 0
        },
        create_card = create_crazy_pack_card,
        ease_background_colour = ease_crazy_pack_colour,
        sparkles = crazy_pack_sparkles
    },
    {
        key = "film_normal_1",
        group_key = "k_dvrprv_film_pack",
        order = 7,
        name = "Film Pack",
        config = {
            extra = 2,
            choose = 1
        },
        weight = 1,
        kind = "Cine",
        cost = 4,
        pos = {
            x = 1,
            y = 1
        },
        create_card = create_film_pack_card,
        ease_background_colour = ease_film_pack_colour,
        meteors = film_pack_meteors
    },
    {
        key = "film_normal_2",
        group_key = "k_dvrprv_film_pack",
        order = 8,
        name = "Film Pack",
        config = {
            extra = 2,
            choose = 1
        },
        weight = 1,
        kind = "Cine",
        cost = 4,
        pos = {
            x = 2,
            y = 1
        },
        create_card = create_film_pack_card,
        ease_background_colour = ease_film_pack_colour,
        meteors = film_pack_meteors
    },
    {
        key = "film_jumbo_1",
        group_key = "k_dvrprv_film_pack",
        order = 9,
        name = "Jumbo Film Pack",
        config = {
            extra = 4,
            choose = 1
        },
        weight = 0.6,
        kind = "Cine",
        cost = 6,
        pos = {
            x = 3,
            y = 1
        },
        create_card = create_film_pack_card,
        ease_background_colour = ease_film_pack_colour,
        meteors = film_pack_meteors
    },
    {
        key = "film_mega_1",
        group_key = "k_dvrprv_film_pack",
        order = 10,
        name = "Mega Film Pack",
        config = {
            extra = 2,
            choose = 1
        },
        weight = 0.07,
        kind = "Cine",
        cost = 8,
        pos = {
            x = 4,
            y = 1
        },
        create_card = create_film_pack_card,
        ease_background_colour = ease_film_pack_colour,
        meteors = film_pack_meteors
    }
}

for _, v in pairs(Reverie.boosters) do
    v.atlas = "cine_boosters"
    v.loc_vars = loc_vars
    v.generate_ui = generate_ui
    v.generate_detailed_tooltip = generate_detailed_tooltip

    SMODS.Booster(v)
end