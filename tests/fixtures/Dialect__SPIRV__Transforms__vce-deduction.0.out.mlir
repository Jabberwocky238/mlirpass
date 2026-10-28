module {
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader], []>, #spirv.resource_limits<>>} {
    spirv.func @iadd(%arg0: i32) -> i32 "None" {
      %0 = spirv.IAdd %arg0, %arg0 : i32
      spirv.ReturnValue %0 : i32
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.3, [GroupNonUniformBallot, Shader, GroupNonUniform, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} {
    spirv.func @group_non_uniform_ballot(%arg0: i1) -> vector<4xi32> "None" {
      %0 = spirv.GroupNonUniformBallot <Workgroup> %arg0 : vector<4xi32>
      spirv.ReturnValue %0 : vector<4xi32>
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.4, [Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader], []>, #spirv.resource_limits<>>} {
    spirv.func @select_with_scalar_condition(%arg0: i1, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> "None" {
      %0 = spirv.Select %arg0, %arg1, %arg2 : i1, vector<2xf32>
      spirv.ReturnValue %0 : vector<2xf32>
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Float16, Float64, Int16, Int64, VariablePointers], []>, #spirv.resource_limits<>>} {
    spirv.func @iadd(%arg0: i32) -> i32 "None" {
      %0 = spirv.IAdd %arg0, %arg0 : i32
      spirv.ReturnValue %0 : i32
    }
  }
  spirv.module PhysicalStorageBuffer64 GLSL450 requires #spirv.vce<v1.0, [PhysicalStorageBufferAddresses, Shader, Matrix], [SPV_EXT_physical_storage_buffer]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [PhysicalStorageBufferAddresses], [SPV_EXT_physical_storage_buffer]>, #spirv.resource_limits<>>} {
    spirv.func @physical_ptr(%arg0: !spirv.ptr<f32, PhysicalStorageBuffer> {spirv.decoration = #spirv.decoration<Aliased>}) "None" {
      spirv.Return
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [AtomicStorage], []>, #spirv.resource_limits<>>} {
    spirv.func @iadd(%arg0: i32) -> i32 "None" {
      %0 = spirv.IAdd %arg0, %arg0 : i32
      spirv.ReturnValue %0 : i32
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.3, [GroupNonUniformArithmetic, Shader, GroupNonUniform, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformArithmetic], []>, #spirv.resource_limits<>>} {
    spirv.func @group_non_uniform_iadd(%arg0: i32) -> i32 "None" {
      %0 = spirv.GroupNonUniformIAdd <Subgroup> <Reduce> %arg0 : i32 -> i32
      spirv.ReturnValue %0 : i32
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.3, [GroupNonUniformClustered, GroupNonUniformBallot, Shader, GroupNonUniform, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformClustered, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} {
    spirv.func @group_non_uniform_iadd(%arg0: i32) -> i32 "None" {
      %0 = spirv.GroupNonUniformIAdd <Subgroup> <Reduce> %arg0 : i32 -> i32
      spirv.ReturnValue %0 : i32
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Int8, Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Int8], []>, #spirv.resource_limits<>>} {
    spirv.func @iadd_function(%arg0: i8) -> i8 "None" {
      %0 = spirv.IAdd %arg0, %arg0 : i8
      spirv.ReturnValue %0 : i8
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Float16, Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Float16], []>, #spirv.resource_limits<>>} {
    spirv.func @fadd_function(%arg0: f16) -> f16 "None" {
      %0 = spirv.FAdd %arg0, %arg0 : f16
      spirv.ReturnValue %0 : f16
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Vector16, Shader, Kernel, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Vector16], []>, #spirv.resource_limits<>>} {
    spirv.func @iadd_v16_function(%arg0: vector<16xi32>) -> vector<16xi32> "None" {
      %0 = spirv.IAdd %arg0, %arg0 : vector<16xi32>
      spirv.ReturnValue %0 : vector<16xi32>
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [SubgroupBallotKHR, Shader, Matrix], [SPV_KHR_shader_ballot]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, SubgroupBallotKHR], [SPV_KHR_shader_ballot, SPV_KHR_shader_clock, SPV_KHR_variable_pointers]>, #spirv.resource_limits<>>} {
    spirv.func @subgroup_ballot(%arg0: i1) -> vector<4xi32> "None" {
      %0 = spirv.KHR.SubgroupBallot %arg0 : vector<4xi32>
      spirv.ReturnValue %0 : vector<4xi32>
    }
  }
  spirv.module Logical Vulkan requires #spirv.vce<v1.5, [VulkanMemoryModel], [SPV_KHR_vulkan_memory_model]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, VulkanMemoryModel], []>, #spirv.resource_limits<>>} {
    spirv.func @iadd(%arg0: i32) -> i32 "None" {
      %0 = spirv.IAdd %arg0, %arg0 : i32
      spirv.ReturnValue %0 : i32
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [StorageBuffer16BitAccess, Shader, Int16, Matrix], [SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, StorageBuffer16BitAccess, Int16], []>, #spirv.resource_limits<>>} {
    spirv.func @iadd_storage_buffer(%arg0: !spirv.ptr<i16, StorageBuffer>) -> i16 "None" {
      %0 = spirv.Load "StorageBuffer" %arg0 : i16
      %1 = spirv.IAdd %0, %0 : i16
      spirv.ReturnValue %1 : i16
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [UniformAndStorageBuffer8BitAccess, StorageUniform16, Int64, Shader, ImageBuffer, StorageImageExtendedFormats, StorageBuffer8BitAccess, StorageBuffer16BitAccess, Matrix, SampledBuffer], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, UniformAndStorageBuffer8BitAccess, StorageBuffer16BitAccess, StorageUniform16, Int16, Int64, ImageBuffer, StorageImageExtendedFormats], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @data : !spirv.ptr<!spirv.struct<(i8 [0], f16 [2], i64 [4])>, Uniform>
    spirv.GlobalVariable @img : !spirv.ptr<!spirv.image<f32, Buffer, NoDepth, NonArrayed, SingleSampled, SamplerUnknown, Rg32f>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [StorageBuffer16BitAccess, Shader, BFloat16TypeKHR, Matrix], [SPV_KHR_bfloat16, SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, StorageBuffer16BitAccess, BFloat16TypeKHR], [SPV_KHR_bfloat16, SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
    spirv.func @load_bf16(%arg0: !spirv.ptr<bf16, StorageBuffer>) -> bf16 "None" {
      %0 = spirv.Load "StorageBuffer" %arg0 : bf16
      spirv.ReturnValue %0 : bf16
    }
  }
  spirv.module Logical Vulkan requires #spirv.vce<v1.5, [GraphARM, Int8, TensorsARM, Float16, VulkanMemoryModel], [SPV_ARM_graph, SPV_ARM_tensors, SPV_KHR_vulkan_memory_model]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, GraphARM, TensorsARM, Float16], [SPV_ARM_tensors, SPV_ARM_graph]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @argmax(%arg0: !spirv.arm.tensor<14x19xi8>, %arg1: !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<14x19xi8> {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<14x19xi8>
    }
  }
  spirv.module Physical64 GLSL450 requires #spirv.vce<v1.0, [Shader, Addresses, Matrix], [SPV_KHR_storage_buffer_storage_class]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, Addresses], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @recursive : !spirv.ptr<!spirv.struct<rec, (!spirv.ptr<!spirv.struct<rec>, StorageBuffer>)>, StorageBuffer>
  }
}

