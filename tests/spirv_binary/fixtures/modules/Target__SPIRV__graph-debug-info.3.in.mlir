"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.6, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_non_semantic_info]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "test_arg_0", type = !spirv.ptr<!spirv.arm.tensor<2x9x3x32xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "test_res_0", type = !spirv.ptr<!spirv.arm.tensor<2x9x3x32xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @test, interface = [@test_arg_0, @test_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{entry_point = true, function_type = (!spirv.arm.tensor<2x9x3x32xi16>) -> !spirv.arm.tensor<2x9x3x32xi8>, sym_name = "test"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<2x9x3x32xi16>):
    %0 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 0 : i32}> : () -> !spirv.arm.tensor<32x1x1x32xi8>
    %1 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 1 : i32}> : () -> !spirv.arm.tensor<32xi64>
    %2 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %3 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %4 = "spirv.Tosa.Conv2D"(%arg0, %0, %1, %2, %3) <{acc_type = #spirv.tosa_ext_acc_type<INT48>, dilation = dense<1> : !spirv.arm.tensor<2xi32>, local_bound = false, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<2x9x3x32xi16>, !spirv.arm.tensor<32x1x1x32xi8>, !spirv.arm.tensor<32xi64>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<2x9x3x32xi64>
    %5 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 2 : i32}> : () -> !spirv.arm.tensor<1xi16>
    %6 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 3 : i32}> : () -> !spirv.arm.tensor<1xi8>
    %7 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi64>}> : () -> !spirv.arm.tensor<1xi64>
    %8 = "spirv.Constant"() <{value = dense<-4> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %9 = "spirv.Tosa.Rescale"(%4, %5, %6, %7, %8) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #spirv.tosa_ext_rounding_mode_type<SingleRound>, scale32 = false}> : (!spirv.arm.tensor<2x9x3x32xi64>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi64>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<2x9x3x32xi8>
    "spirv.ARM.GraphOutputs"(%9) : (!spirv.arm.tensor<2x9x3x32xi8>) -> ()
  }) : () -> ()
}) : () -> ()

