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

-- is the tile is walkable
function Tile:canWalk()
    return self.state == TileState.LIGHT
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