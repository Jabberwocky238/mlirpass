// stage: none
#version 450
const bool c_sc_true = true;
layout(constant_id = 1) const bool c_sc_false = false;
const int c_sc_int = -5;
layout(constant_id = 5) const float c_sc_float = 1.0;
const int[2] c_scc = int[2](c_sc_int, c_sc_int);
int f_use();
int f_use_composite();
int f_use() {
  int v1 = (c_sc_int + c_sc_int);
  return v1;
}
int f_use_composite() {
  int v2 = c_scc[0];
  int v3 = c_scc[1];
  int v4 = (v2 + v3);
  return v4;
}
