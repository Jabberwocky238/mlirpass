"builtin.module"() ({
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x16xf32>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>, sym_name = "experimental_ml_call"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x16xf32>, %arg1: !spirv.arm.tensor<1x16xf32>):
    %0 = "spirv.Constant"() <{value = dense<[83, 101, 108, 102, 65, 116, 116, 101, 110, 116, 105, 111, 110, 79, 112]> : tensor<15xi8>}> : () -> !spirv.array<15 x i8>
    %1 = "spirv.ExperimentalML.Call"(%0, %arg0, %arg1) <{opcode = 0 : i32}> : (!spirv.array<15 x i8>, !spirv.arm.tensor<1x16xf32>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
    "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

