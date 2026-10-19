"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "remove_op_with_inner_ops_pattern"}> ({
    "test.op_with_region_pattern"() ({
      "test.op_with_region_terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "remove_op_with_inner_ops_fold_no_side_effect"}> ({
    "test.op_with_region_fold_no_side_effect"() ({
      "test.op_with_region_terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "remove_op_with_inner_ops_fold"}> ({
  ^bb0(%arg8: i32):
    %13 = "test.op_with_region_fold"(%arg8) ({
      "test.op_with_region_terminator"() : () -> ()
    }) : (i32) -> i32
    "func.return"(%13) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "remove_op_with_variadic_results_and_folder"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %12:2 = "test.op_with_variadic_results_and_folder"(%arg6, %arg7) : (i32, i32) -> (i32, i32)
    "func.return"(%12#0, %12#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "test_commutative_multi"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %8 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 43 : i32}> : () -> i32
    %10 = "test.op_commutative"(%8, %arg4, %arg5, %9) : (i32, i32, i32, i32) -> i32
    %11 = "test.op_commutative"(%arg4, %8, %9, %arg5) : (i32, i32, i32, i32) -> i32
    "func.return"(%10, %11) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "test_commutative_multi_cst"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %3 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %5 = "test.op_commutative"(%3, %arg2, %arg3, %4) : (i32, i32, i32, i32) -> i32
    %6 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %7 = "test.op_commutative"(%arg2, %6, %4, %arg3) : (i32, i32, i32, i32) -> i32
    "func.return"(%5, %7) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "test_dialect_canonicalizer"}> ({
    %2 = "test.dialect_canonicalizable"() : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "test_region_simplify"}> ({
  ^bb0(%arg0: i32, %arg1: i1):
    "test.br"(%arg0, %arg0)[^bb1] : (i32, i32) -> ()
  ^bb1(%0: i32, %1: i32):  // pred: ^bb0
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

