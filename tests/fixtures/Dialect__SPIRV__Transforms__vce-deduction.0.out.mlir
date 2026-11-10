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
  spirv.module Logical GLSL450 requires #spirv.vce<v1.6, [BFloat16TypeKHR, CooperativeMatrixKHR, BFloat16CooperativeMatrixKHR, Shader, Matrix], [SPV_KHR_bfloat16, SPV_KHR_cooperative_matrix]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, BFloat16TypeKHR, BFloat16CooperativeMatrixKHR], [SPV_KHR_cooperative_matrix, SPV_KHR_bfloat16]>, #spirv.resource_limits<>>} {
    spirv.func @bf16_coopmatrix(%arg0: !spirv.coopmatrix<4x4xbf16, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xbf16, Subgroup, MatrixA> "None" {
      spirv.ReturnValue %arg0 : !spirv.coopmatrix<4x4xbf16, Subgroup, MatrixA>
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.6, [Float8EXT, CooperativeMatrixKHR, Float8CooperativeMatrixEXT, Shader, Matrix], [SPV_EXT_float8, SPV_KHR_cooperative_matrix]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float8EXT, Float8CooperativeMatrixEXT], [SPV_KHR_cooperative_matrix, SPV_EXT_float8]>, #spirv.resource_limits<>>} {
    spirv.func @f8_coopmatrix(%arg0: !spirv.coopmatrix<4x4xf8E4M3FN, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xf8E4M3FN, Subgroup, MatrixA> "None" {
      spirv.ReturnValue %arg0 : !spirv.coopmatrix<4x4xf8E4M3FN, Subgroup, MatrixA>
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.6, [Float8EXT, CooperativeMatrixKHR, Float8CooperativeMatrixEXT, Shader, Matrix], [SPV_EXT_float8, SPV_KHR_cooperative_matrix]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float8EXT, Float8CooperativeMatrixEXT], [SPV_KHR_cooperative_matrix, SPV_EXT_float8]>, #spirv.resource_limits<>>} {
    spirv.func @f8_coopmatrix(%arg0: !spirv.coopmatrix<4x4xf8E5M2, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xf8E5M2, Subgroup, MatrixA> "None" {
      spirv.ReturnValue %arg0 : !spirv.coopmatrix<4x4xf8E5M2, Subgroup, MatrixA>
    }
  }
  spirv.module Logical Vulkan requires #spirv.vce<v1.5, [GraphARM, Int8, TensorsARM, Float16, VulkanMemoryModel], [SPV_ARM_graph, SPV_ARM_tensors, SPV_KHR_vulkan_memory_model]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, GraphARM, TensorsARM, Float16], [SPV_ARM_tensors, SPV_ARM_graph]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @argmax(%arg0: !spirv.arm.tensor<14x19xi8>, %arg1: !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<14x19xi8> {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<14x19xi8>
    }
  }
  spirv.module Logical Vulkan requires #spirv.vce<v1.5, [Shader, VulkanMemoryModel, Matrix], [SPV_KHR_vulkan_memory_model]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, VulkanMemoryModel], [SPV_KHR_vulkan_memory_model]>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @var bind(0, 0) : !spirv.ptr<!spirv.struct<(i32 [0])>, UniformConstant>
  }
  spirv.module Physical64 GLSL450 requires #spirv.vce<v1.0, [Shader, Addresses, Matrix], [SPV_KHR_storage_buffer_storage_class]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, Addresses], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @recursive : !spirv.ptr<!spirv.struct<rec, (!spirv.ptr<!spirv.struct<rec>, StorageBuffer>)>, StorageBuffer>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, StorageImageMultisample, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, StorageImageMultisample], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_2d_ms_storage bind(0, 0) : !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, StorageImageMultisample, ImageMSArray, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, StorageImageMultisample, ImageMSArray], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_2d_ms_arrayed_storage bind(0, 0) : !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, Arrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_2d_storage bind(0, 0) : !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_cube bind(0, 0) : !spirv.ptr<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, ImageCubeArray, Matrix, SampledCubeArray], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, ImageCubeArray], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_cube_arrayed bind(0, 0) : !spirv.ptr<!spirv.image<f32, Cube, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Image1D, Matrix, Sampled1D], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Image1D], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_1d_storage bind(0, 0) : !spirv.ptr<!spirv.image<f32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Sampled1D, Matrix], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Sampled1D], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_1d_sampled bind(0, 0) : !spirv.ptr<!spirv.image<f32, Dim1D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, ImageBuffer, Matrix, SampledBuffer], []> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, ImageBuffer], []>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_buffer_storage bind(0, 0) : !spirv.ptr<!spirv.image<f32, Buffer, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Shader, Int64ImageEXT, Int64, Matrix], [SPV_EXT_shader_image_int64]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int64, Int64ImageEXT], [SPV_EXT_shader_image_int64]>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @img_2d_i64 bind(0, 0) : !spirv.ptr<!spirv.image<i64, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [Linkage, Shader, Matrix], [SPV_KHR_linkonce_odr]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Linkage], [SPV_KHR_linkonce_odr]>, #spirv.resource_limits<>>} {
    spirv.func @linkonce_odr_fn() "None" attributes {linkage_attributes = #spirv.linkage_attributes<linkage_name = "linkonce_odr_fn", linkage_type = <LinkOnceODR>>} {
      spirv.Return
    }
  }
  spirv.module Logical GLSL450 requires #spirv.vce<v1.0, [WeakLinkageAMD, Shader, Linkage, Matrix], [SPV_AMD_weak_linkage]> attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, WeakLinkageAMD], [SPV_AMD_weak_linkage]>, #spirv.resource_limits<>>} {
    spirv.GlobalVariable @weak_var {linkage_attributes = #spirv.linkage_attributes<linkage_name = "weak_var", linkage_type = <Weak>>} : !spirv.ptr<i32, Private>
  }
}

