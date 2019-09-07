local Property = {}

Property.STATE = {
    NONE = 1, -- not movable and not turnable
    MOVE = 2, -- movable
    TURN = 3, -- turnable
    MOVE_N_TURN = 4, -- movable and turnable
}

local BaseProperty = class("BaseProperty")
function BaseProperty:ctor(parms)
    self.texture = parms.texture
    self.frames = parms.frames
    self.state = Property.STATE[parms.state or "NONE"]
    self.width = parms.width or 1
    self.height = parms.height or 1
    self.x = parms.x or 0
    self.y = parms.y or 0
    self.row = parms.row or 0
    self.col = parms.col or 0
    self.rotation = parms.rotation
end

function BaseProperty:draw()
    love.graphics.draw(self.texture, self.x, self.y, self.rotation)
end

function BaseProperty:move(ox, oy, oRow, oCol)
    self.x = self.x + ox
    self.y = self.y + oy
    self.row = self.row + oRow
    self.col = self.col + oCol
end

function BaseProperty:rotate(or)
    self.rotation = self.rotation + or * 90
end

function BaseProperty:containsTile(row, col)
    return row <= self.row 
        and self.row - row <= self.height 
        and col >= self.col
        and col - self.col <= self.width
end

return Property