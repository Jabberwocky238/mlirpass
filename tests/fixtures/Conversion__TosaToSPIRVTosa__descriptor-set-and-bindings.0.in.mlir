"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> tensor<1xi8>, sym_name = "default_interface_var_abi"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    "func.return"(%arg0) : (tensor<1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{grapharm.interface_var_abi = #spirv.interface_var_abi<(3, 9)>}], function_type = (tensor<1xi8>) -> tensor<1xi8>, res_attrs = [{grapharm.interface_var_abi = #spirv.interface_var_abi<(7, 11)>}], sym_name = "custom_grapharm_abi"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    "func.return"(%arg0) : (tensor<1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

