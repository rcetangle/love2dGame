Attribute = Object.extend(Object)
function Attribute:new(imgPath, x, y)
    self.img = love.graphics.newImage(imgPath)
    self.x = x
    self.y = y
end

Attack_A = Object.extend(Object)
function Attack_A:new()
    self.normal = Attribute("assets/fight/null.png", -42, -42)
    self.attack = Attribute("assets/fight/player-a/attack.png", 144, 100)
end

Tongue_A = Object.extend(Object)
function Tongue_A:new()
    self.normal = Attribute("assets/fight/null.png", -42, -42)
    self.lose = Attribute("assets/fight/player-a/tongue.png", 74, 163)
end

Head_A= Object.extend(Object)
function Head_A:new()
    self.ready  = Attribute("assets/fight/player-a/head-ready.png",  34, 78)
    self.hitted = Attribute("assets/fight/player-a/head-hitted.png", 20, 78)
    self.win    = Attribute("assets/fight/player-a/head-win.png",    34, 78)
    self.lose   = Attribute("assets/fight/player-a/head-lose.png",   25, 83)
end

Hand_Right_A= Object.extend(Object)
function Hand_Right_A:new()
    self.ready  = Attribute("assets/fight/player-a/hand-right-ready.png",  18, 178)
    self.attack = Attribute("assets/fight/player-a/hand-right-attack.png", 154, 128)
    self.defend = Attribute("assets/fight/player-a/hand-right-defend.png", 68, 130)
    self.win    = Attribute("assets/fight/player-a/hand-right-win.png",    18, 167)
    self.lose   = Attribute("assets/fight/player-a/hand-right-lose.png",    -10, 166)
end

Hand_Left_A= Object.extend(Object)
function Hand_Left_A:new()
    self.ready  = Attribute("assets/fight/player-a/hand-left-ready.png",  110, 152)
    self.attack = Attribute("assets/fight/player-a/hand-left-attack.png", 154, 132)
    self.defend = Attribute("assets/fight/player-a/hand-left-defend.png", 88, 122)
    self.win    = Attribute("assets/fight/player-a/hand-left-win.png",    93, 168)
    self.lose   = Attribute("assets/fight/player-a/hand-left-lose.png",   110, 166)
end

Arm_Right_A= Object.extend(Object)
function Arm_Right_A:new()
    self.straight = Attribute("assets/fight/player-a/arm-straight.png",  43, 150)
    self.bent     = Attribute("assets/fight/player-a/arm-right-bent.png", 4, 148)
    self.lose     = Attribute("assets/fight/player-a/arm-lose.png",  8, 174)
    self.defend   = Attribute("assets/fight/player-a/arm-left-bent.png", 33, 153)
end

Arm_Left_A= Object.extend(Object)
function Arm_Left_A:new()
    self.straight = Attribute("assets/fight/player-a/arm-straight.png",  80, 158)
    self.bent     = Attribute("assets/fight/player-a/arm-left-bent.png", 82, 158)
    self.lose     = Attribute("assets/fight/player-a/arm-left-bent.png", 82, 176)
    self.defend   = self.bent
end

Body_Upper_A = Object.extend(Object)
function Body_Upper_A:new()
    self.normal = Attribute("assets/fight/player-a/body-upper.png", 45, 150)
    self.lose   = Attribute("assets/fight/player-a/body-upper.png", 45, 172)
end

Shoulder_Right_A = Object.extend(Object)
function Shoulder_Right_A:new()
    self.normal = Attribute("assets/fight/player-a/shoulder.png", 38, 146)
    self.lose   = Attribute("assets/fight/player-a/shoulder.png", 38, 166)
end

Shoulder_Left_A = Object.extend(Object)
function Shoulder_Left_A:new()
    self.normal = Attribute("assets/fight/player-a/shoulder.png", 86, 153)
    self.lose   = Attribute("assets/fight/player-a/shoulder.png", 86, 173)
end


Boxer_A = Object.extend(Object)
function Boxer_A:new()
    self.attack         = Attack_A()
    self.tongue         = Tongue_A()
    self.head           = Head_A()
    self.hand_right     = Hand_Right_A()
    self.hand_left      = Hand_Left_A()
    self.arm_right      = Arm_Right_A()
    self.arm_left       = Arm_Left_A()
    self.body_upper     = Body_Upper_A()
    self.body_lower     = Attribute("assets/fight/player-a/body-lower.png",     38, 202)
    self.shoulder_right = Shoulder_Right_A()
    self.shoulder_left  = Shoulder_Left_A()
    self.backbone_upper = Attribute("assets/fight/player-a/backbone-upper.png", 59, 188)
    self.backbone_lower = Attribute("assets/fight/player-a/backbone-lower.png", 59, 196)
    self.leg_right      = Attribute("assets/fight/player-a/leg-right.png",      82, 208)
    self.leg_left       = Attribute("assets/fight/player-a/leg-left.png",       22, 211)
