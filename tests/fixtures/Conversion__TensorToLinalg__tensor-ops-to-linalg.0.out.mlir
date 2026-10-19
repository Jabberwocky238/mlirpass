module {
  func.func @generalize_pad_tensor_static_shape(%arg0: tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x32x32x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x32x32x1xf32>) -> tensor<1x32x32x1xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %1[0, 2, 2, 0] [1, 28, 28, 1] [1, 1, 1, 1] : tensor<1x28x28x1xf32> into tensor<1x32x32x1xf32>
    return %inserted_slice : tensor<1x32x32x1xf32>
  }
  func.func @generalize_pad_tensor_dynamic_shape(%arg0: tensor<4x?x2x?xf32>, %arg1: index) -> tensor<4x?x?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<4x?x2x?xf32>
    %c2 = arith.constant 2 : index
    %0 = arith.addi %arg1, %c2 : index
    %c3 = arith.constant 3 : index
    %dim_0 = tensor.dim %arg0, %c3 : tensor<4x?x2x?xf32>
    %1 = arith.addi %dim_0, %arg1 : index
    %2 = tensor.empty(%dim, %0, %1) : tensor<4x?x?x?xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<4x?x?x?xf32>) -> tensor<4x?x?x?xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %3[0, 0, %arg1, 0] [4, %dim, 2, %dim_0] [1, 1, 1, 1] : tensor<4x?x2x?xf32> into tensor<4x?x?x?xf32>
    return %inserted_slice : tensor<4x?x?x?xf32>
  }
}

// -----
module {
  func.func @generalize_pad_tensor_constant_inside(%arg0: tensor<1x28x28x1xf32>) -> tensor<1x32x32x1xf32> {
    %0 = tensor.empty() : tensor<1x32x32x1xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x32x32x1xf32>) -> tensor<1x32x32x1xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %1[0, 2, 2, 0] [1, 28, 28, 1] [1, 1, 1, 1] : tensor<1x28x28x1xf32> into tensor<1x32x32x1xf32>
    return %inserted_slice : tensor<1x32x32x1xf32>
  }
}

