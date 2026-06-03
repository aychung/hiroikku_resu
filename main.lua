local SCREEN_W = 320
local SCREEN_H = 180

local ROAD_X = 72
local ROAD_W = 176
local ROAD_LEFT = ROAD_X + 8
local ROAD_RIGHT = ROAD_X + ROAD_W - 8
local BASE_WORLD_SPEED = 62
local SPACE_STAR_COUNT = 54
local SPACE_PLANET_COUNT = 7
local SPACE_LOOP_H = 420

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
local CHILD_W = 10
local CHILD_H = 18
local CRASH_PAD_X = 4
local CRASH_PAD_Y = 4
local COIN_SIZE = 7
local COIN_LEVEL_PERIOD = 3
local COIN_SPAWN_INTERVAL = 0.78
local COIN_SPAWN_CHANCE = 0.72
local BANANA_COST = 67
local BANANA_CLEAR_SECONDS = 1.15
local BANANA_FLASH_SECONDS = 0.42
local GOLD_CAR_COST = 456
local PLASMA_PURCHASE_AMOUNT = 100
local UPGRADE_CAR_COUNT = 100
local UPGRADE_CAR_COST = 100
local ORANGE_CAR_CHANCE = 0.08
local PRESTIGE_CAR_CHANCE = 0.015
local PRESTIGE_CAR_REWARD = 3
local CHILD_CHANCE = 0.16
local GREEN_CAR_CHANCE = 0.12
local GREEN_CAR_LIMIT = 2
local OBBY_SPEED_BONUS = 34
local OBBY_SPAWN_MULTIPLIER = 0.78

local SETTINGS_CAR_TAB = 1
local SETTINGS_BACKGROUND_TAB = 2
local SETTINGS_MUSIC_TAB = 3
local SETTINGS_TAB_COUNT = 3

local BACKGROUNDS = {
  { id = "space", name = "SPACE", currency = "free", cost = 0 },
  { id = "void", name = "VOID", currency = "free", cost = 0 },
  { id = "cheering", name = "PEOPLE CHEERING", currency = "plasma", cost = 1345 },
  { id = "village", name = "VILLAGE", currency = "coins", cost = 20 },
}

