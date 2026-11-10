module {
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @broadcast_specific_lane() "None" attributes {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %cst0_i32 = spirv.Constant 0 : i32
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %0 = spirv.GroupNonUniformBroadcast <Subgroup> %cst_f32, %cst0_i32 : f32, i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @broadcast_specific_lane() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %c0_i32 = arith.constant 0 : i32
      %cst = arith.constant 4.200000e+01 : f32
      %0 = gpu.subgroup_broadcast %cst, specific_lane %c0_i32 : f32
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @broadcast_first_active_lane() "None" attributes {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %0 = spirv.GroupNonUniformBroadcastFirst <Subgroup> %cst_f32 : f32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @broadcast_first_active_lane() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %cst = arith.constant 4.200000e+01 : f32
      %0 = gpu.subgroup_broadcast %cst, first_active_lane : f32
      gpu.return
    }
  }
}

