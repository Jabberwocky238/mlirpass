"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "dup_subs"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "cascade"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i32, i32, i32) -> i32, sym_name = "nested"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "scf.for"(%arg0, %arg1, %arg2, %arg5) ({
    ^bb0(%arg6: index, %arg7: i32):
      %1 = "arith.index_cast"(%arg6) : (index) -> i32
      %2 = "arith.addi"(%arg7, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

