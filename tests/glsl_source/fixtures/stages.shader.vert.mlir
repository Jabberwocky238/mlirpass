"builtin.module"() ({
  "glsl.shader"() <{es, stage = 0 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "a_pos", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "v_color", ty = vector<3xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x2, sym_name = "u_offset", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 1 : i32, storage = 0x2, sym_name = "u_scale", ty = f32}> : () -> ()
    "glsl.global"() <{builtin = 0x0, storage = 0x1, sym_name = "gl_Position", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "glsl.load"() <{var = @a_pos}> : () -> vector<2xf32>
      %1 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %2 = "glsl.construct"(%1) : (f32) -> vector<2xf32>
      %3 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %4 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %5 = "glsl.construct"(%4) : (f32) -> vector<2xf32>
      %6 = "arith.addf"(%3, %5) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %7 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %8 = "glsl.construct"(%6, %7) : (vector<2xf32>, f32) -> vector<3xf32>
      %9 = "glsl.load"() <{var = @u_scale}> : () -> f32
      %10 = "glsl.construct"(%9) : (f32) -> vector<3xf32>
      %11 = "arith.mulf"(%8, %10) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      "glsl.store"(%11) <{var = @v_color}> : (vector<3xf32>) -> ()
      %12 = "glsl.load"() <{var = @a_pos}> : () -> vector<2xf32>
      %13 = "glsl.load"() <{var = @u_scale}> : () -> f32
      %14 = "glsl.construct"(%13) : (f32) -> vector<2xf32>
      %15 = "arith.mulf"(%12, %14) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %16 = "glsl.load"() <{var = @u_offset}> : () -> vector<2xf32>
      %17 = "arith.addf"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %18 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %19 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %20 = "glsl.construct"(%17, %18, %19) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      "glsl.store"(%20) <{var = @gl_Position}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
