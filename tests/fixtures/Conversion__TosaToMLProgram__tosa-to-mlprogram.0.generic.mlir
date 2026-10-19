"builtin.module"() ({
  "ml_program.global"() <{is_mutable, sym_name = "var_x", sym_visibility = "private", type = tensor<1xf32>, value = dense<7.000000e+00> : tensor<1xf32>}> : () -> ()
  "func.func"() <{function_type = (tensor<1xf32>) -> tensor<1xf32>, sym_name = "test_stateful_ops"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    "ml_program.global_store"(%arg0) <{global = @var_x}> : (tensor<1xf32>) -> ()
    %0 = "ml_program.global_load"() <{global = @var_x}> : () -> tensor<1xf32>
    "func.return"(%0) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "ml_program.global"() <{is_mutable, sym_name = "var_x", sym_visibility = "private", type = tensor<f32>}> : () -> ()
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "test_stateful_ops"}> ({
  ^bb0(%arg0: tensor<f32>):
    "ml_program.global_store"(%arg0) <{global = @var_x}> : (tensor<f32>) -> ()
    %0 = "ml_program.global_load"() <{global = @var_x}> : () -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

