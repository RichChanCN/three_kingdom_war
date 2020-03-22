local DamageObj = class("DamageObj")

DamageObj.SOURCE = {
    ATTACK = "attack"
}

DamageObj.TYPE = {
    NORMAL = 1,
    REAL = 2,
}

local SOURCE = DamageObj.SOURCE

local TYPE = DamageObj.TYPE

function DamageObj:ctor()
    self.source = nil
    self.expectValue = 0
    self.type = TYPE.NORMAL
    self.finalValue = 0
    self.isDodged = false
    self.isCrit = false
end

return DamageObj