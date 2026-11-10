"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<10xf32>, sym_name = "create_tensor"}> ({
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %3 = "memref.cast"(%2) : (memref<10xf32>) -> memref<10xf32, strided<[?], offset: ?>>
    "func.return"(%2) : (memref<10xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> f32, sym_name = "caller"}> ({
  ^bb0(%arg0: index):
    %0 = "func.call"() <{callee = @create_tensor}> : () -> memref<10xf32>
    %1 = "memref.load"(%0, %arg0) <{invariant = false, nontemporal = false}> : (memref<10xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "return_slice"}> ({
  ^bb0(%arg5: memref<?xf32, strided<[?], offset: ?>>, %arg6: index):
    %7 = "memref.subview"(%arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 4>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%7) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, index) -> (f32, f32), sym_name = "main"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "func.call"(%arg0, %arg1) <{callee = @return_slice}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%1, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
    %5 = "memref.load"(%4, %arg2) <{invariant = false, nontemporal = false}> : (memref<?xf32>, index) -> f32
    %6 = "memref.load"(%arg0, %arg2) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%5, %6) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "return_arg", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

