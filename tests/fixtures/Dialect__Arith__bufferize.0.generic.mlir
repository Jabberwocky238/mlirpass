"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>, i32) -> (tensor<index>, index), sym_name = "index_cast"}> ({
  ^bb0(%arg0: tensor<i32>, %arg1: i32):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<i32>) -> memref<i32>
    %1 = "arith.index_cast"(%0) : (memref<i32>) -> memref<index>
    %2 = "bufferization.to_tensor"(%1) : (memref<index>) -> tensor<index>
    %3 = "arith.index_cast"(%arg1) : (i32) -> index
    "func.return"(%2, %3) : (tensor<index>, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<7.000000e+00> : tensor<3x4xf32>, sym_name = "__constant_3x4xf32", sym_visibility = "private", type = memref<3x4xf32>}> : () -> ()
  "func.func"() <{function_type = () -> tensor<3x4xf32>, sym_name = "basic"}> ({
    %0 = "memref.get_global"() <{name = @__constant_3x4xf32}> : () -> memref<3x4xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<3x4xf32>) -> tensor<3x4xf32>
    "func.return"(%1) : (tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<7.000000e+00> : tensor<3x4xf32>, sym_name = "__constant_3x4xf32", sym_visibility = "private", type = memref<3x4xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (tensor<3x4xf32>, tensor<3x4xf32>), sym_name = "duplicate_constants"}> ({
    %0 = "memref.get_global"() <{name = @__constant_3x4xf32}> : () -> memref<3x4xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<3x4xf32>) -> tensor<3x4xf32>
    %2 = "memref.get_global"() <{name = @__constant_3x4xf32}> : () -> memref<3x4xf32>
    %3 = "bufferization.to_tensor"(%2) : (memref<3x4xf32>) -> tensor<3x4xf32>
    "func.return"(%1, %3) : (tensor<3x4xf32>, tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<8.000000e+00> : tensor<3x4xf32>, sym_name = "__constant_3x4xf32_0", sym_visibility = "private", type = memref<3x4xf32>}> : () -> ()
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<7.000000e+00> : tensor<3x4xf32>, sym_name = "__constant_3x4xf32", sym_visibility = "private", type = memref<3x4xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (tensor<3x4xf32>, tensor<3x4xf32>), sym_name = "multiple_constants"}> ({
    %0 = "memref.get_global"() <{name = @__constant_3x4xf32}> : () -> memref<3x4xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<3x4xf32>) -> tensor<3x4xf32>
    %2 = "memref.get_global"() <{name = @__constant_3x4xf32_0}> : () -> memref<3x4xf32>
    %3 = "bufferization.to_tensor"(%2) : (memref<3x4xf32>) -> tensor<3x4xf32>
    "func.return"(%1, %3) : (tensor<3x4xf32>, tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "non_tensor"}> ({
    %0 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<f32>, tensor<f32>) -> tensor<f32>, sym_name = "select"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<f32>, %arg2: tensor<f32>):
    %0 = "bufferization.to_buffer"(%arg2) : (tensor<f32>) -> memref<f32>
    %1 = "bufferization.to_buffer"(%arg1) : (tensor<f32>) -> memref<f32>
    %2 = "arith.select"(%arg0, %1, %0) : (i1, memref<f32>, memref<f32>) -> memref<f32>
    %3 = "bufferization.to_tensor"(%2) : (memref<f32>) -> tensor<f32>
    "func.return"(%3) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
