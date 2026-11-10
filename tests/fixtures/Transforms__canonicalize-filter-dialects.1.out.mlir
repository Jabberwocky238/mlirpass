module {
  func.func @pattern_test(%arg0: i32) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %0 = arith.addi %arg0, %c1_i32 : i32
    %1 = arith.subi %0, %c2_i32 : i32
    return %1 : i32
  }
}

