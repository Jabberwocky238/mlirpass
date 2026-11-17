"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 2 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %4 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %5 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %6 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      %7 = "glsl.construct"(%6) : (f32) -> vector<2xf32>
      %8 = "arith.mulf"(%5, %7) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %9 = "glsl.texture"(%4, %8) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xf32>
      "spirv.Store"(%3, %9) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %10 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %11 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %12 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %13 = "glsl.texture"(%10, %11, %12) <{lod = 0x2}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>, f32) -> vector<4xf32>
      "spirv.Store"(%2, %13) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %14 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %15 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %16 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %17 = "glsl.construct"(%16) : (f32) -> vector<2xf32>
      %18 = "arith.mulf"(%15, %17) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %19 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %20 = "glsl.texture"(%14, %18, %19) <{lod = 0x1}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>, f32) -> vector<4xf32>
      "spirv.Store"(%1, %20) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %21 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %22 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %23 = "vector.shuffle"(%22, %22) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      %24 = "arith.fptosi"(%23) : (vector<2xf32>) -> vector<2xi32>
      %25 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %26 = "glsl.construct"(%25) : (i32) -> vector<2xi32>
      %27 = "arith.divsi"(%24, %26) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
      %28 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %29 = "glsl.texel_fetch"(%21, %27, %28) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xi32>, i32) -> vector<4xf32>
      "spirv.Store"(%0, %29) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %30 = "spirv.Load"(%3) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %31 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %32 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %33 = "glsl.construct"(%32) : (f32) -> vector<4xf32>
      %34 = "arith.mulf"(%31, %33) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %35 = "arith.addf"(%30, %34) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %36 = "spirv.Load"(%1) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %37 = "arith.constant"() <{value = 1.250000e-01 : f32}> : () -> f32
      %38 = "glsl.construct"(%37) : (f32) -> vector<4xf32>
      %39 = "arith.mulf"(%36, %38) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %40 = "arith.addf"(%35, %39) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %41 = "spirv.Load"(%0) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %42 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %43 = "glsl.construct"(%42) : (f32) -> vector<4xf32>
      %44 = "arith.mulf"(%41, %43) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %45 = "arith.addf"(%40, %44) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%45) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
