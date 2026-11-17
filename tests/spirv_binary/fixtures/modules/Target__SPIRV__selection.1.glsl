// stage: comp
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
int f_selection(bool p0);
void f_main();
int f_selection(bool p0) {
  if (p0) {
    return 0;
  } else {
  }
  return 1;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
