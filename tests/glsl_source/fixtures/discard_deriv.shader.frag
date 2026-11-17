#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
void main() {
    vec2 c = gl_FragCoord.xy;
    if (mod(c.x + c.y, 5.0) < 1.0) discard;
    vec2 d = vec2(dFdx(v_uv.x * v_uv.x * 50.0), dFdy(v_uv.y * c.x));
    float w = fwidth(c.x * c.y * 0.01);
    o_color = vec4(d * 64.0, w, 1.0);
}
