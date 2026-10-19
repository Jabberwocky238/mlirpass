"builtin.module"() <{sym_name = "empty_module"}> ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "simple"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%0) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "attributes"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() <{constantType = i64}> : () -> !pdl.type
    %1 = "pdl.attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    %2 = "pdl.attribute"(%0) : (!pdl.type) -> !pdl.attribute
    %3 = "pdl.operation"(%1, %2) <{attributeValueNames = ["attr", "attr1"], operandSegmentSizes = array<i32: 0, 2, 0>}> : (!pdl.attribute, !pdl.attribute) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraints"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operand"() : () -> !pdl.value
    %2 = "pdl.operation"(%0, %1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 0>}> : (!pdl.value, !pdl.value) -> !pdl.operation
    %3 = "pdl.result"(%2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    "pdl.apply_native_constraint"(%0, %1, %3) <{isNegated = false, name = "multi_constraint"}> : (!pdl.value, !pdl.value, !pdl.value) -> ()
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraint_with_result"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    %1 = "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "check_op_and_get_attr_constr"}> : (!pdl.operation) -> !pdl.attribute
    "pdl.rewrite"(%0, %1) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.attribute) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraint_with_unused_result"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    %1 = "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "check_op_and_get_attr_constr"}> : (!pdl.operation) -> !pdl.attribute
    "pdl.rewrite"(%0) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "constraint_with_result_multiple"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %2 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    %3 = "pdl.apply_native_constraint"(%2) <{isNegated = false, name = "check_op_and_get_attr_constr"}> : (!pdl.operation) -> !pdl.attribute
    "pdl.rewrite"(%2, %3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.attribute) -> ()
  }) : () -> ()
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    %1 = "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "check_op_and_get_attr_constr"}> : (!pdl.operation) -> !pdl.attribute
    "pdl.rewrite"(%0, %1) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.attribute) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "negated_constraint"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.apply_native_constraint"(%0) <{isNegated = true, name = "constraint"}> : (!pdl.operation) -> ()
    "pdl.rewrite"(%0) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "inputs"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() <{constantType = i64}> : () -> !pdl.type
    %1 = "pdl.operand"(%0) : (!pdl.type) -> !pdl.value
    %2 = "pdl.operation"(%1, %1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 0>}> : (!pdl.value, !pdl.value) -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_inputs"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() <{constantTypes = [i64]}> : () -> !pdl.range<type>
    %1 = "pdl.operands"(%0) : (!pdl.range<type>) -> !pdl.range<value>
    %2 = "pdl.operand"() : () -> !pdl.value
    %3 = "pdl.operation"(%2, %1, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 3, 0, 0>}> : (!pdl.value, !pdl.range<value>, !pdl.value) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "single_operand_range"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() <{constantTypes = [i64]}> : () -> !pdl.range<type>
    %1 = "pdl.operands"(%0) : (!pdl.range<type>) -> !pdl.range<value>
    %2 = "pdl.operation"(%1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.range<value>) -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "results"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() <{constantType = i32}> : () -> !pdl.type
    %1 = "pdl.type"() : () -> !pdl.type
    %2 = "pdl.operation"(%0, %1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.type) -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_results"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() <{constantTypes = [i64]}> : () -> !pdl.range<type>
    %1 = "pdl.type"() : () -> !pdl.type
    %2 = "pdl.operation"(%1, %0, %1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 3>}> : (!pdl.type, !pdl.range<type>, !pdl.type) -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "single_result_range"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() <{constantTypes = [i64]}> : () -> !pdl.range<type>
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%1) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "results_as_operands"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() <{constantType = i32}> : () -> !pdl.type
    %1 = "pdl.type"() : () -> !pdl.type
    %2 = "pdl.operation"(%0, %1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.type) -> !pdl.operation
    %3 = "pdl.result"(%2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %4 = "pdl.result"(%2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    %5 = "pdl.operation"(%3, %4) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 0>}> : (!pdl.value, !pdl.value) -> !pdl.operation
    "pdl.rewrite"(%5) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "single_result_range_as_operands"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() : () -> !pdl.range<type>
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    %2 = "pdl.results"(%1) : (!pdl.operation) -> !pdl.range<value>
    %3 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.range<value>) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_single_result_type"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %2 = "pdl.type"() <{constantType = i32}> : () -> !pdl.type
    %3 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() <{constantType = i64}> : () -> !pdl.type
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    "pdl.rewrite"(%1) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_result_types"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %2 = "pdl.types"() <{constantTypes = [i32]}> : () -> !pdl.range<type>
    %3 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() <{constantTypes = [i64, i32]}> : () -> !pdl.range<type>
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%1) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_operand_count_at_least"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %4 = "pdl.operand"() : () -> !pdl.value
    %5 = "pdl.operands"() : () -> !pdl.range<value>
    %6 = "pdl.operation"(%4, %5) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 0>}> : (!pdl.value, !pdl.range<value>) -> !pdl.operation
    "pdl.rewrite"(%6) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operand"() : () -> !pdl.value
    %2 = "pdl.operands"() : () -> !pdl.range<value>
    %3 = "pdl.operation"(%0, %1, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 3, 0, 0>}> : (!pdl.value, !pdl.value, !pdl.range<value>) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "switch_result_count_at_least"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %4 = "pdl.type"() : () -> !pdl.type
    %5 = "pdl.types"() : () -> !pdl.range<type>
    %6 = "pdl.operation"(%4, %5) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%6) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() : () -> !pdl.type
    %1 = "pdl.type"() : () -> !pdl.type
    %2 = "pdl.types"() : () -> !pdl.range<type>
    %3 = "pdl.operation"(%0, %1, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 3>}> : (!pdl.type, !pdl.type, !pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "predicate_ordering"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %2 = "pdl.type"() : () -> !pdl.type
    "pdl.apply_native_constraint"(%2) <{isNegated = false, name = "typeConstraint"}> : (!pdl.type) -> ()
    %3 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    "pdl.rewrite"(%3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() : () -> !pdl.type
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    "pdl.rewrite"(%1) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "multi_root"}> ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "rewrite_multi_root"}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operand"() : () -> !pdl.value
    %2 = "pdl.type"() : () -> !pdl.type
    %3 = "pdl.operation"(%0, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 1>}> : (!pdl.value, !pdl.type) -> !pdl.operation
    %4 = "pdl.result"(%3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %5 = "pdl.operation"(%4) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    %6 = "pdl.operation"(%1, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 1>}> : (!pdl.value, !pdl.type) -> !pdl.operation
    %7 = "pdl.result"(%6) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %8 = "pdl.operation"(%4, %7) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 0>}> : (!pdl.value, !pdl.value) -> !pdl.operation
    "pdl.rewrite"(%5, %8) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "overlapping_roots"}> ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "rewrite_overlapping_roots"}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operand"() : () -> !pdl.value
    %2 = "pdl.type"() : () -> !pdl.type
    %3 = "pdl.operation"(%0, %1, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 1>}> : (!pdl.value, !pdl.value, !pdl.type) -> !pdl.operation
    %4 = "pdl.result"(%3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %5 = "pdl.operation"(%4) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    "pdl.rewrite"(%5) <{name = "rewriter", operandSegmentSizes = array<i32: 0, 1>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "force_overlapped_root"}> ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "rewrite_forced_overlapped_root"}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operand"() : () -> !pdl.value
    %2 = "pdl.type"() : () -> !pdl.type
    %3 = "pdl.operation"(%0, %1, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 1>}> : (!pdl.value, !pdl.value, !pdl.type) -> !pdl.operation
    %4 = "pdl.result"(%3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %5 = "pdl.operation"(%4) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    "pdl.rewrite"(%3, %5) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_results_all"}> ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "variadic_results_all"}> ({
    %0 = "pdl.types"() : () -> !pdl.range<type>
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    %2 = "pdl.results"(%1) : (!pdl.operation) -> !pdl.range<value>
    %3 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.range<value>) -> !pdl.operation
    "pdl.rewrite"(%1, %3) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "variadic_results_at"}> ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "variadic_results_at"}> ({
    %0 = "pdl.type"() : () -> !pdl.type
    %1 = "pdl.types"() : () -> !pdl.range<type>
    %2 = "pdl.operand"() : () -> !pdl.value
    %3 = "pdl.operation"(%1, %0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.range<type>, !pdl.type) -> !pdl.operation
    %4 = "pdl.results"(%3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.range<value>
    %5 = "pdl.operation"(%4, %2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 0>}> : (!pdl.range<value>, !pdl.value) -> !pdl.operation
    %6 = "pdl.operation"(%2, %4) <{attributeValueNames = [], operandSegmentSizes = array<i32: 2, 0, 0>}> : (!pdl.value, !pdl.range<value>) -> !pdl.operation
    "pdl.rewrite"(%5, %6) <{name = "rewriter", operandSegmentSizes = array<i32: 0, 2>}> ({
    }) : (!pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "attribute_literal"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "constraint"}> : (!pdl.attribute) -> ()
    %1 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%1) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "type_literal"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() <{constantType = i32}> : () -> !pdl.type
    %1 = "pdl.types"() <{constantTypes = [i32, i64]}> : () -> !pdl.range<type>
    "pdl.apply_native_constraint"(%0, %1) <{isNegated = false, name = "constraint"}> : (!pdl.type, !pdl.range<type>) -> ()
    %2 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "common_connector"}> ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "common_connector"}> ({
    %0 = "pdl.type"() : () -> !pdl.type
    %1 = "pdl.operation"(%0, %0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.type) -> !pdl.operation
    %2 = "pdl.result"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %3 = "pdl.result"(%1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.value
    %4 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    %5 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    %6 = "pdl.operation"(%3, %0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 1>}> : (!pdl.value, !pdl.type) -> !pdl.operation
    %7 = "pdl.result"(%6) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %8 = "pdl.operation"(%7) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    "pdl.rewrite"(%4, %5, %8) <{name = "rewriter", operandSegmentSizes = array<i32: 0, 3>}> ({
    }) : (!pdl.operation, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "common_connector_range"}> ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "common_connector_range"}> ({
    %0 = "pdl.types"() : () -> !pdl.range<type>
    %1 = "pdl.operation"(%0, %0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.range<type>, !pdl.range<type>) -> !pdl.operation
    %2 = "pdl.results"(%1) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.range<value>
    %3 = "pdl.results"(%1) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
    %4 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.range<value>) -> !pdl.operation
    %5 = "pdl.operation"(%2) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.range<value>) -> !pdl.operation
    %6 = "pdl.operation"(%3, %0) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 1>}> : (!pdl.range<value>, !pdl.range<type>) -> !pdl.operation
    %7 = "pdl.results"(%6) : (!pdl.operation) -> !pdl.range<value>
    %8 = "pdl.operation"(%7) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.range<value>) -> !pdl.operation
    "pdl.rewrite"(%4, %5, %8) <{name = "rewriter", operandSegmentSizes = array<i32: 0, 3>}> ({
    }) : (!pdl.operation, !pdl.operation, !pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

