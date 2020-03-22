local ArenaMap = class("ArenaMap", function()
    return cc.Node:create()
end)
local CharacterConst = require("game_obj.fight_obj.character.character_const")
local BattleConst = require("module.battle.battle_const")
local SIDE = BattleConst.SIDE

local MAP = {
    TOP = 60,
    BOT = -60,
    LEFT = -250,
    RIGHT = 250,
}

local ins
function ArenaMap.getIns()
    return ins
end

function ArenaMap:ctor()
    ins = self
end

function ArenaMap.getBornPos(side)
    if side == SIDE.LEFT then
        return cc.p(MAP.LEFT, 0)
    else
        return cc.p(MAP.RIGHT, 0)
    end
end

function ArenaMap:addFightObj(fightObj)
    local side = fightObj:getSide()
    local fType = fightObj:getFightType()
    self:addChild(fightObj)
    fightObj:setPosition(ArenaMap.getBornPos(side))
    local prePos = self:getPrePosBySideAndFightType(side, fType)
    fightObj:moveTo(prePos)
end

function ArenaMap:getPrePosBySideAndFightType(side, fType)
    local side = side == SIDE.LEFT and -1 or 1
    local x = (fType + 1) * 50 * side
    local offset = math.random(40) - 20
    local y = math.random(MAP.BOT, MAP.TOP)
    local pos = cc.p(x + offset, y)

    return pos
end

return ArenaMap