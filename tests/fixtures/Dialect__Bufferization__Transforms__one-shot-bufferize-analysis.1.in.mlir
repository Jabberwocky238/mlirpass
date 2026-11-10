"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> f32, sym_name = "unknown_op_aliasing"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "tensor.empty"() : () -> tensor<10xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    %2 = "dummy.dummy_op"(%1) : (tensor<10xf32>) -> tensor<10xf32>
    %3 = "linalg.fill"(%arg1, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    %4 = "tensor.extract"(%2, %arg2) : (tensor<10xf32>, index) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unknown_op_bbarg_aliasing"}> ({
    %0 = "tensor.empty"() : () -> tensor<7xf32>
    "dummy.dummy_op"(%0) ({
    ^bb0(%arg0: tensor<7xf32>):
    }) : (tensor<7xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> f32, sym_name = "unknown_op_writing"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "tensor.empty"() : () -> tensor<10xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    "dummy.dummy_op"(%1) : (tensor<10xf32>) -> ()
    %2 = "tensor.extract"(%1, %arg2) : (tensor<10xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index) -> f32, sym_name = "read_of_undef_is_not_a_conflict"}> ({
  ^bb0(%arg0: f32, %arg1: index):
    %0 = "tensor.empty"() : () -> tensor<10xf32>
    %1 = "tensor.insert"(%arg0, %0, %arg1) : (f32, tensor<10xf32>, index) -> tensor<10xf32>
    %2 = "tensor.extract"(%0, %arg1) : (tensor<10xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index) -> f32, sym_name = "read_of_alloc_tensor_is_not_a_conflict"}> ({
  ^bb0(%arg0: f32, %arg1: index):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    %1 = "tensor.insert"(%arg0, %0, %arg1) : (f32, tensor<10xf32>, index) -> tensor<10xf32>
    %2 = "tensor.extract"(%0, %arg1) : (tensor<10xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, f32) -> f32, sym_name = "to_buffer_not_read_only"}> ({
  ^bb0(%arg0: index, %arg1: f32):
    %0 = "tensor.generate"() ({
    ^bb0(%arg2: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : () -> tensor<5xf32>
    %1 = "bufferization.to_buffer"(%0) : (tensor<5xf32>) -> memref<5xf32>
    %2 = "tensor.extract"(%0, %arg0) : (tensor<5xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, f32) -> f32, sym_name = "to_buffer_read_only"}> ({
  ^bb0(%arg0: index, %arg1: f32):
    %0 = "tensor.generate"() ({
    ^bb0(%arg2: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : () -> tensor<5xf32>
    %1 = "bufferization.to_buffer"(%0) <{read_only}> : (tensor<5xf32>) -> memref<5xf32>
    %2 = "tensor.extract"(%0, %arg0) : (tensor<5xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "bbarg_of_unknown_op"}> ({
  ^bb0(%arg0: f32):
    %0 = "tensor.empty"() : () -> tensor<10xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    "dummy.dummy_op"(%1) ({
    ^bb0(%arg1: tensor<10xf32>):
    }) : (tensor<10xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "bbarg_of_unknown_op_2"}> ({
  ^bb0(%arg0: f32):
    %0 = "tensor.empty"() : () -> tensor<10xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<10xf32>) -> tensor<10xf32>
    "dummy.dummy_op"(%1) ({
    ^bb0(%arg1: tensor<10xf32>):
      "dummy.another_op"(%arg1) : (tensor<10xf32>) -> ()
    }) : (tensor<10xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index, index) -> tensor<5xf32>, sym_name = "materialize_in_destination_aliasing"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.empty"(%arg3) : (index) -> tensor<?xf32>
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<5xf32>
    %2 = "tensor.extract_slice"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<5xf32>
    %3 = "bufferization.materialize_in_destination"(%1, %2) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%3) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "materialize_in_destination"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "tensor.empty"(%arg1) : (index) -> tensor<?xf32>
    %1 = "bufferization.materialize_in_destination"(%0, %0) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi32>) -> (tensor<4xi32>, tensor<4xi32>), sym_name = "shorter_inplace_attr"}> ({
  ^bb0(%arg0: tensor<4xi32>):
    "func.return"(%arg0, %arg0) {__inplace_operands_attr__ = ["false"]} : (tensor<4xi32>, tensor<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

