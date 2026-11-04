module {
  func.func @out_of_place_bufferization(%arg0: tensor<?xf32>) -> (f32, f32) {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %1 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %cst = arith.constant 0.000000e+00 : f32
    %c5 = arith.constant 5 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %1, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %1, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    memref.store %cst, %alloc[%c5] : memref<?xf32>
    %2 = memref.load %0[%c5] : memref<?xf32, strided<[?], offset: ?>>
    %3 = memref.load %alloc[%c5] : memref<?xf32>
    return %2, %3 : f32, f32
  }
}

