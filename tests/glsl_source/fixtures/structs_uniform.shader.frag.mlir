"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{location = 2 : i32, storage = 0x2, sym_name = "u_light", ty = !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %1 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %2 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %3 = "glsl.construct"(%2) : (f32) -> vector<2xf32>
      %4 = "arith.subf"(%1, %3) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %5 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %6 = "glsl.construct"(%4, %5) : (vector<2xf32>, f32) -> vector<3xf32>
      %7 = "glsl.builtin"(%6) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%0, %7) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %8 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %9 = "glsl.load"(%8) <{var = @u_light}> : (i32) -> vector<3xf32>
      %10 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %11 = "glsl.builtin"(%9, %10) <{func = 0x2c}> : (vector<3xf32>, vector<3xf32>) -> f32
      %12 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %13 = "glsl.load"(%12) <{var = @u_light}> : (i32) -> f32
      %14 = "arith.mulf"(%11, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %15 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %17 = "glsl.load"(%15, %16) <{var = @u_light}> : (i32, i32) -> vector<2xf32>
      %18 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %20 = "glsl.load"(%18, %19) <{var = @u_light}> : (i32, i32) -> vector<2xf32>
      %21 = "arith.addf"(%17, %20) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %22 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %23 = "glsl.construct"(%14, %21, %22) : (f32, vector<2xf32>, f32) -> vector<4xf32>
      "glsl.store"(%23) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
