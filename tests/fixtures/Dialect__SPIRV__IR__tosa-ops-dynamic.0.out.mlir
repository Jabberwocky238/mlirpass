module {
  spirv.ARM.Graph @rescale_per_channel_dynamic_input_last_dimension(%arg0: !spirv.arm.tensor<?x?x?xi16>) -> !spirv.arm.tensor<?x?x?xi16> {
    %cst = spirv.Constant dense<1> : !spirv.arm.tensor<1xi16>
    %cst_0 = spirv.Constant dense<0> : !spirv.arm.tensor<2xi8>
    %cst_1 = spirv.Constant dense<0> : !spirv.arm.tensor<1xi16>
    %cst_2 = spirv.Constant dense<0> : !spirv.arm.tensor<1xi16>
    %0 = spirv.Tosa.Rescale scale32 = false, rounding_mode = <SingleRound>, per_channel = true, input_unsigned = false, output_unsigned = false, %arg0, %cst, %cst_0, %cst_1, %cst_2 : !spirv.arm.tensor<?x?x?xi16>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<2xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16> -> !spirv.arm.tensor<?x?x?xi16>
    spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<?x?x?xi16>
  }
  spirv.ARM.Graph @rescale_per_channel_dynamic_multiplier_and_shift_length(%arg0: !spirv.arm.tensor<2x3x4xi16>, %arg1: !spirv.arm.tensor<?xi16>, %arg2: !spirv.arm.tensor<?xi8>) -> !spirv.arm.tensor<2x3x4xi16> {
    %cst = spirv.Constant dense<0> : !spirv.arm.tensor<1xi16>
    %cst_0 = spirv.Constant dense<0> : !spirv.arm.tensor<1xi16>
    %0 = spirv.Tosa.Rescale scale32 = false, rounding_mode = <SingleRound>, per_channel = true, input_unsigned = false, output_unsigned = false, %arg0, %arg1, %arg2, %cst, %cst_0 : !spirv.arm.tensor<2x3x4xi16>, !spirv.arm.tensor<?xi16>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16> -> !spirv.arm.tensor<2x3x4xi16>
    spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x3x4xi16>
  }
}

