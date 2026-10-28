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

Then restart kitty. The shader applies one color-agnostic glow: any pixel
perceptually distinct from the background glows in its own color, scaled by
its saturation — saturated accents bloom while white and pink text keep only
a faint halo. Distance and saturation are measured in gamma-2 (sqrt) space
with luma weighting, which is perceptually even across hues and cheap
enough for integrated GPUs at 4K.

The glow is configured in `glow-colors.toml`:

```toml
[settings]
strength = 0.08          # overall glow intensity
radius = 2.0             # halo spread, ~1 tight … ~2.2 wide soft neon
white_suppression = 0.85 # 0 = whites glow equally, 1 = whites never glow
chroma_gain = 4.0        # how fast saturation earns the full glow
```

After editing it, regenerate and reload:

```bash
python3 ~/.config/kitty/shaders/generate-glow.py
```

Fine-tuning without regenerating is also possible directly in
`~/.config/kitty/shaders/tux-glow.pipeline` (the generator bakes the TOML
values there as `var` overrides). The effect is static (`animation_step 0`),
so it only redraws when terminal content changes — no idle CPU cost.

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
      offset = "0 0",
    },
  },
})
```

## License

Wallpaper is the original `tux-ninja-4k-3840x2160.jpg` this theme was built
around; theme files are provided as-is for personal use.
