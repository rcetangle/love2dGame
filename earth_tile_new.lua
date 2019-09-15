local Tile = class("TileNew")

local TileState = {
    NONE = 0, -- the wall tile, unwalkable
    BLACK = 1, -- the black tile, walkable
    LIGHT = 2,  -- the light tile, walkable
    LIGHTEN = 3, -- the tile is lighten by detector, walkable
    HIDDEN = 4, -- hide an actor or hide a property
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
        self.upperTexture = eh_TileTexture[2]
    else
        self.state = TileState.LIGHT
        self.texture = eh_TileTexture[1]
    end
end

function Tile:draw(actor)
    if not self.texture then return end
    love.graphics.draw(self.texture, self.x, self.y)
    if self.upperTexture then
        -- hidden by actor
        if self.state == TileState.HIDDEN and self.byWhom and actor ~= self.byWhom then
            love.graphics.draw(self.upperTexture, self.x, self.y)
            return
        -- hidden for key
        elseif self.state == TileState.HIDDEN and self:hasKey() and actor ~= self.property.byWhom then
            love.graphics.draw(self.upperTexture, self.x, self.y)
            return
        -- hidden unused property
        elseif self.state == TileState.HIDDEN and self.property and actor ~= self.property.byWhom then
            love.graphics.draw(self.upperTexture, self.x, self.y)
            return
        -- for black
        elseif self.state == TileState.BLACK then
            love.graphics.draw(self.upperTexture, self.x, self.y)
        end
    end
    -- love.graphics.print(self.row..","..self.col, self.x, self.y)
    if self.property then
        self.property:draw(actor)
    end
end

-- can put property on the tile
function Tile:canPutProperty()
    return self.state == TileState.BLACK or (self.state == TileState.LIGHT and not self:hasKey())
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
    return self.state == TileState.HIDDEN or self.state == TileState.BLACK or (self.state == TileState.LIGHT and self:hasKey())
end

-- is the tile lightenable
function Tile:canLighten()
    return self.state == TileState.BLACK 
end

-- is the tile hidable
function Tile:canHide(actor)
    return self.state ~= TileState.NONE--self.state == TileState.LIGHT 
        -- or self.state == TileState.BLACK
end

function Tile:hide(actor)
    self.state = TileState.HIDDEN
    self.byWhom = actor
    self.upperTexture = eh_TileTexture[2]
end

function Tile:clearHide()
    if self.state == TileState.HIDDEN and self.property and self.property.state ~= 1 then
        return
    end
    self.state = TileState.LIGHT
    self.byWhom = nil
end

-- put a property
function Tile:putProperty(property)
    self.property = property
    self.property.x = self.x
    self.property.y = self.y
    self.property.row = self.row
    self.property.col = self.col

    self.state = property:isKey() and TileState.LIGHT or TileState.HIDDEN
    self.upperTexture = eh_TileTexture[2]
end

function Tile:hasProperty()
    return self.property
end

function Tile:getProperty()
    return self.property
end

-- move the tile
function Tile:move(ox, oy)
    self.x = self.x + ox
    self.y = self.y + oy
    if self.property then
        self.property:move(ox, oy, 0, 0)
    end
end

-- lighten the tile
function Tile:lighten()
    self.state = TileState.LIGHTEN
    self.upperTexture = eh_TileTexture[self.state]
end

-- is tile has a key
function Tile:hasKey()
    return self.property and self.property:isKey()
end

function Tile:showKey(actor)
    self.state = TileState.HIDDEN
    self.upperTexture = eh_TileTexture[2]
    self.property:touchKey(actor)
end

return Tile