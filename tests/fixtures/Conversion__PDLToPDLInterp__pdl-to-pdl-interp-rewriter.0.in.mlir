"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "external"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    "pdl.rewrite"(%1, %0) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.value) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "erase"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      "pdl.erase"(%0) : (!pdl.operation) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_attributes"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.attribute"() : () -> !pdl.attribute
    %1 = "pdl.operation"(%0) <{attributeValueNames = ["attr"], opName = "foo.op", operandSegmentSizes = array<i32: 0, 1, 0>}> : (!pdl.attribute) -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.attribute"() <{value = true}> : () -> !pdl.attribute
      %3 = "pdl.operation"(%0, %2) <{attributeValueNames = ["attr", "attr1"], opName = "foo.op", operandSegmentSizes = array<i32: 0, 2, 0>}> : (!pdl.attribute, !pdl.attribute) -> !pdl.operation
      "pdl.erase"(%1) : (!pdl.operation) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_operands"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.type"() <{constantType = i32}> : () -> !pdl.type
      %3 = "pdl.operation"(%0, %2) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 1, 0, 1>}> : (!pdl.value, !pdl.type) -> !pdl.operation
      %4 = "pdl.result"(%3) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      %5 = "pdl.operation"(%4) <{attributeValueNames = [], opName = "foo.op2", operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
      "pdl.erase"(%1) : (!pdl.operation) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_replaceop"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() : () -> !pdl.type
    %1 = "pdl.type"() : () -> !pdl.type
    %2 = "pdl.operation"(%0, %1) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.type) -> !pdl.operation
    "pdl.rewrite"(%2) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %3 = "pdl.type"() : () -> !pdl.type
      %4 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
      "pdl.replace"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!pdl.operation, !pdl.operation) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_otherop_individual_results"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() : () -> !pdl.type
    %1 = "pdl.types"() : () -> !pdl.range<type>
    %2 = "pdl.operation"(%0, %1) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%2) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %3 = "pdl.operation"(%0, %1) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 2>}> : (!pdl.type, !pdl.range<type>) -> !pdl.operation
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_otherop_results"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() : () -> !pdl.range<type>
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "operation_infer_types_from_interface"}> ({
  %0 = "arith.constant"() <{value = true}> : () -> i1
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %1 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.types"() : () -> !pdl.range<type>
      %3 = "pdl.operation"(%2) <{attributeValueNames = [], opName = "arith.constant", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
      %4 = "pdl.operation"(%2) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "replace_with_op"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() <{constantType = i32}> : () -> !pdl.type
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
      "pdl.replace"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!pdl.operation, !pdl.operation) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "replace_with_values"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.types"() : () -> !pdl.range<type>
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
      %3 = "pdl.result"(%2) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
      %4 = "pdl.results"(%2) <{index = 1 : i32}> : (!pdl.operation) -> !pdl.range<value>
      %5 = "pdl.results"(%2) <{index = 2 : i32}> : (!pdl.operation) -> !pdl.value
      "pdl.replace"(%1, %3, %4, %5) <{operandSegmentSizes = array<i32: 1, 0, 3>}> : (!pdl.operation, !pdl.value, !pdl.range<value>, !pdl.value) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "replace_with_no_results"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %1 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
      "pdl.replace"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!pdl.operation, !pdl.operation) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "apply_native_rewrite"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.type"() : () -> !pdl.type
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.apply_native_rewrite"(%1) <{name = "functor"}> : (!pdl.operation) -> !pdl.type
      %3 = "pdl.operation"(%2) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "unbound_rewrite_op"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %1 = "pdl.operation"() <{attributeValueNames = [], opName = "bar.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "range_op"}> ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operand"() : () -> !pdl.value
    %1 = "pdl.operation"(%0) <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    "pdl.rewrite"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "pdl.range"() : () -> !pdl.range<value>
      %3 = "pdl.range"(%0, %2) : (!pdl.value, !pdl.range<value>) -> !pdl.range<value>
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

