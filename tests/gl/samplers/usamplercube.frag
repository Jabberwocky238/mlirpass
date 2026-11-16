#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 10) uniform highp usamplerCube u_tex;
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 2.0 - 0.3;
    vec3 dir = normalize(vec3(uv * 2.0 - 1.0, 0.6 - uv.x));
    uvec4 a = texture(u_tex, dir); o_color = vec4(a) / 255.0;
}
