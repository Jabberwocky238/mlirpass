"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "min_f32"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg3, %5) : (f32, memref<f32>) -> ()
    %6 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg2, %6) : (f32, memref<f32>) -> ()
    %7 = "memref.load"(%6) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %8 = "memref.load"(%5) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %9 = "arith.minimumf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%9) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> f64, sym_name = "min_f64"}> ({
  ^bb0(%arg0: f64, %arg1: f64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "memref.store"(%arg1, %0) : (f64, memref<f64>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "memref.store"(%arg0, %1) : (f64, memref<f64>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<f64>) -> f64
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<f64>) -> f64
    %4 = "arith.minimumf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%4) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

