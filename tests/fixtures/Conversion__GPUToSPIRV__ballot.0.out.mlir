module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__SubgroupLocalInvocationId__ built_in("SubgroupLocalInvocationId") : !spirv.ptr<i32, Input>
    spirv.func @ballot_i32() "None" attributes {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} {
      %cst1_i32 = spirv.Constant 1 : i32
      %__builtin__SubgroupLocalInvocationId___addr = spirv.mlir.addressof @__builtin__SubgroupLocalInvocationId__ : !spirv.ptr<i32, Input>
      %0 = spirv.Load "Input" %__builtin__SubgroupLocalInvocationId___addr : i32
      %1 = spirv.ULessThan %0, %cst1_i32 : i32
      %2 = spirv.GroupNonUniformBallot <Subgroup> %1 : vector<4xi32>
      %3 = spirv.CompositeExtract %2[0 : i32] : vector<4xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @ballot_i32() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} {
      %c1 = arith.constant 1 : index
      %0 = gpu.lane_id
      %1 = arith.cmpi ult, %0, %c1 : index
      %2 = gpu.ballot %1 : i32
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot, Int64], []>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__SubgroupLocalInvocationId__ built_in("SubgroupLocalInvocationId") : !spirv.ptr<i32, Input>
    spirv.func @ballot_i64() "None" attributes {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} {
      %cst1_i32 = spirv.Constant 1 : i32
      %__builtin__SubgroupLocalInvocationId___addr = spirv.mlir.addressof @__builtin__SubgroupLocalInvocationId__ : !spirv.ptr<i32, Input>
      %0 = spirv.Load "Input" %__builtin__SubgroupLocalInvocationId___addr : i32
      %1 = spirv.ULessThan %0, %cst1_i32 : i32
      %2 = spirv.GroupNonUniformBallot <Subgroup> %1 : vector<4xi32>
      %3 = spirv.CompositeExtract %2[0 : i32] : vector<4xi32>
      %4 = spirv.CompositeExtract %2[1 : i32] : vector<4xi32>
      %5 = spirv.UConvert %3 : i32 to i64
      %6 = spirv.UConvert %4 : i32 to i64
      %cst32_i64 = spirv.Constant 32 : i64
      %7 = spirv.ShiftLeftLogical %6, %cst32_i64 : i64, i64
      %8 = spirv.BitwiseOr %5, %7 : i64
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @ballot_i64() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} {
      %c1 = arith.constant 1 : index
      %0 = gpu.lane_id
      %1 = arith.cmpi ult, %0, %c1 : index
      %2 = gpu.ballot %1 : i64
      gpu.return
    }
  }
}

// -----
// -----
// -----
