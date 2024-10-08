SMODS.UndiscoveredSprite{
    key = "Cine",
    atlas = "Cine",
    pos = {
        x = 0,
        y = 1
    }
}

local function your_collection_cine_page(args)
    if not args or not args.cycle_config then
        return
    end

    for j = 1, #G.your_collection do
        for i = #G.your_collection[j].cards, 1, -1 do
            local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
            c:remove()
            c = nil
        end
    end

    local cines = {}
    for _, v in pairs(G.P_CENTER_POOLS.Cine) do
        table.insert(cines, v)
    end
    for _, v in pairs(G.P_CENTER_POOLS.Cine_Quest) do
        table.insert(cines, v)
    end

    table.sort(cines, function (a, b) return a.order < b.order end)

    for j = 1, #G.your_collection do
        for i = 1, (1 + j) * 2 do
            local center = cines[i + (j - 1) * 4 + (10 * (args.cycle_config.current_option - 1))]
            if not center then
                break
            end

            local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
            card:start_materialize(nil, i > 1 or j > 1)
            G.your_collection[j]:emplace(card)
        end
    end

    INIT_COLLECTION_CARD_ALERTS()
end

local function create_UIBox_your_collection_cines(self)
    local deck_tables = {}

    G.your_collection = {}
    for j = 1, 2 do
        G.your_collection[j] = CardArea(G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h, (4.25 + (j == 2 and 2 or 0)) * G.CARD_W, 1 * G.CARD_H, {
            card_limit = (1 + j) * 2,
            type = "voucher",
            highlight_limit = 0,
            collection = true
        })
        table.insert(deck_tables, {
            n = G.UIT.R,
            config = {
                align = "cm",
                padding = 0,
                no_fill = true
            },
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        object = G.your_collection[j]
                    }
                }
            }
        })
    end

    local cines = {}
    for _, v in pairs(G.P_CENTER_POOLS.Cine) do
        table.insert(cines, v)
    end
    for _, v in pairs(G.P_CENTER_POOLS.Cine_Quest) do
        table.insert(cines, v)
    end

    table.sort(cines, function (a, b) return a.order < b.order end)

    local cine_options = {}
    for i = 1, math.ceil(#cines / (5 * #G.your_collection)) do
        table.insert(cine_options, localize("k_page").." "..tostring(i).."/"..tostring(math.ceil(#cines / (5 * #G.your_collection))))
    end

    for j = 1, #G.your_collection do
        for i = 1, (1 + j) * 2 do
            local center = cines[i + (j - 1) * 4]
            local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
            card.ability.order = i + (j - 1) * 4

            card:start_materialize(nil, i > 1 or j > 1)
            G.your_collection[j]:emplace(card)
        end
    end

    INIT_COLLECTION_CARD_ALERTS()

    local option_nodes = {
        create_option_cycle({
            options = cine_options,
            w = 4.5,
            cycle_shoulders = true,
            opt_callback = "your_collection_cine_page",
            focus_args = {
                snap_to = true,
                nav = "wide"
            },
            current_option = 1,
            colour = G.C.RED,
            no_pips = true
        })
    }
    local type_buf = {}

    if G.ACTIVE_MOD_UI then
        for _, v in ipairs(SMODS.ConsumableType.obj_buffer) do
            if modsCollectionTally(G.P_CENTER_POOLS[v]).of > 0 then type_buf[#type_buf + 1] = v end
        end
    else
        type_buf = SMODS.ConsumableType.obj_buffer
    end

    local t = create_UIBox_generic_options({
        back_func = #type_buf>3 and 'your_collection_consumables' or G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
        contents = {
            { n = G.UIT.R, config = { align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
            { n = G.UIT.R, config = { align = "cm", padding = 0 },                                                           nodes = option_nodes },
        }
    })

    return t
end

SMODS.ConsumableType{
    key = "Cine",
    collection_rows = { 4, 6 },
    primary_colour = G.C.SET.Joker,
    secondary_colour = Reverie.badge_colour,
    loc_txt = {
        collection = "Cine Cards",
        name = "Cine",
        label = "Cine"
    },
    create_UIBox_your_collection = create_UIBox_your_collection_cines,
    inject = function (self)
        SMODS.ConsumableType.inject(self)

        G.P_CENTER_POOLS.Cine = {}
        G.P_CENTER_POOLS.Cine_Quest = {}
        G.C.SECONDARY_SET.Tag = HEX("a6b8ce")
        G.FUNCS.your_collection_cine_page = your_collection_cine_page
    end,
    inject_card = function (self, center)
        SMODS.ConsumableType.inject_card(self, center)

        if center.reward then
            SMODS.remove_pool(G.P_CENTER_POOLS.Cine, center.key)
            SMODS.insert_pool(G.P_CENTER_POOLS.Cine_Quest, center)
        end
    end,
    delete_card = function (self, center)
        SMODS.ConsumableType.delete_card(self, center)
        SMODS.remove_pool(G.P_CENTER_POOLS[center.reward and "Cine_Quest" or "Cine"], center.key)
    end
}

local function can_use(self, card)
    if card.config.center.reward then
        return false
    else
        return G.STATE == G.STATES.SHOP and G.shop
    end
end

local function loc_vars(self, info_queue, center)
    local vars = nil

    if center and center.config.center.reward and center.ability.progress then
        info_queue[#info_queue + 1] = G.P_CENTERS[center.config.center.reward]

        if center.config.center.reward == "c_dvrprv_unseen" then
            vars = {center.ability.extra.slots, center.ability.extra.goal, center.ability.progress}
        elseif center.config.center.reward == "c_dvrprv_ive_no_shape" then
            vars = {center.ability.extra.chips, center.ability.extra.goal, center.ability.progress}
        elseif center.config.center.reward == "c_dvrprv_jovial_m" then
            info_queue[#info_queue + 1] = {
                key = "j_jolly",
                set = "Joker",
                specific_vars = {G.P_CENTERS.j_jolly.config.t_mult, G.P_CENTERS.j_jolly.config.type}
            }
            vars = {center.ability.extra.goal, center.ability.progress, localize{
                type = "name_text",
                set = "Joker",
                key = "j_jolly"
            }}
        else
            vars = {center.ability.extra.goal, center.ability.progress}
        end
    else
        if self.name == "Tag or Die" then
            vars = {Reverie.get_var_object(center, self).extra.cost}
        elseif self.name == "The Unseen" or self.name == "Eerie Inn" then
            vars = {Reverie.get_var_object(center, self).extra.mult}
        elseif self.name == "I Sing, I've No Shape" then
            vars = {Reverie.get_var_object(center, self).extra.add}
        elseif self.name == "Crazy Lucky" then
            local info = G.P_CENTERS.p_dvrprv_crazy_lucky_1:loc_vars(info_queue)

            info_queue[#info_queue + 1] = {
                key = info.key,
                set = "Other",
                vars = info.vars
            }
        elseif self.name == "Fool Metal Alchemist" then
            vars = {Reverie.get_var_object(center, self).extra.slot}
        elseif self.name == "Every Hue" then
            vars = {Reverie.get_var_object(center, self).extra.rounds}
        else
            vars = {Reverie.get_var_object(center, self).extra}
        end
    end

    return {vars = vars}
end

local function inject(self)
    local order_cache = self.order
    local reward_cache = self.reward

    SMODS.Consumable.inject(self)
    self.order = order_cache
    self.reward = reward_cache
end

Reverie.cines = {
    {
        key = "ive_no_shape",
        order = 20,
        name = "I Sing, I've No Shape",
        config = {
            extra = {
                add = 20
            }
        },
        cost = 4,
        pos = {
            x = 6,
            y = 0
        }
    },
    {
        key = "ive_no_shape_quest",
        order = 19,
        name = "I Sing, I've No Shape Exchange Coupon",
        reward = "c_dvrprv_ive_no_shape",
        config = {
            extra = {
                chips = 2,
                goal = 3
            }
        },
        cost = 4,
        pos = {
            x = 8,
            y = 1
        }
    },
    {
        key = "unseen",
        order = 18,
        name = "The Unseen",
        config = {
            extra = {
                mult = 5
            }
        },
        cost = 4,
        pos = {
            x = 2,
            y = 0
        }
    },
    {
        key = "unseen_quest",
        order = 17,
        name = "The Unseen Exchange Coupon",
        reward = "c_dvrprv_unseen",
        config = {
            extra = {
                slots = 1,
                goal = 5
            }
        },
        cost = 4,
        pos = {
            x = 4,
            y = 1
        }
    },
    {
        key = "gem_heist",
        order = 2,
        name = "Gem Heist",
        config = {
            extra = 25
        },
        cost = 4,
        pos = {
            x = 1,
            y = 0
        }
    },
    {
        key = "gem_heist_quest",
        order = 1,
        name = "Gem Heist Exchange Coupon",
        reward = "c_dvrprv_gem_heist",
        config = {
            extra = {
                goal = 2
            }
        },
        cost = 4,
        pos = {
            x = 3,
            y = 1
        }
    },
    {
        key = "crazy_lucky",
        order = 12,
        name = "Crazy Lucky",
        config = {
            extra = {
                mult = 1,
                kind = {
                    "p_dvrprv_crazy_lucky"
                }
            }
        },
        cost = 4,
        pos = {
            x = 7,
            y = 0
        }
    },
    {
        key = "crazy_lucky_quest",
        order = 11,
        name = "Crazy Lucky Exchange Coupon",
        reward = "c_dvrprv_crazy_lucky",
        config = {
            extra = {
                goal = 6
            }
        },
        cost = 4,
        pos = {
            x = 9,
            y = 1
        }
    },
    {
        key = "tag_or_die",
        order = 4,
        name = "Tag or Die",
        config = {
            extra = {
                cost = 8,
                kind = {
                    "p_dvrprv_tag_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 3,
            y = 0
        }
    },
    {
        key = "tag_or_die_quest",
        order = 3,
        name = "Tag or Die Exchange Coupon",
        reward = "c_dvrprv_tag_or_die",
        config = {
            extra = {
                goal = 4
            }
        },
        cost = 4,
        pos = {
            x = 5,
            y = 1
        }
    },
    {
        key = "let_it_moon",
        order = 8,
        name = "Let It Moon",
        config = {
            extra = {
                kind = {
                    "p_arcana_",
                    "p_celestial_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 0,
            y = 0
        }
    },
    {
        key = "let_it_moon_quest",
        order = 7,
        name = "Let It Moon Exchange Coupon",
        reward = "c_dvrprv_let_it_moon",
        config = {
            extra = {
                goal = 10
            }
        },
        cost = 4,
        pos = {
            x = 2,
            y = 1
        }
    },
    {
        key = "poker_face",
        order = 10,
        name = "Poker Face",
        config = {
            extra = {
                kind = {
                    "p_standard_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 4,
            y = 0
        }
    },
    {
        key = "poker_face_quest",
        order = 9,
        name = "Poker Face Exchange Coupon",
        reward = "c_dvrprv_poker_face",
        config = {
            extra = {
                goal = 8
            }
        },
        cost = 4,
        pos = {
            x = 6,
            y = 1
        }
    },
    {
        key = "eerie_inn",
        order = 6,
        name = "Eerie Inn",
        config = {
            extra = {
                mult = 2,
                kind = {
                    "p_spectral_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 5,
            y = 0
        }
    },
    {
        key = "eerie_inn_quest",
        order = 5,
        name = "Eerie Inn Exchange Coupon",
        reward = "c_dvrprv_eerie_inn",
        config = {
            extra = {
                goal = 5
            }
        },
        cost = 4,
        pos = {
            x = 7,
            y = 1
        }
    },
    {
        key = "adrifting",
        order = 14,
        name = "Adrifting",
        config = {
            extra = 1
        },
        cost = 4,
        pos = {
            x = 8,
            y = 0
        }
    },
    {
        key = "adrifting_quest",
        order = 13,
        name = "Adrifting Exchange Coupon",
        reward = "c_dvrprv_adrifting",
        config = {
            extra = {
                goal = 5
            }
        },
        cost = 4,
        pos = {
            x = 0,
            y = 2
        }
    },
    {
        key = "morsel",
        order = 16,
        name = "Morsel",
        config = {
            extra = {
                kind = {
                    "p_buffoon_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 9,
            y = 0
        }
    },
    {
        key = "morsel_quest",
        order = 15,
        name = "Morsel Exchange Coupon",
        reward = "c_dvrprv_morsel",
        config = {
            extra = {
                goal = 2
            }
        },
        cost = 4,
        pos = {
            x = 1,
            y = 2
        }
    },
    {
        key = "alchemist",
        order = 22,
        name = "Fool Metal Alchemist",
        config = {
            extra = {
                slot = 2,
                kind = {
                    "p_alchemy_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 2,
            y = 2
        },
        dependency = "CodexArcanum"
    },
    {
        key = "alchemist_quest",
        order = 21,
        name = "Fool Metal Alchemist Exchange Coupon",
        reward = "c_dvrprv_alchemist",
        config = {
            extra = {
                goal = 5
            }
        },
        cost = 4,
        pos = {
            x = 3,
            y = 2
        },
        dependency = "CodexArcanum"
    },
    {
        key = "every_hue",
        order = 24,
        name = "Every Hue",
        config = {
            extra = {
                rounds = 3,
                kind = {
                    "p_mf_colour_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 4,
            y = 2
        },
        dependency = "MoreFluff"
    },
    {
        key = "every_hue_quest",
        order = 23,
        name = "Every Hue Exchange Coupon",
        reward = "c_dvrprv_every_hue",
        config = {
            extra = {
                goal = 2
            }
        },
        cost = 4,
        pos = {
            x = 5,
            y = 2
        },
        dependency = "MoreFluff"
    },
    {
        key = "radioactive",
        order = 26,
        name = "Radioactive",
        config = {
            extra = {
                kind = {
                    "p_buffoon_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 6,
            y = 2
        },
        dependency = "FusionJokers"
    },
    {
        key = "radioactive_quest",
        order = 25,
        name = "Radioactive Exchange Coupon",
        reward = "c_dvrprv_radioactive",
        config = {
            extra = {
                goal = 1
            }
        },
        cost = 4,
        pos = {
            x = 7,
            y = 2
        },
        dependency = "FusionJokers"
    },
    {
        key = "jovial_m",
        order = 28,
        name = "Jovial M",
        config = {
            extra = {
                kind = {
                    "p_buffoon_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 8,
            y = 2
        },
        dependency = "Cryptid"
    },
    {
        key = "jovial_m_quest",
        order = 27,
        name = "Jovial M Exchange Coupon",
        reward = "c_dvrprv_jovial_m",
        config = {
            extra = {
                goal = 3
            }
        },
        cost = 4,
        pos = {
            x = 9,
            y = 2
        },
        dependency = "Cryptid"
    }
}

table.sort(Reverie.cines, function (a, b) return a.order < b.order end)

for _, v in pairs(Reverie.cines) do
    v.set = "Cine"
    v.atlas = "Cine"
    v.can_use = can_use
    v.loc_vars = loc_vars
    v.inject = inject
    v.use = not v.reward and Reverie.use_cine or nil

    if not v.dependency or Reverie.find_mod(v.dependency) then
        SMODS.Consumable(v)
    end
end