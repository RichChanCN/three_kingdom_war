local EffectAttrChangeBase = require("game_obj.fight_obj.effect.effect_attr_change_base")
local EffectDamage = class("EffectDamage", EffectAttrChangeBase)

local DamageObj = require("game_obj.fight_obj.damage_obj")

function EffectDamage:touch(...)
    cclog(self:getHost():getName() .. "使用" .. self:getName())

    local target = self:getTarget(...)

    local damageInfo = DamageObj.new()
    damageInfo.source = self:getTag()
    damageInfo.type = DamageObj.TYPE.NORMAL
    damageInfo.expectValue = 100
    target:onBeHurt(self:getOwner(), damageInfo)
end

return EffectDamage