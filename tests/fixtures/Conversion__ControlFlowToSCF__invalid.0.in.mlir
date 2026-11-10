"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "spirv_loop_no_crash"}> ({
  ^bb0(%arg0: i1):
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb2
      "spirv.BranchConditional"(%arg0)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

