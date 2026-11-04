module {
}

// -----
module {
  func.func @extract_slice_fun(%arg0: tensor<?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg1: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}) -> (tensor<4xf32>, tensor<8xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%extracted_slice", "%arg0"], ["%extracted_slice_0", "%arg1"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0] [4] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%arg0"]]} : tensor<?xf32> to tensor<4xf32>
    %extracted_slice_0 = tensor.extract_slice %arg1[0] [8] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%arg1"]]} : tensor<?xf32> to tensor<8xf32>
    return {__inplace_operands_attr__ = ["true", "true"]} %extracted_slice, %extracted_slice_0 : tensor<4xf32>, tensor<8xf32>
  }
}

// -----
module {
  func.func @insert_slice_fun(%arg0: tensor<?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg1: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg2: tensor<4xf32> {bufferization.access = "read", bufferization.writable = false}) -> (tensor<?xf32>, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%inserted_slice_0", "%arg1"], ["%arg2"]]]]} {
    %inserted_slice = tensor.insert_slice %arg2 into %arg0[0] [4] [1] {__inplace_operands_attr__ = ["true", "false"], __opresult_alias_set_attr__ = [["%inserted_slice"]]} : tensor<4xf32> into tensor<?xf32>
    %inserted_slice_0 = tensor.insert_slice %arg2 into %arg1[0] [4] [1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%inserted_slice_0", "%arg1"]]} : tensor<4xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [-1, 1], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice, %inserted_slice_0 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @conflict_on_B(%arg0: tensor<4x4xf32> {bufferization.access = "read", bufferization.writable = true}, %arg1: tensor<4x4xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%2", "%arg1"]]]]} {
    %0 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "false"], __opresult_alias_set_attr__ = [["%0"]]} ins(%arg0, %arg1 : tensor<4x4xf32>, tensor<4x4xf32>) outs(%arg1 : tensor<4x4xf32>) -> tensor<4x4xf32>
    %1 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "false"], __opresult_alias_set_attr__ = [["%1"]]} ins(%arg1, %arg0 : tensor<4x4xf32>, tensor<4x4xf32>) outs(%arg1 : tensor<4x4xf32>) -> tensor<4x4xf32>
    %2 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%2", "%arg1"]]} ins(%arg0, %arg0 : tensor<4x4xf32>, tensor<4x4xf32>) outs(%arg1 : tensor<4x4xf32>) -> tensor<4x4xf32>
    return {__equivalent_func_args__ = [-1, -1, 1], __inplace_operands_attr__ = ["true", "true", "true"]} %0, %1, %2 : tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>
  }
}

// -----
module {
  func.func @extract_slice_extract_slice(%arg0: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "read", bufferization.writable = false}) -> (tensor<2xf32>, tensor<2xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%extracted_slice_0", "%extracted_slice", "%arg0"], ["%extracted_slice_2", "%extracted_slice_1", "%arg1"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0] [4] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%extracted_slice", "%arg0"]]} : tensor<?xf32> to tensor<4xf32>
    %extracted_slice_0 = tensor.extract_slice %extracted_slice[0] [2] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%extracted_slice", "%arg0"]]} : tensor<4xf32> to tensor<2xf32>
    %extracted_slice_1 = tensor.extract_slice %arg1[0] [4] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_2", "%extracted_slice_1", "%arg1"]]} : tensor<?xf32> to tensor<4xf32>
    %extracted_slice_2 = tensor.extract_slice %extracted_slice_1[0] [2] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_2", "%extracted_slice_1", "%arg1"]]} : tensor<4xf32> to tensor<2xf32>
    return {__inplace_operands_attr__ = ["true", "true"]} %extracted_slice_0, %extracted_slice_2 : tensor<2xf32>, tensor<2xf32>
  }
}

// -----
module {
  func.func @insert_slice_insert_slice(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: tensor<4xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg2: tensor<2xf32> {bufferization.access = "read", bufferization.writable = true}, %arg3: tensor<?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg4: tensor<4xf32> {bufferization.access = "read", bufferization.writable = false}, %arg5: tensor<2xf32> {bufferization.access = "read", bufferization.writable = false}) -> (tensor<?xf32>, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%inserted_slice_0", "%arg0"], ["%inserted_slice", "%arg1"], ["%arg2"], ["%arg3"], ["%arg4"], ["%arg5"]]]]} {
    %inserted_slice = tensor.insert_slice %arg2 into %arg1[0] [2] [1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%inserted_slice", "%arg1"]]} : tensor<2xf32> into tensor<4xf32>
    %inserted_slice_0 = tensor.insert_slice %inserted_slice into %arg0[0] [4] [1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%inserted_slice_0", "%arg0"]]} : tensor<4xf32> into tensor<?xf32>
    %inserted_slice_1 = tensor.insert_slice %arg5 into %arg4[0] [2] [1] {__inplace_operands_attr__ = ["true", "false"], __opresult_alias_set_attr__ = [["%inserted_slice_1"]]} : tensor<2xf32> into tensor<4xf32>
    %inserted_slice_2 = tensor.insert_slice %inserted_slice_1 into %arg3[0] [4] [1] {__inplace_operands_attr__ = ["true", "false"], __opresult_alias_set_attr__ = [["%inserted_slice_2"]]} : tensor<4xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [0, -1], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice_0, %inserted_slice_2 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @extract_slice_nonmatching_insert_slice(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg2: index) -> (tensor<?xf32>, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%inserted_slice", "%arg0"], ["%extracted_slice_0", "%arg1"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0] [4] [1] {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%extracted_slice"]]} : tensor<?xf32> to tensor<4xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg0[%arg2] [4] [1] {__inplace_operands_attr__ = ["true", "true", "none"], __opresult_alias_set_attr__ = [["%inserted_slice", "%arg0"]]} : tensor<4xf32> into tensor<?xf32>
    %extracted_slice_0 = tensor.extract_slice %arg1[0] [4] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%arg1"]]} : tensor<?xf32> to tensor<4xf32>
    %inserted_slice_1 = tensor.insert_slice %extracted_slice_0 into %arg1[%arg2] [4] [1] {__inplace_operands_attr__ = ["true", "false", "none"], __opresult_alias_set_attr__ = [["%inserted_slice_1"]]} : tensor<4xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [0, -1], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice, %inserted_slice_1 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @extract_slice_matching_insert_slice(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "read", bufferization.writable = false}) -> (tensor<?xf32>, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%extracted_slice", "%inserted_slice", "%arg0"], ["%extracted_slice_0", "%arg1"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0] [4] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice", "%arg0"]]} : tensor<?xf32> to tensor<4xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg0[0] [4] [1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice", "%arg0"]]} : tensor<4xf32> into tensor<?xf32>
    %extracted_slice_0 = tensor.extract_slice %arg1[0] [4] [1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%arg1"]]} : tensor<?xf32> to tensor<4xf32>
    %inserted_slice_1 = tensor.insert_slice %extracted_slice_0 into %arg1[0] [4] [1] {__inplace_operands_attr__ = ["true", "false"], __opresult_alias_set_attr__ = [["%inserted_slice_1"]]} : tensor<4xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [0, -1], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice, %inserted_slice_1 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @read_of_matching_insert_slice_source(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index, %arg2: index) -> (tensor<?xf32>, vector<5xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%0", "%extracted_slice", "%inserted_slice", "%arg0"]]]]} {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[%arg1] [%arg1] [1] {__inplace_operands_attr__ = ["true", "none", "none"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice", "%inserted_slice", "%arg0"]]} : tensor<?xf32> to tensor<?xf32>
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice", "%inserted_slice", "%arg0"]]} ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg0[%arg1] [%arg1] [1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice", "%inserted_slice", "%arg0"]]} : tensor<?xf32> into tensor<?xf32>
    %1 = vector.transfer_read %0[%arg2], %cst_0 {__inplace_operands_attr__ = ["true", "none", "none"]} : tensor<?xf32>, vector<5xf32>
    return {__equivalent_func_args__ = [0, -1], __inplace_operands_attr__ = ["true", "none"]} %inserted_slice, %1 : tensor<?xf32>, vector<5xf32>
  }
}

