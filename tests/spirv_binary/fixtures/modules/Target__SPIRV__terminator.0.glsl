// stage: none
#version 450
void f_ret();
int f_ret_val();
void f_unreachable();
void f_kill();
void f_ret() {
  return;
}
int f_ret_val() {
  int var1;
  int v2 = var1;
  return v2;
}
void f_unreachable() {
  return;
}
void f_kill() {
  discard;
}
