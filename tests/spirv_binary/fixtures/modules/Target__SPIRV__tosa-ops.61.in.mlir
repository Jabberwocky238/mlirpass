"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "select_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<9x2x15x8xi1>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "select_fp_arg_1", type = !spirv.ptr<!spirv.arm.tensor<9x2x15x8xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "select_fp_arg_2", type = !spirv.ptr<!spirv.arm.tensor<9x1x15x8xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "select_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<9x2x15x8xf16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @select_fp, interface = [@select_fp_arg_0, @select_fp_arg_1, @select_fp_arg_2, @select_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<9x2x15x8xi1>, !spirv.arm.tensor<9x2x15x8xf16>, !spirv.arm.tensor<9x1x15x8xf16>) -> !spirv.arm.tensor<9x2x15x8xf16>, sym_name = "select_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<9x2x15x8xi1>, %arg1: !spirv.arm.tensor<9x2x15x8xf16>, %arg2: !spirv.arm.tensor<9x1x15x8xf16>):
    %0 = "spirv.Tosa.Select"(%arg0, %arg1, %arg2) : (!spirv.arm.tensor<9x2x15x8xi1>, !spirv.arm.tensor<9x2x15x8xf16>, !spirv.arm.tensor<9x1x15x8xf16>) -> !spirv.arm.tensor<9x2x15x8xf16>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<9x2x15x8xf16>) -> ()
  }) : () -> ()
}) : () -> ()

