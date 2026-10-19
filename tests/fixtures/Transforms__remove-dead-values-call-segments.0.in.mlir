"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %0 = "arith.addi"(%arg2, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "caller"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "test.call_with_segments"(%arg0, %arg1) <{callee = @callee, operandSegmentSizes = array<i32: 0, 2, 0>}> : (i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

