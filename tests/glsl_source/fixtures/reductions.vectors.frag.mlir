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
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.array<2 x f32>, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %10 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %11 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %12 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %13 = "vector.shuffle"(%12, %12) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%11, %13) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %14 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %15 = "vector.extract"(%14) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %16 = "arith.constant"() <{value = 1234.56702 : f32}> : () -> f32
      %17 = "arith.mulf"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%10, %17) : (!spirv.ptr<f32, Function>, f32) -> ()
      %18 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %19 = "vector.extract"(%18) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %20 = "arith.constant"() <{value = 7.310000e-04 : f32}> : () -> f32
      %21 = "arith.mulf"(%19, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%9, %21) : (!spirv.ptr<f32, Function>, f32) -> ()
      %22 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %23 = "vector.extract"(%22) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %24 = "glsl.builtin"(%23) <{func = 0x2}> : (f32) -> f32
      %25 = "arith.constant"() <{value = 77.6999969 : f32}> : () -> f32
      %26 = "arith.mulf"(%24, %25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%8, %26) : (!spirv.ptr<f32, Function>, f32) -> ()
      %27 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %28 = "vector.extract"(%27) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %29 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %30 = "vector.extract"(%29) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %31 = "arith.mulf"(%28, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %32 = "arith.constant"() <{value = 3.700000e-01 : f32}> : () -> f32
      %33 = "arith.mulf"(%31, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%7, %33) : (!spirv.ptr<f32, Function>, f32) -> ()
      %34 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %35 = "vector.extract"(%34) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %36 = "glsl.builtin"(%35) <{func = 0x3}> : (f32) -> f32
      %37 = "arith.constant"() <{value = 1.230000e-02 : f32}> : () -> f32
      %38 = "arith.mulf"(%36, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%6, %38) : (!spirv.ptr<f32, Function>, f32) -> ()
      %39 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %40 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %41 = "spirv.AccessChain"(%5, %39) : (!spirv.ptr<!spirv.array<2 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%41, %40) : (!spirv.ptr<f32, Function>, f32) -> ()
      %42 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %43 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %44 = "spirv.AccessChain"(%5, %42) : (!spirv.ptr<!spirv.array<2 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%44, %43) : (!spirv.ptr<f32, Function>, f32) -> ()
      %45 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
      %46 = "spirv.Load"(%9) : (!spirv.ptr<f32, Function>) -> f32
      %47 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %48 = "glsl.construct"(%45, %46, %47) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%4, %48) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %49 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %50 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %51 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
      %52 = "glsl.construct"(%49, %50, %51) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%3, %52) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %53 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %54 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %55 = "spirv.Load"(%9) : (!spirv.ptr<f32, Function>) -> f32
      %56 = "glsl.construct"(%53, %54, %55) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%2, %56) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %57 = "spirv.Load"(%4) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %58 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %59 = "arith.addf"(%57, %58) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %60 = "spirv.Load"(%2) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %61 = "arith.addf"(%59, %60) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %62 = "spirv.Load"(%4) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %63 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %64 = "glsl.construct"(%63) : (f32) -> vector<3xf32>
      %65 = "arith.mulf"(%62, %64) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %66 = "arith.addf"(%61, %65) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %67 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %68 = "arith.addf"(%66, %67) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%1, %68) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %69 = "spirv.Load"(%4) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %70 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %71 = "arith.addf"(%69, %70) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %72 = "spirv.Load"(%2) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %73 = "arith.addf"(%71, %72) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %74 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %75 = "arith.addf"(%73, %74) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %76 = "spirv.Load"(%4) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %77 = "arith.addf"(%75, %76) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%0, %77) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %78 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %79 = "vector.extract"(%78) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %80 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %81 = "vector.extract"(%80) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %82 = "arith.addf"(%79, %81) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %83 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %84 = "vector.extract"(%83) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %85 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %86 = "vector.extract"(%85) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %87 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %88 = "vector.extract"(%87) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %89 = "glsl.construct"(%82, %84, %86, %88) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%89) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
