"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "simple_move"}> ({
    %2 = "moved_op"() : () -> f32
    %3 = "before"() : () -> f32
    %4 = "foo"(%2) : (f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "move_region_dependencies"}> ({
    %2 = "moved_op"() : () -> f32
    %3 = "before"() : () -> f32
    %4 = "foo"() ({
      %5 = "inner_op"(%2) : (f32) -> f32
      "yield"(%5) : (f32) -> ()
    }) : () -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "move_in_topological_sort_order"}> ({
    %2 = "moved_op_1"() : () -> f32
    %3 = "moved_op_3"(%2) : (f32) -> f32
    %4 = "moved_op_4"(%2, %3) : (f32, f32) -> f32
    %5 = "moved_op_2"() : () -> f32
    %6 = "moved_op_5"(%5) : (f32) -> f32
    %7 = "before"() : () -> f32
    %8 = "foo"(%4, %6) : (f32, f32) -> f32
    "func.return"(%8) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "move_region_dependencies"}> ({
    %2 = "moved_op_1"() : () -> f32
    %3 = "moved_op_2"() ({
      "yield"(%2) : (f32) -> ()
    }) : () -> f32
    %4 = "before"() : () -> f32
    %5 = "foo"() ({
      "yield"(%3) : (f32) -> ()
    }) : () -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "ignore_basic_block_arguments"}> ({
    %2 = "test"() : () -> f32
    "func.return"(%2) : (f32) -> ()
  ^bb1(%3: f32):  // no predecessors
    %4 = "moved_op"() ({
      "yield"(%3) : (f32) -> ()
    }) : () -> f32
    %5 = "before"() : () -> f32
    %6 = "foo"() ({
      "yield"(%4) : (f32) -> ()
    }) : () -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "do_not_move_slice"}> ({
    %2 = "before"() : () -> f32
    %3 = "moved_op"(%2) : (f32) -> f32
    %4 = "foo"(%3) : (f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "do_not_move_slice"}> ({
    %2 = "before"() : () -> f32
    %3 = "moved_op"() ({
      "yield"(%2) : (f32) -> ()
    }) : () -> f32
    %4 = "foo"() ({
      "yield"(%3) : (f32) -> ()
    }) : () -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "do_not_move"}> ({
    %2 = "moved_op"() : () -> f32
    %3 = "foo"() ({
      "yield"(%2) : (f32) -> ()
    }) : () -> f32
    %4 = "before"() : () -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "simple_move_values"}> ({
  ^bb0(%arg1: index):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.addi"(%arg1, %5) <{overflowFlags = #arith.overflow<none>}> {moved_op_1} : (index, index) -> index
    %7 = "arith.subi"(%arg1, %5) <{overflowFlags = #arith.overflow<none>}> {moved_op_2} : (index, index) -> index
    %8 = "before"() : () -> index
    %9 = "foo"(%6, %7) : (index, index) -> index
    "func.return"(%9) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["arith.addi"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["arith.subi"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %3 = "transform.get_result"(%0) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      %4 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%3, %4, %2) : (!transform.any_value, !transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> index, sym_name = "move_region_dependencies_values"}> ({
  ^bb0(%arg1: index, %arg2: i1):
    %3 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {moved_op_1} : (index, index) -> index
    %4 = "scf.if"(%arg2) ({
      %6 = "arith.muli"(%3, %3) <{overflowFlags = #arith.overflow<none>}> {inner_op} : (index, index) -> index
      "scf.yield"(%6) : (index) -> ()
    }, {
      "scf.yield"(%3) : (index) -> ()
    }) : (i1) -> index
    %5 = "before"() : () -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["scf.if"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%0) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %1) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "move_values_in_topological_sort_order"}> ({
  ^bb0(%arg1: index, %arg2: index):
    %5 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {moved_op_1} : (index, index) -> index
    %6 = "arith.muli"(%5, %5) <{overflowFlags = #arith.overflow<none>}> {moved_op_3} : (index, index) -> index
    %7 = "arith.andi"(%5, %6) {moved_op_4} : (index, index) -> index
    %8 = "arith.addi"(%arg2, %arg2) <{overflowFlags = #arith.overflow<none>}> {moved_op_2} : (index, index) -> index
    %9 = "arith.subi"(%8, %8) <{overflowFlags = #arith.overflow<none>}> {moved_op_5} : (index, index) -> index
    %10 = "before"() : () -> index
    %11 = "foo"(%7, %9) : (index, index) -> index
    "func.return"(%11) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["arith.andi"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["arith.subi"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %3 = "transform.get_result"(%0) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      %4 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%3, %4, %2) : (!transform.any_value, !transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index, index, index), sym_name = "move_only_required_defns"}> ({
  ^bb0(%arg1: index):
    %6 = "unmoved_op"() : () -> index
    %7 = "dummy_op"() : () -> index
    %8 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {moved_op} : (index, index) -> index
    %9 = "before"() : () -> index
    "func.return"(%6, %7, %9, %8) : (index, index, index, index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["unmoved_op"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["dummy_op"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %3 = "transform.structured.match"(%arg0) <{ops = ["arith.addi"]}> : (!transform.any_op) -> !transform.any_op
      %4 = "transform.get_result"(%0) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      %5 = "transform.get_result"(%3) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%4, %5, %2) : (!transform.any_value, !transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index, index, index), sym_name = "move_only_required_defns_2"}> ({
  ^bb0(%arg1: index):
    %6 = "unmoved_op"() : () -> index
    %7 = "dummy_op"() : () -> index
    %8 = "arith.subi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {moved_op} : (index, index) -> index
    %9 = "before"() : () -> index
    "func.return"(%6, %7, %9, %8) : (index, index, index, index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["unmoved_op"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["dummy_op"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %3 = "transform.structured.match"(%arg0) <{ops = ["arith.subi"]}> : (!transform.any_op) -> !transform.any_op
      %4 = "transform.get_result"(%0) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      %5 = "transform.get_result"(%3) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%4, %5, %2) : (!transform.any_value, !transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "move_with_block_arguments"}> ({
    %3 = "unmoved_op"() : () -> index
    "cf.br"(%3)[^bb1] : (index) -> ()
  ^bb1(%4: index):  // pred: ^bb0
    %5 = "arith.addi"(%4, %4) <{overflowFlags = #arith.overflow<none>}> {moved_op} : (index, index) -> index
    %6 = "before"() : () -> index
    "func.return"(%6, %5) : (index, index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["arith.addi"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "no_move_across_basic_blocks"}> ({
    %3 = "unmoved_op"() : () -> index
    %4 = "before"() : () -> index
    "cf.br"(%3)[^bb1] : (index) -> ()
  ^bb1(%5: index):  // pred: ^bb0
    %6 = "arith.addi"(%5, %5) <{overflowFlags = #arith.overflow<none>}> {moved_op} : (index, index) -> index
    "func.return"(%4, %6) : (index, index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["arith.addi"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "move_isolated_from_above"}> ({
  ^bb0(%arg1: index):
    %3 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {moved0} : (index, index) -> index
    %4 = "arith.muli"(%3, %3) <{overflowFlags = #arith.overflow<none>}> {moved1} : (index, index) -> index
    %5 = "before"() : () -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{ops = ["arith.muli"]}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

