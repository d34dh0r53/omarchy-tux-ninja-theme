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
- `kitty/tux-ninja.conf` — kitty color theme, apply with
  `kitten themes tux-ninja` (copy to `~/.config/kitty/themes/`)
- `kitty/shaders/` — optional neon text-glow shader for kitty (see below)

## Neon glow

Kitty gets a neon text-glow via a custom slang shader (requires kitty ≥ 0.49
and the `shader-slang` package for the `slangc` compiler):

```bash
sudo pacman -S --noconfirm shader-slang
mkdir -p ~/.config/kitty/shaders
cp -r ~/.config/omarchy/themes/tux-ninja/kitty/shaders/* ~/.config/kitty/shaders/
printf '\ncustom_shaders tux-glow\n' >> ~/.config/kitty/kitty.conf
```

Then restart kitty. The shader matches pixels against the theme's named
palette colors (the same names/hexes as starship.toml and colors.toml) and
gives each color its own glow. Colors currently glowing: red, cyan, the
magenta accents (fastfetch omarchy logo, starship prompt), and a faint halo
on bright text.

Each color's glow is configured in `glow-colors.toml` — one section per
palette color with `hex`, `strength` (0 = off) and `radius`:

```toml
[colors.accent]
hex = "#BC50A0"
strength = 0.35
radius = 2.2
```

After editing it, regenerate and reload:

```bash
python3 ~/.config/kitty/shaders/generate-glow.py
```

Fine-tuning strengths/radii without regenerating is also possible directly in
`~/.config/kitty/shaders/tux-glow.pipeline` (the generator bakes the TOML
values there as `var` overrides). `[settings] tolerance` in the TOML
controls how close a pixel must be to a named color to count as it. The
effect is static (`animation_step 0`), so it only redraws when terminal
content changes — no idle CPU cost.

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
