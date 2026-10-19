module {
  func.func @callee1(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    %1 = arith.addi %0, %arg0 : i32
    %2 = arith.addi %1, %arg0 : i32
    return %2 : i32
  }
  func.func @caller1(%arg0: i32) -> i32 {
    %0 = call @callee1(%arg0) : (i32) -> i32
    return %0 : i32
  }
}

