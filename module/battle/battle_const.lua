local BattleConst = {}

BattleConst.SIDE = {
    LEFT = 1,
    RIGHT = 2,
}

BattleConst.OPPONENT_SIDE = {
    [BattleConst.SIDE.LEFT] = BattleConst.SIDE.RIGHT,
    [BattleConst.SIDE.RIGHT] = BattleConst.SIDE.LEFT,
}

BattleConst.TIMING = {
    ALL_TIME = 0,
    BATTLE_CLOCK = 1,

    BEFORE_ATTACK = 11,
    AFTER_ATTACK = 12,
    BEFORE_BE_ATTACKED = 13,
    AFTER_BE_ATTACKED = 14,
    ON_SUPPORT = 15,
}

return BattleConst