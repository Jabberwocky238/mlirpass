"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> tensor<3xf32>, sym_name = "no_conflict"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%arg0, %0, %1) <{nontemporal = false}> : (f32, memref<3xf32>, index) -> ()
    "memref.store"(%arg0, %0, %2) <{nontemporal = false}> : (f32, memref<3xf32>, index) -> ()
    "memref.store"(%arg0, %0, %3) <{nontemporal = false}> : (f32, memref<3xf32>, index) -> ()
    %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf32>
    "memref.copy"(%0, %4) : (memref<3xf32>, memref<3xf32>) -> ()
    "memref.store"(%arg1, %4, %arg2) <{nontemporal = false}> : (f32, memref<3xf32>, index) -> ()
    %5 = "bufferization.to_tensor"(%4) : (memref<3xf32>) -> tensor<3xf32>
    "func.return"(%5) : (tensor<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> vector<4xf32>, sym_name = "use_tensor_func_arg"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%0, %1, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32, strided<[?], offset: ?>>, index, f32) -> vector<4xf32>
    "func.return"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, vector<4xf32>) -> tensor<?xf32>, sym_name = "return_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<4xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%0, %2) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%0, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "vector.transfer_write"(%arg1, %4, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?xf32>, index) -> ()
    %5 = "bufferization.to_tensor"(%4) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%5) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<10xf32>) -> (), sym_name = "func_without_tensor_args"}> ({
  ^bb0(%arg0: vector<10xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "vector.transfer_write"(%arg0, %1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<10xf32>, memref<10xf32>, index) -> ()
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%1, %0, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<10xf32>, index, f32) -> vector<11xf32>
    "vector.print"(%3) <{punctuation = #vector.punctuation<newline>}> : (vector<11xf32>) -> ()
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
    %1 = "bufferization.to_buffer"(%0) : (tensor<10xf32>) -> memref<10xf32, strided<[?], offset: ?>>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "memref.copy"(%1, %2) : (memref<10xf32, strided<[?], offset: ?>>, memref<10xf32>) -> ()
    "memref.store"(%arg0, %2, %arg2) <{nontemporal = false}> : (f32, memref<10xf32>, index) -> ()
    %3 = "test.some_use"(%0) : (tensor<10xf32>) -> f32
    %4 = "memref.load"(%2, %arg1) <{nontemporal = false}> : (memref<10xf32>, index) -> f32
    "func.return"(%3, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<10xf32>, sym_name = "copy_deallocated"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<10xf32>) -> tensor<10xf32>
    "func.return"(%1) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index, i1) -> f32, sym_name = "select_different_tensors"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "memref.alloc"(%arg1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %2 = "memref.cast"(%1) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %3 = "arith.select"(%arg3, %2, %0) : (i1, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    %4 = "memref.load"(%3, %arg2) <{nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "alloc_tensor_with_copy"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%0, %1) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<5xf32>) -> tensor<5xf32>
    "func.return"(%2) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "alloc_tensor_with_memory_space"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32, 1>
    %1 = "bufferization.to_tensor"(%0) : (memref<5xf32, 1>) -> tensor<5xf32>
    "func.return"(%1) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<100xf32>, index, index, index, index, index, f32) -> (f32, f32), sym_name = "read_of_alias"}> ({
  ^bb0(%arg0: tensor<100xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: f32):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<100xf32>) -> memref<100xf32, strided<[?], offset: ?>>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<100xf32>) -> memref<100xf32, strided<[?], offset: ?>>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    "memref.copy"(%1, %2) : (memref<100xf32, strided<[?], offset: ?>>, memref<100xf32>) -> ()
    "memref.store"(%arg6, %2, %arg1) <{nontemporal = false}> : (f32, memref<100xf32>, index) -> ()
    %3 = "memref.subview"(%0, %arg2, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<100xf32, strided<[?], offset: ?>>, index, index) -> memref<?xf32, strided<[?], offset: ?>>
    %4 = "memref.load"(%3, %arg3) <{nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    %5 = "memref.load"(%2, %arg3) <{nontemporal = false}> : (memref<100xf32>, index) -> f32
    "func.return"(%4, %5) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xi32>) -> tensor<*xi32>, sym_name = "from_unranked_to_unranked"}> ({
  ^bb0(%arg0: tensor<*xi32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<*xi32>) -> memref<*xi32>
    %1 = "bufferization.to_tensor"(%0) : (memref<*xi32>) -> tensor<*xi32>
    "func.return"(%1) : (tensor<*xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "tensor_copy"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%0, %1) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<5xf32>) -> tensor<5xf32>
    "func.return"(%2) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, memref<5xf32>) -> (), sym_name = "materialize_in_destination_buffer"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: memref<5xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    "memref.copy"(%0, %arg1) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "materialize_in_func_bbarg"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "bufferization.to_buffer"(%arg1) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%0, %4) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %5 = "bufferization.to_tensor"(%4) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%5) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> (tensor<5xf32>, f32), sym_name = "materialize_in_dest_raw"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, memref<5xf32>) -> ()
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "linalg.fill"(%arg1, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, memref<5xf32>) -> ()
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%1, %2) : (memref<5xf32>, memref<5xf32>) -> ()
    %3 = "bufferization.to_tensor"(%2) : (memref<5xf32>) -> tensor<5xf32>
    %4 = "memref.load"(%0, %arg2) <{nontemporal = false}> : (memref<5xf32>, index) -> f32
    "func.return"(%3, %4) : (tensor<5xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!test.test_tensor<[32, 64], f64>) -> !test.test_tensor<[32, 128], f64>, sym_name = "custom_op"}> ({
  ^bb0(%arg0: !test.test_tensor<[32, 64], f64>):
    %0 = "bufferization.to_buffer"(%arg0) : (!test.test_tensor<[32, 64], f64>) -> !test.test_memref<[32, 64], f64>
    %1 = "test.dummy_memref_op"(%0) : (!test.test_memref<[32, 64], f64>) -> !test.test_memref<[32, 128], f64>
    %2 = "bufferization.to_tensor"(%1) : (!test.test_memref<[32, 128], f64>) -> !test.test_tensor<[32, 128], f64>
    "func.return"(%2) : (!test.test_tensor<[32, 128], f64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !test.test_tensor<[42], f64>, sym_name = "custom_origin_op"}> ({
    %0 = "test.create_memref_op"() : () -> !test.test_memref<[21], f64>
    %1 = "test.dummy_memref_op"(%0) : (!test.test_memref<[21], f64>) -> !test.test_memref<[42], f64>
    %2 = "bufferization.to_tensor"(%1) : (!test.test_memref<[42], f64>) -> !test.test_tensor<[42], f64>
    "func.return"(%2) : (!test.test_tensor<[42], f64>) -> ()
  }) : () -> ()
}) : () -> ()

