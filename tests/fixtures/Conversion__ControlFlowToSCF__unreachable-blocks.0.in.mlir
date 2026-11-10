"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "single_return_statement"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  ^bb1:  // pred: ^bb1
    %0 = "arith.constant"() <{value = true}> : () -> i1
    "cf.cond_br"(%0)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

