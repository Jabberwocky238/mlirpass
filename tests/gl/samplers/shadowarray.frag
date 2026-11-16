#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 5) uniform highp sampler2DArrayShadow u_tex;
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 2.0 - 0.3;
    vec3 dir = normalize(vec3(uv * 2.0 - 1.0, 0.6 - uv.x));
    float a = texture(u_tex, vec4(uv, 1.0, 0.5)); float b = texture(u_tex, vec4(uv.yx, 2.0, uv.x)); ivec3 s = textureSize(u_tex, 0); o_color = vec4(a, b, vec2(s.xz) * 0.01);
}
