"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, index, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "scf_for_yield_only"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "scf.for"(%arg2, %arg3, %arg4, %arg0) ({
    ^bb0(%arg7: index, %arg8: tensor<?xf32>):
      "scf.yield"(%arg8) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    %1 = "scf.for"(%arg2, %arg3, %arg4, %arg1) ({
    ^bb0(%arg5: index, %arg6: tensor<?xf32>):
      "scf.yield"(%arg6) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0, %1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}, {bufferization.writable = false}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, index, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "scf_for_with_tensor.insert_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<4xf32>, %arg3: index, %arg4: index, %arg5: index):
    %0:2 = "scf.for"(%arg3, %arg4, %arg5, %arg0, %arg1) ({
    ^bb0(%arg6: index, %arg7: tensor<?xf32>, %arg8: tensor<?xf32>):
      %1 = "tensor.insert_slice"(%arg2, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      %2 = "tensor.insert_slice"(%arg2, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%1, %2) : (tensor<?xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    "func.return"(%0#0, %0#1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "some_use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, index, index, index) -> tensor<?xf32>, sym_name = "scf_for_deps"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "scf.for"(%arg2, %arg3, %arg4, %arg0) ({
    ^bb0(%arg7: index, %arg8: tensor<?xf32>):
      "func.call"(%arg8) <{callee = @some_use}> : (tensor<?xf32>) -> ()
      "scf.yield"(%arg8) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    %1 = "scf.for"(%arg2, %arg3, %arg4, %arg0) ({
    ^bb0(%arg5: index, %arg6: tensor<?xf32>):
      "func.call"(%arg6) <{callee = @some_use}> : (tensor<?xf32>) -> ()
      "scf.yield"(%arg6) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}], function_type = (tensor<?xf32>, index, vector<5xf32>) -> (tensor<?xf32>, vector<5xf32>), sym_name = "reading_scf_for"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: vector<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_write"(%arg2, %arg0, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %4:2 = "scf.for"(%0, %arg1, %1, %arg0, %arg2) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>, %arg6: vector<5xf32>):
      %6 = "tensor.extract_slice"(%arg5, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %7 = "vector.transfer_read"(%6, %arg1, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
      "scf.yield"(%arg5, %7) : (tensor<?xf32>, vector<5xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, vector<5xf32>) -> (tensor<?xf32>, vector<5xf32>)
    %5 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg3: f32):
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%5, %4#1) : (tensor<?xf32>, vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}], function_type = (tensor<?xf32>, index, vector<5xf32>) -> (tensor<?xf32>, vector<5xf32>), sym_name = "non_reading_scf_for"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: vector<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_write"(%arg2, %arg0, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %5:2 = "scf.for"(%0, %2, %1, %arg0, %arg2) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>, %arg6: vector<5xf32>):
      %7 = "linalg.generic"(%arg5) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg7: f32):
        "linalg.yield"(%3) : (f32) -> ()
      }) : (tensor<?xf32>) -> tensor<?xf32>
      %8 = "vector.transfer_read"(%7, %arg1, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
      "scf.yield"(%7, %8) : (tensor<?xf32>, vector<5xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, vector<5xf32>) -> (tensor<?xf32>, vector<5xf32>)
    %6 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg3: f32):
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%6, %5#1) : (tensor<?xf32>, vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, i1) -> tensor<?xf32>, sym_name = "scf_if_inplace1"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: i1):
    %0 = "scf.if"(%arg2) ({
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, index, i1) -> tensor<?xf32>, sym_name = "scf_if_inplace2"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index, %arg3: i1):
    %0 = "scf.if"(%arg3) ({
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }, {
      %1 = "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, vector<5xf32>, index, i1) -> tensor<?xf32>, sym_name = "scf_if_inplace3"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: vector<5xf32>, %arg3: index, %arg4: i1):
    %0 = "tensor.extract_slice"(%arg0, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
    %1 = "scf.if"(%arg4) ({
      %3 = "vector.transfer_write"(%arg1, %0, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%3) : (tensor<?xf32>) -> ()
    }, {
      %2 = "vector.transfer_write"(%arg2, %arg0, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, index, i1, i1) -> (tensor<?xf32>, vector<10xf32>), sym_name = "scf_if_in_place4"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index, %arg3: i1, %arg4: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "scf.if"(%arg3) ({
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }, {
      %4 = "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%4) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %2 = "scf.if"(%arg4) ({
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %3 = "vector.transfer_read"(%2, %arg2, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<10xf32>
    "func.return"(%2, %3) : (tensor<?xf32>, vector<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}], function_type = (tensor<?xf32>, index, i1) -> tensor<?xf32>, sym_name = "scf_if_inplace5"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: i1):
    %0 = "scf.if"(%arg2) ({
      %3 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%3) : (tensor<?xf32>) -> ()
    }, {
      %2 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%0, %arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, vector<5xf32>, vector<5xf32>, index, i1, i1) -> tensor<?xf32>, sym_name = "scf_if_inplace6"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: vector<5xf32>, %arg3: vector<5xf32>, %arg4: index, %arg5: i1, %arg6: i1):
    %0 = "scf.if"(%arg5) ({
      %2 = "scf.if"(%arg6) ({
        %4 = "vector.transfer_write"(%arg1, %arg0, %arg4) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
        "scf.yield"(%4) : (tensor<?xf32>) -> ()
      }, {
        %3 = "vector.transfer_write"(%arg3, %arg0, %arg4) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
        "scf.yield"(%3) : (tensor<?xf32>) -> ()
      }) : (i1) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }, {
      %1 = "vector.transfer_write"(%arg2, %arg0, %arg4) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, vector<5xf32>, index, index, i1) -> (tensor<?xf32>, vector<5xf32>), sym_name = "scf_if_inplace7"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: vector<5xf32>, %arg3: index, %arg4: index, %arg5: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1:2 = "scf.if"(%arg5) ({
      %4 = "vector.transfer_write"(%arg1, %arg0, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%4, %arg1) : (tensor<?xf32>, vector<5xf32>) -> ()
    }, {
      %2 = "vector.transfer_write"(%arg2, %arg0, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      %3 = "vector.transfer_read"(%arg0, %arg4, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
      "scf.yield"(%2, %3) : (tensor<?xf32>, vector<5xf32>) -> ()
    }) : (i1) -> (tensor<?xf32>, vector<5xf32>)
    "func.return"(%1#0, %1#1) : (tensor<?xf32>, vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, i1) -> tensor<?xf32>, sym_name = "scf_if_out_of_place1a"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "scf.if"(%arg3) ({
      %2 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%0, %arg0, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index, i1) -> tensor<?xf32>, sym_name = "scf_if_out_of_place1b"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: i1):
    %0 = "scf.if"(%arg4) ({
      %3 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%3) : (tensor<?xf32>) -> ()
    }, {
      %2 = "tensor.extract_slice"(%arg0, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%0, %arg0, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, i1) -> tensor<?xf32>, sym_name = "scf_if_out_of_place1c"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "scf.if"(%arg3) ({
      %3 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%3) : (tensor<?xf32>) -> ()
    }, {
      %2 = "tensor.extract_slice"(%arg0, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%0, %arg0, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, index, i1) -> (tensor<?xf32>, vector<10xf32>), sym_name = "scf_if_out_of_place2"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index, %arg3: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "scf.if"(%arg3) ({
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }, {
      %3 = "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%3) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %2 = "vector.transfer_read"(%arg0, %arg2, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<10xf32>
    "func.return"(%1, %2) : (tensor<?xf32>, vector<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, index, i1, i1) -> (tensor<?xf32>, vector<10xf32>), sym_name = "scf_if_out_of_place3"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index, %arg3: i1, %arg4: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "scf.if"(%arg3) ({
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }, {
      %4 = "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%4) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %2 = "scf.if"(%arg4) ({
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %3 = "vector.transfer_read"(%2, %arg2, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<10xf32>
    "func.return"(%1, %3) : (tensor<?xf32>, vector<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index, index) -> tensor<?xf32>, sym_name = "write_to_same_tensor_in_loop_in_place"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg5: index, %arg6: tensor<?xf32>):
      %1 = "bufferization.alloc_tensor"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
      %2 = "arith.index_cast"(%arg5) : (index) -> i32
      %3 = "arith.sitofp"(%2) : (i32) -> f32
      %4 = "tensor.insert"(%3, %1, %arg5) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      %5 = "tensor.insert_slice"(%4, %arg6, %arg5, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%5) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<320xf32>, tensor<320x10240xf32>) -> tensor<320xf32>, sym_name = "same_enclosing_repetitive_region"}> ({
  ^bb0(%arg0: tensor<320xf32>, %arg1: tensor<320x10240xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3 = "scf.forall"(%2, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<320xf32>):
      %4 = "tensor.extract_slice"(%arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, 10240>, static_strides = array<i64: 1, 1>}> : (tensor<320x10240xf32>, index) -> tensor<1x10240xf32>
      %5 = "tensor.extract_slice"(%arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<320xf32>, index) -> tensor<1xf32>
      %6 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32):
        "linalg.yield"(%arg6) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %7 = "linalg.fill"(%1, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>) -> tensor<320xf32>
    "func.return"(%3) : (tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<4xf32>, index, index, index) -> tensor<4xf32>, sym_name = "different_repetitive_region_via_alias"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: tensor<4xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<4xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %4 = "scf.for"(%arg2, %arg3, %arg4, %arg1) ({
    ^bb0(%arg5: index, %arg6: tensor<4xf32>):
      %5 = "tensor.extract"(%3, %arg4) : (tensor<4xf32>, index) -> f32
      "vector.print"(%5) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      %6 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32):
        "linalg.yield"(%arg7) : (f32) -> ()
      }) : (f32, tensor<4xf32>) -> tensor<4xf32>
      "scf.yield"(%6) : (tensor<4xf32>) -> ()
    }) : (index, index, index, tensor<4xf32>) -> tensor<4xf32>
    "func.return"(%4) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<4xf32>, index, index, index) -> (tensor<4xf32>, tensor<4xf32>), sym_name = "no_raw_conflict_after_repetitive_use"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: tensor<4xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<4xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %5 = "scf.for"(%arg2, %arg3, %arg4, %arg1) ({
    ^bb0(%arg7: index, %arg8: tensor<4xf32>):
      %8 = "tensor.extract"(%4, %arg4) : (tensor<4xf32>, index) -> f32
      "vector.print"(%8) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      %9 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32):
        "linalg.yield"(%arg9) : (f32) -> ()
      }) : (f32, tensor<4xf32>) -> tensor<4xf32>
      "scf.yield"(%9) : (tensor<4xf32>) -> ()
    }) : (index, index, index, tensor<4xf32>) -> tensor<4xf32>
    %6 = "tensor.extract"(%4, %arg4) : (tensor<4xf32>, index) -> f32
    "vector.print"(%6) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
    %7 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    "func.return"(%5, %7) : (tensor<4xf32>, tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, index, index, index, f32) -> (), sym_name = "read_of_bbarg_in_repetitive_region"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: f32):
    "scf.for"(%arg1, %arg2, %arg3) ({
    ^bb0(%arg5: index):
      %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<4xf32>
      %1 = "tensor.extract"(%0, %arg1) : (tensor<4xf32>, index) -> f32
      "vector.print"(%1) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      %2 = "tensor.insert"(%arg4, %0, %arg1) : (f32, tensor<4xf32>, index) -> tensor<4xf32>
      %3 = "tensor.extract"(%2, %arg1) : (tensor<4xf32>, index) -> f32
      "vector.print"(%3) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, index, index, index, f32) -> (), sym_name = "read_definition_in_same_repetitive_region_as_write"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: f32):
    %0 = "tensor.insert"(%arg4, %arg0, %arg1) : (f32, tensor<10xf32>, index) -> tensor<10xf32>
    "scf.for"(%arg1, %arg2, %arg3) ({
    ^bb0(%arg5: index):
      %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<4xf32>
      %2 = "tensor.extract"(%1, %arg1) : (tensor<4xf32>, index) -> f32
      "vector.print"(%2) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, index, index, index, f32) -> (), sym_name = "read_definition_in_same_repetitive_region_as_conflicting_write"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: f32):
    %0 = "tensor.insert"(%arg4, %arg0, %arg1) : (f32, tensor<10xf32>, index) -> tensor<10xf32>
    "scf.for"(%arg1, %arg2, %arg3) ({
    ^bb0(%arg5: index):
      %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<4xf32>
      %2 = "tensor.extract"(%1, %arg1) : (tensor<4xf32>, index) -> f32
      "vector.print"(%2) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, index, index, index, f32) -> (), sym_name = "write_value_in_repetitive_region"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: f32):
    %0 = "tensor.extract"(%arg0, %arg1) : (tensor<10xf32>, index) -> f32
    "vector.print"(%0) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
    "scf.for"(%arg1, %arg2, %arg3) ({
    ^bb0(%arg5: index):
      %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<4xf32>
      %2 = "linalg.fill"(%arg4, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32):
        "linalg.yield"(%arg6) : (f32) -> ()
      }) : (f32, tensor<4xf32>) -> tensor<4xf32>
      %3 = "tensor.extract"(%2, %arg1) : (tensor<4xf32>, index) -> f32
      "vector.print"(%3) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, index, index, index, f32) -> (), sym_name = "nesting_op_repetitive_regions"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: f32):
    %0 = "tensor.insert"(%arg4, %arg0, %arg1) : (f32, tensor<10xf32>, index) -> tensor<10xf32>
    "scf.for"(%arg1, %arg2, %arg3) ({
    ^bb0(%arg5: index):
      "scf.for"(%arg1, %arg2, %arg3) ({
      ^bb0(%arg6: index):
        "scf.for"(%arg1, %arg2, %arg3) ({
        ^bb0(%arg7: index):
          %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<4xf32>
          %2 = "tensor.extract"(%1, %arg1) : (tensor<4xf32>, index) -> f32
          "vector.print"(%2) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<320xf32>, sym_name = "parallel_region"}> ({
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<320xf32>
    %1 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3 = "scf.forall"(%2, %0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg0: index, %arg1: tensor<320xf32>):
      %4 = "test.foo"() : () -> f32
      %5 = "linalg.fill"(%4, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg2: f32, %arg3: f32):
        "linalg.yield"(%arg2) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%5, %arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>) -> tensor<320xf32>
    "func.return"(%3) : (tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> tensor<320xf32>, sym_name = "parallel_region_mixed_def"}> ({
  ^bb0(%arg0: i1):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<320xf32>
    %1 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3 = "scf.forall"(%2, %0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: tensor<320xf32>):
      %4 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1xf32>
      %5 = "scf.if"(%arg0) ({
        "scf.yield"(%1) : (tensor<1xf32>) -> ()
      }, {
        "scf.yield"(%4) : (tensor<1xf32>) -> ()
      }) : (i1) -> tensor<1xf32>
      %6 = "test.foo"() : () -> f32
      %7 = "linalg.fill"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>) -> tensor<320xf32>
    "func.return"(%3) : (tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<320xf32>, sym_name = "parallel_region_two_writes"}> ({
  ^bb0(%arg0: f32):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<320xf32>
    %1 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "scf.forall"(%2, %0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: tensor<320xf32>):
      %5 = "test.foo"() : () -> f32
      %6 = "linalg.fill"(%5, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %7 = "tensor.insert"(%arg0, %6, %3) : (f32, tensor<1xf32>, index) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>) -> tensor<320xf32>
    "func.return"(%4) : (tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_region_no_read"}> ({
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<320xf32>
    %1 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    "scf.forall"(%2) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg0: index):
      %3 = "test.foo"() : () -> f32
      %4 = "linalg.fill"(%3, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg1: f32, %arg2: f32):
        "linalg.yield"(%arg1) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}], function_type = (tensor<320xf32>, tensor<320xf32>) -> (tensor<320xf32>, tensor<320xf32>), sym_name = "in_order_multiple_parallel_writes"}> ({
  ^bb0(%arg0: tensor<320xf32>, %arg1: tensor<320xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3:2 = "scf.forall"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 2>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<320xf32>, %arg4: tensor<320xf32>):
      %4 = "tensor.extract_slice"(%arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<320xf32>, index) -> tensor<1xf32>
      %5 = "tensor.extract_slice"(%arg4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<320xf32>, index) -> tensor<1xf32>
      %6 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
        "tensor.parallel_insert_slice"(%6, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>, tensor<320xf32>) -> (tensor<320xf32>, tensor<320xf32>)
    "func.return"(%3#0, %3#1) : (tensor<320xf32>, tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}], function_type = (tensor<320xf32>, tensor<320xf32>) -> (tensor<320xf32>, tensor<320xf32>), sym_name = "out_of_order_parallel_write"}> ({
  ^bb0(%arg0: tensor<320xf32>, %arg1: tensor<320xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3:2 = "scf.forall"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 2>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<320xf32>, %arg4: tensor<320xf32>):
      %4 = "tensor.extract_slice"(%arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<320xf32>, index) -> tensor<1xf32>
      %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%5, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
        "tensor.parallel_insert_slice"(%4, %arg4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>, tensor<320xf32>) -> (tensor<320xf32>, tensor<320xf32>)
    "func.return"(%3#0, %3#1) : (tensor<320xf32>, tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}], function_type = (tensor<320xf32>, tensor<320xf32>) -> (tensor<320xf32>, tensor<320xf32>), sym_name = "out_of_order_parallel_write_multiple_reads"}> ({
  ^bb0(%arg0: tensor<320xf32>, %arg1: tensor<320xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3:2 = "scf.forall"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 2>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<320xf32>, %arg4: tensor<320xf32>):
      %4 = "tensor.extract_slice"(%arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<320xf32>, index) -> tensor<1xf32>
      %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %6 = "arith.subi"(%2, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "tensor.extract_slice"(%arg3, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<320xf32>, index) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%5, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
        "tensor.parallel_insert_slice"(%7, %arg4, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>, tensor<320xf32>) -> (tensor<320xf32>, tensor<320xf32>)
    "func.return"(%3#0, %3#1) : (tensor<320xf32>, tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<320xf32>) -> tensor<320xf32>, sym_name = "in_order_multiple_parallel_writes"}> ({
  ^bb0(%arg0: tensor<320xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 320 : index}> : () -> index
    %3 = "scf.forall"(%2, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: tensor<320xf32>):
      %4 = "tensor.extract_slice"(%arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<320xf32>, index) -> tensor<1xf32>
      %5 = "arith.subi"(%2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg2, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<320xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<320xf32>) -> tensor<320xf32>
    "func.return"(%3) : (tensor<320xf32>) -> ()
  }) : () -> ()
}) : () -> ()

