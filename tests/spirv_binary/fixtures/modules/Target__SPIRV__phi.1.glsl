// stage: comp
#version 450
void f_foo();
void f_main();
void f_foo() {
  int phi1;
  float phi2;
  int t3 = 0;
  float t4 = 1.0;
  phi1 = t3;
  phi2 = t4;
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
