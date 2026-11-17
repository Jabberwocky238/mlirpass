// stage: comp
#version 450
void f_cond_branch_true_argument();
void f_main();
void f_cond_branch_true_argument() {
  int phi1;
  int phi2;
  if (true) {
    int t3 = 0;
    int t4 = 0;
    phi1 = t3;
    phi2 = t4;
    return;
  } else {
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
