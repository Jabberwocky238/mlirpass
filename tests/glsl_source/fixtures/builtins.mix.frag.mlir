"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<2 x vector<2xf32>>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %9 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %10 = "vector.shuffle"(%9, %9) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%8, %10) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %11 = "spirv.Load"(%8) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %12 = "vector.extract"(%11) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %13 = "arith.constant"() <{value = 3.200000e+01 : f32}> : () -> f32
      %14 = "arith.subf"(%12, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %15 = "arith.constant"() <{value = 1.300000e+01 : f32}> : () -> f32
      %16 = "arith.divf"(%14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%7, %16) : (!spirv.ptr<f32, Function>, f32) -> ()
      %17 = "spirv.Load"(%8) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %18 = "vector.extract"(%17) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %19 = "arith.constant"() <{value = 6.400000e+01 : f32}> : () -> f32
      %20 = "arith.divf"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %21 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %22 = "arith.addf"(%20, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%6, %22) : (!spirv.ptr<f32, Function>, f32) -> ()
      %23 = "spirv.Load"(%8) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %24 = "vector.extract"(%23) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %25 = "spirv.Load"(%8) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %26 = "vector.extract"(%25) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %27 = "arith.mulf"(%24, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %28 = "arith.constant"() <{value = 1.500000e+03 : f32}> : () -> f32
      %29 = "arith.subf"(%27, %28) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %30 = "arith.constant"() <{value = 7.000000e+02 : f32}> : () -> f32
      %31 = "arith.divf"(%29, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%5, %31) : (!spirv.ptr<f32, Function>, f32) -> ()
      %32 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %33 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %34 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %35 = "glsl.construct"(%32, %33, %34) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%4, %35) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %36 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %37 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %38 = "arith.subf"(%36, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %39 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %40 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %41 = "arith.mulf"(%39, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %42 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %43 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %44 = "arith.mulf"(%42, %43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %45 = "glsl.construct"(%38, %41, %44) : (f32, f32, f32) -> vector<3xf32>
      "spirv.Store"(%3, %45) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %46 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %47 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %48 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %49 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %50 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %51 = "arith.mulf"(%49, %50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %52 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %53 = "arith.addf"(%51, %52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %54 = "glsl.construct"(%46, %47) : (f32, f32) -> vector<2xf32>
      %55 = "glsl.construct"(%48, %53) : (f32, f32) -> vector<2xf32>
      %56 = "glsl.construct"(%54, %55) : (vector<2xf32>, vector<2xf32>) -> !spirv.matrix<2 x vector<2xf32>>
      "spirv.Store"(%2, %56) : (!spirv.ptr<!spirv.matrix<2 x vector<2xf32>>, Function>, !spirv.matrix<2 x vector<2xf32>>) -> ()
      %57 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %58 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %59 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %60 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %61 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %62 = "arith.addf"(%60, %61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %63 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %64 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %65 = "arith.mulf"(%63, %64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %66 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %67 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %68 = "arith.subf"(%66, %67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %69 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %70 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %71 = "arith.mulf"(%69, %70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %72 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %73 = "arith.constant"() <{value = 1.250000e+00 : f32}> : () -> f32
      %74 = "glsl.construct"(%57, %58, %59) : (f32, f32, f32) -> vector<3xf32>
      %75 = "glsl.construct"(%62, %65, %68) : (f32, f32, f32) -> vector<3xf32>
      %76 = "glsl.construct"(%71, %72, %73) : (f32, f32, f32) -> vector<3xf32>
      %77 = "glsl.construct"(%74, %75, %76) : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> !spirv.matrix<3 x vector<3xf32>>
      "spirv.Store"(%1, %77) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, !spirv.matrix<3 x vector<3xf32>>) -> ()
      %78 = "spirv.Load"(%1) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>) -> !spirv.matrix<3 x vector<3xf32>>
      %79 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %80 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %81 = "spirv.CompositeExtract"(%78) <{indices = [0 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %82 = "vector.extract"(%81) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %83 = "vector.extract"(%81) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %84 = "vector.extract"(%81) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %85 = "glsl.construct"(%82, %83, %84, %80) : (f32, f32, f32, f32) -> vector<4xf32>
      %86 = "spirv.CompositeExtract"(%78) <{indices = [1 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %87 = "vector.extract"(%86) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %88 = "vector.extract"(%86) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %89 = "vector.extract"(%86) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %90 = "glsl.construct"(%87, %88, %89, %80) : (f32, f32, f32, f32) -> vector<4xf32>
      %91 = "spirv.CompositeExtract"(%78) <{indices = [2 : i32]}> : (!spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %92 = "vector.extract"(%91) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %93 = "vector.extract"(%91) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %94 = "vector.extract"(%91) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %95 = "glsl.construct"(%92, %93, %94, %80) : (f32, f32, f32, f32) -> vector<4xf32>
      %96 = "glsl.construct"(%80, %80, %80, %79) : (f32, f32, f32, f32) -> vector<4xf32>
      %97 = "glsl.construct"(%85, %90, %95, %96) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> !spirv.matrix<4 x vector<4xf32>>
      %98 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %99 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
      %100 = "arith.constant"() <{value = 2.000000e-01 : f32}> : () -> f32
      %101 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %102 = "arith.constant"() <{value = 4.000000e-01 : f32}> : () -> f32
      %103 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %104 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %105 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %106 = "arith.constant"() <{value = 8.000000e-01 : f32}> : () -> f32
      %107 = "arith.constant"() <{value = 0.899999976 : f32}> : () -> f32
      %108 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %109 = "arith.constant"() <{value = 1.100000e+00 : f32}> : () -> f32
      %110 = "arith.constant"() <{value = 1.200000e+00 : f32}> : () -> f32
      %111 = "arith.constant"() <{value = 1.300000e+00 : f32}> : () -> f32
      %112 = "arith.constant"() <{value = 1.400000e+00 : f32}> : () -> f32
      %113 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %114 = "glsl.construct"(%98, %99, %100, %101) : (f32, f32, f32, f32) -> vector<4xf32>
      %115 = "glsl.construct"(%102, %103, %104, %105) : (f32, f32, f32, f32) -> vector<4xf32>
      %116 = "glsl.construct"(%106, %107, %108, %109) : (f32, f32, f32, f32) -> vector<4xf32>
      %117 = "glsl.construct"(%110, %111, %112, %113) : (f32, f32, f32, f32) -> vector<4xf32>
      %118 = "glsl.construct"(%114, %115, %116, %117) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> !spirv.matrix<4 x vector<4xf32>>
      %119 = "spirv.CompositeExtract"(%97) <{indices = [0 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %120 = "spirv.CompositeExtract"(%118) <{indices = [0 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %121 = "arith.addf"(%119, %120) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %122 = "spirv.CompositeExtract"(%97) <{indices = [1 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %123 = "spirv.CompositeExtract"(%118) <{indices = [1 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %124 = "arith.addf"(%122, %123) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %125 = "spirv.CompositeExtract"(%97) <{indices = [2 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %126 = "spirv.CompositeExtract"(%118) <{indices = [2 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %127 = "arith.addf"(%125, %126) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %128 = "spirv.CompositeExtract"(%97) <{indices = [3 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %129 = "spirv.CompositeExtract"(%118) <{indices = [3 : i32]}> : (!spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %130 = "arith.addf"(%128, %129) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %131 = "glsl.construct"(%121, %124, %127, %130) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> !spirv.matrix<4 x vector<4xf32>>
      "spirv.Store"(%0, %131) : (!spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>, !spirv.matrix<4 x vector<4xf32>>) -> ()
      %132 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %133 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %134 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %135 = "glsl.builtin"(%132, %133, %134) <{func = 0x25}> : (f32, f32, f32) -> f32
      %136 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %137 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %138 = "glsl.builtin"(%136, %137) <{func = 0x26}> : (f32, f32) -> f32
      %139 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %140 = "arith.negf"(%139) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %141 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %142 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %143 = "glsl.builtin"(%140, %141, %142) <{func = 0x27}> : (f32, f32, f32) -> f32
      %144 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %145 = "glsl.construct"(%135, %138, %143, %144) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%145) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
