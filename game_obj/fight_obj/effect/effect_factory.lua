local EffectFactory = {}

local CfgEffectTag = loadCfg("effect_tag")
local CfgEffectGroup = {
    ["ac"] = loadCfg("effect_attr_change"),
    ["sc"] = loadCfg("effect_status_change"),
    ["sa"] = loadCfg("effect_status_append"),
    ["li"] = loadCfg("effect_limit"),
}

function EffectFactory.newList(idList)
    local effectList = {}
    if not idList then return effectList end
    for i, v in ipairs(idList) do
        local effect = EffectFactory.new(v)
        table.insert(effectList, effect)
    end

    return effectList
end

function EffectFactory.new(id)
    if not id then return end
    local idInfo = string.split(id, "_")

    local info = CfgEffectGroup[idInfo[1]][tonumber(idInfo[2])]
    local eClass = info.tag
    local EffectClass = require("game_obj.fight_obj.effect.effect_" .. eClass)
    local effect = EffectClass.new(id, info)

    return effect
end

return EffectFactory