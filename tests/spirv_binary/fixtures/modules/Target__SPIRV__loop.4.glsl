// stage: none
#version 450
void f_loop_yield(int p0);
void f_loop_yield(int p0) {
  int phi1;
  int var2 = 0;
  phi1 = 0;
  while (true) {
    bool v3 = (phi1 < p0);
    if (v3) {
      int v4 = (phi1 + 1);
      phi1 = v4;
      continue;
    } else {
      break;
    }
  }
  int v5 = phi1;
  var2 = v5;
  return;
}
