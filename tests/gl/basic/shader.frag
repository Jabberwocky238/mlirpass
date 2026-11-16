#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
void main() {
    vec2 c = gl_FragCoord.xy;
    float a = sin(c.x * 0.1) * pow(v_uv.y + 1.0, 1.5);
    float b = mix(c.x, c.y, 0.25) / (c.y + 3.0);
    float s = smoothstep(10.0, 50.0, c.x);
    o_color = vec4(a, b, s, fract(c.x * c.y / 7.0));
}
