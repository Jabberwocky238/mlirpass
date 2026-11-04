"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg0: i32):
      "gpu.printf"(%arg0) <{format = "Hello: %d\0A"}> : (i32) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_printf", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

