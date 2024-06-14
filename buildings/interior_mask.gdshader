shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform vec2 size;

void fragment() {
    COLOR = texture(screen_texture, SCREEN_UV);
    
    vec2 uv = UV;
    vec2 suv = abs(uv * 2.0 - 1.0);
    vec2 u = vec2(size * TEXTURE_PIXEL_SIZE);
    u = smoothstep(vec2(0), u, 1.0 - suv);
    COLOR.a = u.x * u.y;
}
