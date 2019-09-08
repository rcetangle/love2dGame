local Tile = require(".Tile")
local Actor = require(".Actor")
local Property = require(".Property")
local Detective = class("Detective", require(".earth_scene"))

-- tiles map
local map = {
    {-3,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2},
    {-3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
    {-3,1,1,1,1,1,1,1,1,1,1},
    {-3,1,0,0,1,0,0,1,1,1,1},
    {-3,1,0,0,1,0,0,1,1,1,1},
    {-3,0,1,0,1,0,0,1,1,1,1},
    {-3,1,1,1,1,1,1,1,1,1,1},
    {-3,0,1,1,1,1,1,1,1,1,1},
    {-5,1,1,1,1,1,1,1,1,1,1},
    {-4,1,1,1,1,1,1,1,1,1,1},
}

local propertyMap = {
    {row=6, col = 3, name="closet"},
    {row=8, col = 4, name="closet2", frame=2, sy=-1},
    {row=8, col = 8, name="bed"},
    {row=1, col= 4, name="decoration"},
    {row=2, col= 6, name="decoration", frame=4},
    {row=5, col= 5, name="decoration", frame=6},
}
local size = 44

function Detective:loadTextures()
     -- global params
     eh_TileTexture = {
        -- floors
        love.graphics.newImage("res/earth/0.png"),
        love.graphics.newImage("res/earth/1.png"),
        love.graphics.newImage("res/earth/2.png"),

        -- walls
        love.graphics.newImage("res/earth/wall_5.png"),
        love.graphics.newImage("res/earth/wall_4.png"),
        love.graphics.newImage("res/earth/wall_3.png"),
        love.graphics.newImage("res/earth/wall_2.png"),
        love.graphics.newImage("res/earth/wall_1.png"),
    }
    eh_FurnitureCfg = {
        -- furniture
        closet = {
            state = "TURN_N_MOVE",
            frames = {
                love.graphics.newImage("res/earth/closet_f.png"), 
                love.graphics.newImage("res/earth/closet_l.png"), 
                love.graphics.newImage("res/earth/closet_b.png")
            }
        },
        closet2 =  {
            state = "TURN_N_MOVE",
            frames = {
            love.graphics.newImage("res/earth/2Closet_f.png"),  
            love.graphics.newImage("res/earth/2Closet_l.png"), 
            love.graphics.newImage("res/earth/2Closet_b.png"), 
            }
        },
        chair = {
            state = "TURN_N_MOVE",
            frames = {
            love.graphics.newImage("res/earth/chair_f.png"),
            love.graphics.newImage("res/earth/chair_l.png"),
            love.graphics.newImage("res/earth/chair_b.png"),
            }
        },
        bed = {  
            width = 2, height = 2, state = "MOVE",
            frames = {
            love.graphics.newImage("res/earth/bed_f.png"),
            love.graphics.newImage("res/earth/bed_l.png"),
            love.graphics.newImage("res/earth/bed_b.png"),
            }
        },
        closet3 = {
            width = 2, height = 2, state = "MOVE",
            frames = {
            love.graphics.newImage("res/earth/4Closet_f.png"),
            love.graphics.newImage("res/earth/4Closet_l.png"),
            love.graphics.newImage("res/earth/4Closet_b.png"),
            }
        },
        -- decoration
        decoration = {
            love.graphics.newImage("res/earth/bigPic.png"),
            love.graphics.newImage("res/earth/smallPic.png"),
            love.graphics.newImage("res/earth/clock.png"),
            love.graphics.newImage("res/earth/door.png"),
            love.graphics.newImage("res/earth/door2.png"),
            love.graphics.newImage("res/earth/carpet.png"),
        }
    }

    eh_ActorTexture = {
        detective = {
            love.graphics.newImage("res/earth/detective.png"),
            love.graphics.newImage("res/earth/detective_l.png"),
            love.graphics.newImage("res/earth/detective_b.png"),
            love.graphics.newImage("res/earth/detective_r.png"),
        },
        thief = {
            love.graphics.newImage("res/earth/thife.png"),
            love.graphics.newImage("res/earth/thief_l.png"),
            love.graphics.newImage("res/earth/thief_b.png"),
            love.graphics.newImage("res/earth/thief_r.png"),
        }
    }
end


function Detective:load()
    self:loadTextures()
    self:initTilesMap()
    self:initFurniture()
    self:initActors()
end

function Detective:initTilesMap()
    self.mapLeft = 0
    self.mapTop = 0
    self.tiles = {}
    local lastY = 0
    local lastX = 0
    for i, v in ipairs(map) do
        self.tiles[i] = {}
        lastX = 0
        for j, w in ipairs(v) do
            self.tiles[i][j] = Tile.new(w+1, lastX, lastY, i, j)
            if j < #v then
                lastX = lastX + ((w <= -3 and w >= -5) and 21 or size)
            end
        end
        lastY = lastY + size
    end
    self.mapWidth = lastX
    self.mapHeight = lastY
end

function Detective:initFurniture()
    self.furniture = {}
    self.decoration = {}
    for i, v in ipairs(propertyMap) do
        local dt = {}
        table.merge(dt, eh_FurnitureCfg[v.name])
        table.merge(dt, v)
        dt.texture = dt.frames and dt.frames[v.frame or 1] or dt[v.frame or 1]
        dt.x = self.tiles[v.row][v.col].x
        dt.y = self.tiles[v.row][v.col].y
        if v.name == "decoration" then
            table.insert(self.decoration, Property.new(dt))
        else
            table.insert(self.furniture, Property.new(dt))
        end
    end
end

function Detective:initActors()
    self.actors = {}

    -- detective
    local row = 3
    local col = 2
    self.actors[1] = Actor.new("detective", {
        moves = 4, 
        property = 1,

        row = row,
        col = 2,
        x = self.tiles[row][col].x,
        y = self.tiles[row][col].y
    })

    -- thief
    row = 4
    col = 6
    self.actors[2] = Actor.new("thief", {
        moves = 3, 
        property = 1,

        row = row,
        col = col,
        x = self.tiles[row][col].x,
        y = self.tiles[row][col].y
    })

    self.currentActor = self.actors[1]
end

-- check the property can move 2 tile
function Detective:isPropertyCanMove2Tile(property, oRow, oCol)
    -- check the next tile that actor is going is walkable
    -- if not, return
    local arr = property:getEdges(oRow, oCol)
    for i, v in ipairs(arr) do
        -- eh_append2Output(string.format("edge %d,%d (%d,%d)", v[1], v[2], oRow, oCol))
        local rows = self.tiles[v[1]]
        local nextTile = rows and rows[v[2]]
        if not nextTile or not nextTile:canPutFurniture() then
            -- eh_append2Output("tile is can not put property")
            return false
        end

        local nextProperty = nil
        for i, v in ipairs(self.furniture) do
            if v:containsTile(nextTile.row, nextTile.col) then
                -- eh_append2Output(string.format("has property %d,%d", nextTile.row, nextTile.row))
                return false
            end
        end
    end
    return true
end

function Detective:moveActor(oCol, oRow)
    -- check the next tile that actor is going is walkable
    -- if not, return
    local rows = self.tiles[self.currentActor.row+oRow]
    local nextTile = rows and rows[self.currentActor.col+oCol]
    if not nextTile or not nextTile:canWalk() then
        -- eh_append2Output("tile is not walkable")
        return
    end
    
    local nextProperty = nil
    for i, v in ipairs(self.furniture) do
        if v:containsTile(nextTile.row, nextTile.col) then
            nextProperty = v
            break
        end
    end

    if nextProperty then
        -- change facing direction
        self.currentActor:changeDirection(oRow, oCol)
        if not self.pressedA or not self.currentActor:hasMoves() then
            -- eh_append2Output("cannot walk through the property")
            return
        end
    end

    if self.pressedA and self.currentActor:hasMoves() then
        -- get the facing property and move it
        local faceRow, faceCol = self.currentActor:getFaceTileIdx()
        local facingProperty = nil
        if faceRow == nextTile.row and faceCol == nextTile.col then
            facingProperty = nextProperty
        else
            for i, v in ipairs(self.furniture) do
                if v:containsTile(faceRow, faceCol) then
                    facingProperty = v
                    break
                end
            end
        end
        if facingProperty then
            if not self:isPropertyCanMove2Tile(facingProperty, oRow, oCol) then
                return
            end
            facingProperty:move(oCol*size, oRow*size, oRow, oCol)
            self.currentActor:reduceMoves()
        end
    end

    -- move actor to the next tile
    -- if the actor is not in the 3/4 center of the screen, 
    -- move the camera meanwhile.
    self.currentActor:move(oCol*size, oRow*size, oRow, oCol, not self.pressedA)
    if self.currentActor.x < eh_screen.quanterRect[1]
        or self.currentActor.x > eh_screen.quanterRect[3] 
        or self.currentActor.y < eh_screen.quanterRect[2]
        or self.currentActor.y > eh_screen.quanterRect[4] then
            self:moveCamera(-oCol, -oRow)
    end

    -- eh_append2Output(string.format("move %d,%d face %d", self.currentActor.row, self.currentActor.col, self.currentActor.face))
end

-- move the camera
function Detective:moveCamera(oCol, oRow)
    local ox = oCol * size
    local oy = oRow * size

    -- x direction
    local tmpLeft = self.mapLeft + ox
    if tmpLeft + self.mapWidth <= eh_screen.width then
        tmpLeft = eh_screen.width - self.mapWidth
        ox = tmpLeft - self.mapLeft
    end
    if tmpLeft > 0 then
        tmpLeft = 0
        ox = tmpLeft - self.mapLeft
    end

    -- y direction
    local tmpRight = self.mapTop + oy
    if tmpRight + self.mapHeight <= eh_screen.height then
        tmpRight = eh_screen.height - self.mapHeight
        oy = tmpRight - self.mapTop
    end
    if tmpRight > 0 then
        tmpRight = 0
        oy = tmpRight - self.mapTop
    end

    -- filter the unchaned 
    if ox == 0 and oy == 0 then
        return
    end

    self.mapLeft = tmpLeft
    self.mapTop = tmpRight
    -- eh_append2Output(string.format("mapLeft:%d top:%d wid:%d hit:%d", self.mapLeft, self.mapTop, self.mapWidth, self.mapHeight))

    -- move tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile:move(ox, oy)
        end
    end

    -- move decoration
    for i, v in ipairs(self.decoration) do
        v:move(ox, oy, 0, 0)
    end

    -- move properties
    for i, v in ipairs(self.furniture) do
        v:move(ox, oy, 0, 0)
    end

    -- move actors
    for i, v in ipairs(self.actors) do
        v:move(ox, oy, 0, 0)
    end
end

function Detective:shiftActor()
    -- change the current actor to another
    local lastActor = self.currentActor
    for i, v in ipairs(self.actors) do
        if v ~= self.currentActor then
            self.currentActor = v
            self.currentActor:resetMoves()
            break
        end
    end
    -- calculate the offset
    local oRow = lastActor.row - self.currentActor.row
    local oCol = lastActor.col - self.currentActor.col
    -- move the camera
    self:moveCamera(oCol, oRow)
end






function Detective:update()
    if not self:isRunning() then return end
end

function Detective:draw()
    if not self:isRunning() then return end

    -- shiftint actor
    if self.shiftClicked then 
        love.graphics.print("shift to another player...\npress space again when shifting finished.")
        return 
    end

    -- draw tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile:draw()
        end
    end

    -- draw decoration
    for i, dec in ipairs(self.decoration) do
        dec:draw()
    end

    -- draw actor
    if self.currentActor then
        self.currentActor:draw()
    end

    -- draw furniture
    for i, fur in ipairs(self.furniture) do
        fur:draw()
    end

end



------- key events
function Detective:keypressed(key)
    if self.shiftClicked then return end

    -- eh_append2Output("pressed "..key)
    if key == "a" then
        self.pressedA = true
    end
end

function Detective:keyreleased(key)
    if key == "space" then -- shitf 2 another actor
        if not self.shiftClicked then
            self.shiftClicked = true
            self:shiftActor()
        else
            self.shiftClicked = false
        end
    elseif key == "escape" then
        love.window.close()
    end

    -- no key event can be replied until shifting is finished
    if self.shiftClicked then return end
    if key == "up" then
        self:moveActor(0, -1)
    elseif key == "down" then
        self:moveActor(0, 1)
    elseif key == "right" then
        self:moveActor(1, 0)
    elseif key == "left" then
        self:moveActor(-1, 0)
    elseif key == "a" then
        self.pressedA = false
    end
end

return Detective