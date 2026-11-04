module {
}

// -----
module {
  func.func @fill_extract_matmul_1234(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %2[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_1243(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %2[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %extracted_slice : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_1324(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice_1 = tensor.extract_slice %2[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_1342(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice_1 : tensor<16x256xf32>) -> tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_1423(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_1432(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_2134(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %2[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_2143(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %2[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %extracted_slice : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_2314(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_2341(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_2413(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice_1 = tensor.extract_slice %2[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %extracted_slice : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_2431(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice_1 : tensor<256x16xf32>) -> tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %extracted_slice : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_3124(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice_1 = tensor.extract_slice %2[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%1, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_3142(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice_1 : tensor<16x256xf32>) -> tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%1, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_3214(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_3241(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_3412(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice_1 : tensor<16x256xf32>) -> tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%1, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_3421(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice_1 : tensor<16x256xf32>) -> tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<256x16xf32>) -> tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_4123(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_4132(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_4213(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice_1 = tensor.extract_slice %2[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%extracted_slice_1, %1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_4231(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice_1 : tensor<256x16xf32>) -> tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_4312(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice_1 : tensor<256x16xf32>) -> tensor<256x16xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%1, %2 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @fill_extract_matmul_4321(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<256x256xf32> to tensor<16x256xf32>
    %extracted_slice_1 = tensor.extract_slice %0[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"]} : tensor<256x256xf32> to tensor<256x16xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_0 : f32) outs(%extracted_slice : tensor<16x256xf32>) -> tensor<16x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice_1 : tensor<256x16xf32>) -> tensor<256x16xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%2, %1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

