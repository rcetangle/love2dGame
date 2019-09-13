local ChooseGame = class("ChooseGame", require(".earth_scene"))

function ChooseGame:load()
    self.list = {
        love.graphics.newImage("assets/detective.png"),
        love.graphics.newImage("assets/fight.png"),
        love.graphics.newImage("assets/detective.png"),
    }
    self.index = 0
end

function ChooseGame:draw()
    if not self:isRunning() then return end
    for i, v in ipairs(self.list) do
        love.graphics.draw(v, eh_screen.cx-100, eh_screen.cy-100+50*i)
    end
    love.graphics.rectangle("line", eh_screen.cx-100, eh_screen.cy-50+50*self.index, 200, 50)
end

function ChooseGame:keyreleased(key)
    eh_append2Output(key)
    if key == "escape" then
        love.window.close()
    elseif key == "down" then
        self.index = (self.index+1)%#self.list
    elseif key == "up" then
        self.index = (self.index-1)%#self.list
    elseif key == "return" or key == "enter" then
        self:stopScene()
    end
end

function ChooseGame:stopScene()
    self.index = math.max(0, self.index)
    self.index = math.min(#self.list-1, self.index)
    self:setStateStop()
    eh_safeCallFunc(self.callback, self.index+1)
end

return ChooseGame