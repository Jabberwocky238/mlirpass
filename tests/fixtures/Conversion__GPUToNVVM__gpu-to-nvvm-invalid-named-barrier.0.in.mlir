"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "too_many_named_barriers"}> ({
      %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %1 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %2 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %3 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %4 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %5 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %6 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %7 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %8 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %9 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %10 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %11 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %12 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %13 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %14 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %15 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      %16 = "gpu.initialize_named_barrier"(%0) : (i32) -> !gpu.named_barrier
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

