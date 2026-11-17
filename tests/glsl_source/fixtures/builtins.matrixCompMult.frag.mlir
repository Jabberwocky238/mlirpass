"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<2 x vector<2xf32>>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %10 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %11 = "vector.shuffle"(%10, %10) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%9, %11) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %12 = "spirv.Load"(%9) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %13 = "vector.extract"(%12) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %14 = "arith.constant"() <{value = 3.200000e+01 : f32}> : () -> f32
      %15 = "arith.subf"(%13, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %16 = "arith.constant"() <{value = 1.300000e+01 : f32}> : () -> f32
      %17 = "arith.divf"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%8, %17) : (!spirv.ptr<f32, Function>, f32) -> ()
      %18 = "spirv.Load"(%9) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %19 = "vector.extract"(%18) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %20 = "arith.constant"() <{value = 6.400000e+01 : f32}> : () -> f32
      %21 = "arith.divf"(%19, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %22 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %23 = "arith.addf"(%21, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%7, %23) : (!spirv.ptr<f32, Function>, f32) -> ()
      %24 = "spirv.Load"(%9) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %25 = "vector.extract"(%24) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %26 = "spirv.Load"(%9) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %27 = "vector.extract"(%26) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %28 = "arith.mulf"(%25, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %29 = "arith.constant"() <{value = 1.500000e+03 : f32}> : () -> f32
      %30 = "arith.subf"(%28, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %31 = "arith.constant"() <{value = 7.000000e+02 : f32}> : () -> f32
      %32 = "arith.divf"(%30, %31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%6, %32) : (!spirv.ptr<f32, Function>, f32) -> ()
      %33 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %34 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %35 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %36 = "glsl.construct"(%33, %34, %35) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%5, %36) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %37 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %38 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %39 = "arith.subf"(%37, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %40 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %41 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %42 = "arith.mulf"(%40, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %43 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %44 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %45 = "arith.mulf"(%43, %44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %46 = "glsl.construct"(%39, %42, %45) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%4, %46) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %47 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %48 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %49 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %50 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %51 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %52 = "arith.mulf"(%50, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %53 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %54 = "arith.addf"(%52, %53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %55 = "glsl.construct"(%47, %48) : (f32, f32) -> vector<2xf32>
      %56 = "glsl.construct"(%49, %54) : (f32, f32) -> vector<2xf32>
      %57 = "glsl.construct"(%55, %56) : (vector<2xf32>, vector<2xf32>) -> !spirv.matrix<2 x vector<2xf32>>
      "spirv.Store"(%3, %57) : (!spirv.ptr<!spirv.matrix<2 x vector<2xf32>>, Function>, !spirv.matrix<2 x vector<2xf32>>) -> ()
      %58 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %59 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %60 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %61 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %62 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %63 = "arith.addf"(%61, %62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %64 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %65 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %66 = "arith.mulf"(%64, %65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %67 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %68 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %69 = "arith.subf"(%67, %68) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %70 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %71 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %72 = "arith.mulf"(%70, %71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %73 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %74 = "arith.constant"() <{value = 1.250000e+00 : f32}> : () -> f32
      %75 = "glsl.construct"(%58, %59, %60) : (f32, f32, f32) -> vector<3xf32>
      %76 = "glsl.construct"(%63, %66, %69) : (f32, f32, f32) -> vector<3xf32>
      %77 = "glsl.construct"(%72, %73, %74) : (f32, f32, f32) -> vector<3xf32>
      %78 = "glsl.construct"(%75, %76, %77) : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> !spirv.matrix<3 x vector<3xf32>>
      "spirv.Store"(%2, %78) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, !spirv.matrix<3 x vector<3xf32>>) -> ()
      %79 = "spirv.Load"(%2) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>) -> !spirv.matrix<3 x vector<3xf32>>
      %80 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %81 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %82 = "spirv.CompositeExtract"(%79) <{indices = [0 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %83 = "vector.extract"(%82) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %84 = "vector.extract"(%82) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %85 = "vector.extract"(%82) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %86 = "glsl.construct"(%83, %84, %85, %81) : (f32, f32, f32, f32) -> vector<4xf32>
      %87 = "spirv.CompositeExtract"(%79) <{indices = [1 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %88 = "vector.extract"(%87) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %89 = "vector.extract"(%87) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %90 = "vector.extract"(%87) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %91 = "glsl.construct"(%88, %89, %90, %81) : (f32, f32, f32, f32) -> vector<4xf32>
      %92 = "spirv.CompositeExtract"(%79) <{indices = [2 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %93 = "vector.extract"(%92) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %94 = "vector.extract"(%92) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %95 = "vector.extract"(%92) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %96 = "glsl.construct"(%93, %94, %95, %81) : (f32, f32, f32, f32) -> vector<4xf32>
      %97 = "glsl.construct"(%81, %81, %81, %80) : (f32, f32, f32, f32) -> vector<4xf32>
      %98 = "glsl.construct"(%86, %91, %96, %97) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> !spirv.matrix<4 x vector<4xf32>>
      %99 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %100 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
      %101 = "arith.constant"() <{value = 2.000000e-01 : f32}> : () -> f32
      %102 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %103 = "arith.constant"() <{value = 4.000000e-01 : f32}> : () -> f32
      %104 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %105 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %106 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %107 = "arith.constant"() <{value = 8.000000e-01 : f32}> : () -> f32
      %108 = "arith.constant"() <{value = 0.899999976 : f32}> : () -> f32
      %109 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %110 = "arith.constant"() <{value = 1.100000e+00 : f32}> : () -> f32
      %111 = "arith.constant"() <{value = 1.200000e+00 : f32}> : () -> f32
      %112 = "arith.constant"() <{value = 1.300000e+00 : f32}> : () -> f32
      %113 = "arith.constant"() <{value = 1.400000e+00 : f32}> : () -> f32
      %114 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %115 = "glsl.construct"(%99, %100, %101, %102) : (f32, f32, f32, f32) -> vector<4xf32>
      %116 = "glsl.construct"(%103, %104, %105, %106) : (f32, f32, f32, f32) -> vector<4xf32>
      %117 = "glsl.construct"(%107, %108, %109, %110) : (f32, f32, f32, f32) -> vector<4xf32>
      %118 = "glsl.construct"(%111, %112, %113, %114) : (f32, f32, f32, f32) -> vector<4xf32>
      %119 = "glsl.construct"(%115, %116, %117, %118) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> !spirv.matrix<4 x vector<4xf32>>
      %120 = "spirv.CompositeExtract"(%98) <{indices = [0 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %121 = "spirv.CompositeExtract"(%119) <{indices = [0 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %122 = "arith.addf"(%120, %121) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %123 = "spirv.CompositeExtract"(%98) <{indices = [1 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %124 = "spirv.CompositeExtract"(%119) <{indices = [1 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %125 = "arith.addf"(%123, %124) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %126 = "spirv.CompositeExtract"(%98) <{indices = [2 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %127 = "spirv.CompositeExtract"(%119) <{indices = [2 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %128 = "arith.addf"(%126, %127) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %129 = "spirv.CompositeExtract"(%98) <{indices = [3 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %130 = "spirv.CompositeExtract"(%119) <{indices = [3 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %131 = "arith.addf"(%129, %130) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %132 = "glsl.construct"(%122, %125, %128, %131) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> !spirv.matrix<4 x vector<4xf32>>
      "spirv.Store"(%1, %132) : (!spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>, !spirv.matrix<4 x vector<4xf32>>) -> ()
      %133 = "spirv.Load"(%2) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>) -> !spirv.matrix<3 x vector<3xf32>>
      %134 = "spirv.Load"(%2) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>) -> !spirv.matrix<3 x vector<3xf32>>
      %135 = "spirv.CompositeExtract"(%133) <{indices = [0 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %136 = "spirv.CompositeExtract"(%134) <{indices = [0 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %137 = "arith.mulf"(%135, %136) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %138 = "spirv.CompositeExtract"(%133) <{indices = [1 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %139 = "spirv.CompositeExtract"(%134) <{indices = [1 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %140 = "arith.mulf"(%138, %139) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %141 = "spirv.CompositeExtract"(%133) <{indices = [2 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %142 = "spirv.CompositeExtract"(%134) <{indices = [2 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %143 = "arith.mulf"(%141, %142) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %144 = "glsl.construct"(%137, %140, %143) : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> !spirv.matrix<3 x vector<3xf32>>
      "spirv.Store"(%0, %144) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, !spirv.matrix<3 x vector<3xf32>>) -> ()
      %145 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %146 = "spirv.AccessChain"(%0, %145) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      %147 = "spirv.Load"(%146) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %148 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %149 = "spirv.AccessChain"(%0, %148) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      %150 = "spirv.Load"(%149) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %151 = "arith.addf"(%147, %150) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %152 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %153 = "spirv.AccessChain"(%0, %152) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      %154 = "spirv.Load"(%153) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %155 = "arith.addf"(%151, %154) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %156 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %157 = "glsl.construct"(%155, %156) : (vector<3xf32>, f32) -> vector<4xf32>
      "glsl.store"(%157) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
