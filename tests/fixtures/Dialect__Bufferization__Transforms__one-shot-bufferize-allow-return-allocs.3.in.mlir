"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, i1) -> tensor<?xf32>, sym_name = "buffer_not_deallocated"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: i1):
    %0 = "scf.if"(%arg1) ({
      %1 = "test.some_op"() : () -> index
      %2 = "bufferization.alloc_tensor"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>, i1, i32) -> tensor<i32>, sym_name = "write_to_alloc_tensor_or_readonly_tensor"}> ({
  ^bb0(%arg0: tensor<i32>, %arg1: i1, %arg2: i32):
    %0 = "scf.if"(%arg1) ({
      "scf.yield"(%arg0) : (tensor<i32>) -> ()
    }, {
      %1 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<i32>
      %2 = "tensor.insert"(%arg2, %1) : (i32, tensor<i32>) -> tensor<i32>
      "scf.yield"(%2) : (tensor<i32>) -> ()
    }) : (i1) -> tensor<i32>
    "func.return"(%0) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

