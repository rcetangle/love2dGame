function fight_load(callback)
    Keys   = require "fire_keys"
    Object = require "fire_classic"
    Timer = require "fire_timer"
    require "fire_player"
    require "fire_state"

    -- Initial State
    game_is_over     = false
    is_player_attack = true
    game_end_callback = callback

    -- "Load" "Ready" "Fight" "Player"
    game_state    = "Load"

    round_max      = 5
    attack_counter = 0
    round_counter  = 0

    hp_max       = 20
    current_hp_a = hp_max
    current_hp_b = hp_max

    player_a_is_attacking = false
    player_b_is_attacking = false

    -- "None" "Left" "Right"
    player_a_defend_dir = "None"
    player_b_defend_dir = "None"

    -- Timer
    player_b_round_timer   = Timer.new()
    player_a_attack_timer  = Timer.new()
    player_b_attack_timer  = Timer.new()
    player_all_ready_timer = Timer.new()
    ready_timer            = Timer.new()
    fight_timer            = Timer.new()
    door_timer             = Timer.new()
    loading_timer          = Timer.new()

    boxer_a   = Boxer_A()
    current_a = state_ready

    boxer_b   = Boxer_B()
    current_b = state_ready

    clouds     = {}
    doors      = {}
    current_door = 1
    for i=1, 3 do
      clouds[i] = love.graphics.newImage("assets/fight/clouds/"..(i)..".png")
    end
    for i=1, 6 do
      doors[i] = love.graphics.newImage("assets/fight/door/"..(i-1)..".png")
    end
    background = love.graphics.newImage("assets/fight/background.png")
    cloud      = love.graphics.newImage("assets/fight/cloud.png")
    wall1      = love.graphics.newImage("assets/fight/wall-1.png")
    wall2      = love.graphics.newImage("assets/fight/wall-2.png")
    hp_a       = love.graphics.newImage("assets/fight/hp.png")
    hp_b       = love.graphics.newImage("assets/fight/hp.png")
    hp_frame   = love.graphics.newImage("assets/fight/hp-frame.png")
    circle     = love.graphics.newImage("assets/fight/circle.png")
    circle_a   = love.graphics.newImage("assets/fight/player-a.png")
    circle_b   = love.graphics.newImage("assets/fight/player-b.png")
    fight_logo = love.graphics.newImage("assets/fight/fight.png")
    ready_logo = love.graphics.newImage("assets/fight/ready.png")

    music_door   = love.audio.newSource("assets/fight/music/door.wav", "static")
    music_hitted = love.audio.newSource("assets/fight/music/hit.wav", "static")
    music_miss   = love.audio.newSource("assets/fight/music/miss.wav", "static")
    music_shift  = love.audio.newSource("assets/fight/music/shift_player.wav", "static")
    music_win    = love.audio.newSource("assets/fight/music/win.wav", "static")

    ready_logo_width  = ready_logo:getWidth()
    ready_logo_height = ready_logo:getHeight()
    fight_logo_width  = fight_logo:getWidth()
    fight_logo_height = fight_logo:getHeight()

    ready_logo_x_scale = 1.5
    ready_logo_y_scale = 1.5
    fight_logo_x_scale = 1.5
    fight_logo_y_scale = 1.5

    door_timer:addPeriodic(0.4, function() change_door() end)
    loading_timer:add(5, function() game_state = "Ready" end)
end

function fight_draw()
  --love.graphics.print("A: " .. current_hp_a)
  --love.graphics.print("B: " .. current_hp_b, 0, 10)
  --love.graphics.print(game_state, 0, 20)
  --love.graphics.print(round_counter, 0, 30)
  --love.graphics.print(attack_counter, 0, 40)
  love.graphics.draw(background)
  love.graphics.draw(cloud)
  love.graphics.draw(clouds[1], -9, 50)
  love.graphics.draw(clouds[2], 130, 0)
  love.graphics.draw(clouds[3], 280, -5)
  if game_state == "Load" then
    love.graphics.draw(wall2)
    love.graphics.draw(wall1)
    love.graphics.draw(doors[current_door], 128, 117)
    love.audio.play(music_door)
  else
    love.graphics.draw(wall2)
    love.graphics.draw(hp_frame, 33,55)
    love.graphics.draw(circle, 140,45)
    love.graphics.draw(hp_a,  36, 57, 0, current_hp_a/hp_max, 1)
    love.graphics.draw(hp_b, 194, 57, 0, current_hp_b/hp_max, 1)
    --love.graphics.draw(hp_a,  36, 57, 0, hp_table[current_hp_a], 1)
    --love.graphics.draw(hp_b, 194, 57, 0, hp_table[current_hp_b], 1)
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
end

function change_door()
  if current_door < 6 then
    current_door = current_door + 1
  end
end

function setPlayerA(defend_dir)
  if player_b_is_attacking then
    player_a_defend_dir = defend_dir
  end
end

