"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32>, sym_name = "generalize_pad_tensor_static_shape"}> ({
  ^bb0(%arg4: tensor<1x28x28x1xf32>):
    %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "tensor.empty"() : () -> tensor<1x32x32x1xf32>
    %13 = "linalg.fill"(%11, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1x32x32x1xf32>) -> tensor<1x32x32x1xf32>
    %14 = "tensor.insert_slice"(%arg4, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 2, 2, 0>, static_sizes = array<i64: 1, 28, 28, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x28x28x1xf32>, tensor<1x32x32x1xf32>) -> tensor<1x32x32x1xf32>
    "func.return"(%14) : (tensor<1x32x32x1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x?x2x?xf32>, index) -> tensor<4x?x?x?xf32>, sym_name = "generalize_pad_tensor_dynamic_shape"}> ({
  ^bb0(%arg0: tensor<4x?x2x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<4x?x2x?xf32>, index) -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.addi"(%arg1, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.constant"() <{value = 3 : index}> : () -> index
    %6 = "tensor.dim"(%arg0, %5) : (tensor<4x?x2x?xf32>, index) -> index
    %7 = "arith.addi"(%6, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "tensor.empty"(%2, %4, %7) : (index, index, index) -> tensor<4x?x?x?xf32>
    %9 = "linalg.fill"(%0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<4x?x?x?xf32>) -> tensor<4x?x?x?xf32>
    %10 = "tensor.insert_slice"(%arg0, %9, %arg1, %2, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 2, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808, 0>, static_sizes = array<i64: 4, -9223372036854775808, 2, -9223372036854775808>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<4x?x2x?xf32>, tensor<4x?x?x?xf32>, index, index, index) -> tensor<4x?x?x?xf32>
    "func.return"(%10) : (tensor<4x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32>, sym_name = "generalize_pad_tensor_constant_inside"}> ({
  ^bb0(%arg0: tensor<1x28x28x1xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x32x32x1xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<1x32x32x1xf32>) -> tensor<1x32x32x1xf32>
    %3 = "tensor.insert_slice"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 2, 2, 0>, static_sizes = array<i64: 1, 28, 28, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x28x28x1xf32>, tensor<1x32x32x1xf32>) -> tensor<1x32x32x1xf32>
    "func.return"(%3) : (tensor<1x32x32x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

