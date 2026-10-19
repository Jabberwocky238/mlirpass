module {
  func.func @remove_op_with_inner_ops_pattern() {
    return
  }
  func.func @remove_op_with_inner_ops_fold_no_side_effect() {
    return
  }
  func.func @remove_op_with_inner_ops_fold(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @remove_op_with_variadic_results_and_folder(%arg0: i32, %arg1: i32) -> (i32, i32) {
    return %arg0, %arg1 : i32, i32
  }
  func.func @test_commutative_multi(%arg0: i32, %arg1: i32) -> (i32, i32) {
    %c42_i32 = arith.constant 42 : i32
    %c43_i32 = arith.constant 43 : i32
    %0 = "test.op_commutative"(%arg0, %arg1, %c42_i32, %c43_i32) : (i32, i32, i32, i32) -> i32
    %1 = "test.op_commutative"(%arg0, %arg1, %c42_i32, %c43_i32) : (i32, i32, i32, i32) -> i32
    return %0, %1 : i32, i32
  }
  func.func @test_commutative_multi_cst(%arg0: i32, %arg1: i32) -> (i32, i32) {
    %c42_i32 = arith.constant 42 : i32
    %0 = "test.op_commutative"(%arg0, %arg1, %c42_i32, %c42_i32) : (i32, i32, i32, i32) -> i32
    %1 = "test.op_commutative"(%arg0, %arg1, %c42_i32, %c42_i32) : (i32, i32, i32, i32) -> i32
    return %0, %1 : i32, i32
  }
  func.func @test_dialect_canonicalizer() -> i32 {
    %c42_i32 = arith.constant 42 : i32
    return %c42_i32 : i32
  }
  func.func @test_region_simplify(%arg0: i32, %arg1: i1) -> i32 {
    "test.br"(%arg0)[^bb1] : (i32) -> ()
  ^bb1(%0: i32):  // pred: ^bb0
    return %0 : i32
  }
}

