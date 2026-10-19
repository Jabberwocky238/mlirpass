"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xi8>) -> memref<5xi8>, sym_name = "collapse_shape_identity_fold"}> ({
  ^bb0(%arg0: memref<5xi8>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0]]}> : (memref<5xi8>) -> memref<5xi8>
    "func.return"(%0) : (memref<5xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x4xi8>) -> memref<5x4xi8>, sym_name = "expand_shape_identity_fold"}> ({
  ^bb0(%arg0: memref<5x4xi8>):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0], [1]], static_output_shape = array<i64: 5, 4>}> : (memref<5x4xi8>) -> memref<5x4xi8>
    "func.return"(%0) : (memref<5x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xi8>) -> memref<1x1xi8>, sym_name = "collapse_expand_rank0_cancel"}> ({
  ^bb0(%arg0: memref<1x1xi8>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = []}> : (memref<1x1xi8>) -> memref<i8>
    %1 = "memref.expand_shape"(%0) <{reassociation = [], static_output_shape = array<i64: 1, 1>}> : (memref<i8>) -> memref<1x1xi8>
    "func.return"(%1) : (memref<1x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x6x16x32xi8>) -> memref<16x32xi8, strided<[32, 1], offset: 512>>, sym_name = "subview_of_size_memcast"}> ({
  ^bb0(%arg0: memref<4x6x16x32xi8>):
    %0 = "memref.cast"(%arg0) : (memref<4x6x16x32xi8>) -> memref<?x?x16x32xi8>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 1, 0, 0>, static_sizes = array<i64: 1, 1, 16, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<?x?x16x32xi8>) -> memref<16x32xi8, strided<[32, 1], offset: 512>>
    "func.return"(%1) : (memref<16x32xi8, strided<[32, 1], offset: 512>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x?xf32, strided<[35, 7, 1], offset: ?>>) -> memref<1x4xf32, strided<[?, ?], offset: ?>>, sym_name = "subview_of_strides_memcast"}> ({
  ^bb0(%arg0: memref<1x1x?xf32, strided<[35, 7, 1], offset: ?>>):
    %0 = "memref.cast"(%arg0) : (memref<1x1x?xf32, strided<[35, 7, 1], offset: ?>>) -> memref<1x1x?xf32, strided<[?, ?, ?], offset: ?>>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 1, 1, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x1x?xf32, strided<[?, ?, ?], offset: ?>>) -> memref<1x4xf32, strided<[?, ?], offset: ?>>
    "func.return"(%1) : (memref<1x4xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x6x16x32xi8>) -> memref<4x6x16x32xi8>, sym_name = "subview_of_static_full_size"}> ({
  ^bb0(%arg0: memref<4x6x16x32xi8>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0>, static_sizes = array<i64: 4, 6, 16, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<4x6x16x32xi8>) -> memref<4x6x16x32xi8>
    "func.return"(%0) : (memref<4x6x16x32xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x4xf32, strided<[4, 1], offset: ?>>, index) -> memref<16x4xf32, strided<[4, 1], offset: ?>>, sym_name = "negative_subview_of_static_full_size"}> ({
  ^bb0(%arg0: memref<16x4xf32, strided<[4, 1], offset: ?>>, %arg1: index):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 16, 4>, static_strides = array<i64: 1, 1>}> : (memref<16x4xf32, strided<[4, 1], offset: ?>>, index) -> memref<16x4xf32, strided<[4, 1], offset: ?>>
    "func.return"(%0) : (memref<16x4xf32, strided<[4, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "subview_canonicalize"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "memref.subview"(%arg0, %0, %arg1, %1, %2, %1, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "func.return"(%3) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "rank_reducing_subview_canonicalize"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "memref.subview"(%arg0, %0, %arg1, %1, %2, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 2, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%3) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x384x384xf32>, index, index, index) -> memref<?xf32, strided<[1], offset: ?>>, sym_name = "multiple_reducing_dims"}> ({
  ^bb0(%arg0: memref<1x384x384xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %arg1, %arg2, %0, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x384x384xf32>, index, index, index, index) -> memref<?x?xf32, strided<[384, 1], offset: ?>>
    %2 = "memref.subview"(%1, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[384, 1], offset: ?>>, index) -> memref<?xf32, strided<[1], offset: ?>>
    "func.return"(%2) : (memref<?xf32, strided<[1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, index, index, index) -> memref<?xf32, strided<[1], offset: ?>>, sym_name = "multiple_reducing_dims_dynamic"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %arg1, %arg2, %0, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32>, index, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
    %2 = "memref.subview"(%1, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> memref<?xf32, strided<[1], offset: ?>>
    "func.return"(%2) : (memref<?xf32, strided<[1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "multiple_reducing_dims_all_dynamic"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %arg1, %arg2, %0, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    %2 = "memref.subview"(%1, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%2) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "subview_negative_stride1"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = -1 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %0) : (memref<?xf32>, index) -> index
    %3 = "arith.addi"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %4 = "memref.subview"(%arg0, %3, %2, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (memref<?xf32>, index, index, index) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%4) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<7xf32>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "subview_negative_stride2"}> ({
  ^bb0(%arg0: memref<7xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = -1 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %0) : (memref<7xf32>, index) -> index
    %3 = "arith.addi"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %4 = "memref.subview"(%arg0, %3, %2, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (memref<7xf32>, index, index, index) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%4) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1024xf32>) -> memref<?x256xf32, strided<[1024, 1], offset: 2304>>, sym_name = "no_fold_subview_negative_size"}> ({
  ^bb0(%arg0: memref<4x1024xf32>):
    %0 = "arith.constant"() <{value = -13 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2, 256>, static_sizes = array<i64: -9223372036854775808, 256>, static_strides = array<i64: 1, 1>}> : (memref<4x1024xf32>, index) -> memref<?x256xf32, strided<[1024, 1], offset: 2304>>
    "func.return"(%1) : (memref<?x256xf32, strided<[1024, 1], offset: 2304>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32>) -> memref<1xf32, strided<[?], offset: 1>>, sym_name = "no_fold_subview_zero_stride"}> ({
  ^bb0(%arg0: memref<10xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.subview"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 1>, static_sizes = array<i64: 1>, static_strides = array<i64: -9223372036854775808>}> : (memref<10xf32>, index) -> memref<1xf32, strided<[?], offset: 1>>
    "func.return"(%2) : (memref<1xf32, strided<[?], offset: 1>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xi8>, memref<memref<?xi8>>) -> (), sym_name = "no_fold_of_store"}> ({
  ^bb0(%arg0: memref<32xi8>, %arg1: memref<memref<?xi8>>):
    %0 = "memref.cast"(%arg0) : (memref<32xi8>) -> memref<?xi8>
    "memref.store"(%0, %arg1) : (memref<?xi8>, memref<memref<?xi8>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "dim_of_alloca"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloca"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xindex>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%0, %1) : (memref<?xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> index, sym_name = "dim_of_alloca_with_dynamic_size"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "memref.rank"(%arg0) : (memref<*xf32>) -> index
    %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xindex>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?xindex>, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>, memref<?xindex>) -> index, sym_name = "dim_of_memref_reshape"}> ({
  ^bb0(%arg0: memref<*xf32>, %arg1: memref<?xindex>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "memref.reshape"(%arg0, %arg1) : (memref<*xf32>, memref<?xindex>) -> memref<*xf32>
    "memref.store"(%0, %arg1, %0) : (index, memref<?xindex>, index) -> ()
    %2 = "memref.dim"(%1, %0) : (memref<*xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>, memref<?xi32>) -> index, sym_name = "dim_of_memref_reshape_i32"}> ({
  ^bb0(%arg0: memref<*xf32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "memref.reshape"(%arg0, %arg1) : (memref<*xf32>, memref<?xi32>) -> memref<*xf32>
    %2 = "memref.dim"(%1, %0) : (memref<*xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>, memref<?xindex>, index) -> index, sym_name = "dim_of_memref_reshape_block_arg_index"}> ({
  ^bb0(%arg0: memref<*xf32>, %arg1: memref<?xindex>, %arg2: index):
    %0 = "memref.reshape"(%arg0, %arg1) : (memref<*xf32>, memref<?xindex>) -> memref<*xf32>
    %1 = "memref.dim"(%0, %arg2) : (memref<*xf32>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>, memref<?xindex>) -> index, sym_name = "dim_of_memref_reshape_for"}> ({
  ^bb0(%arg0: memref<*xf32>, %arg1: memref<?xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "memref.reshape"(%arg0, %arg1) : (memref<*xf32>, memref<?xindex>) -> memref<*xf32>
    %4 = "scf.for"(%0, %2, %1, %1) ({
    ^bb0(%arg2: index, %arg3: index):
      %5 = "memref.dim"(%3, %arg2) : (memref<*xf32>, index) -> index
      %6 = "arith.muli"(%arg3, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%6) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>, memref<?xindex>, index) -> index, sym_name = "dim_of_memref_reshape_undominated"}> ({
  ^bb0(%arg0: memref<*xf32>, %arg1: memref<?xindex>, %arg2: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "memref.reshape"(%arg0, %arg1) : (memref<*xf32>, memref<?xindex>) -> memref<*xf32>
    %2 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "memref.dim"(%1, %2) : (memref<*xf32>, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<?xf32>, sym_name = "alloc_const_fold"}> ({
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "memref.alloc"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.return"(%1) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<?xf32>, sym_name = "alloc_alignment_const_fold"}> ({
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "memref.alloc"(%0) <{alignment = 4096 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.return"(%1) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> memref<?xi32, strided<[?], offset: ?>>, sym_name = "alloc_const_fold_with_symbols1"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.alloc"(%arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 2>}> : (index, index, index) -> memref<?xi32, strided<[?], offset: ?>>
    "func.return"(%1) : (memref<?xi32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<?xi32, strided<[?], offset: ?>>, sym_name = "alloc_const_fold_with_symbols2"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.alloc"(%0, %0, %0) <{operandSegmentSizes = array<i32: 1, 2>}> : (index, index, index) -> memref<?xi32, strided<[?], offset: ?>>
    "func.return"(%1) : (memref<?xi32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<memref<?xi32>>, index) -> (), sym_name = "allocator"}> ({
  ^bb0(%arg0: memref<memref<?xi32>>, %arg1: index):
    %0 = "memref.alloc"(%arg1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi32>
    "memref.store"(%0, %arg0) : (memref<?xi32>, memref<memref<?xi32>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1xf32>) -> memref<f32>, sym_name = "compose_collapse_of_collapse_zero_dim"}> ({
  ^bb0(%arg0: memref<1x1x1xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (memref<1x1x1xf32>) -> memref<1xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = []}> : (memref<1xf32>) -> memref<f32>
    "func.return"(%1) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?x?xf32>) -> memref<?x?xf32>, sym_name = "compose_collapse_of_collapse"}> ({
  ^bb0(%arg0: memref<?x?x?x?x?xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (memref<?x?x?x?x?xf32>) -> memref<?x?x?xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (memref<?x?x?xf32>) -> memref<?x?xf32>
    "func.return"(%1) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf16>, index, index) -> memref<8x?x?xf16>, sym_name = "compose_collapse_of_expand_partially_dynamic"}> ({
  ^bb0(%arg0: memref<?xf16>, %arg1: index, %arg2: index):
    %0 = "memref.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0, 1, 2, 3, 4]], static_output_shape = array<i64: 4, 2, -9223372036854775808, -9223372036854775808, 32>}> : (memref<?xf16>, index, index) -> memref<4x2x?x?x32xf16>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (memref<4x2x?x?x32xf16>) -> memref<8x?x?xf16>
    "func.return"(%1) : (memref<8x?x?xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, 1]>>, index, index) -> memref<?xf32, strided<[?]>>, sym_name = "do_not_compose_collapse_of_expand_non_identity_layout"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, 1]>>, %arg1: index, %arg2: index):
    %0 = "memref.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (memref<?x?xf32, strided<[?, 1]>>, index, index) -> memref<?x4x?xf32, strided<[?, ?, 1]>>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1, 2]]}> : (memref<?x4x?xf32, strided<[?, ?, 1]>>) -> memref<?xf32, strided<[?]>>
    "func.return"(%1) : (memref<?xf32, strided<[?]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index, index, index) -> memref<?x6x4x5x?xf32>, sym_name = "compose_expand_of_expand"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "memref.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (memref<?x?xf32>, index, index) -> memref<?x4x?xf32>
    %1 = "memref.expand_shape"(%0, %arg3, %arg4) <{reassociation = [[0, 1], [2], [3, 4]], static_output_shape = array<i64: -9223372036854775808, 6, 4, 5, -9223372036854775808>}> : (memref<?x4x?xf32>, index, index) -> memref<?x6x4x5x?xf32>
    "func.return"(%1) : (memref<?x6x4x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> memref<1x1x1xf32>, sym_name = "compose_expand_of_expand_of_zero_dim"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (memref<f32>) -> memref<1xf32>
    %1 = "memref.expand_shape"(%0) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 1, 1>}> : (memref<1xf32>) -> memref<1x1x1xf32>
    "func.return"(%1) : (memref<1x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x4xf32>) -> memref<12x4xf32>, sym_name = "fold_collapse_of_expand"}> ({
  ^bb0(%arg0: memref<12x4xf32>):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 3, 4, 4>}> : (memref<12x4xf32>) -> memref<3x4x4xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (memref<3x4x4xf32>) -> memref<12x4xf32>
    "func.return"(%1) : (memref<12x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> memref<?x?xf32>, sym_name = "fold_collapse_collapse_of_expand"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "memref.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (memref<?x?xf32>, index, index) -> memref<?x4x?xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (memref<?x4x?xf32>) -> memref<?x?xf32>
    "func.return"(%1) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> memref<2x4x4xf32>, sym_name = "fold_memref_expand_cast"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?x?xf32>) -> memref<8x4xf32>
    %1 = "memref.expand_shape"(%0) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 2, 4, 4>}> : (memref<8x4xf32>) -> memref<2x4x4xf32>
    "func.return"(%1) : (memref<2x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x4xf32>) -> memref<2x1x4x4xf32>, sym_name = "fold_memref_expand_with_static_to_dynamic_cast"}> ({
  ^bb0(%arg0: memref<8x4xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "memref.cast"(%arg0) : (memref<8x4xf32>) -> memref<?x4xf32>
    %2 = "memref.expand_shape"(%1, %0) <{reassociation = [[0, 1, 2], [3]], static_output_shape = array<i64: -9223372036854775808, 1, 4, 4>}> : (memref<?x4xf32>, index) -> memref<?x1x4x4xf32>
    %3 = "memref.cast"(%2) : (memref<?x1x4x4xf32>) -> memref<2x1x4x4xf32>
    "func.return"(%3) : (memref<2x1x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x?xf32>) -> memref<1x8x1x?xf32>, sym_name = "fold_memref_expand_static_to_dynamic_partial"}> ({
  ^bb0(%arg0: memref<8x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<8x?xf32>) -> memref<?x?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%0, %1) : (memref<?x?xf32>, index) -> index
    %4 = "memref.dim"(%0, %2) : (memref<?x?xf32>, index) -> index
    %5 = "memref.expand_shape"(%0, %3, %4) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: 1, -9223372036854775808, 1, -9223372036854775808>}> : (memref<?x?xf32>, index, index) -> memref<1x?x1x?xf32>
    %6 = "memref.cast"(%5) : (memref<1x?x1x?xf32>) -> memref<1x8x1x?xf32>
    "func.return"(%6) : (memref<1x8x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x?xf32>) -> memref<1x8x1x?xf32>, sym_name = "fold_memref_expand_static_to_dynamic_partial_with_arith_const_as_dim"}> ({
  ^bb0(%arg0: memref<8x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<8x?xf32>) -> memref<?x?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%0, %1) : (memref<?x?xf32>, index) -> index
    %4 = "memref.dim"(%0, %2) : (memref<?x?xf32>, index) -> index
    %5 = "memref.expand_shape"(%0, %2, %3, %2, %4) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32>, index, index, index, index) -> memref<?x?x?x?xf32>
    %6 = "memref.cast"(%5) : (memref<?x?x?x?xf32>) -> memref<1x8x1x?xf32>
    "func.return"(%6) : (memref<1x8x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x?xf32>, index, index) -> memref<8x1x?x?xf32>, sym_name = "fold_memref_expand_static_to_dynamic_multiple"}> ({
  ^bb0(%arg0: memref<8x?xf32>, %arg1: index, %arg2: index):
    %0 = "memref.cast"(%arg0) : (memref<8x?xf32>) -> memref<?x?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%0, %1) : (memref<?x?xf32>, index) -> index
    %3 = "memref.expand_shape"(%0, %2, %arg1, %arg2) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: -9223372036854775808, 1, -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32>, index, index, index) -> memref<?x1x?x?xf32>
    %4 = "memref.cast"(%3) : (memref<?x1x?x?xf32>) -> memref<8x1x?x?xf32>
    "func.return"(%4) : (memref<8x1x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x4xf32>) -> memref<2x1x4x4xf32>, sym_name = "not_fold_memref_expand_with_dynamic_to_static_cast"}> ({
  ^bb0(%arg0: memref<?x4xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?x4xf32>) -> memref<8x4xf32>
    %1 = "memref.expand_shape"(%0) <{reassociation = [[0, 1, 2], [3]], static_output_shape = array<i64: 2, 1, 4, 4>}> : (memref<8x4xf32>) -> memref<2x1x4x4xf32>
    "func.return"(%1) : (memref<2x1x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x4xf32>, index) -> memref<2x1x4x4xf32>, sym_name = "not_fold_memref_expand_static_to_dynamic_cast_if_really_dynamic"}> ({
  ^bb0(%arg0: memref<8x4xf32>, %arg1: index):
    %0 = "memref.cast"(%arg0) : (memref<8x4xf32>) -> memref<?x4xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%0, %1) : (memref<?x4xf32>, index) -> index
    %3 = "arith.divui"(%2, %arg1) : (index, index) -> index
    %4 = "memref.expand_shape"(%0, %3) <{reassociation = [[0, 1, 2], [3]], static_output_shape = array<i64: -9223372036854775808, 1, 4, 4>}> : (memref<?x4xf32>, index) -> memref<?x1x4x4xf32>
    %5 = "memref.cast"(%4) : (memref<?x1x4x4xf32>) -> memref<2x1x4x4xf32>
    "func.return"(%5) : (memref<2x1x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x4xf32>) -> memref<8x1x4xf32>, sym_name = "fold_memref_expand_static_to_dynamic_layout"}> ({
  ^bb0(%arg0: memref<8x4xf32>):
    %0 = "memref.cast"(%arg0) : (memref<8x4xf32>) -> memref<8x4xf32, strided<[?, ?], offset: ?>>
    %1 = "memref.expand_shape"(%0) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 8, 1, 4>}> : (memref<8x4xf32, strided<[?, ?], offset: ?>>) -> memref<8x1x4xf32, strided<[?, ?, ?], offset: ?>>
    %2 = "memref.cast"(%1) : (memref<8x1x4xf32, strided<[?, ?, ?], offset: ?>>) -> memref<8x1x4xf32>
    "func.return"(%2) : (memref<8x1x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x512x1x1xf32>) -> memref<?x?xf32>, sym_name = "collapse_after_memref_cast_type_change"}> ({
  ^bb0(%arg0: memref<?x512x1x1xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?x512x1x1xf32>) -> memref<?x?x?x?xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0], [1, 2, 3]]}> : (memref<?x?x?x?xf32>) -> memref<?x?xf32>
    "func.return"(%1) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x512x1x?xf32>) -> memref<?x?xf32>, sym_name = "collapse_after_memref_cast"}> ({
  ^bb0(%arg0: memref<?x512x1x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?x512x1x?xf32>) -> memref<?x?x?x?xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0], [1, 2, 3]]}> : (memref<?x?x?x?xf32>) -> memref<?x?xf32>
    "func.return"(%1) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1x?xi64>) -> memref<?x?xi64>, sym_name = "collapse_after_memref_cast_type_change_dynamic"}> ({
  ^bb0(%arg0: memref<1x1x1x?xi64>):
    %0 = "memref.cast"(%arg0) : (memref<1x1x1x?xi64>) -> memref<1x1x?x?xi64>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1, 2], [3]]}> : (memref<1x1x?x?xi64>) -> memref<?x?xi64>
    "func.return"(%1) : (memref<?x?xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x5x7x1xf32>, index) -> memref<1x4x1xf32, strided<[35, 7, 1], offset: ?>>, sym_name = "reduced_memref"}> ({
  ^bb0(%arg0: memref<2x5x7x1xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.subview"(%arg0, %arg1, %arg1, %arg1, %4, %2, %4) <{operandSegmentSizes = array<i32: 1, 3, 3, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<2x5x7x1xf32>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[35, 7, 1], offset: ?>>
    %6 = "memref.cast"(%5) : (memref<?x?x?xf32, strided<[35, 7, 1], offset: ?>>) -> memref<1x4x1xf32, strided<[35, 7, 1], offset: ?>>
    "func.return"(%6) : (memref<1x4x1xf32, strided<[35, 7, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> index, sym_name = "fold_rank_memref"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "memref.rank"(%arg0) : (memref<?x?xf32>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x42xf32>) -> memref<20x42xf32, strided<[42, 1]>>, sym_name = "fold_no_op_subview"}> ({
  ^bb0(%arg0: memref<20x42xf32>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 20, 42>, static_strides = array<i64: 1, 1>}> : (memref<20x42xf32>) -> memref<20x42xf32, strided<[42, 1]>>
    "func.return"(%0) : (memref<20x42xf32, strided<[42, 1]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x42xf32>) -> memref<20x41xf32, strided<[42, 1], offset: 1>>, sym_name = "no_fold_subview_with_non_zero_offset"}> ({
  ^bb0(%arg0: memref<20x42xf32>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 1>, static_sizes = array<i64: 20, 41>, static_strides = array<i64: 1, 1>}> : (memref<20x42xf32>) -> memref<20x41xf32, strided<[42, 1], offset: 1>>
    "func.return"(%0) : (memref<20x41xf32, strided<[42, 1], offset: 1>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x42xf32>) -> memref<20x5xf32, strided<[42, 2]>>, sym_name = "no_fold_subview_with_non_unit_stride"}> ({
  ^bb0(%arg0: memref<20x42xf32>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 20, 5>, static_strides = array<i64: 1, 2>}> : (memref<20x42xf32>) -> memref<20x5xf32, strided<[42, 2]>>
    "func.return"(%0) : (memref<20x5xf32, strided<[42, 2]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32>) -> memref<?xf32, strided<[1], offset: 2>>, sym_name = "no_fold_invalid_dynamic_slice"}> ({
  ^bb0(%arg0: memref<10xf32>):
    %0 = "arith.constant"() <{value = 11 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<10xf32>, index) -> memref<?xf32, strided<[1], offset: 2>>
    "func.return"(%1) : (memref<?xf32, strided<[1], offset: 2>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> memref<?x?xf32, strided<[?, 1]>>, sym_name = "no_fold_dynamic_no_op_subview"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
    %3 = "memref.dim"(%arg0, %1) : (memref<?x?xf32>, index) -> index
    %4 = "memref.subview"(%arg0, %2, %3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<?x?xf32, strided<[?, 1]>>
    "func.return"(%4) : (memref<?x?xf32, strided<[?, 1]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<4xf32>, index) -> (), sym_name = "atomicrmw_cast_fold"}> ({
  ^bb0(%arg0: f32, %arg1: memref<4xf32>, %arg2: index):
    %0 = "memref.cast"(%arg1) : (memref<4xf32>) -> memref<?xf32>
    %1 = "memref.atomic_rmw"(%arg0, %0, %arg2) <{kind = 0 : i64}> : (f32, memref<?xf32>, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<*xf32>) -> (), sym_name = "copy_of_cast"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<*xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "memref.cast"(%arg1) : (memref<*xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "memref.copy"(%0, %1) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "self_copy"}> ({
  ^bb0(%arg0: memref<?xf32>):
    "memref.copy"(%arg0, %arg0) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<0x10xf32>, memref<?x10xf32>) -> (), sym_name = "empty_copy"}> ({
  ^bb0(%arg0: memref<0x10xf32>, %arg1: memref<?x10xf32>):
    "memref.copy"(%arg0, %arg1) : (memref<0x10xf32>, memref<?x10xf32>) -> ()
    "memref.copy"(%arg1, %arg0) : (memref<?x10xf32>, memref<0x10xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scopeMerge"}> ({
    "memref.alloca_scope"() ({
      %0 = "test.count"() : () -> index
      %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi64>
      "test.use"(%1) : (memref<?xi64>) -> ()
      "memref.alloca_scope.return"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scopeMerge2"}> ({
    "test.region"() ({
      "memref.alloca_scope"() ({
        %0 = "test.count"() : () -> index
        %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi64>
        "test.use"(%1) : (memref<?xi64>) -> ()
        "memref.alloca_scope.return"() : () -> ()
      }) : () -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scopeMerge3"}> ({
    %0 = "test.count"() : () -> index
    "test.region"() ({
      "memref.alloca_scope"() ({
        %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi64>
        "test.use"(%1) : (memref<?xi64>) -> ()
        "memref.alloca_scope.return"() : () -> ()
      }) : () -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scopeMerge4"}> ({
    %0 = "test.count"() : () -> index
    "test.region"() ({
      "memref.alloca_scope"() ({
        %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi64>
        "test.use"(%1) : (memref<?xi64>) -> ()
        "memref.alloca_scope.return"() : () -> ()
      }) : () -> ()
      "test.op"() : () -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (64)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scopeMerge5"}> ({
    "test.region"() ({
      "memref.alloca_scope"() ({
        "affine.parallel"() <{lowerBoundsGroups = dense<1> : tensor<1xi32>, lowerBoundsMap = #map, reductions = [], steps = [1], upperBoundsGroups = dense<1> : tensor<1xi32>, upperBoundsMap = #map1}> ({
        ^bb0(%arg0: index):
          %0 = "memref.alloca"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi64>
          "test.use"(%0) : (memref<?xi64>) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "memref.alloca_scope.return"() : () -> ()
      }) : () -> ()
      "test.op"() : () -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<index>) -> (), sym_name = "scopeInline"}> ({
  ^bb0(%arg0: memref<index>):
    %0 = "test.count"() : () -> index
    "test.region"() ({
      "memref.alloca_scope"() ({
        "memref.store"(%0, %arg0) : (index, memref<index>) -> ()
        "memref.alloca_scope.return"() : () -> ()
      }) : () -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scope_merge_without_terminator"}> ({
    "test.region"() ({
      "memref.alloca_scope"() ({
        %0 = "test.count"() : () -> index
        %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi64>
        "test.use"(%1) : (memref<?xi64>) -> ()
        "memref.alloca_scope.return"() : () -> ()
      }) : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x?xi32, strided<[4, ?], offset: ?>>) -> (memref<i32>, index, index, index, index, index), sym_name = "extract_strided_metadata_of_cast"}> ({
  ^bb0(%arg0: memref<3x?xi32, strided<[4, ?], offset: ?>>):
    %0 = "memref.cast"(%arg0) : (memref<3x?xi32, strided<[4, ?], offset: ?>>) -> memref<?x?xi32, strided<[?, ?], offset: ?>>
    %1:6 = "memref.extract_strided_metadata"(%0) : (memref<?x?xi32, strided<[?, ?], offset: ?>>) -> (memref<i32>, index, index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3, %1#4, %1#5) : (memref<i32>, index, index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi32, strided<[?, ?], offset: ?>>) -> (memref<i32>, index, index, index, index, index), sym_name = "extract_strided_metadata_of_cast_w_csts"}> ({
  ^bb0(%arg0: memref<?x?xi32, strided<[?, ?], offset: ?>>):
    %0 = "memref.cast"(%arg0) : (memref<?x?xi32, strided<[?, ?], offset: ?>>) -> memref<4x?xi32, strided<[?, 18], offset: 25>>
    %1:6 = "memref.extract_strided_metadata"(%0) : (memref<4x?xi32, strided<[?, 18], offset: 25>>) -> (memref<i32>, index, index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3, %1#4, %1#5) : (memref<i32>, index, index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> (memref<i32>, index, index, index, index, index), sym_name = "extract_strided_metadata_of_cast_unranked"}> ({
  ^bb0(%arg0: memref<*xi32>):
    %0 = "memref.cast"(%arg0) : (memref<*xi32>) -> memref<?x?xi32, strided<[?, ?], offset: ?>>
    %1:6 = "memref.extract_strided_metadata"(%0) : (memref<?x?xi32, strided<[?, ?], offset: ?>>) -> (memref<i32>, index, index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3, %1#4, %1#5) : (memref<i32>, index, index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x3x4xf32>) -> memref<2x3x4xf32>, sym_name = "reinterpret_noop"}> ({
  ^bb0(%arg0: memref<2x3x4xf32>):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2, 3, 4>, static_strides = array<i64: 12, 4, 1>}> : (memref<2x3x4xf32>) -> memref<2x3x4xf32>
    "func.return"(%0) : (memref<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "reinterpret_constant_fold"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 100 : index}> : () -> index
    %3 = "memref.reinterpret_cast"(%arg0, %0, %2, %2, %2, %1) <{operandSegmentSizes = array<i32: 1, 1, 2, 2>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<f32>, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%3) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index, index) -> memref<?xi8>, sym_name = "reinterpret_of_reinterpret"}> ({
  ^bb0(%arg0: memref<?xi8>, %arg1: index, %arg2: index):
    %0 = "memref.reinterpret_cast"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi8>, index) -> memref<?xi8>
    %1 = "memref.reinterpret_cast"(%0, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi8>, index) -> memref<?xi8>
    "func.return"(%1) : (memref<?xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index) -> memref<?xi8>, sym_name = "reinterpret_of_cast"}> ({
  ^bb0(%arg0: memref<?xi8>, %arg1: index):
    %0 = "memref.cast"(%arg0) : (memref<?xi8>) -> memref<5xi8>
    %1 = "memref.reinterpret_cast"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<5xi8>, index) -> memref<?xi8>
    "func.return"(%1) : (memref<?xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index, index) -> memref<?xi8>, sym_name = "reinterpret_of_subview"}> ({
  ^bb0(%arg0: memref<?xi8>, %arg1: index, %arg2: index):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi8>, index) -> memref<?xi8>
    %1 = "memref.reinterpret_cast"(%0, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi8>, index) -> memref<?xi8>
    "func.return"(%1) : (memref<?xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x2xf32>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "reinterpret_of_extract_strided_metadata_w_type_mistach"}> ({
  ^bb0(%arg0: memref<8x2xf32>):
    %0:6 = "memref.extract_strided_metadata"(%arg0) : (memref<8x2xf32>) -> (memref<f32>, index, index, index, index, index)
    %1 = "memref.reinterpret_cast"(%0#0, %0#1, %0#2, %0#3, %0#4, %0#5) <{operandSegmentSizes = array<i32: 1, 1, 2, 2>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<f32>, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%1) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x2xf32>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "reinterpret_of_extract_strided_metadata_w_constants"}> ({
  ^bb0(%arg0: memref<8x2xf32>):
    %0:6 = "memref.extract_strided_metadata"(%arg0) : (memref<8x2xf32>) -> (memref<f32>, index, index, index, index, index)
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "memref.reinterpret_cast"(%0#0, %1, %0#5) <{operandSegmentSizes = array<i32: 1, 0, 1, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808, 2>, static_strides = array<i64: 2, -9223372036854775808>}> : (memref<f32>, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%2) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "reinterpret_of_extract_strided_metadata_same_type"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>):
    %0:6 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
    %1 = "memref.reinterpret_cast"(%0#0, %0#1, %0#2, %0#3, %0#4, %0#5) <{operandSegmentSizes = array<i32: 1, 1, 2, 2>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<f32>, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%1) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x2xf32>) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "reinterpret_of_extract_strided_metadata_w_different_stride"}> ({
  ^bb0(%arg0: memref<8x2xf32>):
    %0:6 = "memref.extract_strided_metadata"(%arg0) : (memref<8x2xf32>) -> (memref<f32>, index, index, index, index, index)
    %1 = "memref.reinterpret_cast"(%0#0, %0#1, %0#5) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4, 2, 2>, static_strides = array<i64: 1, 1, -9223372036854775808>}> : (memref<f32>, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "func.return"(%1) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x2xf32>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "reinterpret_of_extract_strided_metadata_w_different_offset"}> ({
  ^bb0(%arg0: memref<8x2xf32>):
    %0:6 = "memref.extract_strided_metadata"(%arg0) : (memref<8x2xf32>) -> (memref<f32>, index, index, index, index, index)
    %1 = "memref.reinterpret_cast"(%0#0, %0#2, %0#3, %0#4, %0#5) <{operandSegmentSizes = array<i32: 1, 0, 2, 2>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<f32>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%1) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x?xf32>, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "canonicalize_rank_reduced_subview"}> ({
  ^bb0(%arg0: memref<8x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.subview"(%arg0, %0, %0, %arg1, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<8x?xf32>, index, index, index, index, index) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%2) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xf32>, f32) -> memref<2xf32>, sym_name = "memref_realloc_dead"}> ({
  ^bb0(%arg0: memref<2xf32>, %arg1: f32):
    %0 = "memref.realloc"(%arg0) : (memref<2xf32>) -> memref<4xf32>
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%arg1, %0, %1) : (f32, memref<4xf32>, index) -> ()
    "func.return"(%arg0) : (memref<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[1]>, 3>, index) -> memref<?xf32, 3>, sym_name = "collapse_expand_fold_to_cast"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[1]>, 3>, %arg1: index):
    %0 = "memref.expand_shape"(%arg0, %arg1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, -9223372036854775808>}> : (memref<?xf32, strided<[1]>, 3>, index) -> memref<1x?xf32, 3>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1]]}> : (memref<1x?xf32, 3>) -> memref<?xf32, 3>
    "func.return"(%1) : (memref<?xf32, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "fold_trivial_subviews"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "memref.subview"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%1) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, memref<32xf32>) -> (), sym_name = "load_store_nontemporal"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: memref<32xf32>):
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "memref.load"(%arg0, %0) <{nontemporal = true}> : (memref<32xf32>, index) -> f32
    "memref.store"(%1, %arg1, %0) <{nontemporal = true}> : (f32, memref<32xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "fold_trivial_memory_space_cast"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "memref.memory_space_cast"(%arg0) : (memref<?xf32>) -> memref<?xf32>
    "func.return"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32, 2>, sym_name = "fold_multiple_memory_space_cast"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "memref.memory_space_cast"(%arg0) : (memref<?xf32>) -> memref<?xf32, 1>
    %1 = "memref.memory_space_cast"(%0) : (memref<?xf32, 1>) -> memref<?xf32, 2>
    "func.return"(%1) : (memref<?xf32, 2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<?x?x?xi1>, sym_name = "ub_negative_alloc_size", sym_visibility = "private"}> ({
    %0 = "index.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = -2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 15 : index}> : () -> index
    %3 = "memref.alloc"(%2, %1, %0) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<?x?x?xi1>
    "func.return"(%3) : (memref<?x?x?xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x384x384xf32>, index) -> memref<?x?xf32, strided<[384, 1], offset: ?>>, sym_name = "subview_rank_reduction"}> ({
  ^bb0(%arg0: memref<1x384x384xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %arg1, %arg1, %0, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x384x384xf32>, index, index, index, index) -> memref<?x?xf32, strided<[384, 1], offset: ?>>
    "func.return"(%1) : (memref<?x?xf32, strided<[384, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d1, d0, d4, d3, d2)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d4, d0, d3, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x2x3x4x5xf32>) -> memref<5x3x2x4x1xf32, strided<[1, 20, 60, 5, 120]>>, sym_name = "fold_double_transpose"}> ({
  ^bb0(%arg0: memref<1x2x3x4x5xf32>):
    %0 = "memref.transpose"(%arg0) <{permutation = #map}> : (memref<1x2x3x4x5xf32>) -> memref<2x1x5x4x3xf32, strided<[60, 120, 1, 5, 20]>>
    %1 = "memref.transpose"(%0) <{permutation = #map1}> : (memref<2x1x5x4x3xf32, strided<[60, 120, 1, 5, 20]>>) -> memref<5x3x2x4x1xf32, strided<[1, 20, 60, 5, 120]>>
    "func.return"(%1) : (memref<5x3x2x4x1xf32, strided<[1, 20, 60, 5, 120]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d4, d3, d2)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d4, d1, d3, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x2x3x4x5xf32>) -> memref<5x3x2x4x1xf32, strided<[1, 20, 60, 5, 120]>>, sym_name = "fold_double_transpose2"}> ({
  ^bb0(%arg0: memref<1x2x3x4x5xf32>):
    %0 = "memref.transpose"(%arg0) <{permutation = #map}> : (memref<1x2x3x4x5xf32>) -> memref<1x2x5x4x3xf32, strided<[120, 60, 1, 5, 20]>>
    %1 = "memref.transpose"(%0) <{permutation = #map1}> : (memref<1x2x5x4x3xf32, strided<[120, 60, 1, 5, 20]>>) -> memref<5x3x2x4x1xf32, strided<[1, 20, 60, 5, 120]>>
    "func.return"(%1) : (memref<5x3x2x4x1xf32, strided<[1, 20, 60, 5, 120]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d1, d0, d4, d3, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x2x3x4x5xf32>) -> memref<1x2x3x4x5xf32>, sym_name = "fold_identity_transpose"}> ({
  ^bb0(%arg0: memref<1x2x3x4x5xf32>):
    %0 = "memref.transpose"(%arg0) <{permutation = #map}> : (memref<1x2x3x4x5xf32>) -> memref<2x1x5x4x3xf32, strided<[60, 120, 1, 5, 20]>>
    %1 = "memref.transpose"(%0) <{permutation = #map}> : (memref<2x1x5x4x3xf32, strided<[60, 120, 1, 5, 20]>>) -> memref<1x2x3x4x5xf32>
    "func.return"(%1) : (memref<1x2x3x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1)[s0] -> (d0 + d1 * s0)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x4xf32>) -> memref<?x?xf32, #map>, sym_name = "cannot_fold_transpose_cast"}> ({
  ^bb0(%arg0: memref<?x4xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?x4xf32>) -> memref<?x?xf32>
    %1 = "memref.transpose"(%0) <{permutation = #map1}> : (memref<?x?xf32>) -> memref<?x?xf32, #map>
    "func.return"(%1) : (memref<?x?xf32, #map>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xf32>) -> memref<128xf32>, sym_name = "fold_assume_alignment_chain"}> ({
  ^bb0(%arg0: memref<128xf32>):
    %0 = "memref.assume_alignment"(%arg0) <{alignment = 16 : i32}> : (memref<128xf32>) -> memref<128xf32>
    %1 = "memref.assume_alignment"(%0) <{alignment = 16 : i32}> : (memref<128xf32>) -> memref<128xf32>
    "func.return"(%1) : (memref<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xi8>) -> memref<i32>, sym_name = "fold_view_cast"}> ({
  ^bb0(%arg0: memref<128xi8>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.cast"(%arg0) : (memref<128xi8>) -> memref<?xi8>
    %2 = "memref.view"(%1, %0) : (memref<?xi8>, index) -> memref<i32>
    "func.return"(%2) : (memref<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xi8>) -> memref<128xi8>, sym_name = "fold_view_same_source_result_types"}> ({
  ^bb0(%arg0: memref<128xi8>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.view"(%arg0, %0) : (memref<128xi8>, index) -> memref<128xi8>
    "func.return"(%1) : (memref<128xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xi8>) -> memref<128xi8>, sym_name = "non_fold_view_non_zero_offset"}> ({
  ^bb0(%arg0: memref<128xi8>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.view"(%arg0, %0) : (memref<128xi8>, index) -> memref<128xi8>
    "func.return"(%1) : (memref<128xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index) -> memref<?xi8>, sym_name = "non_fold_view_same_source_dynamic_size"}> ({
  ^bb0(%arg0: memref<?xi8>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.view"(%arg0, %0, %arg1) : (memref<?xi8>, index, index) -> memref<?xi8>
    "func.return"(%1) : (memref<?xi8>) -> ()
  }) : () -> ()
}) : () -> ()

