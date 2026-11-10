"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %1:2 = "gpu.rotate"(%0) <{offset = 4 : i32, width = 16 : i32}> : (f32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "rotate"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformRotateKHR], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %1:2 = "gpu.rotate"(%0) <{offset = 4 : i32, width = 8 : i32}> : (f32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "rotate_width_less_than_subgroup_size"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformRotateKHR], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %1:2 = "gpu.rotate"(%0) <{offset = 4 : i32, width = 32 : i32}> : (f32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "rotate_with_bigger_than_subgroup_size"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformRotateKHR], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

