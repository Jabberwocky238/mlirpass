module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @kernel_arg_0 bind(0, 0) : !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>
    spirv.GlobalVariable @kernel_arg_1 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>
    spirv.func @kernel() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<subgroup_size = 64>} {
      %kernel_arg_0_addr = spirv.mlir.addressof @kernel_arg_0 : !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.AccessChain %kernel_arg_0_addr[%cst0_i32] : !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<f32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : f32
      %kernel_arg_1_addr = spirv.mlir.addressof @kernel_arg_1 : !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @kernel
    spirv.ExecutionMode @kernel "LocalSize", 32, 1, 1
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [VulkanMemoryModel, Shader, Int8, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>, #spirv.resource_limits<>>} {
  spirv.module Logical Vulkan {
    spirv.GlobalVariable @main_arg_0 bind(0, 0) : !spirv.ptr<!spirv.arm.tensor<1x16x16x16xi8>, UniformConstant>
    spirv.GlobalVariable @main_res_0 bind(0, 1) : !spirv.ptr<!spirv.arm.tensor<1x16x16x16xi8>, UniformConstant>
    spirv.ARM.GraphEntryPoint @main, @main_arg_0, @main_res_0
    spirv.ARM.Graph @main(%arg0: !spirv.arm.tensor<1x16x16x16xi8>) -> !spirv.arm.tensor<1x16x16x16xi8> attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1x16x16x16xi8>
    }
  }
}

// -----
// -----
module {
  spirv.module Logical GLSL450 attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @kernel_arg_0 bind(0, 0) : !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>
    spirv.GlobalVariable @kernel_arg_1 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>
    spirv.func @kernel() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<subgroup_size = 64>} {
      %kernel_arg_0_addr = spirv.mlir.addressof @kernel_arg_0 : !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.AccessChain %kernel_arg_0_addr[%cst0_i32] : !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<f32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : f32
      %kernel_arg_1_addr = spirv.mlir.addressof @kernel_arg_1 : !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @kernel, @kernel_arg_0, @kernel_arg_1
    spirv.ExecutionMode @kernel "LocalSize", 32, 1, 1
  }
}

// -----
module {
  spirv.module Logical GLSL450 attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, Sampled1D], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @read_image_arg_0 bind(0, 0) : !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    spirv.GlobalVariable @read_image_arg_1 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    spirv.func @read_image() "None" {
      %read_image_arg_0_addr = spirv.mlir.addressof @read_image_arg_0 : !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
      %read_image_arg_1_addr = spirv.mlir.addressof @read_image_arg_1 : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.Load "UniformConstant" %read_image_arg_0_addr : !spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
      %1 = spirv.Image %0 : !spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
      %2 = spirv.ImageFetch %1, %cst0_i32  : !spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, i32 -> vector<4xf32>
      %3 = spirv.CompositeExtract %2[0 : i32] : vector<4xf32>
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %4 = spirv.AccessChain %read_image_arg_1_addr[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %4, %3 : f32
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @read_image, @read_image_arg_0, @read_image_arg_1
    spirv.ExecutionMode @read_image "LocalSize", 1, 1, 1
  }
}

