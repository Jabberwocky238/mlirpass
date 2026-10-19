module {
  func.func @remove_op_with_inner_ops_pattern() {
    "test.op_with_region_pattern"() ({
      "test.op_with_region_terminator"() : () -> ()
    }) : () -> ()
    return
  }
}

