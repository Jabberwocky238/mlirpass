"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "named_barrier"}> ({
      %4 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %5 = "gpu.initialize_named_barrier"(%4) : (i32) -> !gpu.named_barrier
      "gpu.barrier"(%5) <{scope = #gpu.barrier_scope<workgroup>}> : (!gpu.named_barrier) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "two_named_barriers"}> ({
      %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %2 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %3 = "gpu.initialize_named_barrier"(%1) : (i32) -> !gpu.named_barrier
      "gpu.barrier"(%2) <{scope = #gpu.barrier_scope<workgroup>}> : (!gpu.named_barrier) -> ()
      "gpu.barrier"(%3) <{scope = #gpu.barrier_scope<workgroup>}> : (!gpu.named_barrier) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "cluster_scope"}> ({
      "gpu.barrier"() <{scope = #gpu.barrier_scope<cluster>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
