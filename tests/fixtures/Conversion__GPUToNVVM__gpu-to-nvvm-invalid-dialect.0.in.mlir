"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "func.func"() <{function_type = (index) -> index, sym_name = "test"}> ({
    ^bb0(%arg0: index):
      %0 = "test.increment"(%arg0) : (index) -> index
      "func.return"(%0) : (index) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

