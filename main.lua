local SCREEN_W = 320
local SCREEN_H = 180

local ROAD_X = 72
local ROAD_W = 176
local ROAD_LEFT = ROAD_X + 8
local ROAD_RIGHT = ROAD_X + ROAD_W - 8
local BASE_WORLD_SPEED = 62
local CITY_SPACING = 48
local CITY_PATTERN_COUNT = 8
local CITY_LOOP_H = CITY_SPACING * CITY_PATTERN_COUNT

local LANE_DASH_W = 4
local LANE_DASH_H = 18
local LANE_DASH_GAP = 34

local CAR_W = 18
local CAR_H = 28
local CAR_START_Y = SCREEN_H - CAR_H - 10
local CAR_SPEED = 118
local CAR_VERTICAL_SPEED = 82
local CAR_TOP = 104
local CAR_BOTTOM = SCREEN_H - CAR_H - 8

local MAX_LEVEL = 100
local LEVEL_DISTANCE = 720
local BOX_W = 16
local BOX_H = 16
local TRAFFIC_W = 18
local TRAFFIC_H = 28
local CRASH_PAD_X = 4
local CRASH_PAD_Y = 4
local COIN_SIZE = 7
local COIN_LEVEL_PERIOD = 3
local COIN_SPAWN_INTERVAL = 0.78
local COIN_SPAWN_CHANCE = 0.72
local BANANA_COST = 67
local BANANA_CLEAR_SECONDS = 1.15
local BANANA_FLASH_SECONDS = 0.42
local JAPANESE_TRICK_SECONDS = 60 * 60
local TRICK_CAR_CHANCE = 0.08
local PRESTIGE_CAR_CHANCE = 0.015
local PRESTIGE_CAR_REWARD = 3

local LANES = {
  ROAD_X + ROAD_W / 6,
  ROAD_X + ROAD_W / 2,
  ROAD_X + ROAD_W * 5 / 6,
}

local function clamp(value, low, high)
  if value < low then
    return low
  end

  if value > high then
    return high
  end

  return value
end

local function difficulty_for_level(level)
  if level <= 14 then
    return "easy"
  end

  if level <= 23 then
    return "hard"
  end

  return "impossible"
end

local function japanese_trick_active()
  return (State.japanese_timer or 0) > 0
end

local function coin_level(level)
  return level % COIN_LEVEL_PERIOD == 0
end

local function difficulty_label(level)
  return string.upper(difficulty_for_level(level))
end

local function world_speed_for_level(level)
  if level <= 14 then
    return BASE_WORLD_SPEED + level * 2
  end

  if level <= 23 then
    return BASE_WORLD_SPEED + 38 + (level - 14) * 4
  end

  return BASE_WORLD_SPEED + 82 + (level - 23) * 2.4
end

local function spawn_interval_for_level(level)
  if level <= 14 then
    return math.max(0.72, 1.28 - level * 0.035)
  end

  if level <= 23 then
    return math.max(0.42, 0.82 - (level - 14) * 0.045)
  end

  return math.max(0.22, 0.46 - (level - 23) * 0.004)
end

local function max_row_obstacles(level)
  if level <= 14 then
    return 1
  end

  if level <= 23 then
    return 2
  end

  return 3
end

local function new_level_state(level, prestige, keep_progress)
  local world_speed = world_speed_for_level(level)
  local coins = 0
  local japanese_timer = 0

  if keep_progress and State and State.coins then
    coins = State.coins
  end

  if keep_progress and State and State.japanese_timer then
    japanese_timer = State.japanese_timer
  end

  State = {
    mode = "playing",
    level = level,
    prestige = prestige,
    car_x = SCREEN_W / 2 - CAR_W / 2,
    car_y = CAR_START_Y,
    world_speed = world_speed,
    road_scroll = 0,
    city_scroll = 0,
    distance = 0,
    target_distance = LEVEL_DISTANCE + level * 18,
    obstacles = {},
    coins = coins,
    pickups = {},
    spawn_timer = 0.7,
    coin_spawn_timer = 0.55,
    finish_timer = 0,
    japanese_timer = japanese_timer,
    banana_clear_timer = 0,
    banana_flash_timer = 0,
    banana_message_timer = 0,
  }
end

