"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{location = 3 : i32, storage = 0x2, sym_name = "u_tint", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{location = 4 : i32, storage = 0x2, sym_name = "u_scale", ty = f32}> : () -> ()
    "glsl.global"() <{location = 5 : i32, storage = 0x2, sym_name = "u_shift", ty = si32}> : () -> ()
    "glsl.global"() <{binding = 1 : i32, storage = 0x2, sym_name = "params", ty = !spirv.struct<(vector<4xf32> [0], !spirv.matrix<4 x vector<4xf32>> [16, ColMajor, MatrixStride=16], f32 [80]), Block>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %1 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %2 = "glsl.load"() <{var = @u_scale}> : () -> f32
      %3 = "glsl.construct"(%2) : (f32) -> vector<2xf32>
      %4 = "arith.mulf"(%1, %3) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %5 = "glsl.load"() <{var = @u_shift}> : () -> i32
      %6 = "arith.sitofp"(%5) : (i32) -> f32
      %7 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %8 = "glsl.construct"(%4, %6, %7) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      "spirv.Store"(%0, %8) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %9 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %10 = "glsl.load"(%9) <{var = @params}> : (i32) -> !spirv.matrix<4 x vector<4xf32>>
      %11 = "spirv.Load"(%0) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %12 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %13 = "glsl.load"(%12) <{var = @params}> : (i32) -> vector<4xf32>
      %14 = "arith.addf"(%11, %13) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %15 = "glsl.builtin"(%10, %14) <{func = 0x38}> : (!spirv.matrix<4 x vector<4xf32>>, vector<4xf32>) -> vector<4xf32>
      %16 = "glsl.load"() <{var = @u_tint}> : () -> vector<4xf32>
      %17 = "arith.mulf"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %18 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %19 = "glsl.load"(%18) <{var = @params}> : (i32) -> f32
      %20 = "glsl.construct"(%19) : (f32) -> vector<4xf32>
      %21 = "arith.mulf"(%17, %20) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%21) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
