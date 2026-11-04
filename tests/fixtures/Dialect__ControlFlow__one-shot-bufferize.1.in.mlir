"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> (), sym_name = "br"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "scf.execute_region"() ({
      "cf.br"(%arg0)[^bb1] : (tensor<5xf32>) -> ()
    ^bb1(%1: tensor<5xf32>):  // pred: ^bb0
      "scf.yield"(%1) : (tensor<5xf32>) -> ()
    }) : () -> tensor<5xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, i1) -> (), sym_name = "cond_br"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: i1):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "scf.execute_region"() ({
      "cf.cond_br"(%arg1, %arg0, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, tensor<5xf32>, tensor<5xf32>) -> ()
    ^bb1(%2: tensor<5xf32>):  // 2 preds: ^bb0, ^bb2
      "scf.yield"(%2) : (tensor<5xf32>) -> ()
    ^bb2(%3: tensor<5xf32>):  // pred: ^bb0
      "cf.br"(%3)[^bb1] : (tensor<5xf32>) -> ()
    }) : () -> tensor<5xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "looping_branches"}> ({
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    "cf.br"(%0)[^bb1] : (tensor<5xf32>) -> ()
  ^bb1(%1: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %4 = "tensor.insert"(%3, %1, %2) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    %5 = "test.qux"() : () -> i1
    "cf.cond_br"(%5, %4, %4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, tensor<5xf32>, tensor<5xf32>) -> ()
  ^bb2(%6: tensor<5xf32>):  // pred: ^bb1
    "func.return"(%6) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

