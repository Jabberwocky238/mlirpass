module {
  func.func @const_test() -> tensor<i32> {
    %cst = arith.constant dense<3> : tensor<i32>
    return %cst : tensor<i32>
  }
}

// -----
module {
  func.func @apply_scale_test_i32(%arg0: i32, %arg1: i32, %arg2: i8) -> i32 {
    %0 = tosa.apply_scale %arg0, %arg1, %arg2 {rounding_mode = DOUBLE_ROUND} : (i32, i32, i8) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @apply_scale_test_vector(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi8>) -> vector<4xi32> {
    %0 = tosa.apply_scale %arg0, %arg1, %arg2 {rounding_mode = DOUBLE_ROUND} : (vector<4xi32>, vector<4xi32>, vector<4xi8>) -> vector<4xi32>
    return %0 : vector<4xi32>
  }
}

// -----
module {
  func.func @apply_scale_test_i48(%arg0: i48, %arg1: i32, %arg2: i8) -> i32 {
    %0 = tosa.apply_scale %arg0, %arg1, %arg2 {rounding_mode = DOUBLE_ROUND} : (i48, i32, i8) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @apply_scale_test_i64(%arg0: i64, %arg1: i32, %arg2: i8) -> i32 {
    %0 = tosa.apply_scale %arg0, %arg1, %arg2 {rounding_mode = DOUBLE_ROUND} : (i64, i32, i8) -> i32
    return %0 : i32
  }
}

