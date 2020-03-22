local BattleRandom = {}
local BIG_PRIME = 65537
local MAX_RATIO = 1 / BIG_PRIME
function BattleRandom.setSeed(sed)
    BattleRandom.seed = sed
end

function BattleRandom.getSeed(sed)
    return BattleRandom.seed
end

function BattleRandom.cleanSeed()
    BattleRandom.seed = nil
end

function BattleRandom.isInited()
    return BattleRandom.seed ~= nil
end

function BattleRandom.random(m, n)

    local seed = BattleRandom.seed
    if not seed then return m end

    if seed == 0 then seed = 1 end
    seed = (seed * 67) % BIG_PRIME
    BattleRandom.seed = seed

    local min = 0
    local max = 0
    local isFloor = false

    if m and n then
        min = m
        max = n
        isFloor = true
    elseif m then 
        min = 1
        max = m
        isFloor = true
    end

    local result = min + seed * MAX_RATIO * (max - min + 1)
    if isFloor then result = math.floor(result) end
    return result
end

function BattleRandom.randomInRange(range)
    if not range then return false end
    return BattleRandom.random(1000) <= range
end

return BattleRandom
