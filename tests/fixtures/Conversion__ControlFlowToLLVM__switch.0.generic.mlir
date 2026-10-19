"builtin.module"() ({
  "func.func"() <{function_type = (i32, index) -> index, sym_name = "single_case"}> ({
  ^bb0(%arg0: i32, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    "llvm.switch"(%arg0, %0)[^bb1] <{case_operand_segments = array<i32>, operandSegmentSizes = array<i32: 1, 1, 0>}> : (i32, i64) -> ()
  ^bb1(%1: i64):  // pred: ^bb0
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> i64, sym_name = "single_case_type_match"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    "llvm.switch"(%arg0, %arg1)[^bb1] <{case_operand_segments = array<i32>, operandSegmentSizes = array<i32: 1, 1, 0>}> : (i32, i64) -> ()
  ^bb1(%0: i64):  // pred: ^bb0
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, index, index, i64) -> index, sym_name = "multi_case"}> ({
  ^bb0(%arg0: i32, %arg1: index, %arg2: index, %arg3: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    "llvm.switch"(%arg0, %1, %0, %1, %arg3)[^bb1, ^bb2, ^bb1, ^bb3] <{case_operand_segments = array<i32: 1, 1, 1>, case_values = dense<[12, 13, 14]> : vector<3xi32>, operandSegmentSizes = array<i32: 1, 1, 3>}> : (i32, i64, i64, i64, i64) -> ()
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb0
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  ^bb2(%4: i64):  // pred: ^bb0
    %5 = "builtin.unrealized_conversion_cast"(%4) : (i64) -> index
    "func.return"(%5) : (index) -> ()
  ^bb3(%6: i64):  // pred: ^bb0
    %7 = "arith.index_cast"(%6) : (i64) -> index
    "func.return"(%7) : (index) -> ()
  }) : () -> ()
}) : () -> ()

