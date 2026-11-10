"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "div_i32_si"}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %25 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg11, %25) : (i32, memref<i32>) -> ()
    %26 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg10, %26) : (i32, memref<i32>) -> ()
    %27 = "memref.load"(%26) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %28 = "memref.load"(%25) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %29 = "arith.divsi"(%27, %28) : (i32, i32) -> i32
    "func.return"(%29) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "div_i64_si"}> ({
  ^bb0(%arg8: i64, %arg9: i64):
    %20 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg9, %20) : (i64, memref<i64>) -> ()
    %21 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg8, %21) : (i64, memref<i64>) -> ()
    %22 = "memref.load"(%21) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %23 = "memref.load"(%20) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %24 = "arith.divsi"(%22, %23) : (i64, i64) -> i64
    "func.return"(%24) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "div_i32_ui"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %15 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg7, %15) : (i32, memref<i32>) -> ()
    %16 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg6, %16) : (i32, memref<i32>) -> ()
    %17 = "memref.load"(%16) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %18 = "memref.load"(%15) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %19 = "arith.divui"(%17, %18) : (i32, i32) -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "div_i64_ui"}> ({
  ^bb0(%arg4: i64, %arg5: i64):
    %10 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg5, %10) : (i64, memref<i64>) -> ()
    %11 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg4, %11) : (i64, memref<i64>) -> ()
    %12 = "memref.load"(%11) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %13 = "memref.load"(%10) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %14 = "arith.divui"(%12, %13) : (i64, i64) -> i64
    "func.return"(%14) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "div_f32"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg3, %5) : (f32, memref<f32>) -> ()
    %6 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg2, %6) : (f32, memref<f32>) -> ()
    %7 = "memref.load"(%6) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %8 = "memref.load"(%5) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %9 = "arith.divf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%9) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> f64, sym_name = "div_f64"}> ({
  ^bb0(%arg0: f64, %arg1: f64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "memref.store"(%arg1, %0) : (f64, memref<f64>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "memref.store"(%arg0, %1) : (f64, memref<f64>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<f64>) -> f64
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<f64>) -> f64
    %4 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%4) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

