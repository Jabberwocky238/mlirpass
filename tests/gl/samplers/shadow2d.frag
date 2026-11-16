#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 3) uniform highp sampler2DShadow u_tex;
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 2.0 - 0.3;
    vec3 dir = normalize(vec3(uv * 2.0 - 1.0, 0.6 - uv.x));
    float a = texture(u_tex, vec3(uv, 0.5)); float b = textureProj(u_tex, vec4(uv * 1.3, uv.x, 1.3)); float o = textureOffset(u_tex, vec3(uv, 0.4), ivec2(-1, 2)); float l = textureLod(u_tex, vec3(uv, 0.6), 0.0); float g = textureGrad(u_tex, vec3(uv, 0.45), vec2(0.03, 0.0), vec2(0.0, 0.02)); o_color = vec4(a, b, o + l, g);
}
