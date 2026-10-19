"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "parent1"}> ({
  ^bb0(%arg2: i32):
    %9 = "func.call"(%arg2) <{callee = @child}> : (i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "parent2"}> ({
  ^bb0(%arg1: i32):
    %8 = "func.call"(%arg1) <{callee = @child}> : (i32) -> i32
    "func.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "child"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.cmpi"(%arg0, %0) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %3 = "scf.if"(%2) ({
      "scf.yield"(%arg0) : (i32) -> ()
    }, {
      %4 = "arith.addi"(%arg0, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "func.call"(%4) <{callee = @parent1}> : (i32) -> i32
      %6 = "func.call"(%4) <{callee = @parent2}> : (i32) -> i32
      %7 = "arith.addi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%7) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

