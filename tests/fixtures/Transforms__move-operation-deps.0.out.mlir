module {
  func.func @simple_move(%arg0: f32) -> f32 {
    %0 = arith.addf %arg0, %arg0 {moved_op} : f32
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
  func.func @move_region_dependencies(%arg0: f32) -> f32 {
    %0 = arith.addf %arg0, %arg0 {moved_op} : f32
    %1 = "before"() : () -> f32
    %2 = "foo"() ({
      %3 = arith.mulf %0, %0 : f32
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
  func.func @move_in_topological_sort_order(%arg0: f32, %arg1: f32) -> f32 {
    %0 = arith.addf %arg0, %arg0 {moved_op_1} : f32
    %1 = arith.mulf %0, %0 {moved_op_3} : f32
    %2 = arith.mulf %0, %1 {moved_op_4} : f32
    %3 = arith.addf %arg1, %arg1 {moved_op_2} : f32
    %4 = arith.mulf %3, %3 {moved_op_5} : f32
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
  func.func @move_region_dependencies(%arg0: f32) -> f32 {
    %true = arith.constant true
    %0 = arith.addf %arg0, %arg0 {moved_op_1} : f32
    %1 = scf.if %true -> (f32) {
      %4 = arith.mulf %0, %0 : f32
      scf.yield %4 : f32
    } else {
      scf.yield %0 : f32
    }
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
    %true = arith.constant true
    %2 = scf.if %true -> (f32) {
      %5 = arith.addf %1, %1 : f32
      scf.yield %5 : f32
    } else {
      scf.yield %1 : f32
    }
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
    %cst = arith.constant {before} 1.000000e+00 : f32
    %0 = arith.addf %cst, %cst {moved_op} : f32
    %1 = "foo"(%0) : (f32) -> f32
    return %1 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {before} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @do_not_move_slice_region() -> f32 {
    %true = arith.constant true
    %cst = arith.constant {before} 1.000000e+00 : f32
    %0 = scf.if %true -> (f32) {
      %2 = arith.addf %cst, %cst : f32
      scf.yield %2 : f32
    } else {
      scf.yield %cst : f32
    }
    %1 = "foo"() ({
      "yield"(%0) : (f32) -> ()
    }) : () -> f32
    return %1 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["foo"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {before} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.test.move_operand_deps %0 before %1 : !transform.any_op, !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @do_not_move(%arg0: f32) -> f32 {
    %0 = arith.addf %arg0, %arg0 {moved_op} : f32
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
  func.func @move_between_blocks_same_region(%arg0: index, %arg1: i1) -> index {
    %0 = arith.addi %arg0, %arg0 {to_move} : index
    %1 = "before"() : () -> index
    cf.cond_br %arg1, ^bb1, ^bb2(%arg0 : index)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%0 : index)
  ^bb2(%2: index):  // 2 preds: ^bb0, ^bb1
    return %2 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {to_move} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_chain_out_of_region(%arg0: index, %arg1: i1) -> index {
    %0 = arith.addi %arg0, %arg0 {dep1} : index
    %1 = arith.muli %0, %0 {dep2} : index
    %2 = arith.subi %1, %arg0 {to_move} : index
    %3 = "before"() : () -> index
    %4 = scf.if %arg1 -> (index) {
      scf.yield %2 : index
    } else {
      scf.yield %arg0 : index
    }
    return %4 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {to_move} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_value_defs_side_effecting(%arg0: memref<index>) -> index {
    %0 = "before"() : () -> index
    %1 = memref.load %arg0[] : memref<index>
    %2 = arith.muli %1, %1 {moved_op} : index
    return %2 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {moved_op} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_op_deps_side_effecting(%arg0: memref<index>) -> index {
    %0 = "before"() : () -> index
    %1 = memref.load %arg0[] : memref<index>
    %2 = arith.muli %1, %1 {moved_op} : index
    %3 = "foo"(%2) : (index) -> index
    return %3 : index
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
  func.func @move_op_using_outer_loop_iv(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = scf.for %arg3 = %arg0 to %arg1 step %arg2 iter_args(%arg4 = %arg0) -> (index) {
      %1 = arith.addi %arg3, %arg3 {to_move} : index
      %2 = "before"() : () -> index
      scf.for %arg5 = %arg0 to %arg1 step %arg2 {
        "use"(%1) : (index) -> ()
      }
      scf.yield %arg4 : index
    }
    return %0 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {to_move} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_out_of_doubly_nested_region(%arg0: index, %arg1: i1, %arg2: i1) -> index {
    %0 = arith.addi %arg0, %arg0 {to_move} : index
    %1 = "before"() : () -> index
    %2 = scf.if %arg1 -> (index) {
      %3 = scf.if %arg2 -> (index) {
        scf.yield %0 : index
      } else {
        scf.yield %arg0 : index
      }
      scf.yield %3 : index
    } else {
      scf.yield %arg0 : index
    }
    return %2 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {to_move} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @move_operand_deps_out_of_region(%arg0: index, %arg1: i1) -> index {
    %0 = arith.addi %arg0, %arg0 {dep} : index
    %1 = "before"() : () -> index
    %2 = scf.if %arg1 -> (index) {
      %3 = "foo"(%0) {target} : (index) -> index
      scf.yield %3 : index
    } else {
      scf.yield %arg0 : index
    }
    return %2 : index
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
  func.func @cannot_move_op_using_loop_iv(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> index {
    %0 = "before"() : () -> index
    %1 = scf.for %arg4 = %arg1 to %arg2 step %arg3 iter_args(%arg5 = %arg0) -> (index) {
      %2 = arith.addi %arg4, %arg4 {to_move} : index
      %3 = arith.addi %arg5, %2 : index
      scf.yield %3 : index
    }
    return %1 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {to_move} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @cannot_move_out_of_isolated_region(%arg0: index, %arg1: i1) -> index {
    %0 = "before"() : () -> index
    %1 = test.isolated_one_region_op %arg0, %arg1 {
    ^bb0(%arg2: index, %arg3: i1):
      %2 = scf.if %arg3 -> (index) {
        %3 = arith.addi %arg2, %arg2 {to_move} : index
        scf.yield %3 : index
      } else {
        scf.yield %arg2 : index
      }
      test.region_yield %2 : index
    } : index, i1 -> index
    return %1 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["before"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {to_move} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @captured_block_arg_does_not_dominate(%arg0: f32, %arg1: i1) -> f32 {
    %0 = arith.addf %arg0, %arg0 {before} : f32
    cf.br ^bb1(%0 : f32)
  ^bb1(%1: f32):  // pred: ^bb0
    %2 = scf.if %arg1 -> (f32) {
      %4 = arith.addf %1, %1 : f32
      scf.yield %4 : f32
    } else {
      scf.yield %1 : f32
    }
    %3 = arith.mulf %2, %2 {target} : f32
    return %3 : f32
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match attributes {before} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.structured.match attributes {target} in %arg0 : (!transform.any_op) -> !transform.any_op
      %2 = transform.get_result %1[0] : (!transform.any_op) -> !transform.any_value
      transform.test.move_value_defns %2 before %0 : (!transform.any_value), !transform.any_op
      transform.yield 
    }
  }
}

