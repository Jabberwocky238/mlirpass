module {
  func.func @simple_test(%arg0: i16) -> i16 {
    %c5_i16 = arith.constant 5 : i16
    %0 = arith.addi %c5_i16, %arg0 : i16
    return %0 : i16
  }
}

// -----
module {
  func.func @eliminate_from_region(%arg0: index, %arg1: index, %arg2: index) {
    scf.for %arg3 = %arg0 to %arg1 step %arg2 {
      %c5_i16 = arith.constant 5 : i16
      "test.print"(%c5_i16) : (i16) -> ()
    }
    return
  }
}

// -----
module {
  func.func @eliminate_op_with_region(%arg0: index, %arg1: index, %arg2: index) {
    return
  }
}

// -----
module {
  func.func @unstructured_control_flow(%arg0: i16) -> i16 {
    %c5_i16 = arith.constant 5 : i16
    cf.br ^bb2
  ^bb1:  // pred: ^bb2
    cf.br ^bb3
  ^bb2:  // pred: ^bb0
    %0 = arith.addi %c5_i16, %arg0 : i16
    cf.br ^bb1
  ^bb3:  // pred: ^bb1
    return %0 : i16
  }
}

// -----
module {
  func.func @remove_dead_block() {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    return
  }
}

// -----
module {
  func.func @potentially_side_effecting_op() {
    "test.print"() : () -> ()
    return
  }
}

// -----
module {
  func.func @miss_nested_operand_of_erased_op(%arg0: i16, %arg1: i1) {
    cf.br ^bb3
  ^bb1:  // pred: ^bb2
    cf.br ^bb4
  ^bb2:  // pred: ^bb3
    cf.br ^bb1
  ^bb3:  // pred: ^bb0
    cf.br ^bb2
  ^bb4:  // pred: ^bb1
    return
  }
}

// -----
module {
  test.graph_region {
    %0 = "test.baz"() : () -> i32
  }
}

// -----
module {
  test.graph_region attributes {cycle} {
    %0 = arith.addi %1, %1 : i16
    %1 = arith.addi %0, %0 : i16
    %2 = "test.baz"() : () -> i32
  }
}

// -----
module {
  func.func @dead_blocks() {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    return
  }
}

