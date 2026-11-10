"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "broadcast_specific_lane"}> ({
      %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %4 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %5 = "spirv.GroupNonUniformBroadcast"(%4, %3) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} : () -> ()
  }) : () -> ()
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
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "broadcast_first_active_lane"}> ({
      %2 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3 = "spirv.GroupNonUniformBroadcastFirst"(%2) <{execution_scope = #spirv.scope<Subgroup>}> : (f32) -> f32
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %1 = "gpu.subgroup_broadcast"(%0) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "broadcast_first_active_lane"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

