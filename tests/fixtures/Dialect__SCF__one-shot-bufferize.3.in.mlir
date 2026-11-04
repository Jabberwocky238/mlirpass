"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, index, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "scf_for_yield_only", sym_visibility = "private"}> ({
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
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>, index, index) -> (f32, f32), sym_name = "scf_for_is_reading"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "scf.for"(%arg2, %arg3, %0, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %5 = "linalg.fill"(%1, %arg5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32):
        "linalg.yield"(%arg6) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%arg1) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.extract"(%2, %0) : (tensor<?xf32>, index) -> f32
    %4 = "tensor.extract"(%arg0, %0) : (tensor<?xf32>, index) -> f32
    "func.return"(%3, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}], function_type = (tensor<?xf32>, vector<5xf32>) -> tensor<?xf32>, sym_name = "nested_scf_for"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "scf.for"(%0, %2, %1, %arg0) ({
    ^bb0(%arg2: index, %arg3: tensor<?xf32>):
      %4 = "scf.for"(%0, %2, %1, %arg3) ({
      ^bb0(%arg4: index, %arg5: tensor<?xf32>):
        %5 = "vector.transfer_write"(%arg1, %arg5, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
        "scf.yield"(%5) : (tensor<?xf32>) -> ()
      }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%4) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}, {bufferization.writable = false}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, index, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "scf_for_with_tensor.insert_slice", sym_visibility = "private"}> ({
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
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<?xf32>) -> (f32, tensor<?xf32>, f32), sym_name = "execute_region_with_conflict"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 7 : index}> : () -> index
    %2:3 = "scf.execute_region"() ({
      %4 = "tensor.insert"(%0, %arg0, %1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%0, %4, %0) : (f32, tensor<?xf32>, f32) -> ()
    }) : () -> (f32, tensor<?xf32>, f32)
    %3 = "tensor.extract"(%arg0, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%2#0, %2#1, %3) : (f32, tensor<?xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {bufferization.writable = true}, {}, {}], function_type = (i1, tensor<?xf32>, vector<5xf32>, index) -> tensor<?xf32>, sym_name = "scf_if_inplace"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<?xf32>, %arg2: vector<5xf32>, %arg3: index):
    %0 = "scf.if"(%arg0) ({
      "scf.yield"(%arg1) : (tensor<?xf32>) -> ()
    }, {
      %1 = "vector.transfer_write"(%arg2, %arg1, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, vector<5xf32>, index, i1) -> tensor<?xf32>, sym_name = "scf_if_inside_scf_for"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>, %arg2: index, %arg3: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "scf.for"(%0, %2, %1, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %4 = "scf.if"(%arg3) ({
        "scf.yield"(%arg5) : (tensor<?xf32>) -> ()
      }, {
        %5 = "vector.transfer_write"(%arg1, %arg5, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
        "scf.yield"(%5) : (tensor<?xf32>) -> ()
      }) : (i1) -> tensor<?xf32>
      "scf.yield"(%4) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {bufferization.writable = false}, {bufferization.writable = false}], function_type = (i1, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>, sym_name = "scf_if_non_equiv_yields"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<4xf32>, %arg2: tensor<4xf32>):
    %0 = "scf.if"(%arg0) ({
      "scf.yield"(%arg1) : (tensor<4xf32>) -> ()
    }, {
      "scf.yield"(%arg2) : (tensor<4xf32>) -> ()
    }) : (i1) -> tensor<4xf32>
    "func.return"(%0) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> f32, sym_name = "scf_execute_region_yield_non_equivalent"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "scf.execute_region"() ({
      %2 = "bufferization.alloc_tensor"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
      "scf.yield"(%2) : (tensor<?xf32>) -> ()
    }) : () -> tensor<?xf32>
    %1 = "tensor.extract"(%0, %arg1) : (tensor<?xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index, index) -> tensor<?xf32>, sym_name = "scf_for_yield_non_equivalent"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index, index) -> tensor<?xf32>, sym_name = "scf_for_yield_allocation"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %1 = "bufferization.alloc_tensor"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, index, index, index) -> (f32, f32), sym_name = "scf_for_swapping_yields"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<4xf32>, %arg3: index, %arg4: index, %arg5: index):
    %0:2 = "scf.for"(%arg3, %arg4, %arg5, %arg0, %arg1) ({
    ^bb0(%arg6: index, %arg7: tensor<?xf32>, %arg8: tensor<?xf32>):
      %3 = "tensor.insert_slice"(%arg2, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      %4 = "tensor.insert_slice"(%arg2, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%4, %3) : (tensor<?xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    %1 = "tensor.extract"(%0#0, %arg5) : (tensor<?xf32>, index) -> f32
    %2 = "tensor.extract"(%0#1, %arg5) : (tensor<?xf32>, index) -> f32
    "func.return"(%1, %2) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi1>, index) -> tensor<?xi1>, sym_name = "scf_while"}> ({
  ^bb0(%arg0: tensor<?xi1>, %arg1: index):
    %0:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg4: tensor<?xi1>, %arg5: index):
      %4 = "tensor.extract"(%arg4, %arg1) : (tensor<?xi1>, index) -> i1
      "scf.condition"(%4, %arg4, %arg1) : (i1, tensor<?xi1>, index) -> ()
    }, {
    ^bb0(%arg2: tensor<?xi1>, %arg3: index):
      %1 = "dummy.some_op"() : () -> index
      %2 = "dummy.another_op"() : () -> i1
      %3 = "tensor.insert"(%2, %arg2, %1) : (i1, tensor<?xi1>, index) -> tensor<?xi1>
      "scf.yield"(%3, %arg3) : (tensor<?xi1>, index) -> ()
    }) : (tensor<?xi1>, index) -> (tensor<?xi1>, index)
    "func.return"(%0#0) : (tensor<?xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xi1>, tensor<5xi1>, index) -> (tensor<5xi1>, tensor<5xi1>), sym_name = "scf_while_non_equiv_condition"}> ({
  ^bb0(%arg0: tensor<5xi1>, %arg1: tensor<5xi1>, %arg2: index):
    %0:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg5: tensor<5xi1>, %arg6: tensor<5xi1>):
      %4 = "tensor.extract"(%arg5, %arg2) : (tensor<5xi1>, index) -> i1
      "scf.condition"(%4, %arg6, %arg5) : (i1, tensor<5xi1>, tensor<5xi1>) -> ()
    }, {
    ^bb0(%arg3: tensor<5xi1>, %arg4: tensor<5xi1>):
      %1 = "dummy.some_op"() : () -> index
      %2 = "dummy.another_op"() : () -> i1
      %3 = "tensor.insert"(%2, %arg3, %1) : (i1, tensor<5xi1>, index) -> tensor<5xi1>
      "scf.yield"(%3, %arg4) : (tensor<5xi1>, tensor<5xi1>) -> ()
    }) : (tensor<5xi1>, tensor<5xi1>) -> (tensor<5xi1>, tensor<5xi1>)
    "func.return"(%0#0, %0#1) : (tensor<5xi1>, tensor<5xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xi1>, tensor<5xi1>, index) -> (tensor<5xi1>, tensor<5xi1>), sym_name = "scf_while_non_equiv_condition_and_body"}> ({
  ^bb0(%arg0: tensor<5xi1>, %arg1: tensor<5xi1>, %arg2: index):
    %0:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg5: tensor<5xi1>, %arg6: tensor<5xi1>):
      %4 = "tensor.extract"(%arg5, %arg2) : (tensor<5xi1>, index) -> i1
      "scf.condition"(%4, %arg6, %arg5) : (i1, tensor<5xi1>, tensor<5xi1>) -> ()
    }, {
    ^bb0(%arg3: tensor<5xi1>, %arg4: tensor<5xi1>):
      %1 = "dummy.some_op"() : () -> index
      %2 = "dummy.another_op"() : () -> i1
      %3 = "tensor.insert"(%2, %arg3, %1) : (i1, tensor<5xi1>, index) -> tensor<5xi1>
      "scf.yield"(%arg4, %3) : (tensor<5xi1>, tensor<5xi1>) -> ()
    }) : (tensor<5xi1>, tensor<5xi1>) -> (tensor<5xi1>, tensor<5xi1>)
    "func.return"(%0#0, %0#1) : (tensor<5xi1>, tensor<5xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xi1>, tensor<5xi1>, index) -> (), sym_name = "scf_while_iter_arg_result_mismatch"}> ({
  ^bb0(%arg0: tensor<5xi1>, %arg1: tensor<5xi1>, %arg2: index):
    "scf.while"(%arg1) ({
    ^bb0(%arg3: tensor<5xi1>):
      %3 = "tensor.extract"(%arg0, %arg2) : (tensor<5xi1>, index) -> i1
      %4 = "tensor.extract"(%arg3, %arg2) : (tensor<5xi1>, index) -> i1
      "dummy.use"(%4) : (i1) -> ()
      "scf.condition"(%3) : (i1) -> ()
    }, {
      %0 = "dummy.some_op"() : () -> index
      %1 = "dummy.another_op"() : () -> i1
      %2 = "tensor.insert"(%1, %arg0, %0) : (i1, tensor<5xi1>, index) -> tensor<5xi1>
      "scf.yield"(%2) : (tensor<5xi1>) -> ()
    }) : (tensor<5xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {}, {bufferization.writable = true}, {bufferization.writable = true}], function_type = (index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, f32), sym_name = "parallel_insert_slice_no_conflict", sym_visibility = "private"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "scf.forall"(%arg1, %arg3) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %5 = "tensor.extract_slice"(%arg5, %arg0, %2) <{operandSegmentSizes = array<i32: 1, 0, 1, 1>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %6 = "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32):
        "linalg.yield"(%arg6) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%6, %arg5, %arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 1>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> ()
      }) : () -> ()
    }) {keep_this_attribute} : (index, tensor<?xf32>) -> tensor<?xf32>
    %4 = "tensor.extract"(%3, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%3, %4) : (tensor<?xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {}, {bufferization.writable = true}, {bufferization.writable = true}], function_type = (index, index, tensor<?xf32>, tensor<?xf32>) -> (f32, f32), sym_name = "parallel_insert_slice_with_conflict"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "scf.forall"(%arg1, %arg3) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %6 = "tensor.extract_slice"(%arg5, %arg0, %2) <{operandSegmentSizes = array<i32: 1, 0, 1, 1>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %7 = "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32):
        "linalg.yield"(%arg6) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg5, %arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 1>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32>) -> tensor<?xf32>
    %4 = "tensor.extract"(%arg3, %1) : (tensor<?xf32>, index) -> f32
    %5 = "tensor.extract"(%3, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%5, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 * 4)>
