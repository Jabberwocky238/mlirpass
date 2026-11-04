"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<f32>, sym_name = "different_before_after_args"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<f32>}> : () -> tensor<f32>
    %2 = "scf.while"(%0) ({
    ^bb0(%arg1: i1):
      "scf.condition"(%0, %1) : (i1, tensor<f32>) -> ()
    }, {
    ^bb0(%arg0: tensor<f32>):
      "scf.yield"(%0) : (i1) -> ()
    }) : (i1) -> tensor<f32>
    "func.return"(%2) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

