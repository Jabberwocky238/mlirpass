"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> (), sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: memref<5xf32, strided<[?], offset: ?>>, %arg2: memref<5xf32, strided<[?], offset: ?>>):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %7 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%arg1, %7) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    "memref.store"(%6, %7, %5) <{nontemporal = false}> : (f32, memref<5xf32>, index) -> ()
    %8 = "memref.cast"(%7) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    "memref.copy"(%8, %arg2) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>) -> (f32, f32), sym_name = "main"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %2 = "memref.cast"(%1) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    "func.call"(%arg0, %2) <{callee = @callee}> : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> ()
    %3 = "memref.load"(%arg0, %0) <{nontemporal = false}> : (memref<5xf32, strided<[?], offset: ?>>, index) -> f32
    %4 = "memref.load"(%2, %0) <{nontemporal = false}> : (memref<5xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%3, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<2x5xf32, strided<[?, ?], offset: ?>>) -> (), sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: index, %arg2: memref<2x5xf32, strided<[?, ?], offset: ?>>):
    %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10x20xf32>
    %5 = "memref.subview"(%4, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (memref<10x20xf32>, index, index) -> memref<2x5xf32, strided<[20, 1], offset: ?>>
    %6 = "memref.cast"(%5) : (memref<2x5xf32, strided<[20, 1], offset: ?>>) -> memref<2x5xf32, strided<[?, ?], offset: ?>>
    "memref.copy"(%6, %arg2) : (memref<2x5xf32, strided<[?, ?], offset: ?>>, memref<2x5xf32, strided<[?, ?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x5xf32>
    %2 = "memref.cast"(%1) : (memref<2x5xf32>) -> memref<2x5xf32, strided<[?, ?], offset: ?>>
    "func.call"(%arg0, %2) <{callee = @callee}> : (index, memref<2x5xf32, strided<[?, ?], offset: ?>>) -> ()
    %3 = "memref.load"(%2, %0, %0) <{nontemporal = false}> : (memref<2x5xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

