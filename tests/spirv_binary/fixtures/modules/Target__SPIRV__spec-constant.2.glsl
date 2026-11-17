// stage: none
#version 450
struct S0 {
  int m0;
  float m1;
  float m2;
};
const float c_sc_f32_1 = 1.5;
const float c_sc_f32_2 = 2.5;
const float c_sc_f32_3 = 3.5;
const int c_sc_i32_1 = 1;
const float[3] c_scc_array = float[3](c_sc_f32_1, c_sc_f32_2, c_sc_f32_3);
const S0 c_scc_struct = S0(c_sc_i32_1, c_sc_f32_2, c_sc_f32_3);
const vec3 c_scc_vector = vec3(c_sc_f32_1, c_sc_f32_2, c_sc_f32_3);
