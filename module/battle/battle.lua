local Battle = class("Battle")
local BattleConst = require("module.battle.battle_const")
local BattleRandom = require("module.battle.battle_random")
local AI = require("module.battle.ai")
local ArenaMap = require("module.battle.arena_map")
local SIDE = BattleConst.SIDE
local OPPONENT_SIDE = BattleConst.OPPONENT_SIDE

local ins = nil
function Battle.getIns()
    return ins
end

function Battle:ctor(randomSeed, mapNode)
    ins = self
    self._mapNode = mapNode
    self:init(randomSeed)
end

function Battle:isRunning()
    return self._isRunning
end

function Battle:init(randomSeed)
    self._fightObjs = {}
    self._fightObjs[SIDE.LEFT] = {}
    self._fightObjs[SIDE.RIGHT] = {}
    
    self._isRunning = false
    self._ai = AI.new(self)

    BattleRandom.setSeed(randomSeed)
end

function Battle:addFightObj(fightObj)
    local side = fightObj:getSide()
    local uid = fightObj:getUid()
    self._fightObjs[side][uid] = fightObj

    self._mapNode:addFightObj(fightObj)
    self._ai:touch(fightObj)
end

function Battle:getAliveTargetBySide(side)
    local list = self._fightObjs[BattleConst.OPPONENT_SIDE[side]]

    local aliveList = {}
    for k, v in pairs(list) do
        if v:isAlive() then
            table.insert(aliveList, v)
        end
    end

    return aliveList[math.random(#aliveList)]
end

function Battle:start()
    for _, sideList in pairs(self._fightObjs) do
        for k, v in pairs(sideList) do
            v:findTarget()
        end
    end
end

return Battle