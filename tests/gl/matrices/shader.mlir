glsl.shader vertex attributes {es, version = 310 : i32} {
  glsl.global in @gl_VertexID : si32 {builtin = 2 : i64}
  glsl.global out @v_uv : vector<2xf32> {location = 0 : i32}
  glsl.global out @gl_Position : vector<4xf32> {builtin = 0 : i64}
  func.func @main() {
    %id = glsl.load @gl_VertexID : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %s = arith.shli %id, %c1 : i32
    %a = arith.andi %s, %c2 : i32
    %x = arith.sitofp %a : i32 to f32
    %b = arith.andi %id, %c2 : i32
    %y = arith.sitofp %b : i32 to f32
    %p = glsl.construct(%x, %y : f32, f32) -> vector<2xf32>
    glsl.store %p, @v_uv : vector<2xf32>
    %two = arith.constant dense<2.000000e+00> : vector<2xf32>
    %one = arith.constant dense<1.000000e+00> : vector<2xf32>
    %m = arith.mulf %p, %two : vector<2xf32>
    %q = arith.subf %m, %one : vector<2xf32>
    %z = arith.constant 0.000000e+00 : f32
    %w = arith.constant 1.000000e+00 : f32
    %pos = glsl.construct(%q, %z, %w : vector<2xf32>, f32, f32) -> vector<4xf32>
    glsl.store %pos, @gl_Position : vector<4xf32>
    return
  }
}
glsl.shader fragment attributes {es, version = 310 : i32} {
  glsl.global in @v_uv : vector<2xf32> {location = 0 : i32}
  glsl.global out @o_color : vector<4xf32> {location = 0 : i32}
  glsl.global uniform @m : !spirv.struct<(!spirv.matrix<4 x vector<4xf32>> [0, ColMajor, MatrixStride=16], !spirv.matrix<4 x vector<4xf32>> [64, ColMajor, MatrixStride=16], !spirv.matrix<3 x vector<3xf32>> [128, ColMajor, MatrixStride=16]), Block> {binding = 0 : i32}
  func.func @main() {
    %uv = glsl.load @v_uv : vector<2xf32>
    %x = vector.extract %uv[0] : f32 from vector<2xf32>
    %y = vector.extract %uv[1] : f32 from vector<2xf32>
    %xy = arith.mulf %x, %y : f32
    %one = arith.constant 1.000000e+00 : f32
    %p = glsl.construct(%uv, %xy, %one : vector<2xf32>, f32, f32) -> vector<4xf32>
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %a = glsl.load @m[%c0 : i32] : !spirv.matrix<4 x vector<4xf32>>
    %b = glsl.load @m[%c1 : i32] : !spirv.matrix<4 x vector<4xf32>>
    %ab = glsl.builtin matrix_times_matrix %a, %b : !spirv.matrix<4 x vector<4xf32>>, !spirv.matrix<4 x vector<4xf32>> -> !spirv.matrix<4 x vector<4xf32>>
    %half = arith.constant 5.000000e-01 : f32
    %h = glsl.builtin matrix_times_scalar %a, %half : !spirv.matrix<4 x vector<4xf32>>, f32 -> !spirv.matrix<4 x vector<4xf32>>
    %abp = glsl.builtin matrix_times_vector %ab, %p : !spirv.matrix<4 x vector<4xf32>>, vector<4xf32> -> vector<4xf32>
    %pa = glsl.builtin vector_times_matrix %p, %a : vector<4xf32>, !spirv.matrix<4 x vector<4xf32>> -> vector<4xf32>
    %hp = glsl.builtin matrix_times_vector %h, %p : !spirv.matrix<4 x vector<4xf32>>, vector<4xf32> -> vector<4xf32>
    %r1 = arith.addf %abp, %pa : vector<4xf32>
    %r = arith.addf %r1, %hp : vector<4xf32>
    %c = glsl.load @m[%c2 : i32] : !spirv.matrix<3 x vector<3xf32>>
    %pxyz = "vector.shuffle"(%p, %p) <{mask = array<i64: 0, 1, 2>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
    %pzyx = "vector.shuffle"(%p, %p) <{mask = array<i64: 2, 1, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
    %cp = glsl.builtin matrix_times_vector %c, %pxyz : !spirv.matrix<3 x vector<3xf32>>, vector<3xf32> -> vector<3xf32>
    %pc = glsl.builtin vector_times_matrix %pzyx, %c : vector<3xf32>, !spirv.matrix<3 x vector<3xf32>> -> vector<3xf32>
    %q = arith.addf %cp, %pc : vector<3xf32>
    %zero = arith.constant 0.000000e+00 : f32
    %q4 = glsl.construct(%q, %zero : vector<3xf32>, f32) -> vector<4xf32>
    %o = arith.addf %r, %q4 : vector<4xf32>
    glsl.store %o, @o_color : vector<4xf32>
    return
  }
}
