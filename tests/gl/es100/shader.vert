#version 100
attribute vec2 a_pos;
varying vec2 v_uv;
varying float v_k;
void main() {
    v_uv = a_pos * 0.5 + 0.5;
    v_k = a_pos.x * a_pos.y;
    gl_Position = vec4(a_pos, 0.0, 1.0);
}
