shader_type canvas_item;

void fragment() {
    // Coordenadas locais do fragmento no retângulo (0 a 1)
    vec2 uv = UV;

    // Centro do retângulo
    vec2 center = vec2(0.5, 0.5);

    // Distância do pixel até o centro
    float dist = distance(uv, center);

    // Brilho mais intenso no centro, suave nas bordas
    float glow = smoothstep(0.5, 0.3, dist); // maior o 0.5, maior o brilho

    // Cor base + brilho simulado
    vec3 color = vec3(1.0) * glow * 3.0;

    COLOR = vec4(color, glow); // brilho mais visível nas bordas
}
