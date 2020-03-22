local AI = class("AI")

local CharacterConst = require("game_obj.fight_obj.character.character_const")

function AI:ctor(battle)
    self._curBattle = battle
end

function AI:touch()
    
end

return AI