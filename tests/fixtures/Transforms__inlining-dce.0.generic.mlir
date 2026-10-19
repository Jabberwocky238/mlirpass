"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "dead_function_b"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_function"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_function_b"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_function_c"}> ({
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
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

