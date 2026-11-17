// stage: comp
#version 450
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void f_fmul_kernel();
void f_fmul_kernel() {
  int phi1;
  int phi2;
  phi1 = 43;
  while (true) {
    bool v3 = (phi1 < 4);
    if (v3) {
      int v4 = (phi1 + 4);
      phi1 = v4;
      continue;
    } else {
      break;
    }
  }
  phi2 = 44;
  while (true) {
    bool v5 = (phi2 < 4);
    if (v5) {
      int v6 = (phi2 + 4);
      phi2 = v6;
      continue;
    } else {
      break;
    }
  }
  return;
}
void main() {
  f_fmul_kernel();
}
