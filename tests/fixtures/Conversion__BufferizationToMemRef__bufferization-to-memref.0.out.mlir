module {
  func.func @conversion_static(%arg0: memref<2xf32>) -> memref<2xf32> {
    %alloc = memref.alloc() : memref<2xf32>
    memref.copy %arg0, %alloc : memref<2xf32> to memref<2xf32>
    memref.dealloc %arg0 : memref<2xf32>
    return %alloc : memref<2xf32>
  }
}

// -----
module {
  func.func @conversion_dynamic(%arg0: memref<?xf32>) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %alloc = memref.alloc(%dim) : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32> to memref<?xf32>
    memref.dealloc %arg0 : memref<?xf32>
    return %alloc : memref<?xf32>
  }
}

// -----
module {
  func.func @conversion_unknown(%arg0: memref<*xf32>) -> memref<*xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = memref.rank %arg0 : memref<*xf32>
    %alloca = memref.alloca(%0) : memref<?xindex>
    %1 = scf.for %arg1 = %c0 to %0 step %c1 iter_args(%arg2 = %c1) -> (index) {
      %dim = memref.dim %arg0, %arg1 : memref<*xf32>
      memref.store %dim, %alloca[%arg1] : memref<?xindex>
      %2 = arith.muli %arg2, %dim : index
      scf.yield %2 : index
    }
    %alloc = memref.alloc(%1) : memref<?xf32>
    %reshape = memref.reshape %alloc(%alloca) : (memref<?xf32>, memref<?xindex>) -> memref<*xf32>
    memref.copy %arg0, %reshape : memref<*xf32> to memref<*xf32>
    memref.dealloc %arg0 : memref<*xf32>
    return %reshape : memref<*xf32>
  }
}

// -----
module {
  func.func @conversion_with_layout_map(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) : memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    memref.copy %arg0, %cast : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
    memref.dealloc %arg0 : memref<?xf32, strided<[?], offset: ?>>
    return %cast : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
// -----
module {
  func.func @conversion_dealloc_simple(%arg0: memref<2xf32>, %arg1: i1) {
    scf.if %arg1 {
      memref.dealloc %arg0 : memref<2xf32>
    }
    return
  }
}

