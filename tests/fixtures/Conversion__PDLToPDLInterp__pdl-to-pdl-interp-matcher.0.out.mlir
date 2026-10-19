module @empty_module {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.finalize
  }
  module @rewriters {
  }
}

// -----
module @simple {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @attributes {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_attribute "attr" of %arg0
    pdl_interp.is_not_null %0 : !pdl.attribute -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_attribute "attr1" of %arg0
    pdl_interp.is_not_null %1 : !pdl.attribute -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.check_attribute %0 is 10 : i64 -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %2 = pdl_interp.get_attribute_type of %1
    pdl_interp.check_type %2 is i64 -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @constraints {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 2 -> ^bb2, ^bb1
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_operand 1 of %arg0
    pdl_interp.is_not_null %1 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_result 0 of %arg0
    pdl_interp.apply_constraint "multi_constraint"(%0, %1, %2 : !pdl.value, !pdl.value, !pdl.value) -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.is_not_null %2 : !pdl.value -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @constraint_with_result {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.apply_constraint "check_op_and_get_attr_constr"(%arg0 : !pdl.operation) : !pdl.attribute -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %0 : !pdl.operation, !pdl.attribute) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.attribute) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.attribute)
      pdl_interp.finalize
    }
  }
}

// -----
module @constraint_with_unused_result {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.apply_constraint "check_op_and_get_attr_constr"(%arg0 : !pdl.operation) : !pdl.attribute -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @constraint_with_result_multiple {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.apply_constraint "check_op_and_get_attr_constr"(%arg0 : !pdl.operation) : !pdl.attribute -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter_0(%arg0, %0 : !pdl.operation, !pdl.attribute) : benefit(1), loc([%arg0]) -> ^bb5
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %0 : !pdl.operation, !pdl.attribute) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.attribute) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.attribute)
      pdl_interp.finalize
    }
    pdl_interp.func @pdl_generated_rewriter_0(%arg0: !pdl.operation, %arg1: !pdl.attribute) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.attribute)
      pdl_interp.finalize
    }
  }
}

