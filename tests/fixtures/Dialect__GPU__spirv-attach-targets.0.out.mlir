module attributes {gpu.container_module} {
  gpu.module @spirv_hot_module [#spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, Intel:Other, #spirv.resource_limits<>>] {
  }
  gpu.module @spirv_warm_module [#spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, Intel:Other, #spirv.resource_limits<>>] {
  }
  gpu.module @spirv_cold_module [#spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, Intel:Other, #spirv.resource_limits<>>] {
  }
}

