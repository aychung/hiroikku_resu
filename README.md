# Hiroikku Resu

A prototype 2D obstacle-dodge driving game built with
[Usagi](https://usagiengine.com/) in Lua.

The game concept is simple: the player controls a blue pixel car near the
bottom of the screen while a space road scrolls downward to simulate forward
motion. Obstacles will enter from the top of the screen, and the player will
dodge them while clearing levels, collecting coins on some roads, and spending
coins on a banana item.

## Status

The current prototype has:

- A simple blue pixel car positioned near the bottom of the screen.
- Left/right/up/down car movement clamped to the road bounds and driving area.
- A vertical road with curbs and dashed yellow lane markers.
- A space background with scrolling stars and strange planets.
- Spawned traffic cars, children, and box obstacles with forgiving rectangular
  hitboxes.
- Rare green traffic cars, capped at two spawns per level.
- Level progress, level-complete flow, game-over flow, and restart.
- A level-100 reward choice: gain prestige, become coach, teleport to a city,
  or start a harder obby run.
- A top-screen speed readout showing the current road speed.
- Coin pickups on selected levels, currently every third level.
- A persistent coin wallet across level changes and level restarts.
- A banana item that costs 67 coins and clears current obstacles when used.
- Plasma coins as a prototype paid currency and a gold car skin that costs 456
  plasma coins.
- A start screen that begins the game with keyboard `4`.
- A start-screen settings panel with car, background, and music pages.
- Background choices: space and void free, people cheering for 1345 plasma
  coins, and village for 20 coins.
- Language cycling from the start screen with almost any key, button, or mouse
  click across Japanese, Korean, English, Spanish, Chinese, and Russian.

## Requirements

- [Usagi Engine](https://usagiengine.com/)
- Lua support is provided by Usagi.

Install Usagi by following the official installation instructions:

```sh
curl -fsSL https://usagiengine.com/install.sh | sh
```

On Windows, use the PowerShell installer from the Usagi docs.

## Running The Game

From the project root:

```sh
usagi dev
```

This starts Usagi's live-reload development mode.

To run without live reload:

```sh
usagi run
```

Controls:

- `input.KEY_4` starts the game from the start screen.
- `input.KEY_5` opens settings from the start screen.
- Almost any key, action button, arrow direction, or mouse click cycles the UI
  language from the start screen, except the start/settings keys.
- In settings, `input.UP` / `input.DOWN` switch car/background/music pages.
- On the car/background pages, `input.LEFT` / `input.RIGHT` pick an option,
  `input.BTN3` buys/equips it, and `input.KEY_4` returns to the start screen.
- `input.LEFT` / `input.RIGHT` move the car horizontally.
- `input.UP` / `input.DOWN` move the car vertically within the driving area.
- `input.BTN1` restarts after a crash or advances after level completion.
- `input.BTN2` buys and uses the banana item when you have at least 67 coins.
- `input.BTN3` simulates buying plasma coins, then buys the gold car once you
  have at least 456 plasma coins.
- After level 100, choose `input.BTN1` for prestige, `input.BTN2` for coach,
  `input.BTN3` for city teleport, or `input.KEY_4` for harder obby.

On keyboard, use the mappings configured by Usagi for those abstract actions.

## Project Layout

```text
.
├── main.lua        # Game entry point
├── USAGI.md        # Local copy of Usagi documentation
├── meta/usagi.lua  # Lua language-server stubs for the Usagi API
├── AGENTS.md       # Project guidance for coding agents
└── README.md
```

## Development Notes

- Keep gameplay code in `main.lua` while the prototype is small.
- Use Usagi callbacks: `_config`, `_init`, `_update`, and `_draw`.
- Store mutable cross-frame state in `State`.
- Use 2-space indentation and `snake_case` for Lua locals/functions.
- Prefer Usagi's built-in drawing primitives until sprites are needed.
- Keep road markings and space scenery readable at speed unless there is a
  deliberate gameplay reason to separate them.
- Japanese, Korean, and Chinese text require a CJK-capable `font.png`; the
  bundled Usagi font does not include those glyphs.

## Verification

Syntax check:

```sh
luac -p main.lua
```

Runtime check:

```sh
usagi run
```

In a headless environment without a display, `usagi run` may fail while opening
the window with an X11/GLFW display error. In that case, verify with `luac -p`
and run the game again in a graphical session.

## Export

When the prototype is ready to package:

```sh
usagi export
```

Usagi can export builds for desktop platforms and the web.
