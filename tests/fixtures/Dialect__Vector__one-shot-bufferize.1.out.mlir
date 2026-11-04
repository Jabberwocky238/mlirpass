module {
  func.func @mask(%arg0: tensor<?xf32> {bufferization.access = "read-write"}, %arg1: vector<16xf32>, %arg2: index, %arg3: vector<16xi1>) -> tensor<?xf32> {
    %0 = vector.mask %arg3 { vector.transfer_write %arg1, %arg0[%arg2] {__inplace_operands_attr__ = ["none", "true", "none"]} : vector<16xf32>, tensor<?xf32> } : vector<16xi1> -> tensor<?xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
  func.func @mask_scalable(%arg0: tensor<?xf32> {bufferization.access = "read-write"}, %arg1: vector<[16]xf32>, %arg2: index, %arg3: vector<[16]xi1>) -> tensor<?xf32> {
    %0 = vector.mask %arg3 { vector.transfer_write %arg1, %arg0[%arg2] {__inplace_operands_attr__ = ["none", "true", "none"]} : vector<[16]xf32>, tensor<?xf32> } : vector<[16]xi1> -> tensor<?xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
}

// -----
module {
  func.func @non_reading_xfer_write(%arg0: tensor<5x10xf32> {bufferization.access = "write"}, %arg1: vector<6x11xf32>) -> tensor<5x10xf32> {
    %c0 = arith.constant 0 : index
    %0 = vector.transfer_write %arg1, %arg0[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"]} : vector<6x11xf32>, tensor<5x10xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<5x10xf32>
  }
}

// -----
module {
  func.func @reading_xfer_write(%arg0: tensor<5x10xf32> {bufferization.access = "read-write"}, %arg1: vector<4x11xf32>) -> tensor<5x10xf32> {
    %c0 = arith.constant 0 : index
    %0 = vector.transfer_write %arg1, %arg0[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"]} : vector<4x11xf32>, tensor<5x10xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<5x10xf32>
  }
}

