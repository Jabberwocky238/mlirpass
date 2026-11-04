"builtin.module"() ({
  "func.func"() <{function_type = (memref<7x8xf32>) -> index, sym_name = "dim_out_of_bounds"}> ({
  ^bb0(%arg0: memref<7x8xf32>):
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<7x8xf32>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "dim_out_of_bounds_2"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "bufferization.alloc_tensor"(%1, %1) <{operandSegmentSizes = array<i32: 2, 0, 0>}> : (index, index) -> tensor<?x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x?xf32>, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x?x8xi8>) -> index, sym_name = "dynamic_dim_of_transpose_op"}> ({
  ^bb0(%arg0: tensor<1x2x?x8xi8>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 0, 3, 1, 2>}> : (tensor<1x2x?x8xi8>) -> tensor<1x8x2x?xi8>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "tensor.dim"(%0, %1) : (tensor<1x8x2x?xi8>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x100x?x8xi8>) -> index, sym_name = "static_dim_of_transpose_op"}> ({
  ^bb0(%arg0: tensor<1x100x?x8xi8>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 0, 3, 1, 2>}> : (tensor<1x100x?x8xi8>) -> tensor<1x8x100x?xi8>
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "tensor.dim"(%0, %1) : (tensor<1x8x100x?xi8>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x8xi32>) -> index, sym_name = "dim_of_memref_expand_shape"}> ({
  ^bb0(%arg0: memref<?x8xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %0) : (memref<?x8xi32>, index) -> index
    %3 = "memref.expand_shape"(%arg0, %2) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: 1, -9223372036854775808, 2, 4>}> : (memref<?x8xi32>, index) -> memref<1x?x2x4xi32>
    %4 = "memref.dim"(%3, %1) : (memref<1x?x2x4xi32>, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "iter_to_init_arg_loop_like"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %3 = "scf.forall"(%0, %2, %1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, staticLowerBound = array<i64: -9223372036854775808>, staticStep = array<i64: -9223372036854775808>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<?x?xf32>):
      %4 = "tensor.dim"(%arg3, %1) : (tensor<?x?xf32>, index) -> index
      %5 = "tensor.extract_slice"(%arg1, %arg2, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<1x?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%5, %arg3, %arg2, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<1x?xf32>, tensor<?x?xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, index, index, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%3) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x3xf32>) -> (index, index), sym_name = "dim_of_assume_alignment_static"}> ({
  ^bb0(%arg0: memref<2x3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.assume_alignment"(%arg0) <{alignment = 64 : i32}> : (memref<2x3xf32>) -> memref<2x3xf32>
    %3 = "memref.dim"(%2, %0) : (memref<2x3xf32>, index) -> index
    %4 = "memref.dim"(%2, %1) : (memref<2x3xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32>) -> (index, index), sym_name = "dim_of_assume_alignment_dynamic"}> ({
  ^bb0(%arg0: memref<4x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.assume_alignment"(%arg0) <{alignment = 64 : i32}> : (memref<4x?xf32>) -> memref<4x?xf32>
    %3 = "memref.dim"(%2, %0) : (memref<4x?xf32>, index) -> index
    %4 = "memref.dim"(%2, %1) : (memref<4x?xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

