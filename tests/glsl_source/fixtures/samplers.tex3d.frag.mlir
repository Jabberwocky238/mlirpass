"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 0 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xi32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %7 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %8 = "vector.shuffle"(%7, %7) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%6, %8) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %9 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %10 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %11 = "glsl.construct"(%10) : (f32) -> vector<2xf32>
      %12 = "arith.mulf"(%9, %11) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %13 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %14 = "glsl.construct"(%13) : (f32) -> vector<2xf32>
      %15 = "arith.subf"(%12, %14) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%5, %15) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %16 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %17 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %18 = "glsl.construct"(%17) : (f32) -> vector<2xf32>
      %19 = "arith.mulf"(%16, %18) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %20 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %21 = "glsl.construct"(%20) : (f32) -> vector<2xf32>
      %22 = "arith.subf"(%19, %21) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %23 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %24 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %25 = "vector.extract"(%24) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %26 = "arith.subf"(%23, %25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %27 = "glsl.construct"(%22, %26) : (vector<2xf32>, f32) -> vector<3xf32>
      %28 = "glsl.builtin"(%27) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%4, %28) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %29 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %30 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %31 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %32 = "vector.extract"(%31) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %33 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %34 = "arith.mulf"(%32, %33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %35 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
      %36 = "arith.addf"(%34, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %37 = "glsl.construct"(%30, %36) : (vector<2xf32>, f32) -> vector<3xf32>
      %38 = "glsl.texture"(%29, %37) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>) -> vector<4xf32>
      "spirv.Store"(%3, %38) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %39 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %40 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %41 = "vector.shuffle"(%40, %40) <{mask = array<i64: 1, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %42 = "arith.constant"() <{value = 4.000000e-01 : f32}> : () -> f32
      %43 = "glsl.construct"(%41, %42) : (vector<2xf32>, f32) -> vector<3xf32>
      %44 = "arith.constant"() <{value = 1.300000e+00 : f32}> : () -> f32
      %45 = "glsl.texture"(%39, %43, %44) <{lod = 0x2}> : (!spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>, f32) -> vector<4xf32>
      "spirv.Store"(%2, %45) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %46 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %47 = "spirv.Load"(%6) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %48 = "arith.fptosi"(%47) : (vector<2xf32>) -> vector<2xi32>
      %49 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %50 = "glsl.construct"(%49) : (i32) -> vector<2xi32>
      %51 = "arith.divsi"(%48, %50) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
      %52 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %53 = "glsl.construct"(%51, %52) : (vector<2xi32>, i32) -> vector<3xi32>
      %54 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %55 = "glsl.texel_fetch"(%46, %53, %54) : (!spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xi32>, i32) -> vector<4xf32>
      "spirv.Store"(%1, %55) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %56 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %57 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %58 = "glsl.texture_size"(%56, %57) : (!spirv.sampled_image<!spirv.image<f32, Dim3D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, i32) -> vector<3xi32>
      "spirv.Store"(%0, %58) : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      %59 = "spirv.Load"(%3) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %60 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %61 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %62 = "glsl.construct"(%61) : (f32) -> vector<4xf32>
      %63 = "arith.mulf"(%60, %62) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %64 = "arith.addf"(%59, %63) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %65 = "spirv.Load"(%1) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %66 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %67 = "glsl.construct"(%66) : (f32) -> vector<4xf32>
      %68 = "arith.mulf"(%65, %67) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %69 = "arith.addf"(%64, %68) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %70 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xi32>, Function>) -> vector<3xi32>
      %71 = "arith.sitofp"(%70) : (vector<3xi32>) -> vector<3xf32>
      %72 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %73 = "glsl.construct"(%71, %72) : (vector<3xf32>, f32) -> vector<4xf32>
      %74 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %75 = "glsl.construct"(%74) : (f32) -> vector<4xf32>
      %76 = "arith.mulf"(%73, %75) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %77 = "arith.addf"(%69, %76) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%77) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
