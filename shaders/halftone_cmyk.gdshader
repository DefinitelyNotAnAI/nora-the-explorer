// Halftone CMYK post-process shader.
// Adapted from the MIT-licensed "Halftone CMYK Shader" (Godot Shaders community),
// https://godotshaders.com/shader/halftone-cmyk-shader/ — halftone technique credited
// there to Stefan Gustavson. See also https://github.com/sweepline/godot_halftone.
//
// Usage: apply as the material on a full-screen ColorRect inside a CanvasLayer
// (see scenes/PostProcess.tscn) so it reads SCREEN_TEXTURE and overlays every room.
shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform float radius_c = 0.2;
uniform float radius_m = -0.3;
uniform float radius_y = 0.0;
uniform float radius_k = 0.785;

// Dot pitch in screen pixels is roughly viewport_width / frequency — the
// original tutorial's default (400) works out to a ~3px pitch at our
// resolution, which reads as noise rather than visible dots. Tuned for a
// bold, clearly-readable newsprint-style dot at ~1152px viewport width.
uniform float frequency = 60.0;

mat2 rotate(float r) {
	float c = cos(r);
	float s = sin(r);
	return mat2(
		vec2(c, s),
		vec2(-s, c)
	);
}

float halftone_channel(float value, vec2 uv, float radius) {
	return smoothstep(-1.0, 1.0, sqrt(value) - length(2.0 * fract(rotate(radius) * (frequency * uv)) - 1.0));
}

void fragment() {
	vec3 color = texture(screen_texture, SCREEN_UV).rgb;
	vec4 cmyk = vec4(vec3(1.0) - color, 1.0 - max(max(color.r, color.g), color.b));
	cmyk.xyz -= cmyk.w;

	float k = halftone_channel(cmyk.w, UV, radius_k);
	float c = halftone_channel(cmyk.x, UV, radius_c);
	float m = halftone_channel(cmyk.y, UV, radius_m);
	float y = halftone_channel(cmyk.z, UV, radius_y);

	vec3 new_color = mix(vec3(1.0) - 0.9 * vec3(c, m, y), vec3(0.0), 0.85 * k);

	COLOR = vec4(new_color, 1.0);
}
