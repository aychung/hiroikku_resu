# Hiroikku Resu

A prototype 2D obstacle-dodge driving game built with
[Usagi](https://usagiengine.com/) in Lua.

The game concept is simple: the player controls a blue pixel car near the
bottom of the screen while a city road scrolls downward to simulate forward
motion. Obstacles will enter from the top of the screen, and the player will
dodge them while clearing levels, collecting coins on some roads, and spending
coins on a banana item.

## Status

The current prototype has:

- A simple blue pixel car positioned near the bottom of the screen.
- Left/right/up/down car movement clamped to the road bounds and driving area.
- A vertical road with curbs and dashed yellow lane markers.
- City buildings on both sides of the road.
- Synchronized road and city scrolling through the current world speed.
- Stable building window patterns, so windows do not flicker while scrolling.
- Spawned traffic cars and box obstacles with forgiving rectangular hitboxes.
- Level progress, level-complete flow, game-over flow, and restart.
- Coin pickups on selected levels, currently every third level.
- A persistent coin wallet across level changes and level restarts.
- A banana item that costs 67 coins and clears current obstacles when used.

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

- `input.LEFT` / `input.RIGHT` move the car horizontally.
- `input.UP` / `input.DOWN` move the car vertically within the driving area.
- `input.BTN1` restarts after a crash or advances after level completion.
- `input.BTN2` buys and uses the banana item when you have at least 67 coins.

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
- Keep road markings and city scenery on the same scroll speed unless there is a
  deliberate gameplay reason to separate them.
- Building window patterns should be based on stable building-local data, not
  current screen coordinates, to avoid flicker during scrolling.

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
