local Tile = require(".earth_tile")
local Actor = require(".earth_actor")
local Property = require(".earth_property")
local mapConfig = require(".earth_level_config")

local Detective = class("Detective", require(".earth_scene"))

local size = 44
local map = {}
local propertyMap = {}

function Detective:load()
    math.randomseed(os.time())
    self.winCnts = {0, 0}
    self.gameTurn = 1
    self:resetGame()
end

function Detective:resetGame()
    local gameTurn = self.gameTurn
    if gameTurn > 2 then
        self:stopScene()
        return
    end

    -- load map
    map = mapConfig["tileMap"..gameTurn]
    eh_TileTexture = mapConfig["tileTexture"..gameTurn]

    propertyMap = mapConfig["propertyMap"..gameTurn]
    eh_FurnitureCfg = mapConfig["furnitureCfg"..gameTurn]


    self:initTilesMap()
    self:initFurniture()
    self:initActors()

    self:initTopUI()

    self.gameTurn = gameTurn + 1
    self.isGameEnd = false
    self.canRestart = false
    self.winner = ""
end

function Detective:initTopUI()
    self.m_uis = {
        {eh_UITexture.top, 0, 0, 1}, -- top bg
        {eh_UITexture[self.currentActor.name], 0, 0, 1}, -- head
        {eh_PropTexture[self.currentActor.name][1], 224, 0, 0.4}, -- prop
        {eh_UITexture["num_"..self.winCnts[2]], 145, 4, 1}, -- thief win cnt
        {eh_UITexture["num_"..self.winCnts[1]], 177, 4, 1}, -- detective win cnt
    }
end
function Detective:initTilesMap()
    self.mapLeft = 0
    self.mapTop = 0
    self.tiles = {}
    local lastY = 0
    local lastX = 0
    local blackCnt = 0
    for i, v in ipairs(map) do
        self.tiles[i] = {}
        lastX = -size/2
        for j, w in ipairs(v) do
            self.tiles[i][j] = Tile.new(w+1, lastX, lastY, i, j)
            if j < #v then
                lastX = lastX + size
            else
                lastX = lastX+size/2
            end
            if w == 0 then
                blackCnt = blackCnt + 1
            end
        end
        lastY = lastY + size
    end
    self.mapWidth = lastX
    self.mapHeight = lastY

    -- random key
    local rand = math.random(1, blackCnt)
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            if tile:canHide() then
                rand = rand-1
                if rand <= 1 then
                    local key = Property.new({
                        texture = eh_PropTexture.key[1],
                        state = "KEY"    
                    })
                    tile:putProperty(key)
                    return
                end
            end
        end
    end
end

function Detective:initFurniture()
    self.furniture = {}
    self.furnitureMap = {}
    self.decoration = {}
    for i, v in ipairs(propertyMap) do
        local dt = table.clone(eh_FurnitureCfg[v.name])
        table.merge(dt, v)
        dt.texture = dt.frames and dt.frames[v.frame or 1] or dt[v.frame or 1]
        dt.x = self.tiles[v.row][v.col].x
        dt.y = self.tiles[v.row][v.col].y
        if v.name == "decoration" then
            table.insert(self.decoration, Property.new(dt))
        else
            local newFur = Property.new(dt)
            table.insert(self.furniture, newFur)

            for h = newFur.row, newFur.row-newFur.height+1, -1 do
                if not self.furnitureMap[h] then
                    self.furnitureMap[h] = {}
                end
                for w = newFur.col, newFur.col+newFur.width-1 do
                    self.furnitureMap[h][w] = newFur
                end
            end
        end
    end
end

function Detective:initActors()
    self.actors = {}

    -- detective
    local dtvCfg = mapConfig["detective"..self.gameTurn]
    dtvCfg.x = self.tiles[dtvCfg.row][dtvCfg.col].x
    dtvCfg.y = self.tiles[dtvCfg.row][dtvCfg.col].y - size/3
    self.actors[1] = Actor.new("detective", dtvCfg)

    -- thief
    local tfCfg = mapConfig["thief"..self.gameTurn]
    tfCfg.x = self.tiles[tfCfg.row][tfCfg.col].x
    tfCfg.y = self.tiles[tfCfg.row][tfCfg.col].y - size/3
    self.actors[2] = Actor.new("thief", tfCfg)

    self.currentActor = self.actors[1]
end

-- check the property can move 2 tile
function Detective:isPropertyCanMove2Tile(property, oRow, oCol)
    -- check the next tile that actor is going is walkable
    -- if not, return
    local arr = property:getEdges(oRow, oCol)
    for i, v in ipairs(arr) do
        -- eh_append2Output(string.format("edge %d,%d (%d,%d)", v[1], v[2], oRow, oCol))
        local rows = self.tiles[v[1]]
        local nextTile = rows and rows[v[2]]
        if not nextTile or not nextTile:canPutFurniture() then
            -- eh_append2Output("tile is can not put property")
            return false
        end

        if self.furnitureMap[nextTile.row] and self.furnitureMap[nextTile.row][nextTile.col] ~= nil then
            eh_append2Output(string.format("has property %d,%d", nextTile.row, nextTile.row))
            return false
        end
    end
    return true
