"builtin.module"() ({
  "gpu.module"() <{sym_name = "spirv_hot_module"}> ({
  ^bb0:
  }) : () -> ()
  "gpu.module"() <{sym_name = "spirv_warm_module"}> ({
  ^bb0:
  }) : () -> ()
  "gpu.module"() <{sym_name = "spirv_cold_module"}> ({
  ^bb0:
  }) : () -> ()
}) {gpu.container_module} : () -> ()

