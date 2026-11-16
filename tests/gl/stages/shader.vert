#version 310 es
layout(location = 0) in vec2 a_pos;
layout(location = 0) out vec3 v_color;
layout(location = 0) uniform vec2 u_offset;
layout(location = 1) uniform float u_scale;
void main() {
    v_color = vec3(a_pos * 0.5 + 0.5, 0.25) * u_scale;
    gl_Position = vec4(a_pos * u_scale + u_offset, 0.0, 1.0);
}
