"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (i32) -> (), sym_name = "initialize_named_barrier_pre_gfx12"}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.initialize_named_barrier"(%arg0) : (i32) -> !gpu.named_barrier
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

