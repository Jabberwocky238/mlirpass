module {
  func.func @br(%arg0: tensor<5xf32>) {
    %0 = bufferization.to_buffer %arg0 : tensor<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    %1 = scf.execute_region -> memref<5xf32, strided<[?], offset: ?>> {
      cf.br ^bb1(%0 : memref<5xf32, strided<[?], offset: ?>>)
    ^bb1(%2: memref<5xf32, strided<[?], offset: ?>>):  // pred: ^bb0
      scf.yield %2 : memref<5xf32, strided<[?], offset: ?>>
    }
    return
  }
}

// -----
module {
  func.func @cond_br(%arg0: tensor<5xf32>, %arg1: i1) {
    %0 = bufferization.to_buffer %arg0 : tensor<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    %1 = scf.execute_region -> memref<5xf32, strided<[?], offset: ?>> {
      cf.cond_br %arg1, ^bb1(%0 : memref<5xf32, strided<[?], offset: ?>>), ^bb2(%alloc : memref<5xf32>)
    ^bb1(%2: memref<5xf32, strided<[?], offset: ?>>):  // 2 preds: ^bb0, ^bb2
      scf.yield %2 : memref<5xf32, strided<[?], offset: ?>>
    ^bb2(%3: memref<5xf32>):  // pred: ^bb0
      %cast = memref.cast %3 : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
      cf.br ^bb1(%cast : memref<5xf32, strided<[?], offset: ?>>)
    }
    return
  }
}

// -----
module {
  func.func @looping_branches() -> tensor<5xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    %0 = bufferization.to_tensor %alloc : memref<5xf32> to tensor<5xf32>
    cf.br ^bb1(%0 : tensor<5xf32>)
  ^bb1(%1: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %2 = bufferization.to_buffer %1 : tensor<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    %3 = "test.foo"() : () -> index
    %4 = "test.bar"() : () -> f32
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %2, %alloc_0 : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32>
    memref.store %4, %alloc_0[%3] : memref<5xf32>
    %5 = bufferization.to_tensor %alloc_0 : memref<5xf32> to tensor<5xf32>
    %6 = "test.qux"() : () -> i1
    cf.cond_br %6, ^bb1(%5 : tensor<5xf32>), ^bb2(%5 : tensor<5xf32>)
  ^bb2(%7: tensor<5xf32>):  // pred: ^bb1
    return %7 : tensor<5xf32>
  }
}

