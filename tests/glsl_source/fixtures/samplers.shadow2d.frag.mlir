"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 3 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %8 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %9 = "vector.shuffle"(%8, %8) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%7, %9) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %10 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %11 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %12 = "glsl.construct"(%11) : (f32) -> vector<2xf32>
      %13 = "arith.mulf"(%10, %12) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %14 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %15 = "glsl.construct"(%14) : (f32) -> vector<2xf32>
      %16 = "arith.subf"(%13, %15) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%6, %16) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %17 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %18 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %19 = "glsl.construct"(%18) : (f32) -> vector<2xf32>
      %20 = "arith.mulf"(%17, %19) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %21 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %22 = "glsl.construct"(%21) : (f32) -> vector<2xf32>
      %23 = "arith.subf"(%20, %22) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %24 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %25 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %26 = "vector.extract"(%25) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %27 = "arith.subf"(%24, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %28 = "glsl.construct"(%23, %27) : (vector<2xf32>, f32) -> vector<3xf32>
      %29 = "glsl.builtin"(%28) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%5, %29) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %30 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %31 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %32 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %33 = "glsl.construct"(%31, %32) : (vector<2xf32>, f32) -> vector<3xf32>
      %34 = "vector.shuffle"(%33, %33) <{mask = array<i64: 0, 1>}> : (vector<3xf32>, vector<3xf32>) -> vector<2xf32>
      %35 = "vector.extract"(%33) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %36 = "glsl.texture"(%30, %34, %35) <{dref, lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>, f32) -> f32
      "spirv.Store"(%4, %36) : (!spirv.ptr<f32, Function>, f32) -> ()
      %37 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %38 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %39 = "arith.constant"() <{value = 1.300000e+00 : f32}> : () -> f32
      %40 = "glsl.construct"(%39) : (f32) -> vector<2xf32>
      %41 = "arith.mulf"(%38, %40) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %42 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %43 = "vector.extract"(%42) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %44 = "arith.constant"() <{value = 1.300000e+00 : f32}> : () -> f32
      %45 = "glsl.construct"(%41, %43, %44) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      %46 = "vector.shuffle"(%45, %45) <{mask = array<i64: 0, 1, 3>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
      %47 = "vector.extract"(%45) <{static_position = array<i64: 2>}> : (vector<4xf32>) -> f32
      %48 = "glsl.texture"(%37, %46, %47) <{dref, lod = 0x0, proj}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>, f32) -> f32
      "spirv.Store"(%3, %48) : (!spirv.ptr<f32, Function>, f32) -> ()
      %49 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %50 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %51 = "arith.constant"() <{value = 4.000000e-01 : f32}> : () -> f32
      %52 = "glsl.construct"(%50, %51) : (vector<2xf32>, f32) -> vector<3xf32>
      %53 = "arith.constant"() <{value = dense<[-1, 2]> : vector<2xi32>}> : () -> vector<2xi32>
      %54 = "vector.shuffle"(%52, %52) <{mask = array<i64: 0, 1>}> : (vector<3xf32>, vector<3xf32>) -> vector<2xf32>
      %55 = "vector.extract"(%52) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %56 = "glsl.texture"(%49, %54, %55, %53) <{dref, lod = 0x0, offset}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>, f32, vector<2xi32>) -> f32
      "spirv.Store"(%2, %56) : (!spirv.ptr<f32, Function>, f32) -> ()
      %57 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %58 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %59 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %60 = "glsl.construct"(%58, %59) : (vector<2xf32>, f32) -> vector<3xf32>
      %61 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %62 = "vector.shuffle"(%60, %60) <{mask = array<i64: 0, 1>}> : (vector<3xf32>, vector<3xf32>) -> vector<2xf32>
      %63 = "vector.extract"(%60) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %64 = "glsl.texture"(%57, %62, %63, %61) <{dref, lod = 0x2}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>, f32, f32) -> f32
      "spirv.Store"(%1, %64) : (!spirv.ptr<f32, Function>, f32) -> ()
      %65 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %66 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %67 = "arith.constant"() <{value = 4.500000e-01 : f32}> : () -> f32
      %68 = "glsl.construct"(%66, %67) : (vector<2xf32>, f32) -> vector<3xf32>
      %69 = "arith.constant"() <{value = 3.000000e-02 : f32}> : () -> f32
      %70 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %71 = "glsl.construct"(%69, %70) : (f32, f32) -> vector<2xf32>
      %72 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %73 = "arith.constant"() <{value = 2.000000e-02 : f32}> : () -> f32
      %74 = "glsl.construct"(%72, %73) : (f32, f32) -> vector<2xf32>
      %75 = "vector.shuffle"(%68, %68) <{mask = array<i64: 0, 1>}> : (vector<3xf32>, vector<3xf32>) -> vector<2xf32>
      %76 = "vector.extract"(%68) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %77 = "glsl.texture"(%65, %75, %76, %71, %74) <{dref, lod = 0x3}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>, f32, vector<2xf32>, vector<2xf32>) -> f32
      "spirv.Store"(%0, %77) : (!spirv.ptr<f32, Function>, f32) -> ()
      %78 = "spirv.Load"(%4) : (!spirv.ptr<f32, Function>) -> f32
      %79 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
      %80 = "spirv.Load"(%2) : (!spirv.ptr<f32, Function>) -> f32
      %81 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %82 = "arith.addf"(%80, %81) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %83 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %84 = "glsl.construct"(%78, %79, %82, %83) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%84) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
