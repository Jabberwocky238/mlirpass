#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 0) uniform highp sampler2D u_tex;
const ivec2 SHIFT = ivec2(2, -3);
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 3.0 - 0.25;
    o_color = textureLodOffset(u_tex, uv, 1.25, ivec2(-1, 3));
}
