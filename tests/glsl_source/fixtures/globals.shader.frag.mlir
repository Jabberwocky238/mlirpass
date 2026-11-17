"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{storage = 0x3, sym_name = "g_scale", ty = f32}> : () -> ()
    "glsl.global"() <{storage = 0x3, sym_name = "g_bias", ty = vector<3xf32>}> : () -> ()
    "glsl.global"() <{storage = 0x3, sym_name = "g_samples", ty = !spirv.array<3 x f32>}> : () -> ()
    "glsl.global"() <{storage = 0x3, sym_name = "g_acc", ty = !spirv.struct<(f32, i32)>}> : () -> ()
    "glsl.global"() <{storage = 0x3, sym_name = "g_late", ty = f32}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "add"}> ({
    ^bb0(%arg0: f32):
      %60 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%60, %arg0) : (!spirv.ptr<f32, Function>, f32) -> ()
      %61 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %62 = "glsl.load"(%61) <{var = @g_acc}> : (i32) -> f32
      %63 = "spirv.Load"(%60) : (!spirv.ptr<f32, Function>) -> f32
      %64 = "glsl.load"() <{var = @g_scale}> : () -> f32
      %65 = "arith.mulf"(%63, %64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %66 = "arith.addf"(%62, %65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "glsl.store"(%66, %61) <{var = @g_acc}> : (f32, i32) -> ()
      %67 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %68 = "glsl.load"(%67) <{var = @g_acc}> : (i32) -> i32
      %69 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %70 = "arith.addi"(%68, %69) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "glsl.store"(%70, %67) <{var = @g_acc}> : (i32, i32) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %6 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      "glsl.store"(%6) <{var = @g_scale}> : (f32) -> ()
      %7 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
      %8 = "arith.constant"() <{value = 2.000000e-01 : f32}> : () -> f32
      %9 = "arith.negf"(%8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %10 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %11 = "glsl.construct"(%7, %9, %10) : (f32, f32, f32) -> vector<3xf32>
      "glsl.store"(%11) <{var = @g_bias}> : (vector<3xf32>) -> ()
      %12 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %13 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %14 = "spirv.CompositeConstruct"(%12, %13) : (f32, i32) -> !spirv.struct<(f32, i32)>
      "glsl.store"(%14) <{var = @g_acc}> : (!spirv.struct<(f32, i32)>) -> ()
      %15 = "arith.constant"() <{value = 2.500000e+00 : f32}> : () -> f32
      "glsl.store"(%15) <{var = @g_late}> : (f32) -> ()
      %16 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %17 = "vector.shuffle"(%16, %16) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%5, %17) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %18 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %19 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %20 = "vector.extract"(%19) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %21 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %22 = "arith.mulf"(%20, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "glsl.store"(%22, %18) <{var = @g_samples}> : (f32, i32) -> ()
      %23 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %24 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %25 = "vector.extract"(%24) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %26 = "arith.constant"() <{value = 2.000000e-02 : f32}> : () -> f32
      %27 = "arith.mulf"(%25, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "glsl.store"(%27, %23) <{var = @g_samples}> : (f32, i32) -> ()
      %28 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %29 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %30 = "glsl.load"(%29) <{var = @g_samples}> : (i32) -> f32
      %31 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %32 = "glsl.load"(%31) <{var = @g_samples}> : (i32) -> f32
      %33 = "arith.addf"(%30, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "glsl.store"(%33, %28) <{var = @g_samples}> : (f32, i32) -> ()
      %34 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%4, %34) : (!spirv.ptr<i32, Function>, i32) -> ()
      "scf.while"() ({
        %57 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
        %58 = "arith.constant"() <{value = 3 : i32}> : () -> i32
        %59 = "arith.cmpi"(%57, %58) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "scf.condition"(%59) : (i1) -> ()
      }, {
        %51 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
        %52 = "glsl.load"(%51) <{var = @g_samples}> : (i32) -> f32
        "func.call"(%52) <{callee = @add}> : (f32) -> ()
        %53 = "arith.constant"() <{value = 0 : i1}> : () -> i1
        %54 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
        %55 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %56 = "arith.addi"(%54, %55) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%4, %56) : (!spirv.ptr<i32, Function>, i32) -> ()
        "scf.yield"() : () -> ()
      }) : () -> ()
      %35 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      "glsl.store"(%35) <{var = @g_scale}> : (f32) -> ()
      %36 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "func.call"(%36) <{callee = @add}> : (f32) -> ()
      %37 = "arith.constant"() <{value = 0 : i1}> : () -> i1
      %38 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %39 = "glsl.load"(%38) <{var = @g_acc}> : (i32) -> f32
      %40 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %41 = "glsl.load"(%40) <{var = @g_acc}> : (i32) -> i32
      %42 = "arith.sitofp"(%41) : (i32) -> f32
      %43 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
      %44 = "arith.mulf"(%42, %43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %45 = "func.call"() <{callee = @later}> : () -> f32
      %46 = "glsl.load"() <{var = @g_bias}> : () -> vector<3xf32>
      %47 = "vector.extract"(%46) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %48 = "glsl.load"() <{var = @g_scale}> : () -> f32
      %49 = "arith.addf"(%47, %48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %50 = "glsl.construct"(%39, %44, %45, %49) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%50) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> f32, sym_name = "later"}> ({
      %0 = "glsl.load"() <{var = @g_late}> : () -> f32
      %1 = "glsl.load"() <{var = @g_bias}> : () -> vector<3xf32>
      %2 = "vector.extract"(%1) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %3 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.ReturnValue"(%3) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
