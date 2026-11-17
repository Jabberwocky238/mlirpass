// stage: comp
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void f_selection(bool p0);
void f_main();
void f_selection(bool p0) {
  int var1 = 0;
  if (p0) {
    var1 = 1;
  } else {
    var1 = 2;
  }
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
