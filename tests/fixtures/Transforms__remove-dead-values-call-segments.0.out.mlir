"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "callee", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "caller"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "test.call_with_segments"() <{callee = @callee, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

