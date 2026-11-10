"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "func_0"}> ({
    %11 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %12 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "memref.store"(%12, %11) : (f32, memref<f32>) -> ()
    %13 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %14 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "memref.store"(%14, %13) : (f32, memref<f32>) -> ()
    %15 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "memref.store"(%15, %11) <{nontemporal = false}> : (f32, memref<f32>) -> ()
    %16 = "memref.load"(%11) <{invariant = false, nontemporal = false}> : (memref<f32>) -> f32
    %17 = "arith.constant"() <{value = 1.200000e+01 : f32}> : () -> f32
    "memref.store"(%17, %13) : (f32, memref<f32>) -> ()
    %18 = "arith.addf"(%16, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%18) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "func_1"}> ({
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "memref.store"(%4, %3) : (i32, memref<i32>) -> ()
    %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "memref.store"(%6, %5) : (i32, memref<i32>) -> ()
    %7 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    "memref.store"(%7, %3) <{nontemporal = false}> : (i32, memref<i32>) -> ()
    %8 = "memref.load"(%3) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %9 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    "memref.store"(%9, %5) : (i32, memref<i32>) -> ()
    %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_2"}> ({
  ^bb0(%arg0: i32):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg0, %0) : (i32, memref<i32>) -> ()
    %1 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    "memref.store"(%1, %0) <{nontemporal = false}> : (i32, memref<i32>) -> ()
    %2 = "memref.load"(%0) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

