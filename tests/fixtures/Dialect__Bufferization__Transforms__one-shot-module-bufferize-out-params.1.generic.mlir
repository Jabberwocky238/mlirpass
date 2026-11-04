"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>, memref<5xf32>) -> (), sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: memref<5xf32>, %arg2: memref<5xf32>):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %6 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%arg1, %6) : (memref<5xf32>, memref<5xf32>) -> ()
    "memref.store"(%5, %6, %4) <{nontemporal = false}> : (f32, memref<5xf32>, index) -> ()
    "memref.copy"(%6, %arg2) : (memref<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32>) -> (f32, f32), sym_name = "main"}> ({
  ^bb0(%arg0: memref<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "func.call"(%arg0, %1) <{callee = @callee}> : (memref<5xf32>, memref<5xf32>) -> ()
    %2 = "memref.load"(%arg0, %0) <{nontemporal = false}> : (memref<5xf32>, index) -> f32
    %3 = "memref.load"(%1, %0) <{nontemporal = false}> : (memref<5xf32>, index) -> f32
    "func.return"(%2, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<2x5xf32>) -> (), sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: index, %arg2: memref<2x5xf32>):
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10x20xf32>
    %4 = "memref.subview"(%3, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (memref<10x20xf32>, index, index) -> memref<2x5xf32, strided<[20, 1], offset: ?>>
    %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x5xf32>
    "memref.copy"(%4, %5) : (memref<2x5xf32, strided<[20, 1], offset: ?>>, memref<2x5xf32>) -> ()
    "memref.copy"(%5, %arg2) : (memref<2x5xf32>, memref<2x5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x5xf32>
    "func.call"(%arg0, %1) <{callee = @callee}> : (index, memref<2x5xf32>) -> ()
    %2 = "memref.load"(%1, %0, %0) <{nontemporal = false}> : (memref<2x5xf32>, index, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