end

function Detective:moveActor(oCol, oRow)
    -- check the next tile that actor is going is walkable
    -- if not, return
    local rows = self.tiles[self.currentActor.row+oRow]
    local nextTile = rows and rows[self.currentActor.col+oCol]
    if not nextTile or not nextTile:canWalk() then
        -- eh_append2Output("next tile is not walkable")
        return
    end
    
    local nextProperty = self.furnitureMap[nextTile.row] and self.furnitureMap[nextTile.row][nextTile.col]

    if nextProperty then
        -- change facing direction
        self.currentActor:changeDirection(oRow, oCol)
        if not self.pressedA or not self.currentActor:hasMoves() then
            -- eh_append2Output("cannot walk through the property")
            return
        end
    end

    local facingProperty = nil
    if self.pressedA and self.currentActor:hasMoves() then
        -- get the facing property and move it
        local faceRow, faceCol = self.currentActor:getFaceTileIdx()
        facingProperty = self.furnitureMap[faceRow] and self.furnitureMap[faceRow][faceCol]

        if facingProperty then
            if not self:isPropertyCanMove2Tile(facingProperty, oRow, oCol) then
                return
            end

            for h = facingProperty.row, facingProperty.row-facingProperty.height+1, -1 do
                if self.furnitureMap[h] then 
                    for w = facingProperty.col, facingProperty.col+facingProperty.width-1 do
                        self.furnitureMap[h][w] = nil
                    end
                end
            end
            facingProperty:move(oCol*size, oRow*size, oRow, oCol)
            for h = facingProperty.row, facingProperty.row-facingProperty.height+1, -1 do
                if not self.furnitureMap[h] then 
                    self.furnitureMap[h] = {}
                end
                for w = facingProperty.col, facingProperty.col+facingProperty.width-1 do
                    self.furnitureMap[h][w] = facingProperty
                end
            end
            self.currentActor:reduceMoves()
        end
    end

    -- -- 还需要选择家具 获取row, col为中心的四个格子的家具。旋转他们
    -- local nowRow = self.currentActor.row
    -- local nowCol = self.currentActor.col
    -- local furnitureNearby = {
    --     self.furnitureMap[nowRow-1] and self.furnitureMap[nowRow-1][nowCol],
    --     self.furnitureMap[nowRow+1] and self.furnitureMap[nowRow+1][nowCol],
    --     self.furnitureMap[nowRow] and self.furnitureMap[nowRow][nowCol-1],
    --     self.furnitureMap[nowRow] and self.furnitureMap[nowRow][nowCol+1]
    -- }
    -- for k, fur in pairs(furnitureNearby) do
    --     if fur ~= facingProperty then
    --         fur:rotate()
    --     end
    -- end


    -- move actor to the next tile
    self.currentActor:move(oCol*size, oRow*size, oRow, oCol, not self.pressedA)

    if nextTile:hasProperty() then -- actor hurt by a property
        eh_append2Output("hasProperty!")
        self.currentActor:hurtByProperty(nextTile:getProperty())
    end

    -- move the camera meanwhile.
    local edgeDis = size*2
    if (oCol > 0 and self.currentActor.x > eh_screen.width-edgeDis)
        or (oCol < 0 and self.currentActor.x < edgeDis) 
        or (oRow > 0  and self.currentActor.y > eh_screen.height-edgeDis)
        or (oRow < 0 and self.currentActor.y < edgeDis) then
        self:moveCamera(-oCol, -oRow)
    end
    -- eh_append2Output(string.format("move %d,%d face %d", self.currentActor.row, self.currentActor.col, self.currentActor.face))
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
    -- eh_append2Output(string.format("mapLeft:%d top:%d wid:%d hit:%d", self.mapLeft, self.mapTop, self.mapWidth, self.mapHeight))

    -- move tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile:move(ox, oy)
        end
    end

    -- move decoration
    for i, v in ipairs(self.decoration) do
        v:move(ox, oy, 0, 0)
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
    local tile = self.tiles[self.currentActor.row][self.currentActor.col]
    local canHide = self.currentActor:hideOnTile(tile)
    if not canHide then 
        eh_append2Output("cannot hide on this tile.")
        return false
    end

    local isTwoMet = self.actors[1]:hasSameHidenTile(self.actors[2].hidenTile)
    if isTwoMet then
        self:gameEnd("detective")
        return
    end

    if self.currentActor.name == "thief" and tile:hasKey() then
        tile.property:touchKey(self.currentActor)
        self:gameEnd("thief")
        return
    end

    -- change the current actor to another
    local lastActor = self.currentActor
    for i, v in ipairs(self.actors) do
        if v ~= self.currentActor then
            self.currentActor = v
            self.currentActor:resetMoves()
            break
        end
    end
    -- calculate the offset
    local oRow = lastActor.row - self.currentActor.row
    local oCol = lastActor.col - self.currentActor.col
    -- move the camera
    self:moveCamera(oCol, oRow)
    -- change uis
    self.m_uis[2][1] = eh_UITexture[self.currentActor.name]
    self.m_uis[3][1] = eh_PropTexture[self.currentActor.name][1]

    return true
