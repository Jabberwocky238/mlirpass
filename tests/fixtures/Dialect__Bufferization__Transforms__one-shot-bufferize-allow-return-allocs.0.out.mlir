module {
  func.func @buffer_not_deallocated(%arg0: tensor<?xf32>, %arg1: i1) -> tensor<?xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %1 = scf.if %arg1 -> (memref<?xf32, strided<[?], offset: ?>>) {
      %3 = "test.some_op"() : () -> index
      %alloc = memref.alloc(%3) {alignment = 64 : i64} : memref<?xf32>
      %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
      scf.yield %cast : memref<?xf32, strided<[?], offset: ?>>
    } else {
      scf.yield %0 : memref<?xf32, strided<[?], offset: ?>>
    }
    %2 = bufferization.to_tensor %1 : memref<?xf32, strided<[?], offset: ?>> to tensor<?xf32>
    return %2 : tensor<?xf32>
  }
}

// -----
module {
  func.func @write_to_alloc_tensor_or_readonly_tensor(%arg0: tensor<i32>, %arg1: i1, %arg2: i32) -> tensor<i32> {
    %0 = bufferization.to_buffer %arg0 : tensor<i32> to memref<i32, strided<[], offset: ?>>
    %1 = scf.if %arg1 -> (memref<i32, strided<[], offset: ?>>) {
      scf.yield %0 : memref<i32, strided<[], offset: ?>>
    } else {
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<i32>
      memref.store %arg2, %alloc[] : memref<i32>
      %cast = memref.cast %alloc : memref<i32> to memref<i32, strided<[], offset: ?>>
      scf.yield %cast : memref<i32, strided<[], offset: ?>>
    }
    %2 = bufferization.to_tensor %1 : memref<i32, strided<[], offset: ?>> to tensor<i32>
    return %2 : tensor<i32>
  }
}

