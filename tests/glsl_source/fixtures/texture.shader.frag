#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 2) uniform highp sampler2D u_tex;
void main() {
    vec4 t = texture(u_tex, v_uv * 3.0);
    vec4 l = textureLod(u_tex, v_uv, 1.5);
    vec4 b = texture(u_tex, v_uv * 2.0, 0.5);
    vec4 f = texelFetch(u_tex, ivec2(gl_FragCoord.xy) / 8, 1);
    o_color = t + l * 0.25 + b * 0.125 + f * 0.5;
}
