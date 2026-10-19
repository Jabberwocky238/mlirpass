"builtin.module"() ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg1)[^bb2, ^bb1] <{name = "tosa.mul"}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_attribute"(%arg1) <{name = "shift"}> : (!pdl.operation) -> !pdl.attribute
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.attribute) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.create_attribute"() <{value = 0 : i32}> : () -> !pdl.attribute
    %2 = "pdl_interp.create_attribute"() <{value = 1 : i32}> : () -> !pdl.attribute
    %3 = "pdl_interp.apply_constraint"(%1, %2)[^bb5, ^bb1] <{isNegated = false, name = "return_attr_constraint"}> : (!pdl.attribute, !pdl.attribute) -> !pdl.attribute
  ^bb5:  // pred: ^bb4
    "pdl_interp.apply_constraint"(%0, %3)[^bb6, ^bb1] <{isNegated = false, name = "use_attr_constraint"}> : (!pdl.attribute, !pdl.attribute) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "tosa.mul"}> : (!pdl.operation, !pdl.operation) -> ()
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
"builtin.module"() ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    %0 = "pdl_interp.get_operand"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %1 = "pdl_interp.get_defining_op"(%0) : (!pdl.value) -> !pdl.operation
    "pdl_interp.is_not_null"(%1)[^bb2, ^bb1] : (!pdl.operation) -> ()
  ^bb1:  // 11 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_attribute"(%arg2) <{name = "attr"}> : (!pdl.operation) -> !pdl.attribute
    "pdl_interp.is_not_null"(%2)[^bb6, ^bb1] : (!pdl.attribute) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.check_operand_count"(%1)[^bb7, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb7:  // pred: ^bb6
    "pdl_interp.check_result_count"(%1)[^bb8, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb8:  // pred: ^bb7
    %3 = "pdl_interp.apply_constraint"(%1)[^bb9, ^bb1] <{isNegated = false, name = "return_attr_constraint"}> : (!pdl.operation) -> !pdl.attribute
  ^bb9:  // pred: ^bb8
    %4 = "pdl_interp.get_result"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.are_equal"(%4, %0)[^bb10, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb10:  // pred: ^bb9
    "pdl_interp.are_equal"(%2, %3)[^bb11, ^bb1] : (!pdl.attribute, !pdl.attribute) -> ()
  ^bb11:  // pred: ^bb10
    "pdl_interp.record_match"(%arg2, %2, %1, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 2>, rewriter = @rewriters::@pdl_generated_rewriter}> : (!pdl.operation, !pdl.attribute, !pdl.operation, !pdl.operation) -> ()
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
"builtin.module"() ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.create_attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    %1 = "pdl_interp.apply_constraint"(%0)[^bb4, ^bb1] <{isNegated = false, name = "return_value_constr"}> : (!pdl.attribute) -> !pdl.value
  ^bb4:  // pred: ^bb3
    %2 = "pdl_interp.get_operand"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.are_equal"(%2, %1)[^bb5, ^bb1] : (!pdl.value, !pdl.value) -> ()
  ^bb5:  // pred: ^bb4
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
"builtin.module"() ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_result_count"(%arg1)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %0 = "pdl_interp.get_result"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb4, ^bb1] : (!pdl.value) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.create_attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    %2 = "pdl_interp.apply_constraint"(%1)[^bb5, ^bb1] <{isNegated = false, name = "return_type_constr"}> : (!pdl.attribute) -> !pdl.type
  ^bb5:  // pred: ^bb4
    %3 = "pdl_interp.get_value_type"(%0) : (!pdl.value) -> !pdl.type
    "pdl_interp.are_equal"(%3, %2)[^bb6, ^bb1] : (!pdl.type, !pdl.type) -> ()
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
"builtin.module"() ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operand_count"(%arg1)[^bb2, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    %0 = "pdl_interp.create_attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    %1 = "pdl_interp.apply_constraint"(%0)[^bb3, ^bb1] <{isNegated = false, name = "return_type_range_constr"}> : (!pdl.attribute) -> !pdl.range<type>
  ^bb3:  // pred: ^bb2
    %2 = "pdl_interp.get_results"(%arg1) : (!pdl.operation) -> !pdl.range<value>
    %3 = "pdl_interp.get_value_type"(%2) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.are_equal"(%3, %1)[^bb4, ^bb1] : (!pdl.range<type>, !pdl.range<type>) -> ()
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