// -----
module {
  func.func @read_of_matching_insert_slice_source_interleaved(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index, %arg2: index, %arg3: index) -> (tensor<?xf32>, vector<5xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%1", "%extracted_slice_1", "%inserted_slice_2", "%inserted_slice", "%arg0"]]]]} {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[%arg1] [%arg1] [1] {__inplace_operands_attr__ = ["false", "none", "none"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice"]]} : tensor<?xf32> to tensor<?xf32>
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice"]]} ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg0[%arg1] [%arg1] [1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%inserted_slice", "%arg0"]]} : tensor<?xf32> into tensor<?xf32>
    %extracted_slice_1 = tensor.extract_slice %inserted_slice[%arg3] [%arg3] [1] {__inplace_operands_attr__ = ["true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%inserted_slice", "%arg0"]]} : tensor<?xf32> to tensor<?xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%inserted_slice", "%arg0"]]} ins(%cst : f32) outs(%extracted_slice_1 : tensor<?xf32>) -> tensor<?xf32>
    %2 = vector.transfer_read %0[%arg2], %cst_0 {__inplace_operands_attr__ = ["true", "none", "none"]} : tensor<?xf32>, vector<5xf32>
    %inserted_slice_2 = tensor.insert_slice %1 into %inserted_slice[%arg3] [%arg3] [1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%inserted_slice", "%arg0"]]} : tensor<?xf32> into tensor<?xf32>
    return {__equivalent_func_args__ = [0, -1], __inplace_operands_attr__ = ["true", "none"]} %inserted_slice_2, %2 : tensor<?xf32>, vector<5xf32>
  }
}

// -----
module {
  func.func @extract_slice_linalg_readonly_use(%arg0: tensor<?x?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg1: tensor<4x4xf32> {bufferization.access = "read", bufferization.writable = false}, %arg2: tensor<4x4xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> (tensor<4x4xf32>, tensor<4x4xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%extracted_slice", "%arg0"], ["%arg1"], ["%1", "%arg2"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%arg0"]]} : tensor<?x?xf32> to tensor<4x4xf32>
    %0 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "false"], __opresult_alias_set_attr__ = [["%0"]]} ins(%extracted_slice, %arg1 : tensor<4x4xf32>, tensor<4x4xf32>) outs(%arg1 : tensor<4x4xf32>) -> tensor<4x4xf32>
    %1 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%1", "%arg2"]]} ins(%extracted_slice, %arg1 : tensor<4x4xf32>, tensor<4x4xf32>) outs(%arg2 : tensor<4x4xf32>) -> tensor<4x4xf32>
    return {__equivalent_func_args__ = [-1, 2], __inplace_operands_attr__ = ["true", "true"]} %0, %1 : tensor<4x4xf32>, tensor<4x4xf32>
  }
}

