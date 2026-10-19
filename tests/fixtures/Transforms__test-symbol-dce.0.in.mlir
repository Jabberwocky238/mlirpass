"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "dead_private_function", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_nested_function", sym_visibility = "nested"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_private_function", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_nested_function", sym_visibility = "nested"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "public_function"}> ({
    "foo.return"() {uses = [@live_private_function, @live_nested_function]} : () -> ()
  }) : () -> ()
}) {test.simple} : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() <{sym_name = "public_module"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "dead_nested_function", sym_visibility = "nested"}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "private_function", sym_visibility = "private"}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "nested_function", sym_visibility = "nested"}> ({
      "foo.return"() {uses = [@private_function]} : () -> ()
    }) : () -> ()
  }) : () -> ()
  "live.user"() {uses = [@public_module::@nested_function]} : () -> ()
}) {test.nested} : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() <{sym_name = "public_module"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "nested_function", sym_visibility = "nested"}> ({
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "nested_module", sym_visibility = "nested"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "nested_function", sym_visibility = "nested"}> ({
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "private_module", sym_visibility = "private"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "nested_function", sym_visibility = "nested"}> ({
    }) : () -> ()
  }) : () -> ()
  "live.user"() {uses = [@nested_module, @private_module]} : () -> ()
}) {test.no_dce_non_hidden_parent} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "private_symbol", sym_visibility = "private"}> ({
  }) : () -> ()
  "foo.possibly_unknown_symbol_table"() ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "dead_private_function", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "live_private_function", sym_visibility = "private"}> ({
  }) : () -> ()
  "live.user"() {uses = [@live_private_function]} : () -> ()
  "live.user"() {uses = [@unknown_symbol]} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.one_region_op"() ({
    "test.symbol_scope"() ({
      "func.func"() <{function_type = () -> (), sym_name = "nfunction", sym_visibility = "nested"}> ({
        "func.return"() : () -> ()
      }) : () -> ()
      "func.call"() <{callee = @nfunction}> : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
    "test.finish"() : () -> ()
  }) : () -> ()
}) {test.nested_nosymboltable_region} : () -> ()

// -----
"builtin.module"() ({
  "test.one_region_op"() ({
    "builtin.module"() ({
      "func.func"() <{function_type = () -> (), sym_name = "nested", sym_visibility = "nested"}> ({
        "func.return"() : () -> ()
      }) : () -> ()
      "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
        "func.return"() : () -> ()
      }) : () -> ()
    }) : () -> ()
    "test.finish"() : () -> ()
  }) : () -> ()
}) {test.nested_nosymboltable_region_notcalled} : () -> ()

