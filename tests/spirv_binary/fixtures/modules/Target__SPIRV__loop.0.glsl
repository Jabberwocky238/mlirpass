// stage: comp
#version 450
void f_loop(int p0);
void f_main();
void f_loop(int p0) {
  int var1 = 0;
  while (true) {
    int v2 = var1;
    bool v3 = (v2 < p0);
    if (v3) {
      int v4 = var1;
      int v5 = (v4 + 1);
      var1 = v5;
      continue;
    } else {
      break;
    }
  }
  return;
}
void f_main() {
  return;
}
void main() {
  f_main();
}
