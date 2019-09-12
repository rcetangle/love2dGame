function fight_load()
    Keys   = require "fire_keys"
    Object = require "fire_classic"
    Timer = require "fire_timer"
    require "fire_player"
    require "fire_state"

    hp_table = {0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0}

    -- Initial State
    game_is_over = false
    is_player_attack = true

    -- "Ready" "Fight" "Player"
    game_state   = "Ready"

    round_max     = 5
    round_counter = 0

    current_hp_a = 11
    current_hp_b = 11

    player_b_is_attacking = false
    player_b_is_rounding  = false

    -- "None" "Left" "Right"
    player_a_defend_dir = "None"

    -- Timer
    player_b_round_timer   = Timer.new()
    player_a_attack_timer  = Timer.new()
    player_b_attack_timer  = Timer.new()
    player_all_ready_timer = Timer.new()
    ready_timer            = Timer.new()
    fight_timer            = Timer.new()

    boxer_a   = Boxer_A()
    current_a = state_ready

    boxer_b   = Boxer_B()
    current_b = state_ready

    background = love.graphics.newImage("assets/fight/background.png")
    wall2      = love.graphics.newImage("assets/fight/wall-2.png")
    hp_a       = love.graphics.newImage("assets/fight/hp.png")
    hp_b       = love.graphics.newImage("assets/fight/hp.png")
    hp_frame   = love.graphics.newImage("assets/fight/hp-frame.png")
    circle     = love.graphics.newImage("assets/fight/circle.png")
    circle_a   = love.graphics.newImage("assets/fight/player-a.png")
    circle_b   = love.graphics.newImage("assets/fight/player-b.png")
    fight_logo = love.graphics.newImage("assets/fight/fight.png")
    ready_logo = love.graphics.newImage("assets/fight/ready.png")

    ready_logo_width  = ready_logo:getWidth()
    ready_logo_height = ready_logo:getHeight()
    fight_logo_width  = fight_logo:getWidth()
    fight_logo_height = fight_logo:getHeight()

    ready_logo_x_scale = 1.5
    ready_logo_y_scale = 1.5
    fight_logo_x_scale = 1.5
    fight_logo_y_scale = 1.5
end

function fight_draw()
  --love.graphics.print(player_a_defend_dir)
  --if player_b_is_attacking then
  --  love.graphics.print("player_b_is_attacking", 0, 20)
  --else
  --  love.graphics.print("None", 0, 20)
  --end
  --if game_is_over then
  --  love.graphics.print("game_is_over")
  --end
  love.graphics.print(round_counter)
  love.graphics.print(game_state, 0, 20)
  --love.graphics.draw(background)
  --love.graphics.draw(wall2)
  love.graphics.draw(hp_frame, 33,55)
  love.graphics.draw(circle, 140,45)
  love.graphics.draw(hp_a,  36, 57, 0, hp_table[current_hp_a], 1)
  love.graphics.draw(hp_b, 194, 57, 0, hp_table[current_hp_b], 1)
  if (is_player_attack) then
    love.graphics.draw(circle_a, 145,50)
  else
    love.graphics.draw(circle_b, 145,50)
  end

  if (is_player_attack) then
    boxer_b:draw(current_b)
    boxer_a:draw(current_a)
  else 
    boxer_a:draw(current_a)
    boxer_b:draw(current_b)
  end

  if not game_is_over then
    if (game_state == "Ready") then
      love.graphics.draw(ready_logo, 155, 120, 0, ready_logo_x_scale, ready_logo_y_scale, ready_logo_width/2, ready_logo_height/2)
    end
    if (game_state == "Fight") then
      love.graphics.draw(fight_logo, 155, 120, 0, fight_logo_x_scale, fight_logo_y_scale, fight_logo_width/2, fight_logo_height/2)
    end
  end
end

function setPlayerA(defend_dir)
  if not player_b_is_attacking then
  --if player_b_is_rounding and not player_b_is_attacking then
    player_a_defend_dir = defend_dir
  end
end

