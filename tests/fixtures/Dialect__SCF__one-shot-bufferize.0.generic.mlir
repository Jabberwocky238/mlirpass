"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, index, index, index) -> memref<?xf32>, sym_name = "scf_for_yield_only", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "func.return"(%2) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, index, index) -> (f32, f32), sym_name = "scf_for_is_reading"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %5 = "scf.for"(%arg2, %arg3, %0, %4) ({
    ^bb0(%arg4: index, %arg5: memref<?xf32>):
      "linalg.fill"(%1, %arg5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32):
        "linalg.yield"(%arg6) : (f32) -> ()
      }) : (f32, memref<?xf32>) -> ()
      %8 = "memref.dim"(%arg1, %2) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
      %9 = "memref.alloc"(%8) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      "memref.copy"(%arg1, %9) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
      "scf.yield"(%9) : (memref<?xf32>) -> ()
    }) : (index, index, index, memref<?xf32>) -> memref<?xf32>
    %6 = "memref.load"(%5, %0) <{invariant = false, nontemporal = false}> : (memref<?xf32>, index) -> f32
    %7 = "memref.load"(%arg0, %0) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%6, %7) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, vector<5xf32>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "nested_scf_for"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg2: index):
      "scf.for"(%0, %2, %1) ({
      ^bb0(%arg3: index):
        "vector.transfer_write"(%arg1, %arg0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>, index, index, index) -> memref<?xf32>, sym_name = "scf_for_with_tensor.insert_slice", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "scf.for"(%arg3, %arg4, %arg5) ({
    ^bb0(%arg6: index):
      %3 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<4xf32, strided<[1]>>
      "memref.copy"(%arg2, %3) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[1]>>) -> ()
      %4 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
      "memref.copy"(%arg2, %4) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%2) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32>, f32), sym_name = "execute_region_with_conflict"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "memref.store"(%1, %4, %2) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
    %5 = "memref.load"(%arg0, %2) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%1, %4, %5) : (f32, memref<?xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<?xf32, strided<[?], offset: ?>>, vector<5xf32>, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "scf_if_inplace"}> ({
  ^bb0(%arg0: i1, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: vector<5xf32>, %arg3: index):
    "scf.if"(%arg0) ({
      "scf.yield"() : () -> ()
    }, {
      "vector.transfer_write"(%arg2, %arg1, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"(%arg1) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, vector<5xf32>, index, i1) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "scf_if_inside_scf_for"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<5xf32>, %arg2: index, %arg3: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg4: index):
      "scf.if"(%arg3) ({
        "scf.yield"() : () -> ()
      }, {
        "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>, sym_name = "scf_if_non_equiv_yields"}> ({
  ^bb0(%arg0: i1, %arg1: memref<4xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>):
    %0 = "arith.select"(%arg0, %arg1, %arg2) : (i1, memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
    "func.return"(%0) : (memref<4xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> f32, sym_name = "scf_execute_region_yield_non_equivalent"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %1 = "memref.load"(%0, %arg1) <{invariant = false, nontemporal = false}> : (memref<?xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, index, index) -> memref<?xf32>, sym_name = "scf_for_yield_non_equivalent"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "scf.for"(%arg1, %arg2, %arg3, %2) ({
    ^bb0(%arg4: index, %arg5: memref<?xf32>):
      %4 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      "memref.copy"(%arg0, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
      "scf.yield"(%4) : (memref<?xf32>) -> ()
    }) : (index, index, index, memref<?xf32>) -> memref<?xf32>
    "func.return"(%3) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, index, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "scf_for_yield_allocation"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: memref<?xf32, strided<[?], offset: ?>>):
      %1 = "memref.alloc"(%arg4) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      %2 = "memref.cast"(%1) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
      "scf.yield"(%2) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    }) : (index, index, index, memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>, index, index, index) -> (f32, f32), sym_name = "scf_for_swapping_yields"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1:2 = "scf.for"(%arg3, %arg4, %arg5, %arg0, %arg1) ({
    ^bb0(%arg6: index, %arg7: memref<?xf32, strided<[?], offset: ?>>, %arg8: memref<?xf32, strided<[?], offset: ?>>):
      %4 = "memref.subview"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
      "memref.copy"(%arg2, %4) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
      %5 = "memref.subview"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
      "memref.copy"(%arg2, %5) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
      %6 = "memref.dim"(%arg8, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
      %7 = "memref.alloc"(%6) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      "memref.copy"(%arg8, %7) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
      %8 = "memref.dim"(%arg7, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
      %9 = "memref.alloc"(%8) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      "memref.copy"(%arg7, %9) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
      %10 = "memref.cast"(%7) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
      %11 = "memref.cast"(%9) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
      "scf.yield"(%10, %11) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
    }) : (index, index, index, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>)
    %2 = "memref.load"(%1#0, %arg5) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    %3 = "memref.load"(%1#1, %arg5) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%2, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi1, strided<[?], offset: ?>>, index) -> memref<?xi1, strided<[?], offset: ?>>, sym_name = "scf_while"}> ({
  ^bb0(%arg0: memref<?xi1, strided<[?], offset: ?>>, %arg1: index):
    "scf.while"() ({
      %2 = "memref.load"(%arg0, %arg1) <{invariant = false, nontemporal = false}> : (memref<?xi1, strided<[?], offset: ?>>, index) -> i1
      "scf.condition"(%2) : (i1) -> ()
    }, {
      %0 = "dummy.some_op"() : () -> index
      %1 = "dummy.another_op"() : () -> i1
      "memref.store"(%1, %arg0, %0) <{nontemporal = false}> : (i1, memref<?xi1, strided<[?], offset: ?>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"(%arg0) : (memref<?xi1, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>, index) -> (memref<5xi1>, memref<5xi1>), sym_name = "scf_while_non_equiv_condition"}> ({
  ^bb0(%arg0: memref<5xi1, strided<[?], offset: ?>>, %arg1: memref<5xi1, strided<[?], offset: ?>>, %arg2: index):
    %0:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg5: memref<5xi1, strided<[?], offset: ?>>, %arg6: memref<5xi1, strided<[?], offset: ?>>):
      %5 = "memref.load"(%arg5, %arg2) <{invariant = false, nontemporal = false}> : (memref<5xi1, strided<[?], offset: ?>>, index) -> i1
      %6 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xi1>
      "memref.copy"(%arg6, %6) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1>) -> ()
      %7 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xi1>
      "memref.copy"(%arg5, %7) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1>) -> ()
      "scf.condition"(%5, %6, %7) : (i1, memref<5xi1>, memref<5xi1>) -> ()
    }, {
    ^bb0(%arg3: memref<5xi1>, %arg4: memref<5xi1>):
      %1 = "dummy.some_op"() : () -> index
      %2 = "dummy.another_op"() : () -> i1
      "memref.store"(%2, %arg3, %1) <{nontemporal = false}> : (i1, memref<5xi1>, index) -> ()
      %3 = "memref.cast"(%arg3) : (memref<5xi1>) -> memref<5xi1, strided<[?], offset: ?>>
      %4 = "memref.cast"(%arg4) : (memref<5xi1>) -> memref<5xi1, strided<[?], offset: ?>>
      "scf.yield"(%3, %4) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>) -> ()
    }) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>) -> (memref<5xi1>, memref<5xi1>)
    "func.return"(%0#0, %0#1) : (memref<5xi1>, memref<5xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>, index) -> (memref<5xi1>, memref<5xi1>), sym_name = "scf_while_non_equiv_condition_and_body"}> ({
  ^bb0(%arg0: memref<5xi1, strided<[?], offset: ?>>, %arg1: memref<5xi1, strided<[?], offset: ?>>, %arg2: index):
    %0:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg5: memref<5xi1, strided<[?], offset: ?>>, %arg6: memref<5xi1, strided<[?], offset: ?>>):
      %5 = "memref.load"(%arg5, %arg2) <{invariant = false, nontemporal = false}> : (memref<5xi1, strided<[?], offset: ?>>, index) -> i1
      %6 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xi1>
      "memref.copy"(%arg6, %6) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1>) -> ()
      %7 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xi1>
      "memref.copy"(%arg5, %7) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1>) -> ()
      "scf.condition"(%5, %6, %7) : (i1, memref<5xi1>, memref<5xi1>) -> ()
    }, {
    ^bb0(%arg3: memref<5xi1>, %arg4: memref<5xi1>):
      %1 = "dummy.some_op"() : () -> index
      %2 = "dummy.another_op"() : () -> i1
      "memref.store"(%2, %arg3, %1) <{nontemporal = false}> : (i1, memref<5xi1>, index) -> ()
      %3 = "memref.cast"(%arg4) : (memref<5xi1>) -> memref<5xi1, strided<[?], offset: ?>>
      %4 = "memref.cast"(%arg3) : (memref<5xi1>) -> memref<5xi1, strided<[?], offset: ?>>
      "scf.yield"(%3, %4) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>) -> ()
    }) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>) -> (memref<5xi1>, memref<5xi1>)
    "func.return"(%0#0, %0#1) : (memref<5xi1>, memref<5xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>, index) -> (), sym_name = "scf_while_iter_arg_result_mismatch"}> ({
  ^bb0(%arg0: memref<5xi1, strided<[?], offset: ?>>, %arg1: memref<5xi1, strided<[?], offset: ?>>, %arg2: index):
    "scf.while"(%arg1) ({
    ^bb0(%arg3: memref<5xi1, strided<[?], offset: ?>>):
      %4 = "memref.load"(%arg0, %arg2) <{invariant = false, nontemporal = false}> : (memref<5xi1, strided<[?], offset: ?>>, index) -> i1
      %5 = "memref.load"(%arg3, %arg2) <{invariant = false, nontemporal = false}> : (memref<5xi1, strided<[?], offset: ?>>, index) -> i1
      "dummy.use"(%5) : (i1) -> ()
      "scf.condition"(%4) : (i1) -> ()
    }, {
      %0 = "dummy.some_op"() : () -> index
      %1 = "dummy.another_op"() : () -> i1
      %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xi1>
      "memref.copy"(%arg0, %2) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1>) -> ()
      "memref.store"(%1, %2, %0) <{nontemporal = false}> : (i1, memref<5xi1>, index) -> ()
      %3 = "memref.cast"(%2) : (memref<5xi1>) -> memref<5xi1, strided<[?], offset: ?>>
      "scf.yield"(%3) : (memref<5xi1, strided<[?], offset: ?>>) -> ()
    }) : (memref<5xi1, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "parallel_insert_slice_no_conflict", sym_visibility = "private"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<?xf32, strided<[?], offset: ?>>, %arg3: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.forall"(%arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg4: index):
      %3 = "memref.subview"(%arg3, %arg0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
      "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) {keep_this_attribute} : (index) -> ()
    %2 = "memref.load"(%arg3, %1) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> (f32, f32), sym_name = "parallel_insert_slice_with_conflict"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<?xf32, strided<[?], offset: ?>>, %arg3: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg3, %1) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %3 = "memref.alloc"(%2) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg3, %3) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "scf.forall"(%arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg4: index):
      %6 = "memref.subview"(%3, %arg0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 5>>
      "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, memref<?xf32, strided<[1], offset: 5>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    %4 = "memref.load"(%arg3, %1) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    %5 = "memref.load"(%3, %1) <{invariant = false, nontemporal = false}> : (memref<?xf32>, index) -> f32
    "func.return"(%5, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 * 4)>
#map1 = affine_map<(d0) -> (d0 * 2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8xf32, strided<[?, ?], offset: ?>>, memref<8x8xf32, strided<[?, ?], offset: ?>>, memref<8x8xf32, strided<[?, ?], offset: ?>>) -> memref<8x8xf32, strided<[?, ?], offset: ?>>, sym_name = "matmul"}> ({
  ^bb0(%arg0: memref<8x8xf32, strided<[?, ?], offset: ?>>, %arg1: memref<8x8xf32, strided<[?, ?], offset: ?>>, %arg2: memref<8x8xf32, strided<[?, ?], offset: ?>>):
    "scf.forall"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: 2, 4>}> ({
    ^bb0(%arg3: index, %arg4: index):
      %0 = "affine.apply"(%arg3) <{map = #map}> : (index) -> index
      %1 = "memref.subview"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 4, 8>, static_strides = array<i64: 1, 1>}> : (memref<8x8xf32, strided<[?, ?], offset: ?>>, index) -> memref<4x8xf32, strided<[?, ?], offset: ?>>
      %2 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
      %3 = "memref.subview"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, 4>, static_strides = array<i64: 1, 1>}> : (memref<8x8xf32, strided<[?, ?], offset: ?>>, index) -> memref<8x4xf32, strided<[?, ?], offset: ?>>
      %4 = "memref.subview"(%arg2, %0, %2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (memref<8x8xf32, strided<[?, ?], offset: ?>>, index, index) -> memref<4x4xf32, strided<[?, ?], offset: ?>>
      "linalg.matmul"(%1, %3, %4) <{indexing_maps = [#map2, #map3, #map4], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
        %5 = "arith.mulf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %6 = "arith.addf"(%arg7, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%6) : (f32) -> ()
      }) : (memref<4x8xf32, strided<[?, ?], offset: ?>>, memref<8x4xf32, strided<[?, ?], offset: ?>>, memref<4x4xf32, strided<[?, ?], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
    "func.return"(%arg2) : (memref<8x8xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, strided<[?], offset: ?>>) -> f32, sym_name = "scf_foreach_private_var"}> ({
  ^bb0(%arg0: memref<10xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "memref.copy"(%arg0, %2) : (memref<10xf32, strided<[?], offset: ?>>, memref<10xf32>) -> ()
    "scf.forall"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 2>}> ({
    ^bb0(%arg1: index):
      %4 = "arith.muli"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "memref.subview"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32>, index) -> memref<5xf32, strided<[1], offset: ?>>
      %6 = "memref.load"(%arg0, %arg1) <{invariant = false, nontemporal = false}> : (memref<10xf32, strided<[?], offset: ?>>, index) -> f32
      "memref.store"(%6, %5, %0) <{nontemporal = false}> : (f32, memref<5xf32, strided<[1], offset: ?>>, index) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
    %3 = "memref.load"(%2, %0) <{invariant = false, nontemporal = false}> : (memref<10xf32>, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, strided<[?], offset: ?>>, memref<10xf32, strided<[?], offset: ?>>) -> f32, sym_name = "scf_foreach_privatized_but_not_copied"}> ({
  ^bb0(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    "scf.forall"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 2>}> ({
    ^bb0(%arg2: index):
      %3 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "memref.subview"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[?], offset: ?>>, index) -> memref<5xf32, strided<[?], offset: ?>>
      %5 = "memref.load"(%arg1, %arg2) <{invariant = false, nontemporal = false}> : (memref<10xf32, strided<[?], offset: ?>>, index) -> f32
      "memref.store"(%5, %4, %0) <{nontemporal = false}> : (f32, memref<5xf32, strided<[?], offset: ?>>, index) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
    %2 = "memref.load"(%arg0, %0) <{invariant = false, nontemporal = false}> : (memref<10xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, f32, f32) -> (f32, f32), sym_name = "scf_if_memory_space"}> ({
  ^bb0(%arg0: i1, %arg1: f32, %arg2: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32, 1>
    "linalg.fill"(%arg2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, memref<5xf32, 1>) -> ()
    %2 = "scf.if"(%arg0) ({
      "scf.yield"(%1) : (memref<5xf32, 1>) -> ()
    }, {
      %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32, 1>
      "memref.copy"(%1, %5) : (memref<5xf32, 1>, memref<5xf32, 1>) -> ()
      "memref.store"(%arg1, %5, %0) <{nontemporal = false}> : (f32, memref<5xf32, 1>, index) -> ()
      "scf.yield"(%5) : (memref<5xf32, 1>) -> ()
    }) : (i1) -> memref<5xf32, 1>
    %3 = "memref.load"(%1, %0) <{invariant = false, nontemporal = false}> : (memref<5xf32, 1>, index) -> f32
    %4 = "memref.load"(%2, %0) <{invariant = false, nontemporal = false}> : (memref<5xf32, 1>, index) -> f32
    "func.return"(%3, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "scf_execute_region_memory_space"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32, 1>
    "memref.store"(%arg0, %1, %0) <{nontemporal = false}> : (f32, memref<5xf32, 1>, index) -> ()
    %2 = "memref.load"(%1, %0) <{invariant = false, nontemporal = false}> : (memref<5xf32, 1>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<4xf32, strided<[?], offset: ?>>, index, index, index) -> (f32, f32), sym_name = "scf_for_swapping_yields_memory_space"}> ({
  ^bb0(%arg0: index, %arg1: memref<4xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32, 1>
    %2 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32, 1>
    %3:2 = "scf.for"(%arg2, %arg3, %arg4, %1, %2) ({
    ^bb0(%arg5: index, %arg6: memref<?xf32, 1>, %arg7: memref<?xf32, 1>):
      %6 = "memref.subview"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, 1>) -> memref<4xf32, strided<[1]>, 1>
      "memref.copy"(%arg1, %6) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[1]>, 1>) -> ()
      %7 = "memref.subview"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, 1>) -> memref<4xf32, strided<[1]>, 1>
      "memref.copy"(%arg1, %7) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[1]>, 1>) -> ()
      %8 = "memref.dim"(%arg7, %0) : (memref<?xf32, 1>, index) -> index
      %9 = "memref.alloc"(%8) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32, 1>
      "memref.copy"(%arg7, %9) : (memref<?xf32, 1>, memref<?xf32, 1>) -> ()
      %10 = "memref.dim"(%arg6, %0) : (memref<?xf32, 1>, index) -> index
      %11 = "memref.alloc"(%10) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32, 1>
      "memref.copy"(%arg6, %11) : (memref<?xf32, 1>, memref<?xf32, 1>) -> ()
      "scf.yield"(%9, %11) : (memref<?xf32, 1>, memref<?xf32, 1>) -> ()
    }) : (index, index, index, memref<?xf32, 1>, memref<?xf32, 1>) -> (memref<?xf32, 1>, memref<?xf32, 1>)
    %4 = "memref.load"(%3#0, %arg4) <{invariant = false, nontemporal = false}> : (memref<?xf32, 1>, index) -> f32
    %5 = "memref.load"(%3#1, %arg4) <{invariant = false, nontemporal = false}> : (memref<?xf32, 1>, index) -> f32
    "func.return"(%4, %5) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> memref<?xf32>, sym_name = "scf_for_yield_alias_of_non_equivalent"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "linalg.map"(%3) ({
    ^bb0(%arg2: f32):
      "linalg.yield"(%2) : (f32) -> ()
    }) : (memref<?xf32>) -> ()
    %4 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%3, %4) : (memref<?xf32>, memref<?xf32>) -> ()
    "scf.for"(%0, %arg0, %1) ({
    ^bb0(%arg1: index):
      %5 = "arith.subi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "memref.subview"(%3, %5, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %7 = "memref.load"(%6, %0) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[1], offset: ?>>, index) -> f32
      %8 = "arith.mulf"(%7, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%8, %4, %arg1) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%4) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> f32, sym_name = "scf_for_buffer_type_mismatch"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %4 = "memref.subview"(%3, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 1>>
    %5 = "memref.cast"(%4) : (memref<?xf32, strided<[1], offset: 1>>) -> memref<?xf32, strided<[?], offset: ?>>
    %6 = "scf.for"(%0, %2, %1, %5) ({
    ^bb0(%arg2: index, %arg3: memref<?xf32, strided<[?], offset: ?>>):
      %8 = "test.dummy"() : () -> index
      %9 = "memref.subview"(%arg3, %8) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
      "scf.yield"(%9) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    }) : (index, index, index, memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    %7 = "memref.load"(%6, %1) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> f32, sym_name = "scf_while_buffer_type_mismatch"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5.500000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %3 = "memref.subview"(%2, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 1>>
    %4 = "memref.cast"(%3) : (memref<?xf32, strided<[1], offset: 1>>) -> memref<?xf32, strided<[?], offset: ?>>
    %5 = "scf.while"(%4) ({
    ^bb0(%arg3: memref<?xf32, strided<[?], offset: ?>>):
      %9 = "test.condition"() : () -> i1
      %10 = "test.dummy"() : () -> index
      %11 = "memref.subview"(%arg3, %10) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
      %12 = "memref.alloc"(%10) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      "memref.copy"(%11, %12) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
      "scf.condition"(%9, %12) : (i1, memref<?xf32>) -> ()
    }, {
    ^bb0(%arg2: memref<?xf32>):
      %7 = "test.dummy"() : () -> index
      "memref.store"(%1, %arg2, %7) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
      %8 = "memref.cast"(%arg2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
      "scf.yield"(%8) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    }) : (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32>
    %6 = "memref.load"(%5, %0) <{invariant = false, nontemporal = false}> : (memref<?xf32>, index) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "non_tensor_for_arg"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 10 : index}> : () -> index
    "scf.for"(%0, %3, %1) ({
    ^bb0(%arg1: index):
      "memref.store"(%2, %arg0, %1) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f64, strided<[], offset: ?>>) -> (), sym_name = "buffer_type_of_collapse_shape"}> ({
  ^bb0(%arg0: memref<f64, strided<[], offset: ?>>):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    "scf.while"(%arg0) ({
    ^bb0(%arg1: memref<f64, strided<[], offset: ?>>):
      %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
      "memref.copy"(%arg1, %4) : (memref<f64, strided<[], offset: ?>>, memref<f64>) -> ()
      "scf.condition"(%0) : (i1) -> ()
    }, {
      %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf64>
      %2 = "memref.collapse_shape"(%1) <{reassociation = []}> : (memref<1xf64>) -> memref<f64>
      %3 = "memref.cast"(%2) : (memref<f64>) -> memref<f64, strided<[], offset: ?>>
      "scf.yield"(%3) : (memref<f64, strided<[], offset: ?>>) -> ()
    }) : (memref<f64, strided<[], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "non_block_argument_yield"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "scf.while"(%1) ({
    ^bb0(%arg2: memref<i32>):
      %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
      "memref.copy"(%arg2, %5) : (memref<i32>, memref<i32>) -> ()
      "scf.condition"(%0) : (i1) -> ()
    }, {
      %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
      %3 = "scf.while"(%2) ({
      ^bb0(%arg1: memref<i32>):
        %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
        "memref.copy"(%arg1, %4) : (memref<i32>, memref<i32>) -> ()
        "scf.condition"(%0, %4) : (i1, memref<i32>) -> ()
      }, {
      ^bb0(%arg0: memref<i32>):
        "scf.yield"(%1) : (memref<i32>) -> ()
      }) : (memref<i32>) -> memref<i32>
      "scf.yield"(%3) : (memref<i32>) -> ()
    }) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<2xindex>, sym_name = "regression_cast_in_loop"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xindex>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xindex>
    "memref.copy"(%0, %1) : (memref<2xindex>, memref<2xindex>) -> ()
    "func.return"(%1) : (memref<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, index, index, f32) -> (memref<10xf32>, f32), sym_name = "elide_copy_of_non_writing_scf_if"}> ({
  ^bb0(%arg0: i1, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "scf.if"(%arg0) ({
      %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
      "scf.yield"(%3) : (memref<10xf32>) -> ()
    }, {
      %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
      "scf.yield"(%2) : (memref<10xf32>) -> ()
    }) : (i1) -> memref<10xf32>
    "memref.store"(%arg3, %0, %arg1) <{nontemporal = false}> : (f32, memref<10xf32>, index) -> ()
    %1 = "memref.load"(%0, %arg2) <{invariant = false, nontemporal = false}> : (memref<10xf32>, index) -> f32
    "func.return"(%0, %1) : (memref<10xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "index_switch"}> ({
  ^bb0(%arg0: index, %arg1: memref<5xf32, strided<[?], offset: ?>>, %arg2: memref<5xf32, strided<[?], offset: ?>>):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %1 = "scf.index_switch"(%arg0) <{cases = array<i64: 2, 5>}> ({
      "scf.yield"(%arg2) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    }, {
      %2 = "memref.cast"(%0) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
      "scf.yield"(%2) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    }, {
      "scf.yield"(%arg1) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    }) : (index) -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"(%1) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "check_scfforall_inplace_bufferizer"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg2: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.dim"(%arg2, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %3 = "memref.dim"(%arg1, %1) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
    %4 = "memref.subview"(%arg0, %2, %3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    %5 = "memref.subview"(%arg1, %2, %3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "linalg.generic"(%4, %5, %arg2) <{indexing_maps = [#map, #map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%7, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
    %6 = "memref.subview"(%arg2, %2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg2, %6) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg2) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

