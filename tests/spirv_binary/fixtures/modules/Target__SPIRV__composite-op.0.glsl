// stage: none
#version 450
struct S0 {
  float[4] m0;
  float m1;
};
struct S1 {
  float m0;
  S0 m1;
};
S1 f_composite_insert(S1 p0, float[4] p1);
vec3 f_composite_construct_vector(float p0, float p1, float p2);
float f_vector_dynamic_extract(vec4 p0, int p1);
vec4 f_vector_dynamic_insert(float p0, vec4 p1, int p2);
vec3 f_vector_shuffle(vec4 p0, vec2 p1);
S1 f_composite_insert(S1 p0, float[4] p1) {
  S1 v1 = p0;
  v1.m1.m0 = p1;
  return v1;
}
vec3 f_composite_construct_vector(float p0, float p1, float p2) {
  vec3 v2 = vec3(p0, p1, p2);
  return v2;
}
float f_vector_dynamic_extract(vec4 p0, int p1) {
  float v3 = p0[p1];
  return v3;
}
vec4 f_vector_dynamic_insert(float p0, vec4 p1, int p2) {
  vec4 v4 = p1;
  v4[p2] = p0;
  return v4;
}
vec3 f_vector_shuffle(vec4 p0, vec2 p1) {
  vec3 v5 = vec3(p0[1], p0[3], p0[0]);
  return v5;
}
