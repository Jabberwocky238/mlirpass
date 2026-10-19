module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_id_x blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__WorkgroupId__ built_in("WorkgroupId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_workgroup_id_x() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__WorkgroupId___addr = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__WorkgroupId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_id_x() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %block_id_x = gpu.block_id  x
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    gpu.launch_func  @kernels::@builtin_workgroup_id_y blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  dynamic_shared_memory_size %c256_i32 
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__WorkgroupId__ built_in("WorkgroupId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_workgroup_id_y() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__WorkgroupId___addr = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__WorkgroupId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[1 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_id_y() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %block_id_y = gpu.block_id  y
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_id_z blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__WorkgroupId__ built_in("WorkgroupId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_workgroup_id_z() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__WorkgroupId___addr = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__WorkgroupId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[2 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_id_z() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %block_id_z = gpu.block_id  z
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_size_x blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @builtin_workgroup_size_x() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst32_i32 = spirv.Constant 32 : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_size_x() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} {
      %block_dim_x = gpu.block_dim  x
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_size_y blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @builtin_workgroup_size_y() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst4_i32 = spirv.Constant 4 : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_size_y() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %block_dim_y = gpu.block_dim  y
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_size_z blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @builtin_workgroup_size_z() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst1_i32 = spirv.Constant 1 : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_size_z() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %block_dim_z = gpu.block_dim  z
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_local_id_x blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__LocalInvocationId__ built_in("LocalInvocationId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_local_id_x() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__LocalInvocationId___addr = spirv.mlir.addressof @__builtin__LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__LocalInvocationId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_local_id_x() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %thread_id_x = gpu.thread_id  x
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_num_workgroups_x blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__NumWorkgroups__ built_in("NumWorkgroups") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_num_workgroups_x() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__NumWorkgroups___addr = spirv.mlir.addressof @__builtin__NumWorkgroups__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__NumWorkgroups___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_num_workgroups_x() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %grid_dim_x = gpu.grid_dim  x
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__SubgroupId__ built_in("SubgroupId") : !spirv.ptr<i32, Input>
    spirv.func @builtin_subgroup_id() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__SubgroupId___addr = spirv.mlir.addressof @__builtin__SubgroupId__ : !spirv.ptr<i32, Input>
      %0 = spirv.Load "Input" %__builtin__SubgroupId___addr : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_subgroup_id() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %0 = gpu.subgroup_id : index
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__NumSubgroups__ built_in("NumSubgroups") : !spirv.ptr<i32, Input>
    spirv.func @builtin_num_subgroups() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__NumSubgroups___addr = spirv.mlir.addressof @__builtin__NumSubgroups__ : !spirv.ptr<i32, Input>
      %0 = spirv.Load "Input" %__builtin__NumSubgroups___addr : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_num_subgroups() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %0 = gpu.num_subgroups : index
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_size_x blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__WorkgroupSize__ built_in("WorkgroupSize") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_workgroup_size_x() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} {
      %__builtin__WorkgroupSize___addr = spirv.mlir.addressof @__builtin__WorkgroupSize__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__WorkgroupSize___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_size_x() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>} {
      %block_dim_x = gpu.block_dim  x
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_size_y blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__WorkgroupSize__ built_in("WorkgroupSize") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_workgroup_size_y() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} {
      %__builtin__WorkgroupSize___addr = spirv.mlir.addressof @__builtin__WorkgroupSize__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__WorkgroupSize___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[1 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_size_y() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>} {
      %block_dim_y = gpu.block_dim  y
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_size_z blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__WorkgroupSize__ built_in("WorkgroupSize") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_workgroup_size_z() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} {
      %__builtin__WorkgroupSize___addr = spirv.mlir.addressof @__builtin__WorkgroupSize__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__WorkgroupSize___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[2 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_workgroup_size_z() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>} {
      %block_dim_z = gpu.block_dim  z
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_global_id_x blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__GlobalInvocationId__ built_in("GlobalInvocationId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_global_id_x() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__GlobalInvocationId___addr = spirv.mlir.addressof @__builtin__GlobalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__GlobalInvocationId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_global_id_x() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %global_id_x = gpu.global_id  x
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_global_id_y blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__GlobalInvocationId__ built_in("GlobalInvocationId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_global_id_y() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__GlobalInvocationId___addr = spirv.mlir.addressof @__builtin__GlobalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__GlobalInvocationId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[1 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_global_id_y() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %global_id_y = gpu.global_id  y
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_global_id_z blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__GlobalInvocationId__ built_in("GlobalInvocationId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @builtin_global_id_z() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__GlobalInvocationId___addr = spirv.mlir.addressof @__builtin__GlobalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__GlobalInvocationId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[2 : i32] : vector<3xi32>
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_global_id_z() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %global_id_z = gpu.global_id  z
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__SubgroupSize__ built_in("SubgroupSize") : !spirv.ptr<i32, Input>
    spirv.func @builtin_subgroup_size() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__SubgroupSize___addr = spirv.mlir.addressof @__builtin__SubgroupSize__ : !spirv.ptr<i32, Input>
      %0 = spirv.Load "Input" %__builtin__SubgroupSize___addr : i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @builtin_subgroup_size() kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %0 = gpu.subgroup_size : index
      gpu.return
    }
  }
}

