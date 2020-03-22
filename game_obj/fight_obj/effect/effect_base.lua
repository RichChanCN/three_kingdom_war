local EffectBase = class("EffectBase")
local BattleConst = require("module.battle.battle_const")

function EffectBase:ctor(tid, info)
    self._tid = tid

    self._grade = 1
    self._cfgInfo = info
end

function EffectBase:setOwner(owner)
    self._owner = owner
end

function EffectBase:getOwner()
    return self._owner
end

function EffectBase:getHost()
    local hostStatus = self:getHostStatus()
    if hostStatus then
        return hostStatus:getHost()
    end

    return self._owner
end

function EffectBase:setHostStatus(status)
    self._hostStatus = status
end

function EffectBase:getHostStatus()
    return self._hostStatus
end

function EffectBase:touch(target)

end

function EffectBase:setGrade(grade)
    self._grade = grade
end

function EffectBase:getGrade()
    return self._grade
end

function EffectBase:getUid()
    return self._owner:getUid() .. "_eff_" .. self._tid
end

function EffectBase:getName()
    return self._cfgInfo.name or ""
end

function EffectBase:getDesc()
    return self._cfgInfo.desc or ""
end

function EffectBase:getTag()
    return self._cfgInfo.tag
end

function EffectBase:getTiming()
    return self._cfgInfo.timing
end

function EffectBase:getProbability(grade)
    grade = grade or self._grade
    if not self._cfgInfo.probability then return 1000 end
    return self._cfgInfo.probability[grade] or 0
end

function EffectBase:getPriority()
    return self._cfgInfo.priority or 0
end

function EffectBase:isShow()
    return self:getProbability() > 0
end

function EffectBase:isDurative()
    return self._cfgInfo.timing == BattleConst.TIMING.ALL_TIME
end

function EffectBase:getTargetMode()
    return self._cfgInfo.targetMode
end

function EffectBase:getTargetModeInfo()
    local info = {}

    local params = string.split(self._cfgInfo.targetMode, "_")
    info.isSelf = params[1] == "self"
    info.isEnemy = params[1] == "enemy"
    info.isFriend = params[1] == "friend"
    info.isAll = params[2] == "all"
    info.isMain = params[2] == "main"

    return info
end

function EffectBase:getTarget(...)
    local params = {...}
    local targetModeInfo = self:getTargetModeInfo()

    local target = nil
    if targetModeInfo.isSelf then
        target = self:getHost()
    elseif targetModeInfo.isMain then
        target = params[1]
    else
        target = params[1]
    end

    return target
end

return EffectBase