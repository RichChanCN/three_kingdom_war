local BaseScene = require("scene.base_scene")
local BattleScene = class("BattleScene", BaseScene)
local ArenaMap = require("module.battle.arena_map")
local FF = require("game_obj.fight_obj.character.fighter_factory")
local C = require("game_obj.fight_obj.character.character")
local Battle = require("module.battle.battle")

function BattleScene:testBattle()

    local left = {}
    -- table.insert(left, FF.new(C.new(3), 1, cc.p(100, 350)))
    -- table.insert(left, FF.new(C.new(2), 1, cc.p(100, 300)))
    -- table.insert(left, FF.new(C.new(1), 1, cc.p(100, 250)))


    local right = {}
    table.insert(right, FF.new(C.new(3), 2, 1))
    table.insert(right, FF.new(C.new(2), 2, 2))
    table.insert(right, FF.new(C.new(1), 2, 3))
    table.insert(right, FF.new(C.new(3), 2, 1))
    table.insert(right, FF.new(C.new(2), 2, 2))
    table.insert(right, FF.new(C.new(1), 2, 3))
    table.insert(right, FF.new(C.new(4), 2, 1))
    table.insert(right, FF.new(C.new(4), 2, 2))
    table.insert(right, FF.new(C.new(5), 2, 3))

    local mapNode = ArenaMap.new()
    mapNode:setPosition(cc.p(display.cx, display.cy))

    self._mapLayer:addChild(mapNode)
    local battle = Battle.new(3, mapNode)

    for i, v in ipairs(left) do
        battle:addFightObj(v)
    end
    
    for i, v in ipairs(right) do
        battle:addFightObj(v)
    end
end

function BattleScene:initMapLayer()

end

function BattleScene:initUILayer()
    local btn1 = ccui.Button:create("char/tiny_char_1.png", "char/tiny_char_1.png", "char/tiny_char_1.png")
    btn1:setPosition(cc.p(display.left + 50, display.bottom + 50))
    self._uiLayer:addChild(btn1)

    local btn2 = ccui.Button:create("char/tiny_char_2.png", "char/tiny_char_2.png", "char/tiny_char_2.png")
    btn2:setPosition(cc.p(display.right - 50, display.bottom + 50))
    self._uiLayer:addChild(btn2)

    btn1:addClickEventListener(function(sender)
        self:onClickAdd()
    end)
    btn2:addClickEventListener(function(sender)
        self:onClickStart()
    end)
end

function BattleScene:onClickAdd()
    local char = FF.new(C.new(math.random(4)), 1, 1)
    Battle.getIns():addFightObj(char)
end

function BattleScene:onClickStart()
    Battle.getIns():start()
end

function BattleScene:onEnter()
    self:testBattle()
    cc.Director:getInstance():getScheduler():setTimeScale(1)
end

return BattleScene