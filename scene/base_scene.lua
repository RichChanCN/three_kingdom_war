local BaseScene = class("BaseScene", function() 
    return cc.Scene:create()
end)

local SCENE_LAYER_Z_ORDER = {
    BG = 0,
    MAP = 50,
    MAIN = 100,
    UI = 200,
    TIP = 400,
}

function BaseScene:ctor()
    self:enableNodeEvents()

    self._bgLayer = self:createLayer(SCENE_LAYER_Z_ORDER.BG)

    self._mapLayer = self:createLayer(SCENE_LAYER_Z_ORDER.MAP)

    self._mainLayer = self:createLayer(SCENE_LAYER_Z_ORDER.MAIN)

    self._uiLayer = self:createLayer(SCENE_LAYER_Z_ORDER.UI)

    self._tipLayer = self:createLayer(SCENE_LAYER_Z_ORDER.TIP)

    self:initBgLayer()
    self:initUILayer()
end

function BaseScene:createLayer(zOrder)
    local layer = cc.Layer:create()
    self:addChild(layer, zOrder)

    return layer
end

function BaseScene:initBgLayer()
    
end

function BaseScene:initMapLayer()
    
end

function BaseScene:initUILayer()
    
end

return BaseScene