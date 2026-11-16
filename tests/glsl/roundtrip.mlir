glsl.shader vertex attributes {es, version = 300 : i32} {
  glsl.global in @a_pos : vector<3xf32> {location = 0 : i32}
  glsl.global in @a_uv : vector<2xf32> {location = 1 : i32}
  glsl.global uniform @u_mvp : !spirv.matrix<4 x vector<4xf32>> {precision = 2 : i64}
  glsl.global uniform @u_tex : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>> {binding = 0 : i32}
  glsl.global uniform @u_bones : !spirv.array<4 x vector<4xf32>>
  glsl.global out @v_uv : vector<2xf32> {interpolation = 1 : i64, location = 0 : i32}
  glsl.global out @gl_Position : vector<4xf32> {builtin = 0 : i64}
  func.func @main() {
    %0 = glsl.load @a_pos : vector<3xf32>
    %c1 = arith.constant 1.000000e+00 : f32
    %1 = glsl.construct(%0, %c1 : vector<3xf32>, f32) -> vector<4xf32>
    %2 = glsl.load @u_mvp : !spirv.matrix<4 x vector<4xf32>>
    %3 = glsl.builtin matrix_times_vector %2, %1 : !spirv.matrix<4 x vector<4xf32>>, vector<4xf32> -> vector<4xf32>
    %i = arith.constant 2 : i32
    %4 = glsl.load @u_bones[%i : i32] : vector<4xf32>
    %5 = arith.addf %3, %4 : vector<4xf32>
    glsl.store %5, @gl_Position : vector<4xf32>
    %6 = glsl.load @a_uv : vector<2xf32>
    %s = glsl.load @u_tex : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
    %l = arith.constant 0.000000e+00 : f32
    %7 = glsl.texture explicit %s, %6, %l : f32 : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32> -> vector<4xf32>
    %z = arith.constant 0 : i32
    %8 = glsl.texture_size %s, %z : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, i32 -> vector<2xi32>
    %9 = glsl.derivative dfdx %6 : vector<2xf32>
    glsl.store %9, @v_uv : vector<2xf32>
    glsl.discard
    return
  }
}
