module {
  func.func @single_case(%arg0: i32, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    llvm.switch %arg0 : i32, ^bb1(%0 : i64) [
    ]
  ^bb1(%1: i64):  // pred: ^bb0
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    return %2 : index
  }
}

// -----
module {
  func.func @single_case_type_match(%arg0: i32, %arg1: i64) -> i64 {
    llvm.switch %arg0 : i32, ^bb1(%arg1 : i64) [
    ]
  ^bb1(%0: i64):  // pred: ^bb0
    return %0 : i64
  }
}

// -----
module {
  func.func @multi_case(%arg0: i32, %arg1: index, %arg2: index, %arg3: i64) -> index {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    llvm.switch %arg0 : i32, ^bb1(%1 : i64) [
      12: ^bb2(%0 : i64),
      13: ^bb1(%1 : i64),
      14: ^bb3(%arg3 : i64)
    ]
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb0
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    return %3 : index
  ^bb2(%4: i64):  // pred: ^bb0
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    return %5 : index
  ^bb3(%6: i64):  // pred: ^bb0
    %7 = arith.index_cast %6 : i64 to index
    return %7 : index
  }
}

