"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> (tensor<5xf32>, tensor<5xf32>), sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: tensor<5xf32>):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %6 = "tensor.insert"(%5, %arg1, %4) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    "func.return"(%arg1, %6) : (tensor<5xf32>, tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>) -> (f32, f32), sym_name = "main"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1:2 = "func.call"(%arg0) <{callee = @callee}> : (tensor<5xf32>) -> (tensor<5xf32>, tensor<5xf32>)
    %2 = "tensor.extract"(%1#0, %0) : (tensor<5xf32>, index) -> f32
    %3 = "tensor.extract"(%1#1, %0) : (tensor<5xf32>, index) -> f32
    "func.return"(%2, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<2x5xf32>, sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: index):
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10x20xf32>
    %4 = "tensor.extract_slice"(%3, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (tensor<10x20xf32>, index, index) -> tensor<2x5xf32>
    "func.return"(%4) : (tensor<2x5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "func.call"(%arg0) <{callee = @callee}> : (index) -> tensor<2x5xf32>
    %2 = "tensor.extract"(%1, %0, %0) : (tensor<2x5xf32>, index, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

