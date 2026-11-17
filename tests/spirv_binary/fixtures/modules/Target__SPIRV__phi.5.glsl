// stage: comp
#version 450
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void f_fmul_kernel();
void f_fmul_kernel() {
  int phi1;
  int phi2;
  ivec3 v3 = ivec3(gl_WorkGroupID);
  int v4 = v3[0];
  ivec3 v5 = ivec3(gl_WorkGroupID);
  int v6 = v5[1];
  ivec3 v7 = ivec3(gl_NumWorkGroups);
  int v8 = v7[0];
  ivec3 v9 = ivec3(gl_NumWorkGroups);
  int v10 = v9[1];
  int v11 = (v6 * 32);
  int v12 = (v10 * 32);
  phi1 = v11;
  while (true) {
    bool v13 = (phi1 < 12);
    if (v13) {
      int v14 = (v4 * 4);
      int v15 = (v8 * 4);
      phi2 = v14;
      while (true) {
        bool v16 = (phi2 < 4);
        if (v16) {
          int v17 = (phi2 + v15);
          phi2 = v17;
          continue;
        } else {
          break;
        }
      }
      int v18 = (phi1 + v12);
      phi1 = v18;
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
