"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "dead_function", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_function_b"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_function"}> ({
    "func.call"() <{callee = @dead_function_b}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_function_b"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_function_c", sym_visibility = "private"}> ({
    "func.call"() <{callee = @live_function_b}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_function_d", sym_visibility = "private"}> ({
    "func.call"() <{callee = @dead_function_c}> : () -> ()
    "func.call"() <{callee = @dead_function_c}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_function_c"}> ({
    "func.call"() <{callee = @dead_function_c}> : () -> ()
    "func.call"() <{callee = @dead_function_d}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_function_d", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "live.user"() {use = @live_function_d} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "live_function_e"}> ({
    "func.call"() <{callee = @dead_function_e}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_function_e", sym_visibility = "private"}> ({
    "test.fold_to_call_op"() <{callee = @dead_function_f}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_function_f", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

