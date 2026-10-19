"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "remove_op_with_inner_ops_pattern"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "remove_op_with_inner_ops_fold_no_side_effect"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "remove_op_with_inner_ops_fold"}> ({
  ^bb0(%arg8: i32):
    "func.return"(%arg8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "remove_op_with_variadic_results_and_folder"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    "func.return"(%arg6, %arg7) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "test_commutative_multi"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %6 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 43 : i32}> : () -> i32
    %8 = "test.op_commutative"(%arg4, %arg5, %6, %7) : (i32, i32, i32, i32) -> i32
    %9 = "test.op_commutative"(%arg4, %arg5, %6, %7) : (i32, i32, i32, i32) -> i32
    "func.return"(%8, %9) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "test_commutative_multi_cst"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %3 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %4 = "test.op_commutative"(%arg2, %arg3, %3, %3) : (i32, i32, i32, i32) -> i32
    %5 = "test.op_commutative"(%arg2, %arg3, %3, %3) : (i32, i32, i32, i32) -> i32
    "func.return"(%4, %5) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "test_dialect_canonicalizer"}> ({
    %2 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "test_region_simplify"}> ({
  ^bb0(%arg0: i32, %arg1: i1):
    "test.br"(%arg0, %arg0)[^bb1] : (i32, i32) -> ()
  ^bb1(%0: i32, %1: i32):  // pred: ^bb0
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

