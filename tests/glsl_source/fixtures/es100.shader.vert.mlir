"builtin.module"() ({
  "glsl.shader"() <{es, stage = 0 : i64, version = 100 : i32}> ({
    "glsl.global"() <{storage = 0x0, sym_name = "a_pos", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{storage = 0x1, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{storage = 0x1, sym_name = "v_k", ty = f32}> : () -> ()
    "glsl.global"() <{builtin = 0x0, storage = 0x1, sym_name = "gl_Position", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "glsl.load"() <{var = @a_pos}> : () -> vector<2xf32>
      %1 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %2 = "glsl.construct"(%1) : (f32) -> vector<2xf32>
      %3 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %4 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %5 = "glsl.construct"(%4) : (f32) -> vector<2xf32>
      %6 = "arith.addf"(%3, %5) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "glsl.store"(%6) <{var = @v_uv}> : (vector<2xf32>) -> ()
      %7 = "glsl.load"() <{var = @a_pos}> : () -> vector<2xf32>
      %8 = "vector.extract"(%7) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %9 = "glsl.load"() <{var = @a_pos}> : () -> vector<2xf32>
      %10 = "vector.extract"(%9) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %11 = "arith.mulf"(%8, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "glsl.store"(%11) <{var = @v_k}> : (f32) -> ()
      %12 = "glsl.load"() <{var = @a_pos}> : () -> vector<2xf32>
      %13 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %14 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %15 = "glsl.construct"(%12, %13, %14) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      "glsl.store"(%15) <{var = @gl_Position}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
