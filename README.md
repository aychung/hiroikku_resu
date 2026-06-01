# Hiroikku Resu

A prototype 2D obstacle-dodge driving game built with
[Usagi](https://usagiengine.com/) in Lua.

The game concept is simple: the player controls a blue pixel car near the
bottom of the screen while a city road scrolls downward to simulate forward
motion. Obstacles will enter from the top of the screen, and the player will
dodge them for as long as possible.

## Status

Initialized prototype. The current build has:

- A simple blue pixel car positioned near the bottom of the screen.
- Left/right car movement clamped to the road bounds.
- A vertical road with curbs and dashed yellow lane markers.
- City buildings on both sides of the road.
- Synchronized road and city scrolling through a shared `WORLD_SPEED` constant.
- Stable building window patterns, so windows do not flicker while scrolling.

Planned next playable-loop work:

- Spawn obstacles from the top.
- Detect collisions with simple rectangular hitboxes.
- Show game-over and restart flow.

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

- Left/right actions move the car horizontally. On keyboard, use the mappings
  configured by Usagi for `input.LEFT` and `input.RIGHT`.

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
