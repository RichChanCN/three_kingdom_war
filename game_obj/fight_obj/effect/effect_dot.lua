local EffectAttrChangeBase = require("game_obj.fight_obj.effect.effect_attr_change_base")
local EffectDot = class("EffectDot", EffectAttrChangeBase)

local DamageObj = require("game_obj.fight_obj.damage_obj")

function EffectDot:touch(...)
    cclog(self:getHost():getName() .. "被" .. self:getName() .. "影响，剩余回合数：" .. self:getHostStatus():getRemainTurnNum())

    local target = self:getTarget(...)

    local damageInfo = DamageObj.new()
    damageInfo.source = self:getTag()
    damageInfo.type = DamageObj.TYPE.NORMAL
    damageInfo.expectValue = 30
    target:onBeHurt(self:getOwner(), damageInfo)
end

return EffectDot