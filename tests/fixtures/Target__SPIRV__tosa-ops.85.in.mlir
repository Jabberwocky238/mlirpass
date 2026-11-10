"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "slice_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<32x19x41xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "slice_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<21x5x2xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @slice_int, interface = [@slice_int_arg_0, @slice_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<32x19x41xi8>) -> !spirv.arm.tensor<21x5x2xi8>, sym_name = "slice_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<32x19x41xi8>):
    %0 = "spirv.Constant"() <{value = dense<[8, 11, 39]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[21, 5, 2]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %2 = "spirv.Tosa.Slice"(%arg0, %0, %1) : (!spirv.arm.tensor<32x19x41xi8>, !spirv.arm.tensor<3xi32>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<21x5x2xi8>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<21x5x2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

