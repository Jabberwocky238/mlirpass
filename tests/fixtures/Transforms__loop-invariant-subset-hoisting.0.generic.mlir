"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "hoist_matching_extract_insert"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.subi"(%5, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
    %8:2 = "scf.for"(%0, %1, %2, %arg0, %7) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<5xf32>):
      %10 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 9>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      "test.foo"(%10) : (tensor<5xf32>) -> ()
      %11 = "test.foo"(%arg3) : (tensor<5xf32>) -> tensor<5xf32>
      "scf.yield"(%arg2, %11) : (tensor<?xf32>, tensor<5xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<5xf32>) -> (tensor<?xf32>, tensor<5xf32>)
    %9 = "tensor.insert_slice"(%8#1, %8#0, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%9) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "subset_of_subset"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<5xf32>) -> tensor<2xf32>
    %5:3 = "scf.for"(%0, %1, %2, %arg0, %3, %4) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<5xf32>, %arg4: tensor<2xf32>):
      %8 = "test.foo"(%arg4) : (tensor<2xf32>) -> tensor<2xf32>
      "scf.yield"(%arg2, %arg3, %8) : (tensor<?xf32>, tensor<5xf32>, tensor<2xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<5xf32>, tensor<2xf32>) -> (tensor<?xf32>, tensor<5xf32>, tensor<2xf32>)
    %6 = "tensor.insert_slice"(%5#2, %5#1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<2xf32>, tensor<5xf32>) -> tensor<5xf32>
    %7 = "tensor.insert_slice"(%6, %5#0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%7) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "hoist_matching_chain"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "test.foo"() : () -> index
    %4 = "tensor.extract_slice"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<5xf32>
    %5 = "tensor.extract_slice"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    %6:3 = "scf.for"(%0, %1, %2, %arg0, %4, %5) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<5xf32>, %arg4: tensor<?xf32>):
      %9 = "test.foo"(%arg4) : (tensor<?xf32>) -> tensor<?xf32>
      %10 = "test.foo"(%arg3) : (tensor<5xf32>) -> tensor<5xf32>
      "scf.yield"(%arg2, %10, %9) : (tensor<?xf32>, tensor<5xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<5xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<5xf32>, tensor<?xf32>)
    %7 = "tensor.insert_slice"(%6#2, %6#0, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %8 = "tensor.insert_slice"(%6#1, %7, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%8) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "do_not_hoist_overlapping_subsets"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "test.foo"() : () -> index
    %4 = "test.foo"() : () -> index
    %5 = "scf.for"(%0, %1, %2, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      %6 = "tensor.extract_slice"(%arg2, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      %7 = "tensor.extract_slice"(%arg2, %4) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 10>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      %8 = "test.foo"(%6) : (tensor<?xf32>) -> tensor<?xf32>
      %9 = "test.foo"(%7) : (tensor<?xf32>) -> tensor<?xf32>
      %10 = "tensor.insert_slice"(%9, %arg2, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      %11 = "tensor.insert_slice"(%8, %10, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 10>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%11) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%5) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "multiple_yields"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
    %4 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
    %5:4 = "scf.for"(%0, %1, %2, %arg0, %arg0, %3, %4) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<?xf32>, %arg4: tensor<5xf32>, %arg5: tensor<5xf32>):
      %8 = "test.foo"(%arg4) : (tensor<5xf32>) -> tensor<5xf32>
      %9 = "test.foo"(%arg5) : (tensor<5xf32>) -> tensor<5xf32>
      "scf.yield"(%arg2, %arg3, %9, %8) : (tensor<?xf32>, tensor<?xf32>, tensor<5xf32>, tensor<5xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>, tensor<5xf32>, tensor<5xf32>) -> (tensor<?xf32>, tensor<?xf32>, tensor<5xf32>, tensor<5xf32>)
    %6 = "tensor.insert_slice"(%5#3, %5#1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
    %7 = "tensor.insert_slice"(%5#2, %5#0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%7, %6) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "do_not_hoist_swapping_yields"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3:2 = "scf.for"(%0, %1, %2, %arg0, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<?xf32>):
      %4 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %5 = "tensor.extract_slice"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %6 = "test.foo"(%4) : (tensor<5xf32>) -> tensor<5xf32>
      %7 = "test.foo"(%5) : (tensor<5xf32>) -> tensor<5xf32>
      %8 = "tensor.insert_slice"(%7, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
      %9 = "tensor.insert_slice"(%6, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%9, %8) : (tensor<?xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    "func.return"(%3#0, %3#1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "non_subset_op"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "scf.for"(%0, %1, %2, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      "test.non_subset_op"(%arg2) : (tensor<?xf32>) -> ()
      %4 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %5 = "test.foo"(%4) : (tensor<5xf32>) -> tensor<5xf32>
      %6 = "tensor.insert_slice"(%5, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%6) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "non_loop_invariant_subset_op"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "scf.for"(%0, %1, %2, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      %4 = "tensor.extract_slice"(%arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<5xf32>
      %5 = "test.foo"(%4) : (tensor<5xf32>) -> tensor<5xf32>
      %6 = "tensor.insert_slice"(%5, %arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%6) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "nested_hoisting"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
    %4 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
    %5:3 = "scf.for"(%0, %1, %2, %arg0, %3, %4) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<5xf32>, %arg4: tensor<5xf32>):
      %8 = "test.foo"(%arg3) : (tensor<5xf32>) -> tensor<5xf32>
      %9:2 = "scf.for"(%0, %1, %2, %arg2, %arg4) ({
      ^bb0(%arg5: index, %arg6: tensor<?xf32>, %arg7: tensor<5xf32>):
        %10 = "test.foo"(%arg7) : (tensor<5xf32>) -> tensor<5xf32>
        "scf.yield"(%arg6, %10) : (tensor<?xf32>, tensor<5xf32>) -> ()
      }) : (index, index, index, tensor<?xf32>, tensor<5xf32>) -> (tensor<?xf32>, tensor<5xf32>)
      "scf.yield"(%9#0, %8, %9#1) : (tensor<?xf32>, tensor<5xf32>, tensor<5xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<5xf32>, tensor<5xf32>) -> (tensor<?xf32>, tensor<5xf32>, tensor<5xf32>)
    %6 = "tensor.insert_slice"(%5#2, %5#0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
    %7 = "tensor.insert_slice"(%5#1, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%7) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "hoist_vector_transfer_pairs_tensor"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: tensor<?x?xf32>, %arg5: tensor<?x?xf32>, %arg6: index, %arg7: index, %arg8: index, %arg9: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<1xf32>
    %3:7 = "scf.for"(%arg7, %arg8, %arg9, %arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %2) ({
    ^bb0(%arg10: index, %arg11: tensor<?x?xf32>, %arg12: tensor<?x?xf32>, %arg13: tensor<?x?xf32>, %arg14: tensor<?x?xf32>, %arg15: tensor<?x?xf32>, %arg16: tensor<?x?xf32>, %arg17: vector<1xf32>):
      %5 = "vector.transfer_read"(%arg11, %arg10, %arg10, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
      %6:8 = "scf.for"(%arg7, %arg8, %arg9, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %5, %arg17) ({
      ^bb0(%arg18: index, %arg19: tensor<?x?xf32>, %arg20: tensor<?x?xf32>, %arg21: tensor<?x?xf32>, %arg22: tensor<?x?xf32>, %arg23: tensor<?x?xf32>, %arg24: tensor<?x?xf32>, %arg25: vector<2xf32>, %arg26: vector<1xf32>):
        %8 = "vector.transfer_read"(%arg22, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4xf32>
        "test.some_crippling_use"(%arg23) : (tensor<?x?xf32>) -> ()
        %9 = "vector.transfer_read"(%arg23, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<5xf32>
        %10 = "vector.transfer_read"(%arg24, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<6xf32>
        "test.some_crippling_use"(%arg24) : (tensor<?x?xf32>) -> ()
        %11 = "test.some_use"(%arg26) : (vector<1xf32>) -> vector<1xf32>
        %12 = "test.some_use"(%arg25) : (vector<2xf32>) -> vector<2xf32>
        %13 = "test.some_use"(%arg21) : (tensor<?x?xf32>) -> vector<3xf32>
        %14 = "test.some_use"(%8) : (vector<4xf32>) -> vector<4xf32>
        %15 = "test.some_use"(%9) : (vector<5xf32>) -> vector<5xf32>
        %16 = "test.some_use"(%10) : (vector<6xf32>) -> vector<6xf32>
        %17 = "vector.transfer_write"(%13, %arg21, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %18 = "vector.transfer_write"(%14, %arg22, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %19 = "vector.transfer_write"(%15, %arg23, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %20 = "vector.transfer_write"(%16, %arg24, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<6xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        "test.some_crippling_use"(%18) : (tensor<?x?xf32>) -> ()
        "scf.yield"(%arg19, %arg20, %17, %18, %19, %20, %12, %11) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<2xf32>, vector<1xf32>) -> ()
      }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<2xf32>, vector<1xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<2xf32>, vector<1xf32>)
      %7 = "vector.transfer_write"(%6#6, %6#0, %arg10, %arg10) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      "scf.yield"(%7, %6#1, %6#2, %6#3, %6#4, %6#5, %6#7) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>)
    %4 = "vector.transfer_write"(%3#6, %3#1, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%3#0, %4, %3#2, %3#3, %3#4, %3#5) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index, index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "hoist_vector_transfer_pairs_disjoint_tensor"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%arg2, %0, %2, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<3xf32>
    %5 = "vector.transfer_read"(%arg2, %0, %0, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<3xf32>
    %6 = "vector.transfer_read"(%arg3, %1, %arg8, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4xf32>
    %7 = "vector.transfer_read"(%arg3, %0, %arg8, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4xf32>
    %8:8 = "scf.for"(%arg5, %arg6, %arg7, %arg0, %arg1, %arg2, %arg3, %4, %5, %6, %7) ({
    ^bb0(%arg9: index, %arg10: tensor<?x?xf32>, %arg11: tensor<?x?xf32>, %arg12: tensor<?x?xf32>, %arg13: tensor<?x?xf32>, %arg14: vector<3xf32>, %arg15: vector<3xf32>, %arg16: vector<4xf32>, %arg17: vector<4xf32>):
      %13:8 = "scf.for"(%arg5, %arg6, %arg7, %arg10, %arg11, %arg12, %arg13, %arg15, %arg14, %arg17, %arg16) ({
      ^bb0(%arg18: index, %arg19: tensor<?x?xf32>, %arg20: tensor<?x?xf32>, %arg21: tensor<?x?xf32>, %arg22: tensor<?x?xf32>, %arg23: vector<3xf32>, %arg24: vector<3xf32>, %arg25: vector<4xf32>, %arg26: vector<4xf32>):
        %14 = "vector.transfer_read"(%arg20, %0, %0, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %15 = "vector.transfer_read"(%arg20, %0, %1, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %16 = "vector.transfer_read"(%arg19, %arg9, %arg9, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %17 = "vector.transfer_read"(%arg19, %arg8, %arg8, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %18 = "test.some_use"(%14) : (vector<2xf32>) -> vector<2xf32>
        %19 = "test.some_use"(%15) : (vector<2xf32>) -> vector<2xf32>
        %20 = "test.some_use"(%arg23) : (vector<3xf32>) -> vector<3xf32>
        %21 = "test.some_use"(%arg24) : (vector<3xf32>) -> vector<3xf32>
        %22 = "test.some_use"(%arg25) : (vector<4xf32>) -> vector<4xf32>
        %23 = "test.some_use"(%arg26) : (vector<4xf32>) -> vector<4xf32>
        %24 = "test.some_use"(%16) : (vector<2xf32>) -> vector<2xf32>
        %25 = "test.some_use"(%17) : (vector<2xf32>) -> vector<2xf32>
        %26 = "vector.transfer_write"(%18, %arg20, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %27 = "vector.transfer_write"(%19, %26, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %28 = "vector.transfer_write"(%24, %arg19, %arg9, %arg9) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %29 = "vector.transfer_write"(%25, %28, %arg8, %arg8) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        "scf.yield"(%29, %27, %arg21, %arg22, %20, %21, %22, %23) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>) -> ()
      }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>)
      "scf.yield"(%13#0, %13#1, %13#2, %13#3, %13#5, %13#4, %13#7, %13#6) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<3xf32>, vector<3xf32>, vector<4xf32>, vector<4xf32>)
    %9 = "vector.transfer_write"(%8#7, %8#3, %0, %arg8) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %10 = "vector.transfer_write"(%8#6, %9, %1, %arg8) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %11 = "vector.transfer_write"(%8#5, %8#2, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %12 = "vector.transfer_write"(%8#4, %11, %0, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%8#0, %8#1, %12, %10) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "hoist_vector_transfer_pairs_tensor_and_slices"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: tensor<?x?xf32>, %arg5: tensor<?x?xf32>, %arg6: index, %arg7: index, %arg8: index, %arg9: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2:3 = "scf.for"(%arg7, %arg8, %arg9, %arg0, %arg1, %arg2) ({
    ^bb0(%arg10: index, %arg11: tensor<?x?xf32>, %arg12: tensor<?x?xf32>, %arg13: tensor<?x?xf32>):
      %3 = "tensor.extract_slice"(%arg11, %arg10, %arg10, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
      %4 = "vector.transfer_read"(%3, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<1xf32>
      %5:5 = "scf.for"(%arg7, %arg8, %arg9, %arg11, %arg12, %arg13, %3, %4) ({
      ^bb0(%arg14: index, %arg15: tensor<?x?xf32>, %arg16: tensor<?x?xf32>, %arg17: tensor<?x?xf32>, %arg18: tensor<?x?xf32>, %arg19: vector<1xf32>):
        %8 = "tensor.extract_slice"(%arg16, %arg14, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %9 = "vector.transfer_read"(%8, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %10 = "tensor.extract_slice"(%arg17, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %11 = "vector.transfer_read"(%10, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<3xf32>
        %12 = "test.some_use"(%arg19) : (vector<1xf32>) -> vector<1xf32>
        %13 = "test.some_use"(%9) : (vector<2xf32>) -> vector<2xf32>
        %14 = "test.some_use"(%11) : (vector<3xf32>) -> vector<3xf32>
        %15 = "vector.transfer_write"(%13, %8, %arg10, %arg10) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %16 = "vector.transfer_write"(%14, %10, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %17 = "tensor.insert_slice"(%15, %arg16, %arg14, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %18 = "tensor.insert_slice"(%16, %arg17, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %19 = "tensor.extract_slice"(%18, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 2, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %20 = "tensor.insert_slice"(%19, %arg17, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        "scf.yield"(%arg15, %17, %20, %arg18, %12) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>) -> ()
      }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, vector<1xf32>)
      %6 = "vector.transfer_write"(%5#4, %5#3, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      %7 = "tensor.insert_slice"(%6, %5#0, %arg10, %arg10, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
      "scf.yield"(%7, %5#1, %5#2) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>)
    "func.return"(%2#0, %2#1, %2#2) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>, sym_name = "hoist_vector_transfer_write_pairs_disjoint_tensor"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%arg0, %0, %0, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
    %5 = "vector.transfer_read"(%arg0, %0, %2, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
    %6:3 = "scf.for"(%arg2, %arg3, %arg4, %arg0, %4, %5) ({
    ^bb0(%arg5: index, %arg6: tensor<?x?xf32>, %arg7: vector<2xf32>, %arg8: vector<2xf32>):
      %9 = "test.some_use"(%arg7) : (vector<2xf32>) -> vector<2xf32>
      %10 = "test.some_use"(%arg8) : (vector<2xf32>) -> vector<2xf32>
      "scf.yield"(%arg6, %9, %10) : (tensor<?x?xf32>, vector<2xf32>, vector<2xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>, vector<2xf32>, vector<2xf32>) -> (tensor<?x?xf32>, vector<2xf32>, vector<2xf32>)
    %7 = "vector.transfer_write"(%6#2, %6#0, %0, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %8 = "vector.transfer_write"(%6#1, %7, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%8) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<7x7xf16>) -> (), sym_name = "hoist_buffer"}> ({
  ^bb0(%arg0: memref<7x7xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<7x7xf16>
    %3 = "scf.for"(%0, %1, %1, %2) ({
    ^bb0(%arg1: index, %arg2: memref<7x7xf16>):
      "linalg.copy"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f16, %arg4: f16):
        "linalg.yield"(%arg3) : (f16) -> ()
      }) : (memref<7x7xf16>, memref<7x7xf16>) -> ()
      "scf.yield"(%2) : (memref<7x7xf16>) -> ()
    }) : (index, index, index, memref<7x7xf16>) -> memref<7x7xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

