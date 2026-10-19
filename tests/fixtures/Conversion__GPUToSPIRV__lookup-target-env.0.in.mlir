"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels", targets = [#spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>]}> ({
    "gpu.func"() <{function_type = (memref<12x4xf32>) -> ()}> ({
    ^bb0(%arg0: memref<12x4xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.load"(%arg0, %0, %0) : (memref<12x4xf32>, index, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "load_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels", targets = [#spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>, #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>, #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>]}> ({
    "gpu.func"() <{function_type = (memref<12x4xf32>) -> ()}> ({
    ^bb0(%arg0: memref<12x4xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.load"(%arg0, %0, %0) : (memref<12x4xf32>, index, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "load_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

