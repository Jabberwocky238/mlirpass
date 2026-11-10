"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "sqrt_f32"}> ({
  ^bb0(%arg1: f32):
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg1, %3) : (f32, memref<f32>) -> ()
    %4 = "memref.load"(%3) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %5 = "math.sqrt"(%4) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> f64, sym_name = "sqrt_f64"}> ({
  ^bb0(%arg0: f64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "memref.store"(%arg0, %0) : (f64, memref<f64>) -> ()
    %1 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<f64>) -> f64
    %2 = "math.sqrt"(%1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%2) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

