"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64, i32) -> (), sym_name = "fpowi32"}> ({
  ^bb0(%arg0: f64, %arg1: i32):
    %0 = "math.fpowi"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64, i64) -> (), sym_name = "fpowi64"}> ({
  ^bb0(%arg2: f64, %arg3: i64):
    %26 = "func.call"(%arg2, %arg3) <{callee = @__mlir_math_fpowi_f64_i64}> : (f64, i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, i64) -> f64, sym_name = "__mlir_math_fpowi_f64_i64", sym_visibility = "private"}> ({
  ^bb0(%arg0: f64, %arg1: i64):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %1 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = -9223372036854775808 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 9223372036854775807 : i64}> : () -> i64
    %5 = "arith.cmpi"(%arg1, %1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%5)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%0) : (f64) -> ()
  ^bb2:  // pred: ^bb0
    %6 = "arith.cmpi"(%arg1, %1) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %7 = "arith.cmpi"(%arg1, %3) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %8 = "arith.subi"(%1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.select"(%6, %8, %arg1) : (i1, i64, i64) -> i64
    %10 = "arith.select"(%7, %4, %9) : (i1, i64, i64) -> i64
    "cf.br"(%0, %arg0, %10)[^bb3] : (f64, f64, i64) -> ()
  ^bb3(%11: f64, %12: f64, %13: i64):  // 2 preds: ^bb2, ^bb6
    %14 = "arith.andi"(%13, %2) : (i64, i64) -> i64
    %15 = "arith.cmpi"(%14, %1) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%15, %11)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, f64) -> ()
  ^bb4:  // pred: ^bb3
    %16 = "arith.mulf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "cf.br"(%16)[^bb5] : (f64) -> ()
  ^bb5(%17: f64):  // 2 preds: ^bb3, ^bb4
    %18 = "arith.shrui"(%13, %2) : (i64, i64) -> i64
    %19 = "arith.cmpi"(%18, %1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%19, %17)[^bb7, ^bb6] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, f64) -> ()
  ^bb6:  // pred: ^bb5
    %20 = "arith.mulf"(%12, %12) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "cf.br"(%17, %20, %18)[^bb3] : (f64, f64, i64) -> ()
  ^bb7(%21: f64):  // pred: ^bb5
    "cf.cond_br"(%7, %21)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, f64) -> ()
  ^bb8:  // pred: ^bb7
    %22 = "arith.mulf"(%21, %arg0) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "cf.br"(%22)[^bb9] : (f64) -> ()
  ^bb9(%23: f64):  // 2 preds: ^bb7, ^bb8
    "cf.cond_br"(%6, %23)[^bb10, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, f64) -> ()
  ^bb10:  // pred: ^bb9
    %24 = "arith.divf"(%0, %23) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "cf.br"(%24)[^bb11] : (f64) -> ()
  ^bb11(%25: f64):  // 2 preds: ^bb9, ^bb10
    "func.return"(%25) : (f64) -> ()
  }) {llvm.linkage = #llvm.linkage<linkonce_odr>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xf32>, vector<2x3xi64>) -> (), sym_name = "fpowi64_vec"}> ({
  ^bb0(%arg2: vector<2x3xf32>, %arg3: vector<2x3xi64>):
    %26 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x3xf32>}> : () -> vector<2x3xf32>
    %27 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 0>}> : (vector<2x3xf32>) -> f32
    %28 = "vector.extract"(%arg3) <{static_position = array<i64: 0, 0>}> : (vector<2x3xi64>) -> i64
    %29 = "func.call"(%27, %28) <{callee = @__mlir_math_fpowi_f32_i64}> : (f32, i64) -> f32
    %30 = "vector.insert"(%29, %26) <{static_position = array<i64: 0, 0>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %31 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 1>}> : (vector<2x3xf32>) -> f32
    %32 = "vector.extract"(%arg3) <{static_position = array<i64: 0, 1>}> : (vector<2x3xi64>) -> i64
    %33 = "func.call"(%31, %32) <{callee = @__mlir_math_fpowi_f32_i64}> : (f32, i64) -> f32
    %34 = "vector.insert"(%33, %30) <{static_position = array<i64: 0, 1>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %35 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 2>}> : (vector<2x3xf32>) -> f32
    %36 = "vector.extract"(%arg3) <{static_position = array<i64: 0, 2>}> : (vector<2x3xi64>) -> i64
    %37 = "func.call"(%35, %36) <{callee = @__mlir_math_fpowi_f32_i64}> : (f32, i64) -> f32
    %38 = "vector.insert"(%37, %34) <{static_position = array<i64: 0, 2>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %39 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 0>}> : (vector<2x3xf32>) -> f32
    %40 = "vector.extract"(%arg3) <{static_position = array<i64: 1, 0>}> : (vector<2x3xi64>) -> i64
    %41 = "func.call"(%39, %40) <{callee = @__mlir_math_fpowi_f32_i64}> : (f32, i64) -> f32
    %42 = "vector.insert"(%41, %38) <{static_position = array<i64: 1, 0>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %43 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 1>}> : (vector<2x3xf32>) -> f32
    %44 = "vector.extract"(%arg3) <{static_position = array<i64: 1, 1>}> : (vector<2x3xi64>) -> i64
    %45 = "func.call"(%43, %44) <{callee = @__mlir_math_fpowi_f32_i64}> : (f32, i64) -> f32
    %46 = "vector.insert"(%45, %42) <{static_position = array<i64: 1, 1>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %47 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 2>}> : (vector<2x3xf32>) -> f32
    %48 = "vector.extract"(%arg3) <{static_position = array<i64: 1, 2>}> : (vector<2x3xi64>) -> i64
    %49 = "func.call"(%47, %48) <{callee = @__mlir_math_fpowi_f32_i64}> : (f32, i64) -> f32
    %50 = "vector.insert"(%49, %46) <{static_position = array<i64: 1, 2>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i64) -> f32, sym_name = "__mlir_math_fpowi_f32_i64", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: i64):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = -9223372036854775808 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 9223372036854775807 : i64}> : () -> i64
    %5 = "arith.cmpi"(%arg1, %1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%5)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%0) : (f32) -> ()
  ^bb2:  // pred: ^bb0
    %6 = "arith.cmpi"(%arg1, %1) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %7 = "arith.cmpi"(%arg1, %3) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %8 = "arith.subi"(%1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.select"(%6, %8, %arg1) : (i1, i64, i64) -> i64
    %10 = "arith.select"(%7, %4, %9) : (i1, i64, i64) -> i64
    "cf.br"(%0, %arg0, %10)[^bb3] : (f32, f32, i64) -> ()
  ^bb3(%11: f32, %12: f32, %13: i64):  // 2 preds: ^bb2, ^bb6
    %14 = "arith.andi"(%13, %2) : (i64, i64) -> i64
    %15 = "arith.cmpi"(%14, %1) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%15, %11)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, f32) -> ()
  ^bb4:  // pred: ^bb3
    %16 = "arith.mulf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "cf.br"(%16)[^bb5] : (f32) -> ()
  ^bb5(%17: f32):  // 2 preds: ^bb3, ^bb4
    %18 = "arith.shrui"(%13, %2) : (i64, i64) -> i64
    %19 = "arith.cmpi"(%18, %1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%19, %17)[^bb7, ^bb6] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, f32) -> ()
  ^bb6:  // pred: ^bb5
    %20 = "arith.mulf"(%12, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "cf.br"(%17, %20, %18)[^bb3] : (f32, f32, i64) -> ()
  ^bb7(%21: f32):  // pred: ^bb5
    "cf.cond_br"(%7, %21)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, f32) -> ()
  ^bb8:  // pred: ^bb7
    %22 = "arith.mulf"(%21, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "cf.br"(%22)[^bb9] : (f32) -> ()
  ^bb9(%23: f32):  // 2 preds: ^bb7, ^bb8
    "cf.cond_br"(%6, %23)[^bb10, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, f32) -> ()
  ^bb10:  // pred: ^bb9
    %24 = "arith.divf"(%0, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "cf.br"(%24)[^bb11] : (f32) -> ()
  ^bb11(%25: f32):  // 2 preds: ^bb9, ^bb10
    "func.return"(%25) : (f32) -> ()
  }) {llvm.linkage = #llvm.linkage<linkonce_odr>} : () -> ()
}) : () -> ()

