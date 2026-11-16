#version 310 es
precision highp float;
layout(location = 0) in vec2 v_uv;
layout(location = 0) out vec4 o_color;
layout(location = 3) uniform vec4 u_tint;
layout(location = 4) uniform float u_scale;
layout(location = 5) uniform int u_shift;
layout(std140, binding = 1) uniform Params { vec4 offset; mat4 xform; float gain; } params;
void main() {
    vec4 p = vec4(v_uv * u_scale, float(u_shift), 1.0);
    o_color = (params.xform * (p + params.offset)) * u_tint * params.gain;
}
