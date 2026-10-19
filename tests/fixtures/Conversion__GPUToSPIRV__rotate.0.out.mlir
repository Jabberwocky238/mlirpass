module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformRotateKHR], []>, #spirv.resource_limits<subgroup_size = 16>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @rotate() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %cst4_i32 = spirv.Constant 4 : i32
      %cst16_i32 = spirv.Constant 16 : i32
      %0 = spirv.GroupNonUniformRotateKHR <Subgroup> %cst_f32, %cst4_i32, cluster_size(%cst16_i32) : f32, i32, i32 -> f32
      %true = spirv.Constant true
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @rotate() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %cst = arith.constant 4.200000e+01 : f32
      %rotateResult, %valid = gpu.rotate %cst, 4, 16 : f32
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformRotateKHR], []>, #spirv.resource_limits<subgroup_size = 16>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__SubgroupLocalInvocationId__ built_in("SubgroupLocalInvocationId") : !spirv.ptr<i32, Input>
    spirv.func @rotate_width_less_than_subgroup_size() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %cst4_i32 = spirv.Constant 4 : i32
      %cst8_i32 = spirv.Constant 8 : i32
      %0 = spirv.GroupNonUniformRotateKHR <Subgroup> %cst_f32, %cst4_i32, cluster_size(%cst8_i32) : f32, i32, i32 -> f32
      %__builtin__SubgroupLocalInvocationId___addr = spirv.mlir.addressof @__builtin__SubgroupLocalInvocationId__ : !spirv.ptr<i32, Input>
      %1 = spirv.Load "Input" %__builtin__SubgroupLocalInvocationId___addr : i32
      %2 = spirv.ULessThan %1, %cst8_i32 : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @rotate_width_less_than_subgroup_size() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %cst = arith.constant 4.200000e+01 : f32
      %rotateResult, %valid = gpu.rotate %cst, 4, 8 : f32
      gpu.return
    }
  }
}

// -----
