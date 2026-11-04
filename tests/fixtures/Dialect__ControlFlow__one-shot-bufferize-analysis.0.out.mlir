module {
  func.func @single_branch(%arg0: tensor<5xf32> {bufferization.access = "read"}) -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%arg0"]], [["%0", "%arg0"]]]]} {
    cf.br ^bb1(%arg0 : tensor<5xf32>) {__inplace_operands_attr__ = ["true"]}
  ^bb1(%0: tensor<5xf32>):  // pred: ^bb0
    return {__inplace_operands_attr__ = ["true"]} %0 : tensor<5xf32>
  }
}

// -----
module {
  func.func @diamond_branch(%arg0: i1, %arg1: tensor<5xf32> {bufferization.access = "read"}, %arg2: tensor<5xf32> {bufferization.access = "read"}) -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[["%0", "%2", "%1", "%arg1", "%arg2"], ["%0", "%2", "%1", "%arg1", "%arg2"]], [["%0", "%2", "%1", "%arg1", "%arg2"]], [["%0", "%2", "%1", "%arg1", "%arg2"]], [["%0", "%2", "%1", "%arg1", "%arg2"]]]]} {
    cf.cond_br %arg0, ^bb2(%arg1 : tensor<5xf32>), ^bb3(%arg2 : tensor<5xf32>) {__inplace_operands_attr__ = ["none", "true", "true"]}
  ^bb1(%0: tensor<5xf32>):  // 2 preds: ^bb2, ^bb3
    return {__inplace_operands_attr__ = ["true"]} %0 : tensor<5xf32>
  ^bb2(%1: tensor<5xf32>):  // pred: ^bb0
    cf.br ^bb1(%1 : tensor<5xf32>) {__inplace_operands_attr__ = ["true"]}
  ^bb3(%2: tensor<5xf32>):  // pred: ^bb0
    cf.br ^bb1(%2 : tensor<5xf32>) {__inplace_operands_attr__ = ["true"]}
  }
}

// -----
module {
  func.func @looping_branches() -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[], [["%5", "%1", "%inserted", "%0"]], [["%5", "%1", "%inserted", "%0"]]]]} {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%5", "%1", "%inserted", "%0"]]} : tensor<5xf32>
    cf.br ^bb1(%0 : tensor<5xf32>) {__inplace_operands_attr__ = ["true"]}
  ^bb1(%1: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %inserted = tensor.insert %3 into %1[%2] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%5", "%1", "%inserted", "%0"]]} : tensor<5xf32>
    %4 = "test.qux"() : () -> i1
    cf.cond_br %4, ^bb1(%inserted : tensor<5xf32>), ^bb2(%inserted : tensor<5xf32>) {__inplace_operands_attr__ = ["none", "true", "true"]}
  ^bb2(%5: tensor<5xf32>):  // pred: ^bb1
    return {__inplace_operands_attr__ = ["true"]} %5 : tensor<5xf32>
  }
}

// -----
module {
  func.func @looping_branches_with_conflict(%arg0: f32) -> tensor<5xf32> attributes {__bbarg_alias_set_attr__ = [[[], [["%2", "%4", "%inserted"]], [["%2", "%4", "%inserted"]]]]} {
    %0 = tensor.empty() {__opresult_alias_set_attr__ = [["%1", "%0"]]} : tensor<5xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    cf.br ^bb2(%1 : tensor<5xf32>) {__inplace_operands_attr__ = ["false"]}
  ^bb1(%2: tensor<5xf32>):  // pred: ^bb2
    %3 = "test.foo"() : () -> index
    %extracted = tensor.extract %1[%3] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    return {__inplace_operands_attr__ = ["true"]} %2 : tensor<5xf32>
  ^bb2(%4: tensor<5xf32>):  // 2 preds: ^bb0, ^bb2
    %5 = "test.foo"() : () -> index
    %6 = "test.bar"() : () -> f32
    %inserted = tensor.insert %6 into %4[%5] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%2", "%4", "%inserted"]]} : tensor<5xf32>
    %7 = "test.qux"() : () -> i1
    cf.cond_br %7, ^bb2(%inserted : tensor<5xf32>), ^bb1(%inserted : tensor<5xf32>) {__inplace_operands_attr__ = ["none", "true", "true"]}
  }
}

