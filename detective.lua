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
    eh_FurnitureTexture = {
        -- furniture
        {
            love.graphics.newImage("res/earth/closet_f.png"), 
            love.graphics.newImage("res/earth/closet_l.png"), 
            love.graphics.newImage("res/earth/closet_b.png"), 
        },
        {
            love.graphics.newImage("res/earth/2Closet_f.png"),  
            love.graphics.newImage("res/earth/2Closet_l.png"), 
            love.graphics.newImage("res/earth/2Closet_b.png"), 
        },
        {
            love.graphics.newImage("res/earth/chair_f.png"),
            love.graphics.newImage("res/earth/chair_l.png"),
            love.graphics.newImage("res/earth/chair_b.png"),
        },
        love.graphics.newImage("res/earth/bed_f.png"),
        love.graphics.newImage("res/earth/bed_l.png"),
        love.graphics.newImage("res/earth/bed_b.png"),
        love.graphics.newImage("res/earth/4Closet_f.png"), 
        love.graphics.newImage("res/earth/4Closet_l.png"), 
        love.graphics.newImage("res/earth/4Closet_b.png"), 

        -- decoration
        love.graphics.newImage("res/earth/bigPic.png"),
        love.graphics.newImage("res/earth/smallPic.png"),
        love.graphics.newImage("res/earth/clock.png"),
        love.graphics.newImage("res/earth/door.png"),
        love.graphics.newImage("res/earth/door2.png"),
        love.graphics.newImage("res/earth/carpet.png"),
    }
    eh_ActorTexture = {
        love.graphics.newImage("res/earth/detective.png"),
        love.graphics.newImage("res/earth/thife.png"),
    }


    self.txt = ""
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
    self.actors[1] = Actor.new(1, {
        moves = 4, 
        property = 1
    })

    -- thief
    self.actors[2] = Actor.new(2, {
        moves = 3, 
        property = 1
    })

    self.currentActor = self.actors[1]
end

function Detective:moveCamera(ox, oy)
    ox = ox * size
    oy = oy * size

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
    self.txt = self.txt.."\nleft:"..self.mapLeft.." top:"..self.mapTop.." width:"..self.mapWidth.." height:"..self.mapHeight

    -- move tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile:move(ox, oy)
        end
    end

    -- move properties

    -- move actors
end

function Detective:shiftActor()
    for i, v in ipairs(self.actors) do
        if v ~= self.currentActor then
            self.currentActor = v
            break
        end
    end
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

    -- draw txt
    love.graphics.print(self.txt, 0, 0)
end



------- key events
function Detective:keypressed(key)
    self.txt = "pressed "..key
end

function Detective:keyreleased(key)
    if key == "down" then
        self:moveCamera(0, -1)
    elseif key == "up" then
        self:moveCamera(0, 1)
    elseif key == "left" then
        self:moveCamera(1, 0)
    elseif key == "right" then
        self:moveCamera(-1, 0)
    elseif key == "space" then
        if not self.shiftClicked then
            self.shiftClicked = true
            self:shiftActor()
        else
            self.shiftClicked = false
        end
    end
end

return Detective