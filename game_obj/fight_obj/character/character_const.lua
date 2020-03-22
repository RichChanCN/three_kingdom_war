local CharacterConst = {}

CharacterConst.FIGHT_TYPE = {
    WARRIOR = 1,    -- 战士
    DEFENDER = 2,   -- 防卫者
    ARCHER = 3,     -- 弓箭手
    CASTER = 4,     -- 法师
    RIDER = 5,      -- 骑兵
}


CharacterConst.BASE_ATTR = {
    ATTACK = "attack",
    DEFENSE = "defense",
    HP = "hp",
    ATTACK_RANGE = "attackRange",
    CRIT_CHANCE_RATE = "critChanceRate",
    CRIT_DAMAGE_RATE = "critDamageRate",
    AGILITY = "agility",
}

CharacterConst.RATE_ATTR = {
    [CharacterConst.BASE_ATTR.DEFENSE] = true,
    [CharacterConst.BASE_ATTR.CRIT_CHANCE_RATE] = true,
    [CharacterConst.BASE_ATTR.CRIT_DAMAGE_RATE] = true,
}


return CharacterConst