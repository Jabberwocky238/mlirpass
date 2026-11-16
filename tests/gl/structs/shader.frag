#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
struct Light { vec3 dir; float k; vec2 pad[2]; };
struct Scene { Light key; Light fill; int count; };
Light make(vec3 d, float k) { return Light(d, k, vec2[2](vec2(k), d.xy)); }
float shade(Light l, vec3 n) { return max(dot(l.dir, n), 0.0) * l.k + l.pad[1].y; }
void dim(inout Light l, float f) { l.k *= f; l.pad[0].x -= f; }
void main() {
    vec2 c = gl_FragCoord.xy;
    vec3 n = normalize(vec3(v_uv - 0.5, 0.7));
    Light a = make(normalize(vec3(0.3, 0.5, 0.8)), 1.25);
    Light b = a;
    b.dir.z = -b.dir.z;
    b.pad[1].y = c.x * 0.01;
    dim(b, 0.5);
    Scene s = Scene(a, b, 2);
    Light ls[3];
    ls[0] = a; ls[1] = b; ls[2] = make(n.zyx, 0.3);
    int i = int(c.y) % 3;
    float sum = shade(s.key, n) + shade(s.fill, n) + shade(ls[i], n);
    bool same = a == s.key && !(a == b) && b != ls[0];
    o_color = vec4(sum, s.fill.k + s.fill.pad[0].x, float(s.count) * 0.1 + (same ? 0.5 : 0.0), ls[i].pad[1].y);
}
