// stage: comp
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void f_selection_cf();
void f_main();
void f_selection_cf() {
  int phi1;
  int phi2;
  int phi3;
  bool var4;
  if (true) {
    var4 = true;
  } else {
    var4 = false;
  }
  bool v5 = var4;
  if (v5) {
    phi1 = 1;
    return;
  } else {
    int t6 = 0;
    int t7 = 0;
    phi2 = t6;
    phi3 = t7;
    return;
  }
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
