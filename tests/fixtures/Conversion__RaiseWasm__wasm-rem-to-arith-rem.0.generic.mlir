"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "rem_ui_32"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %15 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg7, %15) : (i32, memref<i32>) -> ()
    %16 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg6, %16) : (i32, memref<i32>) -> ()
    %17 = "memref.load"(%16) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %18 = "memref.load"(%15) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %19 = "arith.remui"(%17, %18) : (i32, i32) -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "rem_si_32"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %10 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg5, %10) : (i32, memref<i32>) -> ()
    %11 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg4, %11) : (i32, memref<i32>) -> ()
    %12 = "memref.load"(%11) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %13 = "memref.load"(%10) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %14 = "arith.remsi"(%12, %13) : (i32, i32) -> i32
    "func.return"(%14) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "rem_ui_64"}> ({
  ^bb0(%arg2: i64, %arg3: i64):
    %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg3, %5) : (i64, memref<i64>) -> ()
    %6 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg2, %6) : (i64, memref<i64>) -> ()
    %7 = "memref.load"(%6) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %8 = "memref.load"(%5) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %9 = "arith.remui"(%7, %8) : (i64, i64) -> i64
    "func.return"(%9) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "rem_si_64"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg1, %0) : (i64, memref<i64>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg0, %1) : (i64, memref<i64>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %4 = "arith.remsi"(%2, %3) : (i64, i64) -> i64
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

