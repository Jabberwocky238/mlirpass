"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<128xf32>, sym_name = "alloc_tesor_with_space_no_encoding"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 1>
    %1 = "bufferization.to_tensor"(%0) : (memref<128xf32, 1>) -> tensor<128xf32>
    "func.return"(%1) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<128xf32, 1 : i64>, sym_name = "alloc_tesor_with_space_and_cast"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 1>
    %1 = "bufferization.to_tensor"(%0) : (memref<128xf32, 1>) -> tensor<128xf32, 1 : i64>
    "func.return"(%1) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<128xf32, 1 : i64>, sym_name = "alloc_tesor_with_space_with_encoding"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 1>
    %1 = "bufferization.to_tensor"(%0) : (memref<128xf32, 1>) -> tensor<128xf32, 1 : i64>
    "func.return"(%1) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32>) -> tensor<128xf32>, sym_name = "alloc_tesor_copy_from_default_space"}> ({
  ^bb0(%arg0: tensor<128xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<128xf32>) -> memref<128xf32, strided<[?], offset: ?>>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 1>
    "memref.copy"(%0, %1) : (memref<128xf32, strided<[?], offset: ?>>, memref<128xf32, 1>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<128xf32, 1>) -> tensor<128xf32>
    "func.return"(%2) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 2 : i64>, sym_name = "alloc_tesor_copy_from_non_default_space"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<128xf32, 1 : i64>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 2>
    "memref.copy"(%0, %1) : (memref<128xf32, strided<[?], offset: ?>, 1>, memref<128xf32, 2>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<128xf32, 2>) -> tensor<128xf32, 2 : i64>
    "func.return"(%2) : (tensor<128xf32, 2 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>, tensor<4xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>, sym_name = "alloc_tesor_copy_from_non_default_space_no_cast"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>, %arg1: tensor<4xf32, 1 : i64>):
    %0 = "bufferization.to_buffer"(%arg1) : (tensor<4xf32, 1 : i64>) -> memref<4xf32, strided<[?], offset: ?>, 1>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<128xf32, 1 : i64>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %2 = "bufferization.to_buffer"(%arg0) : (tensor<128xf32, 1 : i64>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 2>
    "memref.copy"(%2, %3) : (memref<128xf32, strided<[?], offset: ?>, 1>, memref<128xf32, 2>) -> ()
    %4 = "bufferization.to_tensor"(%3) : (memref<128xf32, 2>) -> tensor<128xf32, 1 : i64>
    %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 1>
    "memref.copy"(%1, %5) : (memref<128xf32, strided<[?], offset: ?>, 1>, memref<128xf32, 1>) -> ()
    %6 = "memref.subview"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<128xf32, 1>) -> memref<4xf32, strided<[1]>, 1>
    "memref.copy"(%0, %6) : (memref<4xf32, strided<[?], offset: ?>, 1>, memref<4xf32, strided<[1]>, 1>) -> ()
    "func.return"(%4) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 2 : i64>, sym_name = "materialize_in_destination"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<128xf32, 1 : i64>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 2>
    "memref.copy"(%0, %1) : (memref<128xf32, strided<[?], offset: ?>, 1>, memref<128xf32, 2>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<128xf32, 2>) -> tensor<128xf32, 2 : i64>
    "func.return"(%2) : (tensor<128xf32, 2 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

