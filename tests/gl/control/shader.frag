#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
float wave(float x, float k) { return sin(x * k) * 0.5 + 0.5; }
void main() {
    vec2 c = gl_FragCoord.xy;
    float acc = 0.0;
    for (int i = 0; i < 6; i++) {
        acc += wave(c.x + float(i), 0.05 * float(i + 1));
    }
    vec3 col;
    if (c.x > c.y) {
        col = vec3(acc, c.x / 64.0, 0.25);
    } else {
        col = vec3(c.y / 64.0, acc * 0.5, 0.75);
    }
    int k = 0;
    float t = c.y;
    while (t > 1.0 && k < 10) {
        t *= 0.5;
        k++;
    }
    o_color = vec4(col, float(k) + fract(t));
}
