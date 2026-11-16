#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
void main() { vec2 c = gl_FragCoord.xy; vec3 m = vec3(v_uv - 0.5, 0.7); vec2 q = v_uv - 0.3; o_color = vec4(normalize(c.x - 30.0)); }
