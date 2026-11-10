module {
  func.func @dup_subs(%arg0: i32, %arg1: i32) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}

// -----
module {
  func.func @cascade(%arg0: i32, %arg1: i32) -> i32 {
    return %arg1 : i32
  }
}

// -----
module {
  func.func @nested(%arg0: index, %arg1: index, %arg2: index, %arg3: i32, %arg4: i32, %arg5: i32) -> i32 {
    %0 = scf.for %arg6 = %arg0 to %arg1 step %arg2 iter_args(%arg7 = %arg5) -> (i32) {
      %1 = arith.index_cast %arg6 : index to i32
      %2 = arith.addi %arg7, %1 : i32
      scf.yield %2 : i32
    }
    return %0 : i32
  }
}

