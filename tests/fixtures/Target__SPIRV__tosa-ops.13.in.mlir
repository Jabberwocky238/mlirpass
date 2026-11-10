"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "maxpool2d_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x3x65537x1xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "maxpool2d_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x2x32769x1xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @maxpool2d_int, interface = [@maxpool2d_int_arg_0, @maxpool2d_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x3x65537x1xi8>) -> !spirv.arm.tensor<1x2x32769x1xi8>, sym_name = "maxpool2d_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x3x65537x1xi8>):
    %0 = "spirv.Tosa.MaxPool2D"(%arg0) <{kernel = dense<[3, 2]> : !spirv.arm.tensor<2xi32>, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>, pad = dense<[1, 0, 0, 1]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x3x65537x1xi8>) -> !spirv.arm.tensor<1x2x32769x1xi8>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x2x32769x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

