// stage: none
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
int f_bitcount(int p0);
ivec3 f_bit_field_insert(ivec3 p0, ivec3 p1, int p2, int16_t p3);
ivec3 f_bit_field_s_extract(ivec3 p0, int8_t p1, int8_t p2);
ivec3 f_bit_field_u_extract(ivec3 p0, int8_t p1, int8_t p2);
int f_bitreverse(int p0);
int f_not(int p0);
void f_bitwise_scalar(int p0, int p1);
int f_shift_left_logical(int p0, int16_t p1);
ivec4 f_shift_right_arithmetic(ivec4 p0, i8vec4 p1);
ivec2 f_shift_right_logical(ivec2 p0, i8vec2 p1);
int f_bitcount(int p0) {
  int v1 = int(bitCount(p0));
  return v1;
}
ivec3 f_bit_field_insert(ivec3 p0, ivec3 p1, int p2, int16_t p3) {
  ivec3 v2 = bitfieldInsert(p0, p1, p2, p3);
  return v2;
}
ivec3 f_bit_field_s_extract(ivec3 p0, int8_t p1, int8_t p2) {
  ivec3 v3 = bitfieldExtract(p0, p1, p2);
  return v3;
}
ivec3 f_bit_field_u_extract(ivec3 p0, int8_t p1, int8_t p2) {
  ivec3 v4 = ivec3(bitfieldExtract(uvec3(p0), p1, p2));
  return v4;
}
int f_bitreverse(int p0) {
  int v5 = bitfieldReverse(p0);
  return v5;
}
int f_not(int p0) {
  int v6 = (~p0);
  return v6;
}
void f_bitwise_scalar(int p0, int p1) {
  int v7 = (p0 & p1);
  int v8 = (p0 | p1);
  int v9 = (p0 ^ p1);
  return;
}
int f_shift_left_logical(int p0, int16_t p1) {
  int v10 = (p0 << p1);
  return v10;
}
ivec4 f_shift_right_arithmetic(ivec4 p0, i8vec4 p1) {
  ivec4 v11 = (p0 >> p1);
  return v11;
}
ivec2 f_shift_right_logical(ivec2 p0, i8vec2 p1) {
  ivec2 v12 = ivec2(uvec2(p0) >> p1);
  return v12;
}