// -----
module {
  func.func @extract_slice_to_linalg_write_use(%arg0: tensor<4x4xf32> {bufferization.access = "read", bufferization.writable = false}, %arg1: tensor<?x?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg2: tensor<?x?xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> (tensor<4x4xf32>, tensor<4x4xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%extracted_slice", "%arg1"], ["%1", "%extracted_slice_0", "%arg2"]]]]} {
    %extracted_slice = tensor.extract_slice %arg1[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%arg1"]]} : tensor<?x?xf32> to tensor<4x4xf32>
    %0 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "false"], __opresult_alias_set_attr__ = [["%0"]]} ins(%arg1, %arg2 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%extracted_slice : tensor<4x4xf32>) -> tensor<4x4xf32>
    %extracted_slice_0 = tensor.extract_slice %arg2[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%arg2"]]} : tensor<?x?xf32> to tensor<4x4xf32>
    %1 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%arg2"]]} ins(%arg0, %extracted_slice : tensor<4x4xf32>, tensor<4x4xf32>) outs(%extracted_slice_0 : tensor<4x4xf32>) -> tensor<4x4xf32>
    return {__inplace_operands_attr__ = ["true", "true"]} %0, %1 : tensor<4x4xf32>, tensor<4x4xf32>
  }
}

// -----
module {
  func.func @insert_slice_double_extract_slice(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: tensor<8x6xf32> {bufferization.access = "read", bufferization.writable = false}, %arg5: tensor<6x6xf32> {bufferization.access = "read", bufferization.writable = false}, %arg6: tensor<30x20xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> tensor<30x20xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg4"], ["%arg5"], ["%extracted_slice_0", "%0", "%extracted_slice", "%inserted_slice", "%arg6"]]]]} {
    %extracted_slice = tensor.extract_slice %arg6[%arg2, %arg3] [%arg0, %arg1] [1, 1] {__inplace_operands_attr__ = ["true", "none", "none", "none", "none"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%0", "%extracted_slice", "%inserted_slice", "%arg6"]]} : tensor<30x20xf32> to tensor<?x?xf32>
    %0 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%0", "%extracted_slice", "%inserted_slice", "%arg6"]]} ins(%arg4, %arg5 : tensor<8x6xf32>, tensor<6x6xf32>) outs(%extracted_slice : tensor<?x?xf32>) -> tensor<?x?xf32>
    %extracted_slice_0 = tensor.extract_slice %0[0, 0] [%arg0, %arg1] [1, 1] {__inplace_operands_attr__ = ["true", "none", "none"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%0", "%extracted_slice", "%inserted_slice", "%arg6"]]} : tensor<?x?xf32> to tensor<?x?xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice_0 into %arg6[%arg2, %arg3] [%arg0, %arg1] [1, 1] {__inplace_operands_attr__ = ["true", "true", "none", "none", "none", "none"], __opresult_alias_set_attr__ = [["%extracted_slice_0", "%0", "%extracted_slice", "%inserted_slice", "%arg6"]]} : tensor<?x?xf32> into tensor<30x20xf32>
    return {__equivalent_func_args__ = [6], __inplace_operands_attr__ = ["true"]} %inserted_slice : tensor<30x20xf32>
  }
}

// -----
module {
  func.func @extract_slice_to_linalg_write_use(%arg0: tensor<4x4xf32> {bufferization.access = "read", bufferization.writable = false}, %arg1: tensor<?x?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg2: tensor<?x?xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> (tensor<4x4xf32>, tensor<4x4xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%arg1"], ["%1", "%extracted_slice_0", "%arg2"]]]]} {
    %extracted_slice = tensor.extract_slice %arg1[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice"]]} : tensor<?x?xf32> to tensor<4x4xf32>
    %0 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice"]]} ins(%arg1, %arg2 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%extracted_slice : tensor<4x4xf32>) -> tensor<4x4xf32>
    %extracted_slice_0 = tensor.extract_slice %arg2[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%arg2"]]} : tensor<?x?xf32> to tensor<4x4xf32>
    %1 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%arg2"]]} ins(%arg0, %arg0 : tensor<4x4xf32>, tensor<4x4xf32>) outs(%extracted_slice_0 : tensor<4x4xf32>) -> tensor<4x4xf32>
    return {__inplace_operands_attr__ = ["true", "true"]} %0, %1 : tensor<4x4xf32>, tensor<4x4xf32>
  }
}

// -----
module {
  func.func @nested_extract_slice_and_insert(%arg0: tensor<?x?xf32> {bufferization.access = "read", bufferization.writable = false}, %arg1: tensor<?x?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg2: tensor<?x?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg3: index, %arg4: index, %arg5: index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"], ["%inserted_slice_10", "%extracted_slice_8", "%inserted_slice_11", "%arg2"]]]]} {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [%arg3, %arg3] [1, 1] {__inplace_operands_attr__ = ["false", "none", "none"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice_0", "%inserted_slice", "%extracted_slice"]]} : tensor<?x?xf32> to tensor<?x?xf32>
    %extracted_slice_0 = tensor.extract_slice %extracted_slice[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice_0", "%inserted_slice", "%extracted_slice"]]} : tensor<?x?xf32> to tensor<4x4xf32>
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice_0", "%inserted_slice", "%extracted_slice"]]} ins(%cst : f32) outs(%extracted_slice_0 : tensor<4x4xf32>) -> tensor<4x4xf32>
    %inserted_slice = tensor.insert_slice %0 into %extracted_slice[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice_0", "%inserted_slice", "%extracted_slice"]]} : tensor<4x4xf32> into tensor<?x?xf32>
    %inserted_slice_1 = tensor.insert_slice %inserted_slice into %arg0[0, 0] [%arg3, %arg3] [1, 1] {__inplace_operands_attr__ = ["true", "false", "none", "none"], __opresult_alias_set_attr__ = [["%inserted_slice_1"]]} : tensor<?x?xf32> into tensor<?x?xf32>
    %extracted_slice_2 = tensor.extract_slice %arg1[0, 0] [%arg3, %arg3] [1, 1] {__inplace_operands_attr__ = ["true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"]]} : tensor<?x?xf32> to tensor<?x?xf32>
    %extracted_slice_3 = tensor.extract_slice %extracted_slice_2[0, 0] [4, %arg3] [1, 1] {__inplace_operands_attr__ = ["true", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"]]} : tensor<?x?xf32> to tensor<4x?xf32>
    %extracted_slice_4 = tensor.extract_slice %extracted_slice_3[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"]]} : tensor<4x?xf32> to tensor<4x4xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"]]} ins(%cst : f32) outs(%extracted_slice_4 : tensor<4x4xf32>) -> tensor<4x4xf32>
    %inserted_slice_5 = tensor.insert_slice %1 into %extracted_slice_3[0, 0] [4, 4] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"]]} : tensor<4x4xf32> into tensor<4x?xf32>
    %inserted_slice_6 = tensor.insert_slice %inserted_slice_5 into %extracted_slice_2[0, 0] [4, %arg3] [1, 1] {__inplace_operands_attr__ = ["true", "true", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"]]} : tensor<4x?xf32> into tensor<?x?xf32>
    %inserted_slice_7 = tensor.insert_slice %inserted_slice_6 into %arg1[0, 0] [%arg3, %arg3] [1, 1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_4", "%inserted_slice_5", "%extracted_slice_3", "%inserted_slice_6", "%extracted_slice_2", "%inserted_slice_7", "%arg1"]]} : tensor<?x?xf32> into tensor<?x?xf32>
    %extracted_slice_8 = tensor.extract_slice %arg2[0, 0] [%arg3, %arg3] [1, 1] {__inplace_operands_attr__ = ["true", "none", "none"], __opresult_alias_set_attr__ = [["%inserted_slice_10", "%extracted_slice_8", "%inserted_slice_11", "%arg2"]]} : tensor<?x?xf32> to tensor<?x?xf32>
    %extracted_slice_9 = tensor.extract_slice %extracted_slice_8[0, 0] [%arg4, 4] [1, 1] {__inplace_operands_attr__ = ["false", "none"], __opresult_alias_set_attr__ = [["%2", "%extracted_slice_9"]]} : tensor<?x?xf32> to tensor<?x4xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%2", "%extracted_slice_9"]]} ins(%cst : f32) outs(%extracted_slice_9 : tensor<?x4xf32>) -> tensor<?x4xf32>
    %inserted_slice_10 = tensor.insert_slice %2 into %extracted_slice_8[0, 0] [%arg5, 4] [1, 1] {__inplace_operands_attr__ = ["true", "true", "none"], __opresult_alias_set_attr__ = [["%inserted_slice_10", "%extracted_slice_8", "%inserted_slice_11", "%arg2"]]} : tensor<?x4xf32> into tensor<?x?xf32>
    %inserted_slice_11 = tensor.insert_slice %inserted_slice_10 into %arg2[0, 0] [%arg3, %arg3] [1, 1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%inserted_slice_10", "%extracted_slice_8", "%inserted_slice_11", "%arg2"]]} : tensor<?x?xf32> into tensor<?x?xf32>
    return {__equivalent_func_args__ = [-1, 1, 2], __inplace_operands_attr__ = ["true", "true", "true"]} %inserted_slice_1, %inserted_slice_7, %inserted_slice_11 : tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func private @foo(tensor<64xf32> {bufferization.access = "read-write"})
  func.func @dependence_through_call(%arg0: tensor<64xf32> {bufferization.access = "write", bufferization.writable = true}) attributes {__bbarg_alias_set_attr__ = [[[["%1", "%arg0"]]]]} {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "false"], __opresult_alias_set_attr__ = [["%0"]]} ins(%cst : f32) outs(%arg0 : tensor<64xf32>) -> tensor<64xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%arg0"]]} ins(%cst_0 : f32) outs(%arg0 : tensor<64xf32>) -> tensor<64xf32>
    call @foo(%0) {__inplace_operands_attr__ = ["true"]} : (tensor<64xf32>) -> ()
    call @foo(%1) {__inplace_operands_attr__ = ["true"]} : (tensor<64xf32>) -> ()
    return
  }
}

// -----
module {
  func.func private @foo(tensor<64xf32> {bufferization.access = "read-write"})
  func.func private @bar(%arg0: tensor<64xf32> {bufferization.access = "read-write"}) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"]]]]} {
    call @foo(%arg0) {__inplace_operands_attr__ = ["true"]} : (tensor<64xf32>) -> ()
    return
  }
  func.func @read_dependence_through_scf_and_call(%arg0: tensor<64xf32> {bufferization.access = "write", bufferization.writable = true}, %arg1: tensor<64xf32> {bufferization.access = "write", bufferization.writable = true}) attributes {__bbarg_alias_set_attr__ = [[[["%2#1", "%1", "%arg0"], ["%4", "%arg1"]]]]} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c10 = arith.constant 10 : index
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "false"], __opresult_alias_set_attr__ = [["%2#0", "%0"]]} ins(%cst : f32) outs(%arg0 : tensor<64xf32>) -> tensor<64xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%2#1", "%1", "%arg0"]]} ins(%cst_0 : f32) outs(%arg0 : tensor<64xf32>) -> tensor<64xf32>
    %2:2 = scf.for %arg2 = %c0 to %c10 step %c1 iter_args(%arg3 = %0, %arg4 = %1) -> (tensor<64xf32>, tensor<64xf32>) {
      scf.yield {__inplace_operands_attr__ = ["true", "true"]} %arg3, %arg4 : tensor<64xf32>, tensor<64xf32>
    } {__bbarg_alias_set_attr__ = [[[["%arg3"], ["%arg4"]]]], __inplace_operands_attr__ = ["none", "none", "none", "true", "true"], __opresult_alias_set_attr__ = [["%2#0", "%0"], ["%2#1", "%1", "%arg0"]]}
    call @foo(%2#0) {__inplace_operands_attr__ = ["true"]} : (tensor<64xf32>) -> ()
    call @foo(%2#1) {__inplace_operands_attr__ = ["true"]} : (tensor<64xf32>) -> ()
    %3 = linalg.fill {__inplace_operands_attr__ = ["none", "false"], __opresult_alias_set_attr__ = [["%3"]]} ins(%cst : f32) outs(%arg1 : tensor<64xf32>) -> tensor<64xf32>
    %4 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%4", "%arg1"]]} ins(%cst_0 : f32) outs(%arg1 : tensor<64xf32>) -> tensor<64xf32>
    call @bar(%3) {__inplace_operands_attr__ = ["true"]} : (tensor<64xf32>) -> ()
    call @bar(%4) {__inplace_operands_attr__ = ["true"]} : (tensor<64xf32>) -> ()
    return
  }
}

// -----
module {
  func.func @write_into_constant_via_alias(%arg0: vector<5xi32>, %arg1: index, %arg2: index, %arg3: index) -> tensor<?xi32> {
    %cst = arith.constant {__opresult_alias_set_attr__ = [["%cst"]]} dense<[1, 2, 3, 4]> : tensor<4xi32>
    %extracted_slice = tensor.extract_slice %cst[%arg1] [%arg2] [1] {__inplace_operands_attr__ = ["false", "none", "none"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice"]]} : tensor<4xi32> to tensor<?xi32>
    %0 = vector.transfer_write %arg0, %extracted_slice[%arg3] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice"]]} : vector<5xi32>, tensor<?xi32>
    return {__inplace_operands_attr__ = ["true"]} %0 : tensor<?xi32>
  }
}

// -----
module {
  func.func @matmul_on_tensors(%arg0: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%arg1"], ["%3", "%arg2"]]]]} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%extracted_slice_1", "%2", "%0"]]} : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"], __opresult_alias_set_attr__ = [["%extracted_slice", "%1"]]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%extracted_slice_1", "%2", "%0"]]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%1"]]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %2[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_1", "%2", "%0"]]} : tensor<256x256xf32> to tensor<16x256xf32>
    %3 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%3", "%arg2"]]} ins(%extracted_slice, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %3 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @matmul_on_tensors(%arg0: tensor<518x518xf32> {bufferization.access = "read", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg1: tensor<518x518xf32> {bufferization.access = "read", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg2: tensor<256x256xf32> {bufferization.access = "read-write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<256x256xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%arg1"], ["%7", "%arg2"]]]]} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%extracted_slice_1", "%6", "%4", "%0"]]} : tensor<256x256xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"], __opresult_alias_set_attr__ = [["%extracted_slice", "%3", "%1"]]} ins(%cst : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %2 = vector.transfer_read %arg0[%c0, %c0], %cst {__inplace_operands_attr__ = ["true", "none", "none", "none"], in_bounds = [false, true]} : tensor<518x518xf32>, vector<256x256xf32>
    %3 = vector.transfer_write %2, %1[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"], __opresult_alias_set_attr__ = [["%extracted_slice", "%3", "%1"]], in_bounds = [true, true]} : vector<256x256xf32>, tensor<256x256xf32>
    %4 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%extracted_slice_1", "%6", "%4", "%0"]]} ins(%cst_0 : f32) outs(%0 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = vector.transfer_read %arg1[%c0, %c0], %cst {__inplace_operands_attr__ = ["true", "none", "none", "none"], in_bounds = [false, true]} : tensor<518x518xf32>, vector<256x256xf32>
    %6 = vector.transfer_write %5, %4[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"], __opresult_alias_set_attr__ = [["%extracted_slice_1", "%6", "%4", "%0"]], in_bounds = [true, true]} : vector<256x256xf32>, tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %3[0, 0] [256, 16] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%3", "%1"]]} : tensor<256x256xf32> to tensor<256x16xf32>
    %extracted_slice_1 = tensor.extract_slice %6[0, 0] [16, 256] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice_1", "%6", "%4", "%0"]]} : tensor<256x256xf32> to tensor<16x256xf32>
    %7 = linalg.matmul {__inplace_operands_attr__ = ["true", "true", "true"], __opresult_alias_set_attr__ = [["%7", "%arg2"]]} ins(%extracted_slice, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%arg2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %7 : tensor<256x256xf32>
  }
}

