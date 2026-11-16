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
  func.func @wave(%x: f32, %k: f32) -> f32 {
    %xk = arith.mulf %x, %k : f32
    %s = math.sin %xk : f32
    %h = arith.constant 5.000000e-01 : f32
    %m = arith.mulf %s, %h : f32
    %r = arith.addf %m, %h : f32
    return %r : f32
  }
  func.func @main() {
    %fc = glsl.load @gl_FragCoord : vector<4xf32>
    %cx = vector.extract %fc[0] : f32 from vector<4xf32>
    %cy = vector.extract %fc[1] : f32 from vector<4xf32>
    %zero = arith.constant 0.000000e+00 : f32
    %half = arith.constant 5.000000e-01 : f32
    %one = arith.constant 1.000000e+00 : f32
    %lb = arith.constant 0 : i32
    %ub = arith.constant 6 : i32
    %st = arith.constant 1 : i32
    %ten = arith.constant 10 : i32
    %k005 = arith.constant 5.000000e-02 : f32
    %k64 = arith.constant 6.400000e+01 : f32
    %acc = scf.for %i = %lb to %ub step %st iter_args(%a = %zero) -> (f32) : i32 {
      %fi = arith.sitofp %i : i32 to f32
      %xi = arith.addf %cx, %fi : f32
      %i1 = arith.addi %i, %st : i32
      %fi1 = arith.sitofp %i1 : i32 to f32
      %kk = arith.mulf %k005, %fi1 : f32
      %w = func.call @wave(%xi, %kk) : (f32, f32) -> f32
      %na = arith.addf %a, %w : f32
      scf.yield %na : f32
    }
    %gt = arith.cmpf ogt, %cx, %cy : f32
    %col = scf.if %gt -> (vector<3xf32>) {
      %d = arith.divf %cx, %k64 : f32
      %q = arith.constant 2.500000e-01 : f32
      %v = glsl.construct(%acc, %d, %q : f32, f32, f32) -> vector<3xf32>
      scf.yield %v : vector<3xf32>
    } else {
      %d = arith.divf %cy, %k64 : f32
      %ah = arith.mulf %acc, %half : f32
      %q = arith.constant 7.500000e-01 : f32
      %v = glsl.construct(%d, %ah, %q : f32, f32, f32) -> vector<3xf32>
      scf.yield %v : vector<3xf32>
    }
    %k0 = arith.constant 0 : i32
    %res:2 = "scf.while"(%cy, %k0) ({
    ^bb0(%t: f32, %k: i32):
      %c1 = arith.cmpf ogt, %t, %one : f32
      %c2 = arith.cmpi slt, %k, %ten : i32
      %c = arith.andi %c1, %c2 : i1
      "scf.condition"(%c, %t, %k) : (i1, f32, i32) -> ()
    }, {
    ^bb0(%t2: f32, %k2: i32):
      %tn = arith.mulf %t2, %half : f32
      %kn = arith.addi %k2, %st : i32
      "scf.yield"(%tn, %kn) : (f32, i32) -> ()
    }) : (f32, i32) -> (f32, i32)
    %kf = arith.sitofp %res#1 : i32 to f32
    %fr = glsl.builtin fract %res#0 : f32 -> f32
    %w4 = arith.addf %kf, %fr : f32
    %o = glsl.construct(%col, %w4 : vector<3xf32>, f32) -> vector<4xf32>
    glsl.store %o, @o_color : vector<4xf32>
    return
  }
}
