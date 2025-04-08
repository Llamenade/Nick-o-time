shader_type spatial;
render_mode unshaded, cull_disabled;

uniform vec4 sand_color = vec4(0.8, 0.7, 0.5, 1.0); // Sand color (dust)
uniform float sand_intensity = 1.0; // Intensity of the sandstorm
uniform float sand_speed = 0.8; // Speed of the sand movement
uniform float sand_distortion = 2.5; // How distorted the sand moves
uniform sampler2D noise_texture; // The noise texture used for distortion

void fragment() {
    // Edge detection based on the view normals to enhance the effect at edges
    float edge_mask = dot(NORMAL, VIEW);
    edge_mask = smoothstep(0.4, 0.7, edge_mask); // Adjust the width of the edge mask

    // Apply time-based movement to the texture for the sandstorm effect (left to right)
    vec2 uv = UV + vec2(TIME * sand_speed, 0.0); // Move the texture left to right
    uv.x += TIME * sand_speed;

    // Apply noise texture distortion to simulate sand movement
    float noise_value = texture(noise_texture, uv * sand_distortion).r;

    // Calculate the sandstorm effect
    float sand_effect = edge_mask * noise_value * sand_intensity;

    // Final output: Mix the sand color with the original surface
    ALBEDO = mix(vec3(0.0), sand_color.rgb, sand_effect); // Color the sandstorm effect
    ALPHA = sand_effect; // Transparency based on the effect strength
}
