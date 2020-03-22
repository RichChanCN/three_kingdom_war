local EffectAttrChangeBase = require("game_obj.fight_obj.effect.effect_attr_change_base")
local EffectDebuff = class("EffectDebuff", EffectAttrChangeBase)

local StatusConst = require("game_obj.fight_obj.status.status_const")

function EffectDebuff:touch(target)
    local attrKey = self._cfgInfo.attrKey
    local vType = self._cfgInfo.valueType
    local value = self._cfgInfo.value
    target:fixFightExtraAttr(attrKey, vType, value)
end

return EffectDebuff