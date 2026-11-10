module {
  func.func @no_conflict(%arg0: f32, %arg1: f32, %arg2: index) -> tensor<3xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    memref.store %arg0, %alloc[%c0] : memref<3xf32>
    memref.store %arg0, %alloc[%c1] : memref<3xf32>
    memref.store %arg0, %alloc[%c2] : memref<3xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<3xf32>
    memref.copy %alloc, %alloc_0 : memref<3xf32> to memref<3xf32>
    memref.store %arg1, %alloc_0[%arg2] : memref<3xf32>
    %0 = bufferization.to_tensor %alloc_0 : memref<3xf32> to tensor<3xf32>
    return %0 : tensor<3xf32>
  }
}

// -----
module {
  func.func @use_tensor_func_arg(%arg0: tensor<?xf32>) -> vector<4xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %1 = vector.transfer_read %0[%c0], %cst : memref<?xf32, strided<[?], offset: ?>>, vector<4xf32>
    return %1 : vector<4xf32>
  }
}

// -----
module {
  func.func @return_tensor(%arg0: tensor<?xf32>, %arg1: vector<4xf32>) -> tensor<?xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %dim = memref.dim %0, %c0_0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    vector.transfer_write %arg1, %alloc[%c0] : vector<4xf32>, memref<?xf32>
    %1 = bufferization.to_tensor %alloc : memref<?xf32> to tensor<?xf32>
    return %1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @func_without_tensor_args(%arg0: vector<10xf32>) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    vector.transfer_write %arg0, %alloc[%c0] : vector<10xf32>, memref<10xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %alloc[%c0], %cst : memref<10xf32>, vector<11xf32>
    vector.print %0 : vector<11xf32>
    return
  }
}

// -----
module {
  func.func private @private_func(tensor<?xf32>)
  func.func @empty_func() {
    return
  }
}

// -----
module {
  func.func @read_after_write_conflict(%arg0: f32, %arg1: index, %arg2: index) -> (f32, f32) {
    %0 = "test.dummy_op"() : () -> tensor<10xf32>
    %1 = bufferization.to_buffer %0 : tensor<10xf32> to memref<10xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    memref.copy %1, %alloc : memref<10xf32, strided<[?], offset: ?>> to memref<10xf32>
    memref.store %arg0, %alloc[%arg2] : memref<10xf32>
    %2 = "test.some_use"(%0) : (tensor<10xf32>) -> f32
    %3 = memref.load %alloc[%arg1] : memref<10xf32>
    return %2, %3 : f32, f32
  }
}

// -----
module {
  func.func @copy_deallocated() -> tensor<10xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    %0 = bufferization.to_tensor %alloc : memref<10xf32> to tensor<10xf32>
    return %0 : tensor<10xf32>
  }
}

// -----
module {
  func.func @select_different_tensors(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: i1) -> f32 {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%arg1) {alignment = 64 : i64} : memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %1 = arith.select %arg3, %cast, %0 : memref<?xf32, strided<[?], offset: ?>>
    %2 = memref.load %1[%arg2] : memref<?xf32, strided<[?], offset: ?>>
    return %2 : f32
  }
}

// -----
module {
  func.func @alloc_tensor_with_copy(%arg0: tensor<5xf32>) -> tensor<5xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %0, %alloc : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32>
    %1 = bufferization.to_tensor %alloc : memref<5xf32> to tensor<5xf32>
    return %1 : tensor<5xf32>
  }
}

// -----
module {
  func.func @alloc_tensor_with_memory_space() -> tensor<5xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32, 1>
    %0 = bufferization.to_tensor %alloc : memref<5xf32, 1> to tensor<5xf32>
    return %0 : tensor<5xf32>
  }
}

// -----
module {
  func.func @read_of_alias(%arg0: tensor<100xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: f32) -> (f32, f32) {
    %0 = bufferization.to_buffer %arg0 : tensor<100xf32> to memref<100xf32, strided<[?], offset: ?>>
    %1 = bufferization.to_buffer %arg0 : tensor<100xf32> to memref<100xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<100xf32>
    memref.copy %1, %alloc : memref<100xf32, strided<[?], offset: ?>> to memref<100xf32>
    memref.store %arg6, %alloc[%arg1] : memref<100xf32>
    %subview = memref.subview %0[%arg2] [%arg5] [1] : memref<100xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
    %2 = memref.load %subview[%arg3] : memref<?xf32, strided<[?], offset: ?>>
    %3 = memref.load %alloc[%arg3] : memref<100xf32>
    return %2, %3 : f32, f32
  }
}

// -----
module {
  func.func @from_unranked_to_unranked(%arg0: tensor<*xi32>) -> tensor<*xi32> {
    %0 = bufferization.to_buffer %arg0 : tensor<*xi32> to memref<*xi32>
    %1 = bufferization.to_tensor %0 : memref<*xi32> to tensor<*xi32>
    return %1 : tensor<*xi32>
  }
}

// -----
module {
  func.func @tensor_copy(%arg0: tensor<5xf32>) -> tensor<5xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %0, %alloc : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32>
    %1 = bufferization.to_tensor %alloc : memref<5xf32> to tensor<5xf32>
    return %1 : tensor<5xf32>
  }
}

// -----
module {
  func.func @materialize_in_destination_buffer(%arg0: tensor<5xf32>, %arg1: memref<5xf32>) {
    %0 = bufferization.to_buffer %arg0 : tensor<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    memref.copy %0, %arg1 : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32>
    return
  }
}

// -----
module {
  func.func @materialize_in_func_bbarg(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>) -> tensor<?xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %1 = bufferization.to_buffer %arg1 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %1, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %2 = bufferization.to_tensor %alloc : memref<?xf32> to tensor<?xf32>
    return %2 : tensor<?xf32>
  }
}

// -----
module {
  func.func @materialize_in_dest_raw(%arg0: f32, %arg1: f32, %arg2: index) -> (tensor<5xf32>, f32) {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    linalg.fill ins(%arg0 : f32) outs(%alloc : memref<5xf32>)
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    linalg.fill ins(%arg1 : f32) outs(%alloc_0 : memref<5xf32>)
    %alloc_1 = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %alloc_0, %alloc_1 : memref<5xf32> to memref<5xf32>
    %0 = bufferization.to_tensor %alloc_1 : memref<5xf32> to tensor<5xf32>
    %1 = memref.load %alloc[%arg2] : memref<5xf32>
    return %0, %1 : tensor<5xf32>, f32
  }
}

