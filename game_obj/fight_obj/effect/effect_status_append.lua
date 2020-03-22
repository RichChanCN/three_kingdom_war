local EffectBase = require("game_obj.fight_obj.effect.effect_base")
local EffectStatusAppend = class("EffectStatusAppend", EffectBase)

local Status = require("game_obj.fight_obj.status.status")

function EffectStatusAppend:getStatusList()
    local statusList = Status.newList(self._cfgInfo.statusList)

    for i, v in ipairs(statusList) do
        v:setGrade(self:getGrade())
        v:setOwner(self:getOwner())
    end

    return statusList
end

function EffectStatusAppend:touch(...)
    local target = self:getTarget(...)
    if not target then return end
    
    local statusList = self:getStatusList()
    for i, v in ipairs(statusList) do 
        target:addStatus(v)
    end
end

return EffectStatusAppend