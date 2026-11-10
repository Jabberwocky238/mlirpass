"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i32, sym_name = "i64_wrap"}> ({
  ^bb0(%arg0: i64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg0, %0) : (i64, memref<i64>) -> ()
    %1 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %2 = "arith.trunci"(%1) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

