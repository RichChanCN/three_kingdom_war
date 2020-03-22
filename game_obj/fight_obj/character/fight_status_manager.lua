local FightStatusManager = class("FightStatusManager")

local BattleConst = require("module.battle.battle_const")

function FightStatusManager:ctor(fighter, FAManager)
    self._fighter = fighter
    self._FAManager = FAManager
    self._statusTagGroup = {} -- 类型分组一层索引唯一id作为二层索引的状态表
    self._effectList = {}   -- 唯一id作为索引的效果表

    self._effectTimingMap = {} -- 触发时机一层索引优先级排序的effect的uid映射数组
end

function FightStatusManager:addSkillEffectList(effectList)
    for i, v in ipairs(effectList) do
        self._effectList[v:getUid()] = v
        self:_insertEffectInTimingMap(v)
    end
end

function FightStatusManager:addStatus(status)
    local uid = status:getUid()
    local tag = status:getTag()

    local isAdded = false
    local existed = self:_checkExist(tag, uid)
    if self:_checkCanAdd(status) and not existed then
        local tagList = self:_getStatusListByTag(tag)
        tagList[uid] = status
        local effectList = status:getEffectList()
        for i, v in ipairs(effectList) do
            self:_insertEffectInTimingMap(v)
        end

        isAdded = true
    elseif existed then
        isAdded = false
    end

    if isAdded then
        status:setHost(self._fighter)
    end

    return isAdded
end

function FightStatusManager:_insertEffectInTimingMap(effect)
    local timing = effect:getTiming()
    local priority = effect:getPriority()
    local effectUidList = self:_getEffectUidListByTiming(timing)
    local eUid = effect:getUid()
    
    self._effectList[eUid] = effect

    local isInsert = false
    for i, uid in ipairs(effectUidList) do
        if self._effectList[uid]:getPriority() < priority then
            table.insert(effectUidList, i, eUid)
            isInsert = true
            break
        end
    end

    if not isInsert then
        table.insert(effectUidList, eUid)
    end

    
    if effect:isDurative() then
        effect:touch(self._FAManager)
    end
end

function FightStatusManager:_getEffectUidListByTiming(timing)
    self._effectTimingMap[timing] = self._effectTimingMap[timing] or {}
    return self._effectTimingMap[timing]
end

function FightStatusManager:_getStatusListByTag(tag)
    self._statusTagGroup[tag] = self._statusTagGroup[tag] or {}
    return self._statusTagGroup[tag]
end

function FightStatusManager:_checkCanAdd(status)
    return true
end

function FightStatusManager:_checkExist(tag, sUid)
    local tagList = self:_getStatusListByTag(tag)
    return tagList[sUid] and true or false
end

function FightStatusManager:checkTiming(timing, ...)
    local effUidList = self:_getEffectUidListByTiming(timing)

    for i, effId in ipairs(effUidList) do
        self._effectList[effId]:touch(...)
    end

    if timing == BattleConst.TIMING.BATTLE_CLOCK then
        self:_updateStatus()
    end
end

function FightStatusManager:_updateStatus()
    local invaildStatusList = {}
    for k, group in pairs(self._statusTagGroup) do
        for k, v in pairs(group) do
            v:onTurnOver()
            if not v:isActive() then
                table.insert(invaildStatusList, v)
            end
        end
    end

    self:_clearInvaildStatus(invaildStatusList)
end

function FightStatusManager:_clearInvaildStatus(invaildStatusList)
    for i, status in ipairs(invaildStatusList) do
        cclog(self._fighter:getName() .. "的" .. status:getName() .. "状态结束了")
        local sUid = status:getUid()
        local sTag = status:getTag()
        self._statusTagGroup[sTag][sUid] = nil
        local effList = status:getEffectList()
        self:_removeEffects(effList)
    end
end

function FightStatusManager:_removeEffects(effectList)
    local hasDurativeEffect = false
    for i, effect in ipairs(effectList) do
        local eUid = effect:getUid()
        local timing = effect:getTiming()
        if effect:isDurative() then
            effect:unTouch(self._FAManager)
        end

        self._effectList[eUid] = nil
        local effUidList = self:_getEffectUidListByTiming(timing)
        table.removebyvalue(effUidList, eUid)
    end

    return hasDurativeEffect
end

return FightStatusManager