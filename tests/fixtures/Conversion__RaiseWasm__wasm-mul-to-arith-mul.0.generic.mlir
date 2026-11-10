"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "mul_i32"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg1, %0) : (i32, memref<i32>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg0, %1) : (i32, memref<i32>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %4 = "arith.muli"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "mul_i64"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg1, %0) : (i64, memref<i64>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg0, %1) : (i64, memref<i64>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %4 = "arith.muli"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "mul_f32"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg1, %0) : (f32, memref<f32>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg0, %1) : (f32, memref<f32>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %4 = "arith.mulf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64, f64) -> f64, sym_name = "mul_f64"}> ({
  ^bb0(%arg0: f64, %arg1: f64):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "memref.store"(%arg1, %0) : (f64, memref<f64>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "memref.store"(%arg0, %1) : (f64, memref<f64>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<f64>) -> f64
    %3 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<f64>) -> f64
    %4 = "arith.mulf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%4) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

