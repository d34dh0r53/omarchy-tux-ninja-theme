#language slang 2026
// Tux Ninja — neon magenta glow around the active window border and the
// outer edges of the kitty OS window.
//
// Enable with `custom_shaders tux-glow` in kitty.conf (kitty >= 0.49).
// Colors are in linear RGB; GLOW_COLOR below is #E06FB6 (bright magenta)
// converted to linear.

import kitty_custom_shader_types;

// Tunables — override from a pipeline file without editing this shader.
static const float3 GLOW_COLOR = float3(0.7489, 0.1591, 0.4678);
static const float GLOW_WIDTH_PX = 16.0;  // glow falloff radius in pixels
static const float GLOW_STRENGTH = 0.55;  // peak additive intensity

// Signed distance from point p to the border of rect (xy = lower-left
// corner, zw = width/height), all in pixels. Negative inside the rect.
float
border_distance(float2 p, float4 rect) {
    float2 half_size = rect.zw * 0.5;
    float2 q = abs(p - (rect.xy + half_size)) - half_size;
    float outside = length(max(q, float2(0.f)));
    float inside = min(max(q.x, q.y), 0.f);
    return outside + inside;
}

// Exponential falloff glow around a rect border, in pixels.
float
glow(float2 p, float4 rect) {
    float d = border_distance(p, rect);
    return exp(-abs(d) / (GLOW_WIDTH_PX / 4.0)) * GLOW_STRENGTH;
}

public float4
fragment_main(float4 color, KittyTextures t, KittyCustomShaderData d) {
    float2 vp = float2(d.viewport_size_pixels);
    float2 p = t.pos * vp;

    float g = 0.0;

    // Glow around the active window, so kitty's own window borders
    // (window_border_width) light up magenta. All geometry is in UV
    // coordinates; convert to pixels.
    float4 w = d.active_window_geometry;
    if (w.z > 0.0 && w.w > 0.0) {
        float4 rect = float4(w.xy * vp, w.zw * vp);
        // Grow the rect to cover the window's border/margin/padding so the
        // glow is centered on the drawn border, not the cell area.
        float2 pad_lo = d.active_window_padding.xy * vp;
        float2 pad_hi = d.active_window_padding.zw * vp;
        rect = float4(rect.xy - pad_lo, rect.zw + pad_lo + pad_hi);
        g += glow(p, rect);
    }

    // Glow around the outer edge of the whole OS window (inside the
    // viewport, so it reads as a neon frame on the wall too).
    g += glow(p, float4(0.f, 0.f, vp.x, vp.y));

    if (g > 0.001) {
        color.rgb += GLOW_COLOR * g;
    }
    return color;
}
