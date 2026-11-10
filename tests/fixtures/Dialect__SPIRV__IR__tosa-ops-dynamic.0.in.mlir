"builtin.module"() ({
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<?x?x?xi16>) -> !spirv.arm.tensor<?x?x?xi16>, sym_name = "rescale_per_channel_dynamic_input_last_dimension"}> ({
  ^bb0(%arg3: !spirv.arm.tensor<?x?x?xi16>):
    %3 = "spirv.Constant"() <{value = dense<1> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %4 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<2xi8>}> : () -> !spirv.arm.tensor<2xi8>
    %5 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %6 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %7 = "spirv.Tosa.Rescale"(%arg3, %3, %4, %5, %6) <{input_unsigned = false, output_unsigned = false, per_channel = true, rounding_mode = #spirv.tosa_ext_rounding_mode_type<SingleRound>, scale32 = false}> : (!spirv.arm.tensor<?x?x?xi16>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<2xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16>) -> !spirv.arm.tensor<?x?x?xi16>
    "spirv.ARM.GraphOutputs"(%7) : (!spirv.arm.tensor<?x?x?xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x3x4xi16>, !spirv.arm.tensor<?xi16>, !spirv.arm.tensor<?xi8>) -> !spirv.arm.tensor<2x3x4xi16>, sym_name = "rescale_per_channel_dynamic_multiplier_and_shift_length"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<2x3x4xi16>, %arg1: !spirv.arm.tensor<?xi16>, %arg2: !spirv.arm.tensor<?xi8>):
    %0 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %1 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %2 = "spirv.Tosa.Rescale"(%arg0, %arg1, %arg2, %0, %1) <{input_unsigned = false, output_unsigned = false, per_channel = true, rounding_mode = #spirv.tosa_ext_rounding_mode_type<SingleRound>, scale32 = false}> : (!spirv.arm.tensor<2x3x4xi16>, !spirv.arm.tensor<?xi16>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16>) -> !spirv.arm.tensor<2x3x4xi16>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<2x3x4xi16>) -> ()
  }) : () -> ()
}) : () -> ()

