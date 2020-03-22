local Cell = class("Cell")

function Cell:ctor(pos, num)
    self._pos = pos
    self._num = num or 2
    self._level = math.log(num, 2)
end

function Cell:getPos()
    return self._pos
end

function Cell:upgrade()
    self._num = self._num * 2
    self._level = self._level + 1
end

function Cell:moveTo()
    
end

function Cell:destroy()
    
end

return Cell