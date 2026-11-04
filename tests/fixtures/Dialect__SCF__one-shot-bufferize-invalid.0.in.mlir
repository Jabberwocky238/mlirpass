"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> tensor<10xf32>, sym_name = "inconsistent_memory_space_scf_if"}> ({
  ^bb0(%arg0: i1):
    %0 = "bufferization.alloc_tensor"() <{memory_space = 0 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %1 = "bufferization.alloc_tensor"() <{memory_space = 1 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %2 = "scf.if"(%arg0) ({
      "scf.yield"(%0) : (tensor<10xf32>) -> ()
    }, {
      "scf.yield"(%1) : (tensor<10xf32>) -> ()
    }) : (i1) -> tensor<10xf32>
    "func.return"(%2) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "execute_region_multiple_yields"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "scf.execute_region"() ({
      "scf.yield"(%arg0) : (tensor<5xf32>) -> ()
    ^bb1(%1: tensor<5xf32>):  // no predecessors
      "scf.yield"(%1) : (tensor<5xf32>) -> ()
    }) : () -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "execute_region_no_yield"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "scf.execute_region"() ({
      "cf.br"(%arg0)[^bb1] : (tensor<5xf32>) -> ()
    ^bb1(%1: tensor<5xf32>):  // 2 preds: ^bb0, ^bb2
      "cf.br"(%1)[^bb2] : (tensor<5xf32>) -> ()
    ^bb2(%2: tensor<5xf32>):  // pred: ^bb1
      "cf.br"(%2)[^bb1] : (tensor<5xf32>) -> ()
    }) : () -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> tensor<10xf32>, sym_name = "inconsistent_memory_space_scf_for"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "bufferization.alloc_tensor"() <{memory_space = 0 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %1 = "bufferization.alloc_tensor"() <{memory_space = 1 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %2 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: tensor<10xf32>):
      "scf.yield"(%1) : (tensor<10xf32>) -> ()
    }) : (index, index, index, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%2) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

