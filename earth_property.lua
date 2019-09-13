local PRO_STATE = {
    NONE = 1, -- not movable and not turnable
    MOVE = 2, -- movable
    TURN = 3, -- turnable
    TURN_N_MOVE = 4, -- movable and turnable
    HURT = 5, -- can hurt actor
    KEY = 6
}
local Property = class("Property")
function Property:ctor(parms)
    self.texture = parms.texture
    self.frames = parms.frames
    self.state = PRO_STATE[parms.state or "NONE"]
    self.width = parms.width or 1
    self.height = parms.height or 1
    self.x = parms.x or 0
    self.y = parms.y or 0
    self.row = parms.row or 0
    self.col = parms.col or 0
    self.sx = parms.sx
    self.sy = parms.sy
    self.hurtMoves = parms.hurtMoves or 1
    self.byWhom = parms.byWhom
    self.rotateFrame = 1

    -- adjust the anchor point if needed
    if self.texture:getHeight() > 44 then
        self.y = self.y-self.texture:getHeight()+44 -- set the anchor point to left,bottom
    end
    if self.state ~= PRO_STATE.NONE then
        self.y = self.y - 10
    end
end

function Property:draw(actor)
    if not self.texture then return end
    -- an actor can not see the property that is put by other actors 
    if self.byWhom and self.state == PRO_STATE.HURT and self.byWhom ~= actor then return end
    -- key is invisible
    if self.byWhom ~= actor and self.state == PRO_STATE.KEY then return end
    love.graphics.draw(self.texture, self.x, self.y, 0, self.sx, self.sy)
    -- love.graphics.print(self.row..","..self.col, self.x, self.y)
end

function Property:move(ox, oy, oRow, oCol)
    self.x = self.x + ox
    self.y = self.y + oy
    self.row = self.row + oRow
    self.col = self.col + oCol
end

function Property:rotate()
    if self.state ~= PRO_STATE.TURN and self.state ~= PRO_STATE.TURN_N_MOVE then return end
    if not self.frames then return end
    self.rotateFrame = math.max(1, (self.rotateFrame+1)%(#self.frames+1))
    self.texture = self.frames[self.rotateFrame]
end

function Property:containsTile(row, col)
    -- eh_append2Output(string.format("%d - %d ht:%d, %d - %d wd:%d", row, self.row, self.height, col, self.col, self.width))
    return row <= self.row 
        and self.row - row < self.height 
        and col >= self.col
        and col - self.col < self.width
end

function Property:getEdges(oRow, oCol)
    local ret = {}
    if oRow == 0 then -- x direction
        local col = oCol < 0 and self.col or self.col+self.width-1
        for i = 1, self.height do
            table.insert(ret, {self.row-i+1, col+oCol})
        end
    elseif oCol == 0 then
        local row = oRow < 0 and self.row-self.height+1 or self.row
        for i = 1, self.width do
            table.insert(ret, {row+oRow, self.col+i-1})
        end
    end
    return ret
end

function Property:touchActor(actor)
    -- eh_append2Output("some one touch "..tostring(actor == self.byWhom)..tostring(self.state))
    if actor ~= self.byWhom and self.state == PRO_STATE.HURT then
        self.state = PRO_STATE.NONE
        self.texture = self.frames[2] -- change texture
        return self.hurtMoves
    end
    return 0
end

function Property:touchKey(actor)
    if self:isKey() then
        self.byWhom = actor
    end
end

function Property:isKey()
    return self.state == PRO_STATE.KEY
end

function Property:setStateNone()
    self.state = PRO_STATE.NONE
end

return Property