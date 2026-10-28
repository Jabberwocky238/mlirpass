"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "kernel_arg_0", type = !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "kernel_arg_1", type = !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "kernel"}> ({
      %0 = "spirv.mlir.addressof"() <{variable = @kernel_arg_0}> : () -> !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>
      %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %2 = "spirv.AccessChain"(%0, %1) : (!spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %4 = "spirv.mlir.addressof"() <{variable = @kernel_arg_1}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<subgroup_size = 64>} : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @kernel, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "main_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x16x16x16xi8>, UniformConstant>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "main_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x16x16x16xi8>, UniformConstant>}> : () -> ()
    "spirv.ARM.GraphEntryPoint"() <{fn = @main, interface = [@main_arg_0, @main_res_0]}> : () -> ()
    "spirv.ARM.Graph"() <{entry_point = true, function_type = (!spirv.arm.tensor<1x16x16x16xi8>) -> !spirv.arm.tensor<1x16x16x16xi8>, sym_name = "main"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x16x16x16xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1x16x16x16xi8>) -> ()
    }) : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [VulkanMemoryModel, Shader, Int8, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>, #spirv.resource_limits<>>} : () -> ()

// -----
// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "kernel_arg_0", type = !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "kernel_arg_1", type = !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "kernel"}> ({
      %0 = "spirv.mlir.addressof"() <{variable = @kernel_arg_0}> : () -> !spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>
      %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %2 = "spirv.AccessChain"(%0, %1) : (!spirv.ptr<!spirv.struct<(f32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<f32, StorageBuffer>
      %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %4 = "spirv.mlir.addressof"() <{variable = @kernel_arg_1}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32, stride=4> [0])>, StorageBuffer>
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<subgroup_size = 64>} : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @kernel, interface = [@kernel_arg_0, @kernel_arg_1]}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "read_image_arg_0", type = !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "read_image_arg_1", type = !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "read_image"}> ({
      %0 = "spirv.mlir.addressof"() <{variable = @read_image_arg_0}> : () -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
      %1 = "spirv.mlir.addressof"() <{variable = @read_image_arg_1}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
      %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %3 = "spirv.Load"(%0) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
      %4 = "spirv.Image"(%3) : (!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>) -> !spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>
      %5 = "spirv.ImageFetch"(%4, %2) : (!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, i32) -> vector<4xf32>
      %6 = "spirv.CompositeExtract"(%5) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
      %7 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %9 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %10 = "spirv.AccessChain"(%1, %7, %2) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%10, %6) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @read_image, interface = [@read_image_arg_0, @read_image_arg_1]}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @read_image, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, Sampled1D], []>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

