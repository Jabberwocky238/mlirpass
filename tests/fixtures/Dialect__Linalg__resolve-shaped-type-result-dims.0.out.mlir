module {
  func.func @empty_tensor_static_dim() -> (index, index) {
    %c6 = arith.constant 6 : index
    %c4 = arith.constant 4 : index
    return %c6, %c4 : index, index
  }
}

// -----
module {
  func.func @empty_tensor_dynamic_dim(%arg0: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @empty_tensor_dynamic_dim2(%arg0: index, %arg1: index) -> (index, index) {
    return %arg0, %arg1 : index, index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<()[s0, s1] -> (-s0 + s1)>
module {
  func.func @remove_dim_result_uses(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>) -> (index, index) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
    %0 = affine.apply #map()[%dim, %dim_0]
    %dim_1 = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_2 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
    %1 = affine.apply #map1()[%dim_1, %dim_2]
    return %0, %1 : index, index
  }
}

// -----
module {
  func.func @remove_dim_result_uses_outs(%arg0: tensor<?xf32>, %arg1: index) -> index {
    return %arg1 : index
  }
}

// -----
module {
  func.func @remove_dim_result_uses_sequence(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>) -> (index, index, index, index) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
    %dim_1 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %dim_2 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
    return %dim, %dim_0, %dim_1, %dim_2 : index, index, index, index
  }
}

// -----
module {
  func.func @keep_result_dim_uses_sequence2(%arg0: tensor<?xf32>, %arg1: index) -> (index, index) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    return %dim, %arg1 : index, index
  }
}

// -----
module {
  func.func @empty_tensor_dim_of_linalg_result(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>) -> (index, index) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %dim_0 = tensor.dim %arg0, %c0 : tensor<?xf32>
    return %dim, %dim_0 : index, index
  }
}

// -----
module {
  func.func @dim_reshape_expansion(%arg0: tensor<6x5x?xf32>, %arg1: index) -> (index, index, index) {
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    return %c3, %c4, %arg1 : index, index, index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 28)>
module {
  func.func @dim_reshape_collapse(%arg0: tensor<2x3x5x4x?x7xf32>) -> (index, index) {
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %dim = tensor.dim %arg0, %c4 : tensor<2x3x5x4x?x7xf32>
    %0 = affine.apply #map()[%dim]
    return %c5, %0 : index, index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 + 5)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 + 4)>
module {
  func.func @dim_of_pad_op(%arg0: tensor<2x?x?xf32>, %arg1: index, %arg2: index, %arg3: f32) -> (index, index, index) {
    %c2 = arith.constant 2 : index
    %c12 = arith.constant 12 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<2x?x?xf32>
    %0 = affine.apply #map()[%dim, %arg1]
    %dim_0 = tensor.dim %arg0, %c2 : tensor<2x?x?xf32>
    %1 = affine.apply #map1()[%dim_0, %arg2]
    return %c12, %0, %1 : index, index, index
  }
}

// -----
module {
  func.func @dim_of_softmax_op(%arg0: tensor<?x16x?xf32>, %arg1: tensor<2x?x?xf32>) -> (index, index, index) {
    %c2 = arith.constant 2 : index
    %c16 = arith.constant 16 : index
    %dim = tensor.dim %arg0, %c2 : tensor<?x16x?xf32>
    return %c2, %c16, %dim : index, index, index
  }
}