local LANGUAGES = {
  {
    name = "日本語",
    level = "レベル ",
    prestige = "名声 x",
    speed = "速度 ",
    coins = "コイン ",
    plasma = "プラズマ ",
    banana = "BTN2 バナナ ",
    gold_owned = "金の車 所有",
    gold_buy = "BTN3 金車 ",
    buy_plasma = "BTN3 プラズマ",
    coins_on_road = "道路にコイン",
    banana_message = "バナナ!",
    crash = "クラッシュ!",
    game_over_level = "ゲームオーバー レベル ",
    restart = "BTN1で再開",
    complete_prefix = "レベル ",
    complete_suffix = " クリア",
    btn1_level_1 = "BTN1 レベル1",
    btn1_next_level = "BTN1 レベル ",
    gold_equipped = "金の車 装備中",
    gold_unlocked = "金の車 解除!",
    paid_money = "支払い: +",
    plasma_suffix = " プラズマ",
    start = "スタート - 4を押す",
    change_language = "何か押して言語変更",
    language_label = "言語: ",
    easy = "かんたん",
    hard = "むずかしい",
    impossible = "無理",
  },
  {
    name = "한국어",
    level = "레벨 ",
    prestige = "명성 x",
    speed = "속도 ",
    coins = "코인 ",
    plasma = "플라즈마 ",
    banana = "BTN2 바나나 ",
    gold_owned = "금 차 보유",
    gold_buy = "BTN3 금차 ",
    buy_plasma = "BTN3 플라즈마",
    coins_on_road = "도로 코인",
    banana_message = "바나나!",
    crash = "충돌!",
    game_over_level = "게임오버 레벨 ",
    restart = "BTN1 재시작",
    complete_prefix = "레벨 ",
    complete_suffix = " 완료",
    btn1_level_1 = "BTN1 레벨1",
    btn1_next_level = "BTN1 레벨 ",
    gold_equipped = "금 차 장착",
    gold_unlocked = "금 차 해제!",
    paid_money = "결제: +",
    plasma_suffix = " 플라즈마",
    start = "시작 - 4 누르기",
    change_language = "아무 키나 언어 변경",
    language_label = "언어: ",
    easy = "쉬움",
    hard = "어려움",
    impossible = "불가능",
  },
  {
    name = "ENGLISH",
    level = "LEVEL ",
    prestige = "PRESTIGE x",
    speed = "SPD ",
    coins = "COINS ",
    plasma = "PLASMA ",
    banana = "BTN2 BANANA ",
    gold_owned = "GOLD CAR OWNED",
    gold_buy = "BTN3 GOLD ",
    buy_plasma = "BTN3 BUY PLASMA",
    coins_on_road = "COINS ON ROAD",
    banana_message = "BANANA!",
    crash = "CRASH!",
    game_over_level = "GAME OVER - LEVEL ",
    restart = "PRESS BTN1 TO RESTART",
    complete_prefix = "LEVEL ",
    complete_suffix = " COMPLETE",
    btn1_level_1 = "BTN1 STARTS LEVEL 1",
    btn1_next_level = "PRESS BTN1 FOR LEVEL ",
    gold_equipped = "GOLD CAR EQUIPPED",
    gold_unlocked = "GOLD CAR UNLOCKED!",
    paid_money = "PAID MONEY: +",
    plasma_suffix = " PLASMA",
    start = "START GAME - PRESS 4",
    change_language = "PRESS ANYTHING TO CHANGE LANGUAGE",
    language_label = "LANGUAGE: ",
    easy = "EASY",
    hard = "HARD",
    impossible = "IMPOSSIBLE",
  },
  {
    name = "ESPAÑOL",
    level = "NIVEL ",
    prestige = "PRESTIGIO x",
    speed = "VEL ",
    coins = "MONEDAS ",
    plasma = "PLASMA ",
    banana = "BTN2 BANANA ",
    gold_owned = "AUTO ORO LISTO",
    gold_buy = "BTN3 ORO ",
    buy_plasma = "BTN3 PLASMA",
    coins_on_road = "MONEDAS RUTA",
    banana_message = "BANANA!",
    crash = "CHOQUE!",
    game_over_level = "FIN - NIVEL ",
    restart = "BTN1 REINICIAR",
    complete_prefix = "NIVEL ",
    complete_suffix = " COMPLETO",
    btn1_level_1 = "BTN1 NIVEL 1",
    btn1_next_level = "BTN1 NIVEL ",
    gold_equipped = "AUTO ORO EQUIPADO",
    gold_unlocked = "AUTO ORO!",
    paid_money = "PAGADO: +",
    plasma_suffix = " PLASMA",
    start = "INICIAR - PULSA 4",
    change_language = "PULSA ALGO PARA IDIOMA",
    language_label = "IDIOMA: ",
    easy = "FACIL",
    hard = "DIFICIL",
    impossible = "IMPOSIBLE",
  },
  {
    name = "中文",
    level = "关卡 ",
    prestige = "声望 x",
    speed = "速度 ",
    coins = "金币 ",
    plasma = "等离子 ",
    banana = "BTN2 香蕉 ",
    gold_owned = "金车已拥有",
    gold_buy = "BTN3 金车 ",
    buy_plasma = "BTN3 买等离子",
    coins_on_road = "路上金币",
    banana_message = "香蕉!",
    crash = "撞车!",
    game_over_level = "游戏结束 关卡 ",
    restart = "BTN1 重新开始",
    complete_prefix = "关卡 ",
    complete_suffix = " 完成",
    btn1_level_1 = "BTN1 关卡1",
    btn1_next_level = "BTN1 关卡 ",
    gold_equipped = "金车已装备",
    gold_unlocked = "金车解锁!",
    paid_money = "付款: +",
    plasma_suffix = " 等离子",
    start = "开始游戏 - 按4",
    change_language = "按任意键换语言",
    language_label = "语言: ",
    easy = "简单",
    hard = "困难",
    impossible = "不可能",
  },
  {
    name = "РУССКИЙ",
    level = "УРОВЕНЬ ",
    prestige = "ПРЕСТИЖ x",
    speed = "СКР ",
    coins = "МОНЕТЫ ",
    plasma = "ПЛАЗМА ",
    banana = "BTN2 БАНАН ",
    gold_owned = "ЗОЛОТАЯ МАШИНА",
    gold_buy = "BTN3 ЗОЛОТО ",
    buy_plasma = "BTN3 ПЛАЗМА",
    coins_on_road = "МОНЕТЫ НА ДОРОГЕ",
    banana_message = "БАНАН!",
    crash = "АВАРИЯ!",
    game_over_level = "КОНЕЦ - УРОВЕНЬ ",
    restart = "BTN1 ЗАНОВО",
    complete_prefix = "УРОВЕНЬ ",
    complete_suffix = " ПРОЙДЕН",
    btn1_level_1 = "BTN1 УРОВЕНЬ 1",
    btn1_next_level = "BTN1 УРОВЕНЬ ",
    gold_equipped = "ЗОЛОТО ВЫБРАНО",
    gold_unlocked = "ЗОЛОТО ОТКРЫТО!",
    paid_money = "ОПЛАТА: +",
    plasma_suffix = " ПЛАЗМА",
    start = "СТАРТ - НАЖМИ 4",
    change_language = "НАЖМИ ЧТО УГОДНО ДЛЯ ЯЗЫКА",
    language_label = "ЯЗЫК: ",
    easy = "ЛЕГКО",
    hard = "СЛОЖНО",
    impossible = "НЕВОЗМОЖНО",
  },
}

local DEFAULT_LANGUAGE_INDEX = 3

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

local function coin_level(level)
  return level % COIN_LEVEL_PERIOD == 0
end

local function language()
  local index = DEFAULT_LANGUAGE_INDEX

  if State and State.language_index then
    index = State.language_index
  end

  return LANGUAGES[index] or LANGUAGES[DEFAULT_LANGUAGE_INDEX]
end

local function label(key)
  return language()[key] or LANGUAGES[DEFAULT_LANGUAGE_INDEX][key] or key
end

local function cycle_language()
  State.language_index = (State.language_index or DEFAULT_LANGUAGE_INDEX) + 1

  if State.language_index > #LANGUAGES then
    State.language_index = 1
  end
end

local function car_style_owned(index)
  return State.owned_upgrade_cars and State.owned_upgrade_cars[index] == true
end

