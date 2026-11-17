// stage: none
#version 450
const bool c_condition_scalar = true;
void f_select();
void f_select() {
  float v1 = (c_condition_scalar ? 4.0 : 5.0);
  vec4 v2 = (c_condition_scalar ? vec4(2.0, 3.0, 4.0, 5.0) : vec4(6.0, 7.0, 8.0, 9.0));
  vec4 v3 = mix(vec4(6.0, 7.0, 8.0, 9.0), vec4(2.0, 3.0, 4.0, 5.0), bvec4(true, true, true, true));
  return;
}
