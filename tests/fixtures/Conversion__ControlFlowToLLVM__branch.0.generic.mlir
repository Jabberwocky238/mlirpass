"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "cf_br"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    "llvm.br"(%0)[^bb1] : (i64) -> ()
  ^bb1(%1: i64):  // pred: ^bb0
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "cf_br_type_match"}> ({
  ^bb0(%arg0: i64):
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%0: i64):  // pred: ^bb0
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, index, index) -> index, sym_name = "cf_cond_br"}> ({
  ^bb0(%arg0: i1, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    "llvm.cond_br"(%arg0, %1, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb1(%2: i64):  // pred: ^bb0
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  ^bb2(%4: i64):  // pred: ^bb0
    %5 = "builtin.unrealized_conversion_cast"(%4) : (i64) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unreachable_block"}> ({
    "func.return"() : () -> ()
  ^bb1(%0: index):  // pred: ^bb1
    "cf.br"(%0)[^bb1] : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, index, index) -> index, sym_name = "cf_cond_br_with_weights"}> ({
  ^bb0(%arg0: i1, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    "llvm.cond_br"(%arg0, %1, %0)[^bb1, ^bb2] <{branch_weights = array<i32: 90, 10>, operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb1(%2: i64):  // pred: ^bb0
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  ^bb2(%4: i64):  // pred: ^bb0
    %5 = "builtin.unrealized_conversion_cast"(%4) : (i64) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
}) : () -> ()

