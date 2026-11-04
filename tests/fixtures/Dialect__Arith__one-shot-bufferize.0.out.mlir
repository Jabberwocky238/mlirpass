module {
  func.func @write_to_select_op_source(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: i1) -> (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0_0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    memref.store %cst, %alloc[%c0] : memref<?xf32>
    %0 = arith.select %arg2, %arg0, %arg1 : memref<?xf32, strided<[?], offset: ?>>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    return %0, %alloc : memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>
  }
}

// -----
module {
  func.func @write_after_select_read_one(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: i1) -> (f32, memref<?xf32, strided<[?], offset: ?>>) {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0_0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %0 = arith.select %arg2, %cast, %arg1 : memref<?xf32, strided<[?], offset: ?>>
    memref.store %cst, %0[%c0] : memref<?xf32, strided<[?], offset: ?>>
    %1 = memref.load %arg0[%c0] : memref<?xf32, strided<[?], offset: ?>>
    return %1, %0 : f32, memref<?xf32, strided<[?], offset: ?>>
  }
}

