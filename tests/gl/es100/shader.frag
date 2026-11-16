#version 100
precision highp float;
varying float v_k;
varying vec2 v_uv;
uniform vec4 u_tint;
uniform float u_gain;
uniform sampler2D u_tex;
const float SCALE = 2.0;

vec3 shade(vec3 c, float k) {
    return c * k + vec3(0.125, 0.25, 0.375);
}

void main() {
    vec4 t = texture2D(u_tex, v_uv * SCALE);
    vec4 c = vec4(v_uv, v_k, 1.0) * u_tint * u_gain + t * 0.5;
    float acc = 0.0;
    for (int i = 0; i < 4; i++) {
        acc += c.x * float(i);
    }
    if (c.x > 1.5) {
        c.y = 0.0;
    }
    c.xz = c.zx;
    gl_FragColor = vec4(shade(c.rgb, acc), c.a);
}
