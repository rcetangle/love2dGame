local Tile = require(".Tile")
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
    self.txt = ""

    self.imgs = {
        love.graphics.newImage("res/earth/0.png"),
        love.graphics.newImage("res/earth/1.png"),
        love.graphics.newImage("res/earth/wall_5.png"),
        love.graphics.newImage("res/earth/wall_4.png"),
        love.graphics.newImage("res/earth/wall_3.png"),
        love.graphics.newImage("res/earth/wall_2.png"),
        love.graphics.newImage("res/earth/wall_1.png"),
    }

    self:initTilesMap()
end

function Detective:initTilesMap()
    self.mapHeight = #map*size
    self.mapWidth = #map[1]*size-32
    self.mapLeft = 0
    self.mapTop = 0
    self.tiles = {}
    for i, v in ipairs(map) do
        self.tiles[i] = {}
        for j, w in ipairs(v) do
            if w < 0 and w > -100 then
                self.tiles[i][j] = Tile.new(self.imgs[#self.imgs+w+1], w, -32+size*(j-1), size*(i-1))
            elseif w >= 0 then
                self.tiles[i][j] = Tile.new(self.imgs[w+1], w, -32+size*(j-1), size*(i-1))
            end
        end
    end
end

function Detective:moveCamera(ox, oy)
    ox = ox * size
    oy = oy * size

    -- x direction
    local tmpLeft = self.mapLeft + ox
    if tmpLeft > 0 
        or tmpLeft + self.mapWidth <= eh_screen.width then
        return
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

function Detective:update()
    if not self:isRunning() then return end
end

function Detective:draw()
    if not self:isRunning() then return end

    -- draw tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile:draw()
        end
    end


    -- draw txt
    love.graphics.print(self.txt, 0, 0)
end

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
    end
end

return Detective