// -----
module @negated_constraint {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.apply_constraint "constraint"(%arg0 : !pdl.operation) {isNegated = true} -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @inputs {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 2 -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_operand 1 of %arg0
    pdl_interp.are_equal %0, %1 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_value_type of %0 : !pdl.type
    pdl_interp.check_type %2 is i64 -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @variadic_inputs {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is at_least 2 -> ^bb2, ^bb1
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_operands 2 of %arg0 : !pdl.value
    pdl_interp.are_equal %0, %1 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_operands 1 of %arg0 : !pdl.range<value>
    pdl_interp.is_not_null %2 : !pdl.range<value> -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %3 = pdl_interp.get_value_type of %2 : !pdl.range<type>
    pdl_interp.check_types %3 are [i64] -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @single_operand_range {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %0 = pdl_interp.get_operands of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_value_type of %0 : !pdl.range<type>
    pdl_interp.check_types %1 are [i64] -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @results {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 2 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_result 1 of %arg0
    pdl_interp.is_not_null %1 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_value_type of %0 : !pdl.type
    pdl_interp.check_type %2 is i32 -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @variadic_results {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is at_least 2 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_results 1 of %arg0 : !pdl.range<value>
    pdl_interp.is_not_null %1 : !pdl.range<value> -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_results 2 of %arg0 : !pdl.value
    pdl_interp.is_not_null %2 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %3 = pdl_interp.get_value_type of %1 : !pdl.range<type>
    pdl_interp.check_types %3 are [i64] -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    %4 = pdl_interp.get_value_type of %0 : !pdl.type
    %5 = pdl_interp.get_value_type of %2 : !pdl.type
    pdl_interp.are_equal %4, %5 : !pdl.type -> ^bb8, ^bb1
  ^bb8:  // pred: ^bb7
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @single_result_range {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %0 = pdl_interp.get_results of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_value_type of %0 : !pdl.range<type>
    pdl_interp.check_types %1 are [i64] -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @results_as_operands {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    %0 = pdl_interp.get_operand 0 of %arg0
    %1 = pdl_interp.get_defining_op of %0 : !pdl.value
    pdl_interp.is_not_null %1 : !pdl.operation -> ^bb2, ^bb1
  ^bb1:  // 15 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11, ^bb12, ^bb13, ^bb14, ^bb15
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 2 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_operand 1 of %arg0
    pdl_interp.is_not_null %2 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %3 = pdl_interp.get_defining_op of %2 : !pdl.value
    pdl_interp.is_not_null %3 : !pdl.operation -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.check_operand_count of %1 is 0 -> ^bb8, ^bb1
  ^bb8:  // pred: ^bb7
    pdl_interp.check_result_count of %1 is 2 -> ^bb9, ^bb1
  ^bb9:  // pred: ^bb8
    pdl_interp.are_equal %1, %3 : !pdl.operation -> ^bb10, ^bb1
  ^bb10:  // pred: ^bb9
    %4 = pdl_interp.get_result 0 of %1
    pdl_interp.is_not_null %4 : !pdl.value -> ^bb11, ^bb1
  ^bb11:  // pred: ^bb10
    %5 = pdl_interp.get_result 1 of %1
    pdl_interp.is_not_null %5 : !pdl.value -> ^bb12, ^bb1
  ^bb12:  // pred: ^bb11
    pdl_interp.are_equal %4, %0 : !pdl.value -> ^bb13, ^bb1
  ^bb13:  // pred: ^bb12
    %6 = pdl_interp.get_result 1 of %3
    pdl_interp.are_equal %6, %2 : !pdl.value -> ^bb14, ^bb1
  ^bb14:  // pred: ^bb13
    %7 = pdl_interp.get_value_type of %4 : !pdl.type
    pdl_interp.check_type %7 is i32 -> ^bb15, ^bb1
  ^bb15:  // pred: ^bb14
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%1, %arg0, %3]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @single_result_range_as_operands {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    %0 = pdl_interp.get_operands of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_defining_op of %0 : !pdl.range<value>
    pdl_interp.is_not_null %1 : !pdl.operation -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_operand_count of %1 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %2 = pdl_interp.get_results of %1 : !pdl.range<value>
    pdl_interp.are_equal %2, %0 : !pdl.range<value> -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%1, %arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @switch_single_result_type {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_value_type of %0 : !pdl.type
    pdl_interp.switch_type %1 to [i32, i64](^bb5, ^bb6) -> ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  ^bb6:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter_0(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
    pdl_interp.func @pdl_generated_rewriter_0(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @switch_result_types {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %0 = pdl_interp.get_results of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_value_type of %0 : !pdl.range<type>
    pdl_interp.switch_types %1 to [[i32], [i64, i32]](^bb3, ^bb4) -> ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  ^bb4:  // pred: ^bb2
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter_0(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
    pdl_interp.func @pdl_generated_rewriter_0(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @switch_operand_count_at_least {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is at_least 1 -> ^bb8, ^bb1
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    pdl_interp.finalize
  ^bb2:  // 4 preds: ^bb8, ^bb9, ^bb10, ^bb11
    pdl_interp.check_operand_count of %arg0 is at_least 2 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %1 = pdl_interp.get_operand 1 of %arg0
    pdl_interp.is_not_null %1 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %2 = pdl_interp.get_operands 2 of %arg0 : !pdl.range<value>
    pdl_interp.is_not_null %2 : !pdl.range<value> -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  ^bb8:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb9, ^bb2
  ^bb9:  // pred: ^bb8
    %3 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %3 : !pdl.value -> ^bb10, ^bb2
  ^bb10:  // pred: ^bb9
    %4 = pdl_interp.get_operands 1 of %arg0 : !pdl.range<value>
    pdl_interp.is_not_null %4 : !pdl.range<value> -> ^bb11, ^bb2
  ^bb11:  // pred: ^bb10
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter_0(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb2
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
    pdl_interp.func @pdl_generated_rewriter_0(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @switch_result_count_at_least {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is at_least 1 -> ^bb8, ^bb1
  ^bb3:  // 3 preds: ^bb8, ^bb9, ^bb10
    pdl_interp.check_result_count of %arg0 is at_least 2 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %1 = pdl_interp.get_result 1 of %arg0
    pdl_interp.is_not_null %1 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %2 = pdl_interp.get_results 2 of %arg0 : !pdl.range<value>
    pdl_interp.is_not_null %2 : !pdl.range<value> -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  ^bb8:  // pred: ^bb2
    %3 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %3 : !pdl.value -> ^bb9, ^bb3
  ^bb9:  // pred: ^bb8
    %4 = pdl_interp.get_results 1 of %arg0 : !pdl.range<value>
    pdl_interp.is_not_null %4 : !pdl.range<value> -> ^bb10, ^bb3
  ^bb10:  // pred: ^bb9
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter_0(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb3
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
    pdl_interp.func @pdl_generated_rewriter_0(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @predicate_ordering {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter_0(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb5
  ^bb5:  // pred: ^bb4
    %1 = pdl_interp.get_value_type of %0 : !pdl.type
    pdl_interp.apply_constraint "typeConstraint"(%1 : !pdl.type) -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
    pdl_interp.func @pdl_generated_rewriter_0(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @multi_root {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    %0 = pdl_interp.get_operand 0 of %arg0
    %1 = pdl_interp.get_defining_op of %0 : !pdl.value
    pdl_interp.is_not_null %1 : !pdl.operation -> ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %2 = pdl_interp.get_users of %0 : !pdl.value
    pdl_interp.foreach %arg1 : !pdl.operation in %2 {
      %3 = pdl_interp.get_operand 1 of %arg1
      %4 = pdl_interp.get_defining_op of %3 : !pdl.value
      pdl_interp.is_not_null %4 : !pdl.operation -> ^bb2, ^bb1
    ^bb1:  // 21 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11, ^bb12, ^bb13, ^bb14, ^bb15, ^bb16, ^bb17, ^bb18, ^bb19, ^bb20, ^bb21
      pdl_interp.continue
    ^bb2:  // pred: ^bb0
      pdl_interp.check_operand_count of %arg0 is 1 -> ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
    ^bb5:  // pred: ^bb4
      pdl_interp.is_not_null %arg1 : !pdl.operation -> ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      pdl_interp.check_operand_count of %1 is 1 -> ^bb7, ^bb1
    ^bb7:  // pred: ^bb6
      pdl_interp.check_operand_count of %arg1 is 2 -> ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      pdl_interp.check_result_count of %1 is 1 -> ^bb9, ^bb1
    ^bb9:  // pred: ^bb8
      pdl_interp.check_result_count of %arg1 is 0 -> ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %5 = pdl_interp.get_operand 0 of %1
      pdl_interp.is_not_null %5 : !pdl.value -> ^bb11, ^bb1
    ^bb11:  // pred: ^bb10
      pdl_interp.is_not_null %3 : !pdl.value -> ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      %6 = pdl_interp.get_operand 0 of %arg1
      pdl_interp.are_equal %6, %0 : !pdl.value -> ^bb13, ^bb1
    ^bb13:  // pred: ^bb12
      %7 = pdl_interp.get_result 0 of %1
      pdl_interp.is_not_null %7 : !pdl.value -> ^bb14, ^bb1
    ^bb14:  // pred: ^bb13
      pdl_interp.are_equal %7, %0 : !pdl.value -> ^bb15, ^bb1
    ^bb15:  // pred: ^bb14
      pdl_interp.check_operand_count of %4 is 1 -> ^bb16, ^bb1
    ^bb16:  // pred: ^bb15
      pdl_interp.check_result_count of %4 is 1 -> ^bb17, ^bb1
    ^bb17:  // pred: ^bb16
      %8 = pdl_interp.get_operand 0 of %4
      pdl_interp.is_not_null %8 : !pdl.value -> ^bb18, ^bb1
    ^bb18:  // pred: ^bb17
      %9 = pdl_interp.get_result 0 of %4
      pdl_interp.is_not_null %9 : !pdl.value -> ^bb19, ^bb1
    ^bb19:  // pred: ^bb18
      pdl_interp.are_equal %9, %3 : !pdl.value -> ^bb20, ^bb1
    ^bb20:  // pred: ^bb19
      %10 = pdl_interp.get_value_type of %9 : !pdl.type
      %11 = pdl_interp.get_value_type of %7 : !pdl.type
      pdl_interp.are_equal %10, %11 : !pdl.type -> ^bb21, ^bb1
    ^bb21:  // pred: ^bb20
      pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %arg1 : !pdl.operation, !pdl.operation) : benefit(1), loc([%1, %4, %arg0, %arg1]) -> ^bb1
    } -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @overlapping_roots {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    %0 = pdl_interp.get_operand 0 of %arg0
    %1 = pdl_interp.get_defining_op of %0 : !pdl.value
    pdl_interp.is_not_null %1 : !pdl.operation -> ^bb2, ^bb1
  ^bb1:  // 11 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.check_operand_count of %1 is 2 -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.check_result_count of %1 is 1 -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    %2 = pdl_interp.get_operand 0 of %1
    pdl_interp.is_not_null %2 : !pdl.value -> ^bb8, ^bb1
  ^bb8:  // pred: ^bb7
    %3 = pdl_interp.get_operand 1 of %1
    pdl_interp.is_not_null %3 : !pdl.value -> ^bb9, ^bb1
  ^bb9:  // pred: ^bb8
    %4 = pdl_interp.get_result 0 of %1
    pdl_interp.is_not_null %4 : !pdl.value -> ^bb10, ^bb1
  ^bb10:  // pred: ^bb9
    pdl_interp.are_equal %4, %0 : !pdl.value -> ^bb11, ^bb1
  ^bb11:  // pred: ^bb10
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%1, %arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @force_overlapped_root {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 2 -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.get_operand 1 of %arg0
    pdl_interp.is_not_null %1 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %2 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %3 = pdl_interp.get_users of %2 : !pdl.value
    pdl_interp.foreach %arg1 : !pdl.operation in %3 {
      pdl_interp.is_not_null %arg1 : !pdl.operation -> ^bb2, ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
      pdl_interp.continue
    ^bb2:  // pred: ^bb0
      pdl_interp.check_operand_count of %arg1 is 1 -> ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      pdl_interp.check_result_count of %arg1 is 0 -> ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %4 = pdl_interp.get_operand 0 of %arg1
      pdl_interp.are_equal %4, %2 : !pdl.value -> ^bb5, ^bb1
    ^bb5:  // pred: ^bb4
      pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %arg1 : !pdl.operation, !pdl.operation) : benefit(1), loc([%arg0, %arg1]) -> ^bb1
    } -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @variadic_results_all {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %0 = pdl_interp.get_results of %arg0 : !pdl.range<value>
    %1 = pdl_interp.extract 0 of %0 : !pdl.value
    %2 = pdl_interp.get_users of %1 : !pdl.value
    pdl_interp.foreach %arg1 : !pdl.operation in %2 {
      pdl_interp.is_not_null %arg1 : !pdl.operation -> ^bb2, ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      pdl_interp.continue
    ^bb2:  // pred: ^bb0
      pdl_interp.check_result_count of %arg1 is 0 -> ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %3 = pdl_interp.get_operands of %arg1 : !pdl.range<value>
      pdl_interp.are_equal %3, %0 : !pdl.range<value> -> ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %arg1 : !pdl.operation, !pdl.operation) : benefit(1), loc([%arg0, %arg1]) -> ^bb1
    } -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @variadic_results_at {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    %0 = pdl_interp.get_operands 0 of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_defining_op of %0 : !pdl.range<value>
    pdl_interp.is_not_null %1 : !pdl.operation -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is at_least 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.is_not_null %0 : !pdl.range<value> -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %2 = pdl_interp.get_operands 1 of %arg0 : !pdl.value
    pdl_interp.is_not_null %2 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %3 = pdl_interp.extract 0 of %0 : !pdl.value
    %4 = pdl_interp.get_users of %3 : !pdl.value
    pdl_interp.foreach %arg1 : !pdl.operation in %4 {
      pdl_interp.is_not_null %arg1 : !pdl.operation -> ^bb2, ^bb1
    ^bb1:  // 11 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11
      pdl_interp.continue
    ^bb2:  // pred: ^bb0
      pdl_interp.check_operand_count of %arg1 is at_least 1 -> ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      pdl_interp.check_operand_count of %1 is 0 -> ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      pdl_interp.check_result_count of %1 is at_least 1 -> ^bb5, ^bb1
    ^bb5:  // pred: ^bb4
      pdl_interp.check_result_count of %arg1 is 0 -> ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %5 = pdl_interp.get_operand 0 of %arg1
      pdl_interp.are_equal %5, %2 : !pdl.value -> ^bb7, ^bb1
    ^bb7:  // pred: ^bb6
      %6 = pdl_interp.get_operands 1 of %arg1 : !pdl.range<value>
      pdl_interp.are_equal %6, %0 : !pdl.range<value> -> ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %7 = pdl_interp.get_results 0 of %1 : !pdl.range<value>
      pdl_interp.is_not_null %7 : !pdl.range<value> -> ^bb9, ^bb1
    ^bb9:  // pred: ^bb8
      %8 = pdl_interp.get_results 1 of %1 : !pdl.value
      pdl_interp.is_not_null %8 : !pdl.value -> ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      pdl_interp.are_equal %7, %0 : !pdl.range<value> -> ^bb11, ^bb1
    ^bb11:  // pred: ^bb10
      pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %arg1 : !pdl.operation, !pdl.operation) : benefit(1), loc([%1, %arg0, %arg1]) -> ^bb1
    } -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @attribute_literal {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.create_attribute 10 : i64
    pdl_interp.apply_constraint "constraint"(%0 : !pdl.attribute) -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @type_literal {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.create_type i32
    %1 = pdl_interp.create_types [i32, i64]
    pdl_interp.apply_constraint "constraint"(%0, %1 : !pdl.type, !pdl.range<type>) -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @common_connector {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    %0 = pdl_interp.get_operand 0 of %arg0
    %1 = pdl_interp.get_defining_op of %0 : !pdl.value
    pdl_interp.is_not_null %1 : !pdl.operation -> ^bb2, ^bb1
  ^bb1:  // 18 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11, ^bb12, ^bb13, ^bb14, ^bb15, ^bb16, ^bb17, ^bb18
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %2 = pdl_interp.get_operand 0 of %1
    %3 = pdl_interp.get_defining_op of %2 : !pdl.value
    pdl_interp.is_not_null %3 : !pdl.operation -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_operand_count of %arg0 is 1 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.check_operand_count of %1 is 1 -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.check_result_count of %1 is 1 -> ^bb8, ^bb1
  ^bb8:  // pred: ^bb7
    pdl_interp.is_not_null %2 : !pdl.value -> ^bb9, ^bb1
  ^bb9:  // pred: ^bb8
    %4 = pdl_interp.get_result 0 of %1
    pdl_interp.is_not_null %4 : !pdl.value -> ^bb10, ^bb1
  ^bb10:  // pred: ^bb9
    pdl_interp.are_equal %4, %0 : !pdl.value -> ^bb11, ^bb1
  ^bb11:  // pred: ^bb10
    pdl_interp.check_operand_count of %3 is 0 -> ^bb12, ^bb1
  ^bb12:  // pred: ^bb11
    pdl_interp.check_result_count of %3 is 2 -> ^bb13, ^bb1
  ^bb13:  // pred: ^bb12
    %5 = pdl_interp.get_result 0 of %3
    pdl_interp.is_not_null %5 : !pdl.value -> ^bb14, ^bb1
  ^bb14:  // pred: ^bb13
    %6 = pdl_interp.get_result 1 of %3
    pdl_interp.is_not_null %6 : !pdl.value -> ^bb15, ^bb1
  ^bb15:  // pred: ^bb14
    pdl_interp.are_equal %6, %2 : !pdl.value -> ^bb16, ^bb1
  ^bb16:  // pred: ^bb15
    %7 = pdl_interp.get_value_type of %5 : !pdl.type
    %8 = pdl_interp.get_value_type of %6 : !pdl.type
    pdl_interp.are_equal %7, %8 : !pdl.type -> ^bb17, ^bb1
  ^bb17:  // pred: ^bb16
    %9 = pdl_interp.get_value_type of %4 : !pdl.type
    pdl_interp.are_equal %7, %9 : !pdl.type -> ^bb18, ^bb1
  ^bb18:  // pred: ^bb17
    %10 = pdl_interp.get_users of %5 : !pdl.value
    pdl_interp.foreach %arg1 : !pdl.operation in %10 {
      pdl_interp.is_not_null %arg1 : !pdl.operation -> ^bb2, ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb2
      pdl_interp.continue
    ^bb2:  // pred: ^bb0
      pdl_interp.foreach %arg2 : !pdl.operation in %10 {
        pdl_interp.is_not_null %arg2 : !pdl.operation -> ^bb2, ^bb1
      ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8
        pdl_interp.continue
      ^bb2:  // pred: ^bb0
        pdl_interp.check_operand_count of %arg1 is 1 -> ^bb3, ^bb1
      ^bb3:  // pred: ^bb2
        pdl_interp.check_operand_count of %arg2 is 1 -> ^bb4, ^bb1
      ^bb4:  // pred: ^bb3
        pdl_interp.check_result_count of %arg1 is 0 -> ^bb5, ^bb1
      ^bb5:  // pred: ^bb4
        pdl_interp.check_result_count of %arg2 is 0 -> ^bb6, ^bb1
      ^bb6:  // pred: ^bb5
        %11 = pdl_interp.get_operand 0 of %arg1
        pdl_interp.are_equal %11, %5 : !pdl.value -> ^bb7, ^bb1
      ^bb7:  // pred: ^bb6
        %12 = pdl_interp.get_operand 0 of %arg2
        pdl_interp.are_equal %12, %5 : !pdl.value -> ^bb8, ^bb1
      ^bb8:  // pred: ^bb7
        pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg1, %arg2, %arg0 : !pdl.operation, !pdl.operation, !pdl.operation) : benefit(1), loc([%1, %3, %arg0, %arg1, %arg2]) -> ^bb1
      } -> ^bb1
    } -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.operation, %arg2: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1, %arg2 : !pdl.operation, !pdl.operation, !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module @common_connector_range {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    %0 = pdl_interp.get_operands of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_defining_op of %0 : !pdl.range<value>
    pdl_interp.is_not_null %1 : !pdl.operation -> ^bb2, ^bb1
  ^bb1:  // 10 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %2 = pdl_interp.get_operands of %1 : !pdl.range<value>
    %3 = pdl_interp.get_defining_op of %2 : !pdl.range<value>
    pdl_interp.is_not_null %3 : !pdl.operation -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.is_not_null %2 : !pdl.range<value> -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %4 = pdl_interp.get_results of %1 : !pdl.range<value>
    pdl_interp.are_equal %4, %0 : !pdl.range<value> -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.check_operand_count of %3 is 0 -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    %5 = pdl_interp.get_results 0 of %3 : !pdl.range<value>
    pdl_interp.is_not_null %5 : !pdl.range<value> -> ^bb8, ^bb1
  ^bb8:  // pred: ^bb7
    %6 = pdl_interp.get_results 1 of %3 : !pdl.range<value>
    pdl_interp.is_not_null %6 : !pdl.range<value> -> ^bb9, ^bb1
  ^bb9:  // pred: ^bb8
    pdl_interp.are_equal %6, %2 : !pdl.range<value> -> ^bb10, ^bb1
  ^bb10:  // pred: ^bb9
    %7 = pdl_interp.extract 0 of %5 : !pdl.value
    %8 = pdl_interp.get_users of %7 : !pdl.value
    pdl_interp.foreach %arg1 : !pdl.operation in %8 {
      pdl_interp.is_not_null %arg1 : !pdl.operation -> ^bb2, ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb2
      pdl_interp.continue
    ^bb2:  // pred: ^bb0
      pdl_interp.foreach %arg2 : !pdl.operation in %8 {
        pdl_interp.is_not_null %arg2 : !pdl.operation -> ^bb2, ^bb1
      ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
        pdl_interp.continue
      ^bb2:  // pred: ^bb0
        pdl_interp.check_result_count of %arg1 is 0 -> ^bb3, ^bb1
      ^bb3:  // pred: ^bb2
        pdl_interp.check_result_count of %arg2 is 0 -> ^bb4, ^bb1
      ^bb4:  // pred: ^bb3
        %9 = pdl_interp.get_operands of %arg1 : !pdl.range<value>
        pdl_interp.are_equal %9, %5 : !pdl.range<value> -> ^bb5, ^bb1
      ^bb5:  // pred: ^bb4
        %10 = pdl_interp.get_operands of %arg2 : !pdl.range<value>
        pdl_interp.are_equal %10, %5 : !pdl.range<value> -> ^bb6, ^bb1
      ^bb6:  // pred: ^bb5
        pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg1, %arg2, %arg0 : !pdl.operation, !pdl.operation, !pdl.operation) : benefit(1), loc([%1, %3, %arg0, %arg1, %arg2]) -> ^bb1
      } -> ^bb1
    } -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.operation, %arg2: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1, %arg2 : !pdl.operation, !pdl.operation, !pdl.operation)
      pdl_interp.finalize
    }
  }
}

