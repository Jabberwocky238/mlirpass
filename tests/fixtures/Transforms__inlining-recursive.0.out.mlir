module {
  func.func @foo0(%arg0: i32) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.cmpi eq, %arg0, %c0_i32 : i32
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %c0_i32 : i32
  ^bb2:  // pred: ^bb0
    %1 = call @foo1(%arg0) : (i32) -> i32
    return %1 : i32
  }
  func.func @foo1(%arg0: i32) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.subi %arg0, %c1_i32 : i32
    %1 = call @foo0(%0) : (i32) -> i32
    return %1 : i32
  }
}

