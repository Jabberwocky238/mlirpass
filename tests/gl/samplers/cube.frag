#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 1) uniform highp samplerCube u_tex;
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 2.0 - 0.3;
    vec3 dir = normalize(vec3(uv * 2.0 - 1.0, 0.6 - uv.x));
    vec4 a = texture(u_tex, dir); vec4 b = textureLod(u_tex, dir.zxy, 2.2); ivec2 s = textureSize(u_tex, 0); o_color = a + b * 0.5 + vec4(vec2(s), 0.0, 0.0) * 0.01;
}
