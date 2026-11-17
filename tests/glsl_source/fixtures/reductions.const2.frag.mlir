"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.array<2 x f32>, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %10 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %11 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %12 = "vector.shuffle"(%11, %11) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%10, %12) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %13 = "spirv.Load"(%10) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %14 = "vector.extract"(%13) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %15 = "arith.constant"() <{value = 1234.56702 : f32}> : () -> f32
      %16 = "arith.mulf"(%14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%9, %16) : (!spirv.ptr<f32, Function>, f32) -> ()
      %17 = "spirv.Load"(%10) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %18 = "vector.extract"(%17) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %19 = "arith.constant"() <{value = 7.310000e-04 : f32}> : () -> f32
      %20 = "arith.mulf"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%8, %20) : (!spirv.ptr<f32, Function>, f32) -> ()
      %21 = "spirv.Load"(%10) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %22 = "vector.extract"(%21) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %23 = "glsl.builtin"(%22) <{func = 0x2}> : (f32) -> f32
      %24 = "arith.constant"() <{value = 77.6999969 : f32}> : () -> f32
      %25 = "arith.mulf"(%23, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%7, %25) : (!spirv.ptr<f32, Function>, f32) -> ()
      %26 = "spirv.Load"(%10) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %27 = "vector.extract"(%26) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %28 = "spirv.Load"(%10) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %29 = "vector.extract"(%28) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %30 = "arith.mulf"(%27, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %31 = "arith.constant"() <{value = 3.700000e-01 : f32}> : () -> f32
      %32 = "arith.mulf"(%30, %31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%6, %32) : (!spirv.ptr<f32, Function>, f32) -> ()
      %33 = "spirv.Load"(%10) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %34 = "vector.extract"(%33) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %35 = "glsl.builtin"(%34) <{func = 0x3}> : (f32) -> f32
      %36 = "arith.constant"() <{value = 1.230000e-02 : f32}> : () -> f32
      %37 = "arith.mulf"(%35, %36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%5, %37) : (!spirv.ptr<f32, Function>, f32) -> ()
      %38 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %39 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %40 = "spirv.AccessChain"(%4, %38) : (!spirv.ptr<!spirv.array<2 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%40, %39) : (!spirv.ptr<f32, Function>, f32) -> ()
      %41 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %42 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %43 = "spirv.AccessChain"(%4, %41) : (!spirv.ptr<!spirv.array<2 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%43, %42) : (!spirv.ptr<f32, Function>, f32) -> ()
      %44 = "spirv.Load"(%9) : (!spirv.ptr<f32, Function>) -> f32
      %45 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %46 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %47 = "glsl.construct"(%44, %45, %46) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%3, %47) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %48 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %49 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %50 = "spirv.Load"(%9) : (!spirv.ptr<f32, Function>) -> f32
      %51 = "glsl.construct"(%48, %49, %50) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%2, %51) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %52 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %53 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %54 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %55 = "glsl.construct"(%52, %53, %54) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%1, %55) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %56 = "spirv.Load"(%9) : (!spirv.ptr<f32, Function>) -> f32
      %57 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %58 = "arith.addf"(%56, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %59 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %60 = "arith.addf"(%58, %59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %61 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %62 = "arith.addf"(%60, %61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %63 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %64 = "arith.addf"(%62, %63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %65 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %66 = "arith.addf"(%64, %65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %67 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %68 = "arith.addf"(%66, %67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%0, %68) : (!spirv.ptr<f32, Function>, f32) -> ()
      %69 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %70 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %71 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %72 = "arith.mulf"(%70, %71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %73 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %74 = "arith.negf"(%73) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %75 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %76 = "glsl.construct"(%69, %72, %74, %75) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%76) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
