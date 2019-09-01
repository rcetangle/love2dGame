local ChooseGame = class("ChooseGame", require(".earth_scene"))

function ChooseGame:load()
    self.rectX = eh_screen.cx-50
    self.rectY = eh_screen.cy-50

    self.txt = "no key is pressed"
    self.list = {
        "Detective",
    }
    self.index = 1
end

function ChooseGame:draw()
    if not self:isRunning() then return end
    love.graphics.rectangle("line", self.rectX, self.rectY, 150, 30)

    for i, v in ipairs(self.list) do
        love.graphics.print(v, self.rectX+50, eh_screen.cy-93+50*i)
    end
    love.graphics.print(self.txt, 0, 0)
end

function ChooseGame:keypressed(key)
    self.txt = key
end

function ChooseGame:keyreleased(key)
    if key == "down" then
        self.index = self.index + 1
        self.rectY = self.rectY + 50
    elseif key == "up" then
        self.index = self.index - 1
        self.rectY = self.rectY - 50
    elseif key == "return" then
        self:stopScene()
    end
end

function ChooseGame:stopScene()
    self.index = math.max(1, self.index)
    self.index = math.min(#self.list, self.index)
    self:setStateStop()
    eh_safeCallFunc(self.callback, self.index)
end

return ChooseGame