"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %3 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %4 = "vector.shuffle"(%3, %3) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%2, %4) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %5 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %6 = "vector.extract"(%5) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %7 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %8 = "vector.extract"(%7) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %9 = "arith.addf"(%6, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
      %11 = "glsl.builtin"(%9, %10) <{func = 0x23}> : (f32, f32) -> f32
      %12 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %13 = "arith.cmpf"(%11, %12) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "scf.if"(%13) ({
        "glsl.discard"() : () -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %14 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %15 = "vector.extract"(%14) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %16 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %17 = "vector.extract"(%16) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %18 = "arith.mulf"(%15, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %19 = "arith.constant"() <{value = 5.000000e+01 : f32}> : () -> f32
      %20 = "arith.mulf"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %21 = "glsl.derivative"(%20) <{kind = 0x0}> : (f32) -> f32
      %22 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %23 = "vector.extract"(%22) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %24 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %25 = "vector.extract"(%24) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %26 = "arith.mulf"(%23, %25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %27 = "glsl.derivative"(%26) <{kind = 0x1}> : (f32) -> f32
      %28 = "glsl.construct"(%21, %27) : (f32, f32) -> vector<2xf32>
      "spirv.Store"(%1, %28) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %29 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %30 = "vector.extract"(%29) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %31 = "spirv.Load"(%2) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %32 = "vector.extract"(%31) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %33 = "arith.mulf"(%30, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %34 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %35 = "arith.mulf"(%33, %34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %36 = "glsl.derivative"(%35) <{kind = 0x2}> : (f32) -> f32
      "spirv.Store"(%0, %36) : (!spirv.ptr<f32, Function>, f32) -> ()
      %37 = "spirv.Load"(%1) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %38 = "arith.constant"() <{value = 6.400000e+01 : f32}> : () -> f32
      %39 = "glsl.construct"(%38) : (f32) -> vector<2xf32>
      %40 = "arith.mulf"(%37, %39) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %41 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %42 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %43 = "glsl.construct"(%40, %41, %42) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      "glsl.store"(%43) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
