#map = affine_map<(d0) -> (d0)>
module {
  func.func @basic(%arg0: tensor<4xf32>) -> tensor<4xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<4xf32> to memref<4xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4xf32>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%0 : memref<4xf32>) outs(%alloc : memref<4xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.exp %in : f32
      linalg.yield %2 : f32
    }
    %1 = bufferization.to_tensor %alloc : memref<4xf32> to tensor<4xf32>
    return %1 : tensor<4xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @empty_tensor(%arg0: tensor<?xf32>, %arg1: index) -> tensor<?xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32>
    %alloc = memref.alloc(%arg1) {alignment = 64 : i64} : memref<?xf32>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%0 : memref<?xf32>) outs(%alloc : memref<?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.exp %in : f32
      linalg.yield %2 : f32
    }
    %1 = bufferization.to_tensor %alloc : memref<?xf32> to tensor<?xf32>
    return %1 : tensor<?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @multiple_results(%arg0: tensor<4xf32>) -> (tensor<4xf32>, tensor<4xf32>) {
    %0 = bufferization.to_buffer %arg0 : tensor<4xf32> to memref<4xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<4xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%0 : memref<4xf32>) outs(%alloc, %alloc_0 : memref<4xf32>, memref<4xf32>) {
    ^bb0(%in: f32, %out: f32, %out_1: f32):
      %3 = math.exp %in : f32
      linalg.yield %3, %3 : f32, f32
    }
    %1 = bufferization.to_tensor %alloc_0 : memref<4xf32> to tensor<4xf32>
    %2 = bufferization.to_tensor %alloc : memref<4xf32> to tensor<4xf32>
    return %2, %1 : tensor<4xf32>, tensor<4xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @dynamic_results(%arg0: tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    %alloc_1 = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%0 : memref<?x?xf32>) outs(%alloc, %alloc_1 : memref<?x?xf32>, memref<?x?xf32>) {
    ^bb0(%in: f32, %out: f32, %out_2: f32):
      %3 = math.exp %in : f32
      linalg.yield %3, %3 : f32, f32
    }
    %1 = bufferization.to_tensor %alloc_1 : memref<?x?xf32> to tensor<?x?xf32>
    %2 = bufferization.to_tensor %alloc : memref<?x?xf32> to tensor<?x?xf32>
    return %2, %1 : tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @generic_with_init_tensor(%arg0: tensor<2x3x4xvector<3x4xi4>>, %arg1: tensor<3x2xf32>) -> tensor<3x2xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<2x3x4xvector<3x4xi4>> to memref<2x3x4xvector<3x4xi4>>
    %1 = bufferization.to_buffer %arg1 : tensor<3x2xf32> to memref<3x2xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3x2xf32>
    memref.copy %1, %alloc : memref<3x2xf32> to memref<3x2xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%0 : memref<2x3x4xvector<3x4xi4>>) outs(%alloc : memref<3x2xf32>) {
    ^bb0(%in: vector<3x4xi4>, %out: f32):
      linalg.yield %out : f32
    }
    %2 = bufferization.to_tensor %alloc : memref<3x2xf32> to tensor<3x2xf32>
    return %2 : tensor<3x2xf32>
  }
}

// -----
module {
  func.func @bufferize_fill(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<?xf32>)
    %0 = bufferization.to_tensor %alloc : memref<?xf32> to tensor<?xf32>
    return %0 : tensor<?xf32>
  }
}

// -----
module {
  func.func @bufferize_dot(%arg0: tensor<4xf32>, %arg1: tensor<f32>) -> tensor<f32> {
    %0 = bufferization.to_buffer %arg0 : tensor<4xf32> to memref<4xf32>
    %1 = bufferization.to_buffer %arg1 : tensor<f32> to memref<f32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<f32>
    memref.copy %1, %alloc : memref<f32> to memref<f32>
    linalg.dot ins(%0, %0 : memref<4xf32>, memref<4xf32>) outs(%alloc : memref<f32>)
    %2 = bufferization.to_tensor %alloc : memref<f32> to tensor<f32>
    return %2 : tensor<f32>
  }
}

// -----
module {
  func.func @bufferize_softmax(%arg0: tensor<2x16x32xf32>, %arg1: tensor<2x16x32xf32>) -> tensor<2x16x32xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<2x16x32xf32> to memref<2x16x32xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2x16x32xf32>
    linalg.softmax dimension(2) ins(%0 : memref<2x16x32xf32>) outs(%alloc : memref<2x16x32xf32>)
    %1 = bufferization.to_tensor %alloc : memref<2x16x32xf32> to tensor<2x16x32xf32>
    return %1 : tensor<2x16x32xf32>
  }
}

