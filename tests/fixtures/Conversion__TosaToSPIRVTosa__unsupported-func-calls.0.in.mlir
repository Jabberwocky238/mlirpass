"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> tensor<1xi8>, sym_name = "direct_call"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "func.call"(%arg0) <{callee = @direct_call}> : (tensor<1xi8>) -> tensor<1xi8>
    "func.return"(%0) : (tensor<1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> tensor<1xi8>, sym_name = "indirect_call"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "func.constant"() <{value = @indirect_call}> : () -> ((tensor<1xi8>) -> tensor<1xi8>)
    %1 = "func.call_indirect"(%0, %arg0) : ((tensor<1xi8>) -> tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    "func.return"(%1) : (tensor<1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> tensor<1xi8>, sym_name = "nested_func"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    "builtin.module"() ({
      "func.func"() <{function_type = (tensor<1xi8>) -> tensor<1xi8>, sym_name = "nested"}> ({
      ^bb0(%arg1: tensor<1xi8>):
        "func.return"(%arg1) : (tensor<1xi8>) -> ()
      }) : () -> ()
    }) : () -> ()
    "func.return"(%arg0) : (tensor<1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

