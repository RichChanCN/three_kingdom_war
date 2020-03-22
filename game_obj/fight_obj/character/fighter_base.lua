local FightObj = require("game_obj.fight_obj")
local FighterBase = class("FighterBase", FightObj)

local BattleConst = require("module.battle.battle_const")

local FightAttrManager = require("game_obj.fight_obj.character.fight_attr_manager")
local FightStatusManager = require("game_obj.fight_obj.character.fight_status_manager")
local CharacterConst = require("game_obj.fight_obj.character.character_const")
local SkillConst = require("game_obj.fight_obj.skill.skill_const")
local VALUE_TYPE = SkillConst.VALUE_TYPE
local RATE_ATTR = CharacterConst.RATE_ATTR

function FighterBase:init()
    self:_initFightAttr()
    self:_initFightStatus()
    self:resetMainTargetTag()
end

local SIDE_DESC = {
    [1] = "左边",
    [2] = "右边",
}
function FighterBase:getName()
    local side = self:getSide()
    return SIDE_DESC[side] .. self._char:getName()
end

function FighterBase:getChar()
    return self._char
end

function FighterBase:_initFightAttr()
    self._FAManager = FightAttrManager.new(self)
    
    self:_checkIsAlive()
end

function FighterBase:_initFightStatus()
    self._FSManager = FightStatusManager.new(self, self._FAManager)

    local skillList = self._char:getSkills()
    for i, skill in ipairs(skillList) do
        skill:setOwner(self)
        local effectList = skill:getEffectList()
        self._FSManager:addSkillEffectList(effectList)
    end
end

function FighterBase:_checkTiming(timing, ...)
    if not self:isAlive() then return end

    self._FSManager:checkTiming(timing, ...)
end

function FighterBase:onStatusActive()
    
end

function FighterBase:getTargetSide()
    return BattleConst.OPPONENT_SIDE[self._side]
end

function FighterBase:getPreferenceTargetType()
    return CharacterConst.PREFERENCE_TARGET_TYPE.SAME_Y_FIRST
end

function FighterBase:getTargetRangeInfo()
    return self._char:getTargetRangeInfo()
end

function FighterBase:setMainTargetTag()
    self._isMainTarget = true
end

function FighterBase:resetMainTargetTag()
    self._isMainTarget = false
end

--=============================判断函数=======================================
function FighterBase:_checkIsAlive(from)
    if self:isInAction() then return end
    local beforIsAlive = self._isAlive
    self._isAlive =  self._FAManager:getHp() > 0
    if beforIsAlive and not self._isAlive then
        self:onDeath(from)
    end
end

function FighterBase:isAlive()
    return self._isAlive
end

function FighterBase:isInRange(targetPos)
    local curPos = self:getPos()
    return self._FAManager:isInRange(curPos, targetPos)
end

function FighterBase:canBeSelected()
    return self:isAlive()
end

function FighterBase:canIntoTurn()
    return self:isAlive()
end

function FighterBase.isCharacter()
    return true
end

function FighterBase:isInAction()
    return self._isInAction == true
end

function FighterBase:canChangeActionSide()
    return true
end

function FighterBase:isMainTarget()
    return self._isMainTarget
end
--=============================战斗逻辑=======================================
function FighterBase:doAction(targets)
    for i, v in ipairs(targets) do
        self:beforeAttack(v)
        v:beforeBeAttacked(self)
    end
    
    self:_attack(targets)
    self:_checkIsAlive()
end

function FighterBase:_attack(targets)
    local damageInfo = self._FAManager:newAttackDamage()
    
    cclog(self:getName() .. " 发起攻击！")
    if damageInfo.isCrit then
        cclog("暴击了！")
    end
    for i, v in ipairs(targets) do
        -- 克隆攻击信息，每个目标可能不一样
        self:_doAttack(v, clone(damageInfo))
    end
end

function FighterBase:_doAttack(target, damageInfo)
    if not target:isAlive() then return end

    target:onBeHurt(self, damageInfo)
    self:afterAttack(target, damageInfo)
    target:afterBeAttacked(self, damageInfo)
end

function FighterBase:addStatus(status)
    self._FSManager:addStatus(status)
end

-- 攻击前
function FighterBase:beforeAttack(target)
    if not self:isAlive() then return end
    self:_checkTiming(BattleConst.TIMING.BEFORE_ATTACK, target)
end

-- 攻击后
function FighterBase:afterAttack(target, damageInfo)
    if not self:isAlive() then return end
    self:_checkTiming(BattleConst.TIMING.AFTER_ATTACK, target, damageInfo)
end

-- 受击前
function FighterBase:beforeBeAttacked(from)
    if not self:isAlive() then return end
    self:_checkTiming(BattleConst.TIMING.BEFORE_BE_ATTACKED, from)
end

-- 受击后
function FighterBase:afterBeAttacked(from, damageInfo)
    if not self:isAlive() then return end
    self:_checkTiming(BattleConst.TIMING.AFTER_BE_ATTACKED, from, damageInfo)
end

function FighterBase:onBeHurt(from, damageInfo)
    self._FAManager:suffer(damageInfo)

    cclog(self:getName() .. " 受到 " .. damageInfo.finalValue .. " 点伤害，剩余血量：" .. self._FAManager:getHp())

    from:_doDamage(damageInfo.finalValue)

    self:_checkIsAlive(from)
end

function FighterBase:onBeHealed(from, value)
    self._FAManager:cure(value)

    cclog(self:getName() .. " 回复 " .. value .. " 点血量，当前血量：" .. self._FAManager:getHp())

    from:_doHeal(value)

    return value
end

function FighterBase:onDeath(from)
    FighterBase.super.onDeath(self)
    cclog(self:getName() .. " 死亡！击杀者：" .. from:getName())
end

--=============================统计相关============================
function FighterBase:_doDamage(value)
    
end

function FighterBase:_doHeal(value)
    
end

return FighterBase