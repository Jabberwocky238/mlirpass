"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 0 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xi32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xi32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %4 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %5 = "vector.shuffle"(%4, %4) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%3, %5) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %6 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %7 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      %8 = "glsl.construct"(%7) : (f32) -> vector<2xf32>
      %9 = "arith.mulf"(%6, %8) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %10 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %11 = "glsl.construct"(%10) : (f32) -> vector<2xf32>
      %12 = "arith.subf"(%9, %11) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%2, %12) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %13 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %14 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %15 = "glsl.texture_size"(%13, %14) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, i32) -> vector<2xi32>
      "spirv.Store"(%1, %15) : (!spirv.ptr<vector<2xi32>, Function>, vector<2xi32>) -> ()
      %16 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %17 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %18 = "glsl.texture_size"(%16, %17) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, i32) -> vector<2xi32>
      "spirv.Store"(%0, %18) : (!spirv.ptr<vector<2xi32>, Function>, vector<2xi32>) -> ()
      %19 = "spirv.Load"(%1) : (!spirv.ptr<vector<2xi32>, Function>) -> vector<2xi32>
      %20 = "arith.sitofp"(%19) : (vector<2xi32>) -> vector<2xf32>
      %21 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %22 = "glsl.construct"(%21) : (f32) -> vector<2xf32>
      %23 = "arith.mulf"(%20, %22) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %24 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %25 = "arith.addf"(%23, %24) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %26 = "spirv.Load"(%0) : (!spirv.ptr<vector<2xi32>, Function>) -> vector<2xi32>
      %27 = "arith.sitofp"(%26) : (vector<2xi32>) -> vector<2xf32>
      %28 = "glsl.construct"(%25, %27) : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
      "glsl.store"(%28) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
