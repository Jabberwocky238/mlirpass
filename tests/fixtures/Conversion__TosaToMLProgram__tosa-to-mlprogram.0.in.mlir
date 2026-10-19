"builtin.module"() ({
  "tosa.variable"() <{initial_value = dense<7.000000e+00> : tensor<1xf32>, sym_name = "var_x", type = f32, var_shape = dense<1> : tensor<1xindex>}> : () -> ()
  "func.func"() <{function_type = (tensor<1xf32>) -> tensor<1xf32>, sym_name = "test_stateful_ops"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    "tosa.variable_write"(%arg0) <{name = "var_x"}> : (tensor<1xf32>) -> ()
    %0 = "tosa.variable_read"() <{name = "var_x"}> : () -> tensor<1xf32>
    "func.return"(%0) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tosa.variable"() <{sym_name = "var_x", type = f32, var_shape = dense<> : tensor<0xindex>}> : () -> ()
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "test_stateful_ops"}> ({
  ^bb0(%arg0: tensor<f32>):
    "tosa.variable_write"(%arg0) <{name = "var_x"}> : (tensor<f32>) -> ()
    %0 = "tosa.variable_read"() <{name = "var_x"}> : () -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

