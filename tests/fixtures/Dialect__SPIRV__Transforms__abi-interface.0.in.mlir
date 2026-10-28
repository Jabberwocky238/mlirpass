"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], function_control = #spirv.function_control<None>, function_type = (f32, !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, StorageBuffer>) -> (), sym_name = "kernel"}> ({
    ^bb0(%arg0: f32, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, StorageBuffer>):
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1], subgroup_size = 64>} : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x16x16x16xi8>) -> !spirv.arm.tensor<1x16x16x16xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "main"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x16x16x16xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1x16x16x16xi8>) -> ()
    }) : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [VulkanMemoryModel, Shader, Int8, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
  ^bb0:
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], function_control = #spirv.function_control<None>, function_type = (f32, !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, StorageBuffer>) -> (), sym_name = "kernel"}> ({
    ^bb0(%arg0: f32, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, StorageBuffer>):
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1], subgroup_size = 64>} : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>, !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "read_image"}> ({
    ^bb0(%arg0: !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.Load"(%arg0) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
      %2 = "spirv.Image"(%1) : (!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>) -> !spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>
      %3 = "spirv.ImageFetch"(%2, %0) : (!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, i32) -> vector<4xf32>
      %4 = "spirv.CompositeExtract"(%3) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
      %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %7 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %8 = "spirv.AccessChain"(%arg1, %5, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%8, %4) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [1, 1, 1]>} : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, Sampled1D], []>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

