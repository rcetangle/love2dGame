local Property = require(".Property")
local Actor = class("Actor")

function Actor:ctor(state, params)
    self.textures = eh_ActorTexture[state]
    self.isDetective = state == "detective"
    self.row = params.row or 0
    self.col = params.col or 0
    self.x = params.x or 0
    self.y = params.y or 0
    self.face = 1
    self.texture = self.textures[self.face]
    
    -- other config
    self.frames = params.frames
    self.initMoves = params.moves
    self.moves = self.initMoves
    self.propertyCnt = params.property
    self.propertyHurt = params.propertyHurt or 1

    self.searchedTiles = {}
end

function Actor:draw()
    love.graphics.draw(self.texture, self.x, self.y)
    love.graphics.print({
        {0,0,0,255},
        string.format("moves:%d, prop:%d", self.moves, self.propertyCnt)}, 
        0, eh_screen.height-20)
end

-- move the actor
function Actor:move(ox, oy, oRow, oCol, needChangeDirection)
    self.row = self.row + oRow
    self.col = self.col + oCol
    self.x = self.x + ox
    self.y = self.y + oy
    if needChangeDirection then
       self:changeDirection(oRow, oCol)
    end
end

function Actor:changeDirection(oRow, oCol)
    if oRow == 0 then
        self.face = oCol > 0 and 2 or 4 -- face 2 right or left
    elseif oCol == 0 then
        self.face = oRow > 0 and 1 or 3 -- face 2 front or back
    end
    self.texture = self.textures[self.face]
end

function Actor:getFaceTileIdx()
    if self.face == 1 then -- front
        return self.row+1, self.col
    elseif self.face == 2 then -- right
        return self.row, self.col+1
    elseif self.face == 3 then -- back
        return self.row-1, self.col
    else -- left
        return self.row, self.col-1
    end
end

-- for thife, search the tile
-- for detective, lighten the tile
-- return true when the tile is searchable/lightenable
function Actor:searchTile(tile)
    if not self:hasMoves() then return false end
    if self.isDetective and tile:canLighten() then
        self:reduceMoves()
        tile:lighten()
        table.insert(self.searchedTiles, tile)

        -- todo：如果tile上面有小偷，那么这个时候要赢了
        return true
    elseif not self.isDetective and tile:canSearch() then
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

function Actor:hideOnTile(tile) 
    return true
end

function Actor:hurtByProperty(property)
    local hurt = property:touchActor(self)
    for i = 1, hurt do
        self:reduceMoves()
    end
    if hurt > 1 then
        -- 这里要播放角色受伤的动画
        eh_append2Output("actor is hurt!!!!!"..hurt)
    end
end

-- put property on the tile,
-- return true if successfully
function Actor:putPropertyOnTile(tile)
    if self:hasMoves()
        and self:hasSearthThisTile(tile)
        and self.propertyCnt > 0 
        and tile:canPutProperty() then

        self.propertyCnt = self.propertyCnt - 1

        -- new a property
        local newProperty = Property.new({
            byWhom = self,
            state = "HURT",
            hurtMoves = self.propertyHurt,
            texture = self.texture,
            frames = {self.texture, self.textures[2]}
        })
        tile:putProperty(newProperty)

        self:reduceMoves()
        return true
    end
    eh_append2Output("actor cannot put property")
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