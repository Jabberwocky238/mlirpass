"builtin.module"() ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg0: !pdl.operation):
    "pdl_interp.finalize"() : () -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
  ^bb0:
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "external"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg2)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %0 = "pdl_interp.get_operand"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%0)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%arg2, %0, %arg2)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation, !pdl.value, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation, !pdl.value) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation, %arg1: !pdl.value):
      "pdl_interp.apply_rewrite"(%arg0, %arg1) <{name = "rewriter"}> : (!pdl.operation, !pdl.value) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "erase"}> ({
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
      "pdl_interp.erase"(%arg0) : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_attributes"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg2)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %2 = "pdl_interp.get_attribute"(%arg2) <{name = "attr"}> : (!pdl.operation) -> !pdl.attribute
    "pdl_interp.is_not_null"(%2)[^bb5, ^bb1] : (!pdl.attribute) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%2, %arg2, %arg2)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.attribute, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.attribute, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.attribute, %arg1: !pdl.operation):
      %0 = "pdl_interp.create_attribute"() <{value = true}> : () -> !pdl.attribute
      %1 = "pdl_interp.create_operation"(%arg0, %0) <{inputAttributeNames = ["attr", "attr1"], name = "foo.op", operandSegmentSizes = array<i32: 0, 2, 0>}> : (!pdl.attribute, !pdl.attribute) -> !pdl.operation
      "pdl_interp.erase"(%arg1) : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_operands"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg2)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %4 = "pdl_interp.get_operand"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%4)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%4, %arg2, %arg2)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op", "foo.op2"], operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.value, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.value, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.value, %arg1: !pdl.operation):
      %0 = "pdl_interp.create_type"() <{value = i32}> : () -> !pdl.type
      %1 = "pdl_interp.create_operation"(%arg0, %0) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 1, 0, 1>}> : (!pdl.value, !pdl.type) -> !pdl.operation
      %2 = "pdl_interp.get_result"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      %3 = "pdl_interp.create_operation"(%2) <{inputAttributeNames = [], name = "foo.op2", operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
      "pdl_interp.erase"(%arg1) : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_replaceop"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg1)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg1)[^bb4, ^bb1] <{count = 2 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %4 = "pdl_interp.get_result"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%4)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %5 = "pdl_interp.get_result"(%arg1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%5)[^bb6, ^bb1] : (!pdl.value) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      %0 = "pdl_interp.get_results"(%arg0) : (!pdl.operation) -> !pdl.range<value>
      %1 = "pdl_interp.get_value_type"(%0) : (!pdl.range<value>) -> !pdl.range<type>
      %2 = "pdl_interp.create_operation"(%1) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
      %3 = "pdl_interp.get_results"(%2) : (!pdl.operation) -> !pdl.range<value>
      "pdl_interp.replace"(%arg0, %3) : (!pdl.operation, !pdl.range<value>) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_otherop_individual_results"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg2)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg2)[^bb4, ^bb1] <{compareAtLeast, count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %1 = "pdl_interp.get_result"(%arg2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%1)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %2 = "pdl_interp.get_results"(%arg2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
    "pdl_interp.is_not_null"(%2)[^bb6, ^bb1] : (!pdl.range<value>) -> ()
  ^bb6:  // pred: ^bb5
    %3 = "pdl_interp.get_value_type"(%1) : (!pdl.value) -> !pdl.type
    %4 = "pdl_interp.get_value_type"(%2) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.record_match"(%3, %4, %arg2)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.type, !pdl.range<type>, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.type, !pdl.range<type>) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.type, %arg1: !pdl.range<type>):
      %0 = "pdl_interp.create_operation"(%arg0, %arg1) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.range<type>) -> !pdl.operation
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_otherop_results"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg1)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %1 = "pdl_interp.get_results"(%arg1) : (!pdl.operation) -> !pdl.range<value>
    %2 = "pdl_interp.get_value_type"(%1) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.record_match"(%2, %arg1)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.range<type>, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.range<type>) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.range<type>):
      %0 = "pdl_interp.create_operation"(%arg0) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_interface"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg0: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg0)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg0)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg0)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg0)[^bb1] <{benefit = 1 : i16, generatedOps = ["arith.constant", "foo.op"], operandSegmentSizes = array<i32: 0, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = () -> (), sym_name = "pdl_generated_rewriter"}> ({
      %1 = "pdl_interp.create_operation"() <{inferredResultTypes, inputAttributeNames = [], name = "arith.constant", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
      %2 = "pdl_interp.get_results"(%1) : (!pdl.operation) -> !pdl.range<value>
      %3 = "pdl_interp.get_value_type"(%2) : (!pdl.range<value>) -> !pdl.range<type>
      %4 = "pdl_interp.create_operation"(%3) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  %0 = "arith.constant"() <{value = true}> : () -> i1
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "replace_with_op"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg1)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg1)[^bb4, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %3 = "pdl_interp.get_result"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%3)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    %4 = "pdl_interp.get_value_type"(%3) : (!pdl.value) -> !pdl.type
    "pdl_interp.check_type"(%4)[^bb6, ^bb1] <{type = i32}> : (!pdl.type) -> ()
  ^bb6:  // pred: ^bb5
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      %0 = "pdl_interp.create_type"() <{value = i32}> : () -> !pdl.type
      %1 = "pdl_interp.create_operation"(%0) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
      %2 = "pdl_interp.get_results"(%1) : (!pdl.operation) -> !pdl.range<value>
      "pdl_interp.replace"(%arg0, %2) : (!pdl.operation, !pdl.range<value>) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "replace_with_values"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg2: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg2)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg2)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    %4 = "pdl_interp.get_results"(%arg2) : (!pdl.operation) -> !pdl.range<value>
    %5 = "pdl_interp.get_value_type"(%4) : (!pdl.range<value>) -> !pdl.range<type>
    "pdl_interp.record_match"(%5, %arg2, %arg2)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 2, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.range<type>, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.range<type>, !pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.range<type>, %arg1: !pdl.operation):
      %0 = "pdl_interp.create_operation"(%arg0) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
      %1 = "pdl_interp.get_result"(%0) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      %2 = "pdl_interp.get_results"(%0) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
      %3 = "pdl_interp.get_results"(%0) <{index = 2 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl_interp.replace"(%arg1, %1, %2, %3) : (!pdl.operation, !pdl.value, !pdl.range<value>, !pdl.value) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "replace_with_no_results"}> ({
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
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      %0 = "pdl_interp.get_results"(%arg0) : (!pdl.operation) -> !pdl.range<value>
      %1 = "pdl_interp.get_value_type"(%0) : (!pdl.range<value>) -> !pdl.range<type>
      %2 = "pdl_interp.create_operation"(%1) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
      "pdl_interp.erase"(%arg0) : (!pdl.operation) -> ()
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "apply_native_rewrite"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg1)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg1)[^bb4, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %2 = "pdl_interp.get_result"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%2)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%arg1, %arg1)[^bb1] <{benefit = 1 : i16, generatedOps = ["foo.op"], operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.operation):
      %0 = "pdl_interp.apply_rewrite"(%arg0) <{name = "functor"}> : (!pdl.operation) -> !pdl.type
      %1 = "pdl_interp.create_operation"(%0) <{inputAttributeNames = [], name = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "unbound_rewrite_op"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg0: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg0)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg0)[^bb3, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg0)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    "pdl_interp.record_match"(%arg0)[^bb1] <{benefit = 1 : i16, generatedOps = ["bar.op"], operandSegmentSizes = array<i32: 0, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = () -> (), sym_name = "pdl_generated_rewriter"}> ({
      %0 = "pdl_interp.create_operation"() <{inputAttributeNames = [], name = "bar.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "range_op"}> ({
  "pdl_interp.func"() <{function_type = (!pdl.operation) -> (), sym_name = "matcher"}> ({
  ^bb0(%arg1: !pdl.operation):
    "pdl_interp.check_operation_name"(%arg1)[^bb2, ^bb1] <{name = "foo.op"}> : (!pdl.operation) -> ()
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    "pdl_interp.finalize"() : () -> ()
  ^bb2:  // pred: ^bb0
    "pdl_interp.check_operand_count"(%arg1)[^bb3, ^bb1] <{count = 1 : i32}> : (!pdl.operation) -> ()
  ^bb3:  // pred: ^bb2
    "pdl_interp.check_result_count"(%arg1)[^bb4, ^bb1] <{count = 0 : i32}> : (!pdl.operation) -> ()
  ^bb4:  // pred: ^bb3
    %2 = "pdl_interp.get_operand"(%arg1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl_interp.is_not_null"(%2)[^bb5, ^bb1] : (!pdl.value) -> ()
  ^bb5:  // pred: ^bb4
    "pdl_interp.record_match"(%2, %arg1)[^bb1] <{benefit = 1 : i16, operandSegmentSizes = array<i32: 1, 1>, rewriter = @rewriters::@pdl_generated_rewriter, rootKind = "foo.op"}> : (!pdl.value, !pdl.operation) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "rewriters"}> ({
    "pdl_interp.func"() <{function_type = (!pdl.value) -> (), sym_name = "pdl_generated_rewriter"}> ({
    ^bb0(%arg0: !pdl.value):
      %0 = "pdl_interp.create_range"() : () -> !pdl.range<value>
      %1 = "pdl_interp.create_range"(%arg0, %0) : (!pdl.value, !pdl.range<value>) -> !pdl.range<value>
      "pdl_interp.finalize"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

