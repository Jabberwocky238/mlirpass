"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "resize_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x1x31x55xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "resize_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x1x278x55xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @resize_int, interface = [@resize_int_arg_0, @resize_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x1x31x55xi8>) -> !spirv.arm.tensor<1x1x278x55xi8>, sym_name = "resize_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x1x31x55xi8>):
    %0 = "spirv.Constant"() <{value = dense<[16, 1, 9, 1]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %1 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %2 = "spirv.Constant"() <{value = dense<[0, 7]> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %3 = "spirv.Tosa.Resize"(%arg0, %0, %1, %2) <{mode = #spirv.tosa_ext_resize_mode_type<NearestNeighbor>}> : (!spirv.arm.tensor<1x1x31x55xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<2xi32>) -> !spirv.arm.tensor<1x1x278x55xi8>
    "spirv.ARM.GraphOutputs"(%3) : (!spirv.arm.tensor<1x1x278x55xi8>) -> ()
  }) : () -> ()
}) : () -> ()

