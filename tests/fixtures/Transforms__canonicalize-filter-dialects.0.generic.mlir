"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "pattern_test"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.addi"(%arg0, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