function setPlayerB(defend_dir)
  if player_a_is_attacking then
    player_b_defend_dir = defend_dir
  end
end

function fight_keypressed(key)
  if not game_is_over and attack_counter < 5 and game_state == "Player" then
    -- Player A Control
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

    -- Player B Control
    if key == Keys.X then
      if not is_player_attack then
        player_b_attack("Left")
      else
        setPlayerB("Left")
      end
    end

    if key == Keys.B then
      if not is_player_attack then
        player_b_attack("Right")
      else
        setPlayerB("Right")
      end
    end
  end

  if key == Keys.Start then
    game_is_over     = false
    is_player_attack = true

    game_state = "Ready"

    round_max      = 5
    round_counter  = 0
    attack_counter = 0

    current_hp_a = hp_max
    current_hp_b = hp_max

    player_a_is_attacking = false
    player_b_is_attacking = false

    current_a = state_ready
    current_b = state_ready

    -- "None" "Left" "Right"
    player_a_defend_dir = "None"
    player_b_defend_dir = "None"
  end
end

function player_b_hp_update()
    if (current_hp_b > 0) then
      current_hp_b = current_hp_b - 1
    end
    if (current_hp_b == 0) then
      current_b = state_lose
      current_a = state_win
      love.audio.play(music_win)
    else
      love.audio.play(music_hitted)
      current_b = state_hitted
    end
end

function player_a_hp_update()
    if (current_hp_a > 0) then
      current_hp_a = current_hp_a - 1
    end
    if (current_hp_a == 0) then
      current_a = state_lose
      current_b = state_win
      love.audio.play(music_win)
    else
      love.audio.play(music_hitted)
      current_a = state_hitted
    end
end

function update_round_counter()
  if game_state == "Player" then
    round_counter = round_counter + 1
  end
end

function player_a_attack(attack_dir) 
  player_a_is_attacking = true
  attack_counter = attack_counter + 1
  if (current_hp_b > 0) then
    player_a_attack_timer:add(0.4, function() 
      if attack_dir == "Left" then
        current_a = state_attack_left
        player_b_defend("Right") 
      elseif attack_dir == "Right" then
        current_a = state_attack_right
        player_b_defend("Left") 
      end
    end)
  end

  player_all_ready_timer:add(0.7, function()
    player_a_is_attacking = false
    if (current_hp_b ~= 0) then
      update_round_counter()
      current_a = state_ready
      current_b = state_ready
      player_b_defend_dir = "None"
    end
  end)
end

function player_b_attack(attack_dir) 
  player_b_is_attacking = true
  attack_counter = attack_counter + 1
  if (current_hp_a > 0) then
    player_b_attack_timer:add(0.4, function() 
      if attack_dir == "Left" then
        current_b = state_attack_left
        player_a_defend("Right") 
      elseif attack_dir == "Right" then
        current_b = state_attack_right
        player_a_defend("Left") 
      end
    end)
  end

  player_all_ready_timer:add(0.7, function()
    player_b_is_attacking = false
    if (current_hp_a ~= 0) then
      update_round_counter()
      current_a = state_ready
      current_b = state_ready
      player_a_defend_dir = "None"
    end
  end)
end

function player_a_defend(defend_dir) 
  if (player_a_defend_dir == defend_dir) then
    love.audio.play(music_miss)
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
  if (player_b_defend_dir == defend_dir) then
    love.audio.play(music_miss)
    if (defend_dir == "Right") then
      current_b = state_defend_right
    else
      current_b = state_defend_left
    end
  else
    player_b_hp_update()
  end
end

function fight_update(dt)
  if not game_is_over then
    if current_hp_a == 0 or current_hp_b == 0 then
        game_is_over = true
        fight_game_end()
    end
    player_a_attack_timer:update(dt)
    player_b_attack_timer:update(dt)
    player_b_round_timer:update(dt)
    player_all_ready_timer:update(dt)
    ready_timer:update(dt)
    fight_timer:update(dt)
    door_timer:update(dt)
    loading_timer:update(dt)

    if game_state == "Ready" then
      ready_timer:add(1, function()
        game_state = "Fight"
      end)
    end
    if game_state == "Fight" then
      ready_timer:add(1, function() game_state = "Player" end)
    end

    if round_counter == round_max then
      love.audio.play(music_shift)
      is_player_attack = not is_player_attack
      round_counter    = 0
      attack_counter   = 0
      game_state       = "Ready"
    end
  end
end

function fight_game_end()
  love.audio.stop()
  eh_safeCallFunc(game_end_callback)
end

local FireScene = class("FireScene", require(".earth_scene"))
function FireScene:load()
  fight_load(self.callback)
end

function FireScene:draw()
  fight_draw()
end

function FireScene:update(dt)
  fight_update(dt)
end

function FireScene:keypressed(key)
  fight_keypressed(key)
end

function FireScene:keyreleased(key)
  if key == "escape" then
    self:stopScene()
    return
  end
end
return FireScene