"builtin.module"() ({
  "func.func"() <{function_type = (index) -> i32, sym_name = "forall_store"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index):
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> i32, sym_name = "forall_if_store"}> ({
  ^bb0(%arg0: index, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index):
      "scf.if"(%arg1) ({
        "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "parallel_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.parallel"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg3: index):
      "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i1) -> i32, sym_name = "parallel_if_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "scf.parallel"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg4: index):
      "scf.if"(%arg3) ({
        "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "parallel_reduce_store"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    %3 = "scf.parallel"(%arg0, %arg1, %arg2, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
    ^bb0(%arg3: index):
      %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.reduce"(%5) ({
      ^bb0(%arg4: i32, %arg5: i32):
        %6 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "memref.store"(%6, %2) : (i32, memref<i32>) -> ()
        "scf.reduce.return"(%6) : (i32) -> ()
      }) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    %4 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

