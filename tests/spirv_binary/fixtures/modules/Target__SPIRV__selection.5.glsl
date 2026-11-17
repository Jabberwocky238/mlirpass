// stage: comp
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void f_selection_switch_operands(int p0);
void f_main();
void f_selection_switch_operands(int p0) {
  vec3 phi1;
  vec3 phi2;
  vec3 phi3;
  vec3 u4;
  vec3 v5 = u4;
  v5[0] = 1.0;
  switch (p0) {
    default: {
      phi3 = v5;
      break;
    }
    case 0: {
      phi1 = v5;
      vec3 v6 = phi1;
      v6[1] = 3.0;
      phi3 = v6;
      break;
    }
    case 1: {
      phi2 = v5;
      vec3 v7 = phi2;
      v7[1] = 4.0;
      phi3 = v7;
      break;
    }
  }
  vec3 v8 = phi3;
  vec3 v9 = v8;
  v9[2] = 2.0;
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
