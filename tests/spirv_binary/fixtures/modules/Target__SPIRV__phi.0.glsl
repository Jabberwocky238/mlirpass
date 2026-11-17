// stage: comp
#version 450
void f_foo();
void f_main();
void f_foo() {
  int phi1;
  phi1 = 0;
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
