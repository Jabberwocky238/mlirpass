"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "update_no_op"}> ({
  ^bb0(%arg0: memref<i32>):
    "omp.atomic.update"(%arg0) ({
    ^bb0(%arg1: i32):
      "omp.yield"(%arg1) : (i32) -> ()
    }) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>, i32) -> (), sym_name = "update_write_op"}> ({
  ^bb0(%arg0: memref<i32>, %arg1: i32):
    "omp.atomic.update"(%arg0) ({
    ^bb0(%arg2: i32):
      "omp.yield"(%arg1) : (i32) -> ()
    }) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>, i32) -> (), sym_name = "update_normal"}> ({
  ^bb0(%arg0: memref<i32>, %arg1: i32):
    "omp.atomic.update"(%arg0) ({
    ^bb0(%arg2: i32):
      %0 = "arith.addi"(%arg2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "omp.yield"(%0) : (i32) -> ()
    }) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "update_unnecessary_computations"}> ({
  ^bb0(%arg0: memref<i32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "omp.atomic.update"(%arg0) ({
    ^bb0(%arg1: i32):
      %1 = "arith.addi"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "omp.yield"(%1) : (i32) -> ()
    }) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "update_unnecessary_computations"}> ({
  ^bb0(%arg0: memref<i32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "omp.atomic.update"(%arg0) ({
    ^bb0(%arg1: i32):
      %1 = "arith.muli"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "omp.yield"(%1) : (i32) -> ()
    }) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_empty"}> ({
    "omp.parallel"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 0, 0>}> ({
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_only_terminator"}> ({
    "omp.parallel"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 0, 0>}> ({
      "omp.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "parallel_no_side_effects"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "omp.parallel"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 0, 0>}> ({
      %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "omp.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "parallel_maybe_side_effects"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "omp.parallel"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 0, 0>}> ({
      "func.call"() <{callee = @foo}> : () -> ()
      "omp.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "constant_hoisting_target"}> ({
  ^bb0(%arg0: !llvm.ptr):
    "omp.target"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: !llvm.ptr):
      %0 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "llvm.store"(%0, %arg1) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "omp.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