// -----
module {
  func.func @insert_slice_chain(%arg0: vector<32x90xf32>, %arg1: vector<30x90xf32>, %arg2: tensor<62x126xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg3: tensor<126x90xf32> {bufferization.access = "none", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = false}, %arg4: tensor<62x90xf32> {bufferization.access = "write", bufferization.buffer_layout = affine_map<(d0, d1) -> (d0, d1)>, bufferization.writable = true}) -> tensor<62x90xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg2"], ["%arg3"], ["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]]]], passthrough = [["prefer-vector-width", "512"]], target_cpu = "skylake-avx512"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]]} ins(%cst : f32) outs(%arg4 : tensor<62x90xf32>) -> tensor<62x90xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]]} : tensor<62x90xf32> to tensor<32x90xf32>
    %1 = vector.transfer_write %arg0, %extracted_slice[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]], in_bounds = [true, true]} : vector<32x90xf32>, tensor<32x90xf32>
    %inserted_slice = tensor.insert_slice %1 into %0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]]} : tensor<32x90xf32> into tensor<62x90xf32>
    %extracted_slice_0 = tensor.extract_slice %inserted_slice[32, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]]} : tensor<62x90xf32> to tensor<30x90xf32>
    %2 = vector.transfer_write %arg1, %extracted_slice_0[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]], in_bounds = [true, true]} : vector<30x90xf32>, tensor<30x90xf32>
    %inserted_slice_1 = tensor.insert_slice %2 into %inserted_slice[32, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice", "%2", "%extracted_slice_0", "%inserted_slice_1", "%inserted_slice", "%0", "%arg4"]]} : tensor<30x90xf32> into tensor<62x90xf32>
    return {__equivalent_func_args__ = [4], __inplace_operands_attr__ = ["true"]} %inserted_slice_1 : tensor<62x90xf32>
  }
}

