#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32>, sym_name = "foo"}> ({
  ^bb0(%arg2: memref<?xf32, strided<[?], offset: ?>>):
    %5 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "memref.dim"(%arg2, %7) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %9 = "memref.alloc"(%8) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg2, %9) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "memref.store"(%5, %9, %6) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
    %10 = "memref.cast"(%9) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%9) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index) -> vector<5xf32>, sym_name = "contains_to_buffer_op"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%2, %arg1, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%4) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

