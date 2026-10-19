module {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operation_name of %arg0 is "tosa.mul" -> ^bb2, ^bb1
  ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.get_attribute "shift" of %arg0
    pdl_interp.is_not_null %0 : !pdl.attribute -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %1 = pdl_interp.create_attribute 0 : i32
    %2 = pdl_interp.create_attribute 1 : i32
    %3 = pdl_interp.apply_constraint "return_attr_constraint"(%1, %2 : !pdl.attribute, !pdl.attribute) : !pdl.attribute -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    pdl_interp.apply_constraint "use_attr_constraint"(%0, %3 : !pdl.attribute, !pdl.attribute) -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0 : !pdl.operation) : benefit(1), loc([%arg0]), root("tosa.mul") -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation) {
      pdl_interp.apply_rewrite "rewriter"(%arg0 : !pdl.operation)
      pdl_interp.finalize
    }
  }
}

// -----
module {
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
    %2 = pdl_interp.get_attribute "attr" of %arg0
    pdl_interp.is_not_null %2 : !pdl.attribute -> ^bb6, ^bb1
  ^bb6:  // pred: ^bb5
    pdl_interp.check_operand_count of %1 is 0 -> ^bb7, ^bb1
  ^bb7:  // pred: ^bb6
    pdl_interp.check_result_count of %1 is 0 -> ^bb8, ^bb1
  ^bb8:  // pred: ^bb7
    %3 = pdl_interp.apply_constraint "return_attr_constraint"(%1 : !pdl.operation) : !pdl.attribute -> ^bb9, ^bb1
  ^bb9:  // pred: ^bb8
    %4 = pdl_interp.get_result 0 of %1
    pdl_interp.are_equal %4, %0 : !pdl.value -> ^bb10, ^bb1
  ^bb10:  // pred: ^bb9
    pdl_interp.are_equal %2, %3 : !pdl.attribute -> ^bb11, ^bb1
  ^bb11:  // pred: ^bb10
    pdl_interp.record_match @rewriters::@pdl_generated_rewriter(%arg0, %2 : !pdl.operation, !pdl.attribute) : benefit(1), loc([%1, %arg0]) -> ^bb1
  }
  module @rewriters {
    pdl_interp.func @pdl_generated_rewriter(%arg0: !pdl.operation, %arg1: !pdl.attribute) {
      pdl_interp.apply_rewrite "rewriter"(%arg0, %arg1 : !pdl.operation, !pdl.attribute)
      pdl_interp.finalize
    }
  }
}

// -----
module {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 1 -> ^bb2, ^bb1
  ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb4, ^bb5
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    pdl_interp.check_result_count of %arg0 is 0 -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %0 = pdl_interp.create_attribute 10 : i64
    %1 = pdl_interp.apply_constraint "return_value_constr"(%0 : !pdl.attribute) : !pdl.value -> ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %2 = pdl_interp.get_operand 0 of %arg0
    pdl_interp.are_equal %2, %1 : !pdl.value -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
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
module {
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
    %1 = pdl_interp.create_attribute 10 : i64
    %2 = pdl_interp.apply_constraint "return_type_constr"(%1 : !pdl.attribute) : !pdl.type -> ^bb5, ^bb1
  ^bb5:  // pred: ^bb4
    %3 = pdl_interp.get_value_type of %0 : !pdl.type
    pdl_interp.are_equal %3, %2 : !pdl.type -> ^bb6, ^bb1
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
module {
  pdl_interp.func @matcher(%arg0: !pdl.operation) {
    pdl_interp.check_operand_count of %arg0 is 0 -> ^bb2, ^bb1
  ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    pdl_interp.finalize
  ^bb2:  // pred: ^bb0
    %0 = pdl_interp.create_attribute 10 : i64
    %1 = pdl_interp.apply_constraint "return_type_range_constr"(%0 : !pdl.attribute) : !pdl.range<type> -> ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    %2 = pdl_interp.get_results of %arg0 : !pdl.range<value>
    %3 = pdl_interp.get_value_type of %2 : !pdl.range<type>
    pdl_interp.are_equal %3, %1 : !pdl.range<type> -> ^bb4, ^bb1
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

