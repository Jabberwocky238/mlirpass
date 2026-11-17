"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 10 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<i32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xi32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %4 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %5 = "vector.shuffle"(%4, %4) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%3, %5) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %6 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %7 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %8 = "glsl.construct"(%7) : (f32) -> vector<2xf32>
      %9 = "arith.mulf"(%6, %8) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %10 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %11 = "glsl.construct"(%10) : (f32) -> vector<2xf32>
      %12 = "arith.subf"(%9, %11) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%2, %12) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %13 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %14 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %15 = "glsl.construct"(%14) : (f32) -> vector<2xf32>
      %16 = "arith.mulf"(%13, %15) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %17 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %18 = "glsl.construct"(%17) : (f32) -> vector<2xf32>
      %19 = "arith.subf"(%16, %18) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %20 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %21 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %22 = "vector.extract"(%21) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %23 = "arith.subf"(%20, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %24 = "glsl.construct"(%19, %23) : (vector<2xf32>, f32) -> vector<3xf32>
      %25 = "glsl.builtin"(%24) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%1, %25) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %26 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<i32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %27 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %28 = "glsl.texture"(%26, %27) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<i32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>) -> vector<4xi32>
      "spirv.Store"(%0, %28) : (!spirv.ptr<vector<4xi32>, Function>, vector<4xi32>) -> ()
      %29 = "spirv.Load"(%0) : (!spirv.ptr<vector<4xi32>, Function>) -> vector<4xi32>
      %30 = "arith.uitofp"(%29) : (vector<4xi32>) -> vector<4xf32>
      %31 = "arith.constant"() <{value = 2.550000e+02 : f32}> : () -> f32
      %32 = "glsl.construct"(%31) : (f32) -> vector<4xf32>
      %33 = "arith.divf"(%30, %32) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%33) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
