module {
  func.func @cf_br(%arg0: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%1: i64):  // pred: ^bb0
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    return %2 : index
  }
}

// -----
module {
  func.func @cf_br_type_match(%arg0: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // pred: ^bb0
    return %0 : i64
  }
}

// -----
module {
  func.func @cf_cond_br(%arg0: i1, %arg1: index, %arg2: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    llvm.cond_br %arg0, ^bb1(%1 : i64), ^bb2(%0 : i64)
  ^bb1(%2: i64):  // pred: ^bb0
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    return %3 : index
  ^bb2(%4: i64):  // pred: ^bb0
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    return %5 : index
  }
}

// -----
module {
  func.func @unreachable_block() {
    return
  ^bb1(%0: index):  // pred: ^bb1
    cf.br ^bb1(%0 : index)
  }
}

// -----
module {
  func.func @cf_cond_br_with_weights(%arg0: i1, %arg1: index, %arg2: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    llvm.cond_br %arg0 weights([90, 10]), ^bb1(%1 : i64), ^bb2(%0 : i64)
  ^bb1(%2: i64):  // pred: ^bb0
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    return %3 : index
  ^bb2(%4: i64):  // pred: ^bb0
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    return %5 : index
  }
}

