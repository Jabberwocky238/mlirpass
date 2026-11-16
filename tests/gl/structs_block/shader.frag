#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
struct Light { vec3 dir; float k; vec2 pad[2]; };
struct Scene { Light key; Light fill; int count; };
layout(std140, binding = 1) uniform Params { Light key; float gain; Light rest[1]; } params;
void main() {
    vec3 n = normalize(vec3(v_uv - 0.5, 0.7));
    Light l = params.key;
    o_color = vec4(dot(l.dir, n) * l.k * params.gain, l.pad[1] + params.rest[0].pad[0], params.rest[0].dir.y + params.rest[0].k);
}
