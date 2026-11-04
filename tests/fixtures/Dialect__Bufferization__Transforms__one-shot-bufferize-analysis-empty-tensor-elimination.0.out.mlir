module {
  func.func @buffer_forwarding_conflict(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index) -> (tensor<?xf32>, tensor<?xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0] [%arg1] [1] {__inplace_operands_attr__ = ["false", "none"]} : tensor<?xf32> to tensor<?xf32>
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg0[0] [%arg1] [1] {__inplace_operands_attr__ = ["true", "false", "none"]} : tensor<?xf32> into tensor<?xf32>
    %inserted_slice_0 = tensor.insert_slice %0 into %arg0[42] [%arg1] [1] {__inplace_operands_attr__ = ["true", "true", "none"]} : tensor<?xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [-1, 0], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice, %inserted_slice_0 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @buffer_forwarding_no_conflict(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index) -> (tensor<?xf32>, tensor<?xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[42] [%arg1] [1] {__inplace_operands_attr__ = ["true", "none"]} : tensor<?xf32> to tensor<?xf32>
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg0[42] [%arg1] [1] {__inplace_operands_attr__ = ["true", "true", "none"]} : tensor<?xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [0, 0], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice, %inserted_slice : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @buffer_forwarding_conflict_with_different_element_type(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index) -> (tensor<?xf32>, tensor<?xf32>) {
    %extracted_slice = tensor.extract_slice %arg0[42] [%arg1] [1] {__inplace_operands_attr__ = ["true", "none"]} : tensor<?xf32> to tensor<?xf32>
    %0 = bufferization.alloc_tensor(%arg1) : tensor<?xf32>
    %1 = bufferization.alloc_tensor(%arg1) : tensor<?xbf16>
    %2 = linalg.copy {__inplace_operands_attr__ = ["true", "true"]} ins(%0 : tensor<?xf32>) outs(%1 : tensor<?xbf16>) -> tensor<?xbf16>
    %3 = linalg.copy {__inplace_operands_attr__ = ["true", "true"]} ins(%2 : tensor<?xbf16>) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %3 into %arg0[42] [%arg1] [1] {__inplace_operands_attr__ = ["true", "true", "none"]} : tensor<?xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [0, 0], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice, %inserted_slice : tensor<?xf32>, tensor<?xf32>
  }
}

