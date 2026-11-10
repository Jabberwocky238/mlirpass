"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "resize_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x48x33x63xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "resize_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x753x297x63xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @resize_fp, interface = [@resize_fp_arg_0, @resize_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x48x33x63xf32>) -> !spirv.arm.tensor<1x753x297x63xf32>, sym_name = "resize_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x48x33x63xf32>):
    %0 = "spirv.Constant"() <{value = dense<[16, 1, 9, 1]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %1 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %2 = "spirv.Constant"() <{value = dense<[0, 8]> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %3 = "spirv.Tosa.Resize"(%arg0, %0, %1, %2) <{mode = #spirv.tosa_ext_resize_mode_type<Bilinear>}> : (!spirv.arm.tensor<1x48x33x63xf32>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<2xi32>) -> !spirv.arm.tensor<1x753x297x63xf32>
    "spirv.ARM.GraphOutputs"(%3) : (!spirv.arm.tensor<1x753x297x63xf32>) -> ()
  }) : () -> ()
}) : () -> ()

