"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.printf"() <{format = "Hello, world\0A"}> : () -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_const_printf", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg0: i32):
      "gpu.printf"(%arg0) <{format = "Hello: %d\0A"}> : (i32) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_printf", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "fake_gpu_module_for_test"}> ({
    "builtin.module"() <{sym_name = "test_module"}> ({
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
      ^bb0(%arg0: i32):
        "gpu.printf"(%arg0) <{format = "Hello: %d\0A"}> : (i32) -> ()
        "llvm.return"() : () -> ()
      }) : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

