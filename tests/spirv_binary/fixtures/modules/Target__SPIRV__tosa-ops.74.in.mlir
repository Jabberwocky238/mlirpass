"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "reduceproduct_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<2x16x25xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "reduceproduct_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<2x16x1xf16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @reduceproduct_fp, interface = [@reduceproduct_fp_arg_0, @reduceproduct_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x16x25xf16>) -> !spirv.arm.tensor<2x16x1xf16>, sym_name = "reduceproduct_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<2x16x25xf16>):
    %0 = "spirv.Tosa.ReduceProduct"(%arg0) <{axis = 2 : i32}> : (!spirv.arm.tensor<2x16x25xf16>) -> !spirv.arm.tensor<2x16x1xf16>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x16x1xf16>) -> ()
  }) : () -> ()
}) : () -> ()

