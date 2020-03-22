local FightAttrManager = class("FightAttrManager")

local BattleRandom = require("module.battle.battle_random")
local CharacterConst = require("game_obj.fight_obj.character.character_const")
local SkillConst = require("game_obj.fight_obj.skill.skill_const")
local DamageObj = require("game_obj.fight_obj.damage_obj")

local BASE_ATTR = CharacterConst.BASE_ATTR
local VALUE_TYPE = SkillConst.VALUE_TYPE
local RATE_ATTR = CharacterConst.RATE_ATTR

function FightAttrManager:ctor(fighter)
    self._fighter = fighter
    self:_initBaseAttrs()
    self:_initOtherAttrs()
end

function FightAttrManager:_initBaseAttrs()
    local char = self._fighter:getChar()
    self._originBaseAttrs = {}
    for k, v in pairs(BASE_ATTR) do
        self._originBaseAttrs[v] = char:getAttr(v)
    end
    
    self._maxHp = self._originBaseAttrs.hp
    self._hp = self._originBaseAttrs.hp

    self:resetExtraBaseAttr()
end

function FightAttrManager:_initOtherAttrs()
    self._shield = 0
end

function FightAttrManager:_getAttackDamageValue(isCrit)
    local damageValue = self:getAttr(BASE_ATTR.ATTACK)
    if isCrit then
        local critDamageRate = self:getAttr(BASE_ATTR.CRIT_DAMAGE_RATE) / 1000
        return math.round(damageValue * (1 + critDamageRate))
    else
        return damageValue
    end
end

function FightAttrManager:_getAttackDamageType(isCrit)
    return DamageObj.TYPE.NORMAL
end

function FightAttrManager:_judgeCrit()
    local cirtChanceRate = self:getAttr(BASE_ATTR.CRIT_CHANCE_RATE)
    return BattleRandom.randomInRange(cirtChanceRate)
end

function FightAttrManager:_judgeDodge()
    local agility = self:getAttr(BASE_ATTR.AGILITY)
    return BattleRandom.randomInRange(agility)
end
-----------------------------------------------------------
function FightAttrManager:isInRange(curPos, targetPos)
    local atkRange = self:getAttr(BASE_ATTR.ATTACK_RANGE) * 5
    local distanece = cc.pGetDistance(curPos, targetPos)

    return atkRange >= distanece
end
-----------------------------------------------------------
function FightAttrManager:resetExtraBaseAttr()
    self._extraBaseAttrs = {}
    self._extraBaseAttrs[VALUE_TYPE.RATE] = {}
    self._extraBaseAttrs[VALUE_TYPE.FIXED] = {}
    for k, v in pairs(BASE_ATTR) do
        self._extraBaseAttrs[VALUE_TYPE.RATE][v] = 0
        self._extraBaseAttrs[VALUE_TYPE.FIXED][v] = 0
    end
end

function FightAttrManager:getAttr(key)
    if self._originBaseAttrs[key] then
        return self:getBaseAttr(key)
    end
end

function FightAttrManager:getBaseAttr(key)
    local origin = self._originBaseAttrs[key]
    if not origin then return 0 end

    local rate = self._extraBaseAttrs[VALUE_TYPE.RATE][key] / 1000
    local fixedValue = self._extraBaseAttrs[VALUE_TYPE.FIXED][key]

    local result = math.round(origin * (1 + rate) + fixedValue)

    return result
end

function FightAttrManager:getHp()
    return self._hp
end

function FightAttrManager:getMaxHp()
    return self._maxHp
end

function FightAttrManager:newAttackDamage()
    local damageInfo = DamageObj.new()
    damageInfo.source = DamageObj.SOURCE.ATTACK
    damageInfo.isCrit = self:_judgeCrit()
    damageInfo.expectValue = self:_getAttackDamageValue(damageInfo.isCrit)
    damageInfo.type = self:_getAttackDamageType(damageInfo.isCrit)

    return damageInfo
end

function FightAttrManager:suffer(damageInfo)
    local finalDamage = damageInfo.expectValue
    
    -- 普通攻击计算闪避
    if damageInfo.source == DamageObj.SOURCE.ATTACK then
        damageInfo.isDodged = self:_judgeDodge()
        if damageInfo.isDodged then
            cclog(self._fighter:getName() .. "灵巧闪避了这次攻击！")
            finalDamage = math.round(finalDamage * 0.65)
        end
    end
    
    if damageInfo.damageType ~= DamageObj.TYPE.REAL then
        local defenseRate = self:getAttr(CharacterConst.BASE_ATTR.DEFENSE) / 1000
        finalDamage = math.round(finalDamage * (1 - defenseRate)) 
    end

    finalDamage = finalDamage < 0 and 0 or finalDamage
    damageInfo.finalValue = finalDamage
    self._hp = self._hp - finalDamage
end

function FightAttrManager:cure(value)
    value = value < 0 and 0 or value
    self._hp = self._hp + value
end

return FightAttrManager