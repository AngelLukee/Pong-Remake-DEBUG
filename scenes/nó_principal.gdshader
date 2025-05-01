shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Aumenta o brilho
    COLOR = tex_color + vec4(0.3, 0.3, 0.3, 0.0);
}
