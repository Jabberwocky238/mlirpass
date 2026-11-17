// stage: comp
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void f_selection_yield(bool p0);
void f_main();
void f_selection_yield(bool p0) {
  int phi1;
  int var2 = 0;
  if (p0) {
    phi1 = 1;
  } else {
    phi1 = 2;
  }
  int v3 = phi1;
  var2 = v3;
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
