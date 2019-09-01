-- the main file
require ".class"
require ".earth_utils"

-- global params.
eh_screen = {}
eh_screen.width = 320
eh_screen.height = 240
eh_screen.cx = eh_screen.width/2
eh_screen.cy = eh_screen.height/2
eh_screen.left = 0
eh_screen.top = 0
eh_screen.right = eh_screen.width
eh_screen.bottom = eh_screen.height

-- scene list
local eh_currentScene = nil
local eh_sceneList = {
    -- ".Scenario", 
    -- ".ChooseGame", 
    ".detective",
    ".Scenario"
}
local eh_index = 0
function earth_go2NextScene()
    currentScene = nil
    eh_index = eh_index + 1
    
    assert(eh_index <= #eh_sceneList, "no more scene")
    currentScene = require(eh_sceneList[eh_index]).new({
        step = eh_index,
        callback=earth_go2NextScene
    })
    currentScene:load()
end

-- called only once,
-- when the game is started
function love.load()
    earth_go2NextScene()
end

-- called continuosly
-- all the drawing happens here
function love.draw()
    if currentScene then
        currentScene:draw()
    end
end

-- called continuosly
-- most of math is done here
function love.update(dt)
    if currentScene then
        currentScene:update(dt)
    end
end

-- called when a keyboard key is pressed
function love.keypressed(key)
    if currentScene then
        currentScene:keypressed(key)
    end
end

-- called when a keyboard key is released
function love.keyreleased(key)
    if currentScene then
        currentScene:keyreleased(key)
    end
end

-- called whenever the love window is focus or not.
function love.focus(f)
end

-- called when the love window will be closed.
function love.quit()
end

-- -- called when a mouse button is pressed
-- function love.mousepressed(x, y, btn, istouch)
-- end

-- -- called when a mouse button is released
-- function love.mousereleased(x, y, btn, istouch)
-- end