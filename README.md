# Hiroikku Resu

A prototype 2D obstacle-dodge driving game built with
[Usagi](https://usagiengine.com/) in Lua.

The game concept is simple: the player controls a car near the bottom of the
screen while road scenery scrolls downward to simulate forward motion. Obstacles
enter from the top of the screen, and the player dodges them for as long as
possible.

## Status

Early prototype. The repository currently contains the initial Usagi project
stub and planning notes for the driving game loop.

Planned first playable loop:

- Move a car left and right near the bottom of the screen.
- Scroll the road/background downward.
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

## Export

When the prototype is ready to package:

```sh
usagi export
```

Usagi can export builds for desktop platforms and the web.
