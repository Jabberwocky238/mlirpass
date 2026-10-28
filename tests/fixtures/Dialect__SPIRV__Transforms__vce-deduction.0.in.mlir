"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg18: i32):
      %14 = "spirv.IAdd"(%arg18, %arg18) : (i32, i32) -> i32
      "spirv.ReturnValue"(%14) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> vector<4xi32>, sym_name = "group_non_uniform_ballot"}> ({
    ^bb0(%arg17: i1):
      %13 = "spirv.GroupNonUniformBallot"(%arg17) <{execution_scope = #spirv.scope<Workgroup>}> : (i1) -> vector<4xi32>
      "spirv.ReturnValue"(%13) : (vector<4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "select_with_scalar_condition"}> ({
    ^bb0(%arg14: i1, %arg15: vector<2xf32>, %arg16: vector<2xf32>):
      %12 = "spirv.Select"(%arg14, %arg15, %arg16) : (i1, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.ReturnValue"(%12) : (vector<2xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg13: i32):
      %11 = "spirv.IAdd"(%arg13, %arg13) : (i32, i32) -> i32
      "spirv.ReturnValue"(%11) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Float16, Float64, Int16, Int64, VariablePointers], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<PhysicalStorageBuffer64>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{arg_attrs = [{spirv.decoration = #spirv.decoration<Aliased>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, PhysicalStorageBuffer>) -> (), sym_name = "physical_ptr"}> ({
    ^bb0(%arg12: !spirv.ptr<f32, PhysicalStorageBuffer>):
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [PhysicalStorageBufferAddresses], [SPV_EXT_physical_storage_buffer]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg11: i32):
      %10 = "spirv.IAdd"(%arg11, %arg11) : (i32, i32) -> i32
      "spirv.ReturnValue"(%10) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [AtomicStorage], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_iadd"}> ({
    ^bb0(%arg10: i32):
      %9 = "spirv.GroupNonUniformIAdd"(%arg10) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
      "spirv.ReturnValue"(%9) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformArithmetic], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_iadd"}> ({
    ^bb0(%arg9: i32):
      %8 = "spirv.GroupNonUniformIAdd"(%arg9) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
      "spirv.ReturnValue"(%8) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformClustered, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i8) -> i8, sym_name = "iadd_function"}> ({
    ^bb0(%arg8: i8):
      %7 = "spirv.IAdd"(%arg8, %arg8) : (i8, i8) -> i8
      "spirv.ReturnValue"(%7) : (i8) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Int8], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f16) -> f16, sym_name = "fadd_function"}> ({
    ^bb0(%arg7: f16):
      %6 = "spirv.FAdd"(%arg7, %arg7) : (f16, f16) -> f16
      "spirv.ReturnValue"(%6) : (f16) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Float16], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<16xi32>) -> vector<16xi32>, sym_name = "iadd_v16_function"}> ({
    ^bb0(%arg6: vector<16xi32>):
      %5 = "spirv.IAdd"(%arg6, %arg6) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
      "spirv.ReturnValue"(%5) : (vector<16xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, Vector16], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> vector<4xi32>, sym_name = "subgroup_ballot"}> ({
    ^bb0(%arg5: i1):
      %4 = "spirv.KHR.SubgroupBallot"(%arg5) : (i1) -> vector<4xi32>
      "spirv.ReturnValue"(%4) : (vector<4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, SubgroupBallotKHR], [SPV_KHR_shader_ballot, SPV_KHR_shader_clock, SPV_KHR_variable_pointers]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd"}> ({
    ^bb0(%arg4: i32):
      %3 = "spirv.IAdd"(%arg4, %arg4) : (i32, i32) -> i32
      "spirv.ReturnValue"(%3) : (i32) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, VulkanMemoryModel], []>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i16, StorageBuffer>) -> i16, sym_name = "iadd_storage_buffer"}> ({
    ^bb0(%arg3: !spirv.ptr<i16, StorageBuffer>):
      %1 = "spirv.Load"(%arg3) : (!spirv.ptr<i16, StorageBuffer>) -> i16
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
    ^bb0(%arg2: !spirv.ptr<bf16, StorageBuffer>):
      %0 = "spirv.Load"(%arg2) : (!spirv.ptr<bf16, StorageBuffer>) -> bf16
      "spirv.ReturnValue"(%0) : (bf16) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, StorageBuffer16BitAccess, BFloat16TypeKHR], [SPV_KHR_bfloat16, SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>}> ({
    "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<14x19xi8>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<14x19xi8>, sym_name = "argmax"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<14x19xi8>, %arg1: !spirv.arm.tensor<1xf16>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<14x19xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, GraphARM, TensorsARM, Float16], [SPV_ARM_tensors, SPV_ARM_graph]>, #spirv.resource_limits<>>} : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "recursive", type = !spirv.ptr<!spirv.struct<rec, (!spirv.ptr<!spirv.struct<rec>, StorageBuffer>)>, StorageBuffer>}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, Addresses], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

