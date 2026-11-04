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
    %extracted_slice = tensor.extract_slice %arg0[%arg1] [%arg2] [1] : tensor<?xf32> to tensor<?xf32>
    %0 = "test.dummy_op"(%extracted_slice) : (tensor<?xf32>) -> tensor<?xf32>
    return %extracted_slice, %0 : tensor<?xf32>, tensor<?xf32>
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
    %inserted = tensor.insert %arg1 into %arg0[%c0] : tensor<?xf32>
    return %inserted : tensor<?xf32>
  }
}

// -----
module {
  func.func @simple_scf_if(%arg0: tensor<?xf32> {bufferization.writable = true}, %arg1: i1, %arg2: index, %arg3: f32) -> (tensor<?xf32>, index) {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %1 = scf.if %arg1 -> (memref<?xf32, strided<[?], offset: ?>>) {
      scf.yield %0 : memref<?xf32, strided<[?], offset: ?>>
    } else {
      %inserted = tensor.insert %arg3 into %arg0[%arg2] : tensor<?xf32>
      %3 = bufferization.to_buffer %inserted : tensor<?xf32> to memref<?xf32, strided<[?], offset: ?>>
      scf.yield %3 : memref<?xf32, strided<[?], offset: ?>>
    }
    %2 = bufferization.to_tensor %1 : memref<?xf32, strided<[?], offset: ?>> to tensor<?xf32>
    return %2, %arg2 : tensor<?xf32>, index
  }
}

