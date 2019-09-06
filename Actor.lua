local Actor = class("Actor")

function Actor:ctor(state, params)
    self.texture = eh_ActorTexture[state]
    self.state = state
    self.x = 44
    self.y = 44

    -- other config
    self.frames = params.frames
    self.initMoves = params.moves
    self.propertyCnt = params.property

    self.searchedTiles = {}
end

function Actor:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end

-- move the actor
function Actor:move(ox, oy)
    self.x = self.x + ox
    self.y = self.y + oy
end

-- for thife, search the tile
-- for detective, lighten the tile
-- return true when the tile is searchable/lightenable
function Actor:searchTile(tile)
    if not self:hasMoves() then return false end
    if self.state == 1 and tile:canLighten() then
        self:reduceMoves()
        tile:lighten()
        table.insert(self.searchedTiles, tile)

        -- todo：如果tile上面有小偷，那么这个时候要赢了
        return true
    elseif self.state == 2 and tile:canSearch() then
        self:reduceMoves()
        table.insert(self.searchedTiles, tile)

        -- todo：如果tile上面有钥匙，那么这个时候要赢了
        return true
    end
    return false
end

function Actor:hasSearthThisTile(tile)
    for i, v in ipairs(self.searchedTiles) do
        if tile == v then
            return true
        end
    end
    return false
end

-- put property on the tile,
-- return true if successfully
function Actor:putPropertyOnTile(tile)
    if self:hasMoves()
        and self:hasSearthThisTile(tile)
        and self.propertyCnt > 0 
        and tile:canPutProperty() then

        self.propertyCnt = self.propertyCnt - 1
        tile:putProperty(tile)

        self:reduceMoves()
        return true
    end
    return false
end

-- reduce moves
function Actor:reduceMoves()
    self.moves = self.moves - 1
end

-- reset moves
function Actor:resetMoves()
    self.moves = self.initMoves
end

-- has moves?
function Actor:hasMoves()
    return self.moves > 0
end

return Actor