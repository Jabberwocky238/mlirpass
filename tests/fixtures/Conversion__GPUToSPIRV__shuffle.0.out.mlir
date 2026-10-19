module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle], []>, #spirv.resource_limits<subgroup_size = 16>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @shuffle_xor() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst8_i32 = spirv.Constant 8 : i32
      %cst16_i32 = spirv.Constant 16 : i32
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %0 = spirv.GroupNonUniformShuffleXor <Subgroup> %cst_f32, %cst8_i32 : f32, i32
      %true = spirv.Constant true
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @shuffle_xor() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %c8_i32 = arith.constant 8 : i32
      %c16_i32 = arith.constant 16 : i32
      %cst = arith.constant 4.200000e+01 : f32
      %shuffleResult, %valid = gpu.shuffle  xor %cst, %c8_i32, %c16_i32 : f32
      gpu.return
    }
  }
}

// -----
// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle], []>, #spirv.resource_limits<subgroup_size = 16>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @shuffle_idx() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst8_i32 = spirv.Constant 8 : i32
      %cst16_i32 = spirv.Constant 16 : i32
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %0 = spirv.GroupNonUniformShuffle <Subgroup> %cst_f32, %cst8_i32 : f32, i32
      %true = spirv.Constant true
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @shuffle_idx() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %c8_i32 = arith.constant 8 : i32
      %c16_i32 = arith.constant 16 : i32
      %cst = arith.constant 4.200000e+01 : f32
      %shuffleResult, %valid = gpu.shuffle  idx %cst, %c8_i32, %c16_i32 : f32
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle, GroupNonUniformShuffleRelative], []>, #spirv.resource_limits<subgroup_size = 16>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__SubgroupLocalInvocationId__ built_in("SubgroupLocalInvocationId") : !spirv.ptr<i32, Input>
    spirv.func @shuffle_down() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst4_i32 = spirv.Constant 4 : i32
      %cst16_i32 = spirv.Constant 16 : i32
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %0 = spirv.GroupNonUniformShuffleDown <Subgroup> %cst_f32, %cst4_i32 : f32, i32
      %__builtin__SubgroupLocalInvocationId___addr = spirv.mlir.addressof @__builtin__SubgroupLocalInvocationId__ : !spirv.ptr<i32, Input>
      %1 = spirv.Load "Input" %__builtin__SubgroupLocalInvocationId___addr : i32
      %2 = spirv.IAdd %1, %cst4_i32 : i32
      %3 = spirv.ULessThan %2, %cst16_i32 : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @shuffle_down() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %c4_i32 = arith.constant 4 : i32
      %c16_i32 = arith.constant 16 : i32
      %cst = arith.constant 4.200000e+01 : f32
      %shuffleResult, %valid = gpu.shuffle  down %cst, %c4_i32, %c16_i32 : f32
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle, GroupNonUniformShuffleRelative], []>, #spirv.resource_limits<subgroup_size = 16>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__SubgroupLocalInvocationId__ built_in("SubgroupLocalInvocationId") : !spirv.ptr<i32, Input>
    spirv.func @shuffle_up() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst4_i32 = spirv.Constant 4 : i32
      %cst16_i32 = spirv.Constant 16 : i32
      %cst_f32 = spirv.Constant 4.200000e+01 : f32
      %0 = spirv.GroupNonUniformShuffleUp <Subgroup> %cst_f32, %cst4_i32 : f32, i32
      %__builtin__SubgroupLocalInvocationId___addr = spirv.mlir.addressof @__builtin__SubgroupLocalInvocationId__ : !spirv.ptr<i32, Input>
      %1 = spirv.Load "Input" %__builtin__SubgroupLocalInvocationId___addr : i32
      %2 = spirv.ISub %1, %cst4_i32 : i32
      %cst0_i32 = spirv.Constant 0 : i32
      %3 = spirv.SGreaterThanEqual %2, %cst0_i32 : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @shuffle_up() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %c4_i32 = arith.constant 4 : i32
      %c16_i32 = arith.constant 16 : i32
      %cst = arith.constant 4.200000e+01 : f32
      %shuffleResult, %valid = gpu.shuffle  up %cst, %c4_i32, %c16_i32 : f32
      gpu.return
    }
  }
}

