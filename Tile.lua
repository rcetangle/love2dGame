local Tile = class("Tile")

local TileState = {
    NONE = 0, -- the wall tile, unwalkable
    BLACK = 1, -- the black tile, walkable
    LIGHTEN = 2, -- the tile is lighten by detector, walkable
    LIGHT = 3, -- the light tile, walkable
}

function Tile:ctor(state, x, y, row, col)
    self.x = x
    self.y = y
    self.row = row -- row index
    self.col = col -- col index
    self.property = nil

    if state <= TileState.NONE then
        self.state = TileState.NONE
        self.texture = eh_TileTexture[#eh_TileTexture+state]
    elseif state == TileState.BLACK then
        self.state = TileState.BLACK
        self.texture = eh_TileTexture[1]
    else
        self.state = TileState.LIGHT
        self.texture = eh_TileTexture[2]
    end
end

function Tile:draw()
    if not self.texture then return end
    love.graphics.draw(self.texture, self.x, self.y)
    love.graphics.print(self.row..","..self.col, self.x, self.y)
end

-- can put property on the tile
function Tile:canPutProperty()
    return not self.property and (self.state == TileState.BLACK or self.state == TileState.LIGHTEN)
end

-- can put furniture on the tile
function Tile:canPutFurniture()
    return self.state == TileState.LIGHT
end

-- is the tile is walkable
function Tile:canWalk()
    return self.state ~= TileState.NONE
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
function Tile:lighten()
    self.state = TileState.LIGHTEN
    self.texture = eh_TileTexture[3]
end

return Tile