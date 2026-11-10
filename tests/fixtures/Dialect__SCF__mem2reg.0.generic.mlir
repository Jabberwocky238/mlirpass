"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "if_load_only"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.if"(%arg0) ({
      "scf.yield"(%0) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "if_no_else_load"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.if"(%arg0) ({
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.call"(%0) <{callee = @use}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "if_no_else_store"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.if"(%arg0) ({
      "scf.yield"(%1) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.call"(%2) <{callee = @use}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "if_nested_store"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.if"(%arg0) ({
      %3 = "scf.if"(%arg1) ({
        "scf.yield"(%1) : (i32) -> ()
      }, {
        "scf.yield"(%0) : (i32) -> ()
      }) : (i1) -> i32
      "scf.yield"(%3) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.call"(%2) <{callee = @use}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "if_load_into_store"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.if"(%arg0) ({
      "scf.yield"(%0) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "if_load_then_nested_if_store"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.if"(%arg0) ({
      %2 = "scf.if"(%arg1) ({
        "scf.yield"(%0) : (i32) -> ()
      }, {
        "scf.yield"(%0) : (i32) -> ()
      }) : (i1) -> i32
      "scf.yield"(%2) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "execute_region_load"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.execute_region"() ({
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "execute_region_store"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.execute_region"() ({
      "scf.yield"(%1) : (i32) -> ()
    }) : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "execute_region_cfg"}> ({
  ^bb0(%arg4: i1, %arg5: i1):
    %10 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %11 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %13 = "scf.execute_region"() ({
      "cf.cond_br"(%arg4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "cf.br"(%11)[^bb3] : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "cf.br"(%12)[^bb3] : (i32) -> ()
    ^bb3(%14: i32):  // 2 preds: ^bb1, ^bb2
      "scf.if"(%arg5) ({
        "func.call"(%14) <{callee = @use}> : (i32) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"(%14) : (i32) -> ()
    }) : () -> i32
    "func.call"(%13) <{callee = @use}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "execute_region_cfg_no_use_at_all"}> ({
  ^bb0(%arg2: i1, %arg3: i1):
    %5 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %8 = "scf.execute_region"() ({
      "cf.cond_br"(%arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "cf.br"(%6)[^bb3] : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "cf.br"(%7)[^bb3] : (i32) -> ()
    ^bb3(%9: i32):  // 2 preds: ^bb1, ^bb2
      "scf.yield"(%9) : (i32) -> ()
    }) : () -> i32
    "func.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "execute_region_cfg_with_store"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 11 : i32}> : () -> i32
    %4 = "scf.execute_region"() ({
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "cf.br"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "cf.br"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "scf.yield"(%3) : (i32) -> ()
    }) : () -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "execute_region_multiple_yields"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %3 = "scf.execute_region"() ({
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "scf.yield"(%1) : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "scf.yield"(%2) : (i32) -> ()
    }) : () -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "execute_region_same_reaching_def"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.execute_region"() ({
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "scf.yield"(%1) : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "scf.yield"(%1) : (i32) -> ()
    }) : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "execute_region_load_into_store_same_block"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.execute_region"() ({
      "scf.yield"(%0) : (i32) -> ()
    }) : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "execute_region_load_into_store_diff_block"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.execute_region"() ({
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "scf.yield"(%0) : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "scf.yield"(%0) : (i32) -> ()
    }) : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "for_load_and_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: i32):
      %3 = "arith.addi"(%arg4, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%3) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i32) -> i32, sym_name = "for_existing_iter_arg"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i32):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2:2 = "scf.for"(%arg0, %arg1, %arg2, %arg3, %0) ({
    ^bb0(%arg4: index, %arg5: i32, %arg6: i32):
      %3 = "arith.muli"(%arg5, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %4 = "arith.addi"(%arg6, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%3, %4) : (i32, i32) -> ()
    }) : (index, index, index, i32, i32) -> (i32, i32)
    "func.return"(%2#1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "for_load_only"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i1) -> i32, sym_name = "for_if_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg4: index, %arg5: i32):
      %3 = "scf.if"(%arg3) ({
        "scf.yield"(%1) : (i32) -> ()
      }, {
        "scf.yield"(%arg5) : (i32) -> ()
      }) : (i1) -> i32
      "scf.yield"(%3) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "for_load_into_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: i32):
      "scf.yield"(%arg4) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "forall_load"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index):
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, i1) -> i32, sym_name = "forall_in_if"}> ({
  ^bb0(%arg0: index, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.if"(%arg1) ({
      "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
      ^bb0(%arg2: index):
        "func.call"(%1) <{callee = @use}> : (i32) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index) -> ()
      "scf.yield"(%1) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "parallel_load"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.parallel"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg3: index):
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i1) -> i32, sym_name = "parallel_in_if"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.if"(%arg3) ({
      "scf.parallel"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
      ^bb0(%arg4: index):
        "func.call"(%1) <{callee = @use}> : (i32) -> ()
        "scf.reduce"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"(%1) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "parallel_reduce_load"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "scf.parallel"(%arg0, %arg1, %arg2, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
    ^bb0(%arg3: index):
      %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.reduce"(%3) ({
      ^bb0(%arg4: i32, %arg5: i32):
        %4 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %5 = "arith.muli"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "scf.reduce.return"(%5) : (i32) -> ()
      }) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "while_load_before"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.while"() ({
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "while_load_after"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.while"() ({
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "while_store_before_load_after"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.while"(%0) ({
    ^bb0(%arg2: i32):
      "scf.condition"(%arg0, %1) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      "func.call"(%arg1) <{callee = @use}> : (i32) -> ()
      "scf.yield"(%arg1) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "while_store_before_load_after_loop"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.while"(%0) ({
    ^bb0(%arg2: i32):
      "scf.condition"(%arg0, %1) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      "scf.yield"(%arg1) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "while_store"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %3 = "scf.while"(%0) ({
    ^bb0(%arg1: i32):
      %5 = "arith.cmpi"(%arg1, %2) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%5, %arg1) : (i1, i32) -> ()
    }, {
    ^bb0(%arg0: i32):
      %4 = "arith.addi"(%arg0, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%4) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "while_load_into_store_before"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.while"(%0) ({
    ^bb0(%arg2: i32):
      "scf.condition"(%arg0, %arg2) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      "scf.yield"(%arg1) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "while_load_into_store"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.while"(%0) ({
    ^bb0(%arg2: i32):
      "scf.condition"(%arg0, %arg2) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      "scf.yield"(%arg1) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_switch_load_default"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.index_switch"(%arg0) <{cases = array<i64>}> ({
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> i32, sym_name = "index_switch_store_default"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.index_switch"(%arg0) <{cases = array<i64>}> ({
      "scf.yield"(%1) : (i32) -> ()
    }) : (index) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> i32, sym_name = "index_switch_store_case_load_default"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "scf.index_switch"(%arg0) <{cases = array<i64: 0>}> ({
      "func.call"(%0) <{callee = @use}> : (i32) -> ()
      "scf.yield"(%0) : (i32) -> ()
    }, {
      "scf.yield"(%1) : (i32) -> ()
    }) : (index) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> i32, sym_name = "index_switch_load_into_store"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "scf.index_switch"(%arg0) <{cases = array<i64: 0>}> ({
      "scf.yield"(%0) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (index) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

