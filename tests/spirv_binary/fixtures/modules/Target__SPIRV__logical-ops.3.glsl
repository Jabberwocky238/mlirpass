// stage: none
#version 450
struct S0 {
  int m0;
  int m1;
};
void f_select_op_array(bool p0, int[4] p1, int[4] p2);
void f_select_op_struct(bool p0, S0 p1, S0 p2);
void f_select_op_matrix(bool p0, mat4x3 p1, mat4x3 p2);
void f_select_op_array(bool p0, int[4] p1, int[4] p2) {
  int[4] v1 = (p0 ? p1 : p2);
  return;
}
void f_select_op_struct(bool p0, S0 p1, S0 p2) {
  S0 v2 = (p0 ? p1 : p2);
  return;
}
void f_select_op_matrix(bool p0, mat4x3 p1, mat4x3 p2) {
  mat4x3 v3 = (p0 ? p1 : p2);
  return;
}