end

function Boxer_A:print(strfoo)
    love.graphics.print(strfoo)
end

function Boxer_A:draw(current)
    local attack         = self.attack[current.attack]
    local tongue         = self.tongue[current.tongue]
    local head           = self.head[current.head]
    local hand_right     = self.hand_right[current.hand_right]
    local hand_left      = self.hand_left[current.hand_left]
    local body_upper     = self.body_upper[current.body_upper]
    local body_lower     = self.body_lower
    local shoulder_right = self.shoulder_right[current.shoulder_right]
    local shoulder_left  = self.shoulder_left[current.shoulder_left]
    local backbone_upper = self.backbone_upper
    local backbone_lower = self.backbone_lower
    local leg_right      = self.leg_right
    local leg_left       = self.leg_left
    local arm_right      = self.arm_right[current.arm_right]
    local arm_left       = self.arm_left[current.arm_left]

    love.graphics.draw(attack.img,         attack.x,         attack.y        )
    love.graphics.draw(arm_left.img,       arm_left.x,       arm_left.y      )
    love.graphics.draw(shoulder_left.img,  shoulder_left.x,  shoulder_left.y )
    love.graphics.draw(head.img,           head.x,           head.y          )
    love.graphics.draw(leg_right.img,      leg_right.x,      leg_right.y     )
    love.graphics.draw(body_lower.img,     body_lower.x,     body_lower.y    )
    love.graphics.draw(backbone_lower.img, backbone_lower.x, backbone_lower.y)
    love.graphics.draw(backbone_upper.img, backbone_upper.x, backbone_upper.y)
    love.graphics.draw(body_upper.img,     body_upper.x,     body_upper.y    )
    love.graphics.draw(leg_left.img,       leg_left.x,       leg_left.y      )
    love.graphics.draw(shoulder_right.img, shoulder_right.x, shoulder_right.y)
    love.graphics.draw(hand_left.img,      hand_left.x,      hand_left.y     )


    if (current.arm_right == "straight") then
      love.graphics.draw(arm_right.img, arm_right.x, arm_right.y , 0, 2, 1)
    elseif (current.arm_right == "defend") then
      love.graphics.draw(arm_right.img, arm_right.x, arm_right.y, 0, 1.3, 1)
    else
      love.graphics.draw(arm_right.img, arm_right.x, arm_right.y)
    end
    love.graphics.draw(hand_right.img,     hand_right.x,     hand_right.y    )
    love.graphics.draw(tongue.img,         tongue.x,         tongue.y        )
end

Attack_B = Object.extend(Object)
function Attack_B:new()
    self.normal = Attribute("assets/fight/null.png", -42, -42)
    self.attack = Attribute("assets/fight/player-b/attack.png", 99, 100)
end

Tongue_B = Object.extend(Object)
function Tongue_B:new()
    self.normal = Attribute("assets/fight/null.png", -42, -42)
    self.lose   = Attribute("assets/fight/player-b/tongue.png", 226, 163)
end

Head_B= Object.extend(Object)
function Head_B:new()
    self.ready  = Attribute("assets/fight/player-b/head-ready.png",  186, 78)
    self.hitted = Attribute("assets/fight/player-b/head-hitted.png", 186, 78)
    self.win    = Attribute("assets/fight/player-b/head-win.png",    186, 78)
    self.lose   = Attribute("assets/fight/player-b/head-lose.png",   190, 83)
end

Hand_Right_B= Object.extend(Object)
function Hand_Right_B:new()
    self.ready  = Attribute("assets/fight/player-b/hand-right-ready.png",  168, 152)
    self.attack = Attribute("assets/fight/player-b/hand-right-attack.png", 111, 131)
    self.defend = Attribute("assets/fight/player-b/hand-right-defend.png", 179, 117)
    self.win    = Attribute("assets/fight/player-b/hand-right-win.png",    179, 167)
    self.lose   = Attribute("assets/fight/player-b/hand-right-lose.png",   168, 166)
end

Hand_Left_B= Object.extend(Object)
function Hand_Left_B:new()
    self.ready  = Attribute("assets/fight/player-b/hand-left-ready.png",  256, 178)
    self.attack = Attribute("assets/fight/player-b/hand-left-attack.png", 110, 126)
    self.defend = Attribute("assets/fight/player-b/hand-left-defend.png", 194, 137)
    self.win    = Attribute("assets/fight/player-b/hand-left-win.png",    258, 167)
    self.lose   = Attribute("assets/fight/player-b/hand-left-lose.png",   288, 166)
end

Arm_Right_B= Object.extend(Object)
function Arm_Right_B:new()
    self.straight = Attribute("assets/fight/player-b/arm-straight.png",  142, 155)
    self.bent     = Attribute("assets/fight/player-b/arm-right-bent.png", 189, 161)
    self.lose     = Attribute("assets/fight/player-b/arm-right-bent.png", 189, 176)
    self.defend   = self.bent
