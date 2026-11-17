// stage: comp
#version 450
void f_cond_branch_false_argument();
void f_main();
void f_cond_branch_false_argument() {
  int phi1;
  int phi2;
  if (true) {
    return;
  } else {
    int t3 = 0;
    int t4 = 0;
    phi1 = t3;
    phi2 = t4;
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
