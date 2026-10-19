"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    "func.return"() : () -> ()
  ^bb1:  // no predecessors
    "omp.parallel"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 0, 0>}> ({
      %0 = "llvm.intr.stacksave"() : () -> !llvm.ptr
      "llvm.br"()[^bb1] : () -> ()
    ^bb1:  // pred: ^bb0
      "omp.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

