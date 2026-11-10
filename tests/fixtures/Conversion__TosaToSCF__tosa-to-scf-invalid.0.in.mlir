"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xi32>, tensor<*xi32>, tensor<*xi32>) -> tensor<*xi32>, sym_name = "scatter_unranked"}> ({
  ^bb0(%arg0: tensor<*xi32>, %arg1: tensor<*xi32>, %arg2: tensor<*xi32>):
    %0 = "tosa.scatter"(%arg0, %arg1, %arg2) : (tensor<*xi32>, tensor<*xi32>, tensor<*xi32>) -> tensor<*xi32>
    "func.return"(%0) : (tensor<*xi32>) -> ()
  }) : () -> ()
}) : () -> ()

