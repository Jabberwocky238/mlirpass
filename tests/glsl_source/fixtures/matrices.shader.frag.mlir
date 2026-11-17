"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 0 : i32, storage = 0x2, sym_name = "m", ty = !spirv.struct<(!spirv.matrix<4 x vector<4xf32>> [0, ColMajor, MatrixStride=16], !spirv.matrix<4 x vector<4xf32>> [64, ColMajor, MatrixStride=16], !spirv.matrix<3 x vector<3xf32>> [128, ColMajor, MatrixStride=16]), Block>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %5 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %6 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %7 = "vector.extract"(%6) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %8 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %9 = "vector.extract"(%8) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %10 = "arith.mulf"(%7, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %11 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %12 = "glsl.construct"(%5, %10, %11) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      "spirv.Store"(%4, %12) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %13 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %14 = "glsl.load"(%13) <{var = @m}> : (i32) -> !spirv.matrix<4 x vector<4xf32>>
      %15 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %16 = "glsl.load"(%15) <{var = @m}> : (i32) -> !spirv.matrix<4 x vector<4xf32>>
      %17 = "glsl.builtin"(%14, %16) <{func = 0x37}> : (!spirv.matrix<4 x vector<4xf32>>, !spirv.matrix<4 x vector<4xf32>>) -> !spirv.matrix<4 x vector<4xf32>>
      "spirv.Store"(%3, %17) : (!spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>, !spirv.matrix<4 x vector<4xf32>>) -> ()
      %18 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %19 = "glsl.load"(%18) <{var = @m}> : (i32) -> !spirv.matrix<4 x vector<4xf32>>
      %20 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %21 = "glsl.builtin"(%19, %20) <{func = 0x3a}> : (!spirv.matrix<4 x vector<4xf32>>, f32) -> !spirv.matrix<4 x vector<4xf32>>
      "spirv.Store"(%2, %21) : (!spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>, !spirv.matrix<4 x vector<4xf32>>) -> ()
      %22 = "spirv.Load"(%3) : (!spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>) -> !spirv.matrix<4 x vector<4xf32>>
      %23 = "spirv.Load"(%4) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %24 = "glsl.builtin"(%22, %23) <{func = 0x38}> : (!spirv.matrix<4 x vector<4xf32>>, vector<4xf32>) -> vector<4xf32>
      %25 = "spirv.Load"(%4) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %26 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %27 = "glsl.load"(%26) <{var = @m}> : (i32) -> !spirv.matrix<4 x vector<4xf32>>
      %28 = "glsl.builtin"(%25, %27) <{func = 0x39}> : (vector<4xf32>, !spirv.matrix<4 x vector<4xf32>>) -> vector<4xf32>
      %29 = "arith.addf"(%24, %28) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %30 = "spirv.Load"(%2) : (!spirv.ptr<!spirv.matrix<4 x vector<4xf32>>, Function>) -> !spirv.matrix<4 x vector<4xf32>>
      %31 = "spirv.Load"(%4) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %32 = "glsl.builtin"(%30, %31) <{func = 0x38}> : (!spirv.matrix<4 x vector<4xf32>>, vector<4xf32>) -> vector<4xf32>
      %33 = "arith.addf"(%29, %32) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "spirv.Store"(%1, %33) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %34 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %35 = "glsl.load"(%34) <{var = @m}> : (i32) -> !spirv.matrix<3 x vector<3xf32>>
      %36 = "spirv.Load"(%4) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %37 = "vector.shuffle"(%36, %36) <{mask = array<i64: 0, 1, 2>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
      %38 = "glsl.builtin"(%35, %37) <{func = 0x38}> : (!spirv.matrix<3 x vector<3xf32>>, vector<3xf32>) -> vector<3xf32>
      %39 = "spirv.Load"(%4) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %40 = "vector.shuffle"(%39, %39) <{mask = array<i64: 2, 1, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
      %41 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %42 = "glsl.load"(%41) <{var = @m}> : (i32) -> !spirv.matrix<3 x vector<3xf32>>
      %43 = "glsl.builtin"(%40, %42) <{func = 0x39}> : (vector<3xf32>, !spirv.matrix<3 x vector<3xf32>>) -> vector<3xf32>
      %44 = "arith.addf"(%38, %43) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%0, %44) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %45 = "spirv.Load"(%1) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %46 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %47 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %48 = "glsl.construct"(%46, %47) : (vector<3xf32>, f32) -> vector<4xf32>
      %49 = "arith.addf"(%45, %48) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%49) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
