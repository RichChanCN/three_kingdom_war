local Skill = class("Skill")
local CfgSkill = loadCfg("skill")
local EffectFactory = require("game_obj.fight_obj.effect.effect_factory")
local Status = require("game_obj.fight_obj.status.status")

function Skill:ctor(skillId, grade)
    self._skillId = skillId

    self._grade = 1
    self._cfgInfo = CfgSkill[skillId]

    self:_init()
    self:setGrade(grade)
end

function Skill:_init()
    self._effectList = EffectFactory.newList(self._cfgInfo.effectList)
    -- 这里的状态只作为展示用
    self._statusList = Status.newList(self._cfgInfo.statusList)
end

function Skill:getEffectList()
    return self._effectList
end

function Skill:getStatusList()
    return self._statusList
end

--@TODO 2020-03-02 22:25:22
--战斗需要对owner清理，取消引用才行
function Skill:setOwner(fighter)
    self._owner = fighter

    for i, v in ipairs(self._effectList) do
        v:setOwner(fighter)
    end
    
    for i, v in ipairs(self._statusList) do
        v:setOwner(fighter)
    end
end

function Skill:setGrade(grade)
    self._grade = grade or self._grade
    for i, v in ipairs(self._effectList) do
        v:setGrade(self._grade)
    end
    
    for i, v in ipairs(self._statusList) do
        v:setGrade(self._grade)
    end
end

function Skill:getGrade()
    return self._grade
end

function Skill:getName()
    return self._cfgInfo.name or ""
end

function Skill:getDesc()
    return self._cfgInfo.desc or ""
end

return Skill