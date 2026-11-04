"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "private_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?xf32>) -> (), sym_name = "private_func_2d", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "empty_func"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi32>) -> f32, sym_name = "external_func_with_return_val", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (f32, tensor<?xf32>, f32), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "call_to_unknown_tensor_returning_func"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0:3 = "func.call"(%arg0) <{callee = @foo}> : (tensor<?xf32>) -> (f32, tensor<?xf32>, f32)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> tensor<2x?xf32>, sym_name = "return_extract_slice"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<20x10xf32>
    %1 = "tensor.extract_slice"(%0, %arg0, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<20x10xf32>, index, index, index) -> tensor<2x?xf32>
    "func.return"(%1) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x8xf16>) -> tensor<3x8xf16>, sym_name = "foo"}> ({
  ^bb0(%arg1: tensor<3x8xf16>):
    "func.return"(%arg1) : (tensor<3x8xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x8xf16>) -> tensor<3x8xf16>, sym_name = "call_extract_slice"}> ({
  ^bb0(%arg0: tensor<4x8xf16>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1, 0>, static_sizes = array<i64: 3, 8>, static_strides = array<i64: 1, 1>}> : (tensor<4x8xf16>) -> tensor<3x8xf16>
    %1 = "func.call"(%0) <{callee = @foo}> : (tensor<3x8xf16>) -> tensor<3x8xf16>
    "func.return"(%1) : (tensor<3x8xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> f32, sym_name = "private_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<?xf32>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "func.call"(%arg0) <{callee = @private_func}> : (tensor<?xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> f32, sym_name = "private_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = false}], function_type = (tensor<?xf32>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "func.call"(%arg0) <{callee = @private_func}> : (tensor<?xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
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
  "func.func"() <{function_type = (tensor<?xf32>) -> (tensor<?xf32>, f32), sym_name = "inner_func", sym_visibility = "private"}> ({
  ^bb0(%arg1: tensor<?xf32>):
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "tensor.insert"(%1, %arg1, %2) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %5 = "tensor.extract"(%4, %3) : (tensor<?xf32>, index) -> f32
    "func.return"(%4, %5) : (tensor<?xf32>, f32) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<?xf32>) -> (f32, tensor<?xf32>), sym_name = "call_func_with_non_tensor_return", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0:2 = "func.call"(%arg0) <{callee = @inner_func}> : (tensor<?xf32>) -> (tensor<?xf32>, f32)
    "func.return"(%0#1, %0#0) : (f32, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (tensor<?xf32>, f32), sym_name = "inner_func", sym_visibility = "private"}> ({
  ^bb0(%arg1: tensor<?xf32>):
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "tensor.insert"(%1, %arg1, %2) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %5 = "tensor.extract"(%4, %3) : (tensor<?xf32>, index) -> f32
    "func.return"(%4, %5) : (tensor<?xf32>, f32) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = false}], function_type = (tensor<?xf32>) -> (f32, tensor<?xf32>), sym_name = "call_func_with_non_tensor_return"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0:2 = "func.call"(%arg0) <{callee = @inner_func}> : (tensor<?xf32>) -> (tensor<?xf32>, f32)
    "func.return"(%0#1, %0#0) : (f32, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> f32, sym_name = "f0", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>) -> f32, sym_name = "f1"}> ({
  ^bb0(%arg2: tensor<?xf32>):
    %2 = "func.call"(%arg2) <{callee = @f0}> : (tensor<?xf32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>) -> f32, sym_name = "f2"}> ({
  ^bb0(%arg1: tensor<?xf32>):
    %1 = "func.call"(%arg1) <{callee = @f1}> : (tensor<?xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = false}], function_type = (tensor<?xf32>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "func.call"(%arg0) <{callee = @f2}> : (tensor<?xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "does_not_read", sym_visibility = "private"}> ({
  ^bb0(%arg1: tensor<?xf32>):
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = false}], function_type = (tensor<?xf32>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "func.call"(%arg0) <{callee = @does_not_read}> : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "tensor.extract"(%0, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi32>) -> (), sym_name = "some_external_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = dense<[1, 2, 3, 4]> : tensor<4xi32>}> : () -> tensor<4xi32>
    "func.call"(%0) <{callee = @some_external_func}> : (tensor<4xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi32>) -> (), sym_name = "some_external_func_within_scf_execute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = dense<[1, 2, 3, 4]> : tensor<4xi32>}> : () -> tensor<4xi32>
    "scf.execute_region"() ({
      "func.call"(%0) <{callee = @some_external_func_within_scf_execute}> : (tensor<4xi32>) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (f32, tensor<?xf32>, f32), sym_name = "execute_region_test", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    %3:3 = "scf.execute_region"() ({
      %4 = "tensor.insert"(%1, %arg0, %2) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%0, %4, %1) : (f32, tensor<?xf32>, f32) -> ()
    }) : () -> (f32, tensor<?xf32>, f32)
    "func.return"(%3#0, %3#1, %3#2) : (f32, tensor<?xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_execute_region_not_canonicalized"}> ({
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "scf.execute_region"() <{no_inline}> ({
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0) : (i32) -> ()
    }) : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "some_external_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, index, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "scf_for_with_tensor_insert_slice", sym_visibility = "private"}> ({
  ^bb0(%arg6: tensor<?xf32>, %arg7: tensor<?xf32>, %arg8: tensor<4xf32>, %arg9: index, %arg10: index, %arg11: index):
    %1:2 = "scf.for"(%arg9, %arg10, %arg11, %arg6, %arg7) ({
    ^bb0(%arg12: index, %arg13: tensor<?xf32>, %arg14: tensor<?xf32>):
      %2 = "tensor.insert_slice"(%arg8, %arg13, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      %3 = "tensor.insert_slice"(%arg8, %arg14, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%2, %3) : (tensor<?xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    "func.return"(%1#1, %1#0) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, index, index, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "bar"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<4xf32>, %arg3: index, %arg4: index, %arg5: index):
    %0:2 = "func.call"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{callee = @scf_for_with_tensor_insert_slice}> : (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, index, index, index) -> (tensor<?xf32>, tensor<?xf32>)
    "func.call"(%0#0) <{callee = @some_external_func}> : (tensor<?xf32>) -> ()
    "func.return"(%0#0, %0#1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<64xf32>, tensor<64xf32>, tensor<f32>) -> tensor<f32>, sym_name = "init_and_dot", sym_visibility = "private"}> ({
  ^bb0(%arg6: tensor<64xf32>, %arg7: tensor<64xf32>, %arg8: tensor<f32>):
    %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "linalg.fill"(%11, %arg8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %13 = "linalg.dot"(%arg6, %arg7, %12) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %14 = "arith.mulf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %15 = "arith.addf"(%arg11, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%15) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map, #map1]} : (tensor<64xf32>, tensor<64xf32>, tensor<f32>) -> tensor<f32>
    "func.return"(%13) : (tensor<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<64xf32>
    %4 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<64xf32>
    %5 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<f32>
    %6 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %7 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %8 = "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %9 = "func.call"(%6, %7, %8) <{callee = @init_and_dot}> : (tensor<64xf32>, tensor<64xf32>, tensor<f32>) -> tensor<f32>
    %10 = "tensor.cast"(%9) : (tensor<f32>) -> tensor<*xf32>
    "func.call"(%10) <{callee = @printMemrefF32}> : (tensor<*xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<*xf32>) -> (), sym_name = "printMemrefF32", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "external_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> (), sym_name = "callee"}> ({
  ^bb0(%arg3: tensor<?xf32>, %arg4: tensor<?xf32>, %arg5: tensor<?xf32>):
    "func.call"(%arg3) <{callee = @external_func}> : (tensor<?xf32>) -> ()
    "func.call"(%arg4) <{callee = @external_func}> : (tensor<?xf32>) -> ()
    "func.call"(%arg5) <{callee = @external_func}> : (tensor<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = false}, {bufferization.buffer_layout = #map, bufferization.writable = false}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> (), sym_name = "entry"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<?xf32>):
    "func.call"(%arg0, %arg1, %arg2) <{callee = @callee}> : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "inner_func", sym_visibility = "private"}> ({
  ^bb0(%arg6: tensor<?xf32>):
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "tensor.insert"(%2, %arg6, %3) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index) -> tensor<?xf32>, sym_name = "equivalent_func_arg"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %1 = "func.call"(%arg5) <{callee = @inner_func}> : (tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "inner_func_2"}> ({
  ^bb0(%arg6: tensor<?xf32>):
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "tensor.insert"(%2, %arg6, %3) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index) -> tensor<?xf32>, sym_name = "equivalent_func_arg_2"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %1 = "func.call"(%arg5) <{callee = @inner_func_2}> : (tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%arg5) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}], function_type = (tensor<?xf32>) -> vector<4xf32>, sym_name = "transfer_read"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tensor.cast"(%0) : (tensor<3xf32>) -> tensor<*xf32>
    "func.call"(%1) <{callee = @maybe_writing_func}> : (tensor<*xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<*xf32>) -> (), sym_name = "maybe_writing_func", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "llvm_func", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "call_llvm_func"}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @llvm_func, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index, vector<5xf32>) -> vector<5xf32>, sym_name = "to_buffer_op_unsupported"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<5xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    "test.foo"(%0) : (memref<?xf32>) -> ()
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %arg3, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%2) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "br_in_func"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    "cf.br"(%arg0)[^bb1] : (tensor<5xf32>) -> ()
  ^bb1(%0: tensor<5xf32>):  // pred: ^bb0
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>) -> memref<5xf32>, sym_name = "foo"}> ({
  ^bb0(%arg2: memref<5xf32>):
    %1 = "tensor.empty"() : () -> tensor<5xf32>
    %2 = "func.call"(%1, %arg2) <{callee = @bar}> : (tensor<5xf32>, memref<5xf32>) -> memref<5xf32>
    "func.return"(%2) : (memref<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>, memref<5xf32>) -> memref<5xf32>, sym_name = "bar"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: memref<5xf32>):
    %0 = "func.call"(%arg1) <{callee = @foo}> : (memref<5xf32>) -> memref<5xf32>
    "func.return"(%0) : (memref<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "foo"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "func.call"(%arg0) <{callee = @foo}> : (tensor<5xf32>) -> tensor<5xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.extract"(%arg0, %1) : (tensor<5xf32>, index) -> f32
    "vector.print"(%2) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "foo"}> ({
  ^bb0(%arg1: tensor<5xf32>):
    %1 = "func.call"(%arg1) <{callee = @bar}> : (tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%1) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "bar"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "func.call"(%arg0) <{callee = @foo}> : (tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> tensor<5xf32>, sym_name = "result_type_mismatch"}> ({
  ^bb0(%arg0: i1):
    %0 = "tensor.empty"() : () -> tensor<10xf32>
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 2>}> : (tensor<10xf32>) -> tensor<5xf32>
    "func.return"(%1) : (tensor<5xf32>) -> ()
  ^bb2:  // pred: ^bb0
    %2 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<5xf32>
    "func.return"(%2) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "outer_func"}> ({
  ^bb0(%arg1: tensor<5xf32>):
    "func.return"(%arg1) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "inner_module"}> ({
    "func.func"() <{arg_attrs = [{bufferization.writable = false}], function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "inner_func"}> ({
    ^bb0(%arg0: tensor<5xf32>):
      "func.return"(%arg0) : (tensor<5xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!test.test_tensor<[4, 4], f64>) -> (!test.test_tensor<[4, 8], f64>, !test.test_tensor<[4, 8], f64>), sym_name = "custom_types"}> ({
  ^bb0(%arg0: !test.test_tensor<[4, 4], f64>):
    %0 = "test.dummy_tensor_op"(%arg0) : (!test.test_tensor<[4, 4], f64>) -> !test.test_tensor<[4, 8], f64>
    %1 = "test.create_tensor_op"() : () -> !test.test_tensor<[4, 4], f64>
    %2 = "test.dummy_tensor_op"(%1) : (!test.test_tensor<[4, 4], f64>) -> !test.test_tensor<[4, 8], f64>
    "func.return"(%0, %2) : (!test.test_tensor<[4, 8], f64>, !test.test_tensor<[4, 8], f64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!test.test_tensor<[4, 4], f64>) -> !test.test_tensor<[4, 4], f64>, sym_name = "custom_types_foo"}> ({
  ^bb0(%arg1: !test.test_tensor<[4, 4], f64>):
    %2 = "test.dummy_tensor_op"(%arg1) : (!test.test_tensor<[4, 4], f64>) -> !test.test_tensor<[4, 4], f64>
    "func.return"(%2) : (!test.test_tensor<[4, 4], f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!test.test_tensor<[4, 4], f64>) -> !test.test_tensor<[4, 8], f64>, sym_name = "custom_types_bar"}> ({
  ^bb0(%arg0: !test.test_tensor<[4, 4], f64>):
    %0 = "func.call"(%arg0) <{callee = @custom_types_foo}> : (!test.test_tensor<[4, 4], f64>) -> !test.test_tensor<[4, 4], f64>
    %1 = "test.dummy_tensor_op"(%0) : (!test.test_tensor<[4, 4], f64>) -> !test.test_tensor<[4, 8], f64>
    "func.return"(%1) : (!test.test_tensor<[4, 8], f64>) -> ()
  }) : () -> ()
}) : () -> ()

