"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "view"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xi8>
    %1 = "memref.view"(%0, %arg2, %arg0, %arg1) : (memref<2048xi8>, index, index, index) -> memref<?x?xf32>
    %2 = "memref.view"(%0, %arg2, %arg1) : (memref<2048xi8>, index, index) -> memref<4x?xf32>
    %3 = "memref.view"(%0, %arg2) : (memref<2048xi8>, index) -> memref<64x4xf32>
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xi8, 4>
    %5 = "memref.view"(%4, %arg2) : (memref<2048xi8, 4>, index) -> memref<64x4xf32, 4>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<0xi8>) -> (), sym_name = "view_empty_memref"}> ({
  ^bb0(%arg0: index, %arg1: memref<0xi8>):
    %0 = "memref.view"(%arg1, %arg0) : (memref<0xi8>, index) -> memref<0x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<2xi8>) -> (), sym_name = "view_memref_as_rank0"}> ({
  ^bb0(%arg0: index, %arg1: memref<2xi8>):
    %0 = "memref.view"(%arg1, %arg0) : (memref<2xi8>, index) -> memref<bf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> (), sym_name = "subview"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg1, %arg2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<64x4xf32, strided<[4, 1]>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf16>) -> (), sym_name = "assume_alignment"}> ({
  ^bb0(%arg0: memref<4x4xf16>):
    %0 = "memref.assume_alignment"(%arg0) <{alignment = 16 : i32}> : (memref<4x4xf16>) -> memref<4x4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf16>, memref<?xf32>, memref<?xf64>) -> (memref<?xf16>, memref<?xf32>, memref<?xf64>), sym_name = "distinct_objects"}> ({
  ^bb0(%arg0: memref<?xf16>, %arg1: memref<?xf32>, %arg2: memref<?xf64>):
    %0:3 = "memref.distinct_objects"(%arg0, %arg1, %arg2) : (memref<?xf16>, memref<?xf32>, memref<?xf64>) -> (memref<?xf16>, memref<?xf32>, memref<?xf64>)
    "func.return"(%0#0, %0#1, %0#2) : (memref<?xf16>, memref<?xf32>, memref<?xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf16>) -> memref<?xf16>, sym_name = "distinct_objects_noop"}> ({
  ^bb0(%arg0: memref<?xf16>):
    %0 = "memref.distinct_objects"(%arg0) : (memref<?xf16>) -> memref<?xf16>
    "func.return"(%0) : (memref<?xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf16, strided<[?, ?], offset: ?>>) -> (), sym_name = "assume_alignment_w_offset"}> ({
  ^bb0(%arg0: memref<4x4xf16, strided<[?, ?], offset: ?>>):
    %0 = "memref.assume_alignment"(%arg0) <{alignment = 16 : i32}> : (memref<4x4xf16, strided<[?, ?], offset: ?>>) -> memref<4x4xf16, strided<[?, ?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> index, sym_name = "dim_of_unranked"}> ({
  ^bb0(%arg0: memref<*xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<*xi32>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32, 7>) -> (), sym_name = "address_space"}> ({
  ^bb0(%arg0: memref<32xf32, 7>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32, 5>
    %1 = "arith.constant"() <{value = 7 : index}> : () -> index
    %2 = "memref.load"(%0, %1) : (memref<32xf32, 5>, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2, d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> (), sym_name = "transpose"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>):
    %0 = "memref.transpose"(%arg0) <{permutation = #map}> : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> memref<?x?x?xf32, strided<[1, ?, ?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{initial_value, sym_name = "gv0", type = memref<2xf32>}> : () -> ()
  "memref.global"() <{sym_name = "gv1", sym_visibility = "private", type = memref<2xf32>}> : () -> ()
  "memref.global"() <{initial_value = dense<[[0.000000e+00, 1.000000e+00, 2.000000e+00], [3.000000e+00, 4.000000e+00, 5.000000e+00]]> : tensor<2x3xf32>, sym_name = "gv2", type = memref<2x3xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_gv0_memref"}> ({
    %2 = "memref.get_global"() <{name = @gv0}> : () -> memref<2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_gv2_memref"}> ({
    %1 = "memref.get_global"() <{name = @gv2}> : () -> memref<2x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "memref.global"() <{initial_value = dense<1.000000e+00> : tensor<f32>, sym_name = "gv3", type = memref<f32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_gv3_memref"}> ({
    %0 = "memref.get_global"() <{name = @gv3}> : () -> memref<f32>
    "func.return"() : () -> ()
  }) : () -> ()
  "memref.global"() <{alignment = 64 : i64, initial_value = dense<1.000000e+00> : tensor<f32>, sym_name = "gv4", sym_visibility = "private", type = memref<f32>}> : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x4x5xf32>) -> memref<1x3x4x1x5xf32>, sym_name = "expand_shape_static"}> ({
  ^bb0(%arg0: memref<3x4x5xf32>):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]], static_output_shape = array<i64: 1, 3, 4, 1, 5>}> : (memref<3x4x5xf32>) -> memref<1x3x4x1x5xf32>
    "func.return"(%0) : (memref<1x3x4x1x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x3x4x1x5xf32>) -> memref<3x4x5xf32>, sym_name = "collapse_shape_static"}> ({
  ^bb0(%arg0: memref<1x3x4x1x5xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (memref<1x3x4x1x5xf32>) -> memref<3x4x5xf32>
    "func.return"(%0) : (memref<3x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "rank_of_unranked"}> ({
  ^bb0(%arg0: memref<*xi32>):
    %0 = "memref.rank"(%arg0) : (memref<*xi32>) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> (), sym_name = "rank_of_ranked"}> ({
  ^bb0(%arg0: memref<?xi32>):
    %0 = "memref.rank"(%arg0) : (memref<?xi32>) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xi32>, i32, memref<10xf32>, f32, index) -> (), sym_name = "atomic_rmw"}> ({
  ^bb0(%arg0: memref<10xi32>, %arg1: i32, %arg2: memref<10xf32>, %arg3: f32, %arg4: index):
    %0 = "memref.atomic_rmw"(%arg3, %arg2, %arg4) <{kind = 3 : i64}> : (f32, memref<10xf32>, index) -> f32
    %1 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 1 : i64}> : (i32, memref<10xi32>, index) -> i32
    %2 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 6 : i64}> : (i32, memref<10xi32>, index) -> i32
    %3 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 10 : i64}> : (i32, memref<10xi32>, index) -> i32
    %4 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 7 : i64}> : (i32, memref<10xi32>, index) -> i32
    %5 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 11 : i64}> : (i32, memref<10xi32>, index) -> i32
    %6 = "memref.atomic_rmw"(%arg3, %arg2, %arg4) <{kind = 0 : i64}> : (f32, memref<10xf32>, index) -> f32
    %7 = "memref.atomic_rmw"(%arg3, %arg2, %arg4) <{kind = 4 : i64}> : (f32, memref<10xf32>, index) -> f32
    %8 = "memref.atomic_rmw"(%arg3, %arg2, %arg4) <{kind = 5 : i64}> : (f32, memref<10xf32>, index) -> f32
    %9 = "memref.atomic_rmw"(%arg3, %arg2, %arg4) <{kind = 8 : i64}> : (f32, memref<10xf32>, index) -> f32
    %10 = "memref.atomic_rmw"(%arg3, %arg2, %arg4) <{kind = 9 : i64}> : (f32, memref<10xf32>, index) -> f32
    %11 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 14 : i64}> : (i32, memref<10xi32>, index) -> i32
    %12 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 2 : i64}> : (i32, memref<10xi32>, index) -> i32
    %13 = "memref.atomic_rmw"(%arg1, %arg0, %arg4) <{kind = 15 : i64}> : (i32, memref<10xi32>, index) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xi32, strided<[1], offset: 5>>, i32, index) -> (), sym_name = "atomic_rmw_with_offset"}> ({
  ^bb0(%arg0: memref<10xi32, strided<[1], offset: 5>>, %arg1: i32, %arg2: index):
    %0 = "memref.atomic_rmw"(%arg1, %arg0, %arg2) <{kind = 2 : i64}> : (i32, memref<10xi32, strided<[1], offset: 5>>, index) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "generic_atomic_rmw", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "test.foo"() : () -> memref<10xi32>
    %1 = "test.foo"() : () -> index
    %2 = "memref.generic_atomic_rmw"(%0, %1) ({
    ^bb0(%arg0: i32):
      "memref.atomic_yield"(%arg0) : (i32) -> ()
    }) : (memref<10xi32>, index) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "generic_atomic_rmw_in_alloca_scope", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x3xi32>
    "memref.alloca_scope"() ({
      %2 = "memref.generic_atomic_rmw"(%1, %0, %0) ({
      ^bb0(%arg0: i32):
        "memref.atomic_yield"(%arg0) : (i32) -> ()
      }) : (memref<2x3xi32>, index, index) -> i32
      "memref.alloca_scope.return"() : () -> ()
    }) : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "memref_copy_ranked"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    %1 = "memref.cast"(%0) : (memref<2xf32>) -> memref<?xf32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    %3 = "memref.cast"(%2) : (memref<2xf32>) -> memref<?xf32>
    "memref.copy"(%1, %3) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x4xi32>, index) -> (), sym_name = "memref_copy_contiguous"}> ({
  ^bb0(%arg0: memref<16x4xi32>, %arg1: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x2xi32>
    %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, 2>, static_strides = array<i64: 1, 1>}> : (memref<16x4xi32>, index) -> memref<1x2xi32, strided<[4, 1], offset: ?>>
    "memref.copy"(%1, %0) : (memref<1x2xi32, strided<[4, 1], offset: ?>>, memref<1x2xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>) -> (), sym_name = "memref_copy_0d_offset"}> ({
  ^bb0(%arg0: memref<2xi32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<2xi32>) -> memref<1xi32, strided<[1], offset: 1>>
    %2 = "memref.collapse_shape"(%1) <{reassociation = []}> : (memref<1xi32, strided<[1], offset: 1>>) -> memref<i32, strided<[], offset: 1>>
    "memref.copy"(%2, %0) : (memref<i32, strided<[], offset: 1>>, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x2xi32>, index) -> (), sym_name = "memref_copy_noncontiguous"}> ({
  ^bb0(%arg0: memref<16x2xi32>, %arg1: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x1xi32>
    %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 2, 1>, static_strides = array<i64: 1, 1>}> : (memref<16x2xi32>, index) -> memref<2x1xi32, strided<[2, 1], offset: ?>>
    "memref.copy"(%1, %0) : (memref<2x1xi32, strided<[2, 1], offset: ?>>, memref<2x1xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "memref_copy_unranked"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi1>
    %1 = "memref.cast"(%0) : (memref<2xi1>) -> memref<*xi1>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi1>
    %3 = "memref.cast"(%2) : (memref<2xi1>) -> memref<*xi1>
    "memref.copy"(%1, %3) : (memref<*xi1>, memref<*xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> index, sym_name = "extract_aligned_pointer_as_index"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?xf32>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> index, sym_name = "extract_aligned_pointer_as_index_unranked"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<*xf32>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> (), sym_name = "extract_strided_metadata"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>):
    %0:6 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>) -> (), sym_name = "load_non_temporal"}> ({
  ^bb0(%arg0: memref<32xf32>):
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "memref.load"(%arg0, %0) <{nontemporal = true}> : (memref<32xf32>, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> (), sym_name = "load_with_alignment"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "memref.load"(%arg0, %arg1) <{alignment = 32 : i64}> : (memref<32xf32>, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, memref<32xf32>) -> (), sym_name = "store_non_temporal"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: memref<32xf32>):
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "memref.load"(%arg0, %0) <{nontemporal = true}> : (memref<32xf32>, index) -> f32
    "memref.store"(%1, %arg1, %0) <{nontemporal = true}> : (f32, memref<32xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, f32, index) -> (), sym_name = "store_with_alignment"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: f32, %arg2: index):
    "memref.store"(%arg1, %arg0, %arg2) <{alignment = 32 : i64}> : (f32, memref<32xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloca_unconvertable_memory_space"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x32x33xi32, #spirv.storage_class<StorageBuffer>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

