local function apply_filmstrip(self)
    G.GAME.starting_params.cine_quest_slots = G.GAME.starting_params.cine_quest_slots + self.config.cine_slot
end

local function trigger_stamp(self, args)
    if args.context == "setting_tags" then
        G.GAME.round_resets.blind_tags.Small = "tag_dvrprv_mega_tag"
        G.GAME.round_resets.blind_tags.Big = "tag_dvrprv_mega_tag"

        return
    end
end

Reverie.backs = {
    {
        key = "filmstrip",
        order = 1,
        name = "Filmstrip Deck",
        config = {
            cine_slot = 1
        },
        pos = {
            x = 0,
            y = 0
        },
        loc_vars = function (self, info_queue, center)
            return {vars = {self.config.cine_slot}}
        end,
        apply = apply_filmstrip
    },
    {
        key = "stamp",
        order = 2,
        name = "Stamp Deck",
        config = {},
        pos = {
            x = 1,
            y = 0
        },
        loc_vars = function (self, info_queue, center)
            return {vars = {
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

for _, v in pairs(Reverie.backs) do
    v.atlas = "cine_backs"

    SMODS.Back(v)
end