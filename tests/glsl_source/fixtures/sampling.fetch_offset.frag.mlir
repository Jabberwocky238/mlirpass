"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 0 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %2 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %3 = "vector.shuffle"(%2, %2) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%1, %3) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %4 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %5 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      %6 = "glsl.construct"(%5) : (f32) -> vector<2xf32>
      %7 = "arith.mulf"(%4, %6) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %8 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %9 = "glsl.construct"(%8) : (f32) -> vector<2xf32>
      %10 = "arith.subf"(%7, %9) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%0, %10) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %11 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %12 = "spirv.Load"(%1) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %13 = "arith.fptosi"(%12) : (vector<2xf32>) -> vector<2xi32>
      %14 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %15 = "glsl.construct"(%14) : (i32) -> vector<2xi32>
      %16 = "arith.divsi"(%13, %15) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
      %17 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = dense<[1, -1]> : vector<2xi32>}> : () -> vector<2xi32>
      %19 = "glsl.texel_fetch"(%11, %16, %17, %18) <{offset}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xi32>, i32, vector<2xi32>) -> vector<4xf32>
      "glsl.store"(%19) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
