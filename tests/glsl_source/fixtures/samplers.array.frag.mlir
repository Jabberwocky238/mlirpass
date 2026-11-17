"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 2 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xi32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
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
      %30 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>
      %31 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %32 = "arith.constant"() <{value = 2.200000e+00 : f32}> : () -> f32
      %33 = "glsl.construct"(%31, %32) : (vector<2xf32>, f32) -> vector<3xf32>
      %34 = "glsl.texture"(%30, %33) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>) -> vector<4xf32>
      "spirv.Store"(%4, %34) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %35 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>
      %36 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %37 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %38 = "vector.extract"(%37) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %39 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      %40 = "arith.mulf"(%38, %39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %41 = "glsl.construct"(%36, %40) : (vector<2xf32>, f32) -> vector<3xf32>
      %42 = "arith.constant"() <{value = 8.000000e-01 : f32}> : () -> f32
      %43 = "glsl.texture"(%35, %41, %42) <{lod = 0x2}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>, f32) -> vector<4xf32>
      "spirv.Store"(%3, %43) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %44 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>
      %45 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %46 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %47 = "glsl.construct"(%45, %46) : (vector<2xf32>, f32) -> vector<3xf32>
      %48 = "arith.constant"() <{value = dense<[2, -1]> : vector<2xi32>}> : () -> vector<2xi32>
      %49 = "glsl.texture"(%44, %47, %48) <{lod = 0x0, offset}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>, vector<2xi32>) -> vector<4xf32>
      "spirv.Store"(%2, %49) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %50 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>
      %51 = "spirv.Load"(%7) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %52 = "arith.fptosi"(%51) : (vector<2xf32>) -> vector<2xi32>
      %53 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %54 = "glsl.construct"(%53) : (i32) -> vector<2xi32>
      %55 = "arith.divsi"(%52, %54) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
      %56 = "arith.constant"() <{value = 3 : i32}> : () -> i32
      %57 = "glsl.construct"(%55, %56) : (vector<2xi32>, i32) -> vector<3xi32>
      %58 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %59 = "glsl.texel_fetch"(%50, %57, %58) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xi32>, i32) -> vector<4xf32>
      "spirv.Store"(%1, %59) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %60 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>
      %61 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %62 = "glsl.texture_size"(%60, %61) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>, i32) -> vector<3xi32>
      "spirv.Store"(%0, %62) : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      %63 = "spirv.Load"(%4) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %64 = "spirv.Load"(%3) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %65 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %66 = "glsl.construct"(%65) : (f32) -> vector<4xf32>
      %67 = "arith.mulf"(%64, %66) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %68 = "arith.addf"(%63, %67) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %69 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %70 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %71 = "glsl.construct"(%70) : (f32) -> vector<4xf32>
      %72 = "arith.mulf"(%69, %71) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %73 = "arith.addf"(%68, %72) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %74 = "spirv.Load"(%1) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %75 = "arith.constant"() <{value = 1.250000e-01 : f32}> : () -> f32
      %76 = "glsl.construct"(%75) : (f32) -> vector<4xf32>
      %77 = "arith.mulf"(%74, %76) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %78 = "arith.addf"(%73, %77) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %79 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xi32>, Function>) -> vector<3xi32>
      %80 = "arith.sitofp"(%79) : (vector<3xi32>) -> vector<3xf32>
      %81 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %82 = "glsl.construct"(%80, %81) : (vector<3xf32>, f32) -> vector<4xf32>
      %83 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %84 = "glsl.construct"(%83) : (f32) -> vector<4xf32>
      %85 = "arith.mulf"(%82, %84) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %86 = "arith.addf"(%78, %85) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%86) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
