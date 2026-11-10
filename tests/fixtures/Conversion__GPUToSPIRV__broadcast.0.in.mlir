"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %2 = "gpu.subgroup_broadcast"(%1, %0) <{broadcast_type = #gpu<broadcast specific_lane>}> : (f32, i32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "broadcast_specific_lane"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %1 = "gpu.subgroup_broadcast"(%0) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "broadcast_first_active_lane"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

