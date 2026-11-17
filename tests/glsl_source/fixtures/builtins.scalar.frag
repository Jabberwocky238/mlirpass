#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
void main() {
    vec2 c = gl_FragCoord.xy;
    float x = (c.x - 32.0) / 13.0;
    float y = c.y / 64.0 - 0.4;
    o_color = vec4(normalize(x) + length(y), distance(x, y), dot(x, y) + length(-2.5) + distance(1.25, -0.5), normalize(-0.75) * dot(0.3, 0.7));
}
