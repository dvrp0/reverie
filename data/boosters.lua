return {
    p_tag_normal_1 = {
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
        discovered = false
    },
    p_tag_normal_2 = {
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
        discovered = false
    },
    p_tag_jumbo_1 = {
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
        discovered = false
    },
    p_tag_mega_1 = {
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
        discovered = false
    },
    p_crazy_lucky_1 = {
        order = 6,
        name = "Pack",
        config = {
            extra = 4,
            choose = 1,
            weights = {
                ["Joker"] = 0.3,
                ["Consumeables"] = 0.25,
                ["Playing"] = 0.3,
                ["Tag"] = 0.1,
                ["Voucher"] = 0.05,
            }
        },
        kind = "Crazy",
        cost = 6,
        yes_pool_flag = "Crazy Lucky",
        pos = {
            x = 4,
            y = 0
        },
        discovered = false
    },
    p_flim_normal_1 = {
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
        discovered = false
    },
    p_flim_normal_2 = {
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
        discovered = false
    },
    p_flim_jumbo_1 = {
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
        discovered = false
    },
    p_flim_mega_1 = {
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
        discovered = false
    },
}