#map1 = affine_map<(d0) -> (d0 * 2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {}, {bufferization.writable = true}], function_type = (tensor<8x8xf32>, tensor<8x8xf32>, tensor<8x8xf32>) -> tensor<8x8xf32>, sym_name = "matmul"}> ({
  ^bb0(%arg0: tensor<8x8xf32>, %arg1: tensor<8x8xf32>, %arg2: tensor<8x8xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "scf.forall"(%0, %1, %arg2) <{operandSegmentSizes = array<i32: 0, 2, 0, 1>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg3: index, %arg4: index, %arg5: tensor<8x8xf32>):
      %3 = "affine.apply"(%arg3) <{map = #map}> : (index) -> index
      %4 = "tensor.extract_slice"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 4, 8>, static_strides = array<i64: 1, 1>}> : (tensor<8x8xf32>, index) -> tensor<4x8xf32>
      %5 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
      %6 = "tensor.extract_slice"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, 4>, static_strides = array<i64: 1, 1>}> : (tensor<8x8xf32>, index) -> tensor<8x4xf32>
      %7 = "tensor.extract_slice"(%arg5, %3, %5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<8x8xf32>, index, index) -> tensor<4x4xf32>
      %8 = "linalg.matmul"(%4, %6, %7) <{indexing_maps = [#map2, #map3, #map4], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
        %9 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %10 = "arith.addf"(%arg8, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%10) : (f32) -> ()
      }) : (tensor<4x8xf32>, tensor<8x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%8, %arg5, %3, %5) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<4x4xf32>, tensor<8x8xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, index, tensor<8x8xf32>) -> tensor<8x8xf32>
    "func.return"(%2) : (tensor<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>) -> f32, sym_name = "scf_foreach_private_var"}> ({
  ^bb0(%arg0: tensor<10xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "scf.forall"(%0, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: tensor<10xf32>):
      %4 = "arith.muli"(%1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "tensor.extract_slice"(%arg2, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<10xf32>, index) -> tensor<5xf32>
      %6 = "tensor.extract"(%arg0, %arg1) : (tensor<10xf32>, index) -> f32
      %7 = "tensor.insert"(%6, %5, %0) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg2, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<10xf32>) -> tensor<10xf32>
    %3 = "tensor.extract"(%2, %0) : (tensor<10xf32>, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, tensor<10xf32>) -> f32, sym_name = "scf_foreach_privatized_but_not_copied"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: tensor<10xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "scf.forall"(%0, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<10xf32>):
      %4 = "arith.muli"(%1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "tensor.extract_slice"(%arg3, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<10xf32>, index) -> tensor<5xf32>
      %6 = "tensor.extract"(%arg1, %arg2) : (tensor<10xf32>, index) -> f32
      %7 = "tensor.insert"(%6, %5, %0) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg3, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<10xf32>) -> tensor<10xf32>
    %3 = "tensor.extract"(%2, %0) : (tensor<10xf32>, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, f32, f32) -> (f32, f32), sym_name = "scf_if_memory_space"}> ({
  ^bb0(%arg0: i1, %arg1: f32, %arg2: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "bufferization.alloc_tensor"() <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %2 = "linalg.fill"(%arg2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %3 = "scf.if"(%arg0) ({
      "scf.yield"(%2) : (tensor<5xf32>) -> ()
    }, {
      %6 = "tensor.insert"(%arg1, %2, %0) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
      "scf.yield"(%6) : (tensor<5xf32>) -> ()
    }) : (i1) -> tensor<5xf32>
    %4 = "tensor.extract"(%2, %0) : (tensor<5xf32>, index) -> f32
    %5 = "tensor.extract"(%3, %0) : (tensor<5xf32>, index) -> f32
    "func.return"(%4, %5) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "scf_execute_region_memory_space"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "scf.execute_region"() ({
      %3 = "bufferization.alloc_tensor"() <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
      %4 = "tensor.insert"(%arg0, %3, %0) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
      "scf.yield"(%4) : (tensor<5xf32>) -> ()
    }) : () -> tensor<5xf32>
    %2 = "tensor.extract"(%1, %0) : (tensor<5xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, tensor<4xf32>, index, index, index) -> (f32, f32), sym_name = "scf_for_swapping_yields_memory_space"}> ({
  ^bb0(%arg0: index, %arg1: tensor<4xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "bufferization.alloc_tensor"(%arg0) <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %1 = "bufferization.alloc_tensor"(%arg0) <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %2:2 = "scf.for"(%arg2, %arg3, %arg4, %0, %1) ({
    ^bb0(%arg5: index, %arg6: tensor<?xf32>, %arg7: tensor<?xf32>):
      %5 = "tensor.insert_slice"(%arg1, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      %6 = "tensor.insert_slice"(%arg1, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%6, %5) : (tensor<?xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    %3 = "tensor.extract"(%2#0, %arg4) : (tensor<?xf32>, index) -> f32
    %4 = "tensor.extract"(%2#1, %arg4) : (tensor<?xf32>, index) -> f32
    "func.return"(%3, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<?xf32>, sym_name = "scf_for_yield_alias_of_non_equivalent"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %3 = "tensor.generate"(%arg0) ({
    ^bb0(%arg3: index):
      "tensor.yield"(%2) : (f32) -> ()
    }) : (index) -> tensor<?xf32>
    %4 = "scf.for"(%0, %arg0, %1, %3) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      %5 = "arith.subi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "tensor.extract_slice"(%3, %5, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %7 = "tensor.extract"(%6, %0) : (tensor<?xf32>, index) -> f32
      %8 = "arith.mulf"(%2, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "tensor.insert"(%8, %arg2, %arg1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%9) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> f32, sym_name = "scf_for_buffer_type_mismatch"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "bufferization.alloc_tensor"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %4 = "tensor.extract_slice"(%3, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    %5 = "scf.for"(%0, %2, %1, %4) ({
    ^bb0(%arg2: index, %arg3: tensor<?xf32>):
      %7 = "test.dummy"() : () -> index
      %8 = "tensor.extract_slice"(%arg3, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%8) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    %6 = "tensor.extract"(%5, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> f32, sym_name = "scf_while_buffer_type_mismatch"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "arith.constant"() <{value = 5.500000e+00 : f32}> : () -> f32
    %4 = "bufferization.alloc_tensor"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %5 = "tensor.extract_slice"(%4, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    %6 = "scf.while"(%5) ({
    ^bb0(%arg3: tensor<?xf32>):
      %10 = "test.condition"() : () -> i1
      %11 = "test.dummy"() : () -> index
      %12 = "tensor.extract_slice"(%arg3, %11) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      "scf.condition"(%10, %12) : (i1, tensor<?xf32>) -> ()
    }, {
    ^bb0(%arg2: tensor<?xf32>):
      %8 = "test.dummy"() : () -> index
      %9 = "tensor.insert"(%3, %arg2, %8) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%9) : (tensor<?xf32>) -> ()
    }) : (tensor<?xf32>) -> tensor<?xf32>
    %7 = "tensor.extract"(%6, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "non_tensor_for_arg"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 10 : index}> : () -> index
    %4:2 = "scf.for"(%0, %3, %1, %1, %arg0) ({
    ^bb0(%arg1: index, %arg2: index, %arg3: tensor<?xf32>):
      %5 = "tensor.insert"(%2, %arg3, %arg2) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%arg2, %5) : (index, tensor<?xf32>) -> ()
    }) : (index, index, index, index, tensor<?xf32>) -> (index, tensor<?xf32>)
    "func.return"(%4#1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f64>) -> (), sym_name = "buffer_type_of_collapse_shape"}> ({
  ^bb0(%arg0: tensor<f64>):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "scf.while"(%arg0) ({
    ^bb0(%arg2: tensor<f64>):
      "scf.condition"(%0, %arg2) : (i1, tensor<f64>) -> ()
    }, {
    ^bb0(%arg1: tensor<f64>):
      %2 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1xf64>
      %3 = "tensor.collapse_shape"(%2) <{reassociation = []}> : (tensor<1xf64>) -> tensor<f64>
      "scf.yield"(%3) : (tensor<f64>) -> ()
    }) : (tensor<f64>) -> tensor<f64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "non_block_argument_yield"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<i32>
    %2 = "scf.while"(%1) ({
    ^bb0(%arg3: tensor<i32>):
      "scf.condition"(%0, %arg3) : (i1, tensor<i32>) -> ()
    }, {
    ^bb0(%arg0: tensor<i32>):
      %3 = "scf.while"(%1) ({
      ^bb0(%arg2: tensor<i32>):
        "scf.condition"(%0, %arg2) : (i1, tensor<i32>) -> ()
      }, {
      ^bb0(%arg1: tensor<i32>):
        "scf.yield"(%1) : (tensor<i32>) -> ()
      }) : (tensor<i32>) -> tensor<i32>
      "scf.yield"(%3) : (tensor<i32>) -> ()
    }) : (tensor<i32>) -> tensor<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2xindex>, sym_name = "regression_cast_in_loop"}> ({
    %0 = "arith.constant"() <{value = false}> : () -> i1
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<2xindex>
    %3 = "scf.while"(%2) ({
    ^bb0(%arg1: tensor<2xindex>):
      "scf.condition"(%0, %arg1) : (i1, tensor<2xindex>) -> ()
    }, {
    ^bb0(%arg0: tensor<2xindex>):
      %4 = "tensor.cast"(%2) : (tensor<2xindex>) -> tensor<?xindex>
      %5 = "tensor.insert"(%1, %4, %1) : (index, tensor<?xindex>, index) -> tensor<?xindex>
      %6 = "tensor.cast"(%5) : (tensor<?xindex>) -> tensor<2xindex>
      "scf.yield"(%6) : (tensor<2xindex>) -> ()
    }) : (tensor<2xindex>) -> tensor<2xindex>
    "func.return"(%3) : (tensor<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, index, index, f32) -> (tensor<10xf32>, f32), sym_name = "elide_copy_of_non_writing_scf_if"}> ({
  ^bb0(%arg0: i1, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "scf.if"(%arg0) ({
      %4 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
      "scf.yield"(%4) : (tensor<10xf32>) -> ()
    }, {
      %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
      "scf.yield"(%3) : (tensor<10xf32>) -> ()
    }) : (i1) -> tensor<10xf32>
    %1 = "tensor.insert"(%arg3, %0, %arg1) : (f32, tensor<10xf32>, index) -> tensor<10xf32>
    %2 = "tensor.extract"(%0, %arg2) : (tensor<10xf32>, index) -> f32
    "func.return"(%1, %2) : (tensor<10xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>, sym_name = "index_switch"}> ({
  ^bb0(%arg0: index, %arg1: tensor<5xf32>, %arg2: tensor<5xf32>):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "scf.index_switch"(%arg0) <{cases = array<i64: 2, 5>}> ({
      "scf.yield"(%arg2) : (tensor<5xf32>) -> ()
    }, {
      "scf.yield"(%0) : (tensor<5xf32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<5xf32>) -> ()
    }) : (index) -> tensor<5xf32>
    "func.return"(%1) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {}, {bufferization.writable = true}], function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "check_scfforall_inplace_bufferizer"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg2, %0) : (tensor<?xf32>, index) -> index
    %3 = "tensor.dim"(%arg1, %1) : (tensor<?x?xf32>, index) -> index
    %4 = "scf.forall"(%1, %arg2) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg3: index, %arg4: tensor<?xf32>):
      %5 = "tensor.extract_slice"(%arg0, %2, %3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      %6 = "tensor.extract_slice"(%arg1, %2, %3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      %7 = "linalg.generic"(%5, %6, %arg4) <{indexing_maps = [#map, #map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
        %8 = "arith.mulf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %9 = "arith.addf"(%8, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%9) : (f32) -> ()
      }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg4, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

