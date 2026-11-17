"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 1 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xi32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
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
      %28 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %29 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %30 = "glsl.texture"(%28, %29) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>) -> vector<4xf32>
      "spirv.Store"(%2, %30) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %31 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %32 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %33 = "vector.shuffle"(%32, %32) <{mask = array<i64: 2, 0, 1>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %34 = "arith.constant"() <{value = 2.200000e+00 : f32}> : () -> f32
      %35 = "glsl.texture"(%31, %33, %34) <{lod = 0x2}> : (!spirv.sampled_image<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>, f32) -> vector<4xf32>
      "spirv.Store"(%1, %35) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %36 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %37 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %38 = "glsl.texture_size"(%36, %37) : (!spirv.sampled_image<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, i32) -> vector<2xi32>
      "spirv.Store"(%0, %38) : (!spirv.ptr<vector<2xi32>, Function>, vector<2xi32>) -> ()
      %39 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %40 = "spirv.Load"(%1) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %41 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %42 = "glsl.construct"(%41) : (f32) -> vector<4xf32>
      %43 = "arith.mulf"(%40, %42) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %44 = "arith.addf"(%39, %43) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %45 = "spirv.Load"(%0) : (!spirv.ptr<vector<2xi32>, Function>) -> vector<2xi32>
      %46 = "arith.sitofp"(%45) : (vector<2xi32>) -> vector<2xf32>
      %47 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %48 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %49 = "glsl.construct"(%46, %47, %48) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      %50 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %51 = "glsl.construct"(%50) : (f32) -> vector<4xf32>
      %52 = "arith.mulf"(%49, %51) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %53 = "arith.addf"(%44, %52) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%53) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
