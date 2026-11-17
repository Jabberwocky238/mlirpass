"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %3 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %4 = "vector.shuffle"(%3, %3) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%2, %4) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %5 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %6 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %7 = "glsl.construct"(%6) : (f32) -> vector<2xf32>
      %8 = "arith.subf"(%5, %7) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %9 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %10 = "glsl.construct"(%8, %9) : (vector<2xf32>, f32) -> vector<3xf32>
      "spirv.Store"(%1, %10) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %11 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %12 = "glsl.builtin"(%11) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%0, %12) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %13 = "arith.constant"() <{value = 9.800000e-01 : f32}> : () -> f32
      %14 = "glsl.builtin"(%13) <{func = 0x13}> : (f32) -> f32
      %15 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %16 = "vector.extract"(%15) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %17 = "arith.mulf"(%14, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %18 = "glsl.construct"(%17) : (f32) -> vector<4xf32>
      "glsl.store"(%18) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
