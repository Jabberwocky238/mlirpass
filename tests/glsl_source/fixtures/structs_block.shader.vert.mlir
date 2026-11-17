"builtin.module"() ({
  "glsl.shader"() <{es, stage = 0 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x2, storage = 0x0, sym_name = "gl_VertexID", ty = si32}> : () -> ()
    "glsl.global"() <{builtin = 0x0, storage = 0x1, sym_name = "gl_Position", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %1 = "glsl.load"() <{var = @gl_VertexID}> : () -> i32
      %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %3 = "arith.shli"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %5 = "arith.andi"(%3, %4) : (i32, i32) -> i32
      %6 = "arith.sitofp"(%5) : (i32) -> f32
      %7 = "glsl.load"() <{var = @gl_VertexID}> : () -> i32
      %8 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %9 = "arith.andi"(%7, %8) : (i32, i32) -> i32
      %10 = "arith.sitofp"(%9) : (i32) -> f32
      %11 = "glsl.construct"(%6, %10) : (f32, f32) -> vector<2xf32>
      "spirv.Store"(%0, %11) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %12 = "spirv.Load"(%0) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      "glsl.store"(%12) <{var = @v_uv}> : (vector<2xf32>) -> ()
      %13 = "spirv.Load"(%0) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %14 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %15 = "glsl.construct"(%14) : (f32) -> vector<2xf32>
      %16 = "arith.mulf"(%13, %15) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %17 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %18 = "glsl.construct"(%17) : (f32) -> vector<2xf32>
      %19 = "arith.subf"(%16, %18) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %20 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %21 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %22 = "glsl.construct"(%19, %20, %21) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      "glsl.store"(%22) <{var = @gl_Position}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
