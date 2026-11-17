#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;

float firstOver(float x, float limit) {
    for (int i = 0; i < 32; i++) {
        float v = x * float(i) * 0.37;
        if (v > limit) return v;
    }
    return -1.0;
}

float classify(float x) {
    if (x < 10.0) return 0.25;
    if (x < 30.0) {
        return 0.5;
    }
    return x / 64.0;
}

void main() {
    vec2 c = gl_FragCoord.xy;
    float a = 0.0;
    for (int i = 0; i < 20; i++) {
        if (float(i) * 3.0 > c.x) break;
        a += sin(float(i) + c.y * 0.1);
    }
    float b = 0.0;
    int k = 0;
    while (k < 16) {
        k++;
        if (k % 3 == 0) continue;
        b += float(k) * 0.125;
    }
    float n = 0.0;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (j > i) break;
            if ((i + j) % 2 == 1) continue;
            n += 1.0;
        }
    }
    float d = 0.0;
    int m = 0;
    do {
        m++;
        if (m == 2) continue;
        d += c.x * 0.01;
    } while (m < 5);
    float e = 0.0;
    for (int i = 0; i < 16; i++) {
        if (i == int(c.x) % 7 + 3) break;
        e += float(i) * 0.5;
    }
    if (c.y < 4.0) {
        o_color = vec4(1.0, 0.0, 0.5, 1.0);
        return;
    }
    o_color = vec4(a + firstOver(c.x, 20.0), b + n, d + classify(c.y), fract(a * b) + e);
}
