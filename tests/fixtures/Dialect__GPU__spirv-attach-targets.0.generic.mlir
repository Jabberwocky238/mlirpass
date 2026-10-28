"builtin.module"() ({
  "gpu.module"() <{sym_name = "spirv_hot_module", targets = [#spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, Intel:Other, #spirv.resource_limits<>>]}> ({
  ^bb0:
  }) : () -> ()
  "gpu.module"() <{sym_name = "spirv_warm_module", targets = [#spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, Intel:Other, #spirv.resource_limits<>>]}> ({
  ^bb0:
  }) : () -> ()
  "gpu.module"() <{sym_name = "spirv_cold_module", targets = [#spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, Intel:Other, #spirv.resource_limits<>>]}> ({
  ^bb0:
  }) : () -> ()
}) {gpu.container_module} : () -> ()

