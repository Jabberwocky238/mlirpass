"builtin.module"() ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.attribute"() : () -> !pdl.attribute
    %1 = "pdl.types"() : () -> !pdl.range<type>
    %2 = "pdl.operation"(%0, %1) <{attributeValueNames = ["shift"], opName = "tosa.mul", operandSegmentSizes = array<i32: 0, 1, 1>}> : (!pdl.attribute, !pdl.range<type>) -> !pdl.operation
    %3 = "pdl.attribute"() <{value = 0 : i32}> : () -> !pdl.attribute
    %4 = "pdl.attribute"() <{value = 1 : i32}> : () -> !pdl.attribute
    %5 = "pdl.apply_native_constraint"(%3, %4) <{isNegated = false, name = "return_attr_constraint"}> : (!pdl.attribute, !pdl.attribute) -> !pdl.attribute
    "pdl.apply_native_constraint"(%0, %5) <{isNegated = false, name = "use_attr_constraint"}> : (!pdl.attribute, !pdl.attribute) -> ()
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    %1 = "pdl.result"(%0) <{index = 0 : i32}> : (!pdl.operation) -> !pdl.value
    %2 = "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "return_attr_constraint"}> : (!pdl.operation) -> !pdl.attribute
    %3 = "pdl.operation"(%1, %2) <{attributeValueNames = ["attr"], operandSegmentSizes = array<i32: 1, 1, 0>}> : (!pdl.value, !pdl.attribute) -> !pdl.operation
    "pdl.rewrite"(%3, %2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 1>}> ({
    }) : (!pdl.operation, !pdl.attribute) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    %1 = "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "return_value_constr"}> : (!pdl.attribute) -> !pdl.value
    %2 = "pdl.operation"(%1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 1, 0, 0>}> : (!pdl.value) -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    %1 = "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "return_type_constr"}> : (!pdl.attribute) -> !pdl.type
    %2 = "pdl.operation"(%1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.type) -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "pdl.pattern"() <{benefit = 1 : i16}> ({
    %0 = "pdl.attribute"() <{value = 10 : i64}> : () -> !pdl.attribute
    %1 = "pdl.apply_native_constraint"(%0) <{isNegated = false, name = "return_type_range_constr"}> : (!pdl.attribute) -> !pdl.range<type>
    %2 = "pdl.operation"(%1) <{attributeValueNames = [], operandSegmentSizes = array<i32: 0, 0, 1>}> : (!pdl.range<type>) -> !pdl.operation
    "pdl.rewrite"(%2) <{name = "rewriter", operandSegmentSizes = array<i32: 1, 0>}> ({
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