// -----
module {
  func.func @looping_branches_outside_def(%arg0: f32) {
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%1", "%0"]]} : tensor<5xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %inserted = tensor.insert %3 into %1[%2] {__inplace_operands_attr__ = ["none", "false", "none"], __opresult_alias_set_attr__ = [["%inserted"]]} : tensor<5xf32>
    %4 = "test.foo"() : () -> index
    %extracted = tensor.extract %inserted[%4] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    %5 = "test.qux"(%extracted) : (f32) -> i1
    cf.cond_br %5, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    return
  }
}

// -----
module {
  func.func @looping_branches_outside_def2(%arg0: f32) attributes {__bbarg_alias_set_attr__ = [[[], [["%2", "%1", "%0"]], []]]} {
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%2", "%1", "%0"]]} : tensor<5xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%2", "%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    cf.br ^bb1(%1 : tensor<5xf32>) {__inplace_operands_attr__ = ["true"]}
  ^bb1(%2: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %3 = "test.foo"() : () -> index
    %4 = "test.bar"() : () -> f32
    %inserted = tensor.insert %4 into %2[%3] {__inplace_operands_attr__ = ["none", "false", "none"], __opresult_alias_set_attr__ = [["%inserted"]]} : tensor<5xf32>
    %5 = "test.foo"() : () -> index
    %extracted = tensor.extract %inserted[%5] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    %6 = "test.qux"(%extracted) : (f32) -> i1
    cf.cond_br %6, ^bb1(%2 : tensor<5xf32>), ^bb2 {__inplace_operands_attr__ = ["none", "true"]}
  ^bb2:  // pred: ^bb1
    return
  }
}

// -----
module {
  func.func @looping_branches_outside_def3(%arg0: f32) attributes {__bbarg_alias_set_attr__ = [[[], [["%2", "%1", "%0"]], []]]} {
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%2", "%1", "%0"]]} : tensor<5xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%2", "%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    cf.br ^bb1(%1 : tensor<5xf32>) {__inplace_operands_attr__ = ["true"]}
  ^bb1(%2: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %3 = "test.foo"() : () -> index
    %4 = "test.bar"() : () -> f32
    %inserted = tensor.insert %4 into %2[%3] {__inplace_operands_attr__ = ["none", "false", "none"], __opresult_alias_set_attr__ = [["%inserted"]]} : tensor<5xf32>
    %5 = "test.foo"() : () -> index
    %extracted = tensor.extract %inserted[%5] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    %6 = "test.qux"(%extracted) : (f32) -> i1
    cf.cond_br %6, ^bb1(%1 : tensor<5xf32>), ^bb2 {__inplace_operands_attr__ = ["none", "true"]}
  ^bb2:  // pred: ^bb1
    return
  }
}

// -----
module {
  func.func @looping_branches_sequence_outside_def(%arg0: f32) {
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%1", "%0"]]} : tensor<5xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %inserted = tensor.insert %3 into %1[%2] {__inplace_operands_attr__ = ["none", "false", "none"], __opresult_alias_set_attr__ = [["%inserted"]]} : tensor<5xf32>
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %4 = "test.foo"() : () -> index
    %extracted = tensor.extract %inserted[%4] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    %5 = "test.qux"(%extracted) : (f32) -> i1
    cf.cond_br %5, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    return
  }
}

// -----
module {
  func.func @looping_branches_sequence_inside_def(%arg0: f32) {
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = bufferization.alloc_tensor() {__opresult_alias_set_attr__ = [["%inserted", "%1", "%0"]]} : tensor<5xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"], __opresult_alias_set_attr__ = [["%inserted", "%1", "%0"]]} ins(%arg0 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    %inserted = tensor.insert %3 into %1[%2] {__inplace_operands_attr__ = ["none", "true", "none"], __opresult_alias_set_attr__ = [["%inserted", "%1", "%0"]]} : tensor<5xf32>
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %4 = "test.foo"() : () -> index
    %extracted = tensor.extract %inserted[%4] {__inplace_operands_attr__ = ["true", "none"]} : tensor<5xf32>
    %5 = "test.qux"(%extracted) : (f32) -> i1
    cf.cond_br %5, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    return
  }
}

