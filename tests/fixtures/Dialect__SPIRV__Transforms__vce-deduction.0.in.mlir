"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg21: i32):
      %14 = "spirv.IAdd"(%arg21, %arg21) : (i32, i32) -> i32
      "spirv.ReturnValue"(%14) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> vector<4xi32>, sym_name = "group_non_uniform_ballot"}> ({
    ^bb0(%arg20: i1):
      %13 = "spirv.GroupNonUniformBallot"(%arg20) <{execution_scope = #spirv.scope<Workgroup>}> : (i1) -> vector<4xi32>
      "spirv.ReturnValue"(%13) : (vector<4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "select_with_scalar_condition"}> ({
    ^bb0(%arg17: i1, %arg18: vector<2xf32>, %arg19: vector<2xf32>):
      %12 = "spirv.Select"(%arg17, %arg18, %arg19) : (i1, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.ReturnValue"(%12) : (vector<2xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg16: i32):
      %11 = "spirv.IAdd"(%arg16, %arg16) : (i32, i32) -> i32
      "spirv.ReturnValue"(%11) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Float16, Float64, Int16, Int64, VariablePointers], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<PhysicalStorageBuffer64>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{arg_attrs = [{spirv.decoration = #spirv.decoration<Aliased>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, PhysicalStorageBuffer>) -> (), sym_name = "physical_ptr"}> ({
    ^bb0(%arg15: !spirv.ptr<f32, PhysicalStorageBuffer>):
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [PhysicalStorageBufferAddresses], [SPV_EXT_physical_storage_buffer]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg14: i32):
      %10 = "spirv.IAdd"(%arg14, %arg14) : (i32, i32) -> i32
      "spirv.ReturnValue"(%10) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [AtomicStorage], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_iadd"}> ({
    ^bb0(%arg13: i32):
      %9 = "spirv.GroupNonUniformIAdd"(%arg13) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
      "spirv.ReturnValue"(%9) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformArithmetic], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_iadd"}> ({
    ^bb0(%arg12: i32):
      %8 = "spirv.GroupNonUniformIAdd"(%arg12) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
      "spirv.ReturnValue"(%8) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformClustered, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i8) -> i8, sym_name = "iadd_function"}> ({
    ^bb0(%arg11: i8):
      %7 = "spirv.IAdd"(%arg11, %arg11) : (i8, i8) -> i8
      "spirv.ReturnValue"(%7) : (i8) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Int8], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f16) -> f16, sym_name = "fadd_function"}> ({
    ^bb0(%arg10: f16):
      %6 = "spirv.FAdd"(%arg10, %arg10) : (f16, f16) -> f16
      "spirv.ReturnValue"(%6) : (f16) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Float16], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<16xi32>) -> vector<16xi32>, sym_name = "iadd_v16_function"}> ({
    ^bb0(%arg9: vector<16xi32>):
      %5 = "spirv.IAdd"(%arg9, %arg9) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
      "spirv.ReturnValue"(%5) : (vector<16xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Vector16], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> vector<4xi32>, sym_name = "subgroup_ballot"}> ({
    ^bb0(%arg8: i1):
      %4 = "spirv.KHR.SubgroupBallot"(%arg8) : (i1) -> vector<4xi32>
      "spirv.ReturnValue"(%4) : (vector<4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, SubgroupBallotKHR], [SPV_KHR_shader_ballot, SPV_KHR_shader_clock, SPV_KHR_variable_pointers]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg7: i32):
      %3 = "spirv.IAdd"(%arg7, %arg7) : (i32, i32) -> i32
      "spirv.ReturnValue"(%3) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, VulkanMemoryModel], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i16, StorageBuffer>) -> i16, sym_name = "iadd_storage_buffer"}> ({
    ^bb0(%arg6: !spirv.ptr<i16, StorageBuffer>):
      %1 = "spirv.Load"(%arg6) : (!spirv.ptr<i16, StorageBuffer>) -> i16
      %2 = "spirv.IAdd"(%1, %1) : (i16, i16) -> i16
      "spirv.ReturnValue"(%2) : (i16) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, StorageBuffer16BitAccess, Int16], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "data", type = !spirv.ptr<!spirv.struct<(i8 [0], f16 [2], i64 [4])>, Uniform>}> : () -> ()
    "spirv.GlobalVariable"() <{sym_name = "img", type = !spirv.ptr<!spirv.image<f32, Buffer, NoDepth, NonArrayed, SingleSampled, SamplerUnknown, Rg32f>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, UniformAndStorageBuffer8BitAccess, StorageBuffer16BitAccess, StorageUniform16, Int16, Int64, ImageBuffer, StorageImageExtendedFormats], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<bf16, StorageBuffer>) -> bf16, sym_name = "load_bf16"}> ({
    ^bb0(%arg5: !spirv.ptr<bf16, StorageBuffer>):
      %0 = "spirv.Load"(%arg5) : (!spirv.ptr<bf16, StorageBuffer>) -> bf16
      "spirv.ReturnValue"(%0) : (bf16) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, StorageBuffer16BitAccess, BFloat16TypeKHR], [SPV_KHR_bfloat16, SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<4x4xbf16, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xbf16, Subgroup, MatrixA>, sym_name = "bf16_coopmatrix"}> ({
    ^bb0(%arg4: !spirv.coopmatrix<4x4xbf16, Subgroup, MatrixA>):
      "spirv.ReturnValue"(%arg4) : (!spirv.coopmatrix<4x4xbf16, Subgroup, MatrixA>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, BFloat16TypeKHR, BFloat16CooperativeMatrixKHR], [SPV_KHR_cooperative_matrix, SPV_KHR_bfloat16]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<4x4xf8E4M3FN, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xf8E4M3FN, Subgroup, MatrixA>, sym_name = "f8_coopmatrix"}> ({
    ^bb0(%arg3: !spirv.coopmatrix<4x4xf8E4M3FN, Subgroup, MatrixA>):
      "spirv.ReturnValue"(%arg3) : (!spirv.coopmatrix<4x4xf8E4M3FN, Subgroup, MatrixA>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float8EXT, Float8CooperativeMatrixEXT], [SPV_KHR_cooperative_matrix, SPV_EXT_float8]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<4x4xf8E5M2, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xf8E5M2, Subgroup, MatrixA>, sym_name = "f8_coopmatrix"}> ({
    ^bb0(%arg2: !spirv.coopmatrix<4x4xf8E5M2, Subgroup, MatrixA>):
      "spirv.ReturnValue"(%arg2) : (!spirv.coopmatrix<4x4xf8E5M2, Subgroup, MatrixA>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float8EXT, Float8CooperativeMatrixEXT], [SPV_KHR_cooperative_matrix, SPV_EXT_float8]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>}> ({
    "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<14x19xi8>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<14x19xi8>, sym_name = "argmax"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<14x19xi8>, %arg1: !spirv.arm.tensor<1xf16>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<14x19xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, GraphARM, TensorsARM, Float16], [SPV_ARM_tensors, SPV_ARM_graph]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "var", type = !spirv.ptr<!spirv.struct<(i32 [0])>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, VulkanMemoryModel], [SPV_KHR_vulkan_memory_model]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "recursive", type = !spirv.ptr<!spirv.struct<rec, (!spirv.ptr<!spirv.struct<rec>, StorageBuffer>)>, StorageBuffer>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, Addresses], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_2d_ms_storage", type = !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, StorageImageMultisample], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_2d_ms_arrayed_storage", type = !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, Arrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, StorageImageMultisample, ImageMSArray], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_2d_storage", type = !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_cube", type = !spirv.ptr<!spirv.image<f32, Cube, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_cube_arrayed", type = !spirv.ptr<!spirv.image<f32, Cube, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, ImageCubeArray], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_1d_storage", type = !spirv.ptr<!spirv.image<f32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Image1D], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_1d_sampled", type = !spirv.ptr<!spirv.image<f32, Dim1D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Sampled1D], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_buffer_storage", type = !spirv.ptr<!spirv.image<f32, Buffer, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, ImageBuffer], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "img_2d_i64", type = !spirv.ptr<!spirv.image<i64, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int64, Int64ImageEXT], [SPV_EXT_shader_image_int64]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), linkage_attributes = #spirv.linkage_attributes<linkage_name = "linkonce_odr_fn", linkage_type = <LinkOnceODR>>, sym_name = "linkonce_odr_fn"}> ({
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Linkage], [SPV_KHR_linkonce_odr]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{linkage_attributes = #spirv.linkage_attributes<linkage_name = "weak_var", linkage_type = <Weak>>, sym_name = "weak_var", type = !spirv.ptr<i32, Private>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, WeakLinkageAMD], [SPV_AMD_weak_linkage]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