end

function Detective:gameEnd(winner)
    self.isGameEnd = true
    self.canRestart = false
    self.deltaTime = 2
    self.winner = winner
    if winner == "detective" then
        self.winCnts[1] = self.winCnts[1] + 1
    else
        self.winCnts[2] = self.winCnts[2] + 1
    end
end

function Detective:update(dt)
    if not self:isRunning() then return end
    if self.isGameEnd and not self.canRestart then
        if self.deltaTime >= 2 then
            self.currentActor.texture = self.currentActor.textures[1][1]
        elseif self.deltaTime >= 1 then
            -- eh_append2Output(tostring(dt))
            self.currentActor.y = self.currentActor.y + -self.currentActor.oy * dt
            self.currentActor.x = self.currentActor.x + -self.currentActor.ox * dt
        elseif self.deltaTime <= 0 then
            self.canRestart = true
        end
        self.deltaTime = self.deltaTime - dt
    end
end

function Detective:draw()
    if not self:isRunning() then return end

    if self.canRestart then
        love.graphics.draw(eh_UITexture["ret_"..self.winner], 110, 45)
        love.graphics.draw(eh_UITexture[self.winner.."_big"], 123, 75)
        love.graphics.draw(eh_UITexture["ret_light"], 85, 0)
        love.graphics.print("press 'enter' to restart.")
        return
    end
    -- shiftint actor
    if self.shiftClicked then 
        love.graphics.print("shift to another player...\npress 'space' again when shifting finished.")
        return 
    end

    -- draw tiles
    for i, v in ipairs(self.tiles) do
        for j, tile in ipairs(v) do
            tile:draw(self.currentActor)
        end
    end

    -- draw decoration
    for i, dec in ipairs(self.decoration) do
        dec:draw()
    end

    -- draw actors and furniture
    -- row determins the priority of drawing
    -- lower row, higher priority.
    local tmps = {}
    -- actors
    if self.isGameEnd then
        for i, actor in ipairs(self.actors) do
            table.insert(tmps, actor)
        end
    elseif self.currentActor then
        table.insert(tmps, self.currentActor)
    end

    -- furniture
    for i, fur in ipairs(self.furniture) do
        table.insert(tmps, fur)
    end

    -- sort tmps by row
    table.sort(tmps, function(a, b)
        return a.row < b.row
    end)

    -- draw them
    for i, v in ipairs(tmps) do
        v:draw()
    end

    -- draw uis
    for i, v in ipairs(self.m_uis) do
        love.graphics.draw(v[1], v[2], v[3], 0, v[4], v[4])
    end
    love.graphics.print(self.currentActor.moves, 72, 0)
    love.graphics.print(self.currentActor.propertyCnt, 250, 0)
end

------- key events
function Detective:keypressed(key)
    if self.shiftClicked then return end

    -- eh_append2Output("pressed "..key)
    if key == "a" then
        self.pressedA = true
    end
end

function Detective:keyreleased(key)
    if key == "escape" then
        self:stopScene()
    elseif (key == "return" or key == "enter") and self.canRestart then
        self:resetGame() -- restart
    end

    if self.isGameEnd then return end

    if key == "space" then -- shitf 2 another actor
        if not self.shiftClicked then
            self.shiftClicked = self:shiftActor()
        else
            self.shiftClicked = false
        end
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
    elseif key == "a" then
        self.pressedA = false
    elseif key == "z" then
        self.currentActor:putPropertyOnTile(self.tiles[self.currentActor.row][self.currentActor.col])
    elseif key == "x" then
        local tile = self.tiles[self.currentActor.row][self.currentActor.col]
        local searchSucc = self.currentActor:searchTile(tile)
        if searchSucc then
            local another = self.currentActor == self.actors[1] and self.actors[2] or self.actors[1]
            local isTwoMet = another:hasSameHidenTile(tile)
            if isTwoMet then
                self:gameEnd("detective")
            end
            
            -- is key
            if tile:hasKey() then
                tile.property:touchKey(self.currentActor)
                if self.currentActor.name == "thief"  then
                    self:gameEnd("thief")
                end
            end
        end
    end
end

return Detective