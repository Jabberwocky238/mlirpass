// stage: none
#version 450
void f_bit_cast(float p0);
void f_bit_cast(float p0) {
  int v1 = int(floatBitsToInt(p0));
  int v2 = int(v1);
  uint v3 = uint(v2);
  return;
}
