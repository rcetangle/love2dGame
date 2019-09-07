local Tile = require(".Tile")
local Actor = require(".Actor")
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

local size = 44

function Detective:load()
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
        {
            width = 1, height = 1, state = "TURN_N_MOVE",
            closet = {
                love.graphics.newImage("res/earth/closet_f.png"), 
                love.graphics.newImage("res/earth/closet_l.png"), 
                love.graphics.newImage("res/earth/closet_b.png"), 
            },
            closet2 =  {
                love.graphics.newImage("res/earth/2Closet_f.png"),  
                love.graphics.newImage("res/earth/2Closet_l.png"), 
                love.graphics.newImage("res/earth/2Closet_b.png"), 
            }
            chair = {
                love.graphics.newImage("res/earth/chair_f.png"),
                love.graphics.newImage("res/earth/chair_l.png"),
                love.graphics.newImage("res/earth/chair_b.png"),
            }
        }
        {
            width = 2, height = 2, state = "MOVE",
            bed = {
                love.graphics.newImage("res/earth/bed_f.png"),
                love.graphics.newImage("res/earth/bed_l.png"),
                love.graphics.newImage("res/earth/bed_b.png"),
            },
            closet3 = {
                love.graphics.newImage("res/earth/4Closet_f.png"),
                love.graphics.newImage("res/earth/4Closet_l.png"),
                love.graphics.newImage("res/earth/4Closet_b.png"),
            }
        },
        -- decoration
        {
            wall = {
                love.graphics.newImage("res/earth/bigPic.png"),
                love.graphics.newImage("res/earth/smallPic.png"),
                love.graphics.newImage("res/earth/clock.png"),
                love.graphics.newImage("res/earth/door.png"),
                love.graphics.newImage("res/earth/door2.png"),
            },
            floor {
                love.graphics.newImage("res/earth/carpet.png"),
            }
        },
    }

    eh_ActorTexture = {
        love.graphics.newImage("res/earth/detective.png"),
        love.graphics.newImage("res/earth/thife.png"),
    }

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
end

function Detective:initActors()
    self.actors = {}

    -- detective
    local row = 3
    local col = 2
    self.actors[1] = Actor.new(1, {
        moves = 4, 
        property = 1,

        row = row,
        col = 2,
        x = self.tiles[row][col].x,
        y = self.tiles[row][col].y
    })

    -- thief
    row = 6
    col = 6
    self.actors[2] = Actor.new(2, {
        moves = 3, 
        property = 1,

        row = row,
        cpl = col,
        x = self.tiles[row][col].x,
        y = self.tiles[row][col].y
    })

    self.currentActor = self.actors[1]
end

function Detective:moveActor(oCol, oRow)
    -- check the next tile that actor is going is walkable
    -- if not, return
    local rows = self.tiles[self.currentActor.row+oRow]
    local nextTile = rows and rows[self.currentActor.col+oCol]
    if not nextTile or not nextTile:canWalk() then
        eh_append2Output("tile is not walkable")
        return
    end

    -- move actor to the next tile
    -- if the actor is not in the 3/4 center of the screen, 
    -- move the camera meanwhile.
    self.currentActor:move(oCol*size, oRow*size, oRow, oCol)
    if self.currentActor.x < eh_screen.quanterRect[1]
        or self.currentActor.x > eh_screen.quanterRect[3] 
        or self.currentActor.y < eh_screen.quanterRect[2]
        or self.currentActor.y > eh_screen.quanterRect[4] then
            self:moveCamera(-oCol, -oRow)
    end
    eh_append2Output(string.format("move %d,%d", self.currentActor.row, self.currentActor.col))
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
    eh_append2Output(string.format("mapLeft:%d top:%d wid:%d hit:%d", self.mapLeft, self.mapTop, self.mapWidth, self.mapHeight))

    -- move tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile:move(ox, oy)
        end
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
    -- 记录当前摄像机的位置
    local lastMapLeft = self.lastMapLeft
    local lastMapTop = self.lastMapTop
    self.lastMapLeft = self.mapLeft
    self.lastMapTop = self.mapTop
    for i, v in ipairs(self.actors) do
        if v ~= self.currentActor then
            self.currentActor = v
            break
        end
    end
    -- 把上一轮的摄像机位置还原
    -- 如果没有上一轮的摄像机位置，就用角色的当前位置来定
    if not lastMapLeft then
        lastMapLeft = self.currentActor.x
    end
    if not lastMapTop then
        lastMapTop = self.currentActor.y
    end
    -- 以摄像机位置为坐标原点，计算所有坐标的位置
    -- tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile.x = tile.x - lastMapLeft
            tile.y = tile.y - lastMapTop
        end
    end
    -- properties
    -- actors
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

    -- draw furniture
    for i, fur in ipairs(self.furniture) do
        fur:draw()
    end

    -- draw actor
    if self.currentActor then
        self.currentActor:draw()
    end
end



------- key events
function Detective:keypressed(key)
    eh_append2Output("pressed "..key)
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
    end
end

return Detective