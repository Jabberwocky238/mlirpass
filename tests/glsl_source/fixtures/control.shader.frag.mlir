"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "wave"}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      %74 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %75 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%75, %arg0) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%74, %arg1) : (!spirv.ptr<f32, Function>, f32) -> ()
      %76 = "spirv.Load"(%75) : (!spirv.ptr<f32, Function>) -> f32
      %77 = "spirv.Load"(%74) : (!spirv.ptr<f32, Function>) -> f32
      %78 = "arith.mulf"(%76, %77) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %79 = "glsl.builtin"(%78) <{func = 0x2}> : (f32) -> f32
      %80 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %81 = "arith.mulf"(%79, %80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %82 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %83 = "arith.addf"(%81, %82) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.ReturnValue"(%83) : (f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %6 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %7 = "vector.shuffle"(%6, %6) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%5, %7) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %8 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%4, %8) : (!spirv.ptr<f32, Function>, f32) -> ()
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%3, %9) : (!spirv.ptr<i32, Function>, i32) -> ()
      "scf.while"() ({
        %71 = "spirv.Load"(%3) : (!spirv.ptr<i32, Function>) -> i32
        %72 = "arith.constant"() <{value = 6 : i32}> : () -> i32
        %73 = "arith.cmpi"(%71, %72) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "scf.condition"(%73) : (i1) -> ()
      }, {
        %54 = "spirv.Load"(%4) : (!spirv.ptr<f32, Function>) -> f32
        %55 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %56 = "vector.extract"(%55) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
        %57 = "spirv.Load"(%3) : (!spirv.ptr<i32, Function>) -> i32
        %58 = "arith.sitofp"(%57) : (i32) -> f32
        %59 = "arith.addf"(%56, %58) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %60 = "arith.constant"() <{value = 5.000000e-02 : f32}> : () -> f32
        %61 = "spirv.Load"(%3) : (!spirv.ptr<i32, Function>) -> i32
        %62 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %63 = "arith.addi"(%61, %62) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %64 = "arith.sitofp"(%63) : (i32) -> f32
        %65 = "arith.mulf"(%60, %64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %66 = "func.call"(%59, %65) <{callee = @wave}> : (f32, f32) -> f32
        %67 = "arith.addf"(%54, %66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%4, %67) : (!spirv.ptr<f32, Function>, f32) -> ()
        %68 = "spirv.Load"(%3) : (!spirv.ptr<i32, Function>) -> i32
        %69 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %70 = "arith.addi"(%68, %69) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%3, %70) : (!spirv.ptr<i32, Function>, i32) -> ()
        "scf.yield"() : () -> ()
      }) : () -> ()
      %10 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %11 = "vector.extract"(%10) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %12 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %13 = "vector.extract"(%12) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %14 = "arith.cmpf"(%11, %13) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      "scf.if"(%14) ({
        %47 = "spirv.Load"(%4) : (!spirv.ptr<f32, Function>) -> f32
        %48 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %49 = "vector.extract"(%48) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
        %50 = "arith.constant"() <{value = 6.400000e+01 : f32}> : () -> f32
        %51 = "arith.divf"(%49, %50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %52 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
        %53 = "glsl.construct"(%47, %51, %52) : (f32, f32, f32) -> vector<3xf32>
        "spirv.Store"(%2, %53) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
        "scf.yield"() : () -> ()
      }, {
        %38 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %39 = "vector.extract"(%38) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
        %40 = "arith.constant"() <{value = 6.400000e+01 : f32}> : () -> f32
        %41 = "arith.divf"(%39, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %42 = "spirv.Load"(%4) : (!spirv.ptr<f32, Function>) -> f32
        %43 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
        %44 = "arith.mulf"(%42, %43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %45 = "arith.constant"() <{value = 7.500000e-01 : f32}> : () -> f32
        %46 = "glsl.construct"(%41, %44, %45) : (f32, f32, f32) -> vector<3xf32>
        "spirv.Store"(%2, %46) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %15 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%1, %15) : (!spirv.ptr<i32, Function>, i32) -> ()
      %16 = "spirv.Load"(%5) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %17 = "vector.extract"(%16) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      "spirv.Store"(%0, %17) : (!spirv.ptr<f32, Function>, f32) -> ()
      "scf.while"() ({
        %31 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
        %32 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
        %33 = "arith.cmpf"(%31, %32) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
        %34 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
        %35 = "arith.constant"() <{value = 10 : i32}> : () -> i32
        %36 = "arith.cmpi"(%34, %35) <{predicate = 2 : i64}> : (i32, i32) -> i1
        %37 = "arith.andi"(%33, %36) : (i1, i1) -> i1
        "scf.condition"(%37) : (i1) -> ()
      }, {
        %25 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
        %26 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
        %27 = "arith.mulf"(%25, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%0, %27) : (!spirv.ptr<f32, Function>, f32) -> ()
        %28 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
        %29 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %30 = "arith.addi"(%28, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%1, %30) : (!spirv.ptr<i32, Function>, i32) -> ()
        "scf.yield"() : () -> ()
      }) : () -> ()
      %18 = "spirv.Load"(%2) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %19 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
      %20 = "arith.sitofp"(%19) : (i32) -> f32
      %21 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %22 = "glsl.builtin"(%21) <{func = 0x22}> : (f32) -> f32
      %23 = "arith.addf"(%20, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %24 = "glsl.construct"(%18, %23) : (vector<3xf32>, f32) -> vector<4xf32>
      "glsl.store"(%24) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
