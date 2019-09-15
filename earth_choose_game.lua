local ChooseGame = class("ChooseGame", require(".earth_scene"))
local Timer = require "menu_timer"
function ChooseGame:load()
    -- self.list = {
    --     -- love.graphics.newImage("assets/detective.png"),
    --     love.graphics.newImage("assets/fight.png"),
    --     love.graphics.newImage("assets/detective.png"),
    -- }
    self.index = 0
    self.imgIndex = {10, 16}

    self.current_img = 1
    self.delta = 1
    self.menu_imgs = {}
    for i= 1, 16 do
      self.menu_imgs[i] = love.graphics.newImage("assets/".. i ..".png")
    end
    self.desktop = love.graphics.newImage("assets/desktop.png")

    self.menu_timer = Timer.new()
    self.menu_timer:addPeriodic(0.1, function()
        self:change_menu()
    end)
end

function ChooseGame:change_menu()
    if self.delta == 1 then
        if self.current_img < self.imgIndex[self.index+1] then
            self.current_img = self.current_img + 1
        end
    elseif self.delta == -1 then
        if self.current_img > self.imgIndex[self.index+1] then
            self.current_img = self.current_img - 1
        end
    end
end

function ChooseGame:update(dt)
    self.menu_timer:update(dt)
end

function ChooseGame:draw()
    if not self:isRunning() then return end
    -- menu_draw()
    love.graphics.draw(self.desktop)
    love.graphics.draw(self.menu_imgs[self.current_img])
    -- for i, v in ipairs(self.list) do
    --     love.graphics.draw(v, eh_screen.cx-100, eh_screen.cy-100+50*i)
    -- end
    -- love.graphics.rectangle("line", eh_screen.cx-100, eh_screen.cy-50+50*self.index, 200, 50)
end

function ChooseGame:keyreleased(key)
    eh_append2Output(key)
    if key == "escape" then
        -- love.window.close()
        love.event.quit()
    elseif key == "left" then
        local lastIdx = self.index
        self.index = (self.index+1)%#self.imgIndex
        self.delta = self.index > lastIdx and 1 or -1
    elseif key == "right" then
        local lastIdx = self.index
        self.index = (self.index-1)%#self.imgIndex
        self.delta = self.index > lastIdx and 1 or -1
    elseif key == "return" or key == "enter" then
        self:stopScene()
    end
end

function ChooseGame:stopScene()
    self.index = math.max(0, self.index)
    self.index = math.min(#self.imgIndex-1, self.index)
    self:setStateStop()
    eh_safeCallFunc(self.callback, self.index+1)
end

return ChooseGame