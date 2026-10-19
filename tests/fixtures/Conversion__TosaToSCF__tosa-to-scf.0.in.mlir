"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>) -> tensor<i32>, sym_name = "while_test"}> ({
  ^bb0(%arg0: tensor<i32>):
    %0 = "tosa.while_loop"(%arg0) ({
    ^bb0(%arg2: tensor<i32>):
      %3 = "tosa.const"() <{values = dense<3> : tensor<i32>}> : () -> tensor<i32>
      %4 = "tosa.greater_equal"(%3, %arg2) : (tensor<i32>, tensor<i32>) -> tensor<i1>
      "tosa.yield"(%4) : (tensor<i1>) -> ()
    }, {
    ^bb0(%arg1: tensor<i32>):
      %1 = "tosa.const"() <{values = dense<1> : tensor<i32>}> : () -> tensor<i32>
      %2 = "tosa.add"(%arg1, %1) : (tensor<i32>, tensor<i32>) -> tensor<i32>
      "tosa.yield"(%2) : (tensor<i32>) -> ()
    }) : (tensor<i32>) -> tensor<i32>
    "func.return"(%0) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>, tensor<i1>) -> tensor<f32>, sym_name = "if_test"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>, %arg2: tensor<i1>):
    %0 = "tosa.cond_if"(%arg2) ({
      "tosa.yield"(%arg0) : (tensor<f32>) -> ()
    }, {
      "tosa.yield"(%arg1) : (tensor<f32>) -> ()
    }) : (tensor<i1>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x7x5xi32>, tensor<3x6xi32>, tensor<3x6x5xi32>) -> tensor<3x7x5xi32>, sym_name = "scatter_test"}> ({
  ^bb0(%arg0: tensor<3x7x5xi32>, %arg1: tensor<3x6xi32>, %arg2: tensor<3x6x5xi32>):
    %0 = "tosa.scatter"(%arg0, %arg1, %arg2) : (tensor<3x7x5xi32>, tensor<3x6xi32>, tensor<3x6x5xi32>) -> tensor<3x7x5xi32>
    "func.return"(%0) : (tensor<3x7x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

