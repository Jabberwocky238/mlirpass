"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}, {bufferization.writable = false}, {bufferization.writable = true}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, tensor<4xf32>) -> (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>, tensor<?xf32>), sym_name = "insert_slice_fun", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<4xf32>, %arg3: tensor<4xf32>):
    %0 = "tensor.insert_slice"(%arg2, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%arg3, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    %2 = "tensor.insert_slice"(%arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert_slice"(%arg3, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0, %1, %2, %3) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<4xf32>) -> tensor<?xf32>, sym_name = "insert_slice_fun"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<4xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.insert_slice"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<4xf32>) -> tensor<?xf32>, sym_name = "insert_slice_fun"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<4xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %2 = "tensor.insert_slice"(%arg1, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<4xf32>) -> tensor<?xf32>, sym_name = "insert_slice_fun_not_inplace"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<4xf32>):
    %0 = "tensor.insert_slice"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = false}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "tensor_cast_not_in_place"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: index):
    %0 = "tensor.cast"(%arg0) : (tensor<?xf32>) -> tensor<4xf32>
    %1 = "tensor.insert_slice"(%0, %arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}], function_type = (tensor<?xf32>, f32, index) -> tensor<?xf32>, sym_name = "insert_op"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: f32, %arg2: index):
    %0 = "tensor.insert"(%arg1, %arg0, %arg2) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 ceildiv 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, tensor<8x18x32xf32>) -> tensor<?x1x6x8xf32>, sym_name = "rank_reducing"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<8x18x32xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 6 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<4x1x6x8xf32>
    %6 = "tensor.cast"(%5) : (tensor<4x1x6x8xf32>) -> tensor<?x1x6x8xf32>
    %7 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1x6x8xf32>
    %8 = "scf.for"(%4, %3, %2, %6) ({
    ^bb0(%arg3: index, %arg4: tensor<?x1x6x8xf32>):
      %9 = "affine.apply"(%arg3) <{map = #map}> : (index) -> index
      %10 = "tensor.extract_slice"(%arg2, %arg0, %arg1, %arg3) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 6, 8>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x18x32xf32>, index, index, index) -> tensor<1x6x8xf32>
      %11 = "scf.for"(%4, %1, %0, %7) ({
      ^bb0(%arg5: index, %arg6: tensor<1x6x8xf32>):
        %13 = "tensor.extract_slice"(%10, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 8>, static_strides = array<i64: 1, 1, 1>}> : (tensor<1x6x8xf32>, index) -> tensor<1x1x8xf32>
        %14 = "tensor.insert_slice"(%13, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 8>, static_strides = array<i64: 1, 1, 1>}> : (tensor<1x1x8xf32>, tensor<1x6x8xf32>, index) -> tensor<1x6x8xf32>
        "scf.yield"(%14) : (tensor<1x6x8xf32>) -> ()
      }) : (index, index, index, tensor<1x6x8xf32>) -> tensor<1x6x8xf32>
      %12 = "tensor.insert_slice"(%11, %arg4, %9) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 1, 6, 8>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x6x8xf32>, tensor<?x1x6x8xf32>, index) -> tensor<?x1x6x8xf32>
      "scf.yield"(%12) : (tensor<?x1x6x8xf32>) -> ()
    }) : (index, index, index, tensor<?x1x6x8xf32>) -> tensor<?x1x6x8xf32>
    "func.return"(%8) : (tensor<?x1x6x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<100xf32>, tensor<200x100xf32>) -> (), sym_name = "rank_reducing_parallel_insert_slice"}> ({
  ^bb0(%arg0: tensor<100xf32>, %arg1: tensor<200x100xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 100 : index}> : () -> index
    %2 = "scf.forall"(%1, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<200x100xf32>):
      %3 = "tensor.extract_slice"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<100xf32>, index) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%3, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: 1, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<1xf32>, tensor<200x100xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<200x100xf32>) -> tensor<200x100xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>) -> tensor<2xf32>, sym_name = "parallel_insert_full_slice_in_place"}> ({
  ^bb0(%arg0: tensor<2xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "scf.forall"(%arg0) <{mapping = [#gpu.thread<linear_dim_0>], operandSegmentSizes = array<i32: 0, 0, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 1>}> ({
    ^bb0(%arg1: index, %arg2: tensor<2xf32>):
      %2 = "linalg.fill"(%0, %arg2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, tensor<2xf32>) -> tensor<2xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%2, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<2xf32>, tensor<2xf32>) -> ()
      }) : () -> ()
    }) : (tensor<2xf32>) -> tensor<2xf32>
    "func.return"(%1) : (tensor<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>) -> tensor<10xf32>, sym_name = "insert_equivalent_tensor"}> ({
  ^bb0(%arg0: tensor<10xf32>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    %2 = "tensor.insert_slice"(%1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%2) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, f32, index) -> f32, sym_name = "pad_memory_space"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: f32, %arg3: index):
    %0 = "bufferization.alloc_tensor"(%arg0) <{memory_space = 3 : i64, operandSegmentSizes = array<i32: 0, 1, 0>}> : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "tensor.pad"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: -9223372036854775808>, static_low = array<i64: 2>}> ({
    ^bb0(%arg4: index):
      "tensor.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?xf32>, index) -> tensor<15xf32>
    %2 = "tensor.extract"(%1, %arg3) : (tensor<15xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, tensor<5xf32>) -> tensor<10xf32>, sym_name = "insert_slice_regression"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: tensor<5xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    %3 = "vector.transfer_read"(%2, %1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<10xf32>, index, f32) -> vector<10xf32>
    "vector.print"(%3) <{punctuation = #vector.punctuation<newline>}> : (vector<10xf32>) -> ()
    %4 = "tensor.insert_slice"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%4) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "insert_slice_full_overwrite"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: tensor<10xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    %3 = "vector.transfer_read"(%2, %1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<10xf32>, index, f32) -> vector<10xf32>
    "vector.print"(%3) <{punctuation = #vector.punctuation<newline>}> : (vector<10xf32>) -> ()
    %4 = "tensor.insert_slice"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%4) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, f32, index) -> (tensor<?xf32>, index), sym_name = "dim_not_reading"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: f32, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.insert"(%arg1, %arg0, %arg2) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    "func.return"(%1, %2) : (tensor<?xf32>, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 + 5)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map}, {}], function_type = (tensor<?xf32>, index) -> (tensor<10xf32>, tensor<?xf32>), sym_name = "cast_retains_buffer_layout", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "tensor.cast"(%arg0) : (tensor<?xf32>) -> tensor<10xf32>
    %1 = "tensor.extract_slice"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<10xf32>, index) -> tensor<?xf32>
    "func.return"(%0, %1) : (tensor<10xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = strided<[1], offset: 5>}, {}], function_type = (tensor<?xf32>, index) -> (tensor<10xf32>, tensor<?xf32>), sym_name = "cast_retains_buffer_layout_strided", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "tensor.cast"(%arg0) : (tensor<?xf32>) -> tensor<10xf32>
    %1 = "tensor.extract_slice"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<10xf32>, index) -> tensor<?xf32>
    "func.return"(%0, %1) : (tensor<10xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<100xf32>, f32) -> (), sym_name = "parallel_insert_slice_source_out_of_place"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<100xf32>, %arg2: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 50 : index}> : () -> index
    %3 = "scf.forall"(%2, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg3: index, %arg4: tensor<100xf32>):
      %4 = "tensor.insert"(%arg2, %arg0, %0) : (f32, tensor<1xf32>, index) -> tensor<1xf32>
      %5 = "tensor.extract"(%arg0, %0) : (tensor<1xf32>, index) -> f32
      "vector.print"(%5) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg4, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<100xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<100xf32>) -> tensor<100xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2x2x5xf32>, sym_name = "tensor.reshape"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<2x10xf32>}> : () -> tensor<2x10xf32>
    %1 = "tensor.cast"(%0) : (tensor<2x10xf32>) -> tensor<?x10xf32>
    %2 = "arith.constant"() <{value = dense<[2, 2, 5]> : tensor<3xi64>}> : () -> tensor<3xi64>
    %3 = "tensor.reshape"(%1, %2) : (tensor<?x10xf32>, tensor<3xi64>) -> tensor<2x2x5xf32>
    "func.return"(%3) : (tensor<2x2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> tensor<?x?xf32>, sym_name = "tensor_reshape_aliasing"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<10xf32>}> : () -> tensor<10xf32>
    %1 = "tensor.cast"(%0) : (tensor<10xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<2xindex>
    %5 = "tensor.insert"(%arg0, %4, %2) : (index, tensor<2xindex>, index) -> tensor<2xindex>
    %6 = "tensor.insert"(%arg1, %5, %3) : (index, tensor<2xindex>, index) -> tensor<2xindex>
    %7 = "tensor.reshape"(%1, %6) : (tensor<?xf32>, tensor<2xindex>) -> tensor<?x?xf32>
    "func.return"(%7) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x2xf32, strided<[?, ?], offset: ?>, 3>, tensor<2xi32>, index) -> f32, sym_name = "reshape_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<2x2xf32, strided<[?, ?], offset: ?>, 3>, %arg1: tensor<2xi32>, %arg2: index):
    %0 = "bufferization.to_tensor"(%arg0) <{restrict}> : (memref<2x2xf32, strided<[?, ?], offset: ?>, 3>) -> tensor<2x2xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1, 0>, static_sizes = array<i64: 1, 2>, static_strides = array<i64: 1, 1>}> : (tensor<2x2xf32>) -> tensor<2xf32>
    %2 = "tensor.reshape"(%1, %arg1) : (tensor<2xf32>, tensor<2xi32>) -> tensor<1x2xf32>
    %3 = "tensor.extract"(%2, %arg2, %arg2) : (tensor<1x2xf32>, index, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x20xf32>, f32, index) -> (), sym_name = "collapse_shape_regression"}> ({
  ^bb0(%arg0: tensor<10x20xf32>, %arg1: f32, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2, 3>, static_sizes = array<i64: 5, 6>, static_strides = array<i64: 1, 1>}> : (tensor<10x20xf32>) -> tensor<5x6xf32>
    %1 = "tensor.insert"(%arg1, %0, %arg2, %arg2) : (f32, tensor<5x6xf32>, index, index) -> tensor<5x6xf32>
    %2 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1]]}> : (tensor<5x6xf32>) -> tensor<30xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, i1, index, index) -> (tensor<10xf32>, index), sym_name = "mult_return_callee", sym_visibility = "private"}> ({
  ^bb0(%arg4: tensor<?xf32>, %arg5: i1, %arg6: index, %arg7: index):
    %1 = "tensor.cast"(%arg4) : (tensor<?xf32>) -> tensor<10xf32>
    "cf.cond_br"(%arg5)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%1, %arg6) : (tensor<10xf32>, index) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%1, %arg7) : (tensor<10xf32>, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, i1, index, index) -> (tensor<10xf32>, index), sym_name = "mult_return"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: i1, %arg2: index, %arg3: index):
    %0:2 = "func.call"(%arg0, %arg1, %arg2, %arg3) <{callee = @mult_return_callee}> : (tensor<?xf32>, i1, index, index) -> (tensor<10xf32>, index)
    "func.return"(%0#0, %0#1) : (tensor<10xf32>, index) -> ()
  }) : () -> ()
}) : () -> ()

