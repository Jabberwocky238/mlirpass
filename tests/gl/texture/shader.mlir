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
  glsl.global uniform @u_tex : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>> {binding = 2 : i32}
  func.func @main() {
    %uv = glsl.load @v_uv : vector<2xf32>
    %s = glsl.load @u_tex : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
    %k3 = arith.constant dense<3.000000e+00> : vector<2xf32>
    %uv3 = arith.mulf %uv, %k3 : vector<2xf32>
    %t = glsl.texture implicit %s, %uv3 : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32> -> vector<4xf32>
    %lod = arith.constant 1.500000e+00 : f32
    %l = glsl.texture explicit %s, %uv, %lod : f32 : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32> -> vector<4xf32>
    %k2 = arith.constant dense<2.000000e+00> : vector<2xf32>
    %uv2 = arith.mulf %uv, %k2 : vector<2xf32>
    %bias = arith.constant 5.000000e-01 : f32
    %b = glsl.texture bias %s, %uv2, %bias : f32 : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32> -> vector<4xf32>
    %fc = glsl.load @gl_FragCoord : vector<4xf32>
    %xy = "vector.shuffle"(%fc, %fc) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
    %ixy = arith.fptosi %xy : vector<2xf32> to vector<2xi32>
    %k8 = arith.constant dense<8> : vector<2xi32>
    %d = arith.divsi %ixy, %k8 : vector<2xi32>
    %lv = arith.constant 1 : i32
    %f = glsl.texel_fetch %s, %d, %lv : !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xi32>, i32 -> vector<4xf32>
    %q = arith.constant dense<2.500000e-01> : vector<4xf32>
    %e = arith.constant dense<1.250000e-01> : vector<4xf32>
    %h = arith.constant dense<5.000000e-01> : vector<4xf32>
    %lq = arith.mulf %l, %q : vector<4xf32>
    %be = arith.mulf %b, %e : vector<4xf32>
    %fh = arith.mulf %f, %h : vector<4xf32>
    %s1 = arith.addf %t, %lq : vector<4xf32>
    %s2 = arith.addf %s1, %be : vector<4xf32>
    %s3 = arith.addf %s2, %fh : vector<4xf32>
    glsl.store %s3, @o_color : vector<4xf32>
    return
  }
}
