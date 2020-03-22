local Character = class("Character")

local CfgCharacter = loadCfg("char") 
local CharacterConst = require("game_obj.fight_obj.character.character_const")
local Skill = require("game_obj.fight_obj.skill.skill")


function Character:ctor(id)
    self._id = id
    self:_initInfo()
    self:_initSkill()
end

function Character:_initInfo()
    self._cfgInfo = CfgCharacter[self._id]
    self._grade = 10
    self._star = 0
end

function Character:getCid()
    return self._id
end

function Character:getUid()
    return self._id
end

function Character:getName()
    return self._cfgInfo.name
end

function Character:getQuality()
    return self._cfgInfo.quality
end

function Character:getCurStar()
    return self._star
end

function Character:getCurGrade()
    return self._grade
end

function Character:_initSkill()
    self._skills = {}
    -- for i, v in ipairs(self._cfgInfo.skillList) do 
    --     local skill = Skill.new(v)
    --     table.insert(self._skills, skill)
    -- end
end

function Character:getSkills()
    return self._skills
end

function Character:getFightType()
    return self._cfgInfo.fightType
end


function Character:getStarAttrGrowRate(key)
    local grow = self._cfgInfo[key .. "Grow"]
    if not grow then return 0 end

    if CharacterConst.RATE_ATTR[key] then
        return grow
    else
        return grow / 1000
    end
end

function Character:getBaseAttr(key)
    local origin = self._cfgInfo[key]
    local starRate = self:getStarAttrGrowRate(key)
    local result = origin + self._star * starRate
    return math.round(result)
end

function Character:getAttr(key)
    return self:getBaseAttr(key)
end

return Character