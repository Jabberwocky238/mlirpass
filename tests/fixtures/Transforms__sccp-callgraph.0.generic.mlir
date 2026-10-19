"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "private", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simple_private"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "func.call"(%0) <{callee = @private}> : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "nested", sym_visibility = "nested"}> ({
  ^bb0(%arg0: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simple_nested"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "func.call"(%0) <{callee = @nested}> : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() <{sym_name = "nested_module", sym_visibility = "public"}> ({
    "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "nested", sym_visibility = "nested"}> ({
    ^bb0(%arg0: i32):
      %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "func.return"(%2, %2) : (i32, i32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (i32, i32), sym_name = "nested_not_all_uses_visible"}> ({
      %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %1:2 = "func.call"(%0) <{callee = @nested}> : (i32) -> (i32, i32)
      "func.return"(%0, %0) : (i32, i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "public"}> ({
  ^bb0(%arg0: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%2, %arg0) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "simple_public"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1:2 = "func.call"(%0) <{callee = @public}> : (i32) -> (i32, i32)
    "func.return"(%0, %1#1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "callable", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%2, %arg0) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "non_call_users"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1:2 = "func.call"(%0) <{callee = @callable}> : (i32) -> (i32, i32)
    "func.return"(%0, %1#1) : (i32, i32) -> ()
  }) : () -> ()
  "live.user"() {uses = [@callable]} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "callable", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "unknown.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "unknown_terminator"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "func.call"(%0) <{callee = @callable}> : (i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "callable", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "conflicting_constant"}> ({
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "func.call"(%1) <{callee = @callable}> : (i32) -> i32
    %3 = "func.call"(%0) <{callee = @callable}> : (i32) -> i32
    "func.return"(%2, %3) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "callable", sym_visibility = "private"}> ({
  ^bb0(%arg1: i32):
    "unknown.return"(%arg1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "conflicting_constant"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "func.call"(%0) <{callee = @callable}> : (i32) -> i32
    %2 = "func.call"(%arg0) <{callee = @callable}> : (i32) -> i32
    "func.return"(%1, %2) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "complex_inner_if", sym_visibility = "private"}> ({
  ^bb0(%arg2: i32):
    %6 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = true}> : () -> i1
    %8 = "arith.constant"() <{value = 20 : i32}> : () -> i32
    "cf.cond_br"(%7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%6) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %9 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %10 = "arith.addi"(%6, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "complex_cond", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "complex_callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "func.call"() <{callee = @complex_cond}> : () -> i1
    "cf.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%2) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %4 = "func.call"(%2) <{callee = @complex_inner_if}> : (i32) -> i32
    %5 = "func.call"(%2) <{callee = @complex_callee}> : (i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "complex_caller"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "func.call"(%0) <{callee = @complex_callee}> : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "non_symbol_defining_callable"}> ({
    %0 = "test.functional_region_op"() ({
      %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "test.return"(%2) : (i32) -> ()
    }) : () -> (() -> i32)
    %1 = "func.call_indirect"(%0) : (() -> i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "unreferenced_private_function", sym_visibility = "private"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.select"(%0, %1, %2) : (i1, i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "foo", sym_visibility = "private"}> ({
    %6 = "arith.constant"() <{value = 10 : index}> : () -> index
    "func.return"(%6) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "bar"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "arith.constant"() <{value = 420 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.cmpi"(%arg0, %2) <{predicate = 0 : i64}> : (index, index) -> i1
    "cf.cond_br"(%3, %1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, index) -> ()
  ^bb1(%4: index):  // 2 preds: ^bb0, ^bb2
    "func.return"(%4) : (index) -> ()
  ^bb2:  // pred: ^bb0
    %5 = "func.call"() <{callee = @foo}> : () -> index
    "cf.br"(%0)[^bb1] : (index) -> ()
  }) : () -> ()
}) : () -> ()

