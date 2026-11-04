"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<128xf32>, sym_name = "alloc_tesor_with_space_no_encoding"}> ({
    %0 = "bufferization.alloc_tensor"() <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<128xf32>
    "func.return"(%0) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<128xf32, 1 : i64>, sym_name = "alloc_tesor_with_space_and_cast"}> ({
    %0 = "bufferization.alloc_tensor"() <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<128xf32>
    %1 = "tensor.cast"(%0) : (tensor<128xf32>) -> tensor<128xf32, 1 : i64>
    "func.return"(%1) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<128xf32, 1 : i64>, sym_name = "alloc_tesor_with_space_with_encoding"}> ({
    %0 = "bufferization.alloc_tensor"() <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<128xf32, 1 : i64>
    "func.return"(%0) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32>) -> tensor<128xf32>, sym_name = "alloc_tesor_copy_from_default_space"}> ({
  ^bb0(%arg0: tensor<128xf32>):
    %0 = "bufferization.alloc_tensor"(%arg0) <{memory_space = 1 : i64, operandSegmentSizes = array<i32: 0, 1, 0>}> : (tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%0) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 2 : i64>, sym_name = "alloc_tesor_copy_from_non_default_space"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>):
    %0 = "bufferization.alloc_tensor"(%arg0) <{memory_space = 2 : i64, operandSegmentSizes = array<i32: 0, 1, 0>}> : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
    %1 = "tensor.cast"(%0) : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 2 : i64>
    "func.return"(%1) : (tensor<128xf32, 2 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>, tensor<4xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>, sym_name = "alloc_tesor_copy_from_non_default_space_no_cast"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>, %arg1: tensor<4xf32, 1 : i64>):
    %0 = "bufferization.alloc_tensor"(%arg0) <{memory_space = 2 : i64, operandSegmentSizes = array<i32: 0, 1, 0>}> : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
    %1 = "tensor.insert_slice"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32, 1 : i64>, tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
    "func.return"(%0) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 2 : i64>, sym_name = "materialize_in_destination"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>):
    %0 = "bufferization.alloc_tensor"() <{memory_space = 2 : i64, operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<128xf32, 2 : i64>
    %1 = "bufferization.materialize_in_destination"(%arg0, %0) : (tensor<128xf32, 1 : i64>, tensor<128xf32, 2 : i64>) -> tensor<128xf32, 2 : i64>
    "func.return"(%1) : (tensor<128xf32, 2 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

