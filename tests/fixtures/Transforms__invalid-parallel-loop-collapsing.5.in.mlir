"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "too_few_iters"}> ({
  ^bb0(%arg6: index, %arg7: index, %arg8: index):
    "scf.parallel"(%arg6, %arg7, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg9: index):
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "too_many_iters"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    "scf.parallel"(%arg0, %arg0, %arg0, %arg1, %arg1, %arg1, %arg2, %arg2, %arg2) <{operandSegmentSizes = array<i32: 3, 3, 3, 0>}> ({
    ^bb0(%arg3: index, %arg4: index, %arg5: index):
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

