"builtin.module"() ({
  "func.func"() <{function_type = (i1, index, index) -> index, sym_name = "block_args"}> ({
  ^bb0(%arg0: i1, %arg1: index, %arg2: index):
    "cf.cond_br"(%arg0, %arg1, %arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, index, index) -> ()
  ^bb1(%0: index):  // pred: ^bb0
    "func.return"(%0) : (index) -> ()
  ^bb2(%1: index):  // pred: ^bb0
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

