shader_type spatial;
render_mode unshaded;

uniform sampler2D albedo_texture : filter_nearest;

void fragment() {
    vec3 color = texture(albedo_texture, UV).rgb;
    ALBEDO = color;
}