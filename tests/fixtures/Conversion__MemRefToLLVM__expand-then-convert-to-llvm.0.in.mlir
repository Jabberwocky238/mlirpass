"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "subview"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg1, %arg2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<64x4xf32, strided<[4, 1]>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>, 3>, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>, 3>, sym_name = "subview_non_zero_addrspace"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>, 3>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg1, %arg2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<64x4xf32, strided<[4, 1]>, 3>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>, 3>
    "func.return"(%0) : (memref<?x?xf32, strided<[?, ?], offset: ?>, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<4x2xf32, strided<[?, ?], offset: ?>>, sym_name = "subview_const_size"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 2>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<64x4xf32, strided<[4, 1]>>, index, index, index, index) -> memref<4x2xf32, strided<[?, ?], offset: ?>>
    "func.return"(%0) : (memref<4x2xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<?x?xf32, strided<[4, 2], offset: ?>>, sym_name = "subview_const_stride"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 2>}> : (memref<64x4xf32, strided<[4, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[4, 2], offset: ?>>
    "func.return"(%0) : (memref<?x?xf32, strided<[4, 2], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x8xf32, strided<[8, 1]>>) -> memref<62x3xf32, strided<[8, 1], offset: 2>>, sym_name = "subview_const_stride_and_offset"}> ({
  ^bb0(%arg0: memref<64x8xf32, strided<[8, 1]>>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 2>, static_sizes = array<i64: 62, 3>, static_strides = array<i64: 1, 1>}> : (memref<64x8xf32, strided<[8, 1]>>) -> memref<62x3xf32, strided<[8, 1], offset: 2>>
    "func.return"(%0) : (memref<62x3xf32, strided<[8, 1], offset: 2>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<62x?xf32, strided<[?, 1], offset: ?>>, sym_name = "subview_mixed_static_dynamic"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.subview"(%arg0, %arg2, %arg3, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_offsets = array<i64: -9223372036854775808, 2>, static_sizes = array<i64: 62, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<62x?xf32, strided<[?, 1], offset: ?>>
    "func.return"(%0) : (memref<62x?xf32, strided<[?, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x3xf32>, memref<5x?xf32>) -> memref<3x3xf32, strided<[3, 1], offset: 6>>, sym_name = "subview_leading_operands"}> ({
  ^bb0(%arg0: memref<5x3xf32>, %arg1: memref<5x?xf32>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2, 0>, static_sizes = array<i64: 3, 3>, static_strides = array<i64: 1, 1>}> : (memref<5x3xf32>) -> memref<3x3xf32, strided<[3, 1], offset: 6>>
    "func.return"(%0) : (memref<3x3xf32, strided<[3, 1], offset: 6>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x?xf32>) -> memref<3x?xf32, strided<[?, 1], offset: ?>>, sym_name = "subview_leading_operands_dynamic"}> ({
  ^bb0(%arg0: memref<5x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<5x?xf32>, index) -> index
    %2 = "memref.subview"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2, 0>, static_sizes = array<i64: 3, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<5x?xf32>, index) -> memref<3x?xf32, strided<[?, 1], offset: ?>>
    "func.return"(%2) : (memref<3x?xf32, strided<[?, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x3xf32>) -> memref<3xf32, strided<[1], offset: 3>>, sym_name = "subview_rank_reducing_leading_operands"}> ({
  ^bb0(%arg0: memref<5x3xf32>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1, 0>, static_sizes = array<i64: 1, 3>, static_strides = array<i64: 1, 1>}> : (memref<5x3xf32>) -> memref<3xf32, strided<[1], offset: 3>>
    "func.return"(%0) : (memref<3xf32, strided<[1], offset: 3>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<7xf32>) -> memref<7xf32, strided<[-1], offset: 6>>, sym_name = "subview_negative_stride"}> ({
  ^bb0(%arg0: memref<7xf32>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 6>, static_sizes = array<i64: 7>, static_strides = array<i64: -1>}> : (memref<7xf32>) -> memref<7xf32, strided<[-1], offset: 6>>
    "func.return"(%0) : (memref<7xf32, strided<[-1], offset: 6>>) -> ()
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
  "func.func"() <{function_type = (memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>>) -> memref<4x?xf32, strided<[?, ?], offset: ?>>, sym_name = "collapse_shape_dynamic_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2]]}> : (memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>>) -> memref<4x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%0) : (memref<4x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
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
  "func.func"() <{function_type = (memref<1x1xf32>) -> memref<f32>, sym_name = "collapse_shape_fold_zero_dim"}> ({
  ^bb0(%arg0: memref<1x1xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = []}> : (memref<1x1xf32>) -> memref<f32>
    "func.return"(%0) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> memref<1x1xf32>, sym_name = "expand_shape_zero_dim"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1, 1>}> : (memref<f32>) -> memref<1x1xf32>
    "func.return"(%0) : (memref<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x2x?xf32>) -> memref<1x?xf32>, sym_name = "collapse_shape_dynamic"}> ({
  ^bb0(%arg0: memref<1x2x?xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2]]}> : (memref<1x2x?xf32>) -> memref<1x?xf32>
    "func.return"(%0) : (memref<1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x?xf32>, index) -> memref<1x2x?xf32>, sym_name = "expand_shape_dynamic"}> ({
  ^bb0(%arg0: memref<1x?xf32>, %arg1: index):
    %0 = "memref.expand_shape"(%arg0, %arg1) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 1, 2, -9223372036854775808>}> : (memref<1x?xf32>, index) -> memref<1x2x?xf32>
    "func.return"(%0) : (memref<1x2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x?xf32, strided<[?, ?], offset: ?>>, index) -> memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "expand_shape_dynamic_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<1x?xf32, strided<[?, ?], offset: ?>>, %arg1: index):
    %0 = "memref.expand_shape"(%arg0, %arg1) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 1, 2, -9223372036854775808>}> : (memref<1x?xf32, strided<[?, ?], offset: ?>>, index) -> memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>
    "func.return"(%0) : (memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>>) -> memref<64xf32, strided<[1], offset: ?>>, sym_name = "collapse_static_shape_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2, 3]]}> : (memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>>) -> memref<64xf32, strided<[1], offset: ?>>
    "func.return"(%0) : (memref<64xf32, strided<[1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32, sym_name = "load_and_assume"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: index, %arg2: index):
    %0 = "memref.assume_alignment"(%arg0) <{alignment = 16 : i32}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    %1 = "memref.load"(%0, %arg1, %arg2) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

