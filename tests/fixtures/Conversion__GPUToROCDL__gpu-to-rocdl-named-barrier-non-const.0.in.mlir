"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (i32) -> (), sym_name = "non_constant_member_count"}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.initialize_named_barrier"(%arg0) : (i32) -> !gpu.named_barrier
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

