"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "unusedCast"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    "func.return"(%arg0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "sameTypes"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i64
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "pair"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "symmetricChain"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i1
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> i32
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i32) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "asymmetricChain"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i1
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "unusedChain"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i1
    "func.return"(%arg0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "bifurcation"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i1
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> i32
    %4 = "builtin.unrealized_conversion_cast"(%3) : (i32) -> i64
    %5 = "arith.addi"(%2, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "unusedBifurcation"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i1
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i64
    %4 = "arith.addi"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i32, sym_name = "liveSingleCast"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i32, sym_name = "liveChain"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i1
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "liveBifurcation"}> ({
  ^bb0(%arg0: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i1
    %3 = "arith.extsi"(%2) : (i1) -> i64
    %4 = "arith.addi"(%1, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "deadNToOneCast"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0, %arg1) : (index, index) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "swappingOperands"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:2 = "builtin.unrealized_conversion_cast"(%arg0, %arg1) : (index, index) -> (i64, i64)
    %1:2 = "builtin.unrealized_conversion_cast"(%0#1, %0#0) : (i64, i64) -> (i32, i32)
    %2:2 = "builtin.unrealized_conversion_cast"(%1#0, %1#1) : (i32, i32) -> (index, index)
    "func.return"(%2#0, %2#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "matchingOperands"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:2 = "builtin.unrealized_conversion_cast"(%arg0, %arg1) : (index, index) -> (i64, i64)
    %1:3 = "builtin.unrealized_conversion_cast"(%0#0, %0#1) : (i64, i64) -> (i32, i32, i32)
    %2:2 = "builtin.unrealized_conversion_cast"(%1#0, %1#1, %1#2) : (i32, i32, i32) -> (index, index)
    "func.return"(%2#0, %2#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "emptyCast"}> ({
    %0 = "builtin.unrealized_conversion_cast"() : () -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.graph_region"() ({
    %0 = "builtin.unrealized_conversion_cast"(%2) : (i32) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> i16
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> i32
    "test.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.graph_region"() ({
    %0 = "builtin.unrealized_conversion_cast"(%2) : (i32) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> i16
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> i32
    "test.user"(%2) : (i32) -> ()
    "test.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.graph_region"() ({
    %0 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> i32
    "test.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.graph_region"() ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1:2 = "builtin.unrealized_conversion_cast"(%0, %1#1) : (i32, i32) -> (i32, i32)
    "test.user"(%1#0) : (i32) -> ()
    "test.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

