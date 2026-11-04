#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> vector<5xf32>, sym_name = "use_of_unknown_op_1"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "bufferization.to_buffer"(%0) : (tensor<?xf32>) -> memref<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%1, %2, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%4) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "use_of_unknown_op_2"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "test.another_dummy_op"(%0) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (vector<5xf32>, vector<5xf32>), sym_name = "use_of_unknown_op_3"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%0, %1, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<5xf32>
    %4 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %5 = "bufferization.to_buffer"(%4) : (tensor<?xf32>) -> memref<?xf32>
    %6 = "vector.transfer_read"(%5, %1, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%3, %6) : (vector<5xf32>, vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (vector<5xf32>, tensor<?xf32>), sym_name = "use_of_unknown_op_4"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %3 = "bufferization.to_buffer"(%2) : (tensor<?xf32>) -> memref<?xf32>
    %4 = "vector.transfer_read"(%3, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<5xf32>
    %5 = "test.another_dummy_op"(%2) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%4, %5) : (vector<5xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "use_of_bufferizable_op_in_unbufferizable_op"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "memref.subview"(%0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?xf32, strided<[1], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%1, %4) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32>) -> ()
    %5 = "bufferization.to_tensor"(%4) : (memref<?xf32>) -> tensor<?xf32>
    %6 = "test.dummy_op"(%5) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%5, %6) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> vector<5xf32>, sym_name = "unused_unknown_op"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%0, %1, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<5xf32>
    "test.dummy_op"(%arg0) : (tensor<?xf32>) -> ()
    "func.return"(%3) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xf32>) -> (tensor<10xf32>, tensor<10xf32>), sym_name = "unknown_op_may_read"}> ({
  ^bb0(%arg0: vector<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<10xf32>) -> ()
    %3 = "bufferization.to_tensor"(%2) : (memref<10xf32>) -> tensor<10xf32>
    %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "memref.copy"(%2, %4) : (memref<10xf32>, memref<10xf32>) -> ()
    "vector.transfer_write"(%arg0, %4, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, memref<10xf32>, index) -> ()
    %5 = "bufferization.to_tensor"(%4) : (memref<10xf32>) -> tensor<10xf32>
    %6 = "test.dummy_op"(%3) : (tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%5, %6) : (tensor<10xf32>, tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, vector<5xf32>, index) -> tensor<?xf32>, sym_name = "unknown_op_not_writable"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index):
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "bufferization.to_buffer"(%0) : (tensor<?xf32>) -> memref<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?xf32>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%1, %4) : (memref<?xf32>, memref<?xf32>) -> ()
    "vector.transfer_write"(%arg1, %4, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?xf32>, index) -> ()
    %5 = "bufferization.to_tensor"(%4) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%5) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, f32) -> tensor<?xf32>, sym_name = "simple_tensor_test"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: f32):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%0, %2) : (memref<?xf32>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%0, %4) : (memref<?xf32>, memref<?xf32>) -> ()
    "memref.store"(%arg1, %4, %1) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
    %5 = "bufferization.to_tensor"(%4) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%5) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, i1, index, f32) -> (tensor<?xf32>, index), sym_name = "simple_scf_if"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: i1, %arg2: index, %arg3: f32):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %2:2 = "scf.if"(%arg1) ({
      "scf.yield"(%1, %arg2) : (memref<?xf32>, index) -> ()
    }, {
      %4 = "arith.constant"() <{value = 0 : index}> : () -> index
      %5 = "memref.dim"(%0, %4) : (memref<?xf32>, index) -> index
      %6 = "memref.alloc"(%5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      "memref.copy"(%0, %6) : (memref<?xf32>, memref<?xf32>) -> ()
      "memref.store"(%arg3, %6, %arg2) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
      "scf.yield"(%6, %arg2) : (memref<?xf32>, index) -> ()
    }) : (i1) -> (memref<?xf32>, index)
    %3 = "bufferization.to_tensor"(%2#0) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%3, %2#1) : (tensor<?xf32>, index) -> ()
  }) : () -> ()
}) : () -> ()

