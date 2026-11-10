"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "if_load_only"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    %2 = "scf.if"(%arg0) ({
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "scf.yield"(%3) : (i32) -> ()
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
  "func.func"() <{function_type = (i1) -> (), sym_name = "if_no_else_load"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.if"(%arg0) ({
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%3) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.call"(%2) <{callee = @use}> : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.if"(%arg0) ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.call"(%3) <{callee = @use}> : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.if"(%arg0) ({
      "scf.if"(%arg1) ({
        "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.call"(%3) <{callee = @use}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "if_load_into_store"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.if"(%arg0) ({
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "if_load_then_nested_if_store"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.if"(%arg0) ({
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "scf.if"(%arg1) ({
        "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "execute_region_load"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      %2 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%2) <{callee = @use}> : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "execute_region_cfg"}> ({
  ^bb0(%arg4: i1, %arg5: i1):
    %11 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %14 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%11, %14) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      "cf.cond_br"(%arg4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "memref.store"(%12, %14) : (i32, memref<i32>) -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "memref.store"(%13, %14) : (i32, memref<i32>) -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "scf.if"(%arg5) ({
        %16 = "memref.load"(%14) : (memref<i32>) -> i32
        "func.call"(%16) <{callee = @use}> : (i32) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %15 = "memref.load"(%14) : (memref<i32>) -> i32
    "func.call"(%15) <{callee = @use}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "execute_region_cfg_no_use_at_all"}> ({
  ^bb0(%arg2: i1, %arg3: i1):
    %6 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%6, %9) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      "cf.cond_br"(%arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "memref.store"(%7, %9) : (i32, memref<i32>) -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "memref.store"(%8, %9) : (i32, memref<i32>) -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "scf.yield"() : () -> ()
    }) : () -> ()
    %10 = "memref.load"(%9) : (memref<i32>) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "execute_region_cfg_with_store"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 11 : i32}> : () -> i32
    %4 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %4) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "memref.store"(%1, %4) : (i32, memref<i32>) -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "memref.store"(%2, %4) : (i32, memref<i32>) -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "memref.store"(%3, %4) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %5 = "memref.load"(%4) : (memref<i32>) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "execute_region_multiple_yields"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %3) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "memref.store"(%1, %3) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    ^bb2:  // pred: ^bb0
      "memref.store"(%2, %3) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %4 = "memref.load"(%3) : (memref<i32>) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "execute_region_same_reaching_def"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "scf.yield"() : () -> ()
    ^bb2:  // pred: ^bb0
      "scf.yield"() : () -> ()
    }) : () -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "execute_region_load_into_store_same_block"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "execute_region_load_into_store_diff_block"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.execute_region"() ({
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    ^bb2:  // pred: ^bb0
      "scf.yield"() : () -> ()
    }) : () -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "for_load_and_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      %4 = "memref.load"(%2) : (memref<i32>) -> i32
      %5 = "arith.addi"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "memref.store"(%5, %2) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i32) -> i32, sym_name = "for_existing_iter_arg"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i32):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    %3 = "scf.for"(%arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg4: index, %arg5: i32):
      %5 = "arith.muli"(%arg5, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %6 = "memref.load"(%2) : (memref<i32>) -> i32
      %7 = "arith.addi"(%6, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "memref.store"(%7, %2) : (i32, memref<i32>) -> ()
      "scf.yield"(%5) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    %4 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "for_load_only"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%3) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i1) -> i32, sym_name = "for_if_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg4: index):
      "scf.if"(%arg3) ({
        "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "for_load_into_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "forall_load"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index):
      %2 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%2) <{callee = @use}> : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.if"(%arg1) ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
      ^bb0(%arg2: index):
        %4 = "memref.load"(%2) : (memref<i32>) -> i32
        "func.call"(%4) <{callee = @use}> : (i32) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "parallel_load"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.parallel"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg3: index):
      %2 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%2) <{callee = @use}> : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.if"(%arg3) ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.parallel"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
      ^bb0(%arg4: index):
        %4 = "memref.load"(%2) : (memref<i32>) -> i32
        "func.call"(%4) <{callee = @use}> : (i32) -> ()
        "scf.reduce"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "parallel_reduce_load"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    %3 = "scf.parallel"(%arg0, %arg1, %arg2, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
    ^bb0(%arg3: index):
      %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.reduce"(%4) ({
      ^bb0(%arg4: i32, %arg5: i32):
        %5 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %6 = "memref.load"(%2) : (memref<i32>) -> i32
        %7 = "arith.muli"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "scf.reduce.return"(%7) : (i32) -> ()
      }) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "while_load_before"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.while"() ({
      %2 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%2) <{callee = @use}> : (i32) -> ()
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
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.while"() ({
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      %2 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%2) <{callee = @use}> : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.while"() ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      %3 = "memref.load"(%2) : (memref<i32>) -> i32
      "func.call"(%3) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "while_store_before_load_after_loop"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.while"() ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "while_store"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %3) : (i32, memref<i32>) -> ()
    "scf.while"() ({
      %7 = "memref.load"(%3) : (memref<i32>) -> i32
      %8 = "arith.cmpi"(%7, %2) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%8) : (i1) -> ()
    }, {
      %5 = "memref.load"(%3) : (memref<i32>) -> i32
      %6 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "memref.store"(%6, %3) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %4 = "memref.load"(%3) : (memref<i32>) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "while_load_into_store_before"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.while"() ({
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "while_load_into_store"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.while"() ({
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_switch_load_default"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.index_switch"(%arg0) <{cases = array<i64>}> ({
      %2 = "memref.load"(%1) : (memref<i32>) -> i32
      "func.call"(%2) <{callee = @use}> : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.index_switch"(%arg0) <{cases = array<i64>}> ({
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.index_switch"(%arg0) <{cases = array<i64: 0>}> ({
      %4 = "memref.load"(%2) : (memref<i32>) -> i32
      "func.call"(%4) <{callee = @use}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }, {
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> i32, sym_name = "index_switch_load_into_store"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "scf.index_switch"(%arg0) <{cases = array<i64: 0>}> ({
      %4 = "memref.load"(%1) : (memref<i32>) -> i32
      "memref.store"(%4, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }, {
      %3 = "memref.load"(%1) : (memref<i32>) -> i32
      "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

