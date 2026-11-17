// stage: none
#version 450
void f_switch_default_only(int p0);
void f_switch_default_only(int p0) {
  switch (p0) {
    default: {
      break;
    }
  }
  return;
}
