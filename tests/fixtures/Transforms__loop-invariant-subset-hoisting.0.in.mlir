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
    %7 = "scf.for"(%0, %1, %2, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      %8 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 9>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      "test.foo"(%8) : (tensor<5xf32>) -> ()
      %9 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %10 = "test.foo"(%9) : (tensor<5xf32>) -> tensor<5xf32>
      %11 = "tensor.insert_slice"(%10, %arg2, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%11) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%7) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "subset_of_subset"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "test.foo"() : () -> index
    %1 = "test.foo"() : () -> index
    %2 = "test.foo"() : () -> index
    %3 = "scf.for"(%0, %1, %2, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      %4 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %5 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<5xf32>) -> tensor<2xf32>
      %6 = "test.foo"(%5) : (tensor<2xf32>) -> tensor<2xf32>
      %7 = "tensor.insert_slice"(%6, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<2xf32>, tensor<5xf32>) -> tensor<5xf32>
      %8 = "tensor.insert_slice"(%7, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%8) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
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
    %4 = "scf.for"(%0, %1, %2, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      %5 = "tensor.extract_slice"(%arg2, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      %6 = "tensor.extract_slice"(%arg2, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<5xf32>
      %7 = "test.foo"(%5) : (tensor<?xf32>) -> tensor<?xf32>
      %8 = "test.foo"(%6) : (tensor<5xf32>) -> tensor<5xf32>
      %9 = "tensor.insert_slice"(%8, %arg2, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      %10 = "tensor.insert_slice"(%7, %9, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%10) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
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
    %3:2 = "scf.for"(%0, %1, %2, %arg0, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>, %arg3: tensor<?xf32>):
      %4 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %5 = "tensor.extract_slice"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %6 = "test.foo"(%4) : (tensor<5xf32>) -> tensor<5xf32>
      %7 = "test.foo"(%5) : (tensor<5xf32>) -> tensor<5xf32>
      %8 = "tensor.insert_slice"(%7, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
      %9 = "tensor.insert_slice"(%6, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%8, %9) : (tensor<?xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    "func.return"(%3#0, %3#1) : (tensor<?xf32>, tensor<?xf32>) -> ()
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
    %3 = "scf.for"(%0, %1, %2, %arg0) ({
    ^bb0(%arg1: index, %arg2: tensor<?xf32>):
      %4 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
      %5 = "test.foo"(%4) : (tensor<5xf32>) -> tensor<5xf32>
      %6 = "tensor.insert_slice"(%5, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
      %7 = "scf.for"(%0, %1, %2, %6) ({
      ^bb0(%arg3: index, %arg4: tensor<?xf32>):
        %8 = "tensor.extract_slice"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<5xf32>
        %9 = "test.foo"(%8) : (tensor<5xf32>) -> tensor<5xf32>
        %10 = "tensor.insert_slice"(%9, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
        "scf.yield"(%10) : (tensor<?xf32>) -> ()
      }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%7) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "hoist_vector_transfer_pairs_tensor"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: tensor<?x?xf32>, %arg5: tensor<?x?xf32>, %arg6: index, %arg7: index, %arg8: index, %arg9: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2:6 = "scf.for"(%arg7, %arg8, %arg9, %arg0, %arg1, %arg2, %arg3, %arg4, %arg5) ({
    ^bb0(%arg10: index, %arg11: tensor<?x?xf32>, %arg12: tensor<?x?xf32>, %arg13: tensor<?x?xf32>, %arg14: tensor<?x?xf32>, %arg15: tensor<?x?xf32>, %arg16: tensor<?x?xf32>):
      %3:6 = "scf.for"(%arg7, %arg8, %arg9, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16) ({
      ^bb0(%arg17: index, %arg18: tensor<?x?xf32>, %arg19: tensor<?x?xf32>, %arg20: tensor<?x?xf32>, %arg21: tensor<?x?xf32>, %arg22: tensor<?x?xf32>, %arg23: tensor<?x?xf32>):
        %4 = "vector.transfer_read"(%arg19, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<1xf32>
        %5 = "vector.transfer_read"(%arg18, %arg10, %arg10, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %6 = "vector.transfer_read"(%arg21, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4xf32>
        "test.some_crippling_use"(%arg22) : (tensor<?x?xf32>) -> ()
        %7 = "vector.transfer_read"(%arg22, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<5xf32>
        %8 = "vector.transfer_read"(%arg23, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<6xf32>
        "test.some_crippling_use"(%arg23) : (tensor<?x?xf32>) -> ()
        %9 = "test.some_use"(%4) : (vector<1xf32>) -> vector<1xf32>
        %10 = "test.some_use"(%5) : (vector<2xf32>) -> vector<2xf32>
        %11 = "test.some_use"(%arg20) : (tensor<?x?xf32>) -> vector<3xf32>
        %12 = "test.some_use"(%6) : (vector<4xf32>) -> vector<4xf32>
        %13 = "test.some_use"(%7) : (vector<5xf32>) -> vector<5xf32>
        %14 = "test.some_use"(%8) : (vector<6xf32>) -> vector<6xf32>
        %15 = "vector.transfer_write"(%9, %arg19, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %16 = "vector.transfer_write"(%10, %arg18, %arg10, %arg10) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %17 = "vector.transfer_write"(%11, %arg20, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %18 = "vector.transfer_write"(%12, %arg21, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %19 = "vector.transfer_write"(%13, %arg22, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %20 = "vector.transfer_write"(%14, %arg23, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<6xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        "test.some_crippling_use"(%18) : (tensor<?x?xf32>) -> ()
        "scf.yield"(%16, %15, %17, %18, %19, %20) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
      }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>)
      "scf.yield"(%3#0, %3#1, %3#2, %3#3, %3#4, %3#5) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>)
    "func.return"(%2#0, %2#1, %2#2, %2#3, %2#4, %2#5) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
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
    %4:4 = "scf.for"(%arg5, %arg6, %arg7, %arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg9: index, %arg10: tensor<?x?xf32>, %arg11: tensor<?x?xf32>, %arg12: tensor<?x?xf32>, %arg13: tensor<?x?xf32>):
      %5:4 = "scf.for"(%arg5, %arg6, %arg7, %arg10, %arg11, %arg12, %arg13) ({
      ^bb0(%arg14: index, %arg15: tensor<?x?xf32>, %arg16: tensor<?x?xf32>, %arg17: tensor<?x?xf32>, %arg18: tensor<?x?xf32>):
        %6 = "vector.transfer_read"(%arg16, %0, %0, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %7 = "vector.transfer_read"(%arg16, %0, %1, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %8 = "vector.transfer_read"(%arg17, %0, %0, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<3xf32>
        %9 = "vector.transfer_read"(%arg17, %0, %2, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<3xf32>
        %10 = "vector.transfer_read"(%arg18, %0, %arg8, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4xf32>
        %11 = "vector.transfer_read"(%arg18, %1, %arg8, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4xf32>
        %12 = "vector.transfer_read"(%arg15, %arg9, %arg9, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %13 = "vector.transfer_read"(%arg15, %arg8, %arg8, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %14 = "test.some_use"(%6) : (vector<2xf32>) -> vector<2xf32>
        %15 = "test.some_use"(%7) : (vector<2xf32>) -> vector<2xf32>
        %16 = "test.some_use"(%8) : (vector<3xf32>) -> vector<3xf32>
        %17 = "test.some_use"(%9) : (vector<3xf32>) -> vector<3xf32>
        %18 = "test.some_use"(%10) : (vector<4xf32>) -> vector<4xf32>
        %19 = "test.some_use"(%11) : (vector<4xf32>) -> vector<4xf32>
        %20 = "test.some_use"(%12) : (vector<2xf32>) -> vector<2xf32>
        %21 = "test.some_use"(%13) : (vector<2xf32>) -> vector<2xf32>
        %22 = "vector.transfer_write"(%14, %arg16, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %23 = "vector.transfer_write"(%15, %22, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %24 = "vector.transfer_write"(%16, %arg17, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %25 = "vector.transfer_write"(%17, %24, %0, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %26 = "vector.transfer_write"(%18, %arg18, %0, %arg8) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %27 = "vector.transfer_write"(%19, %26, %1, %arg8) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %28 = "vector.transfer_write"(%20, %arg15, %arg9, %arg9) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %29 = "vector.transfer_write"(%21, %28, %arg8, %arg8) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        "scf.yield"(%29, %23, %25, %27) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
      }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>)
      "scf.yield"(%5#0, %5#1, %5#2, %5#3) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>)
    "func.return"(%4#0, %4#1, %4#2, %4#3) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
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
      %3:3 = "scf.for"(%arg7, %arg8, %arg9, %arg11, %arg12, %arg13) ({
      ^bb0(%arg14: index, %arg15: tensor<?x?xf32>, %arg16: tensor<?x?xf32>, %arg17: tensor<?x?xf32>):
        %4 = "tensor.extract_slice"(%arg15, %arg10, %arg10, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %5 = "vector.transfer_read"(%4, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<1xf32>
        %6 = "tensor.extract_slice"(%arg16, %arg14, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %7 = "vector.transfer_read"(%6, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
        %8 = "tensor.extract_slice"(%arg17, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %9 = "vector.transfer_read"(%8, %0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<3xf32>
        %10 = "test.some_use"(%5) : (vector<1xf32>) -> vector<1xf32>
        %11 = "test.some_use"(%7) : (vector<2xf32>) -> vector<2xf32>
        %12 = "test.some_use"(%9) : (vector<3xf32>) -> vector<3xf32>
        %13 = "vector.transfer_write"(%10, %4, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %14 = "vector.transfer_write"(%11, %6, %arg10, %arg10) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %15 = "vector.transfer_write"(%12, %8, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
        %16 = "tensor.insert_slice"(%13, %arg15, %arg10, %arg10, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %17 = "tensor.insert_slice"(%14, %arg16, %arg14, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %18 = "tensor.insert_slice"(%15, %arg17, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %19 = "tensor.extract_slice"(%18, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 2, 1>}> : (tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        %20 = "tensor.insert_slice"(%19, %arg17, %arg10, %0, %arg9, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
        "scf.yield"(%16, %17, %20) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
      }) : (index, index, index, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>)
      "scf.yield"(%3#0, %3#1, %3#2) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
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
    %4 = "scf.for"(%arg2, %arg3, %arg4, %arg0) ({
    ^bb0(%arg5: index, %arg6: tensor<?x?xf32>):
      %5 = "vector.transfer_read"(%arg6, %0, %0, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
      %6 = "test.some_use"(%5) : (vector<2xf32>) -> vector<2xf32>
      %7 = "vector.transfer_write"(%6, %arg6, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      %8 = "vector.transfer_read"(%7, %0, %2, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<2xf32>
      %9 = "test.some_use"(%8) : (vector<2xf32>) -> vector<2xf32>
      %10 = "vector.transfer_write"(%9, %7, %0, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      "scf.yield"(%10) : (tensor<?x?xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%4) : (tensor<?x?xf32>) -> ()
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

