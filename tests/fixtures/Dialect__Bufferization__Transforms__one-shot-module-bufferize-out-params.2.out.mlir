module {
  func.func private @callee(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 8.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %arg0, %alloc : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32>
    memref.store %cst, %alloc[%c0] : memref<5xf32>
    %cast = memref.cast %alloc : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    return %alloc : memref<5xf32>
  }
  func.func @main(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %0 = call @callee(%arg0) : (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32>
    %1 = memref.load %arg0[%c0] : memref<5xf32, strided<[?], offset: ?>>
    %2 = memref.load %0[%c0] : memref<5xf32>
    return %1, %2 : f32, f32
  }
}

// -----
module {
  func.func private @callee(%arg0: index) -> memref<2x5xf32, strided<[20, 1], offset: ?>> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x20xf32>
    %subview = memref.subview %alloc[%arg0, %arg0] [2, 5] [1, 1] : memref<10x20xf32> to memref<2x5xf32, strided<[20, 1], offset: ?>>
    %cast = memref.cast %subview : memref<2x5xf32, strided<[20, 1], offset: ?>> to memref<2x5xf32, strided<[?, ?], offset: ?>>
    return %subview : memref<2x5xf32, strided<[20, 1], offset: ?>>
  }
  func.func @main(%arg0: index) -> f32 {
    %c0 = arith.constant 0 : index
    %0 = call @callee(%arg0) : (index) -> memref<2x5xf32, strided<[20, 1], offset: ?>>
    %1 = memref.load %0[%c0, %c0] : memref<2x5xf32, strided<[20, 1], offset: ?>>
    return %1 : f32
  }
}

