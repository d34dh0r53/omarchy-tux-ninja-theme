# Tux Ninja — an Omarchy theme

A dark synthwave theme for [Omarchy](https://omarchy.org/), built around a
midnight-navy / cyan / violet palette with a Tux ninja wallpaper.

## Install

```bash
omarchy theme install https://github.com/d34dh0r53/omarchy-tux-ninja-theme.git
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
- `kitty/tux-ninja.conf` — reference copy of the kitty colors Omarchy generates
  from `colors.toml` (don't install it via `kitten themes` — that creates a
  stale `current-theme.conf` in `~/.config/kitty/` that overrides Omarchy's
  generated colors when the theme changes)

This theme ships only colors, wallpaper, and icons — no scripts, shaders, or
build tools, per Omarchy's theme rules.

## Neon glow (optional)

The neon text-glow shader for Kitty and Ghostty, the Hyprland window-glow
shadow, and the generator that builds them live in a companion repo:
[d34dh0r53/omarchy-tux-ninja-plugins](https://github.com/d34dh0r53/omarchy-tux-ninja-plugins).

```bash
git clone https://github.com/d34dh0r53/omarchy-tux-ninja-plugins.git
cd omarchy-tux-ninja-plugins
./install.sh
```

## License

The wallpaper in `backgrounds/` is the original 4K tux-ninja artwork this
theme was built around; theme files are provided as-is for personal use.
