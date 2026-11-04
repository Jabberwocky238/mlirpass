module {
  func.func @foo(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0_0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    memref.store %cst, %alloc[%c0] : memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    return %alloc : memref<?xf32>
  }
  func.func @contains_to_buffer_op(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index) -> vector<5xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %alloc[%arg1], %cst : memref<?xf32>, vector<5xf32>
    return %0 : vector<5xf32>
  }
}