// -----
module {
  func.func @ip(%arg0: tensor<10x20xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index, %arg2: index, %arg3: vector<5x6xf32>) -> tensor<10x20xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg0"]]]]} {
    %c0 = arith.constant 0 : index
    %c256 = arith.constant 256 : index
    %c257 = arith.constant 257 : index
    %0 = scf.for %arg4 = %c0 to %c257 step %c256 iter_args(%arg5 = %arg0) -> (tensor<10x20xf32>) {
      %extracted_slice = tensor.extract_slice %arg5[%arg1, 0] [5, %arg2] [1, 1] {__inplace_operands_attr__ = ["true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%extracted_slice", "%inserted_slice", "%arg5"]]} : tensor<10x20xf32> to tensor<5x?xf32>
      %extracted_slice_0 = tensor.extract_slice %extracted_slice[0, 0] [5, %arg2] [1, 1] {__inplace_operands_attr__ = ["true", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%extracted_slice", "%inserted_slice", "%arg5"]]} : tensor<5x?xf32> to tensor<5x?xf32>
      %1 = vector.transfer_write %arg3, %extracted_slice_0[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%extracted_slice", "%inserted_slice", "%arg5"]]} : vector<5x6xf32>, tensor<5x?xf32>
      %inserted_slice = tensor.insert_slice %1 into %arg5[%arg1, 0] [5, %arg2] [1, 1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0", "%extracted_slice", "%inserted_slice", "%arg5"]]} : tensor<5x?xf32> into tensor<10x20xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %inserted_slice : tensor<10x20xf32>
    } {__bbarg_alias_set_attr__ = [[[["%1", "%extracted_slice_0", "%extracted_slice", "%inserted_slice", "%arg5"]]]], __inplace_operands_attr__ = ["none", "none", "none", "true"], __opresult_alias_set_attr__ = [["%0", "%arg0"]]}
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<10x20xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @linalg_op_same_out_tensors(%arg0: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "write", bufferization.writable = true}) -> (tensor<?xf32>, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%0#0", "%arg1"]]]]} {
    %0:2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<?xf32>) outs(%arg1, %arg1 : tensor<?xf32>, tensor<?xf32>) attrs =  {__inplace_operands_attr__ = ["true", "true", "false"], __opresult_alias_set_attr__ = [["%0#0", "%arg1"], ["%0#1"]]} {
    ^bb0(%in: f32, %out: f32, %out_0: f32):
      linalg.yield %in, %in : f32, f32
    } -> (tensor<?xf32>, tensor<?xf32>)
    return {__equivalent_func_args__ = [1, -1], __inplace_operands_attr__ = ["true", "true"]} %0#0, %0#1 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @linalg_op_same_out_tensors_2(%arg0: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "write", bufferization.writable = true}) -> (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%0#0", "%arg1"]]]]} {
    %0:3 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<?xf32>) outs(%arg1, %arg1, %arg1 : tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) attrs =  {__inplace_operands_attr__ = ["true", "true", "false", "false"], __opresult_alias_set_attr__ = [["%0#0", "%arg1"], ["%0#1"], ["%0#2"]]} {
    ^bb0(%in: f32, %out: f32, %out_0: f32, %out_1: f32):
      linalg.yield %in, %in, %in : f32, f32, f32
    } -> (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>)
    return {__equivalent_func_args__ = [1, -1, -1], __inplace_operands_attr__ = ["true", "true", "true"]} %0#0, %0#1, %0#2 : tensor<?xf32>, tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @double_insert_slice_into_alias(%arg0: vector<32x90xf32>, %arg1: vector<30x90xf32>, %arg2: tensor<62x90xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg3: index, %arg4: index, %arg5: index, %arg6: index) -> (tensor<62x90xf32>, tensor<?x?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%0", "%extracted_slice_0", "%inserted_slice", "%arg2"]]]]} {
    %c0 = arith.constant 0 : index
    %extracted_slice = tensor.extract_slice %arg2[%arg3, %arg4] [%arg5, %arg6] [1, 1] {__inplace_operands_attr__ = ["false", "none", "none", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%extracted_slice"]]} : tensor<62x90xf32> to tensor<?x?xf32>
    %extracted_slice_0 = tensor.extract_slice %arg2[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice_0", "%inserted_slice", "%arg2"]]} : tensor<62x90xf32> to tensor<32x90xf32>
    %0 = vector.transfer_write %arg0, %extracted_slice_0[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice_0", "%inserted_slice", "%arg2"]], in_bounds = [true, true]} : vector<32x90xf32>, tensor<32x90xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg2[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%0", "%extracted_slice_0", "%inserted_slice", "%arg2"]]} : tensor<32x90xf32> into tensor<62x90xf32>
    %extracted_slice_1 = tensor.extract_slice %extracted_slice[32, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%extracted_slice"]]} : tensor<?x?xf32> to tensor<30x90xf32>
    %1 = vector.transfer_write %arg1, %extracted_slice_1[%c0, %c0] {__inplace_operands_attr__ = ["none", "true", "none", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%extracted_slice"]], in_bounds = [true, true]} : vector<30x90xf32>, tensor<30x90xf32>
    %inserted_slice_2 = tensor.insert_slice %1 into %extracted_slice[32, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_1", "%inserted_slice_2", "%extracted_slice"]]} : tensor<30x90xf32> into tensor<?x?xf32>
    return {__equivalent_func_args__ = [2, -1], __inplace_operands_attr__ = ["true", "true"]} %inserted_slice, %inserted_slice_2 : tensor<62x90xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @interleaved_extract_insert_slice_chain_1(%arg0: tensor<62x90xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> tensor<62x90xf32> attributes {__bbarg_alias_set_attr__ = [[[["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]} : tensor<62x90xf32> to tensor<32x90xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[32, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%extracted_slice_0"]]} : tensor<62x90xf32> to tensor<30x90xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]} : tensor<32x90xf32> into tensor<62x90xf32>
    %inserted_slice_1 = tensor.insert_slice %extracted_slice_0 into %inserted_slice[32, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]} : tensor<30x90xf32> into tensor<62x90xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %inserted_slice_1 : tensor<62x90xf32>
  }
}

// -----
module {
  func.func @interleaved_extract_insert_slice_chain_2(%arg0: tensor<62x90xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> tensor<62x90xf32> attributes {__bbarg_alias_set_attr__ = [[[["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]} : tensor<62x90xf32> to tensor<32x90xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[31, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%extracted_slice_0"]]} : tensor<62x90xf32> to tensor<30x90xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]} : tensor<32x90xf32> into tensor<62x90xf32>
    %inserted_slice_1 = tensor.insert_slice %extracted_slice_0 into %inserted_slice[31, 0] [30, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%extracted_slice", "%inserted_slice_1", "%inserted_slice", "%arg0"]]} : tensor<30x90xf32> into tensor<62x90xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %inserted_slice_1 : tensor<62x90xf32>
  }
}

// -----
module {
  func.func @extract_once_insert_twice(%arg0: tensor<62x90xf32> {bufferization.access = "read-write", bufferization.writable = true}) -> tensor<62x90xf32> attributes {__bbarg_alias_set_attr__ = [[[["%inserted_slice_0", "%inserted_slice", "%arg0"]]]]} {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%extracted_slice"]]} : tensor<62x90xf32> to tensor<32x90xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg0[0, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%inserted_slice_0", "%inserted_slice", "%arg0"]]} : tensor<32x90xf32> into tensor<62x90xf32>
    %inserted_slice_0 = tensor.insert_slice %extracted_slice into %inserted_slice[15, 0] [32, 90] [1, 1] {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%inserted_slice_0", "%inserted_slice", "%arg0"]]} : tensor<32x90xf32> into tensor<62x90xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %inserted_slice_0 : tensor<62x90xf32>
  }
}

// -----
module {
  func.func @some_use(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: vector<5xf32>) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg0"]]]]} {
    %c0 = arith.constant 0 : index
    %0 = vector.transfer_write %arg1, %arg0[%c0] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%0", "%arg0"]]} : vector<5xf32>, tensor<?xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
  func.func @main_func(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: vector<5xf32>) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg0"]]]]} {
    %0 = call @some_use(%arg0, %arg1) {__inplace_operands_attr__ = ["true", "none"], __opresult_alias_set_attr__ = [["%0", "%arg0"]]} : (tensor<?xf32>, vector<5xf32>) -> tensor<?xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
}

// -----
module {
  func.func @to_tensor_op_not_writable(%arg0: memref<?xf32>, %arg1: vector<5xf32>, %arg2: index, %arg3: index) -> vector<10xf32> {
    %0 = bufferization.to_tensor %arg0 restrict {__opresult_alias_set_attr__ = [["%0"]]} : memref<?xf32> to tensor<?xf32>
    %1 = vector.transfer_write %arg1, %0[%arg2] {__inplace_operands_attr__ = ["none", "false", "none"], __opresult_alias_set_attr__ = [["%1"]]} : vector<5xf32>, tensor<?xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = vector.transfer_read %1[%arg3], %cst {__inplace_operands_attr__ = ["true", "none", "none"]} : tensor<?xf32>, vector<10xf32>
    return %2 : vector<10xf32>
  }
}

// -----
module {
  func.func @inner_func(%arg0: tensor<?xf32> {bufferization.access = "read"}) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg0"]]]]} {
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %arg0 : tensor<?xf32>
  }
  func.func @equivalent_func_arg(%arg0: index, %arg1: index, %arg2: index, %arg3: tensor<?xf32> {bufferization.access = "read-write"}) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg3"]]]]} {
    %0 = scf.for %arg4 = %arg0 to %arg1 step %arg2 iter_args(%arg5 = %arg3) -> (tensor<?xf32>) {
      %1 = func.call @inner_func(%arg5) {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%arg5"]]} : (tensor<?xf32>) -> tensor<?xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %1 : tensor<?xf32>
    } {__bbarg_alias_set_attr__ = [[[["%1", "%arg5"]]]], __inplace_operands_attr__ = ["none", "none", "none", "true"], __opresult_alias_set_attr__ = [["%0", "%arg3"]]}
    return {__equivalent_func_args__ = [3], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
}

// -----
module {
  func.func @inner_func_2(%arg0: tensor<?xf32> {bufferization.access = "read-write"}) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%inserted", "%arg0"]]]]} {
    %cst = arith.constant 1.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %inserted = tensor.insert %cst into %arg0[%c0] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%arg0"]]} : tensor<?xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %inserted : tensor<?xf32>
  }
  func.func @equivalent_func_arg_2(%arg0: index, %arg1: index, %arg2: index, %arg3: tensor<?xf32> {bufferization.access = "read-write"}) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg3"]]]]} {
    %0 = scf.for %arg4 = %arg0 to %arg1 step %arg2 iter_args(%arg5 = %arg3) -> (tensor<?xf32>) {
      %1 = func.call @inner_func_2(%arg5) {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%1", "%arg5"]]} : (tensor<?xf32>) -> tensor<?xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %1 : tensor<?xf32>
    } {__bbarg_alias_set_attr__ = [[[["%1", "%arg5"]]]], __inplace_operands_attr__ = ["none", "none", "none", "true"], __opresult_alias_set_attr__ = [["%0", "%arg3"]]}
    return {__equivalent_func_args__ = [3], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
}

// -----
module {
  func.func @write_after_select_read_one(%arg0: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg2: i1) -> (f32, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%inserted", "%0", "%arg1"]]]]} {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %0 = arith.select %arg2, %arg0, %arg1 {__inplace_operands_attr__ = ["none", "false", "true"], __opresult_alias_set_attr__ = [["%inserted", "%0", "%arg1"]]} : tensor<?xf32>
    %inserted = tensor.insert %cst into %0[%c0] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%0", "%arg1"]]} : tensor<?xf32>
    %extracted = tensor.extract %arg0[%c0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<?xf32>
    return {__inplace_operands_attr__ = ["none", "true"]} %extracted, %inserted : f32, tensor<?xf32>
  }
}

// -----
module {
  func.func @write_after_select_read_both(%arg0: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}, %arg2: i1) -> (f32, f32, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%arg1"]]]]} {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %0 = arith.select %arg2, %arg0, %arg1 {__inplace_operands_attr__ = ["none", "false", "false"], __opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<?xf32>
    %inserted = tensor.insert %cst into %0[%c0] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<?xf32>
    %extracted = tensor.extract %arg0[%c0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<?xf32>
    %extracted_0 = tensor.extract %arg1[%c0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<?xf32>
    return {__inplace_operands_attr__ = ["none", "none", "true"]} %extracted, %extracted_0, %inserted : f32, f32, tensor<?xf32>
  }
}

// -----
module {
  func.func @write_after_select_no_conflict(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg2: i1) -> (f32, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%inserted", "%0", "%arg0", "%arg1"], ["%inserted", "%0", "%arg0", "%arg1"]]]]} {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %0 = arith.select %arg2, %arg0, %arg1 {__inplace_operands_attr__ = ["none", "true", "true"], __opresult_alias_set_attr__ = [["%inserted", "%0", "%arg0", "%arg1"]]} : tensor<?xf32>
    %inserted = tensor.insert %cst into %0[%c0] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%0", "%arg0", "%arg1"]]} : tensor<?xf32>
    %extracted = tensor.extract %inserted[%c0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<?xf32>
    return {__inplace_operands_attr__ = ["none", "true"]} %extracted, %inserted : f32, tensor<?xf32>
  }
}

// -----
module {
  func.func @write_to_same_tensor_in_loop_out_of_place(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: tensor<?xf32> {bufferization.access = "read", bufferization.writable = true}, %arg2: index, %arg3: index, %arg4: index, %arg5: index) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg0"], ["%arg1"]]]]} {
    %0 = scf.for %arg6 = %arg2 to %arg3 step %arg4 iter_args(%arg7 = %arg0) -> (tensor<?xf32>) {
      %1 = arith.index_cast %arg6 : index to i32
      %2 = arith.sitofp %1 : i32 to f32
      %inserted = tensor.insert %2 into %arg1[%arg6] {__inplace_operands_attr__ = ["none", "false", "none"], __opresult_alias_set_attr__ = [["%inserted"]]} : tensor<?xf32>
      %inserted_slice = tensor.insert_slice %inserted into %arg7[%arg6] [%arg5] [1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%inserted_slice", "%arg7"]]} : tensor<?xf32> into tensor<?xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %inserted_slice : tensor<?xf32>
    } {__bbarg_alias_set_attr__ = [[[["%inserted_slice", "%arg7"]]]], __inplace_operands_attr__ = ["none", "none", "none", "true"], __opresult_alias_set_attr__ = [["%0", "%arg0"]]}
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
}

// -----
module {
  func.func @write_to_same_alloc_tensor_in_place(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%1", "%arg0"]]]]} {
    %0 = bufferization.alloc_tensor(%arg5) {__opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<?xf32>
    %1 = scf.for %arg6 = %arg1 to %arg2 step %arg3 iter_args(%arg7 = %arg0) -> (tensor<?xf32>) {
      %2 = arith.index_cast %arg6 : index to i32
      %3 = arith.sitofp %2 : i32 to f32
      %inserted = tensor.insert %3 into %0[%arg6] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<?xf32>
      %inserted_slice = tensor.insert_slice %inserted into %arg7[%arg6] [%arg4] [1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%inserted_slice", "%arg7"]]} : tensor<?xf32> into tensor<?xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %inserted_slice : tensor<?xf32>
    } {__bbarg_alias_set_attr__ = [[[["%inserted_slice", "%arg7"]]]], __inplace_operands_attr__ = ["none", "none", "none", "true"], __opresult_alias_set_attr__ = [["%1", "%arg0"]]}
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %1 : tensor<?xf32>
  }
}

// -----
module {
  func.func @write_to_same_alloc_tensor_out_of_place(%arg0: tensor<?xf32> {bufferization.access = "read-write", bufferization.writable = true}, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: f32) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%1", "%arg0"]]]]} {
    %0 = bufferization.alloc_tensor(%arg5) {__opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<?xf32>
    %inserted = tensor.insert %arg6 into %0[%arg1] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<?xf32>
    %1 = scf.for %arg7 = %arg1 to %arg2 step %arg3 iter_args(%arg8 = %arg0) -> (tensor<?xf32>) {
      %2 = arith.index_cast %arg7 : index to i32
      %3 = arith.sitofp %2 : i32 to f32
      %inserted_0 = tensor.insert %3 into %inserted[%arg7] {__inplace_operands_attr__ = ["none", "false", "none"], __opresult_alias_set_attr__ = [["%inserted_0"]]} : tensor<?xf32>
      %inserted_slice = tensor.insert_slice %inserted_0 into %arg8[%arg7] [%arg4] [1] {__inplace_operands_attr__ = ["true", "true", "none", "none"], __opresult_alias_set_attr__ = [["%inserted_slice", "%arg8"]]} : tensor<?xf32> into tensor<?xf32>
      scf.yield {__inplace_operands_attr__ = ["true"]} %inserted_slice : tensor<?xf32>
    } {__bbarg_alias_set_attr__ = [[[["%inserted_slice", "%arg8"]]]], __inplace_operands_attr__ = ["none", "none", "none", "true"], __opresult_alias_set_attr__ = [["%1", "%arg0"]]}
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %1 : tensor<?xf32>
  }
}

// -----
module {
  func.func private @ext_func(tensor<?xf32> {bufferization.access = "read-write"})
  func.func @private_func_read_write(%arg0: tensor<5xf32> {bufferization.access = "read"}) -> f32 attributes {__bbarg_alias_set_attr__ = [[[["%arg0"]]]]} {
    %c0 = arith.constant 0 : index
    %cast = tensor.cast %arg0 {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%cast"]]} : tensor<5xf32> to tensor<?xf32>
    call @ext_func(%cast) {__inplace_operands_attr__ = ["true"]} : (tensor<?xf32>) -> ()
    %extracted = tensor.extract %arg0[%c0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func private @print_buffer(tensor<*xf32> {bufferization.access = "read"})
  func.func @private_func_read(%arg0: tensor<5xf32> {bufferization.access = "read"}) -> f32 attributes {__bbarg_alias_set_attr__ = [[[["%cast", "%arg0"]]]]} {
    %c0 = arith.constant 0 : index
    %cast = tensor.cast %arg0 {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%cast", "%arg0"]]} : tensor<5xf32> to tensor<*xf32>
    call @print_buffer(%cast) {__inplace_operands_attr__ = ["true"]} : (tensor<*xf32>) -> ()
    %extracted = tensor.extract %arg0[%c0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func private @ext_func(tensor<?xf32> {bufferization.access = "read-write"}, tensor<?xf32> {bufferization.access = "read-write"})
  func.func @private_func_two_params_writing(%arg0: tensor<?xf32> {bufferization.access = "read"}) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"]]]]} {
    call @ext_func(%arg0, %arg0) {__inplace_operands_attr__ = ["false", "false"]} : (tensor<?xf32>, tensor<?xf32>) -> ()
    return
  }
}

// -----
module {
  func.func private @ext_func(tensor<?xf32> {bufferization.access = "read-write"}) -> (tensor<5xf32>, tensor<6xf32>)
  func.func @private_func_aliasing(%arg0: tensor<?xf32> {bufferization.access = "read"}) -> f32 attributes {__bbarg_alias_set_attr__ = [[[["%arg0"]]]]} {
    %c0 = arith.constant 0 : index
    %0:2 = call @ext_func(%arg0) {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%0#0"], ["%0#1"]]} : (tensor<?xf32>) -> (tensor<5xf32>, tensor<6xf32>)
    %extracted = tensor.extract %0#1[%c0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<6xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func @recursive_function(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>) attributes {__bbarg_alias_set_attr__ = [[[["%arg0"], ["%arg1"]]]]} {
    %0:2 = call @recursive_function(%arg0, %arg1) {__inplace_operands_attr__ = ["false", "false"], __opresult_alias_set_attr__ = [["%0#0"], ["%0#1"]]} : (tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    return {__inplace_operands_attr__ = ["true", "true"]} %0#0, %0#1 : tensor<?xf32>, tensor<?xf32>
  }
}

// -----
module {
  func.func @multiple_returns(%arg0: i1, %arg1: tensor<5xf32> {bufferization.access = "read"}, %arg2: tensor<5xf32> {bufferization.access = "read"}, %arg3: tensor<5xf32> {bufferization.access = "none"}) -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg1"], ["%arg2"], ["%arg3"]], [], []]]} {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return {__equivalent_func_args__ = [1], __inplace_operands_attr__ = ["true"]} %arg1 : tensor<5xf32>
  ^bb2:  // pred: ^bb0
    return {__equivalent_func_args__ = [2], __inplace_operands_attr__ = ["true"]} %arg2 : tensor<5xf32>
  }
  func.func @caller(%arg0: i1, %arg1: tensor<5xf32> {bufferization.access = "read"}, %arg2: tensor<5xf32> {bufferization.access = "read"}, %arg3: tensor<5xf32> {bufferization.access = "none"}) attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg1", "%arg2"], ["%0", "%arg1", "%arg2"], ["%arg3"]]]]} {
    %0 = call @multiple_returns(%arg0, %arg1, %arg2, %arg3) {__inplace_operands_attr__ = ["none", "true", "true", "true"], __opresult_alias_set_attr__ = [["%0", "%arg1", "%arg2"]]} : (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    return
  }
}

// -----
module {
  func.func @multiple_equivalent_returns(%arg0: i1, %arg1: tensor<5xf32> {bufferization.access = "read"}, %arg2: tensor<5xf32> {bufferization.access = "none"}, %arg3: tensor<5xf32> {bufferization.access = "none"}) -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg1"], ["%arg2"], ["%arg3"]], [], []]]} {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return {__equivalent_func_args__ = [1], __inplace_operands_attr__ = ["true"]} %arg1 : tensor<5xf32>
  ^bb2:  // pred: ^bb0
    return {__equivalent_func_args__ = [1], __inplace_operands_attr__ = ["true"]} %arg1 : tensor<5xf32>
  }
  func.func @caller(%arg0: i1, %arg1: tensor<5xf32> {bufferization.access = "read"}, %arg2: tensor<5xf32> {bufferization.access = "none"}, %arg3: tensor<5xf32> {bufferization.access = "none"}) -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg1"], ["%arg2"], ["%arg3"]]]]} {
    %0 = call @multiple_equivalent_returns(%arg0, %arg1, %arg2, %arg3) {__inplace_operands_attr__ = ["none", "true", "true", "true"], __opresult_alias_set_attr__ = [["%0", "%arg1"]]} : (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    return {__equivalent_func_args__ = [1], __inplace_operands_attr__ = ["true"]} %0 : tensor<5xf32>
  }
}

// -----
module {
  func.func @foo(%arg0: tensor<?xf32> {bufferization.access = "read"}) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg0"]]]]} {
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %arg0 : tensor<?xf32>
  }
  func.func @bar(%arg0: tensor<?xf32> {bufferization.access = "read"}) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg0"]]]]} {
    %0 = call @foo(%arg0) {__inplace_operands_attr__ = ["true"], __opresult_alias_set_attr__ = [["%0", "%arg0"]]} : (tensor<?xf32>) -> tensor<?xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<?xf32>
  }
}

