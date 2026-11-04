"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<10xf32>, sym_name = "alloc_tensor_without_memory_space"}> ({
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    "func.return"(%0) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "memory_space_of_unknown_op"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "test.dummy_op"() : () -> tensor<10xf32>
    %2 = "tensor.extract"(%1, %0) : (tensor<10xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

