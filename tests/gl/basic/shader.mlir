glsl.shader vertex attributes {es, version = 310 : i32} {
  glsl.global in @gl_VertexID : i32 {builtin = 2 : i64}
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
  glsl.global in @gl_FragCoord : vector<4xf32> {builtin = 4 : i64}
  glsl.global in @v_uv : vector<2xf32> {location = 0 : i32}
  glsl.global out @o_color : vector<4xf32> {location = 0 : i32}
  func.func @main() {
    %fc = glsl.load @gl_FragCoord : vector<4xf32>
    %c = "vector.shuffle"(%fc, %fc) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
    %cx = vector.extract %c[0] : f32 from vector<2xf32>
    %cy = vector.extract %c[1] : f32 from vector<2xf32>
    %k01 = arith.constant 1.000000e-01 : f32
    %t = arith.mulf %cx, %k01 : f32
    %sin = math.sin %t : f32
    %uv = glsl.load @v_uv : vector<2xf32>
    %uvy = vector.extract %uv[1] : f32 from vector<2xf32>
    %k1 = arith.constant 1.000000e+00 : f32
    %u1 = arith.addf %uvy, %k1 : f32
    %k15 = arith.constant 1.500000e+00 : f32
    %pw = glsl.builtin pow %u1, %k15 : f32, f32 -> f32
    %a = arith.mulf %sin, %pw : f32
    %k025 = arith.constant 2.500000e-01 : f32
    %mx = glsl.builtin mix %cx, %cy, %k025 : f32, f32, f32 -> f32
    %k3 = arith.constant 3.000000e+00 : f32
    %cy3 = arith.addf %cy, %k3 : f32
    %b = arith.divf %mx, %cy3 : f32
    %k10 = arith.constant 1.000000e+01 : f32
    %k50 = arith.constant 5.000000e+01 : f32
    %s = glsl.builtin smoothstep %k10, %k50, %cx : f32, f32, f32 -> f32
    %xy = arith.mulf %cx, %cy : f32
    %k7 = arith.constant 7.000000e+00 : f32
    %d = arith.divf %xy, %k7 : f32
    %f = glsl.builtin fract %d : f32 -> f32
    %col = glsl.construct(%a, %b, %s, %f : f32, f32, f32, f32) -> vector<4xf32>
    glsl.store %col, @o_color : vector<4xf32>
    return
  }
}
