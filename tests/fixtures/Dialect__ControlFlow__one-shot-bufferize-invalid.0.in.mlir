"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "inconsistent_memory_space"}> ({
    %0 = "bufferization.alloc_tensor"() <{memory_space = 0 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    "cf.br"(%0)[^bb1] : (tensor<5xf32>) -> ()
  ^bb1(%1: tensor<5xf32>):  // 2 preds: ^bb0, ^bb2
    "func.return"(%1) : (tensor<5xf32>) -> ()
  ^bb2:  // no predecessors
    %2 = "bufferization.alloc_tensor"() <{memory_space = 1 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    "cf.br"(%2)[^bb1] : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "cannot_infer_type"}> ({
    "func.return"() : () -> ()
  ^bb1(%0: tensor<5xf32>):  // pred: ^bb1
    "cf.br"(%0)[^bb1] : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

