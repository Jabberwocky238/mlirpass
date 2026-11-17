"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 1 : i32, storage = 0x2, sym_name = "params", ty = !spirv.struct<(!spirv.struct<(vector<3xf32> [0], f32 [12], !spirv.array<2 x vector<2xf32>, stride=16> [16])> [0], f32 [48], !spirv.array<1 x !spirv.struct<(vector<3xf32> [0], f32 [12], !spirv.array<2 x vector<2xf32>, stride=16> [16])>, stride=48> [64]), Block>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %2 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %3 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %4 = "glsl.construct"(%3) : (f32) -> vector<2xf32>
      %5 = "arith.subf"(%2, %4) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %6 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %7 = "glsl.construct"(%5, %6) : (vector<2xf32>, f32) -> vector<3xf32>
      %8 = "glsl.builtin"(%7) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%1, %8) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "glsl.load"(%9) <{var = @params}> : (i32) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      "spirv.Store"(%0, %10) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %12 = "spirv.AccessChain"(%0, %11) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      %13 = "spirv.Load"(%12) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %14 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %15 = "glsl.builtin"(%13, %14) <{func = 0x2c}> : (vector<3xf32>, vector<3xf32>) -> f32
      %16 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "spirv.AccessChain"(%0, %16) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<f32, Function>
      %18 = "spirv.Load"(%17) : (!spirv.ptr<f32, Function>) -> f32
      %19 = "arith.mulf"(%15, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %20 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %21 = "glsl.load"(%20) <{var = @params}> : (i32) -> f32
      %22 = "arith.mulf"(%19, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %23 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %24 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %25 = "spirv.AccessChain"(%0, %23, %24) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      %26 = "spirv.Load"(%25) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %27 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %28 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %29 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %30 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %31 = "glsl.load"(%27, %28, %29, %30) <{var = @params}> : (i32, i32, i32, i32) -> vector<2xf32>
      %32 = "arith.addf"(%26, %31) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %33 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %34 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %35 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %36 = "glsl.load"(%33, %34, %35) <{var = @params}> : (i32, i32, i32) -> vector<3xf32>
      %37 = "vector.extract"(%36) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %38 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %39 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %40 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %41 = "glsl.load"(%38, %39, %40) <{var = @params}> : (i32, i32, i32) -> f32
      %42 = "arith.addf"(%37, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %43 = "glsl.construct"(%22, %32, %42) : (f32, vector<2xf32>, f32) -> vector<4xf32>
      "glsl.store"(%43) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
