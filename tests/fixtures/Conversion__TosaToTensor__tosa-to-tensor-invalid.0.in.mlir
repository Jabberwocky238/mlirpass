"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<*xf32>, sym_name = "slice_resultType_unranked"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<2> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %2 = "tosa.slice"(%arg0, %0, %1) : (tensor<?xf32>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<*xf32>
    "func.return"(%2) : (tensor<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

