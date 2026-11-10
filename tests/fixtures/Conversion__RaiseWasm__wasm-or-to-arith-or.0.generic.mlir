"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "or_i32"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg3, %5) : (i32, memref<i32>) -> ()
    %6 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg2, %6) : (i32, memref<i32>) -> ()
    %7 = "memref.load"(%6) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %8 = "memref.load"(%5) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %9 = "arith.ori"(%7, %8) : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "or_i64"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg1, %0) : (i64, memref<i64>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg0, %1) : (i64, memref<i64>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %4 = "arith.ori"(%2, %3) : (i64, i64) -> i64
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

