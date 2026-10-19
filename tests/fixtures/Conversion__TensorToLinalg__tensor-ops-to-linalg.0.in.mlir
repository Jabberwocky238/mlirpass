"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32>, sym_name = "generalize_pad_tensor_static_shape"}> ({
  ^bb0(%arg6: tensor<1x28x28x1xf32>):
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "tensor.pad"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 2, 2, 0>, static_low = array<i64: 0, 2, 2, 0>}> ({
    ^bb0(%arg7: index, %arg8: index, %arg9: index, %arg10: index):
      "tensor.yield"(%3) : (f32) -> ()
    }) : (tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32>
    "func.return"(%4) : (tensor<1x32x32x1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x?x2x?xf32>, index) -> tensor<4x?x?x?xf32>, sym_name = "generalize_pad_tensor_dynamic_shape"}> ({
  ^bb0(%arg0: tensor<4x?x2x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.pad"(%arg0, %0, %0, %arg1, %0, %0, %0, %0, %arg1) <{operandSegmentSizes = array<i32: 1, 4, 4>, static_high = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index):
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<4x?x2x?xf32>, index, index, index, index, index, index, index, index) -> tensor<4x?x?x?xf32>
    "func.return"(%2) : (tensor<4x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32>, sym_name = "generalize_pad_tensor_constant_inside"}> ({
  ^bb0(%arg0: tensor<1x28x28x1xf32>):
    %0 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 2, 2, 0>, static_low = array<i64: 0, 2, 2, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32>
    "func.return"(%0) : (tensor<1x32x32x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

