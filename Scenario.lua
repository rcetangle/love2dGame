
local Scenario = class("Scenario", require(".earth_scene"))

function Scenario:load()
    self.frames = {}

    if self.step == 1 then
        self.txt = "this is opening..."
        self:initOpeningFrames()
    else
        self.txt = "this is ending..."
        self:initEndingFrames()
    end

    self.currentFrame = 1
    local img = self.frames[1]
    self.frameX = eh_getPosInWorld(0, img:getWidth(), eh_screen.cx)
    self.frameY = eh_getPosInWorld(0, img:getHeight(), eh_screen.cy)

    self.time = 3
end

function Scenario:initOpeningFrames()
    for i = 1, 5 do
        table.insert(self.frames, love.graphics.newImage("res/jump"..i..".png"))  
    end
end

function Scenario:initEndingFrames()
    for i = 5, 1, -1 do
        table.insert(self.frames, love.graphics.newImage("res/jump"..i..".png"))  
    end
end

function Scenario:draw()
    if not self:isRunning() then return end
    self:playAnimation()
end

function Scenario:update(dt)
    if not self:isRunning() then return end

    self.currentFrame = self.currentFrame + dt * 5
    if self.currentFrame >= #self.frames then
        self.currentFrame = 1
        self.time = self.time - 1
        if self.time < 0 then
            self.time = 0
            self:stopScene()
        end
    end
end

function Scenario:playAnimation()
    local img = self.frames[math.floor(self.currentFrame)]
    love.graphics.draw(
        self.frames[math.floor(self.currentFrame)], 
        self.frameX, self.frameY)
        
    love.graphics.print(self.txt..self.time, 0, 0)
end

function Scenario:stopScene()
    if self.step == 1 then
        Scenario.super.stopScene(self)
    else
        self.txt = "bye bye~~"
    end
end
return Scenario