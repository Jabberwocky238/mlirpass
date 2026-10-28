module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses], []>, #spirv.resource_limits<>>} {
  spirv.module Physical64 OpenCL {
    spirv.func @kernel(%arg0: f32, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, CrossWorkgroup>) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<subgroup_size = 64>} {
      spirv.Return
    }
    spirv.EntryPoint "Kernel" @kernel
    spirv.ExecutionMode @kernel "LocalSize", 32, 1, 1
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, SubgroupDispatch], []>, #spirv.resource_limits<>>} {
  spirv.module Physical64 OpenCL {
    spirv.func @kernel(%arg0: f32, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, CrossWorkgroup>) "None" {
      spirv.Return
    }
    spirv.EntryPoint "Kernel" @kernel
    spirv.ExecutionMode @kernel "LocalSize", 32, 1, 1
    spirv.ExecutionMode @kernel "SubgroupSize", 64
  }
}

