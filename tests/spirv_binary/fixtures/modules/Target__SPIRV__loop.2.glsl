// stage: comp
#version 450
void f_loop(int p0);
void f_main();
void f_loop(int p0) {
  int var1 = 0;
  int var2 = 0;
  while (true) {
    int v3 = var1;
    bool v4 = (v3 < p0);
    if (v4) {
      var2 = 0;
      while (true) {
        int v5 = var2;
        bool v6 = (v5 < p0);
        if (v6) {
          int v7 = var2;
          int v8 = (v7 + 1);
          var2 = v8;
          continue;
        } else {
          break;
        }
      }
      int v9 = var1;
      int v10 = (v9 + 1);
      var1 = v10;
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
