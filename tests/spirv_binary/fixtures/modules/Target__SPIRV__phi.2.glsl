// stage: comp
#version 450
void f_foo();
void f_main();
void f_foo() {
  int phi1;
  int phi2;
  int phi3;
  phi1 = 0;
  int v4 = (phi1 + phi1);
  int t5 = 0;
  int t6 = v4;
  phi2 = t5;
  phi3 = t6;
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
