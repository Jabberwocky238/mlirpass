"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "foo0"}> ({
  ^bb0(%arg1: i32):
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.cmpi"(%arg1, %3) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%3) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %5 = "func.call"(%arg1) <{callee = @foo1}> : (i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "foo1"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.subi"(%arg0, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "func.call"(%1) <{callee = @foo0}> : (i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

