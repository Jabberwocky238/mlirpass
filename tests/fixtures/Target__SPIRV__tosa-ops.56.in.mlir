"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "negate_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<2x7x15x13xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "negate_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<2x7x15x13xf16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @negate_fp, interface = [@negate_fp_arg_0, @negate_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x7x15x13xf16>) -> !spirv.arm.tensor<2x7x15x13xf16>, sym_name = "negate_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<2x7x15x13xf16>):
    %0 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %1 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %2 = "spirv.Tosa.Negate"(%arg0, %0, %1) : (!spirv.arm.tensor<2x7x15x13xf16>, !spirv.arm.tensor<1xf16>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<2x7x15x13xf16>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<2x7x15x13xf16>) -> ()
  }) : () -> ()
}) : () -> ()

