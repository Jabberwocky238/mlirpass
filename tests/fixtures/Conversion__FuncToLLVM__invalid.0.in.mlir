"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<10xi32>, sym_name = "unsupported_signature", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<10xi32>, tensor<10xi32>), sym_name = "partially_supported_signature", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

