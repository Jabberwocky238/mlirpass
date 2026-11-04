module {
  func.func @index_cast(%arg0: tensor<i32>, %arg1: i32) -> (tensor<index>, index) {
    %0 = bufferization.to_buffer %arg0 : tensor<i32> to memref<i32>
    %1 = arith.index_cast %0 : memref<i32> to memref<index>
    %2 = bufferization.to_tensor %1 : memref<index> to tensor<index>
    %3 = arith.index_cast %arg1 : i32 to index
    return %2, %3 : tensor<index>, index
  }
}

// -----
module {
  memref.global "private" constant @__constant_3x4xf32 : memref<3x4xf32> = dense<7.000000e+00> {alignment = 64 : i64}
  func.func @basic() -> tensor<3x4xf32> {
    %0 = memref.get_global @__constant_3x4xf32 : memref<3x4xf32>
    %1 = bufferization.to_tensor %0 : memref<3x4xf32> to tensor<3x4xf32>
    return %1 : tensor<3x4xf32>
  }
}

// -----
module {
  memref.global "private" constant @__constant_3x4xf32 : memref<3x4xf32> = dense<7.000000e+00> {alignment = 64 : i64}
  func.func @duplicate_constants() -> (tensor<3x4xf32>, tensor<3x4xf32>) {
    %0 = memref.get_global @__constant_3x4xf32 : memref<3x4xf32>
    %1 = bufferization.to_tensor %0 : memref<3x4xf32> to tensor<3x4xf32>
    %2 = memref.get_global @__constant_3x4xf32 : memref<3x4xf32>
    %3 = bufferization.to_tensor %2 : memref<3x4xf32> to tensor<3x4xf32>
    return %1, %3 : tensor<3x4xf32>, tensor<3x4xf32>
  }
}

// -----
module {
  memref.global "private" constant @__constant_3x4xf32_0 : memref<3x4xf32> = dense<8.000000e+00> {alignment = 64 : i64}
  memref.global "private" constant @__constant_3x4xf32 : memref<3x4xf32> = dense<7.000000e+00> {alignment = 64 : i64}
  func.func @multiple_constants() -> (tensor<3x4xf32>, tensor<3x4xf32>) {
    %0 = memref.get_global @__constant_3x4xf32 : memref<3x4xf32>
    %1 = bufferization.to_tensor %0 : memref<3x4xf32> to tensor<3x4xf32>
    %2 = memref.get_global @__constant_3x4xf32_0 : memref<3x4xf32>
    %3 = bufferization.to_tensor %2 : memref<3x4xf32> to tensor<3x4xf32>
    return %1, %3 : tensor<3x4xf32>, tensor<3x4xf32>
  }
}

// -----
module {
  func.func @non_tensor() {
    %c7_i32 = arith.constant 7 : i32
    return
  }
}

// -----
module {
  func.func @select(%arg0: i1, %arg1: tensor<f32>, %arg2: tensor<f32>) -> tensor<f32> {
    %0 = bufferization.to_buffer %arg2 : tensor<f32> to memref<f32>
    %1 = bufferization.to_buffer %arg1 : tensor<f32> to memref<f32>
    %2 = arith.select %arg0, %1, %0 : memref<f32>
    %3 = bufferization.to_tensor %2 : memref<f32> to tensor<f32>
    return %3 : tensor<f32>
  }
}

// -----
