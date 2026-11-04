module {
  func.func @create_tensor() -> memref<10xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    %cast = memref.cast %alloc : memref<10xf32> to memref<10xf32, strided<[?], offset: ?>>
    return %alloc : memref<10xf32>
  }
  func.func @caller(%arg0: index) -> f32 {
    %0 = call @create_tensor() : () -> memref<10xf32>
    %1 = memref.load %0[%arg0] : memref<10xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @return_slice(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index) -> memref<?xf32, strided<[?], offset: ?>> {
    %subview = memref.subview %arg0[4] [%arg1] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
    return %subview : memref<?xf32, strided<[?], offset: ?>>
  }
  func.func @main(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index) -> (f32, f32) {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = call @return_slice(%arg0, %arg1) : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    linalg.fill ins(%cst : f32) outs(%arg0 : memref<?xf32, strided<[?], offset: ?>>)
    %1 = memref.load %alloc[%arg2] : memref<?xf32>
    %2 = memref.load %arg0[%arg2] : memref<?xf32, strided<[?], offset: ?>>
    return %1, %2 : f32, f32
  }
}

// -----
module {
  func.func private @return_arg(%arg0: memref<?xf32, strided<[?], offset: ?>>) {
    return
  }
}

