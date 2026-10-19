"builtin.module"() ({
  "pdl.pattern"() <{benefit = 1 : i16, sym_name = "operation_op"}> ({
    %0 = "pdl.operation"() <{attributeValueNames = [], opName = "foo.op", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
    "pdl.rewrite"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %1 = "pdl.operation"() <{attributeValueNames = [], opName = "bar.unused", operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> !pdl.operation
      "pdl.erase"(%0) : (!pdl.operation) -> ()
    }) : (!pdl.operation) -> ()
  }) : () -> ()
}) : () -> ()

