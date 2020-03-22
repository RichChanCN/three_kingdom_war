local EffectBase = require("game_obj.fight_obj.effect.effect_base")
local EffectAttrChangeBase = class("EffectAttrChangeBase", EffectBase)

function EffectAttrChangeBase:getRateValue(grade)
    grade = grade or self._grade
    if not self._cfgInfo.rateValue then return 0 end
    return self._cfgInfo.rateValue[grade] or 0
end

function EffectAttrChangeBase:getFixedValue(grade)
    grade = grade or self._grade
    if not self._cfgInfo.fixedValue then return 0 end
    return self._cfgInfo.fixedValue[grade] or 0
end

function EffectAttrChangeBase:getRefObject()
    return self._cfgInfo.refObject
end

function EffectAttrChangeBase:getTargetObject()
    return self._cfgInfo.targetObject
end

return EffectAttrChangeBase