"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.access = "read-write", bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "buffer_forwarding_conflict"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> {__inplace_operands_attr__ = ["false", "none"]} : (tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) {__inplace_operands_attr__ = ["none", "true"]} : (f32, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert_slice"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> {__inplace_operands_attr__ = ["true", "false", "none"]} : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %4 = "tensor.insert_slice"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> {__inplace_operands_attr__ = ["true", "true", "none"]} : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%3, %4) {__equivalent_func_args__ = [-1, 0], __inplace_operands_attr__ = ["true", "true"]} : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.access = "read-write", bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "buffer_forwarding_no_conflict"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> {__inplace_operands_attr__ = ["true", "none"]} : (tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) {__inplace_operands_attr__ = ["none", "true"]} : (f32, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert_slice"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> {__inplace_operands_attr__ = ["true", "true", "none"]} : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%3, %3) {__equivalent_func_args__ = [0, 0], __inplace_operands_attr__ = ["true", "true"]} : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.access = "read-write", bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "buffer_forwarding_conflict_with_different_element_type"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> {__inplace_operands_attr__ = ["true", "none"]} : (tensor<?xf32>, index) -> tensor<?xf32>
    %1 = "bufferization.alloc_tensor"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %2 = "bufferization.alloc_tensor"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xbf16>
    %3 = "linalg.copy"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: bf16):
      %7 = "arith.truncf"(%arg4) : (f32) -> bf16
      "linalg.yield"(%7) : (bf16) -> ()
    }) {__inplace_operands_attr__ = ["true", "true"]} : (tensor<?xf32>, tensor<?xbf16>) -> tensor<?xbf16>
    %4 = "linalg.copy"(%3, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: bf16, %arg3: f32):
      %6 = "arith.extf"(%arg2) : (bf16) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) {__inplace_operands_attr__ = ["true", "true"]} : (tensor<?xbf16>, tensor<?xf32>) -> tensor<?xf32>
    %5 = "tensor.insert_slice"(%4, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> {__inplace_operands_attr__ = ["true", "true", "none"]} : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%5, %5) {__equivalent_func_args__ = [0, 0], __inplace_operands_attr__ = ["true", "true"]} : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

