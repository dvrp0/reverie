return {
    c_ive_no_shape = {
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
        },
        discovered = false
    },
    c_ive_no_shape_quest = {
        order = 19,
        name = "I Sing, I've No Shape Exchange Coupon",
        reward = "c_ive_no_shape",
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
        },
        discovered = false
    },
    c_unseen = {
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
        },
        discovered = false
    },
    c_unseen_quest = {
        order = 17,
        name = "The Unseen Exchange Coupon",
        reward = "c_unseen",
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
        },
        discovered = false
    },
    c_gem_heist = {
        order = 2,
        name = "Gem Heist",
        config = {
            extra = 25
        },
        cost = 4,
        pos = {
            x = 1,
            y = 0
        },
        discovered = false
    },
    c_gem_heist_quest = {
        order = 1,
        name = "Gem Heist Exchange Coupon",
        reward = "c_gem_heist",
        config = {
            extra = {
                goal = 2
            }
        },
        cost = 4,
        pos = {
            x = 3,
            y = 1
        },
        discovered = false
    },
    c_crazy_lucky = {
        order = 12,
        name = "Crazy Lucky",
        config = {
            extra = {
                mult = 1,
                kind = {
                    "p_crazy_lucky"
                }
            }
        },
        cost = 4,
        pos = {
            x = 7,
            y = 0
        },
        discovered = false
    },
    c_crazy_lucky_quest = {
        order = 11,
        name = "Crazy Lucky Exchange Coupon",
        reward = "c_crazy_lucky",
        config = {
            extra = {
                goal = 6
            }
        },
        cost = 4,
        pos = {
            x = 9,
            y = 1
        },
        discovered = false
    },
    c_tag_or_die = {
        order = 4,
        name = "Tag or Die",
        config = {
            extra = {
                cost = 8,
                kind = {
                    "p_tag_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 3,
            y = 0
        },
        discovered = false
    },
    c_tag_or_die_quest = {
        order = 3,
        name = "Tag or Die Exchange Coupon",
        reward = "c_tag_or_die",
        config = {
            extra = {
                goal = 4
            }
        },
        cost = 4,
        pos = {
            x = 5,
            y = 1
        },
        discovered = false
    },
    c_let_it_moon = {
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
        },
        discovered = false
    },
    c_let_it_moon_quest = {
        order = 7,
        name = "Let It Moon Exchange Coupon",
        reward = "c_let_it_moon",
        config = {
            extra = {
                goal = 10
            }
        },
        cost = 4,
        pos = {
            x = 2,
            y = 1
        },
        discovered = false
    },
    c_poker_face = {
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
        },
        discovered = false
    },
    c_poker_face_quest = {
        order = 9,
        name = "Poker Face Exchange Coupon",
        reward = "c_poker_face",
        config = {
            extra = {
                goal = 8
            }
        },
        cost = 4,
        pos = {
            x = 6,
            y = 1
        },
        discovered = false
    },
    c_eerie_inn = {
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
        },
        discovered = false
    },
    c_eerie_inn_quest = {
        order = 5,
        name = "Eerie Inn Exchange Coupon",
        reward = "c_eerie_inn",
        config = {
            extra = {
                goal = 5
            }
        },
        cost = 4,
        pos = {
            x = 7,
            y = 1
        },
        discovered = false
    },
    c_adrifting = {
        order = 14,
        name = "Adrifting",
        config = {
            extra = 1
        },
        cost = 4,
        pos = {
            x = 8,
            y = 0
        },
        discovered = false
    },
    c_adrifting_quest = {
        order = 13,
        name = "Adrifting Exchange Coupon",
        reward = "c_adrifting",
        config = {
            extra = {
                goal = 5
            }
        },
        cost = 4,
        pos = {
            x = 0,
            y = 2
        },
        discovered = false
    },
    c_morsel = {
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
        },
        discovered = false
    },
    c_morsel_quest = {
        order = 15,
        name = "Morsel Exchange Coupon",
        reward = "c_morsel",
        config = {
            extra = {
                goal = 2
            }
        },
        cost = 4,
        pos = {
            x = 1,
            y = 2
        },
        discovered = false
    },
    c_alchemist = {
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
        dependency = "CodexArcanum",
        discovered = false
    },
    c_alchemist_quest = {
        order = 21,
        name = "Fool Metal Alchemist Exchange Coupon",
        reward = "c_alchemist",
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
        dependency = "CodexArcanum",
        discovered = false
    },
    c_every_hue = {
        order = 24,
        name = "Every Hue",
        config = {
            extra = {
                rounds = 3,
                kind = {
                    "p_colour_"
                }
            }
        },
        cost = 4,
        pos = {
            x = 4,
            y = 2
        },
        dependency = "MoreFluff",
        discovered = false
    },
    c_every_hue_quest = {
        order = 23,
        name = "Every Hue Exchange Coupon",
        reward = "c_every_hue",
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
        dependency = "MoreFluff",
        discovered = false
    },
    c_radioactive = {
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
        dependency = "FusionJokers",
        discovered = false
    },
    c_radioactive_quest = {
        order = 25,
        name = "Radioactive Exchange Coupon",
        reward = "c_radioactive",
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
        dependency = "FusionJokers",
        discovered = false
    }
}