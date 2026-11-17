"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "clamp_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<18x5x17x6xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "clamp_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<18x5x17x6xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @clamp_fp, interface = [@clamp_fp_arg_0, @clamp_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<18x5x17x6xf32>) -> !spirv.arm.tensor<18x5x17x6xf32>, sym_name = "clamp_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<18x5x17x6xf32>):
    %0 = "spirv.Tosa.Clamp"(%arg0) <{max_val = 2.38255944E+38 : f32, min_val = -1.19339396E+38 : f32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Ignore>}> : (!spirv.arm.tensor<18x5x17x6xf32>) -> !spirv.arm.tensor<18x5x17x6xf32>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<18x5x17x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

