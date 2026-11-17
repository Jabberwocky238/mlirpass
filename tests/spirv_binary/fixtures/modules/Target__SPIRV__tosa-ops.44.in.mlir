"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "table_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<3x2x15x7xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "table_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<3x2x15x7xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @table_int, interface = [@table_int_arg_0, @table_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x2x15x7xi8>) -> !spirv.arm.tensor<3x2x15x7xi8>, sym_name = "table_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<3x2x15x7xi8>):
    %0 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 0 : i32}> : () -> !spirv.arm.tensor<256xi8>
    %1 = "spirv.Tosa.Table"(%arg0, %0) : (!spirv.arm.tensor<3x2x15x7xi8>, !spirv.arm.tensor<256xi8>) -> !spirv.arm.tensor<3x2x15x7xi8>
    "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<3x2x15x7xi8>) -> ()
  }) : () -> ()
}) : () -> ()

