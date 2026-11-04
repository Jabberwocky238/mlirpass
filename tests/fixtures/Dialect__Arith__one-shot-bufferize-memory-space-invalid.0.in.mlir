"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> tensor<10xf32>, sym_name = "inconsistent_memory_space_arith_select"}> ({
  ^bb0(%arg0: i1):
    %0 = "bufferization.alloc_tensor"() <{memory_space = 0 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %1 = "bufferization.alloc_tensor"() <{memory_space = 1 : ui64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %2 = "arith.select"(%arg0, %0, %1) : (i1, tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%2) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i32) -> tensor<3xi32>, sym_name = "unknown_memory_space"}> ({
  ^bb0(%arg0: index, %arg1: i32):
    %0 = "arith.constant"() <{value = dense<[5, 1000, 20]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = "tensor.insert"(%arg1, %0, %arg0) : (i32, tensor<3xi32>, index) -> tensor<3xi32>
    "func.return"(%1) : (tensor<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

