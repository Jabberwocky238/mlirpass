"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 100 : i32}> ({
    "glsl.global"() <{storage = 0x0, sym_name = "v_k", ty = f32}> : () -> ()
    "glsl.global"() <{storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{storage = 0x2, sym_name = "u_tint", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{storage = 0x2, sym_name = "u_gain", ty = f32}> : () -> ()
    "glsl.global"() <{storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x8, storage = 0x1, sym_name = "gl_FragColor", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = (vector<3xf32>, f32) -> vector<3xf32>, sym_name = "shade"}> ({
    ^bb0(%arg0: vector<3xf32>, %arg1: f32):
      %60 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %61 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      "spirv.Store"(%61, %arg0) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      "spirv.Store"(%60, %arg1) : (!spirv.ptr<f32, Function>, f32) -> ()
      %62 = "spirv.Load"(%61) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %63 = "spirv.Load"(%60) : (!spirv.ptr<f32, Function>) -> f32
      %64 = "glsl.construct"(%63) : (f32) -> vector<3xf32>
      %65 = "arith.mulf"(%62, %64) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %66 = "arith.constant"() <{value = 1.250000e-01 : f32}> : () -> f32
      %67 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %68 = "arith.constant"() <{value = 3.750000e-01 : f32}> : () -> f32
      %69 = "glsl.construct"(%66, %67, %68) : (f32, f32, f32) -> vector<3xf32>
      %70 = "arith.addf"(%65, %69) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      "spirv.ReturnValue"(%70) : (vector<3xf32>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %4 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
      %5 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %6 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %7 = "glsl.construct"(%6) : (f32) -> vector<2xf32>
      %8 = "arith.mulf"(%5, %7) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %9 = "glsl.texture"(%4, %8) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xf32>
      "spirv.Store"(%3, %9) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %10 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %11 = "glsl.load"() <{var = @v_k}> : () -> f32
      %12 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %13 = "glsl.construct"(%10, %11, %12) : (vector<2xf32>, f32, f32) -> vector<4xf32>
      %14 = "glsl.load"() <{var = @u_tint}> : () -> vector<4xf32>
      %15 = "arith.mulf"(%13, %14) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %16 = "glsl.load"() <{var = @u_gain}> : () -> f32
      %17 = "glsl.construct"(%16) : (f32) -> vector<4xf32>
      %18 = "arith.mulf"(%15, %17) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %19 = "spirv.Load"(%3) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %20 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %21 = "glsl.construct"(%20) : (f32) -> vector<4xf32>
      %22 = "arith.mulf"(%19, %21) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      %23 = "arith.addf"(%18, %22) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "spirv.Store"(%2, %23) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %24 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%1, %24) : (!spirv.ptr<f32, Function>, f32) -> ()
      %25 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%0, %25) : (!spirv.ptr<i32, Function>, i32) -> ()
      "scf.while"() ({
        %57 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
        %58 = "arith.constant"() <{value = 4 : i32}> : () -> i32
        %59 = "arith.cmpi"(%57, %58) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "scf.condition"(%59) : (i1) -> ()
      }, {
        %47 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
        %48 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
        %49 = "vector.extract"(%48) <{static_position = array<i64: 0>}> : (vector<4xf32>) -> f32
        %50 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
        %51 = "arith.sitofp"(%50) : (i32) -> f32
        %52 = "arith.mulf"(%49, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %53 = "arith.addf"(%47, %52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%1, %53) : (!spirv.ptr<f32, Function>, f32) -> ()
        %54 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
        %55 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %56 = "arith.addi"(%54, %55) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%0, %56) : (!spirv.ptr<i32, Function>, i32) -> ()
        "scf.yield"() : () -> ()
      }) : () -> ()
      %26 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %27 = "vector.extract"(%26) <{static_position = array<i64: 0>}> : (vector<4xf32>) -> f32
      %28 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %29 = "arith.cmpf"(%27, %28) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      "scf.if"(%29) ({
        %44 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        %45 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
        %46 = "vector.insert"(%44, %45) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
        "spirv.Store"(%2, %46) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %30 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %31 = "vector.shuffle"(%30, %30) <{mask = array<i64: 2, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      %32 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %33 = "vector.extract"(%31) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %34 = "vector.insert"(%33, %32) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
      %35 = "vector.extract"(%31) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %36 = "vector.insert"(%35, %34) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
      "spirv.Store"(%2, %36) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %37 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %38 = "vector.shuffle"(%37, %37) <{mask = array<i64: 0, 1, 2>}> : (vector<4xf32>, vector<4xf32>) -> vector<3xf32>
      %39 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %40 = "func.call"(%38, %39) <{callee = @shade}> : (vector<3xf32>, f32) -> vector<3xf32>
      %41 = "spirv.Load"(%2) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %42 = "vector.extract"(%41) <{static_position = array<i64: 3>}> : (vector<4xf32>) -> f32
      %43 = "glsl.construct"(%40, %42) : (vector<3xf32>, f32) -> vector<4xf32>
      "glsl.store"(%43) <{var = @gl_FragColor}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
