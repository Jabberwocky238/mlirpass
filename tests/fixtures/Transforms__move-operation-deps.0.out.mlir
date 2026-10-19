module {
  func.func @simple_move() -> f32 {
    %0 = "moved_op"() : () -> f32
    %1 = "before"() : () -> f32
    %2 = "foo"(%0) : (f32) -> f32
    return %2 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_region_dependencies() -> f32 {
    %0 = "moved_op"() : () -> f32
    %1 = "before"() : () -> f32
    %2 = "foo"() ({
      %3 = "inner_op"(%0) : (f32) -> f32
      "yield"(%3) : (f32) -> ()
    }) : () -> f32
    return %2 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_in_topological_sort_order() -> f32 {
    %0 = "moved_op_1"() : () -> f32
    %1 = "moved_op_3"(%0) : (f32) -> f32
    %2 = "moved_op_4"(%0, %1) : (f32, f32) -> f32
    %3 = "moved_op_2"() : () -> f32
    %4 = "moved_op_5"(%3) : (f32) -> f32
    %5 = "before"() : () -> f32
    %6 = "foo"(%2, %4) : (f32, f32) -> f32
    return %6 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_region_dependencies() -> f32 {
    %0 = "moved_op_1"() : () -> f32
    %1 = "moved_op_2"() ({
      "yield"(%0) : (f32) -> ()
    }) : () -> f32
    %2 = "before"() : () -> f32
    %3 = "foo"() ({
      "yield"(%1) : (f32) -> ()
    }) : () -> f32
    return %3 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @ignore_basic_block_arguments() -> f32 {
    %0 = "test"() : () -> f32
    return %0 : f32
  ^bb1(%1: f32):  // no predecessors
    %2 = "moved_op"() ({
      "yield"(%1) : (f32) -> ()
    }) : () -> f32
    %3 = "before"() : () -> f32
    %4 = "foo"() ({
      "yield"(%2) : (f32) -> ()
    }) : () -> f32
    return %4 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @do_not_move_slice() -> f32 {
    %0 = "before"() : () -> f32
    %1 = "moved_op"(%0) : (f32) -> f32
    %2 = "foo"(%1) : (f32) -> f32
    return %2 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @do_not_move_slice() -> f32 {
    %0 = "before"() : () -> f32
    %1 = "moved_op"() ({
      "yield"(%0) : (f32) -> ()
    }) : () -> f32
    %2 = "foo"() ({
      "yield"(%1) : (f32) -> ()
    }) : () -> f32
    return %2 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @do_not_move() -> f32 {
    %0 = "moved_op"() : () -> f32
    %1 = "foo"() ({
      "yield"(%0) : (f32) -> ()
    }) : () -> f32
    %2 = "before"() : () -> f32
    return %1 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @simple_move_values(%arg0: index) -> index {
    %c0 = arith.constant 0 : index
    %0 = arith.addi %arg0, %c0 {moved_op_1} : index
    %1 = arith.subi %arg0, %c0 {moved_op_2} : index
    %2 = "before"() : () -> index
    %3 = "foo"(%0, %1) : (index, index) -> index
    return %3 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["arith.addi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["arith.subi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %3 = transform.get_result %0[0] : (!transform.any_op) -> !transform.any_value
      %4 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %3, %4 before %2 : (!transform.any_value, !transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_region_dependencies_values(%arg0: index, %arg1: i1) -> index {
    %0 = arith.addi %arg0, %arg0 {moved_op_1} : index
    %1 = scf.if %arg1 -> (index) {
      %3 = arith.muli %0, %0 {inner_op} : index
      scf.yield %3 : index
    } else {
      scf.yield %0 : index
    }
    %2 = "before"() : () -> index
    return %1 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["scf.if"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %0[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %1 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_values_in_topological_sort_order(%arg0: index, %arg1: index) -> index {
    %0 = arith.addi %arg0, %arg0 {moved_op_1} : index
    %1 = arith.muli %0, %0 {moved_op_3} : index
    %2 = arith.andi %0, %1 {moved_op_4} : index
    %3 = arith.addi %arg1, %arg1 {moved_op_2} : index
    %4 = arith.subi %3, %3 {moved_op_5} : index
    %5 = "before"() : () -> index
    %6 = "foo"(%2, %4) : (index, index) -> index
    return %6 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["arith.andi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["arith.subi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %3 = transform.get_result %0[0] : (!transform.any_op) -> !transform.any_value
      %4 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %3, %4 before %2 : (!transform.any_value, !transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_only_required_defns(%arg0: index) -> (index, index, index, index) {
    %0 = "unmoved_op"() : () -> index
    %1 = "dummy_op"() : () -> index
    %2 = arith.addi %arg0, %arg0 {moved_op} : index
    %3 = "before"() : () -> index
    return %0, %1, %3, %2 : index, index, index, index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["unmoved_op"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["dummy_op"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %3 = transform.structured.match ops{["arith.addi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %4 = transform.get_result %0[0] : (!transform.any_op) -> !transform.any_value
      %5 = transform.get_result %3[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %4, %5 before %2 : (!transform.any_value, !transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_only_required_defns_2(%arg0: index) -> (index, index, index, index) {
    %0 = "unmoved_op"() : () -> index
    %1 = "dummy_op"() : () -> index
    %2 = arith.subi %arg0, %arg0 {moved_op} : index
    %3 = "before"() : () -> index
    return %0, %1, %3, %2 : index, index, index, index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["unmoved_op"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["dummy_op"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %3 = transform.structured.match ops{["arith.subi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %4 = transform.get_result %0[0] : (!transform.any_op) -> !transform.any_value
      %5 = transform.get_result %3[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %4, %5 before %2 : (!transform.any_value, !transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_with_block_arguments() -> (index, index) {
    %0 = "unmoved_op"() : () -> index
    cf.br ^bb1(%0 : index)
  ^bb1(%1: index):  // pred: ^bb0
    %2 = arith.addi %1, %1 {moved_op} : index
    %3 = "before"() : () -> index
    return %3, %2 : index, index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["arith.addi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @no_move_across_basic_blocks() -> (index, index) {
    %0 = "unmoved_op"() : () -> index
    %1 = "before"() : () -> index
    cf.br ^bb1(%0 : index)
  ^bb1(%2: index):  // pred: ^bb0
    %3 = arith.addi %2, %2 {moved_op} : index
    return %1, %3 : index, index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["arith.addi"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_isolated_from_above(%arg0: index) {
    %0 = arith.addi %arg0, %arg0 {moved0} : index
    %1 = arith.muli %0, %0 {moved1} : index
    %2 = "before"() : () -> index
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match ops{["arith.muli"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

