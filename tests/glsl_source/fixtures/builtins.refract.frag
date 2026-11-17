#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
void main() {
    vec2 c = gl_FragCoord.xy;
    float x = (c.x - 32.0) / 13.0;
    float y = c.y / 64.0 + 0.01;
    float z = (c.x * c.y - 1500.0) / 700.0;
    vec3 a = vec3(x, y, z);
    vec3 b = vec3(y - 0.5, z * 0.3, x * 0.7);
    mat2 m2 = mat2(x, y, z, x * y + 1.5);
    mat3 m3 = mat3(x, y, z, 1.0 + y, z * 0.5, x - 0.25, y * z, 0.5, 1.25);
    mat4 m4 = mat4(m3) + mat4(0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5);
    o_color = vec4(refract(normalize(a), normalize(b), y), 0.0);
}
