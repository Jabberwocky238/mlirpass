module {
  func.func @unknown_op_aliasing(%arg0: f32, %arg1: f32, %arg2: index) -> f32 {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%3", "%1", "%0"]]} : tensor<10xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%3", "%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<10xf32>) -> tensor<10xf32>
    %2 = "dummy.dummy_op"(%1) {__inplace_operands_attr__ = ["false"], __opresult_alias_set_attr__ = [["%2"]]} : (tensor<10xf32>) -> tensor<10xf32>
    %3 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%3", "%1", "%0"]]} ins(%arg1 : f32) outs(%1 : tensor<10xf32>) -> tensor<10xf32>
    %extracted = tensor.extract %2[%arg2] {__inplace_operands_attr__ = ["true", "none"]} : tensor<10xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func @unknown_op_bbarg_aliasing() {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%0"]]} : tensor<7xf32>
    "dummy.dummy_op"(%0) ({
    ^bb0(%arg0: tensor<7xf32>):
    }) {__bbarg_alias_set_attr__ = [[[["%arg0"]]]], __inplace_operands_attr__ = ["false"]} : (tensor<7xf32>) -> ()
    return
  }
}

// -----
module {
  func.func @unknown_op_writing(%arg0: f32, %arg1: f32, %arg2: index) -> f32 {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%1", "%0"]]} : tensor<10xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<10xf32>) -> tensor<10xf32>
    "dummy.dummy_op"(%1) {__inplace_operands_attr__ = ["false"]} : (tensor<10xf32>) -> ()
    %extracted = tensor.extract %1[%arg2] {__inplace_operands_attr__ = ["true", "none"]} : tensor<10xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func @read_of_undef_is_not_a_conflict(%arg0: f32, %arg1: index) -> f32 {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<10xf32>
    %inserted = tensor.insert %arg0 into %0[%arg1] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<10xf32>
    %extracted = tensor.extract %0[%arg1] {__inplace_operands_attr__ = ["true", "none"]} : tensor<10xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func @read_of_alloc_tensor_is_not_a_conflict(%arg0: f32, %arg1: index) -> f32 {
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<10xf32>
    %inserted = tensor.insert %arg0 into %0[%arg1] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%0"]]} : tensor<10xf32>
    %extracted = tensor.extract %0[%arg1] {__inplace_operands_attr__ = ["true", "none"]} : tensor<10xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func @to_buffer_not_read_only(%arg0: index, %arg1: f32) -> f32 {
    %generated = tensor.generate  {
    ^bb0(%arg2: index):
      tensor.yield %arg1 : f32
    } {__opresult_alias_set_attr__ = [["%generated"]]} : tensor<5xf32>
    %0 = bufferization.to_buffer %generated {__inplace_operands_attr__ = ["false"]} : tensor<5xf32> to memref<5xf32>
    %extracted = tensor.extract %generated[%arg0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func @to_buffer_read_only(%arg0: index, %arg1: f32) -> f32 {
    %generated = tensor.generate  {
    ^bb0(%arg2: index):
      tensor.yield %arg1 : f32
    } {__opresult_alias_set_attr__ = [["%generated"]]} : tensor<5xf32>
    %0 = bufferization.to_buffer %generated read_only {__inplace_operands_attr__ = ["true"]} : tensor<5xf32> to memref<5xf32>
    %extracted = tensor.extract %generated[%arg0] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    return %extracted : f32
  }
}

// -----
module {
  func.func @bbarg_of_unknown_op(%arg0: f32) {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%1", "%0"]]} : tensor<10xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<10xf32>) -> tensor<10xf32>
    "dummy.dummy_op"(%1) ({
    ^bb0(%arg1: tensor<10xf32>):
    }) {__bbarg_alias_set_attr__ = [[[["%arg1"]]]], __inplace_operands_attr__ = ["false"]} : (tensor<10xf32>) -> ()
    return
  }
}

// -----
module {
  func.func @bbarg_of_unknown_op_2(%arg0: f32) {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%1", "%0"]]} : tensor<10xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<10xf32>) -> tensor<10xf32>
    "dummy.dummy_op"(%1) ({
    ^bb0(%arg1: tensor<10xf32>):
      "dummy.another_op"(%arg1) {__inplace_operands_attr__ = ["false"]} : (tensor<10xf32>) -> ()
    }) {__bbarg_alias_set_attr__ = [[[["%arg1"]]]], __inplace_operands_attr__ = ["false"]} : (tensor<10xf32>) -> ()
    return
  }
}

// -----
module {
  func.func @materialize_in_destination_aliasing(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index) -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[["%extracted_slice", "%arg0"]]]]} {
    %0 = tensor.empty(%arg3) {__opresult_alias_set_attr__ = [["%0"]]} : tensor<?xf32>
    %extracted_slice = tensor.extract_slice %arg0[%arg1] [5] [1] {__inplace_operands_attr__ = ["true", "none"], __opresult_alias_set_attr__ = [["%extracted_slice", "%arg0"]]} : tensor<?xf32> to tensor<5xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[%arg2] [5] [1] {__inplace_operands_attr__ = ["false", "none"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0"]]} : tensor<?xf32> to tensor<5xf32>
    %1 = bufferization.materialize_in_destination %extracted_slice in %extracted_slice_0 {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%1", "%extracted_slice_0"]]} : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    return {__inplace_operands_attr__ = ["true"]} %1 : tensor<5xf32>
  }
}

// -----
module {
  func.func @materialize_in_destination(%arg0: tensor<?xf32>, %arg1: index) -> tensor<?xf32> attributes {__bbarg_alias_set_attr__ = [[[["%arg0"]]]]} {
    %0 = tensor.empty(%arg1) {__opresult_alias_set_attr__ = [["%1", "%0"]]} : tensor<?xf32>
    %1 = bufferization.materialize_in_destination %0 in %0 {__inplace_operands_attr__ = ["true", "true"], __opresult_alias_set_attr__ = [["%1", "%0"]]} : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    return {__inplace_operands_attr__ = ["true"]} %1 : tensor<?xf32>
  }
}

