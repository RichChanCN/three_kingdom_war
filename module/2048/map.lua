local Map = class("Map")

function Map:ctor(width, height)
    self._width = width or 4
    self._height = height or 4
    self:_initData()
end

function Map:_initData()
    self._data = {}
    for i = 1, self.width do
        self._data[i] = {}
    end
end

function Map:addCell(cell)
    local pos = cell:getPos()
    self._data[pos.x][pos.y] = cell 
end

function Map:isVaildPosId(posId)
    return posId <= self.posNum and posId > 0
end

function Map:isVaildPos(pos)
    return pos.x > 0 and pos.x <= self.width and pos.y > 0 and pos.y <= self.height
end

function Map:getPosByPosId(posId)
    return cc.p(math.floor(posId / 10), math.mod(posId, 10))
end

function Map:onLeft()
    
end

function Map:onRight()
    
end

function Map:onUp()
    
end

function Map:onDown()
    
end

return Map