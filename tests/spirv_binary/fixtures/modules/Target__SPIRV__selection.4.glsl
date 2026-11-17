// stage: comp
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void f_selection_switch(int p0);
void f_main();
void f_selection_switch(int p0) {
  int var1 = 0;
  switch (p0) {
    default: {
      var1 = 1;
      break;
    }
    case 0: {
      var1 = 2;
      break;
    }
    case 1: {
      var1 = 3;
      break;
    }
    case 2: {
      var1 = 4;
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
