"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "forward"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%0)[^bb1] : (i32) -> ()
    ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
      %4 = "spirv.SLessThan"(%3, %1) : (i32, i32) -> i1
      "spirv.BranchConditional"(%4)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %5 = "spirv.IAdd"(%3, %3) : (i32, i32) -> i32
      %6 = "spirv.IAdd"(%3, %2) : (i32, i32) -> i32
      "spirv.Branch"(%6)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

