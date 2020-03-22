local EffectAttrChangeBase = require("game_obj.fight_obj.effect.effect_attr_change_base")
local EffectBuff = class("EffectBuff", EffectAttrChangeBase)

local StatusConst = require("game_obj.fight_obj.status.status_const")

function EffectBuff:touch(target)
    local attrKey = self:getTargetObject()
    local vType = self._cfgInfo.valueType
    local value = self._cfgInfo.value
    target:fixFightExtraAttr(attrKey, vType, value)
end

return EffectBuff