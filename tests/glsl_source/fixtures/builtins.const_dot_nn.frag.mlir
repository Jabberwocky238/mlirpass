"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %5 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %6 = "vector.shuffle"(%5, %5) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%4, %6) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %7 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %8 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %9 = "glsl.construct"(%8) : (f32) -> vector<2xf32>
      %10 = "arith.subf"(%7, %9) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %11 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %12 = "glsl.construct"(%10, %11) : (vector<2xf32>, f32) -> vector<3xf32>
      %13 = "glsl.builtin"(%12) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%3, %13) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %14 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %15 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %16 = "arith.constant"() <{value = 8.000000e-01 : f32}> : () -> f32
      %17 = "glsl.construct"(%14, %15, %16) : (f32, f32, f32) -> vector<3xf32>
      %18 = "glsl.builtin"(%17) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%2, %18) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %19 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %20 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %21 = "glsl.construct"(%20) : (f32) -> vector<2xf32>
      %22 = "arith.subf"(%19, %21) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %23 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %24 = "glsl.construct"(%22, %23) : (vector<2xf32>, f32) -> vector<3xf32>
      "spirv.Store"(%1, %24) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %25 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %26 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %27 = "arith.constant"() <{value = 8.000000e-01 : f32}> : () -> f32
      %28 = "glsl.construct"(%25, %26, %27) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%0, %28) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %29 = "spirv.Load"(%2) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %30 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %31 = "glsl.builtin"(%29, %30) <{func = 0x2c}> : (vector<3xf32>, vector<3xf32>) -> f32
      %32 = "glsl.construct"(%31) : (f32) -> vector<4xf32>
      "glsl.store"(%32) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
