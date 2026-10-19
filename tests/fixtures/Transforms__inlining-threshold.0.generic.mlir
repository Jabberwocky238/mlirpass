"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "callee1"}> ({
  ^bb0(%arg1: i32):
    %1 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "arith.addi"(%1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "arith.addi"(%2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "caller1"}> ({
  ^bb0(%arg0: i32):
    %0 = "func.call"(%arg0) <{callee = @callee1}> : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

