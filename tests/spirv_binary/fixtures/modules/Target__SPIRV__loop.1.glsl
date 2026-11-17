// stage: comp
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430, set = 0, binding = 0) buffer g_GV1_block {
  layout(offset = 0) float[10] m0;
} g_GV1;
layout(std430, set = 0, binding = 1) buffer g_GV2_block {
  layout(offset = 0) float[10] m0;
} g_GV2;
void f_loop_kernel();
void f_loop_kernel() {
  int phi1;
  phi1 = 4;
  while (true) {
    bool v2 = (phi1 < 42);
    if (v2) {
      float v3 = g_GV1.m0[phi1];
      g_GV2.m0[phi1] = v3;
      int v4 = (phi1 + 2);
      phi1 = v4;
      continue;
    } else {
      break;
    }
  }
  return;
}
void main() {
  f_loop_kernel();
}
