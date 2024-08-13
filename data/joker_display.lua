-- JokerDisplay by nh6574
-- https://github.com/nh6574/JokerDisplay/blob/main/src/display_functions.lua

local progress_text = {
    { ref_table = "card.ability", ref_value = "progress", colour = Reverie.cine_color },
    { text = "/" },
    { ref_table = "card.ability.extra", ref_value = "goal" }
}

function Card:update_cine_display(force_update, force_reload, _from)
    if self.ability and self.ability.set == "Cine" then
        --print(tostring(self.ability.name) .. " : " .. tostring(_from))
        if not self.children.joker_display then
            self.joker_display_values = {}
            self.joker_display_values.disabled = JokerDisplay.config.hide_by_default
            self.joker_display_values.small = false

            --Regular Display
            self.children.joker_display = JokerDisplayBox(self, "joker_display_disable", { type = "NORMAL" })
            self.children.joker_display_small = JokerDisplayBox(self, "joker_display_small_enable", { type = "SMALL" })
            self.children.joker_display_debuff = JokerDisplayBox(self, "joker_display_debuff", { type = "DEBUFF" })
            self:initialize_joker_display()

            --Perishable Display
            self.config.joker_display_perishable = {
                n = G.UIT.ROOT,
                config = {
                    minh = 0.5,
                    maxh = 0.5,
                    minw = 0.75,
                    maxw = 0.75,
                    r = 0.001,
                    padding = 0.1,
                    align = 'cm',
                    colour = adjust_alpha(darken(G.C.BLACK, 0.2), 0.8),
                    shadow = false,
                    func = 'joker_display_perishable',
                    ref_table = self
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = { { n = G.UIT.R, config = { align = "cm" }, nodes = { JokerDisplay.create_display_text_object({ ref_table = self.joker_display_values, ref_value = "perishable", colour = lighten(G.C.PERISHABLE, 0.35), scale = 0.35 }) } } }
                    }

                }
            }

            self.config.joker_display_perishable_config = {
                align = "tl",
                bond = 'Strong',
                parent = self,
                offset = { x = 0.8, y = 0 },
            }
            if self.config.joker_display_perishable then
                self.children.joker_display_perishable = UIBox {
                    definition = self.config.joker_display_perishable,
                    config = self.config.joker_display_perishable_config,
                }
                self.children.joker_display_perishable.states.collide.can = true
                self.children.joker_display_perishable.name = "JokerDisplay"
            end

            --Rental Display
            self.config.joker_display_rental = {
                n = G.UIT.ROOT,
                config = {
                    minh = 0.5,
                    maxh = 0.5,
                    minw = 0.75,
                    maxw = 0.75,
                    r = 0.001,
                    padding = 0.1,
                    align = 'cm',
                    colour = adjust_alpha(darken(G.C.BLACK, 0.2), 0.8),
                    shadow = false,
                    func = 'joker_display_rental',
                    ref_table = self
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = { { n = G.UIT.R, config = { align = "cm" }, nodes = { JokerDisplay.create_display_text_object({ ref_table = self.joker_display_values, ref_value = "rental", colour = G.C.GOLD, scale = 0.35 }) } } }
                    }

                }
            }

            self.config.joker_display_rental_config = {
                align = "tr",
                bond = 'Strong',
                parent = self,
                offset = { x = -0.8, y = 0 },
            }
            if self.config.joker_display_rental then
                self.children.joker_display_rental = UIBox {
                    definition = self.config.joker_display_rental,
                    config = self.config.joker_display_rental_config,
                }
                self.children.joker_display_rental.states.collide.can = true
                self.children.joker_display_rental.name = "JokerDisplay"
            end
        else
            if force_update or (JokerDisplay.config.enabled and
                    (self:joker_display_has_info() or not JokerDisplay.config.hide_empty)
                    and (not self.joker_display_values.disabled)) then
                if force_reload then
                    self:initialize_joker_display()
                else
                    self:calculate_joker_display()
                end
            end
        end
    end
end

local card_update_ref = Card.update
function Card:update(dt)
    card_update_ref(self, dt)

    if JokerDisplay.config.enabled and G.cine_quests and self.area == G.cine_quests then
        if not self.joker_display_last_update_time then
            self.joker_display_last_update_time = 0
            self.joker_display_update_time_variance = math.random()
            local joker_number_delta_variance = math.max(0.2, #G.jokers.cards / 20)
            self.joker_display_next_update_time = joker_number_delta_variance / 2 +
                joker_number_delta_variance / 2 * self.joker_display_update_time_variance
        elseif self.joker_display_values and G.real_dt > 0.05 and #G.jokers.cards > 20 then
            self.joker_display_values.disabled = true
        else
            self.joker_display_last_update_time = self.joker_display_last_update_time + dt
            if self.joker_display_last_update_time > self.joker_display_next_update_time then
                self.joker_display_last_update_time = 0
                local joker_number_delta_variance = math.max(0.2, #G.jokers.cards / 20)
                self.joker_display_next_update_time = joker_number_delta_variance / 2 +
                    joker_number_delta_variance / 2 * self.joker_display_update_time_variance
                self:update_cine_display(false, false, "Card:update")
            end
        end
    end
end

Reverie.joker_display_definitions = {
    c_dvrprv_ive_no_shape_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "X", colour = G.C.ORANGE },
            { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.ORANGE },
            { text = " Chips)" }
        }
    },
    c_dvrprv_unseen_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "slots", colour = G.C.ORANGE },
            { text = " Joker slot", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_gem_heist_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Editioned Joker", colour = G.C.DARK_EDITION },
            { text = ")" }
        }
    },
    c_dvrprv_crazy_lucky_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Booster Pack", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_tag_or_die_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Skip Blind", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_let_it_moon_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Planet", colour = G.C.SECONDARY_SET.Planet },
            { text = "/" },
            { text = "Tarot", colour = G.C.SECONDARY_SET.Tarot },
            { text = ")" }
        }
    },
    c_dvrprv_poker_face_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Enhance", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_eerie_inn_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Destroy", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_adrifting_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Debuffed", colour = G.C.ORANGE },
            { text = "/" },
            { text = "Flipped", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_morsel_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Food Joker", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_alchemist_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Alchemical", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_every_hue_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Colour", colour = G.C.ORANGE },
            { text = ")" }
        }
    },
    c_dvrprv_radioactive_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { text = "Fusion", colour = G.C.GOLD },
            { text = ")" }
        }
    },
    c_dvrprv_jovial_m_quest = {
        text = progress_text,
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
            { text = ")" }
        },
        calc_function = function (card)
            card.joker_display_values.localized_text = localize{
                type = "name_text",
                set = "Joker",
                key = "j_jolly"
            }
        end
    }
}

for k, v in pairs(Reverie.joker_display_definitions) do
    JokerDisplay.Definitions[k] = v
end