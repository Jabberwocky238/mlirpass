"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> tensor<3xf32>, sym_name = "no_conflict"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "tensor.from_elements"(%arg0, %arg0, %arg0) : (f32, f32, f32) -> tensor<3xf32>
    %1 = "tensor.insert"(%arg1, %0, %arg2) : (f32, tensor<3xf32>, index) -> tensor<3xf32>
    "func.return"(%1) : (tensor<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> vector<4xf32>, sym_name = "use_tensor_func_arg"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, vector<4xf32>) -> tensor<?xf32>, sym_name = "return_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.transfer_write"(%arg1, %arg0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<10xf32>) -> (), sym_name = "func_without_tensor_args"}> ({
  ^bb0(%arg0: vector<10xf32>):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.transfer_write"(%arg0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<10xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%2, %1, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<10xf32>, index, f32) -> vector<11xf32>
    "vector.print"(%4) <{punctuation = #vector.punctuation<newline>}> : (vector<11xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "private_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "empty_func"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> (f32, f32), sym_name = "read_after_write_conflict"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "test.dummy_op"() : () -> tensor<10xf32>
    %1 = "tensor.insert"(%arg0, %0, %arg2) : (f32, tensor<10xf32>, index) -> tensor<10xf32>
    %2 = "test.some_use"(%0) : (tensor<10xf32>) -> f32
    %3 = "tensor.extract"(%1, %arg1) : (tensor<10xf32>, index) -> f32
    "func.return"(%2, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<10xf32>, sym_name = "copy_deallocated"}> ({
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    "func.return"(%0) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index, i1) -> f32, sym_name = "select_different_tensors"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "bufferization.alloc_tensor"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %1 = "arith.select"(%arg3, %0, %arg0) : (i1, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    %2 = "tensor.extract"(%1, %arg2) : (tensor<?xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "alloc_tensor_with_copy"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "bufferization.alloc_tensor"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0>}> : (tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "alloc_tensor_with_memory_space"}> ({
    %0 = "bufferization.alloc_tensor"() <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<100xf32>, index, index, index, index, index, f32) -> (f32, f32), sym_name = "read_of_alias"}> ({
  ^bb0(%arg0: tensor<100xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: f32):
    %0 = "tensor.insert"(%arg6, %arg0, %arg1) : (f32, tensor<100xf32>, index) -> tensor<100xf32>
    %1 = "tensor.extract_slice"(%arg0, %arg2, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<100xf32>, index, index) -> tensor<?xf32>
    %2 = "tensor.extract"(%1, %arg3) : (tensor<?xf32>, index) -> f32
    %3 = "tensor.extract"(%0, %arg3) : (tensor<100xf32>, index) -> f32
    "func.return"(%2, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xi32>) -> tensor<*xi32>, sym_name = "from_unranked_to_unranked"}> ({
  ^bb0(%arg0: tensor<*xi32>):
    %0 = "tensor.cast"(%arg0) : (tensor<*xi32>) -> tensor<*xi32>
    "func.return"(%0) : (tensor<*xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "tensor_copy"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "bufferization.materialize_in_destination"(%arg0, %0) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%1) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, memref<5xf32>) -> (), sym_name = "materialize_in_destination_buffer"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: memref<5xf32>):
    "bufferization.materialize_in_destination"(%arg0, %arg1) <{restrict, writable}> : (tensor<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "materialize_in_func_bbarg"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "bufferization.materialize_in_destination"(%arg0, %arg1) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> (tensor<5xf32>, f32), sym_name = "materialize_in_dest_raw"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %3 = "linalg.fill"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %4 = "bufferization.materialize_in_destination"(%3, %1) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    %5 = "tensor.extract"(%1, %arg2) : (tensor<5xf32>, index) -> f32
    "func.return"(%4, %5) : (tensor<5xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!test.test_tensor<[32, 64], f64>) -> !test.test_tensor<[32, 128], f64>, sym_name = "custom_op"}> ({
  ^bb0(%arg0: !test.test_tensor<[32, 64], f64>):
    %0 = "test.dummy_tensor_op"(%arg0) : (!test.test_tensor<[32, 64], f64>) -> !test.test_tensor<[32, 128], f64>
    "func.return"(%0) : (!test.test_tensor<[32, 128], f64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !test.test_tensor<[42], f64>, sym_name = "custom_origin_op"}> ({
    %0 = "test.create_tensor_op"() : () -> !test.test_tensor<[21], f64>
    %1 = "test.dummy_tensor_op"(%0) : (!test.test_tensor<[21], f64>) -> !test.test_tensor<[42], f64>
    "func.return"(%1) : (!test.test_tensor<[42], f64>) -> ()
  }) : () -> ()
}) : () -> ()

