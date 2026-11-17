#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 2) uniform highp sampler2DArray u_tex;
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 2.0 - 0.3;
    vec3 dir = normalize(vec3(uv * 2.0 - 1.0, 0.6 - uv.x));
    vec4 a = texture(u_tex, vec3(uv, 2.2)); vec4 b = textureLod(u_tex, vec3(uv, uv.y * 3.0), 0.8); vec4 o = textureOffset(u_tex, vec3(uv, 1.0), ivec2(2, -1)); vec4 f = texelFetch(u_tex, ivec3(ivec2(c) / 4, 3), 0); ivec3 s = textureSize(u_tex, 2); o_color = a + b * 0.5 + o * 0.25 + f * 0.125 + vec4(vec3(s), 0.0) * 0.01;
}
