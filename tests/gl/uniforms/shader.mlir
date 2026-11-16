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
  glsl.global uniform @u_tint : vector<4xf32> {location = 3 : i32}
  glsl.global uniform @u_scale : f32 {location = 4 : i32}
  glsl.global uniform @u_shift : si32 {location = 5 : i32}
  glsl.global uniform @params : !spirv.struct<(vector<4xf32> [0], !spirv.matrix<4 x vector<4xf32>> [16, ColMajor, MatrixStride=16], f32 [80]), Block> {binding = 1 : i32}
  func.func @main() {
    %uv = glsl.load @v_uv : vector<2xf32>
    %sc = glsl.load @u_scale : f32
    %scv = glsl.construct(%sc : f32) -> vector<2xf32>
    %a = arith.mulf %uv, %scv : vector<2xf32>
    %sh = glsl.load @u_shift : i32
    %shf = arith.sitofp %sh : i32 to f32
    %one = arith.constant 1.000000e+00 : f32
    %p = glsl.construct(%a, %shf, %one : vector<2xf32>, f32, f32) -> vector<4xf32>
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %off = glsl.load @params[%c0 : i32] : vector<4xf32>
    %q = arith.addf %p, %off : vector<4xf32>
    %m = glsl.load @params[%c1 : i32] : !spirv.matrix<4 x vector<4xf32>>
    %mv = glsl.builtin matrix_times_vector %m, %q : !spirv.matrix<4 x vector<4xf32>>, vector<4xf32> -> vector<4xf32>
    %t = glsl.load @u_tint : vector<4xf32>
    %r = arith.mulf %mv, %t : vector<4xf32>
    %g = glsl.load @params[%c2 : i32] : f32
    %gv = glsl.construct(%g : f32) -> vector<4xf32>
    %o = arith.mulf %r, %gv : vector<4xf32>
    glsl.store %o, @o_color : vector<4xf32>
    return
  }
}
