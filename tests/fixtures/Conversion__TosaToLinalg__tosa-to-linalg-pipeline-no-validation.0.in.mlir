"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>) -> tensor<2x3xf32>, sym_name = "simple_abs"}> ({
  ^bb0(%arg0: tensor<2x3xf32>):
    %0 = "tosa.abs"(%arg0) : (tensor<2x3xf32>) -> tensor<2x3xf32>
    "func.return"(%0) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

