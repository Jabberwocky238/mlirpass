"builtin.module"() ({
  "func.func"() <{function_type = (i32, index) -> index, sym_name = "single_case"}> ({
  ^bb0(%arg0: i32, %arg1: index):
    "cf.switch"(%arg0, %arg1)[^bb1] <{case_operand_segments = array<i32>, operandSegmentSizes = array<i32: 1, 1, 0>}> : (i32, index) -> ()
  ^bb1(%0: index):  // pred: ^bb0
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> i64, sym_name = "single_case_type_match"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    "cf.switch"(%arg0, %arg1)[^bb1] <{case_operand_segments = array<i32>, operandSegmentSizes = array<i32: 1, 1, 0>}> : (i32, i64) -> ()
  ^bb1(%0: i64):  // pred: ^bb0
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, index, index, i64) -> index, sym_name = "multi_case"}> ({
  ^bb0(%arg0: i32, %arg1: index, %arg2: index, %arg3: i64):
    "cf.switch"(%arg0, %arg1, %arg2, %arg1, %arg3)[^bb1, ^bb2, ^bb1, ^bb3] <{case_operand_segments = array<i32: 1, 1, 1>, case_values = dense<[12, 13, 14]> : vector<3xi32>, operandSegmentSizes = array<i32: 1, 1, 3>}> : (i32, index, index, index, i64) -> ()
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb0
    "func.return"(%0) : (index) -> ()
  ^bb2(%1: index):  // pred: ^bb0
    "func.return"(%1) : (index) -> ()
  ^bb3(%2: i64):  // pred: ^bb0
    %3 = "arith.index_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

