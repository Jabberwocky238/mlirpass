"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %3 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %4 = "vector.shuffle"(%3, %3) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%2, %4) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %5 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %6 = "vector.extract"(%5) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %7 = "arith.constant"() <{value = 3.200000e+01 : f32}> : () -> f32
      %8 = "arith.subf"(%6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.constant"() <{value = 1.300000e+01 : f32}> : () -> f32
      %10 = "arith.divf"(%8, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%1, %10) : (!spirv.ptr<f32, Function>, f32) -> ()
      %11 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %12 = "vector.extract"(%11) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %13 = "arith.constant"() <{value = 6.400000e+01 : f32}> : () -> f32
      %14 = "arith.divf"(%12, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %15 = "arith.constant"() <{value = 4.000000e-01 : f32}> : () -> f32
      %16 = "arith.subf"(%14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%0, %16) : (!spirv.ptr<f32, Function>, f32) -> ()
      %17 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %18 = "glsl.builtin"(%17) <{func = 0x2e}> : (f32) -> f32
      %19 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %20 = "glsl.builtin"(%19) <{func = 0x2a}> : (f32) -> f32
      %21 = "arith.addf"(%18, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %22 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %23 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %24 = "glsl.builtin"(%22, %23) <{func = 0x2b}> : (f32, f32) -> f32
      %25 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %26 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %27 = "arith.mulf"(%25, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %28 = "arith.constant"() <{value = 2.500000e+00 : f32}> : () -> f32
      %29 = "arith.negf"(%28) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %30 = "glsl.builtin"(%29) <{func = 0x2a}> : (f32) -> f32
      %31 = "arith.addf"(%27, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %32 = "arith.constant"() <{value = 1.250000e+00 : f32}> : () -> f32
      %33 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %34 = "arith.negf"(%33) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %35 = "glsl.builtin"(%32, %34) <{func = 0x2b}> : (f32, f32) -> f32
      %36 = "arith.addf"(%31, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %37 = "arith.constant"() <{value = 7.500000e-01 : f32}> : () -> f32
      %38 = "arith.negf"(%37) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %39 = "glsl.builtin"(%38) <{func = 0x2e}> : (f32) -> f32
      %40 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %41 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %42 = "arith.mulf"(%40, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %43 = "arith.mulf"(%39, %42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %44 = "glsl.construct"(%21, %24, %36, %43) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%44) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
