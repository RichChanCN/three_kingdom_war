local FightObj = class("FightObj", function()
    return cc.Node:create()
end)

local STATUS = {
    MOVE = "move",
    FOLLOW = "follow",
    STAND = "stand",
    ATTACK = "attack",
    DEATH = "death",
}

local SCALE_RATE = 0.22

local index = 0
function FightObj.getIndex()
    index = index + 1
    return index
end

function FightObj:ctor(char, side, index)
    self._char = char
    self._side = side
    self._index = index

    self._uid = self._side * 100000 + self._char:getCid() * 1000 + FightObj.getIndex()
    self:setPosition(cc.p(0, 0))
    self:updateZOrder()

    self:enableNodeEvents()
    self:createSprite()
    self:init()
end

function FightObj:init()
    
end

function FightObj:getPos()
    return cc.p(self:getPosition())
end

function FightObj:getUid()
    return self._uid
end

function FightObj:getSide()
    return self._side
end

function FightObj:getFightType()
    return self._char:getFightType()
end

function FightObj:createSprite()
    self._sprite = cc.Sprite:create("char/tiny_char_" .. self._char:getCid() .. ".png")
    self._sprite:setScale(SCALE_RATE)
    if self._side == 1 then
        self._sprite:setScaleX(-SCALE_RATE)
    end
    self:addChild(self._sprite)
end

function FightObj:updateZOrder()
    local x, y = self:getPosition()
    self:setLocalZOrder(-y)
end

function FightObj:requestStatus(status)
    if self._curStatus == status then return end

    self._curStatus = status
    if status == STATUS.MOVE then
        self:_moveAction()
    elseif status == STATUS.ATTACK then
        self:_attackAction()
    elseif status == STATUS.STAND then
        self:_standAction()
    elseif status == STATUS.DEATH then
        self:_deathAction()
    end
end

function FightObj:moveTo(targetPos)
    self:stopAllActions()

    local curPos = self:getPos()
    local distance = cc.pGetDistance(curPos, targetPos)
    
    local moveTo = cc.MoveTo:create(distance / 100, targetPos)
    local moveEnd = cc.CallFunc:create(function()
        self:moveEnd()
    end)
    local sequeue = cc.Sequence:create({moveTo, moveEnd})
    self:runAction(sequeue)
    self:requestStatus(STATUS.MOVE)
end

function FightObj:follow()
    self:stopAllActions()

    local targetPos = self._target:getPos()
    
    if not self._target:isAlive() then
        self:findTarget()
        return
    elseif self:isInRange(targetPos) then
        self:requestStatus(nil)
        self:requestStatus(STATUS.ATTACK)
        return
    end
    self:moveTo(targetPos)

    local delay = cc.DelayTime:create(0.1)
    local check = cc.CallFunc:create(function()
        if self._target:isAlive() then
            self:follow()
        else
            self:findTarget()
        end
    end)
    local sequeue = cc.Sequence:create({delay, check})
    self:runAction(sequeue)
end

function FightObj:moveEnd()
    self:updateZOrder()
    self:requestStatus(STATUS.STAND)
end

function FightObj:isInRange(targetPos)
    return false
end

function FightObj:findTarget()
    local Battle = require("module.battle.battle")
    local target = Battle.getIns():getAliveTargetBySide(self:getSide())
    
    if target then
        self:setTarget(target)
        self:follow()
    else
        self:setTarget(nil)
        self:requestStatus(STATUS.STAND)
    end
end

function FightObj:_moveAction()
    self._sprite:stopAllActions()
    local jump = cc.JumpTo:create(0.4, cc.p(0, 0), 5, 1)
    local squeue = cc.Sequence:create({jump})
    self._sprite:runAction(cc.RepeatForever:create(squeue))
end

function FightObj:_attackAction()
    if not self._target:isAlive() then
        self:findTarget()
        return
    end

    self._sprite:stopAllActions()

    local tPos = self._target:getPos()
    local pos = self:getPos()
    local offX = tPos.x - pos.x 
    if offX > 0 then
        self._sprite:setScaleX(-SCALE_RATE)
    else
        self._sprite:setScaleX(SCALE_RATE)
    end
    local jump = cc.JumpTo:create(0.2, cc.p(offX / 3, 5), 10, 1)

    local cb = cc.CallFunc:create(function()
        self:doAction({self._target})
    end)

    local back = cc.MoveTo:create(0.1, cc.p(0, 0))

    local delay = cc.DelayTime:create(0.5)

    local attackEnd = cc.CallFunc:create(function()
        self:follow()
    end)

    local squeue = cc.Sequence:create({jump, cb, back, delay, attackEnd})
    self._sprite:runAction(squeue)
end

function FightObj:_standAction()
    self._sprite:stopAllActions()
    local jump = cc.JumpTo:create(0.4, cc.p(0, 0), 5, 1)
    local delay = cc.DelayTime:create(1)
    local squeue = cc.Sequence:create({jump, delay})
    self._sprite:runAction(cc.RepeatForever:create(squeue))
end

function FightObj:doAction(targets)

end

function FightObj:onDeath()
    self:stopAllActions()
    self._sprite:stopAllActions()
    self:requestStatus(STATUS.DEATH)
end

function FightObj:_deathAction()
    self:stopAllActions()
    self._sprite:stopAllActions()
    local rotate = cc.RotateTo:create(0.2, 90)
    local fadeOut = cc.FadeOut:create(0.2)
    local squeue = cc.Sequence:create({rotate, fadeOut})
    self._sprite:runAction(cc.RepeatForever:create(squeue))
end

function FightObj:setTarget(target)
    self._target = target
end

function FightObj:onEnter()
    self:requestStatus(STATUS.STAND)
end

return FightObj