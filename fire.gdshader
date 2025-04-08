shader_type spatial;
render_mode unshaded, cull_disabled;

uniform vec4 fire_color = vec4(1.0, 0.4, 0.0, 1.0); // Fire color (orange)
uniform float fire_intensity = 2.0;
uniform float fire_speed = 1.5;
uniform float fire_distortion = 2.5;
uniform sampler2D noise_texture; // Assign a noise texture in material settings

void fragment() {
    // Edge detection using view normals
    float edge_mask = dot(NORMAL, VIEW);
    edge_mask = smoothstep(0.4, 0.7, edge_mask); // Adjust fire width

    // Fire effect animation using noise texture
    vec2 uv = UV + vec2(0.0, TIME * fire_speed); // Move texture upwards based on time
    uv.y += TIME * fire_speed; // Vertical movement, giving upward flow

    // Apply noise texture distortion
    float noise_value = texture(noise_texture, uv * fire_distortion).r;

    // Apply fire effect only to the outline
    float fire_effect = edge_mask * noise_value * fire_intensity;

    // Final output
    ALBEDO = mix(vec3(0.0), fire_color.rgb, fire_effect); // Fire on edges, rest transparent
    EMISSION = fire_color.rgb * fire_effect * 2.0; // Glow effect
    ALPHA = fire_effect; // Makes non-fire areas transparent
}
