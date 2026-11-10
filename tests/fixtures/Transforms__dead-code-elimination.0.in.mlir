"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> i16, sym_name = "simple_test"}> ({
  ^bb0(%arg0: i16):
    %0 = "arith.constant"() <{value = 5 : i16}> : () -> i16
    %1 = "arith.addi"(%0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %2 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %3 = "arith.addi"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "func.return"(%1) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "eliminate_from_region"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      %0 = "arith.constant"() <{value = 5 : i16}> : () -> i16
      %1 = "arith.constant"() <{value = 10 : i16}> : () -> i16
      "test.print"(%0) : (i16) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "eliminate_op_with_region"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: i16):
      %2 = "arith.constant"() <{value = 5 : i16}> : () -> i16
      %3 = "arith.addi"(%arg4, %2) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
      "scf.yield"(%3) : (i16) -> ()
    }) : (index, index, index, i16) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> i16, sym_name = "unstructured_control_flow"}> ({
  ^bb0(%arg0: i16):
    %0 = "arith.constant"() <{value = 5 : i16}> : () -> i16
    "cf.br"()[^bb2] : () -> ()
  ^bb1:  // pred: ^bb2
    %1 = "arith.addi"(%3, %3) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %2 = "arith.addi"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    %3 = "arith.addi"(%0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %4 = "arith.subi"(%0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%3) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "remove_dead_block"}> ({
    "cf.br"()[^bb2] : () -> ()
  ^bb1:  // no predecessors
    %0 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "potentially_side_effecting_op"}> ({
    "test.print"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16, i1) -> (), sym_name = "miss_nested_operand_of_erased_op"}> ({
  ^bb0(%arg0: i16, %arg1: i1):
    "cf.br"()[^bb3] : () -> ()
  ^bb1:  // pred: ^bb2
    %0 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "cf.br"()[^bb4] : () -> ()
  ^bb2:  // pred: ^bb3
    %1 = "scf.if"(%arg1) ({
      %3 = "arith.addi"(%2, %2) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
      "scf.yield"(%3) : (i16) -> ()
    }, {
      "scf.yield"(%2) : (i16) -> ()
    }) : (i1) -> i16
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb0
    %2 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "cf.br"()[^bb2] : () -> ()
  ^bb4:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.graph_region"() ({
    %0 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %1 = "arith.constant"() <{value = 5 : i16}> : () -> i16
    %2 = "test.baz"() : () -> i32
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.graph_region"() ({
    %0 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %1 = "arith.addi"(%0, %0) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %2 = "test.baz"() : () -> i32
  }) {cycle} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "dead_blocks"}> ({
    "cf.br"()[^bb3] : () -> ()
  ^bb1:  // pred: ^bb2
    "test.print"() : () -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

