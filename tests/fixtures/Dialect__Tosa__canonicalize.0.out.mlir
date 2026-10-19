module {
  func.func @argmax_nofold(%arg0: tensor<?x1xf32>) -> tensor<1xi32> {
    %0 = tosa.argmax %arg0 {axis = 0 : i32} : (tensor<?x1xf32>) -> tensor<1xi32>
    return %0 : tensor<1xi32>
  }
}

// -----
module {
  func.func @test_argmax_fold_i64_index(%arg0: tensor<1xi8>) -> tensor<i64> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<i64>}> : () -> tensor<i64>
    return %0 : tensor<i64>
  }
}

// -----
module {
  func.func @pad_wh_avg_pool2d_nofold(%arg0: tensor<1x10x8x3xf32>) -> tensor<1x6x5x3xf32> {
    %0 = tosa.const_shape  {values = dense<[0, 0, 1, 0, 1, 0, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pad %arg0, %0, %1 : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x11x9x3xf32>
    %3 = tosa.avg_pool2d %2, %1, %1 {acc_type = f32, kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>} : (tensor<1x11x9x3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x6x5x3xf32>
    return %3 : tensor<1x6x5x3xf32>
  }
}

// -----
module {
  func.func @pad_wh_avg_pool2d_nofold_pad_const(%arg0: tensor<1x10x8x3xi8>) -> tensor<1x6x5x3xi8> {
    %0 = tosa.const_shape  {values = dense<[0, 0, 1, 0, 1, 0, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<10> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<20> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.pad %arg0, %0, %1 : (tensor<1x10x8x3xi8>, !tosa.shape<8>, tensor<1xi8>) -> tensor<1x11x9x3xi8>
    %5 = tosa.avg_pool2d %4, %2, %3 {acc_type = i32, kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>} : (tensor<1x11x9x3xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x6x5x3xi8>
    return %5 : tensor<1x6x5x3xi8>
  }
}

// -----
module {
  func.func @pad_wh_avg_pool2d_nofold_pad_larger_than_kernel(%arg0: tensor<1x10x8x3xf32>) -> tensor<1x7x5x3xf32> {
    %0 = tosa.const_shape  {values = dense<[0, 0, 3, 0, 1, 0, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pad %arg0, %0, %1 : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x13x9x3xf32>
    %3 = tosa.avg_pool2d %2, %1, %1 {acc_type = f32, kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>} : (tensor<1x13x9x3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x7x5x3xf32>
    return %3 : tensor<1x7x5x3xf32>
  }
}

// -----
module {
  func.func @pad_wh_conv2d_fold(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<1x3x3x3xf32>, %arg2: tensor<1xf32>) -> tensor<1x10x8x1xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.conv2d %arg0, %arg1, %arg2, %0, %0 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 2, 2, 3, 3>, stride = array<i64: 1, 1>} : (tensor<1x8x4x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x10x8x1xf32>
    return %1 : tensor<1x10x8x1xf32>
  }
}

// -----
module {
  func.func @pad_bwh_conv2d_nofold(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<1x3x3x3xf32>, %arg2: tensor<1xf32>) -> tensor<3x10x8x1xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 1, 1, 1, 2, 2, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pad %arg0, %0, %1 : (tensor<1x8x4x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<3x10x8x3xf32>
    %3 = tosa.conv2d %2, %arg1, %arg2, %1, %1 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>} : (tensor<3x10x8x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<3x10x8x1xf32>
    return %3 : tensor<3x10x8x1xf32>
  }
}

// -----
module {
  func.func @pad_wh_conv2d_nofold_pad_const(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<1x3x3x3xf32>, %arg2: tensor<1xf32>) -> tensor<1x10x8x1xf32> {
    %0 = tosa.const_shape  {values = dense<[0, 0, 1, 1, 2, 2, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.pad %arg0, %0, %1 : (tensor<1x8x4x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x10x8x3xf32>
    %4 = tosa.conv2d %3, %arg1, %arg2, %2, %2 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>} : (tensor<1x10x8x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x10x8x1xf32>
    return %4 : tensor<1x10x8x1xf32>
  }
}

// -----
module {
  func.func @pad_wh_depthwise_conv2d_fold(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<3x3x3x1xf32>, %arg2: tensor<3xf32>) -> tensor<1x10x8x3xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.depthwise_conv2d %arg0, %arg1, %arg2, %0, %0 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 2, 2, 3, 3>, stride = array<i64: 1, 1>} : (tensor<1x8x4x3xf32>, tensor<3x3x3x1xf32>, tensor<3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x10x8x3xf32>
    return %1 : tensor<1x10x8x3xf32>
  }
}

// -----
module {
  func.func @pad_wh_max_pool2d_fold(%arg0: tensor<1x10x8x3xf32>) -> tensor<1x6x5x3xf32> {
    %0 = tosa.max_pool2d %arg0 {kernel = array<i64: 2, 2>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 2, 2>} : (tensor<1x10x8x3xf32>) -> tensor<1x6x5x3xf32>
    return %0 : tensor<1x6x5x3xf32>
  }
}

// -----
module {
  func.func @pad_wh_max_pool2d_nofold_pad_const(%arg0: tensor<1x10x8x3xf32>) -> tensor<1x6x5x3xf32> {
    %0 = tosa.const_shape  {values = dense<[0, 0, 1, 0, 1, 0, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pad %arg0, %0, %1 : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x11x9x3xf32>
    %3 = tosa.max_pool2d %2 {kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>} : (tensor<1x11x9x3xf32>) -> tensor<1x6x5x3xf32>
    return %3 : tensor<1x6x5x3xf32>
  }
}

// -----
module {
  func.func @pad_wh_max_pool2d_no_fold_8k_limit(%arg0: tensor<1x10x8x3xf32>) -> tensor<1x6x4101x3xf32> {
    %0 = tosa.const_shape  {values = dense<[0, 0, 1, 0, 8193, 0, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pad %arg0, %0, %1 : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x11x8201x3xf32>
    %3 = tosa.max_pool2d %2 {kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>} : (tensor<1x11x8201x3xf32>) -> tensor<1x6x4101x3xf32>
    return %3 : tensor<1x6x4101x3xf32>
  }
}

// -----
module {
  func.func @add_bcast_zero_int(%arg0: tensor<4x2x3xi32>) -> tensor<4x2x3xi32> {
    return %arg0 : tensor<4x2x3xi32>
  }
}

// -----
module {
  func.func @add_zero_int(%arg0: tensor<2x3xi32>) -> tensor<2x3xi32> {
    return %arg0 : tensor<2x3xi32>
  }
}

// -----
module {
  func.func @cast_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @cast_nofold(%arg0: tensor<?x1xf32>) -> tensor<?x1xi32> {
    %0 = tosa.cast %arg0 : (tensor<?x1xf32>) -> tensor<?x1xi32>
    return %0 : tensor<?x1xi32>
  }
}

// -----
module {
  func.func @clamp_i32_not_noop(%arg0: tensor<4xi32>) -> tensor<4xi32> {
    %0 = tosa.clamp %arg0 {max_val = 4 : i32, min_val = 1 : i32} : (tensor<4xi32>) -> tensor<4xi32>
    return %0 : tensor<4xi32>
  }
}

// -----
module {
  func.func @clamp_f32_not_noop(%arg0: tensor<4xf32>) -> tensor<4xf32> {
    %0 = tosa.clamp %arg0 {max_val = 3.40282347E+38 : f32, min_val = -3.40282347E+38 : f32} : (tensor<4xf32>) -> tensor<4xf32>
    return %0 : tensor<4xf32>
  }
}

// -----
module {
  func.func @clamp_f16_is_noop(%arg0: tensor<4xf16>) -> tensor<4xf16> {
    return %arg0 : tensor<4xf16>
  }
}

// -----
module {
  func.func @clamp_f32_is_noop(%arg0: tensor<4xf32>) -> tensor<4xf32> {
    return %arg0 : tensor<4xf32>
  }
}

// -----
module {
  func.func @clamp_boolean_is_noop(%arg0: tensor<4xi1>) -> tensor<4xi1> {
    return %arg0 : tensor<4xi1>
  }
}

// -----
module {
  func.func @clamp_boolean_dynamic_is_noop(%arg0: tensor<?xi1>) -> tensor<?xi1> {
    return %arg0 : tensor<?xi1>
  }
}

// -----
module {
  func.func @clamp_int8_is_noop(%arg0: tensor<4xi8>) -> tensor<4xi8> {
    return %arg0 : tensor<4xi8>
  }
}

// -----
module {
  func.func @clamp_int16_is_noop(%arg0: tensor<4xi16>) -> tensor<4xi16> {
    return %arg0 : tensor<4xi16>
  }
}

// -----
module {
  func.func @clamp_uint8_is_noop(%arg0: tensor<4xui8>) -> tensor<4xui8> {
    return %arg0 : tensor<4xui8>
  }
}

// -----
module {
  func.func @clamp_twice_is_single_clamp(%arg0: tensor<4xi8>) -> tensor<4xi8> {
    %0 = tosa.clamp %arg0 {max_val = 2 : i8, min_val = -2 : i8} : (tensor<4xi8>) -> tensor<4xi8>
    return %0 : tensor<4xi8>
  }
}

// -----
module {
  func.func @disjoint_clamp_twice_is_not_single_clamp(%arg0: tensor<4xi8>) -> tensor<4xi8> {
    %0 = tosa.clamp %arg0 {max_val = -5 : i8, min_val = -10 : i8} : (tensor<4xi8>) -> tensor<4xi8>
    %1 = tosa.clamp %0 {max_val = 5 : i8, min_val = 1 : i8} : (tensor<4xi8>) -> tensor<4xi8>
    return %1 : tensor<4xi8>
  }
}

// -----
module {
  func.func @clamp_twice_with_nan_propagate_is_single_clamp(%arg0: tensor<4xi8>) -> tensor<4xi8> {
    %0 = tosa.clamp %arg0 {max_val = 2 : i8, min_val = -2 : i8} : (tensor<4xi8>) -> tensor<4xi8>
    return %0 : tensor<4xi8>
  }
}

// -----
module {
  func.func @clamp_twice_with_nan_ignore_is_single_clamp(%arg0: tensor<4xi8>) -> tensor<4xi8> {
    %0 = tosa.clamp %arg0 {max_val = 2 : i8, min_val = -2 : i8, nan_mode = IGNORE} : (tensor<4xi8>) -> tensor<4xi8>
    return %0 : tensor<4xi8>
  }
}

// -----
module {
  func.func @clamp_twice_with_nan_ignore_propagate_is_single_clamp(%arg0: tensor<4xi8>) -> tensor<4xi8> {
    %0 = tosa.clamp %arg0 {max_val = 2 : i8, min_val = -2 : i8, nan_mode = IGNORE} : (tensor<4xi8>) -> tensor<4xi8>
    return %0 : tensor<4xi8>
  }
}

// -----
module {
  func.func @clamp_twice_with_nan_propagate_ignore_is_not_single_clamp(%arg0: tensor<4xi8>) -> tensor<4xi8> {
    %0 = tosa.clamp %arg0 {max_val = 4 : i8, min_val = -2 : i8} : (tensor<4xi8>) -> tensor<4xi8>
    %1 = tosa.clamp %0 {max_val = 2 : i8, min_val = -4 : i8, nan_mode = IGNORE} : (tensor<4xi8>) -> tensor<4xi8>
    return %1 : tensor<4xi8>
  }
}

// -----
module {
  func.func @clamp_twice_with_unsigned_quantized_is_single_clamp(%arg0: tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>> {
    %0 = tosa.clamp %arg0 {max_val = 230 : ui8, min_val = 10 : ui8} : (tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>
    return %0 : tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>
  }
}

// -----
module {
  func.func @clamp_twice_with_signed_quantized_is_single_clamp(%arg0: tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>> {
    %0 = tosa.clamp %arg0 {max_val = 110 : i8, min_val = -5 : i8} : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
    return %0 : tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
  }
  func.func @clamp_twice_with_signed_quantized_non_overlap_is_not_single_clamp(%arg0: tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>> {
    %0 = tosa.clamp %arg0 {max_val = 50 : i8, min_val = -10 : i8} : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
    %1 = tosa.clamp %0 {max_val = 120 : i8, min_val = 60 : i8} : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
    return %1 : tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
  }
}

// -----
module {
  func.func @concat_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @concat_fold_cast(%arg0: tensor<?x1xf32>) -> tensor<?x?xf32> {
    %cast = tensor.cast %arg0 : tensor<?x1xf32> to tensor<?x?xf32>
    return %cast : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @conv2d_stride_2(%arg0: tensor<4x11x11x2xf32>) -> tensor<4x6x6x3xf32> {
    %0 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<3x1x1x2xf32>}> : () -> tensor<3x1x1x2xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.conv2d %arg0, %0, %1, %2, %2 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 2, 2>} : (tensor<4x11x11x2xf32>, tensor<3x1x1x2xf32>, tensor<3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x6x6x3xf32>
    return %3 : tensor<4x6x6x3xf32>
  }
}

// -----
module {
  func.func @conv2d_weight_2x2(%arg0: tensor<4x10x10x1xf32>) -> tensor<4x9x9x1xf32> {
    %0 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<1x2x2x1xf32>}> : () -> tensor<1x2x2x1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.conv2d %arg0, %0, %1, %1, %1 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>} : (tensor<4x10x10x1xf32>, tensor<1x2x2x1xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x9x9x1xf32>
    return %2 : tensor<4x9x9x1xf32>
  }
}

// -----
module {
  func.func @depthwise_conv2d_stride_2(%arg0: tensor<4x11x11x2xf32>, %arg1: tensor<1x1x2x3xf32>, %arg2: tensor<6xf32>, %arg3: tensor<1xf32>, %arg4: tensor<1xf32>) -> tensor<4x6x6x6xf32> {
    %0 = tosa.depthwise_conv2d %arg0, %arg1, %arg2, %arg3, %arg4 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 2, 2>} : (tensor<4x11x11x2xf32>, tensor<1x1x2x3xf32>, tensor<6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x6x6x6xf32>
    return %0 : tensor<4x6x6x6xf32>
  }
}

// -----
module {
  func.func @depthwise_conv2d_weight_2x2(%arg0: tensor<4x10x10x2xf32>, %arg1: tensor<2x2x2x3xf32>, %arg2: tensor<6xf32>, %arg3: tensor<1xf32>, %arg4: tensor<1xf32>) -> tensor<4x9x9x6xf32> {
    %0 = tosa.depthwise_conv2d %arg0, %arg1, %arg2, %arg3, %arg4 {acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>} : (tensor<4x10x10x2xf32>, tensor<2x2x2x3xf32>, tensor<6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x9x9x6xf32>
    return %0 : tensor<4x9x9x6xf32>
  }
}

// -----
module {
  func.func @max_pool2d_is_noop(%arg0: tensor<10x1x1x3xf32>) -> tensor<10x1x1x3xf32> {
    return %arg0 : tensor<10x1x1x3xf32>
  }
}

// -----
module {
  func.func @pad_noop(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> {
    return %arg0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @pad_noop_padding_mismatch_nofold(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 0, 0, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pad %arg0, %0, %1 : (tensor<?x?xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @pad_noop_type_mismatch_nofold(%arg0: tensor<10xf32>) -> tensor<?xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pad %arg0, %0, %1 : (tensor<10xf32>, !tosa.shape<2>, tensor<1xf32>) -> tensor<?xf32>
    return %2 : tensor<?xf32>
  }
}

// -----
module {
  func.func @pad_determine_val_i32(%arg0: tensor<?x?xi32>, %arg1: tensor<2x2xi32>) -> tensor<?x?xi32> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = tosa.const_shape  {values = dense<[1, 0, 0, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.pad %arg0, %1, %0 : (tensor<?x?xi32>, !tosa.shape<4>, tensor<1xi32>) -> tensor<?x?xi32>
    return %2 : tensor<?x?xi32>
  }
}

// -----
module {
  func.func @pad_determine_val_f32(%arg0: tensor<?x?xf32>, %arg1: tensor<2x2xi32>) -> tensor<?x?xf32> {
    %0 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.const_shape  {values = dense<[1, 0, 0, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.pad %arg0, %1, %0 : (tensor<?x?xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @pad_determine_val_quant(%arg0: tensor<?x?xi32>, %arg1: tensor<2x2xi32>) -> tensor<?x?xi32> {
    %0 = "tosa.const"() <{values = dense<3> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = tosa.const_shape  {values = dense<[1, 0, 0, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.pad %arg0, %1, %0 {input_zp = 42 : i32} : (tensor<?x?xi32>, !tosa.shape<4>, tensor<1xi32>) -> tensor<?x?xi32>
    return %2 : tensor<?x?xi32>
  }
}

// -----
module {
  func.func @mul_one_float(%arg0: tensor<2x3xf32>) -> tensor<2x3xf32> {
    return %arg0 : tensor<2x3xf32>
  }
}

// -----
module {
  func.func @mul_bcast_one_float(%arg0: tensor<2x3xf32>) -> tensor<2x3xf32> {
    return %arg0 : tensor<2x3xf32>
  }
}

// -----
module {
  func.func @mul_one_int(%arg0: tensor<2x3xi32>) -> tensor<2x3xi32> {
    return %arg0 : tensor<2x3xi32>
  }
}

// -----
module {
  func.func @mul_one_int_and_shift(%arg0: tensor<2x3xi32>) -> tensor<2x3xi32> {
    %0 = "tosa.const"() <{values = dense<1> : tensor<2x3xi32>}> : () -> tensor<2x3xi32>
    %1 = "tosa.const"() <{values = dense<31> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.mul %arg0, %0, %1 : (tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>) -> tensor<2x3xi32>
    return %2 : tensor<2x3xi32>
  }
}

// -----
module {
  func.func @mul_zero_broadcast(%arg0: tensor<2x3xf32>) -> (tensor<2x3xf32>, tensor<2x3xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    return %0, %0 : tensor<2x3xf32>, tensor<2x3xf32>
  }
}

// -----
module {
  func.func @mul_zero_dynamic_nofold(%arg0: tensor<?x17xf32>) -> tensor<?x17xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.mul %arg0, %0, %1 : (tensor<?x17xf32>, tensor<1x1xf32>, tensor<1xi8>) -> tensor<?x17xf32>
    return %2 : tensor<?x17xf32>
  }
}

// -----
module {
  func.func @mul_one_dynamic_fold(%arg0: tensor<?x17xf32>) -> tensor<?x17xf32> {
    return %arg0 : tensor<?x17xf32>
  }
}

// -----
module {
  func.func @select_same_value(%arg0: tensor<2x3xi1>, %arg1: tensor<2x3xi32>) -> tensor<2x3xi32> {
    return %arg1 : tensor<2x3xi32>
  }
}

// -----
module {
  func.func @select_true_value(%arg0: tensor<2x3xi32>, %arg1: tensor<2x3xi32>) -> tensor<2x3xi32> {
    return %arg0 : tensor<2x3xi32>
  }
}

// -----
module {
  func.func @select_false_value(%arg0: tensor<2x3xi32>, %arg1: tensor<2x3xi32>) -> tensor<2x3xi32> {
    return %arg1 : tensor<2x3xi32>
  }
}

// -----
module {
  func.func @select_not_pred(%arg0: tensor<2x3xi1>, %arg1: tensor<2x3xi32>, %arg2: tensor<2x3xi32>) -> tensor<2x3xi32> {
    %0 = tosa.select %arg0, %arg2, %arg1 : (tensor<2x3xi1>, tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>
    return %0 : tensor<2x3xi32>
  }
}

// -----
module {
  func.func @select_broadcast_same_value_no_fold(%arg0: tensor<2x2xi1>, %arg1: tensor<1x1xf32>) -> tensor<2x2xf32> {
    %0 = tosa.select %arg0, %arg1, %arg1 : (tensor<2x2xi1>, tensor<1x1xf32>, tensor<1x1xf32>) -> tensor<2x2xf32>
    return %0 : tensor<2x2xf32>
  }
}

// -----
module {
  func.func @select_broadcast_true_value_no_fold(%arg0: tensor<1x1xf32>, %arg1: tensor<2x2xf32>) -> tensor<?x?xf32> {
    %0 = "tosa.const"() <{values = dense<true> : tensor<2x2xi1>}> : () -> tensor<2x2xi1>
    %1 = tosa.select %0, %arg0, %arg1 : (tensor<2x2xi1>, tensor<1x1xf32>, tensor<2x2xf32>) -> tensor<?x?xf32>
    return %1 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @select_broadcast_false_value_no_fold(%arg0: tensor<2x2xf32>, %arg1: tensor<1x1xf32>) -> tensor<2x2xf32> {
    %0 = "tosa.const"() <{values = dense<false> : tensor<2x2xi1>}> : () -> tensor<2x2xi1>
    %1 = tosa.select %0, %arg0, %arg1 : (tensor<2x2xi1>, tensor<2x2xf32>, tensor<1x1xf32>) -> tensor<2x2xf32>
    return %1 : tensor<2x2xf32>
  }
}

// -----
module {
  func.func @select_broadcast_false_value_dynamic_operand_no_fold(%arg0: tensor<2x?xf32>, %arg1: tensor<2x2xf32>) -> tensor<2x2xf32> {
    %0 = "tosa.const"() <{values = dense<false> : tensor<2x2xi1>}> : () -> tensor<2x2xi1>
    %1 = tosa.select %0, %arg0, %arg1 : (tensor<2x2xi1>, tensor<2x?xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>
    return %1 : tensor<2x2xf32>
  }
}

// -----
module {
  func.func @reduce_all_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_all_nofold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    %0 = tosa.reduce_all %arg0 {axis = 0 : i32} : (tensor<?x1xf32>) -> tensor<?x1xf32>
    return %0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_any_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_any_nofold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    %0 = tosa.reduce_any %arg0 {axis = 0 : i32} : (tensor<?x1xf32>) -> tensor<?x1xf32>
    return %0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_max_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_max_nofold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    %0 = tosa.reduce_max %arg0 {axis = 0 : i32} : (tensor<?x1xf32>) -> tensor<?x1xf32>
    return %0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_min_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_min_nofold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    %0 = tosa.reduce_min %arg0 {axis = 0 : i32} : (tensor<?x1xf32>) -> tensor<?x1xf32>
    return %0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_product_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_product_nofold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    %0 = tosa.reduce_product %arg0 {axis = 0 : i32} : (tensor<?x1xf32>) -> tensor<?x1xf32>
    return %0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_sum_fold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reduce_sum_nofold(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    %0 = tosa.reduce_sum %arg0 {axis = 0 : i32} : (tensor<?x1xf32>) -> tensor<?x1xf32>
    return %0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reshape_canonicalize(%arg0: tensor<?x10xf32>) -> tensor<?x10xf32> {
    return %arg0 : tensor<?x10xf32>
  }
}

// -----
module {
  func.func @reshape_canonicalize_dyn_nofold(%arg0: tensor<?x?x10xf32>) -> tensor<?x?x10xf32> {
    %0 = tosa.const_shape  {values = dense<[-1, 2, 10]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %1 = tosa.reshape %arg0, %0 : (tensor<?x?x10xf32>, !tosa.shape<3>) -> tensor<?x?x10xf32>
    return %1 : tensor<?x?x10xf32>
  }
}

// -----
module {
  func.func @reshape_canonicalize_double(%arg0: tensor<?x10xf32>) -> tensor<?x5xf32> {
    %0 = tosa.const_shape  {values = dense<[-1, 5]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %1 = tosa.reshape %arg0, %0 : (tensor<?x10xf32>, !tosa.shape<2>) -> tensor<?x5xf32>
    return %1 : tensor<?x5xf32>
  }
}

// -----
module {
  func.func @reshape_canonicalize_const() -> tensor<1x5xi32> {
    %0 = "tosa.const"() <{values = dense<[[0, 1, 2, 3, 4]]> : tensor<1x5xi32>}> : () -> tensor<1x5xi32>
    return %0 : tensor<1x5xi32>
  }
}

// -----
module {
  func.func @reshape_canonicalize_const_dynamic() -> tensor<1x?xi32> {
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4]> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = tosa.const_shape  {values = dense<[1, 5]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<5xi32>, !tosa.shape<2>) -> tensor<1x?xi32>
    return %2 : tensor<1x?xi32>
  }
}

// -----
module {
  func.func @reshape_canonicalize_const_splat() -> (tensor<10xi32>, tensor<1x10xi32>) {
    %0 = "tosa.const"() <{values = dense<0> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1x10xi32>}> : () -> tensor<1x10xi32>
    return %0, %1 : tensor<10xi32>, tensor<1x10xi32>
  }
}

// -----
module {
  func.func @reshape_canonicalize_const_sparse() -> (tensor<3xi32>, tensor<1x3xi32>) {
    %0 = "tosa.const"() <{values = dense<[1, 2, 3]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = tosa.const_shape  {values = dense<[1, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<3xi32>, !tosa.shape<2>) -> tensor<1x3xi32>
    return %0, %2 : tensor<3xi32>, tensor<1x3xi32>
  }
}

// -----
module {
  func.func @reshape_canonicalize_quant_nofold() -> tensor<1x3x!quant.uniform<i8:f32, 1.000000e+00>> {
    %0 = "tosa.const"() <{values = dense<[1, 2, 3]> : tensor<3xi8>}> : () -> tensor<3x!quant.uniform<i8:f32, 1.000000e+00>>
    %1 = tosa.const_shape  {values = dense<[1, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<3x!quant.uniform<i8:f32, 1.000000e+00>>, !tosa.shape<2>) -> tensor<1x3x!quant.uniform<i8:f32, 1.000000e+00>>
    return %2 : tensor<1x3x!quant.uniform<i8:f32, 1.000000e+00>>
  }
}

// -----
module {
  func.func @transpose_canonicalize_strip_quant() -> tensor<2x1x3x!quant.uniform<i8:f32, 1.000000e+00>> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1x2x3xi8>}> : () -> tensor<1x2x3x!quant.uniform<i8:f32, 1.000000e+00>>
    %1 = tosa.const_shape  {values = dense<[2, 1, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<1x2x3x!quant.uniform<i8:f32, 1.000000e+00>>, !tosa.shape<3>) -> tensor<2x1x3x!quant.uniform<i8:f32, 1.000000e+00>>
    return %2 : tensor<2x1x3x!quant.uniform<i8:f32, 1.000000e+00>>
  }
}

// -----
module {
  func.func @slice_fold(%arg0: tensor<3x4xf32>) -> tensor<3x4xf32> {
    return %arg0 : tensor<3x4xf32>
  }
}

// -----
module {
  func.func @slice_nofold(%arg0: tensor<?x4xf32>) -> tensor<?x4xf32> {
    %0 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %1 = tosa.const_shape  {values = dense<[3, 4]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.slice %arg0, %0, %1 : (tensor<?x4xf32>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<?x4xf32>
    return %2 : tensor<?x4xf32>
  }
}

// -----
module {
  func.func @tile_fold(%arg0: tensor<3x4xf32>) -> tensor<3x4xf32> {
    return %arg0 : tensor<3x4xf32>
  }
}

// -----
module {
  func.func @tile_nofold(%arg0: tensor<3x4xf32>) -> tensor<3x8xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %1 = tosa.tile %arg0, %0 : (tensor<3x4xf32>, !tosa.shape<2>) -> tensor<3x8xf32>
    return %1 : tensor<3x8xf32>
  }
}

// -----
module {
  func.func @transpose_no_op(%arg0: tensor<3x4x5x6xf32>) -> tensor<3x4x5x6xf32> {
    return %arg0 : tensor<3x4x5x6xf32>
  }
}

// -----
module {
  func.func @transpose_is_reshape(%arg0: tensor<1x4x5x1xf32>) -> tensor<1x4x1x5xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 4, 1, 5]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.reshape %arg0, %0 : (tensor<1x4x5x1xf32>, !tosa.shape<4>) -> tensor<1x4x1x5xf32>
    return %1 : tensor<1x4x1x5xf32>
  }
}

// -----
module {
  func.func @transpose_is_reshape_unknown_dim(%arg0: tensor<1x4x?x1xf32>) -> tensor<1x4x1x?xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 4, 1, -1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.reshape %arg0, %0 : (tensor<1x4x?x1xf32>, !tosa.shape<4>) -> tensor<1x4x1x?xf32>
    return %1 : tensor<1x4x1x?xf32>
  }
}

// -----
module {
  func.func @single_bit_reshape() -> tensor<1xi1> {
    %0 = "tosa.const"() <{values = dense<true> : tensor<1xi1>}> : () -> tensor<1xi1>
    return %0 : tensor<1xi1>
  }
}

// -----
module {
  func.func @fold_resize_nearest(%arg0: tensor<1x15x13x1xi8>) -> tensor<1x15x13x1xi8> {
    return %arg0 : tensor<1x15x13x1xi8>
  }
}

// -----
module {
  func.func @fold_resize_bilinear(%arg0: tensor<1x15x13x1xi8>) -> tensor<1x15x13x1xi8> {
    return %arg0 : tensor<1x15x13x1xi8>
  }
}

// -----
module {
  func.func @canonicalize_concat_slice_final_axis(%arg0: tensor<1x12x12x1xf32>, %arg1: tensor<1x12x12x1xf32>) -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xf32>) {
    return %arg0, %arg1 : tensor<1x12x12x1xf32>, tensor<1x12x12x1xf32>
  }
}

// -----
module {
  func.func @canonicalize_concat_slice_middle_axis(%arg0: tensor<1x12x12xf32>, %arg1: tensor<1x12x12xf32>) -> (tensor<1x12x12xf32>, tensor<1x12x12xf32>) {
    return %arg0, %arg1 : tensor<1x12x12xf32>, tensor<1x12x12xf32>
  }
}

// -----
module {
  func.func @canonicalize_cross_concat_inputs(%arg0: tensor<1x12x12xf32>, %arg1: tensor<1x12x12xf32>) -> (tensor<1x12x15xf32>, tensor<1x12x20xf32>) {
    %0 = tosa.const_shape  {values = dense<[1, 12, 20]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %1 = tosa.const_shape  {values = dense<[1, 12, 15]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.const_shape  {values = dense<[0, 0, 4]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.const_shape  {values = dense<0> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.concat %arg0, %arg1 {axis = 2 : i32} : (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> tensor<1x12x24xf32>
    %5 = tosa.slice %4, %3, %1 : (tensor<1x12x24xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x12x15xf32>
    %6 = tosa.slice %4, %2, %0 : (tensor<1x12x24xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x12x20xf32>
    return %5, %6 : tensor<1x12x15xf32>, tensor<1x12x20xf32>
  }
}

// -----
module {
  func.func @canonicalize_concat_slice_on_non_concat_axis(%arg0: tensor<1x12x12xf32>, %arg1: tensor<1x12x12xf32>) -> (tensor<1x6x12xf32>, tensor<1x3x12xf32>) {
    %0 = tosa.const_shape  {values = dense<[1, 3, 12]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %1 = tosa.const_shape  {values = dense<[1, 3, 0]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.const_shape  {values = dense<0> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.const_shape  {values = dense<[1, 6, 12]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.slice %arg0, %2, %3 : (tensor<1x12x12xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x6x12xf32>
    %5 = tosa.slice %arg1, %1, %0 : (tensor<1x12x12xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x3x12xf32>
    return %4, %5 : tensor<1x6x12xf32>, tensor<1x3x12xf32>
  }
}

// -----
module {
  func.func @canonicalize_pad_slice_overlap(%arg0: tensor<?x16x16x3xf32>) -> tensor<?x14x18x3xf32> {
    %0 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<[-1, 14, 18, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.const_shape  {values = dense<[0, 0, 0, 0, 1, 1, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %4 = tosa.pad %arg0, %3, %2 : (tensor<?x16x16x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<?x16x18x3xf32>
    %5 = tosa.slice %4, %0, %1 : (tensor<?x16x18x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<?x14x18x3xf32>
    return %5 : tensor<?x14x18x3xf32>
  }
}

// -----
module {
  func.func @canonicalize_pad_slice_inside(%arg0: tensor<1x16x16x3xf32>) -> tensor<1x14x14x3xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 14, 10, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<[0, 1, 2, 0]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.slice %arg0, %1, %0 : (tensor<1x16x16x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x14x14x3xf32>
    return %2 : tensor<1x14x14x3xf32>
  }
}

// -----
module {
  func.func @canonicalize_pad_slice_exact(%arg0: tensor<1x16x16x3xf32>) -> tensor<1x16x20x2xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 16, 20, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.const_shape  {values = dense<[0, 0, 0, 0, 2, 2, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %4 = tosa.pad %arg0, %3, %2 : (tensor<1x16x16x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x16x20x3xf32>
    %5 = tosa.slice %4, %1, %0 : (tensor<1x16x20x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x16x20x2xf32>
    return %5 : tensor<1x16x20x2xf32>
  }
}

// -----
module {
  func.func @canonicalize_pad_slice_dynamic_noupdate(%arg0: tensor<1x16x?x3xf32>) -> tensor<1x16x?x2xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 16, 15, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.const_shape  {values = dense<[0, 0, 0, 0, 2, 2, 0, 0]> : tensor<8xindex>} : () -> !tosa.shape<8>
    %4 = tosa.pad %arg0, %3, %2 : (tensor<1x16x?x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x16x?x3xf32>
    %5 = tosa.slice %4, %1, %0 : (tensor<1x16x?x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x16x?x2xf32>
    return %5 : tensor<1x16x?x2xf32>
  }
}

// -----
module {
  func.func @fold_negate_negate(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    return %arg0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @no_fold_negate_negate_non_const_zp(%arg0: tensor<?x1xf32>, %arg1: tensor<1xf32>) -> tensor<?x1xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.negate %arg0, %arg1, %0 : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %2 = tosa.negate %1, %0, %0 : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %3 = tosa.negate %2, %0, %arg1 : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %4 = tosa.negate %3, %0, %0 : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %5 = tosa.negate %4, %arg1, %0 : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    return %5 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @no_fold_negate_negate_non_zero_zp(%arg0: tensor<?x1xi8>) -> tensor<?x1xi8> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.negate %arg0, %0, %1 : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %3 = tosa.negate %2, %0, %0 : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %4 = tosa.negate %3, %1, %0 : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %5 = tosa.negate %4, %0, %0 : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %6 = tosa.negate %5, %0, %1 : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    return %6 : tensor<?x1xi8>
  }
}

// -----
module {
  func.func @fold_abs_abs(%arg0: tensor<?x1xf32>) -> tensor<?x1xf32> {
    %0 = tosa.abs %arg0 : (tensor<?x1xf32>) -> tensor<?x1xf32>
    return %0 : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @reshape_quant_nofold() -> tensor<1x1x1x1xi32> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<30> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<1073741824> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<127> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %5 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.reshape %4, %5 : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, !tosa.shape<4>) -> tensor<1x1x1x1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %7 = tosa.rescale %6, %3, %2, %1, %0 {input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = DOUBLE_ROUND, scale32 = true} : (tensor<1x1x1x1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi32>) -> tensor<1x1x1x1xi32>
    return %7 : tensor<1x1x1x1xi32>
  }
}

// -----
module {
  func.func @add_quant_nofold() -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>> {
    %0 = "tosa.const"() <{values = dense<127> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = tosa.add %0, %0 : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    return %1 : tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
  }
}

// -----
module {
  func.func @sub_quant_nofold() -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>> {
    %0 = "tosa.const"() <{values = dense<127> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = tosa.sub %0, %0 : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    return %1 : tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
  }
}

// -----
module {
  func.func @greater_quant_fold() -> tensor<i1> {
    %0 = "tosa.const"() <{values = dense<false> : tensor<i1>}> : () -> tensor<i1>
    return %0 : tensor<i1>
  }
}

// -----
module {
  func.func @greater_equal_quant_fold() -> tensor<i1> {
    %0 = "tosa.const"() <{values = dense<true> : tensor<i1>}> : () -> tensor<i1>
    return %0 : tensor<i1>
  }
}

// -----
module {
  func.func @equal_quant_fold() -> tensor<i1> {
    %0 = "tosa.const"() <{values = dense<true> : tensor<i1>}> : () -> tensor<i1>
    return %0 : tensor<i1>
  }
}

// -----
module {
  func.func @cast_quant_nofold() -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:3>> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = tosa.cast %0 : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:3>>
    return %1 : tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:3>>
  }
}

// -----
module {
  func.func @reverse_quant_fold() -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    return %0 : tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
  }
}

// -----
module {
  func.func @select_quant_fold() -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    return %0 : tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
  }
}

// -----
module {
  func.func @mul_quant_nofold() -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = tosa.mul %0, %1, %2 : (tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<1xi8>) -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    return %3 : tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
  }
}

// -----
module {
  func.func nested @fold_reciprocal() -> tensor<3x600x1200xf32> {
    %0 = "tosa.const"() <{values = dense<8.620690e-03> : tensor<3x600x1200xf32>}> : () -> tensor<3x600x1200xf32>
    return %0 : tensor<3x600x1200xf32>
  }
}

// -----
module {
  func.func nested @do_not_fold_reciprocal_int() -> tensor<3x600x1200xi32> {
    %0 = "tosa.const"() <{values = dense<11> : tensor<3x600x1200xi32>}> : () -> tensor<3x600x1200xi32>
    %1 = tosa.reciprocal %0 : (tensor<3x600x1200xi32>) -> tensor<3x600x1200xi32>
    return %1 : tensor<3x600x1200xi32>
  }
}

// -----
module {
  func.func @do_not_fold_intdiv_division_by_0() -> tensor<1x24x2xi32> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1x24x2xi32>}> : () -> tensor<1x24x2xi32>
    %1 = "tosa.const"() <{values = dense<20> : tensor<1x24x2xi32>}> : () -> tensor<1x24x2xi32>
    %2 = tosa.intdiv %1, %0 : (tensor<1x24x2xi32>, tensor<1x24x2xi32>) -> tensor<1x24x2xi32>
    return %2 : tensor<1x24x2xi32>
  }
}

// -----
module {
  func.func @slice_dynamic_size_static_output_canonicalize(%arg0: tensor<2x60x59x?xf32>) -> tensor<2x60x58x?xf32> {
    %0 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<[2, 60, 58, -1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.slice %arg0, %0, %1 : (tensor<2x60x59x?xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<2x60x58x?xf32>
    return %2 : tensor<2x60x58x?xf32>
  }
}

// -----
module {
  func.func @fold_mul_shift() -> tensor<i32> {
    %0 = "tosa.const"() <{values = dense<1> : tensor<i32>}> : () -> tensor<i32>
    return %0 : tensor<i32>
  }
}

// -----
module {
  func.func @fold_mul_no_shift() -> tensor<i32> {
    %0 = "tosa.const"() <{values = dense<781333542> : tensor<i32>}> : () -> tensor<i32>
    return %0 : tensor<i32>
  }
}

// -----
module {
  func.func @no_fold_mul_result_exceeds_i32() -> tensor<i32> {
    %0 = "tosa.const"() <{values = dense<23661> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<330222> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = tosa.mul %0, %1, %2 : (tensor<i32>, tensor<i32>, tensor<1xi8>) -> tensor<i32>
    return %3 : tensor<i32>
  }
}

// -----
module {
  func.func @test_fold_i1_to_i32_cast() -> tensor<i32> {
    %0 = "tosa.const"() <{values = dense<1> : tensor<i32>}> : () -> tensor<i32>
    return %0 : tensor<i32>
  }
}

// -----
module {
  func.func @test_fold_i32_to_i1_cast() -> tensor<i1> {
    %0 = "tosa.const"() <{values = dense<true> : tensor<i1>}> : () -> tensor<i1>
    return %0 : tensor<i1>
  }
}

