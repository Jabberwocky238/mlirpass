#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;

float scale(float x);
float scale(float x) { return x * 1.5 + 0.25; }
vec2 scale(vec2 v) { return v * 0.75 - 0.125; }
int scale(int k) { return k * 3 + 1; }

void split(float x, out float whole, out float part) {
    whole = floor(x);
    part = x - whole;
}

void accumulate(inout vec3 acc, vec3 v, float w) {
    acc += v * w;
}

bool clampTo(inout float x, float lo, float hi) {
    if (x < lo) { x = lo; return true; }
    if (x > hi) { x = hi; return true; }
    return false;
}

void main() {
    vec2 c = gl_FragCoord.xy;
    float w, p;
    split(c.x * 0.37, w, p);
    vec3 acc = vec3(0.0);
    for (int i = 0; i < 3; i++) {
        accumulate(acc, vec3(c, float(i)), 0.1 * float(scale(i)));
    }
    vec4 o = vec4(scale(c.y * 0.01), scale(v_uv), 0.0);
    split(c.y * 0.21, o.z, o.w);
    float t = c.x * 0.05 - 1.0;
    bool hit = clampTo(t, -0.5, 0.5);
    float arr[3];
    arr[0] = 0.0;
    arr[1] = 0.0;
    arr[2] = 0.0;
    split(c.x * 0.11, arr[1], arr[int(c.y) % 2 * 2]);
    o_color = vec4(w + p + acc.x, acc.y + o.x + o.y, acc.z + o.z + o.w + t + (hit ? 1.0 : 0.0), arr[0] + arr[1] + arr[2]);
}
