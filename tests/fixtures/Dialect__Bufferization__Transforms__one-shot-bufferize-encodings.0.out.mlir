module {
  func.func @alloc_tesor_with_space_no_encoding() -> tensor<128xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 1>
    %0 = bufferization.to_tensor %alloc : memref<128xf32, 1> to tensor<128xf32>
    return %0 : tensor<128xf32>
  }
}

// -----
module {
  func.func @alloc_tesor_with_space_and_cast() -> tensor<128xf32, 1 : i64> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 1>
    %0 = bufferization.to_tensor %alloc : memref<128xf32, 1> to tensor<128xf32, 1 : i64>
    return %0 : tensor<128xf32, 1 : i64>
  }
}

// -----
module {
  func.func @alloc_tesor_with_space_with_encoding() -> tensor<128xf32, 1 : i64> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 1>
    %0 = bufferization.to_tensor %alloc : memref<128xf32, 1> to tensor<128xf32, 1 : i64>
    return %0 : tensor<128xf32, 1 : i64>
  }
}

// -----
module {
  func.func @alloc_tesor_copy_from_default_space(%arg0: tensor<128xf32>) -> tensor<128xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<128xf32> to memref<128xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 1>
    memref.copy %0, %alloc : memref<128xf32, strided<[?], offset: ?>> to memref<128xf32, 1>
    %1 = bufferization.to_tensor %alloc : memref<128xf32, 1> to tensor<128xf32>
    return %1 : tensor<128xf32>
  }
}

// -----
module {
  func.func @alloc_tesor_copy_from_non_default_space(%arg0: tensor<128xf32, 1 : i64>) -> tensor<128xf32, 2 : i64> {
    %0 = bufferization.to_buffer %arg0 : tensor<128xf32, 1 : i64> to memref<128xf32, strided<[?], offset: ?>, 1>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 2>
    memref.copy %0, %alloc : memref<128xf32, strided<[?], offset: ?>, 1> to memref<128xf32, 2>
    %1 = bufferization.to_tensor %alloc : memref<128xf32, 2> to tensor<128xf32, 2 : i64>
    return %1 : tensor<128xf32, 2 : i64>
  }
}

// -----
module {
  func.func @alloc_tesor_copy_from_non_default_space_no_cast(%arg0: tensor<128xf32, 1 : i64>, %arg1: tensor<4xf32, 1 : i64>) -> tensor<128xf32, 1 : i64> {
    %0 = bufferization.to_buffer %arg1 : tensor<4xf32, 1 : i64> to memref<4xf32, strided<[?], offset: ?>, 1>
    %1 = bufferization.to_buffer %arg0 : tensor<128xf32, 1 : i64> to memref<128xf32, strided<[?], offset: ?>, 1>
    %2 = bufferization.to_buffer %arg0 : tensor<128xf32, 1 : i64> to memref<128xf32, strided<[?], offset: ?>, 1>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 2>
    memref.copy %2, %alloc : memref<128xf32, strided<[?], offset: ?>, 1> to memref<128xf32, 2>
    %3 = bufferization.to_tensor %alloc : memref<128xf32, 2> to tensor<128xf32, 1 : i64>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 1>
    memref.copy %1, %alloc_0 : memref<128xf32, strided<[?], offset: ?>, 1> to memref<128xf32, 1>
    %subview = memref.subview %alloc_0[0] [4] [1] : memref<128xf32, 1> to memref<4xf32, strided<[1]>, 1>
    memref.copy %0, %subview : memref<4xf32, strided<[?], offset: ?>, 1> to memref<4xf32, strided<[1]>, 1>
    return %3 : tensor<128xf32, 1 : i64>
  }
}

// -----
module {
  func.func @materialize_in_destination(%arg0: tensor<128xf32, 1 : i64>) -> tensor<128xf32, 2 : i64> {
    %0 = bufferization.to_buffer %arg0 : tensor<128xf32, 1 : i64> to memref<128xf32, strided<[?], offset: ?>, 1>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 2>
    memref.copy %0, %alloc : memref<128xf32, strided<[?], offset: ?>, 1> to memref<128xf32, 2>
    %1 = bufferization.to_tensor %alloc : memref<128xf32, 2> to tensor<128xf32, 2 : i64>
    return %1 : tensor<128xf32, 2 : i64>
  }
}

