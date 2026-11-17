"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 6 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xi32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xi32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xi32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %6 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %7 = "vector.shuffle"(%6, %6) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%5, %7) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %8 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %9 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %10 = "glsl.construct"(%9) : (f32) -> vector<2xf32>
      %11 = "arith.mulf"(%8, %10) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %12 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %13 = "glsl.construct"(%12) : (f32) -> vector<2xf32>
      %14 = "arith.subf"(%11, %13) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%4, %14) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %15 = "spirv.Load"(%4) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %16 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %17 = "glsl.construct"(%16) : (f32) -> vector<2xf32>
      %18 = "arith.mulf"(%15, %17) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %19 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %20 = "glsl.construct"(%19) : (f32) -> vector<2xf32>
      %21 = "arith.subf"(%18, %20) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %22 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %23 = "spirv.Load"(%4) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %24 = "vector.extract"(%23) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %25 = "arith.subf"(%22, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %26 = "glsl.construct"(%21, %25) : (vector<2xf32>, f32) -> vector<3xf32>
      %27 = "glsl.builtin"(%26) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%3, %27) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %28 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %29 = "spirv.Load"(%4) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %30 = "glsl.texture"(%28, %29) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xi32>
      "spirv.Store"(%2, %30) : (!spirv.ptr<vector<4xi32>, Function>, vector<4xi32>) -> ()
      %31 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %32 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %33 = "arith.fptosi"(%32) : (vector<2xf32>) -> vector<2xi32>
      %34 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %35 = "glsl.construct"(%34) : (i32) -> vector<2xi32>
      %36 = "arith.divsi"(%33, %35) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
      %37 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %38 = "glsl.texel_fetch"(%31, %36, %37) : (!spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xi32>, i32) -> vector<4xi32>
      "spirv.Store"(%1, %38) : (!spirv.ptr<vector<4xi32>, Function>, vector<4xi32>) -> ()
      %39 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %40 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %41 = "arith.fptosi"(%40) : (vector<2xf32>) -> vector<2xi32>
      %42 = "arith.constant"() <{value = 5 : i32}> : () -> i32
      %43 = "glsl.construct"(%42) : (i32) -> vector<2xi32>
      %44 = "arith.divsi"(%41, %43) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
      %45 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %46 = "arith.constant"() <{value = dense<[1, 2]> : vector<2xi32>}> : () -> vector<2xi32>
      %47 = "glsl.texel_fetch"(%39, %44, %45, %46) <{offset}> : (!spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xi32>, i32, vector<2xi32>) -> vector<4xi32>
      "spirv.Store"(%0, %47) : (!spirv.ptr<vector<4xi32>, Function>, vector<4xi32>) -> ()
      %48 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xi32>, Function>) -> vector<4xi32>
      %49 = "arith.sitofp"(%48) : (vector<4xi32>) -> vector<4xf32>
      %50 = "arith.constant"() <{value = 1.280000e+02 : f32}> : () -> f32
      %51 = "glsl.construct"(%50) : (f32) -> vector<4xf32>
      %52 = "arith.divf"(%49, %51) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %53 = "spirv.Load"(%1) : (!spirv.ptr<vector<4xi32>, Function>) -> vector<4xi32>
      %54 = "spirv.Load"(%0) : (!spirv.ptr<vector<4xi32>, Function>) -> vector<4xi32>
      %55 = "arith.subi"(%53, %54) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
      %56 = "arith.sitofp"(%55) : (vector<4xi32>) -> vector<4xf32>
      %57 = "arith.constant"() <{value = 2.560000e+02 : f32}> : () -> f32
      %58 = "glsl.construct"(%57) : (f32) -> vector<4xf32>
      %59 = "arith.divf"(%56, %58) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %60 = "arith.addf"(%52, %59) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%60) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
