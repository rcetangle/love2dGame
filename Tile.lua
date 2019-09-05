local Tile = class("Tile")

local TileState = {
    NONE = 0, -- the wall tile, unwalkable
    BLACK = 1, -- the black tile, unwalkable
    LIGHTEN = 2, -- the tile is lighten by detector, unwalkable
    LIGHT = 3, -- the light tile, walkable
}
function Tile:ctor(texture, state, x, y, idx, idy)
    self.initTecture = texture
    self.x = x
    self.y = y
    self.texture = self.initTecture
    self.idx = idx -- row index
    self.idy = idy -- col index
    self.property = nil

    if state < 0 then
        self.state = TileState.NONE
    elseif state == 0 then
        self.state = TileState.BLACK
    else
        self.state = TileState.LIGHT
    end
end

function Tile:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end

-- can put property on the tile
function Tile:canPutProperty()
    return not self.property and (self.state == TileState.BLACK or self.state == TileState.LIGHTEN)
end

-- is the tile is walkable
function Tile:canWalk()
    return self.state == TileState.LIGHT
end

-- is the tile searchable
function Tile:canSearch()
    return self.state == TileState.BLACK or self.state == TileState.LIGHTEN
end

-- is the tile lightenable
function Tile:canLighten()
    return self.state == TileState.BLACK 
end

-- put a property
function Tile:putProperty(property)
    self.property = property
    self.property.x = self.x
    self.property.y = self.y
end

-- move the tile
function Tile:move(ox, oy)
    self.x = self.x + ox
    self.y = self.y + oy
end

-- lighten the tile
function Tile:lighten(texture)
    self.lightenTexture = texture
    self.state = TileState.LIGHTEN
    self.texture = self.lightenTexture
end

return Tile