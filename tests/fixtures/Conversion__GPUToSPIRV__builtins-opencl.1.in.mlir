"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%1, %1, %1, %1, %1, %1) <{kernel = @kernels::@builtin_workgroup_id_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_workgroup_id_x"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "gpu.subgroup_size"() : () -> index
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_subgroup_size"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "gpu.lane_id"() : () -> index
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_laneid"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} : () -> ()

