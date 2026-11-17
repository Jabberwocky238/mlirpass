#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 0) uniform highp sampler2D u_tex;
const ivec2 SHIFT = ivec2(2, -3);
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 3.0 - 0.25;
    ivec2 s0 = textureSize(u_tex, 0); ivec2 s2 = textureSize(u_tex, 2); o_color = vec4(vec2(s0) * 0.01 + uv, vec2(s2));
}
