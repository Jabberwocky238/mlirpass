"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<10xf32>, sym_name = "create_tensor"}> ({
    %2 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10xf32>
    "func.return"(%2) : (tensor<10xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> f32, sym_name = "caller"}> ({
  ^bb0(%arg0: index):
    %0 = "func.call"() <{callee = @create_tensor}> : () -> tensor<10xf32>
    %1 = "tensor.extract"(%0, %arg0) : (tensor<10xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "return_slice"}> ({
  ^bb0(%arg5: tensor<?xf32>, %arg6: index):
    %5 = "tensor.extract_slice"(%arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 4>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%5) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> (f32, f32), sym_name = "main"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "func.call"(%arg0, %arg1) <{callee = @return_slice}> : (tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.extract"(%1, %arg2) : (tensor<?xf32>, index) -> f32
    %4 = "tensor.extract"(%2, %arg2) : (tensor<?xf32>, index) -> f32
    "func.return"(%3, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "return_arg", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    "func.return"(%arg0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

