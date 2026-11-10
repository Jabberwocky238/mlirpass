"builtin.module"() ({
  "gpu.module"() <{sym_name = "random_container"}> ({
    "func.func"() <{function_type = (tensor<1xi8>) -> tensor<1xi8>, sym_name = "nested"}> ({
    ^bb0(%arg0: tensor<1xi8>):
      "func.return"(%arg0) : (tensor<1xi8>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "random_container"}> ({
  "builtin.module"() <{sym_name = "yet_anther_random_container"}> ({
    "gpu.module"() <{sym_name = "another_random_container"}> ({
      "func.func"() <{function_type = (tensor<1xi8>) -> tensor<1xi8>, sym_name = "nested"}> ({
      ^bb0(%arg0: tensor<1xi8>):
        "func.return"(%arg0) : (tensor<1xi8>) -> ()
      }) : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

