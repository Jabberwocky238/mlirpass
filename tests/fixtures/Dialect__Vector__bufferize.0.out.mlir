module {
  func.func @transfer_read(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: f32) -> vector<5x6xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %1 = vector.transfer_read %0[%arg1, %arg2], %arg3 {in_bounds = [true, false]} : memref<?x?xf32>, vector<5x6xf32>
    return %1 : vector<5x6xf32>
  }
}

// -----
module {
  func.func @transfer_write(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: vector<5x6xf32>, %arg4: vector<5x6xi1>) -> tensor<?x?xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %0, %c0 : memref<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %0, %c1 : memref<?x?xf32>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    memref.copy %0, %alloc : memref<?x?xf32> to memref<?x?xf32>
    vector.transfer_write %arg3, %alloc[%arg1, %arg2], %arg4 {in_bounds = [true, false]} : vector<5x6xf32>, memref<?x?xf32>
    %1 = bufferization.to_tensor %alloc : memref<?x?xf32> to tensor<?x?xf32>
    return %1 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @scatter(%arg0: tensor<16x16xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>) -> tensor<16x16xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<16x16xf32> to memref<16x16xf32>
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<16x16xf32>
    memref.copy %0, %alloc : memref<16x16xf32> to memref<16x16xf32>
    vector.scatter %alloc[%c0, %c0] [%arg1], %arg2, %arg3 : memref<16x16xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32>
    %1 = bufferization.to_tensor %alloc : memref<16x16xf32> to tensor<16x16xf32>
    return %1 : tensor<16x16xf32>
  }
}

// -----
module {
  func.func @gather(%arg0: tensor<?x?xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>) -> vector<16xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %c0 = arith.constant 0 : index
    %1 = vector.gather %0[%c0, %c0] [%arg1], %arg2, %arg3 : memref<?x?xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32> into vector<16xf32>
    return %1 : vector<16xf32>
  }
}

