"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "simple_move"}> ({
  ^bb0(%arg1: f32):
    %2 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> {moved_op} : (f32, f32) -> f32
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
  "func.func"() <{function_type = (f32) -> f32, sym_name = "move_region_dependencies"}> ({
  ^bb0(%arg1: f32):
    %2 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> {moved_op} : (f32, f32) -> f32
    %3 = "before"() : () -> f32
    %4 = "foo"() ({
      %5 = "arith.mulf"(%2, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
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
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "move_in_topological_sort_order"}> ({
  ^bb0(%arg1: f32, %arg2: f32):
    %2 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> {moved_op_1} : (f32, f32) -> f32
    %3 = "arith.mulf"(%2, %2) <{fastmath = #arith.fastmath<none>}> {moved_op_3} : (f32, f32) -> f32
    %4 = "arith.mulf"(%2, %3) <{fastmath = #arith.fastmath<none>}> {moved_op_4} : (f32, f32) -> f32
    %5 = "arith.addf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> {moved_op_2} : (f32, f32) -> f32
    %6 = "arith.mulf"(%5, %5) <{fastmath = #arith.fastmath<none>}> {moved_op_5} : (f32, f32) -> f32
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
  "func.func"() <{function_type = (f32) -> f32, sym_name = "move_region_dependencies"}> ({
  ^bb0(%arg1: f32):
    %2 = "arith.constant"() <{value = true}> : () -> i1
    %3 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> {moved_op_1} : (f32, f32) -> f32
    %4 = "scf.if"(%2) ({
      %7 = "arith.mulf"(%3, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%7) : (f32) -> ()
    }, {
      "scf.yield"(%3) : (f32) -> ()
    }) : (i1) -> f32
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
  "func.func"() <{function_type = () -> f32, sym_name = "ignore_basic_block_arguments"}> ({
    %2 = "test"() : () -> f32
    "func.return"(%2) : (f32) -> ()
  ^bb1(%3: f32):  // no predecessors
    %4 = "arith.constant"() <{value = true}> : () -> i1
    %5 = "scf.if"(%4) ({
      %8 = "arith.addf"(%3, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%8) : (f32) -> ()
    }, {
      "scf.yield"(%3) : (f32) -> ()
    }) : (i1) -> f32
    %6 = "before"() : () -> f32
    %7 = "foo"() ({
      "yield"(%5) : (f32) -> ()
    }) : () -> f32
    "func.return"(%7) : (f32) -> ()
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
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> {before} : () -> f32
    %3 = "arith.addf"(%2, %2) <{fastmath = #arith.fastmath<none>}> {moved_op} : (f32, f32) -> f32
    %4 = "foo"(%3) : (f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {before}}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "do_not_move_slice_region"}> ({
    %2 = "arith.constant"() <{value = true}> : () -> i1
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> {before} : () -> f32
    %4 = "scf.if"(%2) ({
      %6 = "arith.addf"(%3, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%6) : (f32) -> ()
    }, {
      "scf.yield"(%3) : (f32) -> ()
    }) : (i1) -> f32
    %5 = "foo"() ({
      "yield"(%4) : (f32) -> ()
    }) : () -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["foo"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {before}}> : (!transform.any_op) -> !transform.any_op
      "transform.test.move_operand_deps"(%0, %1) : (!transform.any_op, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "do_not_move"}> ({
  ^bb0(%arg1: f32):
    %2 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> {moved_op} : (f32, f32) -> f32
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
  "func.func"() <{function_type = (index, i1) -> index, sym_name = "move_between_blocks_same_region"}> ({
  ^bb0(%arg1: index, %arg2: i1):
    %3 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {to_move} : (index, index) -> index
    %4 = "before"() : () -> index
    "cf.cond_br"(%arg2, %arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, index) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%3)[^bb2] : (index) -> ()
  ^bb2(%5: index):  // 2 preds: ^bb0, ^bb1
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {to_move}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> index, sym_name = "move_chain_out_of_region"}> ({
  ^bb0(%arg1: index, %arg2: i1):
    %3 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {dep1} : (index, index) -> index
    %4 = "arith.muli"(%3, %3) <{overflowFlags = #arith.overflow<none>}> {dep2} : (index, index) -> index
    %5 = "arith.subi"(%4, %arg1) <{overflowFlags = #arith.overflow<none>}> {to_move} : (index, index) -> index
    %6 = "before"() : () -> index
    %7 = "scf.if"(%arg2) ({
      "scf.yield"(%5) : (index) -> ()
    }, {
      "scf.yield"(%arg1) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%7) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {to_move}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<index>) -> index, sym_name = "move_value_defs_side_effecting"}> ({
  ^bb0(%arg1: memref<index>):
    %3 = "before"() : () -> index
    %4 = "memref.load"(%arg1) : (memref<index>) -> index
    %5 = "arith.muli"(%4, %4) <{overflowFlags = #arith.overflow<none>}> {moved_op} : (index, index) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {moved_op}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<index>) -> index, sym_name = "move_op_deps_side_effecting"}> ({
  ^bb0(%arg1: memref<index>):
    %2 = "before"() : () -> index
    %3 = "memref.load"(%arg1) : (memref<index>) -> index
    %4 = "arith.muli"(%3, %3) <{overflowFlags = #arith.overflow<none>}> {moved_op} : (index, index) -> index
    %5 = "foo"(%4) : (index) -> index
    "func.return"(%5) : (index) -> ()
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
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "move_op_using_outer_loop_iv"}> ({
  ^bb0(%arg1: index, %arg2: index, %arg3: index):
    %3 = "scf.for"(%arg1, %arg2, %arg3, %arg1) ({
    ^bb0(%arg4: index, %arg5: index):
      %4 = "arith.addi"(%arg4, %arg4) <{overflowFlags = #arith.overflow<none>}> {to_move} : (index, index) -> index
      %5 = "before"() : () -> index
      "scf.for"(%arg1, %arg2, %arg3) ({
      ^bb0(%arg6: index):
        "use"(%4) : (index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"(%arg5) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {to_move}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1, i1) -> index, sym_name = "move_out_of_doubly_nested_region"}> ({
  ^bb0(%arg1: index, %arg2: i1, %arg3: i1):
    %3 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {to_move} : (index, index) -> index
    %4 = "before"() : () -> index
    %5 = "scf.if"(%arg2) ({
      %6 = "scf.if"(%arg3) ({
        "scf.yield"(%3) : (index) -> ()
      }, {
        "scf.yield"(%arg1) : (index) -> ()
      }) : (i1) -> index
      "scf.yield"(%6) : (index) -> ()
    }, {
      "scf.yield"(%arg1) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {to_move}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> index, sym_name = "move_operand_deps_out_of_region"}> ({
  ^bb0(%arg1: index, %arg2: i1):
    %2 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> {dep} : (index, index) -> index
    %3 = "before"() : () -> index
    %4 = "scf.if"(%arg2) ({
      %5 = "foo"(%2) {target} : (index) -> index
      "scf.yield"(%5) : (index) -> ()
    }, {
      "scf.yield"(%arg1) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%4) : (index) -> ()
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
  "func.func"() <{function_type = (index, index, index, index) -> index, sym_name = "cannot_move_op_using_loop_iv"}> ({
  ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %3 = "before"() : () -> index
    %4 = "scf.for"(%arg2, %arg3, %arg4, %arg1) ({
    ^bb0(%arg5: index, %arg6: index):
      %5 = "arith.addi"(%arg5, %arg5) <{overflowFlags = #arith.overflow<none>}> {to_move} : (index, index) -> index
      %6 = "arith.addi"(%arg6, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%6) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {to_move}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> index, sym_name = "cannot_move_out_of_isolated_region"}> ({
  ^bb0(%arg1: index, %arg2: i1):
    %3 = "before"() : () -> index
    %4 = "test.isolated_one_region_op"(%arg1, %arg2) ({
    ^bb0(%arg3: index, %arg4: i1):
      %5 = "scf.if"(%arg4) ({
        %6 = "arith.addi"(%arg3, %arg3) <{overflowFlags = #arith.overflow<none>}> {to_move} : (index, index) -> index
        "scf.yield"(%6) : (index) -> ()
      }, {
        "scf.yield"(%arg3) : (index) -> ()
      }) : (i1) -> index
      "test.region_yield"(%5) : (index) -> ()
    }) : (index, i1) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["before"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {to_move}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, i1) -> f32, sym_name = "captured_block_arg_does_not_dominate"}> ({
  ^bb0(%arg1: f32, %arg2: i1):
    %3 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> {before} : (f32, f32) -> f32
    "cf.br"(%3)[^bb1] : (f32) -> ()
  ^bb1(%4: f32):  // pred: ^bb0
    %5 = "scf.if"(%arg2) ({
      %7 = "arith.addf"(%4, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%7) : (f32) -> ()
    }, {
      "scf.yield"(%4) : (f32) -> ()
    }) : (i1) -> f32
    %6 = "arith.mulf"(%5, %5) <{fastmath = #arith.fastmath<none>}> {target} : (f32, f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{op_attrs = {before}}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.structured.match"(%arg0) <{op_attrs = {target}}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.get_result"(%1) <{raw_position_list = array<i64: 0>}> : (!transform.any_op) -> !transform.any_value
      "transform.test.move_value_defns"(%2, %0) : (!transform.any_value, !transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

