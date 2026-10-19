module {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.finalize
  }
  module @rewriters {
  }
}

// -----
module @external {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %0 : !pdl.operation, !pdl.value) : benefit(1), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.value) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.value)
      pdl_interp.finalize
    }
  }
}

// -----
module @erase {
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
      pdl_interp.erase %arg0
      pdl_interp.finalize
    }
  }
}

// -----
module @operation_attributes {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_attribute "attr" of %arg0
    pdl_interp.is_not_null %0 : !pdl.attribute -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%0, %arg0 : !pdl.attribute, !pdl.operation) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.attribute, %arg1: !pdl.operation) {
      %0 = pdl_interp.create_attribute true
      %1 = pdl_interp.create_operation "foo.op" {"attr" = %arg0, "attr1" = %0} 
      pdl_interp.erase %arg1
      pdl_interp.finalize
    }
  }
}

// -----
module @operation_operands {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%0, %arg0 : !pdl.value, !pdl.operation) : benefit(1), generatedOps(["foo.op", "foo.op2"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.value, %arg1: !pdl.operation) {
      %0 = pdl_interp.create_type i32
      %1 = pdl_interp.create_operation "foo.op"(%arg0 : !pdl.value)  -> (%0 : !pdl.type)
      %2 = pdl_interp.get_result 0 of %1
      %3 = pdl_interp.create_operation "foo.op2"(%2 : !pdl.value) 
      pdl_interp.erase %arg1
      pdl_interp.finalize
    }
  }
}

// -----
module @operation_infer_types_from_replaceop {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 2 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %1 = pdl_interp.get_result 1 of %arg0
    pdl_interp.is_not_null %1 : !pdl.value -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      %0 = pdl_interp.get_results of %arg0 : !pdl.range<value>
      %1 = pdl_interp.get_value_type of %0 : !pdl.range<type>
      %2 = pdl_interp.create_operation "foo.op"  -> (%1 : !pdl.range<type>)
      %3 = pdl_interp.get_results of %2 : !pdl.range<value>
      pdl_interp.replace %arg0 with (%3 : !pdl.range<value>)
      pdl_interp.finalize
    }
  }
}

// -----
module @operation_infer_types_from_otherop_individual_results {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is at_least 1 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %1 = pdl_interp.get_results 1 of %arg0 : !pdl.range<value>
    pdl_interp.is_not_null %1 : !pdl.range<value> -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    %2 = pdl_interp.get_value_type of %0 : !pdl.type
    %3 = pdl_interp.get_value_type of %1 : !pdl.range<type>
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%2, %3 : !pdl.type, !pdl.range<type>) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.type, %arg1: !pdl.range<type>) {
      %0 = pdl_interp.create_operation "foo.op"  -> (%arg0, %arg1 : !pdl.type, !pdl.range<type>)
      pdl_interp.finalize
    }
  }
}

// -----
module @operation_infer_types_from_otherop_results {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_results of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_value_type of %0 : !pdl.range<type>
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%1 : !pdl.range<type>) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.range<type>) {
      %0 = pdl_interp.create_operation "foo.op"  -> (%arg0 : !pdl.range<type>)
      pdl_interp.finalize
    }
  }
}

// -----
module @operation_infer_types_from_interface {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter : benefit(1), generatedOps(["arith.constant", "foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter() {
      %0 = pdl_interp.create_operation "arith.constant"  -> <inferred>
      %1 = pdl_interp.get_results of %0 : !pdl.range<value>
      %2 = pdl_interp.get_value_type of %1 : !pdl.range<type>
      %3 = pdl_interp.create_operation "foo.op"  -> (%2 : !pdl.range<type>)
      pdl_interp.finalize
    }
  }
  %true = arith.constant true
}

// -----
module @replace_with_op {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 1 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %1 = pdl_interp.get_value_type of %0 : !pdl.type
    pdl_interp.check_type %1 is i32 -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      %0 = pdl_interp.create_type i32
      %1 = pdl_interp.create_operation "foo.op"  -> (%0 : !pdl.type)
      %2 = pdl_interp.get_results of %1 : !pdl.range<value>
      pdl_interp.replace %arg0 with (%2 : !pdl.range<value>)
      pdl_interp.finalize
    }
  }
}

// -----
module @replace_with_values {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_results of %arg0 : !pdl.range<value>
    %1 = pdl_interp.get_value_type of %0 : !pdl.range<type>
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%1, %arg0 : !pdl.range<type>, !pdl.operation) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.range<type>, %arg1: !pdl.operation) {
      %0 = pdl_interp.create_operation "foo.op"  -> (%arg0 : !pdl.range<type>)
      %1 = pdl_interp.get_result 0 of %0
      %2 = pdl_interp.get_results 1 of %0 : !pdl.range<value>
      %3 = pdl_interp.get_results 2 of %0 : !pdl.value
      pdl_interp.replace %arg1 with (%1, %2, %3 : !pdl.value, !pdl.range<value>, !pdl.value)
      pdl_interp.finalize
    }
  }
}

// -----
module @replace_with_no_results {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      %0 = pdl_interp.get_results of %arg0 : !pdl.range<value>
      %1 = pdl_interp.get_value_type of %0 : !pdl.range<type>
      %2 = pdl_interp.create_operation "foo.op"  -> (%1 : !pdl.range<type>)
      pdl_interp.erase %arg0
      pdl_interp.finalize
    }
  }
}

// -----
module @apply_native_rewrite {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 1 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_result 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), generatedOps(["foo.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      %0 = pdl_interp.apply_rewrite "functor"(%arg0 : !pdl.operation) : !pdl.type
      %1 = pdl_interp.create_operation "foo.op"  -> (%0 : !pdl.type)
      pdl_interp.finalize
    }
  }
}

// -----
module @unbound_rewrite_op {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter : benefit(1), generatedOps(["bar.op"]), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter() {
      %0 = pdl_interp.create_operation "bar.op" 
      pdl_interp.finalize
    }
  }
}

// -----
module @range_op {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "foo.op" -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 1 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %0 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.is_not_null %0 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%0 : !pdl.value) : benefit(1), loc([%arg0]), root("foo.op") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.value) {
      %0 = pdl_interp.create_range : !pdl.range<value>
      %1 = pdl_interp.create_range %arg0, %0 : !pdl.value, !pdl.range<value> 
      pdl_interp.finalize
    }
  }
}

