#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(binding = 4) uniform highp samplerCubeShadow u_tex;
void main() {
    vec2 c = gl_FragCoord.xy;
    vec2 uv = v_uv * 2.0 - 0.3;
    vec3 dir = normalize(vec3(uv * 2.0 - 1.0, 0.6 - uv.x));
    float a = texture(u_tex, vec4(dir, 0.5)); float b = texture(u_tex, vec4(dir.yzx, uv.x)); o_color = vec4(a, b, a * b, 1.0);
}
