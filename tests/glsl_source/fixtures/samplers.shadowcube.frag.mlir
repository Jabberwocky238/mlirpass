"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 4 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Cube, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %5 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %6 = "vector.shuffle"(%5, %5) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%4, %6) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %7 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %8 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %9 = "glsl.construct"(%8) : (f32) -> vector<2xf32>
      %10 = "arith.mulf"(%7, %9) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %11 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %12 = "glsl.construct"(%11) : (f32) -> vector<2xf32>
      %13 = "arith.subf"(%10, %12) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%3, %13) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %14 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %15 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %16 = "glsl.construct"(%15) : (f32) -> vector<2xf32>
      %17 = "arith.mulf"(%14, %16) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %18 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %19 = "glsl.construct"(%18) : (f32) -> vector<2xf32>
      %20 = "arith.subf"(%17, %19) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %21 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %22 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %23 = "vector.extract"(%22) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %24 = "arith.subf"(%21, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %25 = "glsl.construct"(%20, %24) : (vector<2xf32>, f32) -> vector<3xf32>
      %26 = "glsl.builtin"(%25) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%2, %26) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %27 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Cube, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %28 = "spirv.Load"(%2) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %29 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %30 = "glsl.construct"(%28, %29) : (vector<3xf32>, f32) -> vector<4xf32>
      %31 = "vector.shuffle"(%30, %30) <{mask = array<i64: 0, 1, 2>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
      %32 = "vector.extract"(%30) <{static_position = array<i64: 3>}> : (vector<4xf32>) -> f32
      %33 = "glsl.texture"(%27, %31, %32) <{dref, lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Cube, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>, f32) -> f32
      "spirv.Store"(%1, %33) : (!spirv.ptr<f32, Function>, f32) -> ()
      %34 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Cube, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %35 = "spirv.Load"(%2) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %36 = "vector.shuffle"(%35, %35) <{mask = array<i64: 1, 2, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %37 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %38 = "vector.extract"(%37) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %39 = "glsl.construct"(%36, %38) : (vector<3xf32>, f32) -> vector<4xf32>
      %40 = "vector.shuffle"(%39, %39) <{mask = array<i64: 0, 1, 2>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
      %41 = "vector.extract"(%39) <{static_position = array<i64: 3>}> : (vector<4xf32>) -> f32
      %42 = "glsl.texture"(%34, %40, %41) <{dref, lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Cube, IsDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>, f32) -> f32
      "spirv.Store"(%0, %42) : (!spirv.ptr<f32, Function>, f32) -> ()
      %43 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %44 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %45 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %46 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %47 = "arith.mulf"(%45, %46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %48 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %49 = "glsl.construct"(%43, %44, %47, %48) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%49) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
