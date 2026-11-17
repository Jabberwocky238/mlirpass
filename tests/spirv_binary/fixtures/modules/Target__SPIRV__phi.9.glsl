// stage: comp
#version 450
void f_cond_branch_true_and_false_argument();
void f_main();
void f_cond_branch_true_and_false_argument() {
  int phi1;
  int phi2;
  int phi3;
  if (true) {
    phi1 = 1;
    return;
  } else {
    int t4 = 0;
    int t5 = 0;
    phi2 = t4;
    phi3 = t5;
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
