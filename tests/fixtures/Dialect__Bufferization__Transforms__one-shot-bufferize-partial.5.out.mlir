module {
  func.func @use_of_unknown_op_1(%arg0: tensor<?xf32>) -> vector<5xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = vector.transfer_read %0[%c0], %cst : tensor<?xf32>, vector<5xf32>
    return %1 : vector<5xf32>
  }
}

// -----
module {
  func.func @use_of_unknown_op_2(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "test.another_dummy_op"(%0) : (tensor<?xf32>) -> tensor<?xf32>
    return %1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @use_of_unknown_op_3(%arg0: tensor<?xf32>) -> (vector<5xf32>, vector<5xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0], %cst : tensor<?xf32>, vector<5xf32>
    %1 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %2 = vector.transfer_read %1[%c0], %cst : tensor<?xf32>, vector<5xf32>
    return %0, %2 : vector<5xf32>, vector<5xf32>
  }
}

// -----
module {
  func.func @use_of_unknown_op_4(%arg0: tensor<?xf32>) -> (vector<5xf32>, tensor<?xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = vector.transfer_read %0[%c0], %cst : tensor<?xf32>, vector<5xf32>
    %2 = "test.another_dummy_op"(%0) : (tensor<?xf32>) -> tensor<?xf32>
    return %1, %2 : vector<5xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @use_of_bufferizable_op_in_unbufferizable_op(%arg0: tensor<?xf32>, %arg1: index, %arg2: index) -> (tensor<?xf32>, tensor<?xf32>) {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %subview = memref.subview %0[%arg1] [%arg2] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%arg2) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %subview, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %1 = bufferization.to_tensor %alloc : memref<?xf32> to tensor<?xf32>
    %2 = "test.dummy_op"(%1) : (tensor<?xf32>) -> tensor<?xf32>
    return %1, %2 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @unused_unknown_op(%arg0: tensor<?xf32>) -> vector<5xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0], %cst : tensor<?xf32>, vector<5xf32>
    "test.dummy_op"(%arg0) : (tensor<?xf32>) -> ()
    return %0 : vector<5xf32>
  }
}

// -----
module {
  func.func @unknown_op_may_read(%arg0: vector<5xf32>) -> (tensor<10xf32>, tensor<10xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 5.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    %0 = bufferization.to_tensor %alloc : memref<10xf32> to tensor<10xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<10xf32>) -> tensor<10xf32>
    %2 = vector.transfer_write %arg0, %1[%c0] {in_bounds = [true]} : vector<5xf32>, tensor<10xf32>
    %3 = "test.dummy_op"(%1) : (tensor<10xf32>) -> tensor<10xf32>
    return %2, %3 : tensor<10xf32>, tensor<10xf32>
  }
}

// -----
module {
  func.func @unknown_op_not_writable(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index) -> tensor<?xf32> {
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = vector.transfer_write %arg1, %0[%arg2] : vector<5xf32>, tensor<?xf32>
    return %1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @simple_tensor_test(%arg0: tensor<?xf32>, %arg1: f32) -> tensor<?xf32> {
    %c0 = arith.constant 0 : index
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    memref.store %arg1, %alloc[%c0] : memref<?xf32>
    %1 = bufferization.to_tensor %alloc : memref<?xf32> to tensor<?xf32>
    return %1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @simple_scf_if(%arg0: tensor<?xf32> {bufferization.writable = true}, %arg1: i1, %arg2: index, %arg3: f32) -> (tensor<?xf32>, index) {
    %c0 = arith.constant 0 : index
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %1 = scf.if %arg1 -> (tensor<?xf32>) {
      scf.yield %arg0 : tensor<?xf32>
    } else {
      %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
      %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
      memref.copy %0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
      memref.store %arg3, %alloc[%arg2] : memref<?xf32>
      %2 = bufferization.to_tensor %alloc : memref<?xf32> to tensor<?xf32>
      scf.yield %2 : tensor<?xf32>
    }
    return %1, %arg2 : tensor<?xf32>, index
  }
}

