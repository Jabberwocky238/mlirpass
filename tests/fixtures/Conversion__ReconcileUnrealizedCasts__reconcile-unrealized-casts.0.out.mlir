module {
  func.func @unusedCast(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
}

// -----
module {
  func.func @sameTypes(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
}

// -----
module {
  func.func @pair(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
}

// -----
module {
  func.func @symmetricChain(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
}

// -----
module {
  func.func @asymmetricChain(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
}

// -----
module {
  func.func @unusedChain(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
}

// -----
module {
  func.func @bifurcation(%arg0: i64) -> i64 {
    %0 = arith.addi %arg0, %arg0 : i64
    return %0 : i64
  }
}

// -----
module {
  func.func @unusedBifurcation(%arg0: i64) -> i64 {
    %0 = arith.addi %arg0, %arg0 : i64
    return %0 : i64
  }
}

// -----
module {
  func.func @liveSingleCast(%arg0: i64) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : i64 to i32
    return %0 : i32
  }
}

// -----
module {
  func.func @liveChain(%arg0: i64) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : i64 to i1
    %1 = builtin.unrealized_conversion_cast %0 : i1 to i32
    return %1 : i32
  }
}

// -----
module {
  func.func @liveBifurcation(%arg0: i64) -> i64 {
    %0 = builtin.unrealized_conversion_cast %arg0 : i64 to i32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to i1
    %2 = arith.extsi %1 : i1 to i64
    %3 = arith.addi %arg0, %2 : i64
    return %3 : i64
  }
}

// -----
module {
  func.func @deadNToOneCast(%arg0: index, %arg1: index) {
    return
  }
}

// -----
module {
  func.func @swappingOperands(%arg0: index, %arg1: index) -> (index, index) {
    %0:2 = builtin.unrealized_conversion_cast %arg0, %arg1 : index, index to i64, i64
    %1:2 = builtin.unrealized_conversion_cast %0#1, %0#0 : i64, i64 to i32, i32
    %2:2 = builtin.unrealized_conversion_cast %1#0, %1#1 : i32, i32 to index, index
    return %2#0, %2#1 : index, index
  }
}

// -----
module {
  func.func @matchingOperands(%arg0: index, %arg1: index) -> (index, index) {
    return %arg0, %arg1 : index, index
  }
}

// -----
module {
  func.func @emptyCast() -> index {
    %0 = builtin.unrealized_conversion_cast to index
    return %0 : index
  }
}

// -----
module {
  test.graph_region {
    "test.return"() : () -> ()
  }
}

// -----
module {
  test.graph_region {
    %0 = builtin.unrealized_conversion_cast %2 : i32 to i64
    %1 = builtin.unrealized_conversion_cast %0 : i64 to i16
    %2 = builtin.unrealized_conversion_cast %1 : i16 to i32
    "test.user"(%2) : (i32) -> ()
    "test.return"() : () -> ()
  }
}

// -----
module {
  test.graph_region {
    "test.return"() : () -> ()
  }
}

// -----
module {
  test.graph_region {
    %c0_i32 = arith.constant 0 : i32
    %0:2 = builtin.unrealized_conversion_cast %c0_i32, %0#1 : i32, i32 to i32, i32
    "test.user"(%0#0) : (i32) -> ()
    "test.return"() : () -> ()
  }
}

