module attributes {gpu.container_module} {
  spirv.module @__spv__kernels Logical GLSL450 attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
    spirv.func @load_kernel(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst4_i32 = spirv.Constant 4 : i32
      %cst0_i32_2 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : f32
      spirv.Return
    }
  }
  gpu.module @kernels [#spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>] {
    gpu.func @load_kernel(%arg0: memref<12x4xf32>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %c0 = arith.constant 0 : index
      %0 = memref.load %arg0[%c0, %c0] : memref<12x4xf32>
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  spirv.module @__spv__kernels Logical GLSL450 attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
    spirv.func @load_kernel(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst4_i32 = spirv.Constant 4 : i32
      %cst0_i32_2 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : f32
      spirv.Return
    }
  }
  gpu.module @kernels [#spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>, #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>, #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>] {
    gpu.func @load_kernel(%arg0: memref<12x4xf32>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %c0 = arith.constant 0 : index
      %0 = memref.load %arg0[%c0, %c0] : memref<12x4xf32>
      gpu.return
    }
  }
}

