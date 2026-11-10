"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "clz_i32"}> ({
  ^bb0(%arg1: i32):
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg1, %3) : (i32, memref<i32>) -> ()
    %4 = "memref.load"(%3) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %5 = "math.ctlz"(%4) : (i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "clz_i64"}> ({
  ^bb0(%arg0: i64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg0, %0) : (i64, memref<i64>) -> ()
    %1 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %2 = "math.ctlz"(%1) : (i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

