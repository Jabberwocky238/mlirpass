"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, index) -> index, sym_name = "dim"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<*xf32>) -> memref<*xf32>
    %1 = "memref.dim"(%0, %arg1) : (memref<*xf32>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> index, sym_name = "rank"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<*xf32>) -> memref<*xf32>
    %1 = "memref.rank"(%0) : (memref<*xf32>) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<2xindex>, sym_name = "tensor.cast"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xindex>) -> memref<?xindex>
    %1 = "memref.cast"(%0) : (memref<?xindex>) -> memref<2xindex>
    %2 = "bufferization.to_tensor"(%1) : (memref<2xindex>) -> tensor<2xindex>
    "func.return"(%2) : (tensor<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> tensor<2xf32>, sym_name = "tensor.cast_from_unranked"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<*xf32>) -> memref<*xf32>
    %1 = "memref.cast"(%0) : (memref<*xf32>) -> memref<2xf32, strided<[?], offset: ?>>
    %2 = "bufferization.to_tensor"(%1) : (memref<2xf32, strided<[?], offset: ?>>) -> tensor<2xf32>
    "func.return"(%2) : (tensor<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>) -> tensor<*xf32>, sym_name = "tensor.cast_to_unranked"}> ({
  ^bb0(%arg0: tensor<2xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<2xf32>) -> memref<2xf32>
    %1 = "memref.cast"(%0) : (memref<2xf32>) -> memref<*xf32>
    %2 = "bufferization.to_tensor"(%1) : (memref<*xf32>) -> tensor<*xf32>
    "func.return"(%2) : (tensor<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "tensor.empty"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<5xf32>) -> tensor<5xf32>
    "func.return"(%1) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> f32, sym_name = "tensor.extract"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "memref.load"(%0, %arg1) <{invariant = false, nontemporal = false}> : (memref<?xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<index>, sym_name = "tensor.from_elements_0d"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<index>
    "memref.store"(%arg0, %0) : (index, memref<index>) -> ()
    %1 = "bufferization.to_tensor"(%0) : (memref<index>) -> tensor<index>
    "func.return"(%1) : (tensor<index>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> tensor<2xindex>, sym_name = "tensor.from_elements_1d"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xindex>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%arg0, %0, %1) <{nontemporal = false}> : (index, memref<2xindex>, index) -> ()
    "memref.store"(%arg1, %0, %2) <{nontemporal = false}> : (index, memref<2xindex>, index) -> ()
    %3 = "bufferization.to_tensor"(%0) : (memref<2xindex>) -> tensor<2xindex>
    "func.return"(%3) : (tensor<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> tensor<3x2xindex>, sym_name = "tensor.from_elements_2d"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x2xindex>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%arg0, %0, %1, %1) <{nontemporal = false}> : (index, memref<3x2xindex>, index, index) -> ()
    "memref.store"(%arg1, %0, %1, %2) <{nontemporal = false}> : (index, memref<3x2xindex>, index, index) -> ()
    "memref.store"(%arg0, %0, %2, %1) <{nontemporal = false}> : (index, memref<3x2xindex>, index, index) -> ()
    "memref.store"(%arg1, %0, %2, %2) <{nontemporal = false}> : (index, memref<3x2xindex>, index, index) -> ()
    "memref.store"(%arg0, %0, %3, %1) <{nontemporal = false}> : (index, memref<3x2xindex>, index, index) -> ()
    "memref.store"(%arg1, %0, %3, %2) <{nontemporal = false}> : (index, memref<3x2xindex>, index, index) -> ()
    %4 = "bufferization.to_tensor"(%0) : (memref<3x2xindex>) -> tensor<3x2xindex>
    "func.return"(%4) : (tensor<3x2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<3x2x2xf32>, sym_name = "tensor.from_elements_3d"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 6.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 9.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 1.100000e+01 : f32}> : () -> f32
    %11 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x2x2xf32>
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%arg0, %11, %12, %12, %12) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%0, %11, %12, %12, %13) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%1, %11, %12, %13, %12) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%2, %11, %12, %13, %13) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%3, %11, %13, %12, %12) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%4, %11, %13, %12, %13) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%5, %11, %13, %13, %12) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%6, %11, %13, %13, %13) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%7, %11, %14, %12, %12) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%8, %11, %14, %12, %13) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%9, %11, %14, %13, %12) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    "memref.store"(%10, %11, %14, %13, %13) <{nontemporal = false}> : (f32, memref<3x2x2xf32>, index, index, index) -> ()
    %15 = "bufferization.to_tensor"(%11) : (memref<3x2x2xf32>) -> tensor<3x2x2xf32>
    "func.return"(%15) : (tensor<3x2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, index) -> tensor<?xindex>, sym_name = "tensor.generate"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<*xf32>) -> memref<*xf32>
    %1 = "memref.alloc"(%arg1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xindex>
    %2 = "bufferization.to_tensor"(%1) : (memref<?xindex>) -> tensor<?xindex>
    %3 = "linalg.map"(%2) ({
    ^bb0(%arg2: index):
      %4 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %5 = "memref.dim"(%0, %4) : (memref<*xf32>, index) -> index
      "linalg.yield"(%5) : (index) -> ()
    }) : (tensor<?xindex>) -> tensor<?xindex>
    "func.return"(%3) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<16x?xindex>, sym_name = "tensor.generate_static_and_dynamic"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<16x?xindex>
    %1 = "bufferization.to_tensor"(%0) : (memref<16x?xindex>) -> tensor<16x?xindex>
    %2 = "linalg.map"(%1) ({
    ^bb0(%arg1: index):
      %3 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %4 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "linalg.yield"(%5) : (index) -> ()
    }) : (tensor<16x?xindex>) -> tensor<16x?xindex>
    "func.return"(%2) : (tensor<16x?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<?xindex>, sym_name = "tensor.generate_unknown_ops_in_body"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"(%arg0) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xindex>
    %1 = "bufferization.to_tensor"(%0) : (memref<?xindex>) -> tensor<?xindex>
    %2 = "linalg.map"(%1) ({
    ^bb0(%arg1: index):
      %3 = "test.source"() : () -> index
      "linalg.yield"(%3) : (index) -> ()
    }) : (tensor<?xindex>) -> tensor<?xindex>
    "func.return"(%2) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index) -> tensor<?x10xf32>, sym_name = "tensor.extract_slice"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %1 = "memref.subview"(%0, %arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 5, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 10>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<?x10xf32, strided<[?, 1], offset: ?>>
    %2 = "bufferization.to_tensor"(%1) : (memref<?x10xf32, strided<[?, 1], offset: ?>>) -> tensor<?x10xf32>
    "func.return"(%2) : (tensor<?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10x?xf32>, index, index) -> tensor<?x15xf32>, sym_name = "tensor.extract_slice_rank_reducing"}> ({
  ^bb0(%arg0: tensor<?x10x?xf32>, %arg1: index, %arg2: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x10x?xf32>) -> memref<?x10x?xf32>
    %1 = "memref.subview"(%0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 5, -9223372036854775808, 10>, static_sizes = array<i64: -9223372036854775808, 1, 15>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x10x?xf32>, index, index) -> memref<?x15xf32, strided<[?, 1], offset: ?>>
    %2 = "bufferization.to_tensor"(%1) : (memref<?x15xf32, strided<[?, 1], offset: ?>>) -> tensor<?x15xf32>
    "func.return"(%2) : (tensor<?x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x10xf32>, index, index) -> tensor<?x?xf32>, sym_name = "tensor.insert_slice"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x10xf32>, %arg2: index, %arg3: index):
    %0 = "bufferization.to_buffer"(%arg1) : (tensor<?x10xf32>) -> memref<?x10xf32>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%1, %4) : (memref<?x?xf32>, index) -> index
    %6 = "memref.alloc"(%3, %5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%1, %6) : (memref<?x?xf32>, memref<?x?xf32>) -> ()
    %7 = "memref.subview"(%6, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 5>, static_sizes = array<i64: -9223372036854775808, 10>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<?x10xf32, strided<[?, 1], offset: ?>>
    "memref.copy"(%0, %7) : (memref<?x10xf32>, memref<?x10xf32, strided<[?, 1], offset: ?>>) -> ()
    %8 = "bufferization.to_tensor"(%6) : (memref<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%8) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<f32>, index, index) -> tensor<?x?xf32>, sym_name = "tensor.insert_slice_rank_reducing_1"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<f32>, %arg2: index, %arg3: index):
    %0 = "bufferization.to_buffer"(%arg1) : (tensor<f32>) -> memref<f32>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%1, %4) : (memref<?x?xf32>, index) -> index
    %6 = "memref.alloc"(%3, %5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%1, %6) : (memref<?x?xf32>, memref<?x?xf32>) -> ()
    %7 = "memref.subview"(%6, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<f32, strided<[], offset: ?>>
    "memref.copy"(%0, %7) : (memref<f32>, memref<f32, strided<[], offset: ?>>) -> ()
    %8 = "bufferization.to_tensor"(%6) : (memref<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%8) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?x?x?x?xf32>, tensor<2x1x4x1x1xf32>, index) -> tensor<?x?x?x?x?x?x?xf32>, sym_name = "tensor.insert_slice_rank_reducing_2"}> ({
  ^bb0(%arg0: tensor<?x?x?x?x?x?x?xf32>, %arg1: tensor<2x1x4x1x1xf32>, %arg2: index):
    %0 = "bufferization.to_buffer"(%arg1) : (tensor<2x1x4x1x1xf32>) -> memref<2x1x4x1x1xf32>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<?x?x?x?x?x?x?xf32>) -> memref<?x?x?x?x?x?x?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?x?x?x?x?x?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%1, %4) : (memref<?x?x?x?x?x?x?xf32>, index) -> index
    %6 = "arith.constant"() <{value = 2 : index}> : () -> index
    %7 = "memref.dim"(%1, %6) : (memref<?x?x?x?x?x?x?xf32>, index) -> index
    %8 = "arith.constant"() <{value = 3 : index}> : () -> index
    %9 = "memref.dim"(%1, %8) : (memref<?x?x?x?x?x?x?xf32>, index) -> index
    %10 = "arith.constant"() <{value = 4 : index}> : () -> index
    %11 = "memref.dim"(%1, %10) : (memref<?x?x?x?x?x?x?xf32>, index) -> index
    %12 = "arith.constant"() <{value = 5 : index}> : () -> index
    %13 = "memref.dim"(%1, %12) : (memref<?x?x?x?x?x?x?xf32>, index) -> index
    %14 = "arith.constant"() <{value = 6 : index}> : () -> index
    %15 = "memref.dim"(%1, %14) : (memref<?x?x?x?x?x?x?xf32>, index) -> index
    %16 = "memref.alloc"(%3, %5, %7, %9, %11, %13, %15) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 7, 0>}> : (index, index, index, index, index, index, index) -> memref<?x?x?x?x?x?x?xf32>
    "memref.copy"(%1, %16) : (memref<?x?x?x?x?x?x?xf32>, memref<?x?x?x?x?x?x?xf32>) -> ()
    %17 = "memref.subview"(%16, %arg2, %arg2, %arg2, %arg2, %arg2, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 7, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 1, 4, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1, 1, 1, 1>}> : (memref<?x?x?x?x?x?x?xf32>, index, index, index, index, index, index, index) -> memref<2x1x4x1x1xf32, strided<[?, ?, ?, ?, ?], offset: ?>>
    "memref.copy"(%0, %17) : (memref<2x1x4x1x1xf32>, memref<2x1x4x1x1xf32, strided<[?, ?, ?, ?, ?], offset: ?>>) -> ()
    %18 = "bufferization.to_tensor"(%16) : (memref<?x?x?x?x?x?x?xf32>) -> tensor<?x?x?x?x?x?x?xf32>
    "func.return"(%18) : (tensor<?x?x?x?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, index, f32) -> tensor<5xf32>, sym_name = "tensor.insert"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: index, %arg2: f32):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<5xf32>) -> memref<5xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%0, %1) : (memref<5xf32>, memref<5xf32>) -> ()
    "memref.store"(%arg2, %1, %arg1) <{nontemporal = false}> : (f32, memref<5xf32>, index) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<5xf32>) -> tensor<5xf32>
    "func.return"(%2) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>, index) -> tensor<2x?x10xf32>, sym_name = "tensor.expand_shape"}> ({
  ^bb0(%arg0: tensor<?x10xf32>, %arg1: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x10xf32>) -> memref<?x10xf32>
    %1 = "memref.expand_shape"(%0, %arg1) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 2, -9223372036854775808, 10>}> : (memref<?x10xf32>, index) -> memref<2x?x10xf32>
    %2 = "bufferization.to_tensor"(%1) : (memref<2x?x10xf32>) -> tensor<2x?x10xf32>
    "func.return"(%2) : (tensor<2x?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x20xf32>, index, index, index) -> tensor<?x7x2x5xf32>, sym_name = "tensor.expand_shape_of_slice"}> ({
  ^bb0(%arg0: tensor<?x20xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x20xf32>) -> memref<?x20xf32>
    %1 = "memref.subview"(%0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 5>, static_sizes = array<i64: -9223372036854775808, 10>, static_strides = array<i64: 1, 1>}> : (memref<?x20xf32>, index, index) -> memref<?x10xf32, strided<[20, 1], offset: ?>>
    %2 = "memref.expand_shape"(%1, %arg3) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: -9223372036854775808, 7, 2, 5>}> : (memref<?x10xf32, strided<[20, 1], offset: ?>>, index) -> memref<?x7x2x5xf32, strided<[140, 20, 5, 1], offset: ?>>
    %3 = "bufferization.to_tensor"(%2) : (memref<?x7x2x5xf32, strided<[140, 20, 5, 1], offset: ?>>) -> tensor<?x7x2x5xf32>
    "func.return"(%3) : (tensor<?x7x2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> tensor<1xf32>, sym_name = "tensor.expand_shape_of_scalar_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "memref.subview"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<f32, strided<[], offset: ?>>
    %2 = "memref.expand_shape"(%1) <{reassociation = [], static_output_shape = array<i64: 1>}> : (memref<f32, strided<[], offset: ?>>) -> memref<1xf32, strided<[1], offset: ?>>
    %3 = "bufferization.to_tensor"(%2) : (memref<1xf32, strided<[1], offset: ?>>) -> tensor<1xf32>
    "func.return"(%3) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x256xf32>, index, index, index) -> tensor<?x?x?x256xf32>, sym_name = "tensor.expand_shape_multiple_dynamic_indices"}> ({
  ^bb0(%arg0: tensor<?x256xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x256xf32>) -> memref<?x256xf32>
    %1 = "memref.expand_shape"(%0, %arg1, %arg2, %arg3) <{reassociation = [[0, 1, 2], [3]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 256>}> : (memref<?x256xf32>, index, index, index) -> memref<?x?x?x256xf32>
    %2 = "bufferization.to_tensor"(%1) : (memref<?x?x?x256xf32>) -> tensor<?x?x?x256xf32>
    "func.return"(%2) : (tensor<?x?x?x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?x?xf32>) -> tensor<?x?xf32>, sym_name = "tensor.collapse_shape"}> ({
  ^bb0(%arg0: tensor<2x?x?xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<2x?x?xf32>) -> memref<2x?x?xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (memref<2x?x?xf32>) -> memref<?x?xf32>
    %2 = "bufferization.to_tensor"(%1) : (memref<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x1xf32>) -> tensor<f32>, sym_name = "tensor.collapse_shape_to_scalar"}> ({
  ^bb0(%arg0: tensor<1x1x1xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<1x1x1xf32>) -> memref<1x1x1xf32>
    %1 = "memref.collapse_shape"(%0) <{reassociation = []}> : (memref<1x1x1xf32>) -> memref<f32>
    %2 = "bufferization.to_tensor"(%1) : (memref<f32>) -> tensor<f32>
    "func.return"(%2) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi32>) -> tensor<i32>, sym_name = "tensor.collapse_shape_of_slice"}> ({
  ^bb0(%arg0: tensor<2xi32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<2xi32>) -> memref<2xi32>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<2xi32>) -> memref<1xi32, strided<[1], offset: 1>>
    %2 = "memref.collapse_shape"(%1) <{reassociation = []}> : (memref<1xi32, strided<[1], offset: 1>>) -> memref<i32, strided<[], offset: 1>>
    %3 = "bufferization.to_tensor"(%2) : (memref<i32, strided<[], offset: 1>>) -> tensor<i32>
    "func.return"(%3) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xi64>, index, index, index, index) -> tensor<87x63648xi64>, sym_name = "tensor.collapse_shape_of_slice2"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xi64>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x?x?x?xi64>) -> memref<?x?x?x?xi64>
    %1 = "memref.subview"(%0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 87, 78, 68, 12>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<?x?x?x?xi64>, index, index, index, index) -> memref<87x78x68x12xi64, strided<[?, ?, ?, 1], offset: ?>>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<87x78x68x12xi64>
    "memref.copy"(%1, %2) : (memref<87x78x68x12xi64, strided<[?, ?, ?, 1], offset: ?>>, memref<87x78x68x12xi64>) -> ()
    %3 = "memref.collapse_shape"(%2) <{reassociation = [[0], [1, 2, 3]]}> : (memref<87x78x68x12xi64>) -> memref<87x63648xi64>
    %4 = "bufferization.to_tensor"(%3) : (memref<87x63648xi64>) -> tensor<87x63648xi64>
    "func.return"(%4) : (tensor<87x63648xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<1xf32>, sym_name = "tensor.collapse_shape_of_slice3"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<1x2xf32>) -> memref<1x2xf32>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<1x2xf32>) -> memref<1x1xf32, strided<[2, 1]>>
    %2 = "memref.collapse_shape"(%1) <{reassociation = [[0, 1]]}> : (memref<1x1xf32, strided<[2, 1]>>) -> memref<1xf32, strided<[2]>>
    %3 = "bufferization.to_tensor"(%2) : (memref<1xf32, strided<[2]>>) -> tensor<1xf32>
    "func.return"(%3) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2x4xf32>, index, index) -> tensor<8xf32>, sym_name = "tensor.collapse_shape_of_slice4"}> ({
  ^bb0(%arg0: tensor<?x2x4xf32>, %arg1: index, %arg2: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x2x4xf32>) -> memref<?x2x4xf32>
    %1 = "memref.subview"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: 4, 2, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x2x4xf32>, index) -> memref<4x2x1xf32, strided<[8, 4, 1], offset: ?>>
    %2 = "memref.collapse_shape"(%1) <{reassociation = [[0, 1, 2]]}> : (memref<4x2x1xf32, strided<[8, 4, 1], offset: ?>>) -> memref<8xf32, strided<[4], offset: ?>>
    %3 = "bufferization.to_tensor"(%2) : (memref<8xf32, strided<[4], offset: ?>>) -> tensor<8xf32>
    "func.return"(%3) : (tensor<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2x2xi64>) -> tensor<4xi64>, sym_name = "tensor.collapse_shape_of_slice5"}> ({
  ^bb0(%arg0: tensor<2x2x2xi64>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<2x2x2xi64>) -> memref<2x2x2xi64>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 2, 1, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<2x2x2xi64>) -> memref<2x1x2xi64, strided<[4, 2, 1]>>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x1x2xi64>
    "memref.copy"(%1, %2) : (memref<2x1x2xi64, strided<[4, 2, 1]>>, memref<2x1x2xi64>) -> ()
    %3 = "memref.collapse_shape"(%2) <{reassociation = [[0, 1, 2]]}> : (memref<2x1x2xi64>) -> memref<4xi64>
    %4 = "bufferization.to_tensor"(%3) : (memref<4xi64>) -> tensor<4xi64>
    "func.return"(%4) : (tensor<4xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>) -> tensor<2x2x5xf32>, sym_name = "tensor.reshape"}> ({
  ^bb0(%arg0: tensor<?x10xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x10xf32>) -> memref<?x10xf32>
    %1 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 5 : i64}> : () -> i64
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xi64>
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%1, %3, %4) <{nontemporal = false}> : (i64, memref<3xi64>, index) -> ()
    "memref.store"(%1, %3, %5) <{nontemporal = false}> : (i64, memref<3xi64>, index) -> ()
    "memref.store"(%2, %3, %6) <{nontemporal = false}> : (i64, memref<3xi64>, index) -> ()
    %7 = "memref.reshape"(%0, %3) : (memref<?x10xf32>, memref<3xi64>) -> memref<2x2x5xf32>
    %8 = "bufferization.to_tensor"(%7) : (memref<2x2x5xf32>) -> tensor<2x2x5xf32>
    "func.return"(%8) : (tensor<2x2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 + 5)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 + 10)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xindex>, index, index, index) -> tensor<?x?xindex>, sym_name = "tensor.pad"}> ({
  ^bb0(%arg0: tensor<?x10xindex>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x10xindex>) -> memref<?x10xindex>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%0, %1) : (memref<?x10xindex>, index) -> index
    %3 = "arith.constant"() <{value = 5 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%0, %4) : (memref<?x10xindex>, index) -> index
    %6 = "affine.apply"(%2, %arg2) <{map = #map}> : (index, index) -> index
    %7 = "affine.apply"(%arg1, %arg3) <{map = #map1}> : (index, index) -> index
    %8 = "memref.alloc"(%6, %7) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xindex>
    %9 = "bufferization.to_tensor"(%8) : (memref<?x?xindex>) -> tensor<?x?xindex>
    %10 = "linalg.map"(%9) ({
    ^bb0(%arg4: index):
      %14 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %15 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %16 = "arith.muli"(%14, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "linalg.yield"(%16) : (index) -> ()
    }) : (tensor<?x?xindex>) -> tensor<?x?xindex>
    %11 = "bufferization.to_buffer"(%10) : (tensor<?x?xindex>) -> memref<?x?xindex>
    %12 = "memref.subview"(%11, %arg1, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 5, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 10>, static_strides = array<i64: 1, 1>}> : (memref<?x?xindex>, index, index) -> memref<?x10xindex, strided<[?, 1], offset: ?>>
    "memref.copy"(%0, %12) : (memref<?x10xindex>, memref<?x10xindex, strided<[?, 1], offset: ?>>) -> ()
    %13 = "bufferization.to_tensor"(%11) : (memref<?x?xindex>) -> tensor<?x?xindex>
    "func.return"(%13) : (tensor<?x?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<10x2x4xf32>, sym_name = "tensor.splat"}> ({
  ^bb0(%arg0: f32):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10x2x4xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<10x2x4xf32>) -> tensor<10x2x4xf32>
    %2 = "linalg.map"(%1) ({
    ^bb0(%arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (tensor<10x2x4xf32>) -> tensor<10x2x4xf32>
    "func.return"(%2) : (tensor<10x2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!test.memref_element) -> tensor<10x2x4x!test.memref_element>, sym_name = "tensor.splat_other"}> ({
  ^bb0(%arg0: !test.memref_element):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10x2x4x!test.memref_element>
    %1 = "bufferization.to_tensor"(%0) : (memref<10x2x4x!test.memref_element>) -> tensor<10x2x4x!test.memref_element>
    %2 = "linalg.map"(%1) ({
    ^bb0(%arg1: !test.memref_element):
      "linalg.yield"(%arg0) : (!test.memref_element) -> ()
    }) : (tensor<10x2x4x!test.memref_element>) -> tensor<10x2x4x!test.memref_element>
    "func.return"(%2) : (tensor<10x2x4x!test.memref_element>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8xf32>) -> tensor<16xf32>, sym_name = "tensor.concat"}> ({
  ^bb0(%arg0: tensor<8xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<8xf32>) -> memref<8xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    %2 = "memref.subview"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 8>, static_strides = array<i64: 1>}> : (memref<16xf32>) -> memref<8xf32, strided<[1]>>
    "memref.copy"(%0, %2) : (memref<8xf32>, memref<8xf32, strided<[1]>>) -> ()
    %3 = "memref.subview"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 8>, static_sizes = array<i64: 8>, static_strides = array<i64: 1>}> : (memref<16xf32>) -> memref<8xf32, strided<[1], offset: 8>>
    "memref.copy"(%0, %3) : (memref<8xf32>, memref<8xf32, strided<[1], offset: 8>>) -> ()
    %4 = "bufferization.to_tensor"(%1) : (memref<16xf32>) -> tensor<16xf32>
    "func.return"(%4) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x4xf32>, tensor<8x5xf32>) -> tensor<8x9xf32>, sym_name = "tensor.concat_different_shapes"}> ({
  ^bb0(%arg0: tensor<8x4xf32>, %arg1: tensor<8x5xf32>):
    %0 = "bufferization.to_buffer"(%arg1) : (tensor<8x5xf32>) -> memref<8x5xf32>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<8x4xf32>) -> memref<8x4xf32>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x9xf32>
    %3 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 8, 4>, static_strides = array<i64: 1, 1>}> : (memref<8x9xf32>) -> memref<8x4xf32, strided<[9, 1]>>
    "memref.copy"(%1, %3) : (memref<8x4xf32>, memref<8x4xf32, strided<[9, 1]>>) -> ()
    %4 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 4>, static_sizes = array<i64: 8, 5>, static_strides = array<i64: 1, 1>}> : (memref<8x9xf32>) -> memref<8x5xf32, strided<[9, 1], offset: 4>>
    "memref.copy"(%0, %4) : (memref<8x5xf32>, memref<8x5xf32, strided<[9, 1], offset: 4>>) -> ()
    %5 = "bufferization.to_tensor"(%2) : (memref<8x9xf32>) -> tensor<8x9xf32>
    "func.return"(%5) : (tensor<8x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x?xf32>, tensor<8x?xf32>) -> tensor<8x?xf32>, sym_name = "tensor.concat_dynamic"}> ({
  ^bb0(%arg0: tensor<8x?xf32>, %arg1: tensor<8x?xf32>):
    %0 = "bufferization.to_buffer"(%arg1) : (tensor<8x?xf32>) -> memref<8x?xf32>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<8x?xf32>) -> memref<8x?xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<8x?xf32>, index) -> index
    %4 = "memref.dim"(%0, %2) : (memref<8x?xf32>, index) -> index
    %5 = "affine.apply"(%3, %4) <{map = #map}> : (index, index) -> index
    %6 = "memref.alloc"(%5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<8x?xf32>
    %7 = "memref.subview"(%6, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 8, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x?xf32>, index) -> memref<8x?xf32, strided<[?, 1]>>
    "memref.copy"(%1, %7) : (memref<8x?xf32>, memref<8x?xf32, strided<[?, 1]>>) -> ()
    %8 = "memref.subview"(%6, %3, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x?xf32>, index, index) -> memref<8x?xf32, strided<[?, 1], offset: ?>>
    "memref.copy"(%0, %8) : (memref<8x?xf32>, memref<8x?xf32, strided<[?, 1], offset: ?>>) -> ()
    %9 = "bufferization.to_tensor"(%6) : (memref<8x?xf32>) -> tensor<8x?xf32>
    "func.return"(%9) : (tensor<8x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "tensor.concat_dynamic_nonconcat_dim"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "bufferization.to_buffer"(%arg1) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%1, %4) : (memref<?x?xf32>, index) -> index
    %6 = "memref.dim"(%0, %4) : (memref<?x?xf32>, index) -> index
    %7 = "affine.apply"(%5, %6) <{map = #map}> : (index, index) -> index
    %8 = "memref.alloc"(%3, %7) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %9 = "memref.dim"(%8, %2) : (memref<?x?xf32>, index) -> index
    %10 = "memref.subview"(%8, %9, %5) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<?x?xf32, strided<[?, 1]>>
    "memref.copy"(%1, %10) : (memref<?x?xf32>, memref<?x?xf32, strided<[?, 1]>>) -> ()
    %11 = "memref.subview"(%8, %5, %9, %6) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
    "memref.copy"(%0, %11) : (memref<?x?xf32>, memref<?x?xf32, strided<[?, 1], offset: ?>>) -> ()
    %12 = "bufferization.to_tensor"(%8) : (memref<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%12) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x?xf32>, tensor<8x?xf32>, tensor<8x2xf32>) -> tensor<8x10xf32>, sym_name = "tensor.concat_mixed_dynamic_static"}> ({
  ^bb0(%arg0: tensor<8x?xf32>, %arg1: tensor<8x?xf32>, %arg2: tensor<8x2xf32>):
    %0 = "bufferization.to_buffer"(%arg2) : (tensor<8x2xf32>) -> memref<8x2xf32>
    %1 = "bufferization.to_buffer"(%arg1) : (tensor<8x?xf32>) -> memref<8x?xf32>
    %2 = "bufferization.to_buffer"(%arg0) : (tensor<8x?xf32>) -> memref<8x?xf32>
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x10xf32>
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%2, %4) : (memref<8x?xf32>, index) -> index
    %6 = "memref.subview"(%3, %5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 8, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x10xf32>, index) -> memref<8x?xf32, strided<[10, 1]>>
    "memref.copy"(%2, %6) : (memref<8x?xf32>, memref<8x?xf32, strided<[10, 1]>>) -> ()
    %7 = "memref.dim"(%1, %4) : (memref<8x?xf32>, index) -> index
    %8 = "memref.subview"(%3, %5, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x10xf32>, index, index) -> memref<8x?xf32, strided<[10, 1], offset: ?>>
    "memref.copy"(%1, %8) : (memref<8x?xf32>, memref<8x?xf32, strided<[10, 1], offset: ?>>) -> ()
    %9 = "affine.apply"(%5, %7) <{map = #map}> : (index, index) -> index
    %10 = "memref.subview"(%3, %9) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, 2>, static_strides = array<i64: 1, 1>}> : (memref<8x10xf32>, index) -> memref<8x2xf32, strided<[10, 1], offset: ?>>
    "memref.copy"(%0, %10) : (memref<8x2xf32>, memref<8x2xf32, strided<[10, 1], offset: ?>>) -> ()
    %11 = "bufferization.to_tensor"(%3) : (memref<8x10xf32>) -> tensor<8x10xf32>
    "func.return"(%11) : (tensor<8x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> tensor<?x3x?xf32>, sym_name = "tensor.splat_dynamic"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "memref.alloc"(%arg1, %arg2) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x3x?xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<?x3x?xf32>) -> tensor<?x3x?xf32>
    %2 = "linalg.map"(%1) ({
    ^bb0(%arg3: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (tensor<?x3x?xf32>) -> tensor<?x3x?xf32>
    "func.return"(%2) : (tensor<?x3x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<4xf32>) -> (), sym_name = "parallel_insert_slice_copy_before_write"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: tensor<4xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<4xf32>) -> memref<4xf32>
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "scf.forall"(%1, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<4xf32>):
      %3 = "bufferization.to_buffer"(%arg3) : (tensor<4xf32>) -> memref<4xf32>
      %4 = "memref.subview"(%0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<4xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
      %5 = "memref.subview"(%3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<4xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
      "memref.copy"(%4, %5) : (memref<1xf32, strided<[1], offset: ?>>, memref<1xf32, strided<[1], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index, tensor<4xf32>) -> tensor<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
^bb0:
}) : () -> ()

