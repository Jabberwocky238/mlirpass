"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> (memref<?xf32>, memref<?xf32>, memref<?xf32>), sym_name = "insert_slice_fun", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: memref<4xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<4xf32, strided<[1]>>
    "memref.copy"(%arg2, %3) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[1]>>) -> ()
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.dim"(%arg0, %4) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %6 = "memref.alloc"(%5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %6) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %7 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<4xf32, strided<[1]>>
    "memref.copy"(%arg3, %7) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[1]>>) -> ()
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "memref.dim"(%arg1, %8) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %10 = "memref.alloc"(%9) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg1, %10) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %11 = "memref.subview"(%10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<4xf32, strided<[1]>>
    "memref.copy"(%arg2, %11) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[1]>>) -> ()
    %12 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg3, %12) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
    %13 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %14 = "memref.cast"(%6) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %15 = "memref.cast"(%10) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%2, %6, %10) : (memref<?xf32>, memref<?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "insert_slice_fun"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<4xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg1, %1) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
    "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "insert_slice_fun"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<4xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
    %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg1, %1) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> memref<?xf32>, sym_name = "insert_slice_fun_not_inplace"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<4xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<4xf32, strided<[1]>>
    "memref.copy"(%arg1, %3) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[1]>>) -> ()
    %4 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%2) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "tensor_cast_not_in_place"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: index):
    %0 = "memref.cast"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "memref.copy"(%0, %1) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32>) -> ()
    %2 = "memref.subview"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<4xf32, strided<[?], offset: ?>>
    "memref.copy"(%1, %2) : (memref<4xf32>, memref<4xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, f32, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "insert_op"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32, %arg2: index):
    "memref.store"(%arg1, %arg0, %arg2) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 ceildiv 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<8x18x32xf32, strided<[?, ?, ?], offset: ?>>) -> memref<?x1x6x8xf32>, sym_name = "rank_reducing"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<8x18x32xf32, strided<[?, ?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 6 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x1x6x8xf32>
    %6 = "memref.cast"(%5) : (memref<4x1x6x8xf32>) -> memref<?x1x6x8xf32>
    %7 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x6x8xf32>
    %8 = "scf.for"(%4, %3, %2, %6) ({
    ^bb0(%arg3: index, %arg4: memref<?x1x6x8xf32>):
      %10 = "affine.apply"(%arg3) <{map = #map}> : (index) -> index
      %11 = "memref.subview"(%arg2, %arg0, %arg1, %arg3) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 6, 8>, static_strides = array<i64: 1, 1, 1>}> : (memref<8x18x32xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> memref<1x6x8xf32, strided<[?, ?, ?], offset: ?>>
      %12 = "scf.for"(%4, %1, %0, %7) ({
      ^bb0(%arg5: index, %arg6: memref<1x6x8xf32>):
        %14 = "memref.subview"(%11, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 8>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x6x8xf32, strided<[?, ?, ?], offset: ?>>, index) -> memref<1x1x8xf32, strided<[?, ?, ?], offset: ?>>
        %15 = "memref.subview"(%arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 8>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x6x8xf32>, index) -> memref<1x1x8xf32, strided<[48, 8, 1], offset: ?>>
        "memref.copy"(%14, %15) : (memref<1x1x8xf32, strided<[?, ?, ?], offset: ?>>, memref<1x1x8xf32, strided<[48, 8, 1], offset: ?>>) -> ()
        "scf.yield"(%arg6) : (memref<1x6x8xf32>) -> ()
      }) : (index, index, index, memref<1x6x8xf32>) -> memref<1x6x8xf32>
      %13 = "memref.subview"(%arg4, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 1, 6, 8>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<?x1x6x8xf32>, index) -> memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>
      "memref.copy"(%12, %13) : (memref<1x6x8xf32>, memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>) -> ()
      "scf.yield"(%arg4) : (memref<?x1x6x8xf32>) -> ()
    }) : (index, index, index, memref<?x1x6x8xf32>) -> memref<?x1x6x8xf32>
    %9 = "memref.cast"(%8) : (memref<?x1x6x8xf32>) -> memref<?x1x6x8xf32, strided<[?, ?, ?, ?], offset: ?>>
    "func.return"(%8) : (memref<?x1x6x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<100xf32, strided<[?], offset: ?>>, memref<200x100xf32, strided<[?, ?], offset: ?>>) -> (), sym_name = "rank_reducing_parallel_insert_slice"}> ({
  ^bb0(%arg0: memref<100xf32, strided<[?], offset: ?>>, %arg1: memref<200x100xf32, strided<[?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 100 : index}> : () -> index
    "scf.forall"(%1) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index):
      %2 = "memref.subview"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<100xf32, strided<[?], offset: ?>>, index) -> memref<1xf32, strided<[?], offset: ?>>
      %3 = "memref.subview"(%arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 1, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<200x100xf32, strided<[?, ?], offset: ?>>, index) -> memref<1xf32, strided<[?], offset: ?>>
      "memref.copy"(%2, %3) : (memref<1xf32, strided<[?], offset: ?>>, memref<1xf32, strided<[?], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xf32, strided<[?], offset: ?>>) -> memref<2xf32, strided<[?], offset: ?>>, sym_name = "parallel_insert_full_slice_in_place"}> ({
  ^bb0(%arg0: memref<2xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "scf.forall"() <{mapping = [#gpu.thread<linear_dim_0>], operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 1>}> ({
    ^bb0(%arg1: index):
      "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg2: f32, %arg3: f32):
        "linalg.yield"(%arg2) : (f32) -> ()
      }) : (f32, memref<2xf32, strided<[?], offset: ?>>) -> ()
      %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (memref<2xf32, strided<[?], offset: ?>>) -> memref<2xf32, strided<[?], offset: ?>>
      "memref.copy"(%arg0, %1) : (memref<2xf32, strided<[?], offset: ?>>, memref<2xf32, strided<[?], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
    "func.return"(%arg0) : (memref<2xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>, sym_name = "insert_equivalent_tensor"}> ({
  ^bb0(%arg0: memref<10xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<10xf32>) -> ()
    %2 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>
    "memref.copy"(%1, %2) : (memref<10xf32>, memref<10xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<10xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, f32, index) -> f32, sym_name = "pad_memory_space"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: f32, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32, 3>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, 3>) -> ()
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<15xf32, 3>
    "linalg.map"(%3) ({
    ^bb0(%arg4: f32):
      %8 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<15xf32, 3>) -> ()
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.dim"(%2, %4) : (memref<?xf32, 3>, index) -> index
    %6 = "memref.subview"(%3, %5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<15xf32, 3>, index) -> memref<?xf32, strided<[1], offset: 2>, 3>
    "memref.copy"(%2, %6) : (memref<?xf32, 3>, memref<?xf32, strided<[1], offset: 2>, 3>) -> ()
    %7 = "memref.load"(%3, %arg3) <{invariant = false, nontemporal = false}> : (memref<15xf32, 3>, index) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>, sym_name = "insert_slice_regression"}> ({
  ^bb0(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<5xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<10xf32>) -> ()
    %3 = "vector.transfer_read"(%2, %1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<10xf32>, index, f32) -> vector<10xf32>
    "vector.print"(%3) <{punctuation = #vector.punctuation<newline>}> : (vector<10xf32>) -> ()
    %4 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg1, %4) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<10xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, strided<[?], offset: ?>>, memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>, sym_name = "insert_slice_full_overwrite"}> ({
  ^bb0(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<10xf32, strided<[?], offset: ?>>) -> ()
    %2 = "vector.transfer_read"(%arg0, %1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<10xf32, strided<[?], offset: ?>>, index, f32) -> vector<10xf32>
    "vector.print"(%2) <{punctuation = #vector.punctuation<newline>}> : (vector<10xf32>) -> ()
    %3 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg1, %3) : (memref<10xf32, strided<[?], offset: ?>>, memref<10xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg0) : (memref<10xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, f32, index) -> (memref<?xf32, strided<[?], offset: ?>>, index), sym_name = "dim_not_reading"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%arg1, %arg0, %arg2) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    "func.return"(%arg0, %1) : (memref<?xf32, strided<[?], offset: ?>>, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 + 5)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, #map>, index) -> memref<?xf32, strided<[1], offset: 7>>, sym_name = "cast_retains_buffer_layout", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, #map>, %arg1: index):
    %0 = "memref.cast"(%arg0) : (memref<?xf32, #map>) -> memref<10xf32, #map>
    %1 = "memref.subview"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<10xf32, #map>, index) -> memref<?xf32, strided<[1], offset: 7>>
    %2 = "memref.cast"(%0) : (memref<10xf32, #map>) -> memref<10xf32, strided<[?], offset: ?>>
    %3 = "memref.cast"(%1) : (memref<?xf32, strided<[1], offset: 7>>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%1) : (memref<?xf32, strided<[1], offset: 7>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: 5>>, index) -> memref<?xf32, strided<[1], offset: 7>>, sym_name = "cast_retains_buffer_layout_strided", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[1], offset: 5>>, %arg1: index):
    %0 = "memref.cast"(%arg0) : (memref<?xf32, strided<[1], offset: 5>>) -> memref<10xf32, strided<[1], offset: 5>>
    %1 = "memref.subview"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<10xf32, strided<[1], offset: 5>>, index) -> memref<?xf32, strided<[1], offset: 7>>
    %2 = "memref.cast"(%0) : (memref<10xf32, strided<[1], offset: 5>>) -> memref<10xf32, strided<[?], offset: ?>>
    %3 = "memref.cast"(%1) : (memref<?xf32, strided<[1], offset: 7>>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%1) : (memref<?xf32, strided<[1], offset: 7>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1xf32, strided<[?], offset: ?>>, memref<100xf32, strided<[?], offset: ?>>, f32) -> (), sym_name = "parallel_insert_slice_source_out_of_place"}> ({
  ^bb0(%arg0: memref<1xf32, strided<[?], offset: ?>>, %arg1: memref<100xf32, strided<[?], offset: ?>>, %arg2: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 50 : index}> : () -> index
    "scf.forall"(%2) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg3: index):
      %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf32>
      "memref.copy"(%arg0, %3) : (memref<1xf32, strided<[?], offset: ?>>, memref<1xf32>) -> ()
      "memref.store"(%arg2, %3, %0) <{nontemporal = false}> : (f32, memref<1xf32>, index) -> ()
      %4 = "memref.load"(%arg0, %0) <{invariant = false, nontemporal = false}> : (memref<1xf32, strided<[?], offset: ?>>, index) -> f32
      "vector.print"(%4) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      %5 = "memref.subview"(%arg1, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<100xf32, strided<[?], offset: ?>>, index) -> memref<1xf32, strided<[?], offset: ?>>
      "memref.copy"(%3, %5) : (memref<1xf32>, memref<1xf32, strided<[?], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<[2, 2, 5]> : tensor<3xi64>, sym_name = "__constant_3xi64", sym_visibility = "private", type = memref<3xi64>}> : () -> ()
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<0.000000e+00> : tensor<2x10xf32>, sym_name = "__constant_2x10xf32", sym_visibility = "private", type = memref<2x10xf32>}> : () -> ()
  "func.func"() <{function_type = () -> memref<2x2x5xf32>, sym_name = "tensor.reshape"}> ({
    %0 = "memref.get_global"() <{name = @__constant_2x10xf32}> : () -> memref<2x10xf32>
    %1 = "memref.cast"(%0) : (memref<2x10xf32>) -> memref<?x10xf32>
    %2 = "memref.get_global"() <{name = @__constant_3xi64}> : () -> memref<3xi64>
    %3 = "memref.reshape"(%1, %2) : (memref<?x10xf32>, memref<3xi64>) -> memref<2x2x5xf32>
    %4 = "memref.cast"(%3) : (memref<2x2x5xf32>) -> memref<2x2x5xf32, strided<[?, ?, ?], offset: ?>>
    "func.return"(%3) : (memref<2x2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<0.000000e+00> : tensor<10xf32>, sym_name = "__constant_10xf32", sym_visibility = "private", type = memref<10xf32>}> : () -> ()
  "func.func"() <{function_type = (index, index) -> memref<?x?xf32>, sym_name = "tensor_reshape_aliasing"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.get_global"() <{name = @__constant_10xf32}> : () -> memref<10xf32>
    %1 = "memref.cast"(%0) : (memref<10xf32>) -> memref<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xindex>
    "memref.store"(%arg0, %4, %2) <{nontemporal = false}> : (index, memref<2xindex>, index) -> ()
    "memref.store"(%arg1, %4, %3) <{nontemporal = false}> : (index, memref<2xindex>, index) -> ()
    %5 = "memref.reshape"(%1, %4) : (memref<?xf32>, memref<2xindex>) -> memref<?x?xf32>
    %6 = "memref.cast"(%5) : (memref<?x?xf32>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%5) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x2xf32, strided<[?, ?], offset: ?>, 3>, memref<2xi32, strided<[?], offset: ?>>, index) -> f32, sym_name = "reshape_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<2x2xf32, strided<[?, ?], offset: ?>, 3>, %arg1: memref<2xi32, strided<[?], offset: ?>>, %arg2: index):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1, 0>, static_sizes = array<i64: 1, 2>, static_strides = array<i64: 1, 1>}> : (memref<2x2xf32, strided<[?, ?], offset: ?>, 3>) -> memref<2xf32, strided<[?], offset: ?>, 3>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32, 3>
    "memref.copy"(%0, %1) : (memref<2xf32, strided<[?], offset: ?>, 3>, memref<2xf32, 3>) -> ()
    %2 = "memref.reshape"(%1, %arg1) : (memref<2xf32, 3>, memref<2xi32, strided<[?], offset: ?>>) -> memref<1x2xf32, 3>
    %3 = "memref.load"(%2, %arg2, %arg2) <{invariant = false, nontemporal = false}> : (memref<1x2xf32, 3>, index, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x20xf32, strided<[?, ?], offset: ?>>, f32, index) -> (), sym_name = "collapse_shape_regression"}> ({
  ^bb0(%arg0: memref<10x20xf32, strided<[?, ?], offset: ?>>, %arg1: f32, %arg2: index):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2, 3>, static_sizes = array<i64: 5, 6>, static_strides = array<i64: 1, 1>}> : (memref<10x20xf32, strided<[?, ?], offset: ?>>) -> memref<5x6xf32, strided<[?, ?], offset: ?>>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x6xf32>
    "memref.copy"(%0, %1) : (memref<5x6xf32, strided<[?, ?], offset: ?>>, memref<5x6xf32>) -> ()
    "memref.store"(%arg1, %1, %arg2, %arg2) <{nontemporal = false}> : (f32, memref<5x6xf32>, index, index) -> ()
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x6xf32>
    "memref.copy"(%0, %2) : (memref<5x6xf32, strided<[?, ?], offset: ?>>, memref<5x6xf32>) -> ()
    %3 = "memref.collapse_shape"(%2) <{reassociation = [[0, 1]]}> : (memref<5x6xf32>) -> memref<30xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, i1, index, index) -> index, sym_name = "mult_return_callee", sym_visibility = "private"}> ({
  ^bb0(%arg4: memref<?xf32, strided<[?], offset: ?>>, %arg5: i1, %arg6: index, %arg7: index):
    %2 = "memref.cast"(%arg4) : (memref<?xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>
    "cf.cond_br"(%arg5)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%arg6) : (index) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%arg7) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, i1, index, index) -> (memref<?xf32, strided<[?], offset: ?>>, index), sym_name = "mult_return"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: i1, %arg2: index, %arg3: index):
    %0 = "func.call"(%arg0, %arg1, %arg2, %arg3) <{callee = @mult_return_callee}> : (memref<?xf32, strided<[?], offset: ?>>, i1, index, index) -> index
    %1 = "memref.cast"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>>
    "func.return"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> ()
  }) : () -> ()
}) : () -> ()

