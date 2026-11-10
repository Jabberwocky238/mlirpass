"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "private_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> (), sym_name = "private_func_2d", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "empty_func"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xi32, strided<[?], offset: ?>>) -> f32, sym_name = "external_func_with_return_val", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32, strided<[?], offset: ?>>, f32), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "call_to_unknown_tensor_returning_func"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0:3 = "func.call"(%arg0) <{callee = @foo}> : (memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32, strided<[?], offset: ?>>, f32)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> memref<2x?xf32, strided<[10, 1], offset: ?>>, sym_name = "return_extract_slice"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<20x10xf32>
    %1 = "memref.subview"(%0, %arg0, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<20x10xf32>, index, index, index) -> memref<2x?xf32, strided<[10, 1], offset: ?>>
    "func.return"(%1) : (memref<2x?xf32, strided<[10, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x8xf16, strided<[?, ?], offset: ?>>) -> memref<3x8xf16, strided<[?, ?], offset: ?>>, sym_name = "foo"}> ({
  ^bb0(%arg1: memref<3x8xf16, strided<[?, ?], offset: ?>>):
    "func.return"(%arg1) : (memref<3x8xf16, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x8xf16, strided<[?, ?], offset: ?>>) -> memref<3x8xf16, strided<[?, ?], offset: ?>>, sym_name = "call_extract_slice"}> ({
  ^bb0(%arg0: memref<4x8xf16, strided<[?, ?], offset: ?>>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1, 0>, static_sizes = array<i64: 3, 8>, static_strides = array<i64: 1, 1>}> : (memref<4x8xf16, strided<[?, ?], offset: ?>>) -> memref<3x8xf16, strided<[?, ?], offset: ?>>
    %1 = "func.call"(%0) <{callee = @foo}> : (memref<3x8xf16, strided<[?, ?], offset: ?>>) -> memref<3x8xf16, strided<[?, ?], offset: ?>>
    "func.return"(%1) : (memref<3x8xf16, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "private_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "func.call"(%arg0) <{callee = @private_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "private_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %4 = "func.call"(%3) <{callee = @private_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<10xf32>) -> (), sym_name = "func_without_tensor_args"}> ({
  ^bb0(%arg0: vector<10xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "vector.transfer_write"(%arg0, %2, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<10xf32>, memref<10xf32>, index) -> ()
    %3 = "vector.transfer_read"(%2, %1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<10xf32>, index, f32) -> vector<11xf32>
    "vector.print"(%3) <{punctuation = #vector.punctuation<newline>}> : (vector<11xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "inner_func", sym_visibility = "private"}> ({
  ^bb0(%arg1: memref<?xf32, strided<[?], offset: ?>>):
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%1, %arg1, %2) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    %4 = "memref.load"(%arg1, %3) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "call_func_with_non_tensor_return", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "func.call"(%arg0) <{callee = @inner_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "inner_func", sym_visibility = "private"}> ({
  ^bb0(%arg1: memref<?xf32, strided<[?], offset: ?>>):
    %5 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%5, %arg1, %6) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    %8 = "memref.load"(%arg1, %7) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%8) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32, strided<[?], offset: ?>>), sym_name = "call_func_with_non_tensor_return"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %4 = "func.call"(%3) <{callee = @inner_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    "func.return"(%4, %3) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "f0", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "f1"}> ({
  ^bb0(%arg2: memref<?xf32, strided<[?], offset: ?>>):
    %6 = "func.call"(%arg2) <{callee = @f0}> : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "f2"}> ({
  ^bb0(%arg1: memref<?xf32, strided<[?], offset: ?>>):
    %5 = "func.call"(%arg1) <{callee = @f1}> : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %4 = "func.call"(%3) <{callee = @f2}> : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "does_not_read", sym_visibility = "private"}> ({
  ^bb0(%arg1: memref<?xf32, strided<[?], offset: ?>>):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "linalg.fill"(%6, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> f32, sym_name = "main"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %3 = "memref.alloc"(%2) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %4 = "memref.cast"(%3) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.call"(%4) <{callee = @does_not_read}> : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    %5 = "memref.load"(%4, %0) <{invariant = false, nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<[1, 2, 3, 4]> : tensor<4xi32>, sym_name = "__constant_4xi32", sym_visibility = "private", type = memref<4xi32>}> : () -> ()
  "func.func"() <{function_type = (memref<4xi32, strided<[?], offset: ?>>) -> (), sym_name = "some_external_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.get_global"() <{name = @__constant_4xi32}> : () -> memref<4xi32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    "memref.copy"(%0, %1) : (memref<4xi32>, memref<4xi32>) -> ()
    %2 = "memref.cast"(%1) : (memref<4xi32>) -> memref<4xi32, strided<[?], offset: ?>>
    "func.call"(%2) <{callee = @some_external_func}> : (memref<4xi32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<[1, 2, 3, 4]> : tensor<4xi32>, sym_name = "__constant_4xi32", sym_visibility = "private", type = memref<4xi32>}> : () -> ()
  "func.func"() <{function_type = (memref<4xi32, strided<[?], offset: ?>>) -> (), sym_name = "some_external_func_within_scf_execute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.get_global"() <{name = @__constant_4xi32}> : () -> memref<4xi32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    "memref.copy"(%0, %1) : (memref<4xi32>, memref<4xi32>) -> ()
    %2 = "memref.cast"(%1) : (memref<4xi32>) -> memref<4xi32, strided<[?], offset: ?>>
    "func.call"(%2) <{callee = @some_external_func_within_scf_execute}> : (memref<4xi32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (f32, f32), sym_name = "execute_region_test", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    "memref.store"(%1, %arg0, %2) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    "func.return"(%0, %1) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_execute_region_not_canonicalized"}> ({
    "scf.execute_region"() <{no_inline}> ({
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "some_external_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>, index, index, index) -> (), sym_name = "scf_for_with_tensor_insert_slice", sym_visibility = "private"}> ({
  ^bb0(%arg6: memref<?xf32, strided<[?], offset: ?>>, %arg7: memref<?xf32, strided<[?], offset: ?>>, %arg8: memref<4xf32, strided<[?], offset: ?>>, %arg9: index, %arg10: index, %arg11: index):
    "scf.for"(%arg9, %arg10, %arg11) ({
    ^bb0(%arg12: index):
      %4 = "memref.subview"(%arg6, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<4xf32, strided<[?], offset: ?>>
      "memref.copy"(%arg8, %4) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
      %5 = "memref.subview"(%arg7, %arg12) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> memref<4xf32, strided<[?], offset: ?>>
      "memref.copy"(%arg8, %5) : (memref<4xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>, index, index, index) -> (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>), sym_name = "bar"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "func.call"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{callee = @scf_for_with_tensor_insert_slice}> : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>, index, index, index) -> ()
    %1 = "memref.dim"(%arg1, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg1, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %3 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.call"(%3) <{callee = @some_external_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg1, %arg0) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>, memref<f32, strided<[], offset: ?>>) -> (), sym_name = "init_and_dot", sym_visibility = "private"}> ({
  ^bb0(%arg6: memref<64xf32, strided<[?], offset: ?>>, %arg7: memref<64xf32, strided<[?], offset: ?>>, %arg8: memref<f32, strided<[], offset: ?>>):
    %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "linalg.fill"(%10, %arg8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, memref<f32, strided<[], offset: ?>>) -> ()
    "linalg.dot"(%arg6, %arg7, %arg8) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %11 = "arith.mulf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %12 = "arith.addf"(%arg11, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%12) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map, #map1]} : (memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>, memref<f32, strided<[], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, memref<64xf32>) -> ()
    "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<64xf32>) -> ()
    "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, memref<f32>) -> ()
    %6 = "memref.cast"(%3) : (memref<64xf32>) -> memref<64xf32, strided<[?], offset: ?>>
    %7 = "memref.cast"(%4) : (memref<64xf32>) -> memref<64xf32, strided<[?], offset: ?>>
    %8 = "memref.cast"(%5) : (memref<f32>) -> memref<f32, strided<[], offset: ?>>
    "func.call"(%6, %7, %8) <{callee = @init_and_dot}> : (memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>, memref<f32, strided<[], offset: ?>>) -> ()
    %9 = "memref.cast"(%8) : (memref<f32, strided<[], offset: ?>>) -> memref<*xf32>
    "func.call"(%9) <{callee = @printMemrefF32}> : (memref<*xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "printMemrefF32", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "external_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "callee"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: memref<?xf32, strided<[?], offset: ?>>, %arg5: memref<?xf32, strided<[?], offset: ?>>):
    %10 = "memref.cast"(%arg3) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.call"(%10) <{callee = @external_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.call"(%arg4) <{callee = @external_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.call"(%arg5) <{callee = @external_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "entry"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32>, memref<?xf32>) -> ()
    %3 = "memref.dim"(%arg1, %0) : (memref<?xf32>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg1, %4) : (memref<?xf32>, memref<?xf32>) -> ()
    %5 = "memref.dim"(%arg2, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %6 = "memref.alloc"(%5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg2, %6) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    %7 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32>
    %8 = "memref.cast"(%4) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %9 = "memref.cast"(%6) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.call"(%7, %8, %9) <{callee = @callee}> : (memref<?xf32>, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "inner_func", sym_visibility = "private"}> ({
  ^bb0(%arg6: memref<?xf32, strided<[?], offset: ?>>):
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%1, %arg6, %2) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, index, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "equivalent_func_arg"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: memref<?xf32, strided<[?], offset: ?>>):
      "func.call"(%arg5) <{callee = @inner_func}> : (memref<?xf32, strided<[?], offset: ?>>) -> ()
      "scf.yield"(%arg5) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    }) : (index, index, index, memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    "func.return"(%0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "inner_func_2"}> ({
  ^bb0(%arg5: memref<?xf32, strided<[?], offset: ?>>):
    %5 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%5, %arg5, %6) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    "func.return"(%arg5) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, index, index) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "equivalent_func_arg_2"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.for"(%arg1, %arg2, %arg3) ({
    ^bb0(%arg4: index):
      %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
      %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
      %3 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
      %4 = "func.call"(%3) <{callee = @inner_func_2}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> vector<4xf32>, sym_name = "transfer_read"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32, strided<[?], offset: ?>>, index, f32) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf32>, sym_name = "__constant_3xf32", sym_visibility = "private", type = memref<3xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.get_global"() <{name = @__constant_3xf32}> : () -> memref<3xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf32>
    "memref.copy"(%0, %1) : (memref<3xf32>, memref<3xf32>) -> ()
    %2 = "memref.cast"(%1) : (memref<3xf32>) -> memref<*xf32>
    "func.call"(%2) <{callee = @maybe_writing_func}> : (memref<*xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "maybe_writing_func", sym_visibility = "private"}> ({
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
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, index, index, index, vector<5xf32>) -> vector<5xf32>, sym_name = "to_buffer_op_unsupported"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<5xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %3 = "memref.alloc"(%2) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %3) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "test.foo"(%3) : (memref<?xf32>) -> ()
    %4 = "vector.transfer_read"(%arg0, %arg3, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32, strided<[?], offset: ?>>, index, f32) -> vector<5xf32>
    "func.return"(%4) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "br_in_func"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>):
    "func.return"(%arg0) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>) -> memref<5xf32>, sym_name = "foo"}> ({
  ^bb0(%arg2: memref<5xf32>):
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %2 = "memref.cast"(%1) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    %3 = "func.call"(%2, %arg2) <{callee = @bar}> : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> memref<5xf32>
    "func.return"(%3) : (memref<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> memref<5xf32>, sym_name = "bar"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: memref<5xf32>):
    %0 = "func.call"(%arg1) <{callee = @foo}> : (memref<5xf32>) -> memref<5xf32>
    "func.return"(%0) : (memref<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "foo"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%arg0, %1) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    %2 = "memref.cast"(%1) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    %3 = "func.call"(%2) <{callee = @foo}> : (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    %4 = "memref.load"(%arg0, %0) <{invariant = false, nontemporal = false}> : (memref<5xf32, strided<[?], offset: ?>>, index) -> f32
    "vector.print"(%4) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
    "func.return"(%3) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "foo"}> ({
  ^bb0(%arg1: memref<5xf32, strided<[?], offset: ?>>):
    %1 = "func.call"(%arg1) <{callee = @bar}> : (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"(%1) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "bar"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>):
    %0 = "func.call"(%arg0) <{callee = @foo}> : (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"(%0) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "result_type_mismatch"}> ({
  ^bb0(%arg0: i1):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 2>}> : (memref<10xf32>) -> memref<5xf32, strided<[2]>>
    %2 = "memref.cast"(%1) : (memref<5xf32, strided<[2]>>) -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"(%2) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  ^bb2:  // pred: ^bb0
    %3 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (memref<10xf32>) -> memref<5xf32, strided<[1], offset: 2>>
    %4 = "memref.cast"(%3) : (memref<5xf32, strided<[1], offset: 2>>) -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"(%4) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>, sym_name = "outer_func"}> ({
  ^bb0(%arg1: memref<5xf32, strided<[?], offset: ?>>):
    "func.return"(%arg1) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
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
  "func.func"() <{function_type = (memref<64x20x40xf32, strided<[?, ?, ?], offset: ?>>) -> memref<64x20x40xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "ranked_return_via_unranked_call"}> ({
  ^bb0(%arg0: memref<64x20x40xf32, strided<[?, ?, ?], offset: ?>>):
    %0 = "memref.cast"(%arg0) : (memref<64x20x40xf32, strided<[?, ?, ?], offset: ?>>) -> memref<*xf32>
    %1 = "func.call"(%0) <{callee = @relu_unranked}> : (memref<*xf32>) -> memref<*xf32>
    %2 = "memref.cast"(%1) : (memref<*xf32>) -> memref<64x20x40xf32, strided<[?, ?, ?], offset: ?>>
    "func.return"(%2) : (memref<64x20x40xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xf32>) -> memref<*xf32>, sym_name = "relu_unranked", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

