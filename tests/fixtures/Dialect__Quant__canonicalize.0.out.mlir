module {
  func.func @dcast_fold(%arg0: tensor<4xf32>) -> tensor<4xf32> {
    return %arg0 : tensor<4xf32>
  }
}

// -----
module {
  func.func @dcast_no_fold_source(%arg0: tensor<4xi8>) -> tensor<4xf32> {
    %0 = quant.scast %arg0 : tensor<4xi8> to tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
    %1 = quant.dcast %0 : tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>> to tensor<4xf32>
    return %1 : tensor<4xf32>
  }
}

// -----
module {
  func.func @qcast_fold(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>> {
    return %arg0 : tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
  }
}

// -----
module {
  func.func @qcast_no_fold_source(%arg0: tensor<4xf32>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>> {
    %0 = arith.negf %arg0 : tensor<4xf32>
    %1 = quant.qcast %0 : tensor<4xf32> to tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
    return %1 : tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
  }
}

// -----
module {
  func.func @qcast_no_fold_type(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>> {
    %0 = quant.dcast %arg0 : tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>> to tensor<4xf32>
    %1 = quant.qcast %0 : tensor<4xf32> to tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>
    return %1 : tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>
  }
}

// -----
module {
  func.func @scast_fold(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>> {
    return %arg0 : tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
  }
}

// -----
module {
  func.func @scast_no_fold_source(%arg0: tensor<4xf32>) -> tensor<4xi8> {
    %0 = quant.qcast %arg0 : tensor<4xf32> to tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
    %1 = quant.scast %0 : tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>> to tensor<4xi8>
    return %1 : tensor<4xi8>
  }
}

// -----
module {
  func.func @scast_no_fold_type(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>> {
    %0 = quant.scast %arg0 : tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>> to tensor<4xi8>
    %1 = quant.scast %0 : tensor<4xi8> to tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>
    return %1 : tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>
  }
}

