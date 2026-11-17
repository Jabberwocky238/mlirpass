#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
void main() { vec2 c = gl_FragCoord.xy; vec3 n = normalize(vec3(v_uv - 0.5, 0.7)); vec3 d = normalize(vec3(0.3, 0.5, 0.8)); vec3 m = vec3(v_uv - 0.5, 0.7); vec3 e = vec3(0.3, 0.5, 0.8); o_color = vec4(dot(d, n)); }
