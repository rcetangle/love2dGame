local Scene = class("Scene")

local STATE = {
    RUNING = 1,
    STOP = 2
}
Scene.STATE = STATE

function Scene:ctor(parms)
    self.state = STATE.RUNING
    self.step = parms.step
    self.callback = parms.callback
end

function Scene:isRunning()
    return self.state == STATE.RUNING
end

function Scene:setStateStop()
    self.state = STATE.STOP
end

function Scene:stopScene()
    eh_safeCallFunc(self.callback)
end

function Scene:draw()
end

function Scene:update(dt)
end

function Scene:keypressed(key)
end

function Scene:keyreleased(key)
end

return Scene