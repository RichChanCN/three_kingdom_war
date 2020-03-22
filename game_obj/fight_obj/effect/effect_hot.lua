local EffectAttrChangeBase = require("game_obj.fight_obj.effect.effect_attr_change_base")
local EffectHot = class("EffectHot", EffectAttrChangeBase)

function EffectHot:touch(...)
    cclog(self:getHost():getName() .. "被" .. self:getName() .. "影响，剩余回合数：" .. self:getHostStatus():getRemainTurnNum())

    local target = self:getTarget(...)

    target:onBeHealed(self:getOwner(), 20)
end

return EffectHot