end

Arm_Left_B= Object.extend(Object)
function Arm_Left_B:new()
    self.straight = Attribute("assets/fight/player-b/arm-straight.png",  112, 150)
    self.bent     = Attribute("assets/fight/player-b/arm-left-bent.png", 268, 148)
    self.lose     = Attribute("assets/fight/player-b/arm-lose.png", 262, 174)
    self.defend   = Attribute("assets/fight/player-b/arm-right-bent.png", 224, 158)
end

Body_Upper_B = Object.extend(Object)
function Body_Upper_B:new()
    self.normal = Attribute("assets/fight/player-b/body-upper.png", 221, 150)
    self.lose   = Attribute("assets/fight/player-b/body-upper.png", 221, 172)
end

Shoulder_Right_B = Object.extend(Object)
function Shoulder_Right_B:new()
    self.normal = Attribute("assets/fight/player-b/shoulder.png", 216, 153)
    self.lose   = Attribute("assets/fight/player-b/shoulder.png", 212, 173)
end

Shoulder_Left_B = Object.extend(Object)
function Shoulder_Left_B:new()
    self.normal = Attribute("assets/fight/player-b/shoulder.png", 262, 148)
    self.lose   = Attribute("assets/fight/player-b/shoulder.png", 260, 172)
end

Boxer_B = Object.extend(Object)
function Boxer_B:new()
    self.attack         = Attack_B()
    self.tongue         = Tongue_B()
    self.head           = Head_B()
    self.hand_right     = Hand_Right_B()
    self.hand_left      = Hand_Left_B()
    self.arm_right      = Arm_Right_B()
    self.arm_left       = Arm_Left_B()
    self.body_upper     = Body_Upper_B()
    self.body_lower     = Attribute("assets/fight/player-b/body-lower.png",     224, 202)
    self.shoulder_right = Shoulder_Right_B()
    self.shoulder_left  = Shoulder_Left_B()
    self.backbone_upper = Attribute("assets/fight/player-b/backbone-upper.png", 239, 188)
    self.backbone_lower = Attribute("assets/fight/player-b/backbone-lower.png", 241, 196)
    self.leg_right      = Attribute("assets/fight/player-b/leg-right.png",      204, 211)
    self.leg_left       = Attribute("assets/fight/player-b/leg-left.png",       268, 208)
end

function Boxer_B:draw(current)
    local attack         = self.attack[current.attack]
    local tongue         = self.tongue[current.tongue]
    local head           = self.head[current.head]
    local hand_right     = self.hand_right[current.hand_right]
    local hand_left      = self.hand_left[current.hand_left]
    local body_upper     = self.body_upper[current.body_upper]
    local body_lower     = self.body_lower
    local shoulder_right = self.shoulder_right[current.shoulder_right]
    local shoulder_left  = self.shoulder_left[current.shoulder_left]
    local backbone_upper = self.backbone_upper
    local backbone_lower = self.backbone_lower
    local leg_right      = self.leg_right
    local leg_left       = self.leg_left
    local arm_right      = self.arm_right[current.arm_right]
    local arm_left       = self.arm_left[current.arm_left]

    love.graphics.draw(attack.img,         attack.x,         attack.y        )
    love.graphics.draw(arm_right.img,      arm_right.x,      arm_right.y     )
    love.graphics.draw(shoulder_right.img, shoulder_right.x, shoulder_right.y)
    love.graphics.draw(head.img,           head.x,           head.y          )
    love.graphics.draw(leg_right.img,      leg_right.x,      leg_right.y     )
    love.graphics.draw(body_lower.img,     body_lower.x,     body_lower.y    )
    love.graphics.draw(backbone_lower.img, backbone_lower.x, backbone_lower.y)
    love.graphics.draw(backbone_upper.img, backbone_upper.x, backbone_upper.y)
    love.graphics.draw(body_upper.img,     body_upper.x,     body_upper.y    )
    love.graphics.draw(leg_left.img,       leg_left.x,       leg_left.y      )
    love.graphics.draw(shoulder_left.img,  shoulder_left.x,  shoulder_left.y )
    love.graphics.draw(hand_right.img,     hand_right.x,     hand_right.y    )
    if (current.arm_left == "straight") then
      love.graphics.draw(arm_left.img, arm_left.x, arm_left.y , 0, 2, 1)
    elseif (current.arm_left == "defend") then
      love.graphics.draw(arm_left.img, arm_left.x, arm_left.y, 0, 1.3, 1)
    else
      love.graphics.draw(arm_left.img, arm_left.x, arm_left.y)
    end
    love.graphics.draw(hand_left.img,      hand_left.x,      hand_left.y     )
    love.graphics.draw(tongue.img,         tongue.x,         tongue.y        )
end