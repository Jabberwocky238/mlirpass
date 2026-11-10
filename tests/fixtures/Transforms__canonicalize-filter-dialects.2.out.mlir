module {
  func.func @pattern_test(%arg0: i32) -> i32 {
    %c-1_i32 = arith.constant -1 : i32
    %0 = arith.addi %arg0, %c-1_i32 : i32
    return %0 : i32
  }
}

