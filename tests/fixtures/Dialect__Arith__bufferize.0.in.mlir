"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>, i32) -> (tensor<index>, index), sym_name = "index_cast"}> ({
  ^bb0(%arg0: tensor<i32>, %arg1: i32):
    %0 = "arith.index_cast"(%arg0) : (tensor<i32>) -> tensor<index>
    %1 = "arith.index_cast"(%arg1) : (i32) -> index
    "func.return"(%0, %1) : (tensor<index>, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3x4xf32>, sym_name = "basic"}> ({
    %0 = "arith.constant"() <{value = dense<7.000000e+00> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    "func.return"(%0) : (tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (tensor<3x4xf32>, tensor<3x4xf32>), sym_name = "duplicate_constants"}> ({
    %0 = "arith.constant"() <{value = dense<7.000000e+00> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    %1 = "arith.constant"() <{value = dense<7.000000e+00> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    "func.return"(%0, %1) : (tensor<3x4xf32>, tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (tensor<3x4xf32>, tensor<3x4xf32>), sym_name = "multiple_constants"}> ({
    %0 = "arith.constant"() <{value = dense<7.000000e+00> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    %1 = "arith.constant"() <{value = dense<8.000000e+00> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    "func.return"(%0, %1) : (tensor<3x4xf32>, tensor<3x4xf32>) -> ()
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
    %0 = "arith.select"(%arg0, %arg1, %arg2) : (i1, tensor<f32>, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xi1>, tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>, sym_name = "elementwise_select"}> ({
  ^bb0(%arg0: tensor<5xi1>, %arg1: tensor<5xi32>, %arg2: tensor<5xi32>):
    %0 = "arith.select"(%arg0, %arg1, %arg2) : (tensor<5xi1>, tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    "func.return"(%0) : (tensor<5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

