module {
  func.func private @callee(memref<64xf32, strided<[?], offset: ?>>)
  func.func @caller(%arg0: memref<64xf32, strided<[?], offset: ?>>) {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<64xf32>
    memref.copy %arg0, %alloc : memref<64xf32, strided<[?], offset: ?>> to memref<64xf32>
    %cast = memref.cast %alloc : memref<64xf32> to memref<64xf32, strided<[?], offset: ?>>
    call @callee(%cast) : (memref<64xf32, strided<[?], offset: ?>>) -> ()
    return
  }
}

