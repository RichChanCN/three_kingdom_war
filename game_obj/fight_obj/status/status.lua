local Status = class("Status")

local CfgStatus = loadCfg("status")
local EffectFactory = require("game_obj.fight_obj.effect.effect_factory")


function Status.newList(idList)
    idList = idList or {}
    local list = {}
    for i, v in ipairs(idList) do
        list[i] = Status.new(v)
    end

    return list
end

function Status:ctor(tid)
    self._tid = tid
    self._grade = 1

    self._cfgInfo = CfgStatus[tid]
    
    self:_initEffectList()
end

function Status:_initEffectList()
    self._effectList = EffectFactory.newList(self._cfgInfo.effectList)
    for i, v in ipairs(self._effectList) do
        v:setHostStatus(self)
    end
end

function Status:getUid()
    return self._owner:getUid() .. "_status_" .. self._tid
end

function Status:getName()
    return self._cfgInfo.name or self:getUid()
end

function Status:setGrade(grade)
    self._grade = grade
    
    for i, v in ipairs(self._effectList) do
        v:setGrade(grade)
    end

    self:update()
end

function Status:update()
    self._turnNum = self:getDuration()
    self._remainTurnNum = self:getDuration()
    self._maxStackCount = self:getMaxStackCount()
end

function Status:setOwner(owner)
    self._owner = owner

    for i, v in ipairs(self._effectList) do
        v:setOwner(owner)
    end
end

function Status:setHost(fighter)
    self._host = fighter
end

function Status:getHost()
    return self._host
end

function Status:getTag()
    return self._cfgInfo.tag
end

function Status:canStack()
    return self._maxStackCount > 1
end

function Status:getEffectList()
    return self._effectList
end

function Status:getRemainTurnNum()
    return self._remainTurnNum
end

function Status:onTurnOver()
    self._remainTurnNum = self._remainTurnNum - 1
end

function Status:isActive()
    return self._remainTurnNum > 0
end

function Status:getDuration(grade)
    grade = grade or self._grade
    return self._cfgInfo.duration[grade]
end

function Status:getMaxStackCount(grade)
    grade = grade or self._grade
    return self._cfgInfo.maxStackCount[grade]
end

return Status