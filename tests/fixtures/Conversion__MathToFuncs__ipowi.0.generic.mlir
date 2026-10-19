"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ipowi"}> ({
  ^bb0(%arg2: i64, %arg3: i64):
    %21 = "func.call"(%arg2, %arg3) <{callee = @__mlir_math_ipowi_i64}> : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "__mlir_math_ipowi_i64", sym_visibility = "private"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %3 = "arith.cmpi"(%arg1, %0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%1) : (i64) -> ()
  ^bb2:  // pred: ^bb0
    %4 = "arith.cmpi"(%arg1, %0) <{predicate = 3 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%4, %1, %arg0, %arg1)[^bb3, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 3>}> : (i1, i64, i64, i64) -> ()
  ^bb3:  // pred: ^bb2
    %5 = "arith.cmpi"(%arg0, %0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%5)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %6 = "arith.divsi"(%1, %0) : (i64, i64) -> i64
    "func.return"(%6) : (i64) -> ()
  ^bb5:  // pred: ^bb3
    %7 = "arith.cmpi"(%arg0, %1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%7)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "func.return"(%1) : (i64) -> ()
  ^bb7:  // pred: ^bb5
    %8 = "arith.cmpi"(%arg0, %2) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%8)[^bb8, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb8:  // pred: ^bb7
    %9 = "arith.andi"(%arg1, %1) : (i64, i64) -> i64
    %10 = "arith.cmpi"(%9, %0) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%10)[^bb9, ^bb10] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb9:  // pred: ^bb8
    "func.return"(%2) : (i64) -> ()
  ^bb10:  // pred: ^bb8
    "func.return"(%1) : (i64) -> ()
  ^bb11:  // pred: ^bb7
    "func.return"(%0) : (i64) -> ()
  ^bb12(%11: i64, %12: i64, %13: i64):  // 2 preds: ^bb2, ^bb16
    %14 = "arith.andi"(%13, %1) : (i64, i64) -> i64
    %15 = "arith.cmpi"(%14, %0) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%15, %11)[^bb13, ^bb14] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i64) -> ()
  ^bb13:  // pred: ^bb12
    %16 = "arith.muli"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "cf.br"(%16)[^bb14] : (i64) -> ()
  ^bb14(%17: i64):  // 2 preds: ^bb12, ^bb13
    %18 = "arith.shrui"(%13, %1) : (i64, i64) -> i64
    %19 = "arith.cmpi"(%18, %0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%19)[^bb15, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb15:  // pred: ^bb14
    "func.return"(%17) : (i64) -> ()
  ^bb16:  // pred: ^bb14
    %20 = "arith.muli"(%12, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "cf.br"(%17, %20, %18)[^bb12] : (i64, i64, i64) -> ()
  }) {llvm.linkage = #llvm.linkage<linkonce_odr>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8, i8) -> (), sym_name = "ipowi"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %21 = "func.call"(%arg2, %arg3) <{callee = @__mlir_math_ipowi_i8}> : (i8, i8) -> i8
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i8, sym_name = "__mlir_math_ipowi_i8", sym_visibility = "private"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 1 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %3 = "arith.cmpi"(%arg1, %0) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%1) : (i8) -> ()
  ^bb2:  // pred: ^bb0
    %4 = "arith.cmpi"(%arg1, %0) <{predicate = 3 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%4, %1, %arg0, %arg1)[^bb3, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 3>}> : (i1, i8, i8, i8) -> ()
  ^bb3:  // pred: ^bb2
    %5 = "arith.cmpi"(%arg0, %0) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%5)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %6 = "arith.divsi"(%1, %0) : (i8, i8) -> i8
    "func.return"(%6) : (i8) -> ()
  ^bb5:  // pred: ^bb3
    %7 = "arith.cmpi"(%arg0, %1) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%7)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "func.return"(%1) : (i8) -> ()
  ^bb7:  // pred: ^bb5
    %8 = "arith.cmpi"(%arg0, %2) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%8)[^bb8, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb8:  // pred: ^bb7
    %9 = "arith.andi"(%arg1, %1) : (i8, i8) -> i8
    %10 = "arith.cmpi"(%9, %0) <{predicate = 1 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%10)[^bb9, ^bb10] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb9:  // pred: ^bb8
    "func.return"(%2) : (i8) -> ()
  ^bb10:  // pred: ^bb8
    "func.return"(%1) : (i8) -> ()
  ^bb11:  // pred: ^bb7
    "func.return"(%0) : (i8) -> ()
  ^bb12(%11: i8, %12: i8, %13: i8):  // 2 preds: ^bb2, ^bb16
    %14 = "arith.andi"(%13, %1) : (i8, i8) -> i8
    %15 = "arith.cmpi"(%14, %0) <{predicate = 1 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%15, %11)[^bb13, ^bb14] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i8) -> ()
  ^bb13:  // pred: ^bb12
    %16 = "arith.muli"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (i8, i8) -> i8
    "cf.br"(%16)[^bb14] : (i8) -> ()
  ^bb14(%17: i8):  // 2 preds: ^bb12, ^bb13
    %18 = "arith.shrui"(%13, %1) : (i8, i8) -> i8
    %19 = "arith.cmpi"(%18, %0) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "cf.cond_br"(%19)[^bb15, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb15:  // pred: ^bb14
    "func.return"(%17) : (i8) -> ()
  ^bb16:  // pred: ^bb14
    %20 = "arith.muli"(%12, %12) <{overflowFlags = #arith.overflow<none>}> : (i8, i8) -> i8
    "cf.br"(%17, %20, %18)[^bb12] : (i8, i8, i8) -> ()
  }) {llvm.linkage = #llvm.linkage<linkonce_odr>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xi64>, vector<2x3xi64>) -> (), sym_name = "ipowi_vec"}> ({
  ^bb0(%arg2: vector<2x3xi64>, %arg3: vector<2x3xi64>):
    %21 = "arith.constant"() <{value = dense<0> : vector<2x3xi64>}> : () -> vector<2x3xi64>
    %22 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 0>}> : (vector<2x3xi64>) -> i64
    %23 = "vector.extract"(%arg3) <{static_position = array<i64: 0, 0>}> : (vector<2x3xi64>) -> i64
    %24 = "func.call"(%22, %23) <{callee = @__mlir_math_ipowi_i64}> : (i64, i64) -> i64
    %25 = "vector.insert"(%24, %21) <{static_position = array<i64: 0, 0>}> : (i64, vector<2x3xi64>) -> vector<2x3xi64>
    %26 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 1>}> : (vector<2x3xi64>) -> i64
    %27 = "vector.extract"(%arg3) <{static_position = array<i64: 0, 1>}> : (vector<2x3xi64>) -> i64
    %28 = "func.call"(%26, %27) <{callee = @__mlir_math_ipowi_i64}> : (i64, i64) -> i64
    %29 = "vector.insert"(%28, %25) <{static_position = array<i64: 0, 1>}> : (i64, vector<2x3xi64>) -> vector<2x3xi64>
    %30 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 2>}> : (vector<2x3xi64>) -> i64
    %31 = "vector.extract"(%arg3) <{static_position = array<i64: 0, 2>}> : (vector<2x3xi64>) -> i64
    %32 = "func.call"(%30, %31) <{callee = @__mlir_math_ipowi_i64}> : (i64, i64) -> i64
    %33 = "vector.insert"(%32, %29) <{static_position = array<i64: 0, 2>}> : (i64, vector<2x3xi64>) -> vector<2x3xi64>
    %34 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 0>}> : (vector<2x3xi64>) -> i64
    %35 = "vector.extract"(%arg3) <{static_position = array<i64: 1, 0>}> : (vector<2x3xi64>) -> i64
    %36 = "func.call"(%34, %35) <{callee = @__mlir_math_ipowi_i64}> : (i64, i64) -> i64
    %37 = "vector.insert"(%36, %33) <{static_position = array<i64: 1, 0>}> : (i64, vector<2x3xi64>) -> vector<2x3xi64>
    %38 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 1>}> : (vector<2x3xi64>) -> i64
    %39 = "vector.extract"(%arg3) <{static_position = array<i64: 1, 1>}> : (vector<2x3xi64>) -> i64
    %40 = "func.call"(%38, %39) <{callee = @__mlir_math_ipowi_i64}> : (i64, i64) -> i64
    %41 = "vector.insert"(%40, %37) <{static_position = array<i64: 1, 1>}> : (i64, vector<2x3xi64>) -> vector<2x3xi64>
    %42 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 2>}> : (vector<2x3xi64>) -> i64
    %43 = "vector.extract"(%arg3) <{static_position = array<i64: 1, 2>}> : (vector<2x3xi64>) -> i64
    %44 = "func.call"(%42, %43) <{callee = @__mlir_math_ipowi_i64}> : (i64, i64) -> i64
    %45 = "vector.insert"(%44, %41) <{static_position = array<i64: 1, 2>}> : (i64, vector<2x3xi64>) -> vector<2x3xi64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "__mlir_math_ipowi_i64", sym_visibility = "private"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %3 = "arith.cmpi"(%arg1, %0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%1) : (i64) -> ()
  ^bb2:  // pred: ^bb0
    %4 = "arith.cmpi"(%arg1, %0) <{predicate = 3 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%4, %1, %arg0, %arg1)[^bb3, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 3>}> : (i1, i64, i64, i64) -> ()
  ^bb3:  // pred: ^bb2
    %5 = "arith.cmpi"(%arg0, %0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%5)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %6 = "arith.divsi"(%1, %0) : (i64, i64) -> i64
    "func.return"(%6) : (i64) -> ()
  ^bb5:  // pred: ^bb3
    %7 = "arith.cmpi"(%arg0, %1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%7)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "func.return"(%1) : (i64) -> ()
  ^bb7:  // pred: ^bb5
    %8 = "arith.cmpi"(%arg0, %2) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%8)[^bb8, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb8:  // pred: ^bb7
    %9 = "arith.andi"(%arg1, %1) : (i64, i64) -> i64
    %10 = "arith.cmpi"(%9, %0) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%10)[^bb9, ^bb10] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb9:  // pred: ^bb8
    "func.return"(%2) : (i64) -> ()
  ^bb10:  // pred: ^bb8
    "func.return"(%1) : (i64) -> ()
  ^bb11:  // pred: ^bb7
    "func.return"(%0) : (i64) -> ()
  ^bb12(%11: i64, %12: i64, %13: i64):  // 2 preds: ^bb2, ^bb16
    %14 = "arith.andi"(%13, %1) : (i64, i64) -> i64
    %15 = "arith.cmpi"(%14, %0) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%15, %11)[^bb13, ^bb14] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i64) -> ()
  ^bb13:  // pred: ^bb12
    %16 = "arith.muli"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "cf.br"(%16)[^bb14] : (i64) -> ()
  ^bb14(%17: i64):  // 2 preds: ^bb12, ^bb13
    %18 = "arith.shrui"(%13, %1) : (i64, i64) -> i64
    %19 = "arith.cmpi"(%18, %0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%19)[^bb15, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb15:  // pred: ^bb14
    "func.return"(%17) : (i64) -> ()
  ^bb16:  // pred: ^bb14
    %20 = "arith.muli"(%12, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "cf.br"(%17, %20, %18)[^bb12] : (i64, i64, i64) -> ()
  }) {llvm.linkage = #llvm.linkage<linkonce_odr>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "ipowi_index"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "math.ipowi"(%arg0, %arg1) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

