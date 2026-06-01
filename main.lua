local SCREEN_W = 320
local SCREEN_H = 180

local ROAD_X = 72
local ROAD_W = 176
local ROAD_LEFT = ROAD_X + 8
local ROAD_RIGHT = ROAD_X + ROAD_W - 8
local WORLD_SPEED = 62
local CITY_SPACING = 48
local CITY_PATTERN_COUNT = 8
local CITY_LOOP_H = CITY_SPACING * CITY_PATTERN_COUNT

local LANE_DASH_W = 4
local LANE_DASH_H = 18
local LANE_DASH_GAP = 34

local CAR_W = 18
local CAR_H = 28
local CAR_Y = SCREEN_H - CAR_H - 10
local CAR_SPEED = 110

local function clamp(value, low, high)
  if value < low then
    return low
  end

  if value > high then
    return high
  end

  return value
end

local function reset_state()
  State = {
    car_x = SCREEN_W / 2 - CAR_W / 2,
    road_scroll = 0,
    city_scroll = 0,
  }
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

local function draw_car()
  local x = math.floor(State.car_x)
  local y = CAR_Y

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
  State.road_scroll = (State.road_scroll + WORLD_SPEED * dt) % LANE_DASH_GAP
  State.city_scroll = (State.city_scroll + WORLD_SPEED * dt) % CITY_LOOP_H

  local move = 0

  if input.held(input.LEFT) then
    move = move - 1
  end

  if input.held(input.RIGHT) then
    move = move + 1
  end

  State.car_x = clamp(State.car_x + move * CAR_SPEED * dt,
    ROAD_LEFT, ROAD_RIGHT - CAR_W)
end

function _draw(_dt)
  gfx.clear(gfx.COLOR_DARK_BLUE)
  draw_city_side(true)
  draw_city_side(false)
  draw_road()
  draw_car()
end
