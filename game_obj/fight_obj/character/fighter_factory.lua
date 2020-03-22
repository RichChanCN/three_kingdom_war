local FighterFactory = {}
local CharacterConst = require("game_obj.fight_obj.character.character_const")

local FighterClass = {
    [CharacterConst.FIGHT_TYPE.WARRIOR] = require("game_obj.fight_obj.character.fighter_warrior"),
    [CharacterConst.FIGHT_TYPE.DEFENDER] = require("game_obj.fight_obj.character.fighter_defender"),
    [CharacterConst.FIGHT_TYPE.CASTER] = require("game_obj.fight_obj.character.fighter_caster"),
    [CharacterConst.FIGHT_TYPE.RIDER] = require("game_obj.fight_obj.character.fighter_rider"),
    [CharacterConst.FIGHT_TYPE.ARCHER] = require("game_obj.fight_obj.character.fighter_archer"),
}

function FighterFactory.new(char, side, pos)
    local cType = char:getFightType()
    local charClass = FighterClass[cType]

    return charClass.new(char, side, pos)
end

return FighterFactory