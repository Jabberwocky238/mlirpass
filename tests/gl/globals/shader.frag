#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
struct Acc { float sum; int n; };
float g_scale = 1.5;
vec3 g_bias = vec3(0.1, -0.2, 0.3);
float g_samples[3];
Acc g_acc = Acc(0.0, 0);
float later();
void add(float v) {
    g_acc.sum += v * g_scale;
    g_acc.n += 1;
}
void main() {
    vec2 c = gl_FragCoord.xy;
    g_samples[0] = c.x * 0.01;
    g_samples[1] = c.y * 0.02;
    g_samples[2] = g_samples[0] + g_samples[1];
    for (int i = 0; i < 3; i++) {
        add(g_samples[i]);
    }
    g_scale = 0.25;
    add(1.0);
    o_color = vec4(g_acc.sum, float(g_acc.n) * 0.1, later(), g_bias.y + g_scale);
}
float g_late = 2.5;
float later() { return g_late * g_bias.x; }
