module {
  func.func @dup_subs(%arg0: i32, %arg1: i32) -> i32 {
    %0 = arith.subi %arg0, %arg1 : i32
    %1 = arith.subi %arg0, %arg1 : i32
    %2 = arith.subi %0, %1 : i32
    return %2 : i32
  }
}

// -----
module {
  func.func @cascade(%arg0: i32, %arg1: i32) -> i32 {
    %0 = arith.subi %arg0, %arg1 : i32
    %1 = arith.subi %arg0, %arg1 : i32
    %2 = arith.subi %0, %1 : i32
    %3 = arith.addi %2, %arg1 : i32
    return %3 : i32
  }
}

// -----
module {
  func.func @nested(%arg0: index, %arg1: index, %arg2: index, %arg3: i32, %arg4: i32, %arg5: i32) -> i32 {
    %0 = scf.for %arg6 = %arg0 to %arg1 step %arg2 iter_args(%arg7 = %arg5) -> (i32) {
      %1 = arith.subi %arg3, %arg4 : i32
      %2 = arith.subi %arg3, %arg4 : i32
      %3 = arith.subi %1, %2 : i32
      %4 = arith.index_cast %arg6 : index to i32
      %5 = arith.addi %arg7, %4 : i32
      %6 = arith.addi %5, %3 : i32
      scf.yield %6 : i32
    }
    return %0 : i32
  }
}

