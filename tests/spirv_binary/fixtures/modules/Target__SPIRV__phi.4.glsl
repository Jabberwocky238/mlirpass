// stage: comp
#version 450
void f_foo();
void f_main();
void f_foo() {
  int phi1;
  int var2;
  if (true) {
    phi1 = 0;
    var2 = phi1;
    return;
  } else {
    phi1 = 1;
    var2 = phi1;
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