function fight_keypressed(key)
  if not game_is_over and game_state == "Player" then
    if key == Keys.DPad_left then
      if is_player_attack then
        player_a_attack("Left")
      else
        setPlayerA("Left")
      end
    end

    if key == Keys.DPad_right then
      if is_player_attack then
        player_a_attack("Right")
      else
        setPlayerA("Right")
      end
    end
  end

  if key == Keys.Start then
    game_is_over = false
    is_player_attack = true

    game_state = "Ready"

    round_max     = 5
    round_counter = 0

    current_hp_a = 11
    current_hp_b = 11

    player_b_is_attacking = false
    player_b_is_rounding  = false

    -- "None" "Left" "Right"
    player_a_defend_dir = "None"

    current_a = state_ready
    current_b = state_ready
  end
end

function player_b_hp_update()
    if (current_hp_b > 1) then
    current_hp_b = current_hp_b - 1
    end
    if (current_hp_b == 1) then
      current_b = state_lose
      current_a = state_win
    else
      current_b = state_hitted
    end
end

function player_a_hp_update()
    if (current_hp_a > 1) then
      current_hp_a = current_hp_a - 1
    end
    if (current_hp_a == 1) then
      current_a = state_lose
      current_b = state_win
    else
      current_a = state_hitted
    end
end

function player_a_attack(attack_dir) 
  if (current_hp_b > 1) then
    player_a_attack_timer:add(0.2, function() 
      if attack_dir == "Left" then
        current_a = state_attack_left
        player_b_defend(state_defend_right) 
      elseif attack_dir == "Right" then
        current_a = state_attack_right
        player_b_defend(state_defend_left) 
      end
    end)
  end
  player_all_ready_timer:add(0.5, function()
    if (current_hp_b ~= 1) then
      round_counter = round_counter + 1
      current_a = state_ready
      current_b = state_ready
    else
      game_is_over = true
    end
  end)
end

function player_b_attack(attack_dir)
  player_b_is_attacking = true
  if (love.math.random(2) == 1) then
    current_b = state_attack_right
    player_a_defend("Left")
  else
    current_b = state_attack_left
    player_a_defend("Right")
  end
  player_a_defend_dir = "None"
end

function player_a_defend(defend_dir) 
  if (player_a_defend_dir == defend_dir) then
    if (defend_dir == "Right") then
      current_a = state_defend_right
    else
      current_a = state_defend_left
    end
  else
    player_a_hp_update()
  end
end

function player_b_defend(defend_dir) 
  if (love.math.random(2) == 1) then
    current_b = defend_dir
  else
    player_b_hp_update()
  end
end

function player_b_round()
  if (not player_b_is_attacking and current_hp_b ~= 1 and game_state == "Player") then
    player_b_attack_timer:add(0.4, function() player_b_attack() end)

    player_all_ready_timer:add(0.8, function()
      if (current_hp_b ~= 1) then
        current_a = state_ready
        current_b = state_ready
        player_b_is_attacking = false
        round_counter = round_counter + 1
      else
        game_is_over = true
      end

    end)
  end

  player_b_is_rounding = false
end

function fight_update(dt)
  if not game_is_over then
    if current_hp_a == 1 or current_hp_b == 1 then
        game_is_over = true
    end
    player_a_attack_timer:update(dt)
    player_b_attack_timer:update(dt)
    player_b_round_timer:update(dt)
    player_all_ready_timer:update(dt)
    ready_timer:update(dt)
    fight_timer:update(dt)

    if game_state == "Ready" then
      ready_timer:add(1, function()
        game_state = "Fight"
      end)
    end
    if game_state == "Fight" then
      ready_timer:add(1, function() game_state = "Player" end)
    end

    if round_counter == round_max then
      is_player_attack = not is_player_attack
      round_counter    = 0
      game_state       = "Ready"
    end

    if (not is_player_attack and not player_b_is_rounding and game_state == "Player") then
      player_b_is_rounding = true
      player_b_round_timer:add(1, function () player_b_round() end)
    end
  end
end





local FireScene = class("FireScene", require(".earth_scene"))
function FireScene:load()
  fight_load()
end

function FireScene:draw()
  fight_draw()
end

function FireScene:update(dt)
  fight_update(dt)
end

function FireScene:keypressed(key)
  if key == "escape" then
    self:stopScene()
    return
  end
  fight_keypressed(key)
end
return FireScene