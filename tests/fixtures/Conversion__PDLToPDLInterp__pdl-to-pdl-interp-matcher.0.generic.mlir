"builtin.module"() <{sym_name = "empty_module"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg0: !pdl.operation):
    "pdl_interp.finalize"() : () -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
  ^bb0:
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "simple"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg1)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg1)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "attributes"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_attribute"(%arg1) <{name = "attr"}> : (!pdl.operation) -> !pdl.attribute
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.attribute) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_attribute"(%arg1) <{name = "attr1"}> : (!pdl.operation) -> !pdl.attribute
    "pdl_interp.is_not_null"(%1)[^bb5, ^bb1] : (!pdl.attribute) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.check_attribute"(%0)[^bb6, ^bb1] <{constantValue = 10 : i64}> : (!pdl.attribute) -> ()
  ^bb6:  // pred: ^bb5
    %2 = "pdl_interp.get_attribute_type"(%1) : (!pdl.attribute) -> !pdl.type
    "pdl_interp.check_type"(%2)[^bb7, ^bb1] <{type = i64}> : (!pdl.type) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraints"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_operand"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_operand"(%arg1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%1)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_result"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.apply_constraint"(%0, %1, %2)[^bb6, ^bb1] <{isNegated = false, name = "multi_constraint"}> : (!pdl.value, !pdl.value, !pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.is_not_null"(%2)[^bb7, ^bb1] : (!pdl.value) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraint_with_result"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg2)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.apply_constraint"(%arg2)[^bb4, ^bb1] <{isNegated = false, name = "check_op_and_get_attr_constr"}> : (!pdl.operation) -> !pdl.attribute
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg2, %0, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.attribute, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.attribute) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.attribute):
      "pdl_interp.apply_rewrite"(%arg0, %arg1) <{name = "rewriter"}> : (!pdl.operation, !pdl.attribute) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraint_with_unused_result"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.apply_constraint"(%arg1)[^bb4, ^bb1] <{isNegated = false, name = "check_op_and_get_attr_constr"}> : (!pdl.operation) -> !pdl.attribute
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraint_with_result_multiple"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg4: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg4)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg4)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.apply_constraint"(%arg4)[^bb4, ^bb1] <{isNegated = false, name = "check_op_and_get_attr_constr"}> : (!pdl.operation) -> !pdl.attribute
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg4, %0, %arg4)[^bb5] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter_0}> : (!pdl.operation, !pdl.attribute, !pdl.operation) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%arg4, %0, %arg4)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.attribute, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.attribute) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg2: !pdl.operation, %arg3: !pdl.attribute):
      "pdl_interp.apply_rewrite"(%arg2, %arg3) <{name = "rewriter"}> : (!pdl.operation, !pdl.attribute) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.attribute) -> (), sym_name = "pdl_generated_rewriter_0"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.attribute):
      "pdl_interp.apply_rewrite"(%arg0, %arg1) <{name = "rewriter"}> : (!pdl.operation, !pdl.attribute) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "negated_constraint"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.apply_constraint"(%arg1)[^bb4, ^bb1] <{isNegated = true, name = "constraint"}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "inputs"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_operand"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_operand"(%arg1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.are_equal"(%0, %1)[^bb5, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_value_type"(%0) : (!pdl.value) -> !pdl.type
    "pdl_interp.check_type"(%2)[^bb6, ^bb1] <{type = i64}> : (!pdl.type) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_inputs"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{compareAtLeast, count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_operand"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_operands"(%arg1) <{index = 2 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.are_equal"(%0, %1)[^bb5, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_operands"(%arg1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%2)[^bb6, ^bb1] : (!pdl.range<value>) -> ()
  ^bb6:  // pred: ^bb5
    %3 = "pdl_interp.get_value_type"(%2) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.check_types"(%3)[^bb7, ^bb1] <{types = [i64]}> : (!pdl.range<type>) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "single_operand_range"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_result_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %0 = "pdl_interp.get_operands"(%arg1) : (!pdl.operation) -> !pdl.range<value>
    %1 = "pdl_interp.get_value_type"(%0) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.check_types"(%1)[^bb3, ^bb1] <{types = [i64]}> : (!pdl.range<type>) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "results"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_result"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_result"(%arg1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%1)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_value_type"(%0) : (!pdl.value) -> !pdl.type
    "pdl_interp.check_type"(%2)[^bb6, ^bb1] <{type = i32}> : (!pdl.type) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_results"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{compareAtLeast, count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_result"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_results"(%arg1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%1)[^bb5, ^bb1] : (!pdl.range<value>) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_results"(%arg1) <{index = 2 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%2)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    %3 = "pdl_interp.get_value_type"(%1) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.check_types"(%3)[^bb7, ^bb1] <{types = [i64]}> : (!pdl.range<type>) -> ()
  ^bb7:  // pred: ^bb6
    %4 = "pdl_interp.get_value_type"(%0) : (!pdl.value) -> !pdl.type
    %5 = "pdl_interp.get_value_type"(%2) : (!pdl.value) -> !pdl.type
    "pdl_interp.are_equal"(%4, %5)[^bb8, ^bb1] : (!pdl.type, !pdl.type) -> ()
  ^bb8:  // pred: ^bb7
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "single_result_range"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %0 = "pdl_interp.get_results"(%arg1) : (!pdl.operation) -> !pdl.range<value>
    %1 = "pdl_interp.get_value_type"(%0) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.check_types"(%1)[^bb3, ^bb1] <{types = [i64]}> : (!pdl.range<type>) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "results_as_operands"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    %0 = "pdl_interp.get_operand"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.value) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 15 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11, ^bb12, ^bb13, ^bb14, ^bb15
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg1)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_operand"(%arg1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%2)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    %3 = "pdl_interp.get_defining_op"(%2) : (!pdl.value) -> !pdl.operation
    "pdl_interp.is_not_null"(%3)[^bb7, ^bb1] : (!pdl.operation) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.check_operand_count"(%1)[^bb8, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb8:  // pred: ^bb7
    "pdl_interp.check_result_count"(%1)[^bb9, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb9:  // pred: ^bb8
    "pdl_interp.are_equal"(%1, %3)[^bb10, ^bb1] : (!pdl.operation, !pdl.operation) -> ()
  ^bb10:  // pred: ^bb9
    %4 = "pdl_interp.get_result"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%4)[^bb11, ^bb1] : (!pdl.value) -> ()
  ^bb11:  // pred: ^bb10
    %5 = "pdl_interp.get_result"(%1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%5)[^bb12, ^bb1] : (!pdl.value) -> ()
  ^bb12:  // pred: ^bb11
    "pdl_interp.are_equal"(%4, %0)[^bb13, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb13:  // pred: ^bb12
    %6 = "pdl_interp.get_result"(%3) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.are_equal"(%6, %2)[^bb14, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb14:  // pred: ^bb13
    %7 = "pdl_interp.get_value_type"(%4) : (!pdl.value) -> !pdl.type
    "pdl_interp.check_type"(%7)[^bb15, ^bb1] <{type = i32}> : (!pdl.type) -> ()
  ^bb15:  // pred: ^bb14
    "pdl_interp.record_match"(%arg1, %1, %arg1, %3)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 3>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "single_result_range_as_operands"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    %0 = "pdl_interp.get_operands"(%arg1) : (!pdl.operation) -> !pdl.range<value>
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.range<value>) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_operand_count"(%1)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %2 = "pdl_interp.get_results"(%1) : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.are_equal"(%2, %0)[^bb5, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%arg1, %1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 2>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_single_result_type"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg2)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_result"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_value_type"(%0) : (!pdl.value) -> !pdl.type
    "pdl_interp.switch_type"(%1)[^bb1, ^bb5, ^bb6] <{caseValues = [i32, i64]}> : (!pdl.type) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%arg2, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  ^bb6:  // pred: ^bb4
    "pdl_interp.record_match"(%arg2, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter_0}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg1) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter_0"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_result_types"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %0 = "pdl_interp.get_results"(%arg2) : (!pdl.operation) -> !pdl.range<value>
    %1 = "pdl_interp.get_value_type"(%0) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.switch_types"(%1)[^bb1, ^bb3, ^bb4] <{caseValues = [[i32], [i64, i32]]}> : (!pdl.range<type>) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.record_match"(%arg2, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  ^bb4:  // pred: ^bb2
    "pdl_interp.record_match"(%arg2, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter_0}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg1) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter_0"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_operand_count_at_least"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb8, ^bb1] <{compareAtLeast, count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // 4 preds: ^bb8, ^bb9, ^bb10, ^bb11
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{compareAtLeast, count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %0 = "pdl_interp.get_operand"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %1 = "pdl_interp.get_operand"(%arg2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%1)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    %2 = "pdl_interp.get_operands"(%arg2) <{index = 2 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%2)[^bb7, ^bb1] : (!pdl.range<value>) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.record_match"(%arg2, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  ^bb8:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg2)[^bb9, ^bb2] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb9:  // pred: ^bb8
    %3 = "pdl_interp.get_operand"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%3)[^bb10, ^bb2] : (!pdl.value) -> ()
  ^bb10:  // pred: ^bb9
    %4 = "pdl_interp.get_operands"(%arg2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%4)[^bb11, ^bb2] : (!pdl.range<value>) -> ()
  ^bb11:  // pred: ^bb10
    "pdl_interp.record_match"(%arg2, %arg2)[^bb2] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter_0}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg1) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter_0"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_result_count_at_least"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg2)[^bb8, ^bb1] <{compareAtLeast, count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // 3 preds: ^bb8, ^bb9, ^bb10
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{compareAtLeast, count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %0 = "pdl_interp.get_result"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %1 = "pdl_interp.get_result"(%arg2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%1)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    %2 = "pdl_interp.get_results"(%arg2) <{index = 2 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%2)[^bb7, ^bb1] : (!pdl.range<value>) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.record_match"(%arg2, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  ^bb8:  // pred: ^bb2
    %3 = "pdl_interp.get_result"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%3)[^bb9, ^bb3] : (!pdl.value) -> ()
  ^bb9:  // pred: ^bb8
    %4 = "pdl_interp.get_results"(%arg2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%4)[^bb10, ^bb3] : (!pdl.range<value>) -> ()
  ^bb10:  // pred: ^bb9
    "pdl_interp.record_match"(%arg2, %arg2)[^bb3] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter_0}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg1) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter_0"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "predicate_ordering"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg2)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_result"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg2, %arg2)[^bb5] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter_0}> : (!pdl.operation, !pdl.operation) -> ()
  ^bb5:  // pred: ^bb4
    %1 = "pdl_interp.get_value_type"(%0) : (!pdl.value) -> !pdl.type
    "pdl_interp.apply_constraint"(%1)[^bb6, ^bb1] <{isNegated = false, name = "typeConstraint"}> : (!pdl.type) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.record_match"(%arg2, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg1) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter_0"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "multi_root"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    %0 = "pdl_interp.get_operand"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.value) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %2 = "pdl_interp.get_users"(%0) : (!pdl.value) -> !pdl.range<operation>
    "pdl_interp.foreach"(%2)[^bb1] ({
    ^bb0(%arg3: !pdl.operation):
      %3 = "pdl_interp.get_operand"(%arg3) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
      %4 = "pdl_interp.get_defining_op"(%3) : (!pdl.value) -> !pdl.operation
      "pdl_interp.is_not_null"(%4)[^bb2, ^bb1] : (!pdl.operation) -> ()
    ^bb1:  // 21 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11, ^bb12, ^bb13, ^bb14, ^bb15, ^bb16, ^bb17, ^bb18, ^bb19, ^bb20, ^bb21
      "pdl_interp.continue"() : () -> ()
    ^bb2:  // pred: ^bb0
      "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb3:  // pred: ^bb2
      "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
    ^bb4:  // pred: ^bb3
      "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.value) -> ()
    ^bb5:  // pred: ^bb4
      "pdl_interp.is_not_null"(%arg3)[^bb6, ^bb1] : (!pdl.operation) -> ()
    ^bb6:  // pred: ^bb5
      "pdl_interp.check_operand_count"(%1)[^bb7, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb7:  // pred: ^bb6
      "pdl_interp.check_operand_count"(%arg3)[^bb8, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
    ^bb8:  // pred: ^bb7
      "pdl_interp.check_result_count"(%1)[^bb9, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb9:  // pred: ^bb8
      "pdl_interp.check_result_count"(%arg3)[^bb10, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
    ^bb10:  // pred: ^bb9
      %5 = "pdl_interp.get_operand"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.is_not_null"(%5)[^bb11, ^bb1] : (!pdl.value) -> ()
    ^bb11:  // pred: ^bb10
      "pdl_interp.is_not_null"(%3)[^bb12, ^bb1] : (!pdl.value) -> ()
    ^bb12:  // pred: ^bb11
      %6 = "pdl_interp.get_operand"(%arg3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.are_equal"(%6, %0)[^bb13, ^bb1] : (!pdl.value, !pdl.value) -> ()
    ^bb13:  // pred: ^bb12
      %7 = "pdl_interp.get_result"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.is_not_null"(%7)[^bb14, ^bb1] : (!pdl.value) -> ()
    ^bb14:  // pred: ^bb13
      "pdl_interp.are_equal"(%7, %0)[^bb15, ^bb1] : (!pdl.value, !pdl.value) -> ()
    ^bb15:  // pred: ^bb14
      "pdl_interp.check_operand_count"(%4)[^bb16, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb16:  // pred: ^bb15
      "pdl_interp.check_result_count"(%4)[^bb17, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb17:  // pred: ^bb16
      %8 = "pdl_interp.get_operand"(%4) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.is_not_null"(%8)[^bb18, ^bb1] : (!pdl.value) -> ()
    ^bb18:  // pred: ^bb17
      %9 = "pdl_interp.get_result"(%4) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.is_not_null"(%9)[^bb19, ^bb1] : (!pdl.value) -> ()
    ^bb19:  // pred: ^bb18
      "pdl_interp.are_equal"(%9, %3)[^bb20, ^bb1] : (!pdl.value, !pdl.value) -> ()
    ^bb20:  // pred: ^bb19
      %10 = "pdl_interp.get_value_type"(%9) : (!pdl.value) -> !pdl.type
      %11 = "pdl_interp.get_value_type"(%7) : (!pdl.value) -> !pdl.type
      "pdl_interp.are_equal"(%10, %11)[^bb21, ^bb1] : (!pdl.type, !pdl.type) -> ()
    ^bb21:  // pred: ^bb20
      "pdl_interp.record_match"(%arg2, %arg3, %1, %4, %arg2, %arg3)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 4>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation) -> ()
    }) : (!pdl.range<operation>) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0, %arg1) <{name = "rewriter"}> : (!pdl.operation, !pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "overlapping_roots"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    %0 = "pdl_interp.get_operand"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.value) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 11 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg1)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.check_operand_count"(%1)[^bb6, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.check_result_count"(%1)[^bb7, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb7:  // pred: ^bb6
    %2 = "pdl_interp.get_operand"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%2)[^bb8, ^bb1] : (!pdl.value) -> ()
  ^bb8:  // pred: ^bb7
    %3 = "pdl_interp.get_operand"(%1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%3)[^bb9, ^bb1] : (!pdl.value) -> ()
  ^bb9:  // pred: ^bb8
    %4 = "pdl_interp.get_result"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%4)[^bb10, ^bb1] : (!pdl.value) -> ()
  ^bb10:  // pred: ^bb9
    "pdl_interp.are_equal"(%4, %0)[^bb11, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb11:  // pred: ^bb10
    "pdl_interp.record_match"(%arg1, %1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 2>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "force_overlapped_root"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb2, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg2)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_operand"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_operand"(%arg2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%1)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_result"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%2)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    %3 = "pdl_interp.get_users"(%2) : (!pdl.value) -> !pdl.range<operation>
    "pdl_interp.foreach"(%3)[^bb1] ({
    ^bb0(%arg3: !pdl.operation):
      "pdl_interp.is_not_null"(%arg3)[^bb2, ^bb1] : (!pdl.operation) -> ()
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
      "pdl_interp.continue"() : () -> ()
    ^bb2:  // pred: ^bb0
      "pdl_interp.check_operand_count"(%arg3)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb3:  // pred: ^bb2
      "pdl_interp.check_result_count"(%arg3)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
    ^bb4:  // pred: ^bb3
      %4 = "pdl_interp.get_operand"(%arg3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.are_equal"(%4, %2)[^bb5, ^bb1] : (!pdl.value, !pdl.value) -> ()
    ^bb5:  // pred: ^bb4
      "pdl_interp.record_match"(%arg2, %arg3, %arg2, %arg3)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 2>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation) -> ()
    }) : (!pdl.range<operation>) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0, %arg1) <{name = "rewriter"}> : (!pdl.operation, !pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_results_all"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg2)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %0 = "pdl_interp.get_results"(%arg2) : (!pdl.operation) -> !pdl.range<value>
    %1 = "pdl_interp.extract"(%0) <{index = 0 : i32}> : (!pdl.range<value>) -> !pdl.value
    %2 = "pdl_interp.get_users"(%1) : (!pdl.value) -> !pdl.range<operation>
    "pdl_interp.foreach"(%2)[^bb1] ({
    ^bb0(%arg3: !pdl.operation):
      "pdl_interp.is_not_null"(%arg3)[^bb2, ^bb1] : (!pdl.operation) -> ()
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      "pdl_interp.continue"() : () -> ()
    ^bb2:  // pred: ^bb0
      "pdl_interp.check_result_count"(%arg3)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
    ^bb3:  // pred: ^bb2
      %3 = "pdl_interp.get_operands"(%arg3) : (!pdl.operation) -> !pdl.range<value>
      "pdl_interp.are_equal"(%3, %0)[^bb4, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
    ^bb4:  // pred: ^bb3
      "pdl_interp.record_match"(%arg2, %arg3, %arg2, %arg3)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 2>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation) -> ()
    }) : (!pdl.range<operation>) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0, %arg1) <{name = "rewriter"}> : (!pdl.operation, !pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_results_at"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    %0 = "pdl_interp.get_operands"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.range<value>
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.range<value>) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{compareAtLeast, count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.range<value>) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_operands"(%arg2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%2)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    %3 = "pdl_interp.extract"(%0) <{index = 0 : i32}> : (!pdl.range<value>) -> !pdl.value
    %4 = "pdl_interp.get_users"(%3) : (!pdl.value) -> !pdl.range<operation>
    "pdl_interp.foreach"(%4)[^bb1] ({
    ^bb0(%arg3: !pdl.operation):
      "pdl_interp.is_not_null"(%arg3)[^bb2, ^bb1] : (!pdl.operation) -> ()
    ^bb1:  // 11 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11
      "pdl_interp.continue"() : () -> ()
    ^bb2:  // pred: ^bb0
      "pdl_interp.check_operand_count"(%arg3)[^bb3, ^bb1] <{compareAtLeast, count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb3:  // pred: ^bb2
      "pdl_interp.check_operand_count"(%1)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
    ^bb4:  // pred: ^bb3
      "pdl_interp.check_result_count"(%1)[^bb5, ^bb1] <{compareAtLeast, count = 1 : i32}> : (!pdl.operation) -> ()
    ^bb5:  // pred: ^bb4
      "pdl_interp.check_result_count"(%arg3)[^bb6, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
    ^bb6:  // pred: ^bb5
      %5 = "pdl_interp.get_operand"(%arg3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.are_equal"(%5, %2)[^bb7, ^bb1] : (!pdl.value, !pdl.value) -> ()
    ^bb7:  // pred: ^bb6
      %6 = "pdl_interp.get_operands"(%arg3) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
      "pdl_interp.are_equal"(%6, %0)[^bb8, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
    ^bb8:  // pred: ^bb7
      %7 = "pdl_interp.get_results"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.range<value>
      "pdl_interp.is_not_null"(%7)[^bb9, ^bb1] : (!pdl.range<value>) -> ()
    ^bb9:  // pred: ^bb8
      %8 = "pdl_interp.get_results"(%1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.is_not_null"(%8)[^bb10, ^bb1] : (!pdl.value) -> ()
    ^bb10:  // pred: ^bb9
      "pdl_interp.are_equal"(%7, %0)[^bb11, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
    ^bb11:  // pred: ^bb10
      "pdl_interp.record_match"(%arg2, %arg3, %1, %arg2, %arg3)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 3>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation) -> ()
    }) : (!pdl.range<operation>) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0, %arg1) <{name = "rewriter"}> : (!pdl.operation, !pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "attribute_literal"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.create_attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    "pdl_interp.apply_constraint"(%0)[^bb4, ^bb1] <{isNegated = false, name = "constraint"}> : (!pdl.attribute) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "type_literal"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.create_type"() <{value = i32}> : () -> !pdl.type
    %1 = "pdl_interp.create_types"() <{value = [i32, i64]}> : () -> !pdl.range<type>
    "pdl_interp.apply_constraint"(%0, %1)[^bb4, ^bb1] <{isNegated = false, name = "constraint"}> : (!pdl.type, !pdl.range<type>) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0) <{name = "rewriter"}> : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "common_connector"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg3: !pdl.operation):
    %0 = "pdl_interp.get_operand"(%arg3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.value) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 18 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11, ^bb12, ^bb13, ^bb14, ^bb15, ^bb16, ^bb17, ^bb18
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %2 = "pdl_interp.get_operand"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %3 = "pdl_interp.get_defining_op"(%2) : (!pdl.value) -> !pdl.operation
    "pdl_interp.is_not_null"(%3)[^bb3, ^bb1] : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_operand_count"(%arg3)[^bb4, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.check_result_count"(%arg3)[^bb5, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.is_not_null"(%0)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.check_operand_count"(%1)[^bb7, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.check_result_count"(%1)[^bb8, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb8:  // pred: ^bb7
    "pdl_interp.is_not_null"(%2)[^bb9, ^bb1] : (!pdl.value) -> ()
  ^bb9:  // pred: ^bb8
    %4 = "pdl_interp.get_result"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%4)[^bb10, ^bb1] : (!pdl.value) -> ()
  ^bb10:  // pred: ^bb9
    "pdl_interp.are_equal"(%4, %0)[^bb11, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb11:  // pred: ^bb10
    "pdl_interp.check_operand_count"(%3)[^bb12, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb12:  // pred: ^bb11
    "pdl_interp.check_result_count"(%3)[^bb13, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb13:  // pred: ^bb12
    %5 = "pdl_interp.get_result"(%3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%5)[^bb14, ^bb1] : (!pdl.value) -> ()
  ^bb14:  // pred: ^bb13
    %6 = "pdl_interp.get_result"(%3) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%6)[^bb15, ^bb1] : (!pdl.value) -> ()
  ^bb15:  // pred: ^bb14
    "pdl_interp.are_equal"(%6, %2)[^bb16, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb16:  // pred: ^bb15
    %7 = "pdl_interp.get_value_type"(%5) : (!pdl.value) -> !pdl.type
    %8 = "pdl_interp.get_value_type"(%6) : (!pdl.value) -> !pdl.type
    "pdl_interp.are_equal"(%7, %8)[^bb17, ^bb1] : (!pdl.type, !pdl.type) -> ()
  ^bb17:  // pred: ^bb16
    %9 = "pdl_interp.get_value_type"(%4) : (!pdl.value) -> !pdl.type
    "pdl_interp.are_equal"(%7, %9)[^bb18, ^bb1] : (!pdl.type, !pdl.type) -> ()
  ^bb18:  // pred: ^bb17
    %10 = "pdl_interp.get_users"(%5) : (!pdl.value) -> !pdl.range<operation>
    "pdl_interp.foreach"(%10)[^bb1] ({
    ^bb0(%arg4: !pdl.operation):
      "pdl_interp.is_not_null"(%arg4)[^bb2, ^bb1] : (!pdl.operation) -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb2
      "pdl_interp.continue"() : () -> ()
    ^bb2:  // pred: ^bb0
      "pdl_interp.foreach"(%10)[^bb1] ({
      ^bb0(%arg5: !pdl.operation):
        "pdl_interp.is_not_null"(%arg5)[^bb2, ^bb1] : (!pdl.operation) -> ()
      ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8
        "pdl_interp.continue"() : () -> ()
      ^bb2:  // pred: ^bb0
        "pdl_interp.check_operand_count"(%arg4)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
      ^bb3:  // pred: ^bb2
        "pdl_interp.check_operand_count"(%arg5)[^bb4, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
      ^bb4:  // pred: ^bb3
        "pdl_interp.check_result_count"(%arg4)[^bb5, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
      ^bb5:  // pred: ^bb4
        "pdl_interp.check_result_count"(%arg5)[^bb6, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
      ^bb6:  // pred: ^bb5
        %11 = "pdl_interp.get_operand"(%arg4) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
        "pdl_interp.are_equal"(%11, %5)[^bb7, ^bb1] : (!pdl.value, !pdl.value) -> ()
      ^bb7:  // pred: ^bb6
        %12 = "pdl_interp.get_operand"(%arg5) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
        "pdl_interp.are_equal"(%12, %5)[^bb8, ^bb1] : (!pdl.value, !pdl.value) -> ()
      ^bb8:  // pred: ^bb7
        "pdl_interp.record_match"(%arg4, %arg5, %arg3, %1, %3, %arg3, %arg4, %arg5)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 3, 5>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation) -> ()
      }) : (!pdl.range<operation>) -> ()
    }) : (!pdl.range<operation>) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.operation, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.operation, %arg2: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0, %arg1, %arg2) <{name = "rewriter"}> : (!pdl.operation, !pdl.operation, !pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "common_connector_range"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg3: !pdl.operation):
    %0 = "pdl_interp.get_operands"(%arg3) : (!pdl.operation) -> !pdl.range<value>
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.range<value>) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 10 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %2 = "pdl_interp.get_operands"(%1) : (!pdl.operation) -> !pdl.range<value>
    %3 = "pdl_interp.get_defining_op"(%2) : (!pdl.range<value>) -> !pdl.operation
    "pdl_interp.is_not_null"(%3)[^bb3, ^bb1] : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg3)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.is_not_null"(%2)[^bb5, ^bb1] : (!pdl.range<value>) -> ()
  ^bb5:  // pred: ^bb4
    %4 = "pdl_interp.get_results"(%1) : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.are_equal"(%4, %0)[^bb6, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.check_operand_count"(%3)[^bb7, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb7:  // pred: ^bb6
    %5 = "pdl_interp.get_results"(%3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%5)[^bb8, ^bb1] : (!pdl.range<value>) -> ()
  ^bb8:  // pred: ^bb7
    %6 = "pdl_interp.get_results"(%3) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%6)[^bb9, ^bb1] : (!pdl.range<value>) -> ()
  ^bb9:  // pred: ^bb8
    "pdl_interp.are_equal"(%6, %2)[^bb10, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
  ^bb10:  // pred: ^bb9
    %7 = "pdl_interp.extract"(%5) <{index = 0 : i32}> : (!pdl.range<value>) -> !pdl.value
    %8 = "pdl_interp.get_users"(%7) : (!pdl.value) -> !pdl.range<operation>
    "pdl_interp.foreach"(%8)[^bb1] ({
    ^bb0(%arg4: !pdl.operation):
      "pdl_interp.is_not_null"(%arg4)[^bb2, ^bb1] : (!pdl.operation) -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb2
      "pdl_interp.continue"() : () -> ()
    ^bb2:  // pred: ^bb0
      "pdl_interp.foreach"(%8)[^bb1] ({
      ^bb0(%arg5: !pdl.operation):
        "pdl_interp.is_not_null"(%arg5)[^bb2, ^bb1] : (!pdl.operation) -> ()
      ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
        "pdl_interp.continue"() : () -> ()
      ^bb2:  // pred: ^bb0
        "pdl_interp.check_result_count"(%arg4)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
      ^bb3:  // pred: ^bb2
        "pdl_interp.check_result_count"(%arg5)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
      ^bb4:  // pred: ^bb3
        %9 = "pdl_interp.get_operands"(%arg4) : (!pdl.operation) -> !pdl.range<value>
        "pdl_interp.are_equal"(%9, %5)[^bb5, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
      ^bb5:  // pred: ^bb4
        %10 = "pdl_interp.get_operands"(%arg5) : (!pdl.operation) -> !pdl.range<value>
        "pdl_interp.are_equal"(%10, %5)[^bb6, ^bb1] : (!pdl.range<value>, !pdl.range<value>) -> ()
      ^bb6:  // pred: ^bb5
        "pdl_interp.record_match"(%arg4, %arg5, %arg3, %1, %3, %arg3, %arg4, %arg5)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 3, 5>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation, !pdl.operation) -> ()
      }) : (!pdl.range<operation>) -> ()
    }) : (!pdl.range<operation>) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.operation, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.operation, %arg2: !pdl.operation):
      "pdl_interp.apply_rewrite"(%arg0, %arg1, %arg2) <{name = "rewriter"}> : (!pdl.operation, !pdl.operation, !pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

