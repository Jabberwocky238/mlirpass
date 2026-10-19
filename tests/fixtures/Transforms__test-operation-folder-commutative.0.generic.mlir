"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_reorder_constants_and_match"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 43 : i32}> : () -> i32
    %1 = "test.op_commutative2"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

