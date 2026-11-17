"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %4 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %5 = "vector.shuffle"(%4, %4) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%3, %5) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %6 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %7 = "vector.extract"(%6) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %8 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
      %9 = "arith.mulf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "glsl.builtin"(%9) <{func = 0x2}> : (f32) -> f32
      %11 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %12 = "vector.extract"(%11) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %13 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %14 = "arith.addf"(%12, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %15 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %16 = "glsl.builtin"(%14, %15) <{func = 0x20}> : (f32, f32) -> f32
      %17 = "arith.mulf"(%10, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%2, %17) : (!spirv.ptr<f32, Function>, f32) -> ()
      %18 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %19 = "vector.extract"(%18) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %20 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %21 = "vector.extract"(%20) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %22 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %23 = "glsl.builtin"(%19, %21, %22) <{func = 0x25}> : (f32, f32, f32) -> f32
      %24 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %25 = "vector.extract"(%24) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %26 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      %27 = "arith.addf"(%25, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %28 = "arith.divf"(%23, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%1, %28) : (!spirv.ptr<f32, Function>, f32) -> ()
      %29 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
      %30 = "arith.constant"() <{value = 5.000000e+01 : f32}> : () -> f32
      %31 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %32 = "vector.extract"(%31) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %33 = "glsl.builtin"(%29, %30, %32) <{func = 0x27}> : (f32, f32, f32) -> f32
      "spirv.Store"(%0, %33) : (!spirv.ptr<f32, Function>, f32) -> ()
      %34 = "spirv.Load"(%2) : (!spirv.ptr<f32, Function>) -> f32
      %35 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %36 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %37 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %38 = "vector.extract"(%37) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %39 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %40 = "vector.extract"(%39) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %41 = "arith.mulf"(%38, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %42 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
      %43 = "arith.divf"(%41, %42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %44 = "glsl.builtin"(%43) <{func = 0x22}> : (f32) -> f32
      %45 = "glsl.construct"(%34, %35, %36, %44) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%45) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
