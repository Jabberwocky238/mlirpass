#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> vector<5xf32>, sym_name = "use_of_unknown_op_1"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%0, %1, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%3) : (vector<5xf32>) -> ()
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
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    %3 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %4 = "vector.transfer_read"(%3, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%2, %4) : (vector<5xf32>, vector<5xf32>) -> ()
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
    %3 = "vector.transfer_read"(%2, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    %4 = "test.another_dummy_op"(%2) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3, %4) : (vector<5xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "use_of_bufferizable_op_in_unbufferizable_op"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
    %1 = "test.dummy_op"(%0) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0, %1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> vector<5xf32>, sym_name = "unused_unknown_op"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    "test.dummy_op"(%arg0) : (tensor<?xf32>) -> ()
    "func.return"(%2) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xf32>) -> (tensor<10xf32>, tensor<10xf32>), sym_name = "unknown_op_may_read"}> ({
  ^bb0(%arg0: vector<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %2 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    %4 = "vector.transfer_write"(%arg0, %3, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    %5 = "test.dummy_op"(%3) : (tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%4, %5) : (tensor<10xf32>, tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, vector<5xf32>, index) -> tensor<?xf32>, sym_name = "unknown_op_not_writable"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index):
    %0 = "test.dummy_op"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "vector.transfer_write"(%arg1, %0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, f32) -> tensor<?xf32>, sym_name = "simple_tensor_test"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.insert"(%arg1, %arg0, %0) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, i1, index, f32) -> (tensor<?xf32>, index), sym_name = "simple_scf_if"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: i1, %arg2: index, %arg3: f32):
    %0:2 = "scf.if"(%arg1) ({
      "scf.yield"(%arg0, %arg2) : (tensor<?xf32>, index) -> ()
    }, {
      %1 = "tensor.insert"(%arg3, %arg0, %arg2) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%1, %arg2) : (tensor<?xf32>, index) -> ()
    }) : (i1) -> (tensor<?xf32>, index)
    "func.return"(%0#0, %0#1) : (tensor<?xf32>, index) -> ()
  }) : () -> ()
}) : () -> ()

