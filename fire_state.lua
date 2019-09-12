-- Normal State
state_ready = {
    attack     = "normal",
    tongue     = "normal",
    head       = "ready",
    hand_right = "ready",
    hand_left  = "ready",
    arm_right  = "bent",
    arm_left   = "bent",
    body_upper = "normal",
    shoulder_right = "normal",
    shoulder_left  = "normal"
}

state_win = {
    attack     = "normal",
    tongue     = "normal",
    head       = "win",
    hand_right = "win",
    hand_left  = "win",
    arm_right  = "bent",
    arm_left   = "bent",
    body_upper = "normal",
    shoulder_right = "normal",
    shoulder_left  = "normal"
}

state_lose = {
    attack     = "normal",
    tongue     = "lose",
    head       = "lose",
    hand_right = "lose",
    hand_left  = "lose",
    arm_right  = "lose",
    arm_left   = "lose",
    body_upper = "lose",
    shoulder_right = "lose",
    shoulder_left  = "lose"
}

-- Attack
state_attack_left = {
    attack         = "attack",
    tongue         = "normal",
    head           = "ready",
    hand_right     = "ready",
    hand_left      = "attack",
    arm_right      = "bent",
    arm_left       = "straight",
    body_upper     = "normal",
    shoulder_right = "normal",
    shoulder_left  = "normal"
}

state_attack_right = {
    attack         = "attack",
    tongue         = "normal",
    head           = "ready",
    hand_right     = "attack",
    hand_left      = "ready",
    arm_right      = "straight",
    arm_left       = "bent",
    body_upper     = "normal",
    shoulder_right = "normal",
    shoulder_left  = "normal"
}

-- Defend
state_defend_right = {
    attack         = "normal",
    tongue         = "normal",
    head           = "ready",
    hand_right     = "defend",
    hand_left      = "ready",
    arm_right      = "defend",
    arm_left       = "bent",
    body_upper     = "normal",
    shoulder_right = "normal",
    shoulder_left  = "normal"
}

state_defend_left = {
    attack         = "normal",
    tongue         = "normal",
    head           = "ready",
    hand_right     = "ready",
    hand_left      = "defend",
    arm_right      = "bent",
    arm_left       = "defend",
    body_upper     = "normal",
    shoulder_right = "normal",
    shoulder_left  = "normal"
}

-- Hitted
state_hitted = {
    attack         = "normal",
    tongue         = "normal",
    head           = "hitted",
    hand_right     = "ready",
    hand_left      = "ready",
    arm_right      = "bent",
    arm_left       = "bent",
    body_upper     = "normal",
    shoulder_right = "normal",
    shoulder_left  = "normal"
}