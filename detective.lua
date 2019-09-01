local Detective = class("Detective", require(".earth_scene"))

local map = {
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 0, 0, 1, 0, 0, 1},
    {1, 1, 0, 0, 1, 0, 0, 1},
    {1, 1, 0, 0, 1, 0, 0, 1},
    {1, 1, 0, 0, 1, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1},
}

local size = 44

function Detective:load()
    self.imgs = {
        love.graphics.newImage("res/earth/0.png"),
        love.graphics.newImage("res/earth/1.png"),
    }
end

function Detective:update()
    if not self:isRunning() then return end
end

function Detective:draw()
    if not self:isRunning() then return end
    for i, v in ipairs(map) do
        for j, w in ipairs(v) do
            love.graphics.draw(self.imgs[w+1], size*(j-1), size*(i-1))
        end
    end
end

function Detective:keypressed(key)
end

function Detective:keyreleased(key)
end

return Detective