module {
  func.func @br(%arg0: memref<5xf32, strided<[?], offset: ?>>) {
    %0 = scf.execute_region -> memref<5xf32, strided<[?], offset: ?>> {
      cf.br ^bb1(%arg0 : memref<5xf32, strided<[?], offset: ?>>)
    ^bb1(%1: memref<5xf32, strided<[?], offset: ?>>):  // pred: ^bb0
      scf.yield %1 : memref<5xf32, strided<[?], offset: ?>>
    }
    return
  }
}

// -----
module {
  func.func @cond_br(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: i1) {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    %0 = scf.execute_region -> memref<5xf32, strided<[?], offset: ?>> {
      cf.cond_br %arg1, ^bb1(%arg0 : memref<5xf32, strided<[?], offset: ?>>), ^bb2(%alloc : memref<5xf32>)
    ^bb1(%1: memref<5xf32, strided<[?], offset: ?>>):  // 2 preds: ^bb0, ^bb2
      scf.yield %1 : memref<5xf32, strided<[?], offset: ?>>
    ^bb2(%2: memref<5xf32>):  // pred: ^bb0
      %cast = memref.cast %2 : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
      cf.br ^bb1(%cast : memref<5xf32, strided<[?], offset: ?>>)
    }
    return
  }
}

// -----
module {
  func.func @looping_branches() -> memref<5xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    cf.br ^bb1(%alloc : memref<5xf32>)
  ^bb1(%0: memref<5xf32>):  // 2 preds: ^bb0, ^bb1
    %1 = "test.foo"() : () -> index
    %2 = "test.bar"() : () -> f32
    memref.store %2, %0[%1] : memref<5xf32>
    %3 = "test.qux"() : () -> i1
    cf.cond_br %3, ^bb1(%0 : memref<5xf32>), ^bb2(%0 : memref<5xf32>)
  ^bb2(%4: memref<5xf32>):  // pred: ^bb1
    %cast = memref.cast %4 : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    return %4 : memref<5xf32>
  }
}

