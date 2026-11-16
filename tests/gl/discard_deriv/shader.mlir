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
  glsl.global in @gl_FragCoord : vector<4xf32> {builtin = 4 : i64}
  glsl.global in @v_uv : vector<2xf32> {location = 0 : i32}
  glsl.global out @o_color : vector<4xf32> {location = 0 : i32}
  func.func @main() {
    %fc = glsl.load @gl_FragCoord : vector<4xf32>
    %cx = vector.extract %fc[0] : f32 from vector<4xf32>
    %cy = vector.extract %fc[1] : f32 from vector<4xf32>
    %s = arith.addf %cx, %cy : f32
    %k5 = arith.constant 5.000000e+00 : f32
    %m = glsl.builtin mod %s, %k5 : f32, f32 -> f32
    %k1 = arith.constant 1.000000e+00 : f32
    %lt = arith.cmpf olt, %m, %k1 : f32
    scf.if %lt {
      glsl.discard
    }
    %uv = glsl.load @v_uv : vector<2xf32>
    %ux = vector.extract %uv[0] : f32 from vector<2xf32>
    %uy = vector.extract %uv[1] : f32 from vector<2xf32>
    %u2 = arith.mulf %ux, %ux : f32
    %k50 = arith.constant 5.000000e+01 : f32
    %u50 = arith.mulf %u2, %k50 : f32
    %dx = glsl.derivative dfdx %u50 : f32
    %uyc = arith.mulf %uy, %cx : f32
    %dy = glsl.derivative dfdy %uyc : f32
    %d = glsl.construct(%dx, %dy : f32, f32) -> vector<2xf32>
    %xy = arith.mulf %cx, %cy : f32
    %k001 = arith.constant 1.000000e-02 : f32
    %xyk = arith.mulf %xy, %k001 : f32
    %w = glsl.derivative fwidth %xyk : f32
    %k64 = arith.constant dense<6.400000e+01> : vector<2xf32>
    %d64 = arith.mulf %d, %k64 : vector<2xf32>
    %one = arith.constant 1.000000e+00 : f32
    %o = glsl.construct(%d64, %w, %one : vector<2xf32>, f32, f32) -> vector<4xf32>
    glsl.store %o, @o_color : vector<4xf32>
    return
  }
}
