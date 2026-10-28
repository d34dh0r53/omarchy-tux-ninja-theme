# Tux Ninja — an Omarchy theme

A dark synthwave theme for [Omarchy](https://omarchy.org/), built around a
midnight-navy / violet / hot-magenta palette with a Tux ninja wallpaper.

## Install

```bash
omarchy theme install https://github.com/d34dh0r53/tux-ninja-theme.git
```

This clones the theme into `~/.config/omarchy/themes/tux-ninja` and applies it.
You can also switch to it later with:

```bash
omarchy theme set tux-ninja
```

## Contents

- `colors.toml` — the palette; Omarchy renders terminal, editor, and shell
  colors from this file
- `backgrounds/1-tux-ninja.jpg` — 4K wallpaper
- `icons.theme` — Yaru purple-dark icon set
- `preview.png` — theme preview thumbnail
- `kitty/` — optional neon glow extras for kitty (see below)

## Neon glow

Kitty gets a magenta glow around the active window border and the OS window
edges via a custom slang shader (kitty ≥ 0.49). Omarchy regenerates kitty's
config from `colors.toml` when applying a theme, so enable it once by hand:

```bash
mkdir -p ~/.config/kitty/shaders
cp -r ~/.config/omarchy/themes/tux-ninja/kitty/shaders/* ~/.config/kitty/shaders/
echo 'custom_shaders tux-glow' >> ~/.config/kitty/kitty.conf
```

Then restart kitty (or `omarchy restart terminal`). Tune the look by editing
the `GLOW_*` constants at the top of `~/.config/kitty/shaders/tux-glow.slang`
(width, strength, and color).

To glow the outside of every window on the desktop, add a magenta Hyprland
shadow with zero offset to `~/.config/hypr/` (e.g. in `looknfeel.lua`):

```lua
hl.config({
  decoration = {
    shadow = {
      enabled = true,
      range = 20,
      render_power = 4,
      color = "rgba(bc50a05c)",
      offset = "0x0",
    },
  },
})
```

## License

Wallpaper is the original `tux-ninja-4k-3840x2160.jpg` this theme was built
around; theme files are provided as-is for personal use.
