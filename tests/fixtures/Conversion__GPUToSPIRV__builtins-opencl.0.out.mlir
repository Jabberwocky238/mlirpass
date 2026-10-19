module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} {
  func.func @builtin() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@builtin_workgroup_id_x blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.GlobalVariable @__builtin__WorkgroupId__ built_in("WorkgroupId") : !spirv.ptr<vector<3xi32>, Input>
      spirv.func @builtin_workgroup_id_x() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %__builtin__WorkgroupId___addr = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
        %0 = spirv.Load "Input" %__builtin__WorkgroupId___addr : vector<3xi32>
        %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
        spirv.Return
      }
    }
    func.func @builtin_workgroup_id_x() attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.GlobalVariable @__builtin__SubgroupSize__ built_in("SubgroupSize") : !spirv.ptr<i32, Input>
      spirv.func @builtin_subgroup_size() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %__builtin__SubgroupSize___addr = spirv.mlir.addressof @__builtin__SubgroupSize__ : !spirv.ptr<i32, Input>
        %0 = spirv.Load "Input" %__builtin__SubgroupSize___addr : i32
        spirv.Return
      }
    }
    func.func @builtin_subgroup_size() attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} {
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.GlobalVariable @__builtin__SubgroupLocalInvocationId__ built_in("SubgroupLocalInvocationId") : !spirv.ptr<i32, Input>
      spirv.func @builtin_laneid() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
        %__builtin__SubgroupLocalInvocationId___addr = spirv.mlir.addressof @__builtin__SubgroupLocalInvocationId__ : !spirv.ptr<i32, Input>
        %0 = spirv.Load "Input" %__builtin__SubgroupLocalInvocationId___addr : i32
        spirv.Return
      }
    }
    func.func @builtin_laneid() attributes {gpu.kernel} {
      return
    }
  }
}

