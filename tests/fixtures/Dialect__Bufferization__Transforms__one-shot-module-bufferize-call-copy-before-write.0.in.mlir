"builtin.module"() ({
  "func.func"() <{function_type = (tensor<64xf32>) -> (), sym_name = "callee", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64xf32>) -> (), sym_name = "caller"}> ({
  ^bb0(%arg0: tensor<64xf32>):
    "func.call"(%arg0) <{callee = @callee}> : (tensor<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