local function car_style_colors(index)
  local body_colors = {
    gfx.COLOR_BLUE,
    gfx.COLOR_GREEN,
    gfx.COLOR_PINK,
    gfx.COLOR_ORANGE,
    gfx.COLOR_RED,
    gfx.COLOR_INDIGO,
    gfx.COLOR_PEACH,
    gfx.COLOR_LIGHT_GRAY,
  }
  local trim_colors = {
    gfx.COLOR_DARK_BLUE,
    gfx.COLOR_DARK_GREEN,
    gfx.COLOR_DARK_PURPLE,
    gfx.COLOR_BROWN,
    gfx.COLOR_BLACK,
  }
  local window_colors = {
    gfx.COLOR_INDIGO,
    gfx.COLOR_LIGHT_GRAY,
    gfx.COLOR_TRUE_WHITE,
    gfx.COLOR_DARK_GRAY,
  }

  return body_colors[(index - 1) % #body_colors + 1],
    trim_colors[(index * 2) % #trim_colors + 1],
    window_colors[(index * 3) % #window_colors + 1]
end

local function language_pick_pressed()
  if input.pressed(input.LEFT) or input.pressed(input.RIGHT)
      or input.pressed(input.UP) or input.pressed(input.DOWN)
      or input.pressed(input.BTN1) or input.pressed(input.BTN2)
      or input.pressed(input.BTN3)
      or input.mouse_pressed(input.MOUSE_LEFT)
      or input.mouse_pressed(input.MOUSE_RIGHT)
      or input.mouse_pressed(input.MOUSE_MIDDLE) then
    return true
  end

  local keys = {
    input.KEY_A, input.KEY_B, input.KEY_C, input.KEY_D, input.KEY_E,
    input.KEY_F, input.KEY_G, input.KEY_H, input.KEY_I, input.KEY_J,
    input.KEY_K, input.KEY_L, input.KEY_M, input.KEY_N, input.KEY_O,
    input.KEY_P, input.KEY_Q, input.KEY_R, input.KEY_S, input.KEY_T,
    input.KEY_U, input.KEY_V, input.KEY_W, input.KEY_X, input.KEY_Y,
    input.KEY_Z, input.KEY_0, input.KEY_1, input.KEY_2, input.KEY_3,
    input.KEY_6, input.KEY_7, input.KEY_8, input.KEY_9,
    input.KEY_SPACE, input.KEY_ENTER, input.KEY_ESCAPE, input.KEY_TAB,
    input.KEY_BACKSPACE, input.KEY_DELETE, input.KEY_LEFT, input.KEY_RIGHT,
    input.KEY_UP, input.KEY_DOWN, input.KEY_LSHIFT, input.KEY_RSHIFT,
    input.KEY_LCTRL, input.KEY_RCTRL, input.KEY_LALT, input.KEY_RALT,
    input.KEY_BACKTICK, input.KEY_MINUS, input.KEY_EQUAL,
    input.KEY_LBRACKET, input.KEY_RBRACKET, input.KEY_BACKSLASH,
    input.KEY_SEMICOLON, input.KEY_APOSTROPHE, input.KEY_COMMA,
    input.KEY_PERIOD, input.KEY_SLASH,
  }

  for _, key in ipairs(keys) do
    if input.key_pressed(key) then
      return true
    end
  end

  return false
end

local function difficulty_label(level)
  local difficulty = difficulty_for_level(level)

  if difficulty == "easy" then
    return label("easy")
  end

  if difficulty == "hard" then
    return label("hard")
  end

  return label("impossible")
end

local function world_speed_for_level(level)
  if level <= 14 then
    return BASE_WORLD_SPEED + level * 2
  end

  if level <= 23 then
    return BASE_WORLD_SPEED + 38 + (level - 14) * 4
  end

  local speed = BASE_WORLD_SPEED + 82 + (level - 23) * 2.4

  if State and State.endgame_path == "obby" then
    speed = speed + OBBY_SPEED_BONUS + State.prestige * 5
  end

  return speed
end

local function spawn_interval_for_level(level)
  if level <= 14 then
    return math.max(0.72, 1.28 - level * 0.035)
  end

  if level <= 23 then
    return math.max(0.42, 0.82 - (level - 14) * 0.045)
  end

  local interval = math.max(0.22, 0.46 - (level - 23) * 0.004)

  if State and State.endgame_path == "obby" then
    interval = math.max(0.16, interval * OBBY_SPAWN_MULTIPLIER)
  end

  return interval
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
  local plasma_coins = 0
  local gold_car_owned = false
  local language_index = DEFAULT_LANGUAGE_INDEX
  local owned_upgrade_cars = { [1] = true }
  local equipped_car_index = 1
  local shop_car_index = 1
  local settings_tab = SETTINGS_CAR_TAB
  local background_index = 1
  local equipped_background = "space"
  local owned_backgrounds = {
    space = true,
    void = true,
  }
  local music_on = true
  local endgame_path = "normal"

  if keep_progress and State and State.coins then
    coins = State.coins
  end

  if keep_progress and State and State.plasma_coins then
    plasma_coins = State.plasma_coins
  end

  if keep_progress and State and State.gold_car_owned then
    gold_car_owned = true
  end

  if keep_progress and State and State.owned_upgrade_cars then
    owned_upgrade_cars = State.owned_upgrade_cars
  end

  if keep_progress and State and State.equipped_car_index then
    equipped_car_index = State.equipped_car_index
  end

  if State and State.shop_car_index then
    shop_car_index = State.shop_car_index
  end

  if State and State.settings_tab then
    settings_tab = State.settings_tab
  end

  if State and State.background_index then
    background_index = State.background_index
  end

  if keep_progress and State and State.equipped_background then
    equipped_background = State.equipped_background
  end

  if keep_progress and State and State.owned_backgrounds then
    owned_backgrounds = State.owned_backgrounds
  end

  if State and State.music_on ~= nil then
    music_on = State.music_on
  end

  if keep_progress and State and State.endgame_path then
    endgame_path = State.endgame_path
  end

  if State and State.language_index then
    language_index = State.language_index
  end

  State = {
    mode = "playing",
    level = level,
    prestige = prestige,
    car_x = SCREEN_W / 2 - CAR_W / 2,
    car_y = CAR_START_Y,
    world_speed = world_speed,
    road_scroll = 0,
    space_scroll = 0,
    distance = 0,
    target_distance = LEVEL_DISTANCE + level * 18,
    obstacles = {},
    coins = coins,
    plasma_coins = plasma_coins,
    gold_car_owned = gold_car_owned,
    owned_upgrade_cars = owned_upgrade_cars,
    equipped_car_index = equipped_car_index,
    shop_car_index = shop_car_index,
    settings_tab = settings_tab,
    background_index = background_index,
    equipped_background = equipped_background,
    owned_backgrounds = owned_backgrounds,
    music_on = music_on,
    endgame_path = endgame_path,
    language_index = language_index,
    pickups = {},
    spawn_timer = 0.7,
    coin_spawn_timer = 0.55,
    finish_timer = 0,
    green_cars_spawned = 0,
    banana_clear_timer = 0,
    banana_flash_timer = 0,
    banana_message_timer = 0,
    premium_message_timer = 0,
    premium_message = "",
  }
end

local function reset_state()
  new_level_state(1, 0, false)
  State.mode = "title"
end

local function ensure_state()
  if not State or not State.mode or not State.world_speed or not State.obstacles then
    reset_state()
    return
  end

  if not State.coins then
    State.coins = 0
  end

  if not State.language_index then
    State.language_index = DEFAULT_LANGUAGE_INDEX
  end

  if not State.plasma_coins then
    State.plasma_coins = 0
  end

  if State.gold_car_owned == nil then
    State.gold_car_owned = false
  end

  if not State.owned_upgrade_cars then
    State.owned_upgrade_cars = { [1] = true }
  end

  if not State.equipped_car_index then
    State.equipped_car_index = 1
  end

  if not State.shop_car_index then
    State.shop_car_index = State.equipped_car_index
  end

  if not State.settings_tab then
    State.settings_tab = SETTINGS_CAR_TAB
  end

  if not State.background_index then
    State.background_index = 1
  end

  if not State.equipped_background then
    State.equipped_background = "space"
  end

  if not State.owned_backgrounds then
    State.owned_backgrounds = {
      space = true,
      void = true,
    }
  end

  if State.music_on == nil then
    State.music_on = true
  end

  if not State.endgame_path then
    State.endgame_path = "normal"
  end

  if not State.pickups then
    State.pickups = {}
  end

  if not State.coin_spawn_timer then
    State.coin_spawn_timer = 0.55
  end

  if not State.space_scroll then
    State.space_scroll = State.city_scroll or 0
    State.city_scroll = nil
  end

  if not State.green_cars_spawned then
    State.green_cars_spawned = 0
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

  if not State.premium_message_timer then
    State.premium_message_timer = 0
  end

  if not State.premium_message then
    State.premium_message = ""
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

local function choose_prestige_reward()
  State.endgame_path = "normal"
  new_level_state(1, State.prestige + 1, true)
end

local function choose_coach_reward()
  State.endgame_path = "coach"
  new_level_state(1, State.prestige, true)
end

local function choose_city_reward()
  State.endgame_path = "city"
  new_level_state(1, State.prestige, true)
end

local function choose_obby_reward()
  State.endgame_path = "obby"
  new_level_state(1, State.prestige, true)
end

local function planet_color(seed)
  local colors = {
    gfx.COLOR_PINK,
    gfx.COLOR_GREEN,
    gfx.COLOR_ORANGE,
    gfx.COLOR_INDIGO,
    gfx.COLOR_PEACH,
    gfx.COLOR_DARK_PURPLE,
    gfx.COLOR_BLUE,
  }

  return colors[seed % #colors + 1]
end

local function draw_strange_planet(x, y, r, seed)
  local color = planet_color(seed)

  gfx.circ_fill(x, y, r, color)
  gfx.circ(x, y, r, gfx.COLOR_BLACK)

  if seed % 2 == 0 then
    gfx.line(x - r - 5, y + 1, x + r + 5, y - 3, gfx.COLOR_LIGHT_GRAY)
    gfx.line(x - r - 4, y + 3, x + r + 4, y - 1, gfx.COLOR_DARK_GRAY)
  else
    gfx.circ(x + r / 3, y - r / 4, math.max(2, r / 4), gfx.COLOR_YELLOW)
    gfx.circ_fill(x - r / 3, y + r / 5, math.max(1, r / 5),
      gfx.COLOR_DARK_BLUE)
  end

  if seed % 3 == 0 then
    gfx.line(x - r / 2, y - r, x + r / 2, y + r, gfx.COLOR_TRUE_WHITE)
  end
end

local function draw_space_background()
  gfx.rect_fill(0, 0, SCREEN_W, SCREEN_H, gfx.COLOR_BLACK)

  for i = 1, SPACE_STAR_COUNT do
    local x = (i * 47 + i * i * 3) % SCREEN_W
    local base_y = (i * 31 + i * i) % SPACE_LOOP_H
    local y = math.floor((base_y + State.space_scroll) % SPACE_LOOP_H - 80)
    local color = gfx.COLOR_LIGHT_GRAY

    if i % 5 == 0 then
      color = gfx.COLOR_TRUE_WHITE
    elseif i % 7 == 0 then
      color = gfx.COLOR_YELLOW
    end

    if y >= 0 and y < SCREEN_H then
      gfx.rect_fill(x, y, 1, 1, color)

      if i % 11 == 0 then
        gfx.rect_fill(x - 1, y, 3, 1, color)
        gfx.rect_fill(x, y - 1, 1, 3, color)
      end
    end
  end

  for i = 1, SPACE_PLANET_COUNT do
    local x = (i * 83 + 19) % SCREEN_W
    local base_y = (i * 67 + 23) % SPACE_LOOP_H
    local y = math.floor((base_y + State.space_scroll * 0.72)
      % SPACE_LOOP_H - 110)
    local r = 9 + (i % 4) * 3

    if y + r >= 0 and y - r < SCREEN_H then
      draw_strange_planet(x, y, r, i)
    end
  end
end

local function draw_city_teleport_overlay()
  for i = 0, 7 do
    local x = i * 42 - 6
    local h = 30 + (i % 4) * 9
    local y = SCREEN_H - h

    gfx.rect_fill(x, y, 32, h, gfx.COLOR_DARK_PURPLE)
    gfx.rect(x, y, 32, h, gfx.COLOR_BLACK)

    for wy = y + 7, SCREEN_H - 8, 11 do
      gfx.rect_fill(x + 7, wy, 5, 4, gfx.COLOR_YELLOW)
      gfx.rect_fill(x + 20, wy, 5, 4, gfx.COLOR_LIGHT_GRAY)
    end
  end
end

local function draw_void_background()
  gfx.rect_fill(0, 0, SCREEN_W, SCREEN_H, gfx.COLOR_BLACK)

  for i = 1, 16 do
    local x = (i * 61 + 17) % SCREEN_W
    local y = math.floor(((i * 47) + State.space_scroll * 0.35)
      % SPACE_LOOP_H - 120)

    if y >= 0 and y < SCREEN_H then
      gfx.rect_fill(x, y, 1, 1, gfx.COLOR_DARK_GRAY)
    end
  end
end

local function draw_cheering_background()
  gfx.rect_fill(0, 0, SCREEN_W, SCREEN_H, gfx.COLOR_DARK_PURPLE)

  for i = 1, 32 do
    local x = (i - 1) * 10
    local y = 132 + (i % 3) * 6
    local shirt = gfx.COLOR_GREEN

    if i % 4 == 0 then
      shirt = gfx.COLOR_PINK
    elseif i % 4 == 1 then
      shirt = gfx.COLOR_YELLOW
    elseif i % 4 == 2 then
      shirt = gfx.COLOR_BLUE
    end

    gfx.circ_fill(x + 5, y, 3, gfx.COLOR_PEACH)
    gfx.rect_fill(x + 2, y + 4, 6, 9, shirt)
    gfx.line(x + 2, y + 5, x, y + 1, gfx.COLOR_PEACH)
    gfx.line(x + 8, y + 5, x + 10, y + 1, gfx.COLOR_PEACH)
  end
end

local function draw_village_background()
  gfx.rect_fill(0, 0, SCREEN_W, SCREEN_H, gfx.COLOR_DARK_GREEN)

  for i = 0, 7 do
    local x = i * 46 - 8
    local y = 118 + (i % 2) * 10

    gfx.rect_fill(x, y, 30, 26, gfx.COLOR_BROWN)
    gfx.line(x - 2, y, x + 15, y - 14, gfx.COLOR_ORANGE)
    gfx.line(x + 15, y - 14, x + 32, y, gfx.COLOR_ORANGE)
    gfx.rect_fill(x + 11, y + 12, 8, 14, gfx.COLOR_DARK_GRAY)
    gfx.rect_fill(x + 4, y + 7, 6, 5, gfx.COLOR_YELLOW)
    gfx.rect_fill(x + 20, y + 7, 6, 5, gfx.COLOR_YELLOW)
  end
end

local function draw_current_background()
  if State.equipped_background == "void" then
    draw_void_background()
  elseif State.equipped_background == "cheering" then
    draw_cheering_background()
  elseif State.equipped_background == "village" then
    draw_village_background()
  else
    draw_space_background()
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
  local body_color, trim_color, window_color =
    car_style_colors(State.equipped_car_index or 1)

  if State.gold_car_owned and (State.equipped_car_index or 1) == 1 then
    body_color = gfx.COLOR_YELLOW
    trim_color = gfx.COLOR_ORANGE
    window_color = gfx.COLOR_LIGHT_GRAY
  end

  gfx.rect_fill(x + 3, y + 1, CAR_W - 6, CAR_H - 2, body_color)
  gfx.rect_fill(x + 1, y + 7, CAR_W - 2, CAR_H - 12, body_color)
  gfx.rect(x + 3, y + 1, CAR_W - 6, CAR_H - 2, trim_color)
  gfx.rect_fill(x + 5, y + 5, CAR_W - 10, 6, window_color)
  gfx.rect_fill(x + 5, y + 17, CAR_W - 10, 4, trim_color)
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

  if obstacle.kind == "orange_car" then
    color = gfx.COLOR_ORANGE
  elseif obstacle.kind == "prestige_car" then
    color = gfx.COLOR_RED
  elseif obstacle.variant == 1 then
    color = gfx.COLOR_GREEN
  elseif obstacle.variant == 2 then
    color = gfx.COLOR_PINK
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

  if obstacle.kind == "orange_car" then
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

local function draw_child(obstacle)
  local x = math.floor(obstacle.x)
  local y = math.floor(obstacle.y)

  gfx.circ_fill(x + 5, y + 4, 3, gfx.COLOR_PEACH)
  gfx.rect_fill(x + 2, y + 2, 6, 2, gfx.COLOR_BROWN)
  gfx.rect_fill(x + 3, y + 8, 4, 6, gfx.COLOR_YELLOW)
  gfx.line(x + 3, y + 9, x, y + 12, gfx.COLOR_PEACH)
  gfx.line(x + 7, y + 9, x + CHILD_W - 1, y + 12, gfx.COLOR_PEACH)
  gfx.line(x + 4, y + 14, x + 2, y + CHILD_H - 1, gfx.COLOR_BLUE)
  gfx.line(x + 6, y + 14, x + 8, y + CHILD_H - 1, gfx.COLOR_BLUE)
  gfx.rect(x + 2, y + 1, 6, CHILD_H - 1, gfx.COLOR_BLACK)
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
    elseif obstacle.kind == "child" then
      draw_child(obstacle)
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

local function draw_car_preview(x, y, car_index)
  local body_color, trim_color, window_color = car_style_colors(car_index)

  gfx.rect_fill(x + 6, y + 2, 24, 32, body_color)
  gfx.rect_fill(x + 2, y + 10, 32, 18, body_color)
  gfx.rect(x + 6, y + 2, 24, 32, trim_color)
  gfx.rect_fill(x + 11, y + 7, 14, 7, window_color)
  gfx.rect_fill(x + 11, y + 23, 14, 5, trim_color)
  gfx.rect_fill(x, y + 11, 5, 8, gfx.COLOR_BLACK)
  gfx.rect_fill(x + 31, y + 11, 5, 8, gfx.COLOR_BLACK)
  gfx.rect_fill(x, y + 25, 5, 8, gfx.COLOR_BLACK)
  gfx.rect_fill(x + 31, y + 25, 5, 8, gfx.COLOR_BLACK)
  gfx.rect_fill(x + 8, y + 2, 5, 3, gfx.COLOR_TRUE_WHITE)
  gfx.rect_fill(x + 23, y + 2, 5, 3, gfx.COLOR_TRUE_WHITE)
end

local function draw_hud()
  local level_text = label("level") .. State.level .. "/" .. MAX_LEVEL
  local prestige_text = label("prestige") .. State.prestige
  local tier_text = difficulty_label(State.level)
  local speed_text = label("speed") .. math.floor(State.world_speed)
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

  gfx.rect_fill(148, 4, 82, 15, gfx.COLOR_BLACK)
  gfx.text(speed_text, 153, 7, gfx.COLOR_GREEN)

  gfx.rect_fill(4, SCREEN_H - 20, 130, 16, gfx.COLOR_BLACK)
  gfx.text(label("coins") .. State.coins, 8, SCREEN_H - 17,
    gfx.COLOR_YELLOW)

  gfx.rect_fill(4, SCREEN_H - 36, 130, 14, gfx.COLOR_BLACK)
  gfx.text(label("plasma") .. State.plasma_coins, 8, SCREEN_H - 34,
    gfx.COLOR_PINK)

  local banana_color = gfx.COLOR_LIGHT_GRAY

  if State.coins >= BANANA_COST then
    banana_color = gfx.COLOR_YELLOW
  end

  gfx.rect_fill(SCREEN_W - 120, SCREEN_H - 20, 116, 16, gfx.COLOR_BLACK)
  gfx.text(label("banana") .. BANANA_COST, SCREEN_W - 116, SCREEN_H - 17,
    banana_color)

  gfx.rect_fill(SCREEN_W - 120, SCREEN_H - 36, 116, 14, gfx.COLOR_BLACK)

  if State.gold_car_owned then
    gfx.text(label("gold_owned"), SCREEN_W - 116, SCREEN_H - 34,
      gfx.COLOR_YELLOW)
  elseif State.plasma_coins >= GOLD_CAR_COST then
    gfx.text(label("gold_buy") .. GOLD_CAR_COST, SCREEN_W - 116,
      SCREEN_H - 34, gfx.COLOR_YELLOW)
  else
    gfx.text(label("buy_plasma"), SCREEN_W - 116, SCREEN_H - 34,
      gfx.COLOR_PINK)
  end

  if coin_level(State.level) then
    gfx.rect_fill(4, 32, 92, 12, gfx.COLOR_BLACK)
    gfx.text(label("coins_on_road"), 8, 34, gfx.COLOR_YELLOW)
  end

  if State.endgame_path and State.endgame_path ~= "normal" then
    local path_text = "PATH " .. string.upper(State.endgame_path)

    gfx.rect_fill(4, 46, 92, 12, gfx.COLOR_BLACK)
    gfx.text(path_text, 8, 48, gfx.COLOR_GREEN)
  end

  if State.endgame_path == "coach" then
    gfx.rect_fill(SCREEN_W - 88, 22, 84, 12, gfx.COLOR_BLACK)
    gfx.text("COACH BOOST", SCREEN_W - 84, 24, gfx.COLOR_YELLOW)
  elseif State.endgame_path == "obby" then
    gfx.rect_fill(SCREEN_W - 88, 22, 84, 12, gfx.COLOR_BLACK)
    gfx.text("OBBY HARD", SCREEN_W - 84, 24, gfx.COLOR_RED)
  end

  if State.banana_message_timer > 0 then
    text_center(label("banana_message"), 62, gfx.COLOR_YELLOW)
  end

  if State.premium_message_timer > 0 then
    text_center(State.premium_message, 76, gfx.COLOR_PINK)
  end
end

local function draw_overlay()
  if State.mode == "playing" then
    return
  end

  if State.mode == "title" then
    gfx.rect_fill(38, 42, 244, 92, gfx.COLOR_BLACK)
    gfx.rect(38, 42, 244, 92, gfx.COLOR_WHITE)
    text_center("HIROIKKU RESU", 52, gfx.COLOR_YELLOW)
    text_center(label("start"), 72, gfx.COLOR_TRUE_WHITE)
    text_center("SETTINGS - PRESS 5", 88, gfx.COLOR_YELLOW)
    text_center(label("change_language"), 104, gfx.COLOR_PINK)
    text_center(label("language_label") .. language().name, 120,
      gfx.COLOR_GREEN)
    return
  end

  if State.mode == "settings" then
    gfx.rect_fill(28, 22, 264, 136, gfx.COLOR_BLACK)
    gfx.rect(28, 22, 264, 136, gfx.COLOR_WHITE)
    text_center("SETTINGS", 32, gfx.COLOR_YELLOW)
    gfx.text("UP/DOWN TAB", 44, 48, gfx.COLOR_LIGHT_GRAY)

    if State.settings_tab == SETTINGS_BACKGROUND_TAB then
      local background = BACKGROUNDS[State.background_index]
      local owned = State.owned_backgrounds[background.id] == true
      local status = "LOCKED"
      local price = "FREE"

      if State.equipped_background == background.id then
        status = "EQUIPPED"
      elseif owned then
        status = "OWNED"
      end

      if background.currency == "plasma" then
        price = background.cost .. " PLASMA"
      elseif background.currency == "coins" then
        price = background.cost .. " COINS"
      end

      text_center("BACKGROUND", 48, gfx.COLOR_PINK)
      gfx.text(background.name, 54, 74, gfx.COLOR_TRUE_WHITE)
      gfx.text("DETAIL " .. status, 54, 90, gfx.COLOR_GREEN)
      gfx.text("PRICE " .. price, 54, 106, gfx.COLOR_YELLOW)
      gfx.text("COINS " .. State.coins .. "  PLASMA " .. State.plasma_coins,
        54, 122, gfx.COLOR_PINK)
      gfx.text("LEFT/RIGHT PICK", 44, 140, gfx.COLOR_TRUE_WHITE)
      gfx.text("BTN3 BUY/EQUIP  4 BACK", 140, 140, gfx.COLOR_YELLOW)
    elseif State.settings_tab == SETTINGS_MUSIC_TAB then
      text_center("MUSIC", 48, gfx.COLOR_PINK)
      gfx.text("DETAIL MUSIC TOGGLE", 54, 78, gfx.COLOR_GREEN)
      gfx.text("STATUS " .. (State.music_on and "ON" or "OFF"), 54, 96,
        gfx.COLOR_TRUE_WHITE)
      gfx.text("BTN3 TOGGLE", 54, 116, gfx.COLOR_YELLOW)
      gfx.text("4 BACK", 206, 140, gfx.COLOR_YELLOW)
    else
      local car_index = State.shop_car_index or 1
      local owned = car_style_owned(car_index)
      local status = "LOCKED"

      if State.equipped_car_index == car_index then
        status = "EQUIPPED"
      elseif owned then
        status = "OWNED"
      end

      text_center("WIFI UPGRADE CAR", 48, gfx.COLOR_PINK)
      draw_car_preview(44, 72, car_index)
      gfx.text("CAR " .. car_index .. "/" .. UPGRADE_CAR_COUNT, 94, 70,
        gfx.COLOR_TRUE_WHITE)
      gfx.text("DETAIL " .. status, 94, 86, gfx.COLOR_GREEN)
      gfx.text("PRICE " .. UPGRADE_CAR_COST .. " PLASMA", 94, 102,
        gfx.COLOR_PINK)
      gfx.text("PLASMA " .. State.plasma_coins, 94, 118, gfx.COLOR_PINK)
      gfx.text("LEFT/RIGHT PICK", 44, 140, gfx.COLOR_TRUE_WHITE)
      gfx.text("BTN3 BUY/EQUIP  4 BACK", 140, 140, gfx.COLOR_YELLOW)
    end

    if State.premium_message_timer > 0 then
      text_center(State.premium_message, 158, gfx.COLOR_PINK)
    end

    return
  end

  gfx.rect_fill(48, 54, 224, 72, gfx.COLOR_BLACK)
  gfx.rect(48, 54, 224, 72, gfx.COLOR_WHITE)

  if State.mode == "game_over" then
    text_center(label("crash"), 64, gfx.COLOR_RED)
    text_center(label("game_over_level") .. State.level, 82,
      gfx.COLOR_TRUE_WHITE)
    text_center(label("restart"), 104, gfx.COLOR_YELLOW)
  elseif State.mode == "level_complete" then
    text_center(label("complete_prefix") .. State.level
      .. label("complete_suffix"), 68,
      gfx.COLOR_GREEN)

    if State.level == MAX_LEVEL then
      gfx.rect_fill(42, 82, 236, 54, gfx.COLOR_BLACK)
      text_center("BTN1 PRESTIGE +1", 84, gfx.COLOR_YELLOW)
      text_center("BTN2 BE THE COACH", 98, gfx.COLOR_TRUE_WHITE)
      text_center("BTN3 TELEPORT CITY", 112, gfx.COLOR_PINK)
      text_center("4 HARDER OBBY", 126, gfx.COLOR_GREEN)
    else
      text_center(label("btn1_next_level") .. (State.level + 1), 94,
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
  local speed = State.world_speed + math.random(8, 30)
  local variant = math.random(0, 1) * 2

  local special_roll = math.random()

  if special_roll < PRESTIGE_CAR_CHANCE then
    kind = "prestige_car"
  elseif special_roll < PRESTIGE_CAR_CHANCE + ORANGE_CAR_CHANCE then
    kind = "orange_car"
  elseif math.random() < CHILD_CHANCE then
    kind = "child"
    w = CHILD_W
    h = CHILD_H
    pad_x = 2
    pad_y = 2
    speed = State.world_speed + math.random(0, 10)
  elseif math.random() < 0.42 then
    kind = "box"
    w = BOX_W
    h = BOX_H
    pad_x = 2
    pad_y = 2
  end

  if kind == "car" and State.green_cars_spawned < GREEN_CAR_LIMIT
      and math.random() < GREEN_CAR_CHANCE then
    variant = 1
    State.green_cars_spawned = State.green_cars_spawned + 1
  end

  return {
    kind = kind,
    x = LANES[lane_index] - w / 2,
    y = -h - math.random(0, 28),
    w = w,
    h = h,
    pad_x = pad_x,
    pad_y = pad_y,
    speed = speed,
    variant = variant,
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
  State.space_scroll = (State.space_scroll + State.world_speed * dt * 0.55)
    % SPACE_LOOP_H
end

local function update_player(dt)
  local move_x = 0
  local move_y = 0
  local car_speed = CAR_SPEED
  local vertical_speed = CAR_VERTICAL_SPEED

  if State.endgame_path == "coach" then
    car_speed = car_speed + 22
    vertical_speed = vertical_speed + 16
  end

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

  State.car_x = clamp(State.car_x + move_x * car_speed * dt,
    ROAD_LEFT, ROAD_RIGHT - CAR_W)
  State.car_y = clamp(State.car_y + move_y * vertical_speed * dt,
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

local function update_premium_shop(dt)
  if State.premium_message_timer > 0 then
    State.premium_message_timer = math.max(0, State.premium_message_timer - dt)
  end

  if not input.pressed(input.BTN3) then
    return
  end

  if State.gold_car_owned then
    State.premium_message = label("gold_equipped")
  elseif State.plasma_coins >= GOLD_CAR_COST then
    State.plasma_coins = State.plasma_coins - GOLD_CAR_COST
    State.gold_car_owned = true
    State.equipped_car_index = 1
    State.premium_message = label("gold_unlocked")
    effect.flash(0.16, gfx.COLOR_YELLOW)
  else
    State.plasma_coins = State.plasma_coins + PLASMA_PURCHASE_AMOUNT
    State.premium_message = label("paid_money") .. PLASMA_PURCHASE_AMOUNT
      .. label("plasma_suffix")
    effect.flash(0.1, gfx.COLOR_PINK)
  end

  State.premium_message_timer = 0.75
end

local function update_settings_screen(dt)
  if State.premium_message_timer > 0 then
    State.premium_message_timer = math.max(0, State.premium_message_timer - dt)
  end

  if input.pressed(input.UP) then
    State.settings_tab = State.settings_tab - 1

    if State.settings_tab < 1 then
      State.settings_tab = SETTINGS_TAB_COUNT
    end
  end

  if input.pressed(input.DOWN) then
    State.settings_tab = State.settings_tab + 1

    if State.settings_tab > SETTINGS_TAB_COUNT then
      State.settings_tab = 1
    end
  end

  if input.pressed(input.LEFT) then
    if State.settings_tab == SETTINGS_BACKGROUND_TAB then
      State.background_index = State.background_index - 1

      if State.background_index < 1 then
        State.background_index = #BACKGROUNDS
      end
    elseif State.settings_tab == SETTINGS_CAR_TAB then
      State.shop_car_index = State.shop_car_index - 1

      if State.shop_car_index < 1 then
        State.shop_car_index = UPGRADE_CAR_COUNT
      end
    end
  end

  if input.pressed(input.RIGHT) then
    if State.settings_tab == SETTINGS_BACKGROUND_TAB then
      State.background_index = State.background_index + 1

      if State.background_index > #BACKGROUNDS then
        State.background_index = 1
      end
    elseif State.settings_tab == SETTINGS_CAR_TAB then
      State.shop_car_index = State.shop_car_index + 1

      if State.shop_car_index > UPGRADE_CAR_COUNT then
        State.shop_car_index = 1
      end
    end
  end

  if input.pressed(input.BTN3) then
    if State.settings_tab == SETTINGS_BACKGROUND_TAB then
      local background = BACKGROUNDS[State.background_index]
      local owned = State.owned_backgrounds[background.id] == true

      if owned then
        State.equipped_background = background.id
        State.premium_message = background.name .. " EQUIPPED"
        State.premium_message_timer = 0.8
      elseif background.currency == "plasma"
          and State.plasma_coins >= background.cost then
        State.plasma_coins = State.plasma_coins - background.cost
        State.owned_backgrounds[background.id] = true
        State.equipped_background = background.id
        State.premium_message = background.name .. " UNLOCKED"
        State.premium_message_timer = 0.8
      elseif background.currency == "coins" and State.coins >= background.cost then
        State.coins = State.coins - background.cost
        State.owned_backgrounds[background.id] = true
        State.equipped_background = background.id
        State.premium_message = background.name .. " UNLOCKED"
        State.premium_message_timer = 0.8
      else
        State.premium_message = "NOT ENOUGH MONEY"
        State.premium_message_timer = 0.8
      end
    elseif State.settings_tab == SETTINGS_MUSIC_TAB then
      State.music_on = not State.music_on
      State.premium_message = "MUSIC " .. (State.music_on and "ON" or "OFF")
      State.premium_message_timer = 0.8
    else
      local car_index = State.shop_car_index

      if car_style_owned(car_index) then
        State.equipped_car_index = car_index
        State.premium_message = "CAR " .. car_index .. " EQUIPPED"
        State.premium_message_timer = 0.8
      elseif State.plasma_coins >= UPGRADE_CAR_COST then
        State.plasma_coins = State.plasma_coins - UPGRADE_CAR_COST
        State.owned_upgrade_cars[car_index] = true
        State.equipped_car_index = car_index
        State.premium_message = "CAR " .. car_index .. " UNLOCKED"
        State.premium_message_timer = 0.8
        effect.flash(0.14, gfx.COLOR_GREEN)
      else
        State.plasma_coins = State.plasma_coins + PLASMA_PURCHASE_AMOUNT
        State.premium_message = "PAID MONEY: +" .. PLASMA_PURCHASE_AMOUNT
          .. " PLASMA"
        State.premium_message_timer = 0.8
        effect.flash(0.1, gfx.COLOR_PINK)
      end
    end
  end

  if input.key_pressed(input.KEY_4) then
    State.mode = "title"
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
      if obstacle.kind == "prestige_car" then
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

  if State.mode == "title" then
    update_scrolling(dt)

    if input.key_pressed(input.KEY_4) then
      State.mode = "playing"
    elseif input.key_pressed(input.KEY_5) then
      State.mode = "settings"
    elseif language_pick_pressed() then
      cycle_language()
    end

    return
  end

  if State.mode == "settings" then
    update_scrolling(dt)
    update_settings_screen(dt)
    return
  end

  if State.mode == "game_over" then
    if input.pressed(input.BTN1) then
      restart_level()
    end

    return
  end

  if State.mode == "level_complete" then
    if State.level == MAX_LEVEL then
      if input.pressed(input.BTN1) then
        choose_prestige_reward()
      elseif input.pressed(input.BTN2) then
        choose_coach_reward()
      elseif input.pressed(input.BTN3) then
        choose_city_reward()
      elseif input.key_pressed(input.KEY_4) then
        choose_obby_reward()
      end
    elseif input.pressed(input.BTN1) then
      start_next_level()
    end

    return
  end

  update_scrolling(dt)
  update_player(dt)
  update_banana_item(dt)
  update_premium_shop(dt)
  update_pickups(dt)
  update_obstacles(dt)

  if State.mode == "playing" then
    update_level_progress(dt)
  end
end

function _draw(_dt)
  ensure_state()

  gfx.clear(gfx.COLOR_BLACK)
  draw_current_background()

  if State.endgame_path == "city" then
    draw_city_teleport_overlay()
  end

  draw_road()
  draw_pickups()
  draw_obstacles()
  draw_player_car()

  if State.mode ~= "title" and State.mode ~= "settings" then
    draw_hud()
  end

  draw_overlay()
end
