module {
  func.func private @callee(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: memref<5xf32, strided<[?], offset: ?>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 8.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %arg0, %alloc : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32>
    memref.store %cst, %alloc[%c0] : memref<5xf32>
    %cast = memref.cast %alloc : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    memref.copy %cast, %arg1 : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    return
  }
  func.func @main(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<5xf32>
    %cast = memref.cast %alloc : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    call @callee(%arg0, %cast) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> ()
    %0 = memref.load %arg0[%c0] : memref<5xf32, strided<[?], offset: ?>>
    %1 = memref.load %cast[%c0] : memref<5xf32, strided<[?], offset: ?>>
    return %0, %1 : f32, f32
  }
}

// -----
module {
  func.func private @callee(%arg0: index, %arg1: memref<2x5xf32, strided<[?, ?], offset: ?>>) {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x20xf32>
    %subview = memref.subview %alloc[%arg0, %arg0] [2, 5] [1, 1] : memref<10x20xf32> to memref<2x5xf32, strided<[20, 1], offset: ?>>
    %cast = memref.cast %subview : memref<2x5xf32, strided<[20, 1], offset: ?>> to memref<2x5xf32, strided<[?, ?], offset: ?>>
    memref.copy %cast, %arg1 : memref<2x5xf32, strided<[?, ?], offset: ?>> to memref<2x5xf32, strided<[?, ?], offset: ?>>
    return
  }
  func.func @main(%arg0: index) -> f32 {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<2x5xf32>
    %cast = memref.cast %alloc : memref<2x5xf32> to memref<2x5xf32, strided<[?, ?], offset: ?>>
    call @callee(%arg0, %cast) : (index, memref<2x5xf32, strided<[?, ?], offset: ?>>) -> ()
    %0 = memref.load %cast[%c0, %c0] : memref<2x5xf32, strided<[?, ?], offset: ?>>
    return %0 : f32
  }
}

