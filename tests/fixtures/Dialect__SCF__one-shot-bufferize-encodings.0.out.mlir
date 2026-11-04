module {
  func.func @scf_for_iter_arg(%arg0: tensor<128xf32, 1 : i64>, %arg1: index, %arg2: index, %arg3: index) -> tensor<128xf32, 1 : i64> {
    %0 = bufferization.to_buffer %arg0 : tensor<128xf32, 1 : i64> to memref<128xf32, strided<[?], offset: ?>, 1>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32, 1>
    memref.copy %0, %alloc : memref<128xf32, strided<[?], offset: ?>, 1> to memref<128xf32, 1>
    %cast = memref.cast %alloc : memref<128xf32, 1> to memref<128xf32, strided<[?], offset: ?>, 1>
    %1 = scf.for %arg4 = %arg1 to %arg2 step %arg3 iter_args(%arg5 = %cast) -> (memref<128xf32, strided<[?], offset: ?>, 1>) {
      %3 = bufferization.to_tensor %arg5 : memref<128xf32, strided<[?], offset: ?>, 1> to tensor<128xf32, 1 : i64>
      %4 = "some.use"(%3) : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
      %5 = bufferization.to_buffer %4 : tensor<128xf32, 1 : i64> to memref<128xf32, strided<[?], offset: ?>, 1>
      scf.yield %5 : memref<128xf32, strided<[?], offset: ?>, 1>
    }
    %2 = bufferization.to_tensor %1 : memref<128xf32, strided<[?], offset: ?>, 1> to tensor<128xf32, 1 : i64>
    return %2 : tensor<128xf32, 1 : i64>
  }
}

// -----
module {
  func.func @scf_forall(%arg0: index, %arg1: index, %arg2: tensor<?xf32, 1 : i64>, %arg3: tensor<?xf32, 1 : i64>) -> tensor<?xf32, 1 : i64> {
    %0 = bufferization.to_buffer %arg3 : tensor<?xf32, 1 : i64> to memref<?xf32, strided<[?], offset: ?>, 1>
    %cst = arith.constant 4.200000e+01 : f32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c0_0 = arith.constant 0 : index
    %dim = memref.dim %0, %c0_0 : memref<?xf32, strided<[?], offset: ?>, 1>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32, 1>
    memref.copy %0, %alloc : memref<?xf32, strided<[?], offset: ?>, 1> to memref<?xf32, 1>
    scf.forall (%arg4) in (%arg1) {
      %2 = bufferization.to_tensor %alloc : memref<?xf32, 1> to tensor<?xf32, 1 : i64>
      %3 = "some.use"(%2) : (tensor<?xf32, 1 : i64>) -> tensor<?xf32, 1 : i64>
      %4 = bufferization.to_buffer %3 : tensor<?xf32, 1 : i64> to memref<?xf32, strided<[?], offset: ?>, 1>
      %subview = memref.subview %alloc[5] [%arg0] [%c1] : memref<?xf32, 1> to memref<?xf32, strided<[?], offset: 5>, 1>
      memref.copy %4, %subview : memref<?xf32, strided<[?], offset: ?>, 1> to memref<?xf32, strided<[?], offset: 5>, 1>
    }
    %1 = bufferization.to_tensor %alloc : memref<?xf32, 1> to tensor<?xf32, 1 : i64>
    return %1 : tensor<?xf32, 1 : i64>
  }
}

// -----
module {
  func.func @scf_execute_region(%arg0: tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64> {
    %0 = bufferization.to_buffer %arg0 : tensor<128xf32, 1 : i64> to memref<128xf32, strided<[?], offset: ?>, 1>
    %1 = scf.execute_region -> memref<128xf32, strided<[?], offset: ?>, 1> {
      scf.yield %0 : memref<128xf32, strided<[?], offset: ?>, 1>
    }
    %2 = bufferization.to_tensor %1 : memref<128xf32, strided<[?], offset: ?>, 1> to tensor<128xf32, 1 : i64>
    %3 = "some.use"(%2) : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
    return %3 : tensor<128xf32, 1 : i64>
  }
}

