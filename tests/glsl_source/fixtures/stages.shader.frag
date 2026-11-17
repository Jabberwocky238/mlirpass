#version 310 es
precision highp float;
layout(location = 0) in vec3 v_color;
layout(location = 0) out vec4 o_color;
layout(location = 2) uniform vec4 u_tint;
layout(location = 3) uniform bool u_flip;
void main() {
    o_color = u_tint;
    if (u_flip) {
        o_color = vec4(v_color, 1.0) * u_tint;
    }
}
