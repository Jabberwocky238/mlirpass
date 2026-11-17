#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
struct Light { vec3 dir; float k; vec2 pad[2]; };
struct Scene { Light key; Light fill; int count; };
layout(location = 2) uniform Light u_light;
void main() {
    vec3 n = normalize(vec3(v_uv - 0.5, 0.7));
    o_color = vec4(dot(u_light.dir, n) * u_light.k, u_light.pad[0] + u_light.pad[1], 1.0);
}
