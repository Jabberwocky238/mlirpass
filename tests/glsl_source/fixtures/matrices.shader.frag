#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(std140, binding = 0) uniform M { mat4 a; mat4 b; mat3 c; } m;
void main() {
    vec4 p = vec4(v_uv, v_uv.x * v_uv.y, 1.0);
    mat4 ab = m.a * m.b;
    mat4 h = m.a * 0.5;
    vec4 r = ab * p + p * m.a + h * p;
    vec3 q = m.c * p.xyz + p.zyx * m.c;
    o_color = r + vec4(q, 0.0);
}
