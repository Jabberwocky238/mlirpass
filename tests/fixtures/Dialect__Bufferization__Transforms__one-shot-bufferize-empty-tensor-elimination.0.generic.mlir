"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> (memref<?xf32>, memref<?xf32>), sym_name = "buffer_forwarding_conflict"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"(%arg1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<?xf32>) -> ()
    %3 = "memref.dim"(%arg0, %0) : (memref<?xf32>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %4) : (memref<?xf32>, memref<?xf32>) -> ()
    %5 = "memref.subview"(%4, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1]>>
    "memref.copy"(%2, %5) : (memref<?xf32>, memref<?xf32, strided<[1]>>) -> ()
    %6 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 42>>
    "memref.copy"(%2, %6) : (memref<?xf32>, memref<?xf32, strided<[1], offset: 42>>) -> ()
    "func.return"(%4, %arg0) : (memref<?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> memref<?xf32>, sym_name = "buffer_forwarding_no_conflict"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 42>>
    "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<?xf32, strided<[1], offset: 42>>) -> ()
    "func.return"(%arg0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "insertion_point_inside_loop"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    "scf.for"(%0, %arg1, %1) ({
    ^bb0(%arg2: index):
      %2 = "memref.subview"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<5xf32, strided<[?], offset: ?>>
      %3 = "arith.index_cast"(%arg2) : (index) -> i32
      %4 = "arith.sitofp"(%3) : (i32) -> f32
      "linalg.fill"(%4, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, memref<5xf32, strided<[?], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "insertion_point_outside_loop"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    "scf.for"(%0, %arg1, %1) ({
    ^bb0(%arg3: index):
      %2 = "memref.subview"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<5xf32, strided<[?], offset: ?>>
      %3 = "arith.index_cast"(%arg3) : (index) -> i32
      %4 = "arith.sitofp"(%3) : (i32) -> f32
      "linalg.fill"(%4, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, memref<5xf32, strided<[?], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "shape_mismatch"}> ({
  ^bb0(%arg0: memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<128xf32>) -> ()
    %2 = "memref.expand_shape"(%1) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 1, 128>}> : (memref<128xf32>) -> memref<1x1x128xf32>
    %3 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2, 3, 0>, static_sizes = array<i64: 1, 1, 128>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> memref<1x1x128xf32, strided<[?, ?, ?], offset: ?>>
    "memref.copy"(%2, %3) : (memref<1x1x128xf32>, memref<1x1x128xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<256xf32, strided<[?], offset: ?>>) -> memref<256xf32, strided<[?], offset: ?>>, sym_name = "cast"}> ({
  ^bb0(%arg0: memref<256xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<256xf32, strided<[?], offset: ?>>) -> memref<128xf32, strided<[?], offset: ?>>
    "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<128xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<256xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> memref<?xf32>, sym_name = "parallel_insert_slice"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "scf.forall"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 512>}> ({
    ^bb0(%arg2: index):
      %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 42>>
      "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, memref<?xf32, strided<[1], offset: 42>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
    "func.return"(%arg0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index, i1) -> memref<?xf32>, sym_name = "eleminate_multiple_ops"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index, %arg2: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "scf.if"(%arg2) ({
      %5 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 42>>
      "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, memref<?xf32, strided<[1], offset: 42>>) -> ()
      "scf.yield"(%5) : (memref<?xf32, strided<[1], offset: 42>>) -> ()
    }, {
      %4 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 42>>
      "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, memref<?xf32, strided<[1], offset: 42>>) -> ()
      "scf.yield"(%4) : (memref<?xf32, strided<[1], offset: 42>>) -> ()
    }) : (i1) -> memref<?xf32, strided<[1], offset: 42>>
    %3 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<?xf32, strided<[1], offset: 42>>
    "memref.copy"(%2, %3) : (memref<?xf32, strided<[1], offset: 42>>, memref<?xf32, strided<[1], offset: 42>>) -> ()
    "func.return"(%arg0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, strided<[?], offset: ?>>, memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>, sym_name = "regression_do_not_eliminate_non_empty"}> ({
  ^bb0(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    %1 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    "memref.copy"(%0, %1) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg1) : (memref<10xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>, memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>, sym_name = "regression_insert_of_bbarg"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>):
    %0 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg0, %0) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg1) : (memref<10xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<?x16xi8, strided<[?, ?], offset: ?>>) -> memref<?x16xi8, strided<[?, ?], offset: ?>>, sym_name = "regression_eliminate_equivalent_only"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<?x16xi8, strided<[?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?x8xi32>
    %4 = "memref.subview"(%3, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (memref<?x8xi32>, index) -> memref<?x8xi32, strided<[8, 1]>>
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg3: index):
      %5 = "memref.subview"(%3, %arg0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (memref<?x8xi32>, index) -> memref<?x8xi32, strided<[8, 1]>>
      "memref.copy"(%4, %5) : (memref<?x8xi32, strided<[8, 1]>>, memref<?x8xi32, strided<[8, 1]>>) -> ()
      %6 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?x8xi8>
      "linalg.generic"(%3, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: i32, %arg5: i8):
        %8 = "arith.trunci"(%arg4) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
        "linalg.yield"(%8) : (i8) -> ()
      }) : (memref<?x8xi32>, memref<?x8xi8>) -> ()
      %7 = "memref.subview"(%arg2, %arg1, %arg3, %arg0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (memref<?x16xi8, strided<[?, ?], offset: ?>>, index, index, index) -> memref<?x8xi8, strided<[?, ?], offset: ?>>
      "memref.copy"(%6, %7) : (memref<?x8xi8>, memref<?x8xi8, strided<[?, ?], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg2) : (memref<?x16xi8, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "regression_multiple_insertion_points"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 5.500000e+00 : f32}> : () -> f32
    %1 = "test.foo"() : () -> index
    %2 = "test.bar"() : () -> index
    %3 = "memref.subview"(%arg0, %1, %2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> memref<2x5xf32, strided<[?, ?], offset: ?>>
    "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<2x5xf32, strided<[?, ?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>, f32) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "materialize_in_destination"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: f32):
    "linalg.fill"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<5xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>, f32) -> (), sym_name = "materialize_in_destination_buffer"}> ({
  ^bb0(%arg0: memref<5xf32>, %arg1: f32):
    "linalg.fill"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>, f32) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "linalg_copy"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: f32):
    "linalg.fill"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<5xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<26xi32>, sym_name = "linalg_copy_empty"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<26xi32>
    "func.return"(%0) : (memref<26xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>, f32, f32, i1) -> (), sym_name = "multiple_materialize_in_destination_buffer"}> ({
  ^bb0(%arg0: memref<5xf32>, %arg1: f32, %arg2: f32, %arg3: i1):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "linalg.fill"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, memref<5xf32>) -> ()
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "linalg.fill"(%arg2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, memref<5xf32>) -> ()
    %2 = "arith.select"(%arg3, %0, %1) : (i1, memref<5xf32>, memref<5xf32>) -> memref<5xf32>
    "memref.copy"(%2, %arg0) : (memref<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<5x6x128xf32>, sym_name = "eliminate_all_empty_tensors"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x6x128xf32>
    %3 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32>) -> memref<5x6x64xf32, strided<[768, 128, 1]>>
    "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<5x6x64xf32, strided<[768, 128, 1]>>) -> ()
    %4 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32>) -> memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>
    "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>) -> ()
    "func.return"(%2) : (memref<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<5x6x128xf32>, sym_name = "eliminate_concatenated_empty_tensors"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x6x128xf32>
    %3 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32>) -> memref<5x6x64xf32, strided<[768, 128, 1]>>
    "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<5x6x64xf32, strided<[768, 128, 1]>>) -> ()
    %4 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32>) -> memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>
    "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>) -> ()
    "func.return"(%2) : (memref<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<5x6x128xf32>, sym_name = "multi_use_of_the_same_tensor_empty"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x6x128xf32>
    %3 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32>) -> memref<5x6x64xf32, strided<[768, 128, 1]>>
    "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<5x6x64xf32, strided<[768, 128, 1]>>) -> ()
    %4 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32>) -> memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>
    "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>) -> ()
    "func.return"(%2) : (memref<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>) -> (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>), sym_name = "multi_use_of_the_same_tensor_empty_creates_non_existent_read"}> ({
  ^bb0(%arg0: memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, %arg1: memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x6x64xf32>
    "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    "linalg.generic"(%2, %arg1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %3 = "arith.addf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (memref<5x6x64xf32>, memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    "func.return"(%arg0, %arg1) : (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "direct_use_of_tensor_empty"}> ({
  ^bb0(%arg0: memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>):
    "func.return"(%arg0) : (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32>, index, f32) -> memref<10xf32>, sym_name = "move_dependent_arith_op"}> ({
  ^bb0(%arg0: memref<10xf32>, %arg1: index, %arg2: f32):
    %0 = "arith.constant"() <{value = 5 : index}> : () -> index
    %1 = "arith.addi"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %2 = "memref.subview"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32>, index) -> memref<5xf32, strided<[1], offset: ?>>
    "linalg.fill"(%arg2, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, memref<5xf32, strided<[1], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32>, memref<index>, f32) -> memref<10xf32>, sym_name = "side_effecting_op_blocks_movement"}> ({
  ^bb0(%arg0: memref<10xf32>, %arg1: memref<index>, %arg2: f32):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "linalg.fill"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, memref<5xf32>) -> ()
    %1 = "memref.load"(%arg1) : (memref<index>) -> index
    %2 = "memref.subview"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32>, index) -> memref<5xf32, strided<[1], offset: ?>>
    "memref.copy"(%0, %2) : (memref<5xf32>, memref<5xf32, strided<[1], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

