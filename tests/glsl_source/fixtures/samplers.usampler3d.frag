#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 8) uniform highp usampler3D u_tex;
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 2.0 - 0.3;
    vec3 dir = normalize(vec3(uv * 2.0 - 1.0, 0.6 - uv.x));
    uvec4 a = texture(u_tex, vec3(uv, 0.4)); uvec4 f = texelFetch(u_tex, ivec3(ivec2(c) / 8, 1), 0); o_color = vec4(a + f) / 510.0;
}
