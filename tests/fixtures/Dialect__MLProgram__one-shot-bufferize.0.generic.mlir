"builtin.module"() ({
  "memref.global"() <{initial_value = dense<0> : tensor<i64>, sym_name = "global", sym_visibility = "private", type = memref<i64>}> : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "global_load_store"}> ({
    %0 = "arith.constant"() <{value = 127 : i64}> : () -> i64
    %1 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.copy"(%1, %4) : (memref<i64>, memref<i64>) -> ()
    "memref.store"(%3, %4) <{nontemporal = false}> : (i64, memref<i64>) -> ()
    %5 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    "memref.copy"(%4, %5) : (memref<i64>, memref<i64>) -> ()
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{initial_value = dense<0> : tensor<i64>, sym_name = "global", sym_visibility = "private", type = memref<i64>}> : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "raw_hazard"}> ({
    %0 = "arith.constant"() <{value = 127 : i64}> : () -> i64
    %1 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    %2 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.copy"(%1, %3) : (memref<i64>, memref<i64>) -> ()
    "memref.store"(%0, %3) <{nontemporal = false}> : (i64, memref<i64>) -> ()
    %4 = "memref.load"(%2) <{invariant = false, nontemporal = false}> : (memref<i64>) -> i64
    %5 = "memref.get_global"() <{name = @global}> : () -> memref<i64>
    "memref.copy"(%3, %5) : (memref<i64>, memref<i64>) -> ()
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{initial_value = dense<0.000000e+00> : tensor<4x75xf32>, sym_name = "state_tensor", sym_visibility = "private", type = memref<4x75xf32>}> : () -> ()
  "func.func"() <{function_type = () -> tensor<4x75xf32>, sym_name = "global_load_store_tensor"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "memref.get_global"() <{name = @state_tensor}> : () -> memref<4x75xf32>
    %3 = "memref.load"(%2, %0, %0) <{invariant = false, nontemporal = false}> : (memref<4x75xf32>, index, index) -> f32
    %4 = "arith.addf"(%3, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x75xf32>
    "memref.copy"(%2, %5) : (memref<4x75xf32>, memref<4x75xf32>) -> ()
    "memref.store"(%4, %5, %0, %0) <{nontemporal = false}> : (f32, memref<4x75xf32>, index, index) -> ()
    %6 = "bufferization.to_tensor"(%5) : (memref<4x75xf32>) -> tensor<4x75xf32>
    %7 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x75xf32>
    "memref.copy"(%5, %7) : (memref<4x75xf32>, memref<4x75xf32>) -> ()
    %8 = "memref.get_global"() <{name = @state_tensor}> : () -> memref<4x75xf32>
    "memref.copy"(%7, %8) : (memref<4x75xf32>, memref<4x75xf32>) -> ()
    "func.return"(%6) : (tensor<4x75xf32>) -> ()
  }) : () -> ()
}) : () -> ()

