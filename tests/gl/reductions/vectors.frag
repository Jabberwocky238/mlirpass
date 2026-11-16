#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
void main() {
    vec2 c = gl_FragCoord.xy;
    float a = c.x * 1234.567;
    float b = c.y * 0.000731;
    float d = sin(c.x) * 77.7;
    float e = c.x * c.y * 0.37;
    float f = cos(c.y) * 0.0123;
    float arr[2];
    arr[0] = e;
    arr[1] = f;
    vec3 u = vec3(a, b, d);
    vec3 w = vec3(e, f, a);
    vec3 z = vec3(d, e, b);
    vec3 r = u + w + z + u * 0.25 + w;
    vec3 s = u + w + z + w + u;
    o_color = vec4(r.x + s.y, r.y, s.z, r.z);
}