local function reset_state()
  new_level_state(1, 0, false)
end

local function ensure_state()
  if not State or not State.mode or not State.world_speed or not State.obstacles then
    reset_state()
    return
  end

  if not State.japanese_timer then
    State.japanese_timer = 0
  end

  if not State.coins then
    State.coins = 0
  end

  if not State.pickups then
    State.pickups = {}
  end

  if not State.coin_spawn_timer then
    State.coin_spawn_timer = 0.55
  end

  if not State.banana_clear_timer then
    State.banana_clear_timer = 0
  end

  if not State.banana_flash_timer then
    State.banana_flash_timer = 0
  end

  if not State.banana_message_timer then
    State.banana_message_timer = 0
  end
end

local function restart_level()
  new_level_state(State.level, State.prestige, true)
end

local function start_next_level()
  local next_level = State.level + 1
  local prestige = State.prestige

  if next_level > MAX_LEVEL then
    prestige = prestige + 1
    next_level = 1
  end

  new_level_state(next_level, prestige, true)
end

local function building_color(index)
  local colors = {
    gfx.COLOR_DARK_PURPLE,
    gfx.COLOR_DARK_BLUE,
    gfx.COLOR_BROWN,
    gfx.COLOR_DARK_GREEN,
  }

  return colors[index % #colors + 1]
end

local function draw_building(x, y, w, h, color, seed)
  gfx.rect_fill(x, y, w, h, color)
  gfx.rect(x, y, w, h, gfx.COLOR_BLACK)

  local window_row = 0

  for wy = y + 7, y + h - 8, 11 do
    local window_col = 0

    for wx = x + 6, x + w - 8, 12 do
      local light_on = (window_col * 2 + window_row + seed) % 4 ~= 0
      local window_color = gfx.COLOR_DARK_GRAY

      if light_on then
        window_color = gfx.COLOR_YELLOW
      end

      gfx.rect_fill(wx, wy, 5, 4, window_color)
      window_col = window_col + 1
    end

    window_row = window_row + 1
  end
end

local function draw_city_side(left_side)
  local side_x = 0
  local curb_x = ROAD_X - 5
  local building_w = 56

  if not left_side then
    side_x = ROAD_X + ROAD_W + 5
    curb_x = ROAD_X + ROAD_W
    building_w = SCREEN_W - side_x
  end

  gfx.rect_fill(curb_x, 0, 5, SCREEN_H, gfx.COLOR_LIGHT_GRAY)

  local side_seed = 0

  if not left_side then
    side_seed = 3
  end

  for i = 0, CITY_PATTERN_COUNT - 1 do
    local seed = i + side_seed
    local h = 42 + (seed % 4) * 8
    local y = math.floor((i * CITY_SPACING + State.city_scroll) % CITY_LOOP_H
      - CITY_SPACING)
    local inset = (seed % 2) * 6
    local x = side_x + inset
    local w = building_w - inset

    if left_side then
      x = 6
      w = building_w - inset
    end

    if y < SCREEN_H and y + h > 0 then
      draw_building(x, y, w, h, building_color(seed), seed)
    end
  end
end

local function draw_road()
  gfx.rect_fill(ROAD_X, 0, ROAD_W, SCREEN_H, gfx.COLOR_DARK_GRAY)
  gfx.rect_fill(ROAD_X, 0, 3, SCREEN_H, gfx.COLOR_WHITE)
  gfx.rect_fill(ROAD_X + ROAD_W - 3, 0, 3, SCREEN_H, gfx.COLOR_WHITE)

  local lane_a = ROAD_X + ROAD_W / 3
  local lane_b = ROAD_X + ROAD_W * 2 / 3
  local dash_y = math.floor(-LANE_DASH_H + State.road_scroll)

  while dash_y < SCREEN_H do
    gfx.rect_fill(lane_a - LANE_DASH_W / 2, dash_y,
      LANE_DASH_W, LANE_DASH_H, gfx.COLOR_YELLOW)
    gfx.rect_fill(lane_b - LANE_DASH_W / 2, dash_y,
      LANE_DASH_W, LANE_DASH_H, gfx.COLOR_YELLOW)
    dash_y = dash_y + LANE_DASH_GAP
  end
end

local function draw_player_car()
  local x = math.floor(State.car_x)
  local y = math.floor(State.car_y)

  gfx.rect_fill(x + 3, y + 1, CAR_W - 6, CAR_H - 2, gfx.COLOR_BLUE)
  gfx.rect_fill(x + 1, y + 7, CAR_W - 2, CAR_H - 12, gfx.COLOR_BLUE)
  gfx.rect(x + 3, y + 1, CAR_W - 6, CAR_H - 2, gfx.COLOR_DARK_BLUE)
  gfx.rect_fill(x + 5, y + 5, CAR_W - 10, 6, gfx.COLOR_INDIGO)
  gfx.rect_fill(x + 5, y + 17, CAR_W - 10, 4, gfx.COLOR_DARK_BLUE)
  gfx.rect_fill(x, y + 8, 3, 7, gfx.COLOR_BLACK)
  gfx.rect_fill(x + CAR_W - 3, y + 8, 3, 7, gfx.COLOR_BLACK)
  gfx.rect_fill(x, y + 19, 3, 7, gfx.COLOR_BLACK)
  gfx.rect_fill(x + CAR_W - 3, y + 19, 3, 7, gfx.COLOR_BLACK)
  gfx.rect_fill(x + 4, y + 1, 3, 2, gfx.COLOR_TRUE_WHITE)
  gfx.rect_fill(x + CAR_W - 7, y + 1, 3, 2, gfx.COLOR_TRUE_WHITE)
end

local function draw_traffic_car(obstacle)
  local x = math.floor(obstacle.x)
  local y = math.floor(obstacle.y)
  local color = gfx.COLOR_RED

  if obstacle.kind == "trick_car" then
    color = gfx.COLOR_PINK
  elseif obstacle.kind == "prestige_car" then
    color = gfx.COLOR_RED
  elseif obstacle.variant == 1 then
    color = gfx.COLOR_GREEN
  elseif obstacle.variant == 2 then
    color = gfx.COLOR_ORANGE
  end

  gfx.rect_fill(x + 3, y + 1, TRAFFIC_W - 6, TRAFFIC_H - 2, color)
  gfx.rect_fill(x + 1, y + 8, TRAFFIC_W - 2, TRAFFIC_H - 13, color)
  gfx.rect(x + 3, y + 1, TRAFFIC_W - 6, TRAFFIC_H - 2, gfx.COLOR_BLACK)
  gfx.rect_fill(x + 5, y + 5, TRAFFIC_W - 10, 5, gfx.COLOR_LIGHT_GRAY)
  gfx.rect_fill(x + 5, y + 18, TRAFFIC_W - 10, 4, gfx.COLOR_DARK_GRAY)
  gfx.rect_fill(x, y + 8, 3, 7, gfx.COLOR_BLACK)
  gfx.rect_fill(x + TRAFFIC_W - 3, y + 8, 3, 7, gfx.COLOR_BLACK)
  gfx.rect_fill(x, y + 19, 3, 7, gfx.COLOR_BLACK)
  gfx.rect_fill(x + TRAFFIC_W - 3, y + 19, 3, 7, gfx.COLOR_BLACK)

  if obstacle.kind == "trick_car" then
    gfx.rect_fill(x + 7, y + 12, 4, 4, gfx.COLOR_YELLOW)
    gfx.rect(x + 6, y + 11, 6, 6, gfx.COLOR_INDIGO)
  elseif obstacle.kind == "prestige_car" then
    gfx.rect(x - 1, y, TRAFFIC_W + 2, TRAFFIC_H, gfx.COLOR_PINK)
    gfx.rect_fill(x + 5, y + 12, 8, 3, gfx.COLOR_TRUE_WHITE)
  end
end

local function draw_box(obstacle)
  local x = math.floor(obstacle.x)
  local y = math.floor(obstacle.y)

  gfx.rect_fill(x, y, BOX_W, BOX_H, gfx.COLOR_BROWN)
  gfx.rect(x, y, BOX_W, BOX_H, gfx.COLOR_BLACK)
  gfx.line(x + 3, y + 3, x + BOX_W - 4, y + BOX_H - 4, gfx.COLOR_ORANGE)
  gfx.line(x + BOX_W - 4, y + 3, x + 3, y + BOX_H - 4, gfx.COLOR_ORANGE)
end

local function draw_coin(coin)
  local x = math.floor(coin.x)
  local y = math.floor(coin.y)
  local center_x = x + COIN_SIZE / 2
  local center_y = y + COIN_SIZE / 2

  gfx.circ_fill(center_x, center_y, COIN_SIZE / 2, gfx.COLOR_YELLOW)
  gfx.circ(center_x, center_y, COIN_SIZE / 2, gfx.COLOR_ORANGE)
  gfx.rect_fill(x + 3, y + 2, 1, COIN_SIZE - 3, gfx.COLOR_PEACH)
end

local function draw_obstacles()
  for _, obstacle in ipairs(State.obstacles) do
    if obstacle.kind == "box" then
      draw_box(obstacle)
    else
      draw_traffic_car(obstacle)
    end
  end
end

local function draw_pickups()
  for _, pickup in ipairs(State.pickups) do
    if pickup.kind == "coin" then
      draw_coin(pickup)
    end
  end
end

local function text_center(text, y, color)
  local text_w = usagi.measure_text(text)
  gfx.text(text, SCREEN_W / 2 - text_w / 2, y, color)
end

local function draw_hud()
  local level_text = "LEVEL " .. State.level .. "/" .. MAX_LEVEL
  local prestige_text = "PRESTIGE x" .. State.prestige
  local tier_text = difficulty_label(State.level)
  local progress_w = 88
  local progress = clamp(State.distance / State.target_distance, 0, 1)

  gfx.rect_fill(4, 4, 140, 24, gfx.COLOR_BLACK)
  gfx.text(level_text, 8, 7, gfx.COLOR_TRUE_WHITE)
  gfx.text(tier_text, 84, 7, gfx.COLOR_YELLOW)
  gfx.rect(8, 18, progress_w, 5, gfx.COLOR_WHITE)
  gfx.rect_fill(9, 19, math.floor((progress_w - 2) * progress), 3,
    gfx.COLOR_GREEN)

  gfx.rect_fill(SCREEN_W - 86, 4, 82, 15, gfx.COLOR_BLACK)
  gfx.text(prestige_text, SCREEN_W - 82, 7, gfx.COLOR_TRUE_WHITE)

  gfx.rect_fill(4, SCREEN_H - 20, 130, 16, gfx.COLOR_BLACK)
  gfx.text("COINS " .. State.coins, 8, SCREEN_H - 17, gfx.COLOR_YELLOW)

  local banana_color = gfx.COLOR_LIGHT_GRAY

  if State.coins >= BANANA_COST then
    banana_color = gfx.COLOR_YELLOW
  end

  gfx.rect_fill(SCREEN_W - 120, SCREEN_H - 20, 116, 16, gfx.COLOR_BLACK)
  gfx.text("BTN2 BANANA " .. BANANA_COST, SCREEN_W - 116, SCREEN_H - 17,
    banana_color)

  if coin_level(State.level) then
    gfx.rect_fill(4, 32, 92, 12, gfx.COLOR_BLACK)
    gfx.text("COINS ON ROAD", 8, 34, gfx.COLOR_YELLOW)
  end

  if State.banana_message_timer > 0 then
    text_center("BANANA!", 62, gfx.COLOR_YELLOW)
  end

  if japanese_trick_active() then
    local minutes_left = math.ceil(State.japanese_timer / 60)
    gfx.rect_fill(4, 46, 70, 12, gfx.COLOR_BLACK)
    gfx.text("TRICK " .. minutes_left .. " MIN", 8, 48, gfx.COLOR_PINK)
  end
end

local function draw_overlay()
  if State.mode == "playing" then
    return
  end

  gfx.rect_fill(48, 54, 224, 72, gfx.COLOR_BLACK)
  gfx.rect(48, 54, 224, 72, gfx.COLOR_WHITE)

  if State.mode == "game_over" then
    text_center("CRASH!", 64, gfx.COLOR_RED)
    text_center("GAME OVER - LEVEL " .. State.level, 82,
      gfx.COLOR_TRUE_WHITE)
    text_center("PRESS BTN1 TO RESTART", 104, gfx.COLOR_YELLOW)
  elseif State.mode == "level_complete" then
    text_center("LEVEL " .. State.level .. " COMPLETE", 68,
      gfx.COLOR_GREEN)

    if State.level == MAX_LEVEL then
      text_center("PRESTIGE x" .. (State.prestige + 1), 86,
        gfx.COLOR_YELLOW)
      text_center("BTN1 STARTS LEVEL 1", 104, gfx.COLOR_TRUE_WHITE)
    else
      text_center("PRESS BTN1 FOR LEVEL " .. (State.level + 1), 94,
        gfx.COLOR_YELLOW)
    end
  end
end

local function rects_overlap(a_x, a_y, a_w, a_h, b_x, b_y, b_w, b_h)
  return a_x < b_x + b_w
    and a_x + a_w > b_x
    and a_y < b_y + b_h
    and a_y + a_h > b_y
end

local function player_hits(obstacle)
  return rects_overlap(
    State.car_x + CRASH_PAD_X,
    State.car_y + CRASH_PAD_Y,
    CAR_W - CRASH_PAD_X * 2,
    CAR_H - CRASH_PAD_Y * 2,
    obstacle.x + obstacle.pad_x,
    obstacle.y + obstacle.pad_y,
    obstacle.w - obstacle.pad_x * 2,
    obstacle.h - obstacle.pad_y * 2
  )
end

local function make_obstacle(lane_index)
  local kind = "car"
  local w = TRAFFIC_W
  local h = TRAFFIC_H
  local pad_x = 3
  local pad_y = 4

  local special_roll = math.random()

  if special_roll < PRESTIGE_CAR_CHANCE then
    kind = "prestige_car"
  elseif special_roll < PRESTIGE_CAR_CHANCE + TRICK_CAR_CHANCE then
    kind = "trick_car"
  elseif math.random() < 0.42 then
    kind = "box"
    w = BOX_W
    h = BOX_H
    pad_x = 2
    pad_y = 2
  end

  return {
    kind = kind,
    x = LANES[lane_index] - w / 2,
    y = -h - math.random(0, 28),
    w = w,
    h = h,
    pad_x = pad_x,
    pad_y = pad_y,
    speed = State.world_speed + math.random(8, 30),
    variant = math.random(0, 2),
  }
end

local function spawn_obstacle_row()
  local lanes = { 1, 2, 3 }
  local count = math.random(1, max_row_obstacles(State.level))

  if State.level <= 14 then
    count = 1
  elseif State.level <= 23 and math.random() < 0.28 then
    count = 1
  elseif State.level >= 24 and math.random() < 0.22 then
    count = 3
  end

  for i = #lanes, 2, -1 do
    local swap_i = math.random(1, i)
    lanes[i], lanes[swap_i] = lanes[swap_i], lanes[i]
  end

  for i = 1, count do
    table.insert(State.obstacles, make_obstacle(lanes[i]))
  end
end

local function make_coin_pickup(lane_index)
  return {
    kind = "coin",
    x = LANES[lane_index] - COIN_SIZE / 2,
    y = -COIN_SIZE - math.random(0, 18),
    w = COIN_SIZE,
    h = COIN_SIZE,
    speed = State.world_speed,
  }
end

local function spawn_coin_pickup()
  if not coin_level(State.level) or math.random() > COIN_SPAWN_CHANCE then
    return
  end

  table.insert(State.pickups, make_coin_pickup(math.random(1, #LANES)))
end

local function update_scrolling(dt)
  State.road_scroll = (State.road_scroll + State.world_speed * dt)
    % LANE_DASH_GAP
  State.city_scroll = (State.city_scroll + State.world_speed * dt)
    % CITY_LOOP_H
end

local function update_player(dt)
  local move_x = 0
  local move_y = 0

  if input.held(input.LEFT) then
    move_x = move_x - 1
  end

  if input.held(input.RIGHT) then
    move_x = move_x + 1
  end

  if input.held(input.UP) then
    move_y = move_y - 1
  end

  if input.held(input.DOWN) then
    move_y = move_y + 1
  end

  State.car_x = clamp(State.car_x + move_x * CAR_SPEED * dt,
    ROAD_LEFT, ROAD_RIGHT - CAR_W)
  State.car_y = clamp(State.car_y + move_y * CAR_VERTICAL_SPEED * dt,
    CAR_TOP, CAR_BOTTOM)
end

local function update_banana_item(dt)
  if State.banana_clear_timer > 0 then
    State.banana_clear_timer = math.max(0, State.banana_clear_timer - dt)
  end

  if State.banana_flash_timer > 0 then
    State.banana_flash_timer = math.max(0, State.banana_flash_timer - dt)
  end

  if State.banana_message_timer > 0 then
    State.banana_message_timer = math.max(0, State.banana_message_timer - dt)
  end

  if input.pressed(input.BTN2) and State.coins >= BANANA_COST then
    State.coins = State.coins - BANANA_COST
    State.obstacles = {}
    State.banana_clear_timer = BANANA_CLEAR_SECONDS
    State.banana_flash_timer = BANANA_FLASH_SECONDS
    State.banana_message_timer = BANANA_FLASH_SECONDS
    effect.screen_shake(0.16, 2)
    effect.flash(0.14, gfx.COLOR_YELLOW)
  end
end

local function update_pickups(dt)
  State.coin_spawn_timer = State.coin_spawn_timer - dt

  if State.coin_spawn_timer <= 0 then
    spawn_coin_pickup()
    State.coin_spawn_timer = COIN_SPAWN_INTERVAL + math.random() * 0.2
  end

  for i = #State.pickups, 1, -1 do
    local pickup = State.pickups[i]
    pickup.y = pickup.y + pickup.speed * dt

    if pickup.kind == "coin" and rects_overlap(
      State.car_x + 2,
      State.car_y + 2,
      CAR_W - 4,
      CAR_H - 4,
      pickup.x,
      pickup.y,
      pickup.w,
      pickup.h
    ) then
      State.coins = State.coins + 1
      table.remove(State.pickups, i)
    elseif pickup.y > SCREEN_H + 8 then
      table.remove(State.pickups, i)
    end
  end
end

local function update_obstacles(dt)
  if State.banana_clear_timer > 0 then
    return
  end

  State.spawn_timer = State.spawn_timer - dt

  if State.spawn_timer <= 0 then
    spawn_obstacle_row()
    State.spawn_timer = spawn_interval_for_level(State.level)
      + math.random() * 0.18
  end

  for i = #State.obstacles, 1, -1 do
    local obstacle = State.obstacles[i]
    obstacle.y = obstacle.y + obstacle.speed * dt

    if player_hits(obstacle) then
      if obstacle.kind == "trick_car" then
        State.japanese_timer = JAPANESE_TRICK_SECONDS
      elseif obstacle.kind == "prestige_car" then
        State.prestige = State.prestige + PRESTIGE_CAR_REWARD
      end

      State.mode = "game_over"
    elseif obstacle.y > SCREEN_H + 8 then
      table.remove(State.obstacles, i)
    end
  end
end

local function update_level_progress(dt)
  State.distance = State.distance + State.world_speed * dt

  if State.distance >= State.target_distance then
    State.distance = State.target_distance
    State.mode = "level_complete"
  end
end

local function update_japanese_trick(dt)
  if (State.japanese_timer or 0) <= 0 then
    return
  end

  State.japanese_timer = math.max(0, State.japanese_timer - dt)
end

function _config()
  return {
    name = "Hiroikku Resu",
    game_id = "com.usagiengine.hiroikku_resu",
  }
end

function _init()
  reset_state()
end

function _update(dt)
  ensure_state()
  update_japanese_trick(dt)

  if State.mode == "game_over" then
    if input.pressed(input.BTN1) then
      restart_level()
    end

    return
  end

  if State.mode == "level_complete" then
    if input.pressed(input.BTN1) then
      start_next_level()
    end

    return
  end

  update_scrolling(dt)
  update_player(dt)
  update_banana_item(dt)
  update_pickups(dt)
  update_obstacles(dt)

  if State.mode == "playing" then
    update_level_progress(dt)
  end
end

function _draw(_dt)
  ensure_state()

  gfx.clear(gfx.COLOR_DARK_BLUE)
  draw_city_side(true)
  draw_city_side(false)
  draw_road()
  draw_pickups()
  draw_obstacles()
  draw_player_car()
  draw_hud()
  draw_overlay()
end
