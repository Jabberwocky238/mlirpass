"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, i1) -> (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>), sym_name = "write_to_select_op_source"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "memref.store"(%0, %4, %1) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
    %5 = "arith.select"(%arg2, %arg0, %arg1) : (i1, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    %6 = "memref.cast"(%4) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%5, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, i1) -> (f32, memref<?xf32, strided<[?], offset: ?>>), sym_name = "write_after_select_read_one"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %5 = "memref.cast"(%4) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %6 = "arith.select"(%arg2, %5, %arg1) : (i1, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    "memref.store"(%0, %6, %1) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    %7 = "memref.load"(%arg0, %1) <{nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%7, %6) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

