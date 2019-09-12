local Property = require(".earth_property")
local Actor = class("Actor")

function Actor:ctor(state, params)
    self.textures = eh_ActorTexture[state]
    self.isDetective = state == "detective"
    self.name = state
    self.row = params.row or 0
    self.col = params.col or 0
    self.x = params.x or 0
    self.y = params.y or 0
    self.ox = 0
    self.oy = 0
    self.face = 1
    self.stepCnt = 1
    self.texture = self.textures[self.face][self.stepCnt]
    
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
end

-- move the actor
function Actor:move(ox, oy, oRow, oCol, needChangeDirection)
    self.ox = ox
    self.oy = oy
    self.row = self.row + oRow
    self.col = self.col + oCol
    self.x = self.x + ox
    self.y = self.y + oy

    self.stepCnt = math.max(1, (self.stepCnt+1)%4)
    if needChangeDirection then
       self:changeDirection(oRow, oCol)
    else
        self:updateTexture()
    end
end

function Actor:updateTexture()
    self.texture = self.textures[self.face][self.stepCnt]
end

function Actor:changeDirection(oRow, oCol)
    if oRow == 0 then
        self.face = oCol > 0 and 2 or 4 -- face 2 right or left
    elseif oCol == 0 then
        self.face = oRow > 0 and 1 or 3 -- face 2 front or back
    end
    self:updateTexture()
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
    if not self:hasMoves() then 
        eh_append2Output("cannot search the tile, no moves!")
        return false 
    end
    if self.isDetective and tile:canLighten() then
        self:reduceMoves()
        tile:lighten()
        table.insert(self.searchedTiles, tile)
        return true
    elseif not self.isDetective and tile:canSearch() then
        self:reduceMoves()
        table.insert(self.searchedTiles, tile)
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
    local canHide = false
    if self.isDetective and not tile:hasKey() then -- detective cannot hide on key tile
        canHide = true
    elseif not self.isDetective and tile:canHide() then -- thief can hide on black tile
        canHide = true
    end
    if canHide then
        self.hidenTile = tile

        -- reset actor direction
        self.face = 1
        self.stepCnt = 1
        self:updateTexture()
    end
    return canHide
end

function Actor:hasSameHidenTile(tile)
    return self.hidenTile ~= nil and self.hidenTile == tile
end

function Actor:hurtByProperty(property)
    local hurt = property:touchActor(self)
    for i = 1, hurt do
        self:reduceMoves()
    end
    if hurt > 1 then
        -- 这里要播放角色受伤的动画
        eh_append2Output("actor is hurt!!!!! "..hurt)
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
            texture = eh_PropTexture[self.name][1],
            frames = eh_PropTexture[self.name]
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