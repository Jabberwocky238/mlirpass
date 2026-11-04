module {
  func.func private @callee(%arg0: memref<5xf32>, %arg1: memref<5xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 8.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %arg0, %alloc : memref<5xf32> to memref<5xf32>
    memref.store %cst, %alloc[%c0] : memref<5xf32>
    memref.copy %alloc, %arg1 : memref<5xf32> to memref<5xf32>
    return
  }
  func.func @main(%arg0: memref<5xf32>) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<5xf32>
    call @callee(%arg0, %alloc) : (memref<5xf32>, memref<5xf32>) -> ()
    %0 = memref.load %arg0[%c0] : memref<5xf32>
    %1 = memref.load %alloc[%c0] : memref<5xf32>
    return %0, %1 : f32, f32
  }
}

// -----
module {
  func.func private @callee(%arg0: index, %arg1: memref<2x5xf32>) {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x20xf32>
    %subview = memref.subview %alloc[%arg0, %arg0] [2, 5] [1, 1] : memref<10x20xf32> to memref<2x5xf32, strided<[20, 1], offset: ?>>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<2x5xf32>
    memref.copy %subview, %alloc_0 : memref<2x5xf32, strided<[20, 1], offset: ?>> to memref<2x5xf32>
    memref.copy %alloc_0, %arg1 : memref<2x5xf32> to memref<2x5xf32>
    return
  }
  func.func @main(%arg0: index) -> f32 {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<2x5xf32>
    call @callee(%arg0, %alloc) : (index, memref<2x5xf32>) -> ()
    %0 = memref.load %alloc[%c0, %c0] : memref<2x5xf32>
    return %0 : f32
  }
}

