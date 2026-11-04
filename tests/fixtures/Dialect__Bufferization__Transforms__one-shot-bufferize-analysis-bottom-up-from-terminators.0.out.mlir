module {
  func.func @simple_test(%arg0: index, %arg1: index, %arg2: index, %arg3: f32, %arg4: f32) -> (tensor<5xf32>, tensor<5xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<5xf32>
    %1 = scf.for %arg5 = %arg0 to %arg1 step %arg2 iter_args(%arg6 = %0) -> (tensor<5xf32>) {
      %4 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%arg3 : f32) outs(%arg6 : tensor<5xf32>) -> tensor<5xf32>
      %5 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%arg4 : f32) outs(%arg6 : tensor<5xf32>) -> tensor<5xf32>
      %6 = vector.transfer_read %4[%c0], %cst {__inplace_operands_attr__ = ["true", "none", "none"]} : tensor<5xf32>, vector<5xf32>
      vector.print %6 : vector<5xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %5 : tensor<5xf32>
    } {__inplace_operands_attr__ = ["none", "none", "none", "false"]}
    %2 = tensor.empty() : tensor<5xf32>
    %3 = scf.for %arg5 = %arg0 to %arg1 step %arg2 iter_args(%arg6 = %0) -> (tensor<5xf32>) {
      %4 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%arg3 : f32) outs(%arg6 : tensor<5xf32>) -> tensor<5xf32>
      %5 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%arg4 : f32) outs(%arg6 : tensor<5xf32>) -> tensor<5xf32>
      %6 = vector.transfer_read %5[%c0], %cst {__inplace_operands_attr__ = ["true", "none", "none"]} : tensor<5xf32>, vector<5xf32>
      vector.print %6 : vector<5xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %4 : tensor<5xf32>
    } {__inplace_operands_attr__ = ["none", "none", "none", "true"]}
    return {__inplace_operands_attr__ = ["true", "true"]} %1, %3 : tensor<5xf32>, tensor<5xf32>
  }
}

