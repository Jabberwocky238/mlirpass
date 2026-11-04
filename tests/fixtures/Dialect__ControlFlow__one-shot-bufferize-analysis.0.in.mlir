"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "single_branch"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    "cf.br"(%arg0)[^bb1] : (tensor<5xf32>) -> ()
  ^bb1(%0: tensor<5xf32>):  // pred: ^bb0
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>, sym_name = "diamond_branch"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<5xf32>, %arg2: tensor<5xf32>):
    "cf.cond_br"(%arg0, %arg1, %arg2)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, tensor<5xf32>, tensor<5xf32>) -> ()
  ^bb1(%0: tensor<5xf32>):  // 2 preds: ^bb2, ^bb3
    "func.return"(%0) : (tensor<5xf32>) -> ()
  ^bb2(%1: tensor<5xf32>):  // pred: ^bb0
    "cf.br"(%1)[^bb1] : (tensor<5xf32>) -> ()
  ^bb3(%2: tensor<5xf32>):  // pred: ^bb0
    "cf.br"(%2)[^bb1] : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "looping_branches"}> ({
    %0 = "tensor.empty"() : () -> tensor<5xf32>
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

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<5xf32>, sym_name = "looping_branches_with_conflict"}> ({
  ^bb0(%arg0: f32):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "cf.br"(%1)[^bb2] : (tensor<5xf32>) -> ()
  ^bb1(%2: tensor<5xf32>):  // pred: ^bb2
    %3 = "test.foo"() : () -> index
    %4 = "tensor.extract"(%1, %3) : (tensor<5xf32>, index) -> f32
    "func.return"(%2) : (tensor<5xf32>) -> ()
  ^bb2(%5: tensor<5xf32>):  // 2 preds: ^bb0, ^bb2
    %6 = "test.foo"() : () -> index
    %7 = "test.bar"() : () -> f32
    %8 = "tensor.insert"(%7, %5, %6) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    %9 = "test.qux"() : () -> i1
    "cf.cond_br"(%9, %8, %8)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, tensor<5xf32>, tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "looping_branches_outside_def"}> ({
  ^bb0(%arg0: f32):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %4 = "tensor.insert"(%3, %1, %2) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    %5 = "test.foo"() : () -> index
    %6 = "tensor.extract"(%4, %5) : (tensor<5xf32>, index) -> f32
    %7 = "test.qux"(%6) : (f32) -> i1
    "cf.cond_br"(%7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "looping_branches_outside_def2"}> ({
  ^bb0(%arg0: f32):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "cf.br"(%1)[^bb1] : (tensor<5xf32>) -> ()
  ^bb1(%2: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %3 = "test.foo"() : () -> index
    %4 = "test.bar"() : () -> f32
    %5 = "tensor.insert"(%4, %2, %3) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    %6 = "test.foo"() : () -> index
    %7 = "tensor.extract"(%5, %6) : (tensor<5xf32>, index) -> f32
    %8 = "test.qux"(%7) : (f32) -> i1
    "cf.cond_br"(%8, %2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, tensor<5xf32>) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "looping_branches_outside_def3"}> ({
  ^bb0(%arg0: f32):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "cf.br"(%1)[^bb1] : (tensor<5xf32>) -> ()
  ^bb1(%2: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %3 = "test.foo"() : () -> index
    %4 = "test.bar"() : () -> f32
    %5 = "tensor.insert"(%4, %2, %3) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    %6 = "test.foo"() : () -> index
    %7 = "tensor.extract"(%5, %6) : (tensor<5xf32>, index) -> f32
    %8 = "test.qux"(%7) : (f32) -> i1
    "cf.cond_br"(%8, %1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, tensor<5xf32>) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "looping_branches_sequence_outside_def"}> ({
  ^bb0(%arg0: f32):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %4 = "tensor.insert"(%3, %1, %2) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %5 = "test.foo"() : () -> index
    %6 = "tensor.extract"(%4, %5) : (tensor<5xf32>, index) -> f32
    %7 = "test.qux"(%6) : (f32) -> i1
    "cf.cond_br"(%7)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "looping_branches_sequence_inside_def"}> ({
  ^bb0(%arg0: f32):
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %4 = "tensor.insert"(%3, %1, %2) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %5 = "test.foo"() : () -> index
    %6 = "tensor.extract"(%4, %5) : (tensor<5xf32>, index) -> f32
    %7 = "test.qux"(%6) : (f32) -> i1
    "cf.cond_br"(%7)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

