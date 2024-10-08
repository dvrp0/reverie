local function apply_filmstrip(self)
    CardSleeves.Sleeve.apply(self)

    if self.get_current_deck_key() ~= "b_dvrprv_filmstrip" then
        G.GAME.starting_params.cine_quest_slots = G.GAME.starting_params.cine_quest_slots + self.config.cine_slot
    else
        G.GAME.cine_rate = self.config.rate
    end
end

local function trigger_stamp(self, args)
    CardSleeves.Sleeve.trigger_effect(self, args)

    if args.context == "setting_tags" then
        local tag = self.get_current_deck_key() == "b_dvrprv_stamp" and "tag_dvrprv_mega_tag" or "tag_dvrprv_jumbo_tag"

        G.GAME.round_resets.blind_tags.Small = tag
        G.GAME.round_resets.blind_tags.Big = tag
    end
end

Reverie.sleeves = {
    {
        key = "filmstrip",
        order = 1,
        name = "Filmstrip Sleeve",
        config = {
            cine_slot = 1,
            odds = 4,
            rate = 2
        },
        pos = {
            x = 0,
            y = 0
        },
        unlocked = false,
        unlock_condition = { deck = "b_dvrprv_filmstrip", stake = 6 },
        loc_vars = function (self)
            local key = self.key

            if self.get_current_deck_key() == "b_dvrprv_filmstrip" then
                key = key.."_alt"
            end

            return {key = key, vars = {self.config.cine_slot, ""..(G.GAME and G.GAME.probabilities.normal or 1), self.config.odds}}
        end,
        apply = apply_filmstrip
    },
    {
        key = "stamp",
        order = 2,
        name = "Stamp Sleeve",
        config = {},
        pos = {
            x = 1,
            y = 0
        },
        unlocked = false,
        unlock_condition = { deck = "b_dvrprv_stamp", stake = 5 },
        loc_vars = function (self)
            local key = self.key

            if self.get_current_deck_key() == "b_dvrprv_stamp" then
                key = key.."_alt"
            end

            return {key = key, vars = {
                localize{
                    type = "name_text",
                    key = "p_dvrprv_tag_jumbo",
                    set = "Other"
                }
            }}
        end,
        trigger_effect = trigger_stamp
    }
}

for _, v in pairs(Reverie.sleeves) do
    v.atlas = "cine_sleeves"

    CardSleeves.Sleeve(v)
end