"builtin.module"() ({
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x28x17x17xi8>) -> !spirv.arm.tensor<3x28x17xi32>, sym_name = "argmax_int"}> ({
  ^bb0(%arg160: !spirv.arm.tensor<3x28x17x17xi8>):
    %156 = "spirv.Tosa.ArgMax"(%arg160) <{axis = 3 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<3x28x17x17xi8>) -> !spirv.arm.tensor<3x28x17xi32>
    "spirv.ARM.GraphOutputs"(%156) : (!spirv.arm.tensor<3x28x17xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x2x7x14xf32>) -> !spirv.arm.tensor<2x2x14xi32>, sym_name = "argmax_fp"}> ({
  ^bb0(%arg159: !spirv.arm.tensor<2x2x7x14xf32>):
    %155 = "spirv.Tosa.ArgMax"(%arg159) <{axis = 2 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<2x2x7x14xf32>) -> !spirv.arm.tensor<2x2x14xi32>
    "spirv.ARM.GraphOutputs"(%155) : (!spirv.arm.tensor<2x2x14xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x3x65537x1xi8>) -> !spirv.arm.tensor<1x2x32768x1xi8>, sym_name = "avgpool2d_int"}> ({
  ^bb0(%arg158: !spirv.arm.tensor<1x3x65537x1xi8>):
    %152 = "spirv.Constant"() <{value = dense<125> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %153 = "spirv.Constant"() <{value = dense<-90> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %154 = "spirv.Tosa.AvgPool2D"(%arg158, %152, %153) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, kernel = dense<3> : !spirv.arm.tensor<2xi32>, pad = dense<[0, 1, 0, 0]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x3x65537x1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x32768x1xi8>
    "spirv.ARM.GraphOutputs"(%154) : (!spirv.arm.tensor<1x2x32768x1xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x2x65533x2xf32>) -> !spirv.arm.tensor<1x2x65532x2xf32>, sym_name = "avgpool2d_fp"}> ({
  ^bb0(%arg157: !spirv.arm.tensor<1x2x65533x2xf32>):
    %149 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %150 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %151 = "spirv.Tosa.AvgPool2D"(%arg157, %149, %150) <{acc_type = #spirv.tosa_ext_acc_type<FP32>, kernel = dense<2> : !spirv.arm.tensor<2xi32>, pad = dense<[1, 0, 0, 0]> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x2x65533x2xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x2x65532x2xf32>
    "spirv.ARM.GraphOutputs"(%151) : (!spirv.arm.tensor<1x2x65532x2xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x65535x3x1xi8>, !spirv.arm.tensor<7x1x1x1xi8>, !spirv.arm.tensor<1xi32>) -> !spirv.arm.tensor<1x65536x2x7xi32>, sym_name = "conv2d_int"}> ({
  ^bb0(%arg154: !spirv.arm.tensor<1x65535x3x1xi8>, %arg155: !spirv.arm.tensor<7x1x1x1xi8>, %arg156: !spirv.arm.tensor<1xi32>):
    %146 = "spirv.Constant"() <{value = dense<35> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %147 = "spirv.Constant"() <{value = dense<57> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %148 = "spirv.Tosa.Conv2D"(%arg154, %arg155, %arg156, %146, %147) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, dilation = dense<[7, 1]> : !spirv.arm.tensor<2xi32>, local_bound = false, pad = dense<[1, 0, 0, 0]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x65535x3x1xi8>, !spirv.arm.tensor<7x1x1x1xi8>, !spirv.arm.tensor<1xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x65536x2x7xi32>
    "spirv.ARM.GraphOutputs"(%148) : (!spirv.arm.tensor<1x65536x2x7xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x34x18x27xf16>, !spirv.arm.tensor<11x1x1x27xf16>, !spirv.arm.tensor<11xf16>) -> !spirv.arm.tensor<1x34x18x11xf16>, sym_name = "conv2d_fp"}> ({
  ^bb0(%arg151: !spirv.arm.tensor<1x34x18x27xf16>, %arg152: !spirv.arm.tensor<11x1x1x27xf16>, %arg153: !spirv.arm.tensor<11xf16>):
    %143 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %144 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %145 = "spirv.Tosa.Conv2D"(%arg151, %arg152, %arg153, %143, %144) <{acc_type = #spirv.tosa_ext_acc_type<FP16>, dilation = dense<1> : !spirv.arm.tensor<2xi32>, local_bound = true, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x34x18x27xf16>, !spirv.arm.tensor<11x1x1x27xf16>, !spirv.arm.tensor<11xf16>, !spirv.arm.tensor<1xf16>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<1x34x18x11xf16>
    "spirv.ARM.GraphOutputs"(%145) : (!spirv.arm.tensor<1x34x18x11xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x9x21x14x1xi8>, !spirv.arm.tensor<2x1x2x1x1xi8>, !spirv.arm.tensor<1xi32>) -> !spirv.arm.tensor<1x9x20x14x2xi32>, sym_name = "conv3d_int"}> ({
  ^bb0(%arg148: !spirv.arm.tensor<1x9x21x14x1xi8>, %arg149: !spirv.arm.tensor<2x1x2x1x1xi8>, %arg150: !spirv.arm.tensor<1xi32>):
    %140 = "spirv.Constant"() <{value = dense<123> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %141 = "spirv.Constant"() <{value = dense<121> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %142 = "spirv.Tosa.Conv3D"(%arg148, %arg149, %arg150, %140, %141) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, dilation = dense<1> : !spirv.arm.tensor<3xi32>, local_bound = false, pad = dense<0> : !spirv.arm.tensor<6xi32>, stride = dense<1> : !spirv.arm.tensor<3xi32>}> : (!spirv.arm.tensor<1x9x21x14x1xi8>, !spirv.arm.tensor<2x1x2x1x1xi8>, !spirv.arm.tensor<1xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x9x20x14x2xi32>
    "spirv.ARM.GraphOutputs"(%142) : (!spirv.arm.tensor<1x9x20x14x2xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x2x65539x1x2xf32>, !spirv.arm.tensor<1x1x1x1x2xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x3x65540x2x1xf32>, sym_name = "conv3d_fp"}> ({
  ^bb0(%arg145: !spirv.arm.tensor<1x2x65539x1x2xf32>, %arg146: !spirv.arm.tensor<1x1x1x1x2xf32>, %arg147: !spirv.arm.tensor<1xf32>):
    %137 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %138 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %139 = "spirv.Tosa.Conv3D"(%arg145, %arg146, %arg147, %137, %138) <{acc_type = #spirv.tosa_ext_acc_type<FP32>, dilation = dense<[1, 1, 7]> : !spirv.arm.tensor<3xi32>, local_bound = false, pad = dense<[0, 1, 1, 0, 0, 1]> : !spirv.arm.tensor<6xi32>, stride = dense<1> : !spirv.arm.tensor<3xi32>}> : (!spirv.arm.tensor<1x2x65539x1x2xf32>, !spirv.arm.tensor<1x1x1x1x2xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x3x65540x2x1xf32>
    "spirv.ARM.GraphOutputs"(%139) : (!spirv.arm.tensor<1x3x65540x2x1xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x4x65537x1xi8>, !spirv.arm.tensor<1x3x1x4xi8>, !spirv.arm.tensor<4xi32>) -> !spirv.arm.tensor<1x4x32762x4xi32>, sym_name = "depthwiseconv2d_int"}> ({
  ^bb0(%arg142: !spirv.arm.tensor<1x4x65537x1xi8>, %arg143: !spirv.arm.tensor<1x3x1x4xi8>, %arg144: !spirv.arm.tensor<4xi32>):
    %134 = "spirv.Constant"() <{value = dense<58> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %135 = "spirv.Constant"() <{value = dense<-106> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %136 = "spirv.Tosa.DepthwiseConv2D"(%arg142, %arg143, %arg144, %134, %135) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, dilation = dense<7> : !spirv.arm.tensor<2xi32>, local_bound = false, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x4x65537x1xi8>, !spirv.arm.tensor<1x3x1x4xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x4x32762x4xi32>
    "spirv.ARM.GraphOutputs"(%136) : (!spirv.arm.tensor<1x4x32762x4xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x65540x1x3xf32>, !spirv.arm.tensor<1x1x3x1xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x65541x2x3xf32>, sym_name = "depthwiseconv2d_fp"}> ({
  ^bb0(%arg139: !spirv.arm.tensor<1x65540x1x3xf32>, %arg140: !spirv.arm.tensor<1x1x3x1xf32>, %arg141: !spirv.arm.tensor<1xf32>):
    %131 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %132 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %133 = "spirv.Tosa.DepthwiseConv2D"(%arg139, %arg140, %arg141, %131, %132) <{acc_type = #spirv.tosa_ext_acc_type<FP32>, dilation = dense<[1, 7]> : !spirv.arm.tensor<2xi32>, local_bound = true, pad = dense<[0, 1, 1, 1]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x65540x1x3xf32>, !spirv.arm.tensor<1x1x3x1xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x65541x2x3xf32>
    "spirv.ARM.GraphOutputs"(%133) : (!spirv.arm.tensor<1x65541x2x3xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>), sym_name = "fft2d_fft"}> ({
  ^bb0(%arg137: !spirv.arm.tensor<1x32x32xf32>, %arg138: !spirv.arm.tensor<1x32x32xf32>):
    %128 = "spirv.Tosa.FFT2D"(%arg137, %arg138) <{inverse = true, local_bound = false}> : (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> !spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>
    %129 = "spirv.CompositeExtract"(%128) <{indices = [0 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>) -> !spirv.arm.tensor<1x32x32xf32>
    %130 = "spirv.CompositeExtract"(%128) <{indices = [1 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>) -> !spirv.arm.tensor<1x32x32xf32>
    "spirv.ARM.GraphOutputs"(%129, %130) : (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<8x2x3xi8>, !spirv.arm.tensor<8x3x8xi8>) -> !spirv.arm.tensor<8x2x8xi32>, sym_name = "matmul_int"}> ({
  ^bb0(%arg135: !spirv.arm.tensor<8x2x3xi8>, %arg136: !spirv.arm.tensor<8x3x8xi8>):
    %125 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %126 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %127 = "spirv.Tosa.MatMul"(%arg135, %arg136, %125, %126) : (!spirv.arm.tensor<8x2x3xi8>, !spirv.arm.tensor<8x3x8xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<8x2x8xi32>
    "spirv.ARM.GraphOutputs"(%127) : (!spirv.arm.tensor<8x2x8xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<15x39x50xf16>, !spirv.arm.tensor<15x50x24xf16>) -> !spirv.arm.tensor<15x39x24xf16>, sym_name = "matmul_fp"}> ({
  ^bb0(%arg133: !spirv.arm.tensor<15x39x50xf16>, %arg134: !spirv.arm.tensor<15x50x24xf16>):
    %122 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %123 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %124 = "spirv.Tosa.MatMul"(%arg133, %arg134, %122, %123) : (!spirv.arm.tensor<15x39x50xf16>, !spirv.arm.tensor<15x50x24xf16>, !spirv.arm.tensor<1xf16>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<15x39x24xf16>
    "spirv.ARM.GraphOutputs"(%124) : (!spirv.arm.tensor<15x39x24xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x3x65537x1xi8>) -> !spirv.arm.tensor<1x2x32769x1xi8>, sym_name = "maxpool2d_int"}> ({
  ^bb0(%arg132: !spirv.arm.tensor<1x3x65537x1xi8>):
    %121 = "spirv.Tosa.MaxPool2D"(%arg132) <{kernel = dense<[3, 2]> : !spirv.arm.tensor<2xi32>, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>, pad = dense<[1, 0, 0, 1]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x3x65537x1xi8>) -> !spirv.arm.tensor<1x2x32769x1xi8>
    "spirv.ARM.GraphOutputs"(%121) : (!spirv.arm.tensor<1x2x32769x1xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x6x65536x1xf32>) -> !spirv.arm.tensor<1x3x32769x1xf32>, sym_name = "maxpool2d_fp"}> ({
  ^bb0(%arg131: !spirv.arm.tensor<1x6x65536x1xf32>):
    %120 = "spirv.Tosa.MaxPool2D"(%arg131) <{kernel = dense<[3, 2]> : !spirv.arm.tensor<2xi32>, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>, pad = dense<[1, 0, 1, 1]> : !spirv.arm.tensor<4xi32>, stride = dense<2> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x6x65536x1xf32>) -> !spirv.arm.tensor<1x3x32769x1xf32>
    "spirv.ARM.GraphOutputs"(%120) : (!spirv.arm.tensor<1x3x32769x1xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x32x32xf32>) -> (!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>), sym_name = "rfft2d_fft"}> ({
  ^bb0(%arg130: !spirv.arm.tensor<1x32x32xf32>):
    %117 = "spirv.Tosa.RFFT2D"(%arg130) <{local_bound = false}> : (!spirv.arm.tensor<1x32x32xf32>) -> !spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>
    %118 = "spirv.CompositeExtract"(%117) <{indices = [0 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>) -> !spirv.arm.tensor<1x32x17xf32>
    %119 = "spirv.CompositeExtract"(%117) <{indices = [1 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>) -> !spirv.arm.tensor<1x32x17xf32>
    "spirv.ARM.GraphOutputs"(%118, %119) : (!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x13x33x3xi16>, !spirv.arm.tensor<11x1x3x3xi8>, !spirv.arm.tensor<1xi64>) -> !spirv.arm.tensor<1x13x35x11xi64>, sym_name = "transposeconv2d_int"}> ({
  ^bb0(%arg127: !spirv.arm.tensor<1x13x33x3xi16>, %arg128: !spirv.arm.tensor<11x1x3x3xi8>, %arg129: !spirv.arm.tensor<1xi64>):
    %114 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %115 = "spirv.Constant"() <{value = dense<88> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %116 = "spirv.Tosa.TransposeConv2D"(%arg127, %arg128, %arg129, %114, %115) <{acc_type = #spirv.tosa_ext_acc_type<INT48>, local_bound = false, out_pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x13x33x3xi16>, !spirv.arm.tensor<11x1x3x3xi8>, !spirv.arm.tensor<1xi64>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x13x35x11xi64>
    "spirv.ARM.GraphOutputs"(%116) : (!spirv.arm.tensor<1x13x35x11xi64>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<10x24x9x13xf16>, !spirv.arm.tensor<14x1x1x13xf16>, !spirv.arm.tensor<14xf16>) -> !spirv.arm.tensor<10x25x65x14xf16>, sym_name = "transposeconv2d_fp"}> ({
  ^bb0(%arg124: !spirv.arm.tensor<10x24x9x13xf16>, %arg125: !spirv.arm.tensor<14x1x1x13xf16>, %arg126: !spirv.arm.tensor<14xf16>):
    %111 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %112 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %113 = "spirv.Tosa.TransposeConv2D"(%arg124, %arg125, %arg126, %111, %112) <{acc_type = #spirv.tosa_ext_acc_type<FP16>, local_bound = true, out_pad = dense<[0, 1, 0, 0]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 8]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<10x24x9x13xf16>, !spirv.arm.tensor<14x1x1x13xf16>, !spirv.arm.tensor<14xf16>, !spirv.arm.tensor<1xf16>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<10x25x65x14xf16>
    "spirv.ARM.GraphOutputs"(%113) : (!spirv.arm.tensor<10x25x65x14xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<27x44x55xi8>) -> !spirv.arm.tensor<27x44x55xi8>, sym_name = "clamp_int"}> ({
  ^bb0(%arg123: !spirv.arm.tensor<27x44x55xi8>):
    %110 = "spirv.Tosa.Clamp"(%arg123) <{max_val = -100 : i8, min_val = -102 : i8, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<27x44x55xi8>) -> !spirv.arm.tensor<27x44x55xi8>
    "spirv.ARM.GraphOutputs"(%110) : (!spirv.arm.tensor<27x44x55xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<18x5x17x6xf32>) -> !spirv.arm.tensor<18x5x17x6xf32>, sym_name = "clamp_fp"}> ({
  ^bb0(%arg122: !spirv.arm.tensor<18x5x17x6xf32>):
    %109 = "spirv.Tosa.Clamp"(%arg122) <{max_val = 2.38255944E+38 : f32, min_val = -1.19339396E+38 : f32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Ignore>}> : (!spirv.arm.tensor<18x5x17x6xf32>) -> !spirv.arm.tensor<18x5x17x6xf32>
    "spirv.ARM.GraphOutputs"(%109) : (!spirv.arm.tensor<18x5x17x6xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<47x38x51xf32>) -> !spirv.arm.tensor<47x38x51xf32>, sym_name = "erf_fp"}> ({
  ^bb0(%arg121: !spirv.arm.tensor<47x38x51xf32>):
    %108 = "spirv.Tosa.Erf"(%arg121) : (!spirv.arm.tensor<47x38x51xf32>) -> !spirv.arm.tensor<47x38x51xf32>
    "spirv.ARM.GraphOutputs"(%108) : (!spirv.arm.tensor<47x38x51xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<28x43x45xf32>) -> !spirv.arm.tensor<28x43x45xf32>, sym_name = "sigmoid_fp"}> ({
  ^bb0(%arg120: !spirv.arm.tensor<28x43x45xf32>):
    %107 = "spirv.Tosa.Sigmoid"(%arg120) : (!spirv.arm.tensor<28x43x45xf32>) -> !spirv.arm.tensor<28x43x45xf32>
    "spirv.ARM.GraphOutputs"(%107) : (!spirv.arm.tensor<28x43x45xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<46x50x36xf16>) -> !spirv.arm.tensor<46x50x36xf16>, sym_name = "tanh_fp"}> ({
  ^bb0(%arg119: !spirv.arm.tensor<46x50x36xf16>):
    %106 = "spirv.Tosa.Tanh"(%arg119) : (!spirv.arm.tensor<46x50x36xf16>) -> !spirv.arm.tensor<46x50x36xf16>
    "spirv.ARM.GraphOutputs"(%106) : (!spirv.arm.tensor<46x50x36xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<4x7x3x10xi32>, !spirv.arm.tensor<4x7x3x1xi32>) -> !spirv.arm.tensor<4x7x3x10xi32>, sym_name = "add_int"}> ({
  ^bb0(%arg117: !spirv.arm.tensor<4x7x3x10xi32>, %arg118: !spirv.arm.tensor<4x7x3x1xi32>):
    %105 = "spirv.Tosa.Add"(%arg117, %arg118) : (!spirv.arm.tensor<4x7x3x10xi32>, !spirv.arm.tensor<4x7x3x1xi32>) -> !spirv.arm.tensor<4x7x3x10xi32>
    "spirv.ARM.GraphOutputs"(%105) : (!spirv.arm.tensor<4x7x3x10xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<26x37x18xf16>, !spirv.arm.tensor<1x37x18xf16>) -> !spirv.arm.tensor<26x37x18xf16>, sym_name = "add_fp"}> ({
  ^bb0(%arg115: !spirv.arm.tensor<26x37x18xf16>, %arg116: !spirv.arm.tensor<1x37x18xf16>):
    %104 = "spirv.Tosa.Add"(%arg115, %arg116) : (!spirv.arm.tensor<26x37x18xf16>, !spirv.arm.tensor<1x37x18xf16>) -> !spirv.arm.tensor<26x37x18xf16>
    "spirv.ARM.GraphOutputs"(%104) : (!spirv.arm.tensor<26x37x18xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x47x22xi16>, !spirv.arm.tensor<49x47x22xi16>) -> !spirv.arm.tensor<49x47x22xi16>, sym_name = "arithmeticrightshift_int"}> ({
  ^bb0(%arg113: !spirv.arm.tensor<1x47x22xi16>, %arg114: !spirv.arm.tensor<49x47x22xi16>):
    %103 = "spirv.Tosa.ArithmeticRightShift"(%arg113, %arg114) <{round = true}> : (!spirv.arm.tensor<1x47x22xi16>, !spirv.arm.tensor<49x47x22xi16>) -> !spirv.arm.tensor<49x47x22xi16>
    "spirv.ARM.GraphOutputs"(%103) : (!spirv.arm.tensor<49x47x22xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<4x1x7x12xi16>, !spirv.arm.tensor<4x13x7x12xi16>) -> !spirv.arm.tensor<4x13x7x12xi16>, sym_name = "bitwiseand_int"}> ({
  ^bb0(%arg111: !spirv.arm.tensor<4x1x7x12xi16>, %arg112: !spirv.arm.tensor<4x13x7x12xi16>):
    %102 = "spirv.Tosa.BitwiseAnd"(%arg111, %arg112) : (!spirv.arm.tensor<4x1x7x12xi16>, !spirv.arm.tensor<4x13x7x12xi16>) -> !spirv.arm.tensor<4x13x7x12xi16>
    "spirv.ARM.GraphOutputs"(%102) : (!spirv.arm.tensor<4x13x7x12xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<11x30x23xi32>, !spirv.arm.tensor<1x30x23xi32>) -> !spirv.arm.tensor<11x30x23xi32>, sym_name = "bitwiseor_int"}> ({
  ^bb0(%arg109: !spirv.arm.tensor<11x30x23xi32>, %arg110: !spirv.arm.tensor<1x30x23xi32>):
    %101 = "spirv.Tosa.BitwiseOr"(%arg109, %arg110) : (!spirv.arm.tensor<11x30x23xi32>, !spirv.arm.tensor<1x30x23xi32>) -> !spirv.arm.tensor<11x30x23xi32>
    "spirv.ARM.GraphOutputs"(%101) : (!spirv.arm.tensor<11x30x23xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<4x8x13x9xi16>, !spirv.arm.tensor<4x8x1x9xi16>) -> !spirv.arm.tensor<4x8x13x9xi16>, sym_name = "bitwisexor_int"}> ({
  ^bb0(%arg107: !spirv.arm.tensor<4x8x13x9xi16>, %arg108: !spirv.arm.tensor<4x8x1x9xi16>):
    %100 = "spirv.Tosa.BitwiseXor"(%arg107, %arg108) : (!spirv.arm.tensor<4x8x13x9xi16>, !spirv.arm.tensor<4x8x1x9xi16>) -> !spirv.arm.tensor<4x8x13x9xi16>
    "spirv.ARM.GraphOutputs"(%100) : (!spirv.arm.tensor<4x8x13x9xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x65533x1xi32>, !spirv.arm.tensor<2x65533x1xi32>) -> !spirv.arm.tensor<2x65533x1xi32>, sym_name = "intdiv_any"}> ({
  ^bb0(%arg105: !spirv.arm.tensor<1x65533x1xi32>, %arg106: !spirv.arm.tensor<2x65533x1xi32>):
    %99 = "spirv.Tosa.IntDiv"(%arg105, %arg106) : (!spirv.arm.tensor<1x65533x1xi32>, !spirv.arm.tensor<2x65533x1xi32>) -> !spirv.arm.tensor<2x65533x1xi32>
    "spirv.ARM.GraphOutputs"(%99) : (!spirv.arm.tensor<2x65533x1xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x1x7x11xi1>, !spirv.arm.tensor<2x4x7x11xi1>) -> !spirv.arm.tensor<2x4x7x11xi1>, sym_name = "logicaland_any"}> ({
  ^bb0(%arg103: !spirv.arm.tensor<2x1x7x11xi1>, %arg104: !spirv.arm.tensor<2x4x7x11xi1>):
    %98 = "spirv.Tosa.LogicalAnd"(%arg103, %arg104) : (!spirv.arm.tensor<2x1x7x11xi1>, !spirv.arm.tensor<2x4x7x11xi1>) -> !spirv.arm.tensor<2x4x7x11xi1>
    "spirv.ARM.GraphOutputs"(%98) : (!spirv.arm.tensor<2x4x7x11xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<7x1x11x4xi8>, !spirv.arm.tensor<7x8x11x4xi8>) -> !spirv.arm.tensor<7x8x11x4xi8>, sym_name = "logicalleftshift_any"}> ({
  ^bb0(%arg101: !spirv.arm.tensor<7x1x11x4xi8>, %arg102: !spirv.arm.tensor<7x8x11x4xi8>):
    %97 = "spirv.Tosa.LogicalLeftShift"(%arg101, %arg102) : (!spirv.arm.tensor<7x1x11x4xi8>, !spirv.arm.tensor<7x8x11x4xi8>) -> !spirv.arm.tensor<7x8x11x4xi8>
    "spirv.ARM.GraphOutputs"(%97) : (!spirv.arm.tensor<7x8x11x4xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<6x13x1x19xi8>, !spirv.arm.tensor<6x13x6x19xi8>) -> !spirv.arm.tensor<6x13x6x19xi8>, sym_name = "logicalrightshift_any"}> ({
  ^bb0(%arg99: !spirv.arm.tensor<6x13x1x19xi8>, %arg100: !spirv.arm.tensor<6x13x6x19xi8>):
    %96 = "spirv.Tosa.LogicalRightShift"(%arg99, %arg100) : (!spirv.arm.tensor<6x13x1x19xi8>, !spirv.arm.tensor<6x13x6x19xi8>) -> !spirv.arm.tensor<6x13x6x19xi8>
    "spirv.ARM.GraphOutputs"(%96) : (!spirv.arm.tensor<6x13x6x19xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x6x12x5xi1>, !spirv.arm.tensor<3x6x1x5xi1>) -> !spirv.arm.tensor<3x6x12x5xi1>, sym_name = "logicalor_any"}> ({
  ^bb0(%arg97: !spirv.arm.tensor<3x6x12x5xi1>, %arg98: !spirv.arm.tensor<3x6x1x5xi1>):
    %95 = "spirv.Tosa.LogicalOr"(%arg97, %arg98) : (!spirv.arm.tensor<3x6x12x5xi1>, !spirv.arm.tensor<3x6x1x5xi1>) -> !spirv.arm.tensor<3x6x12x5xi1>
    "spirv.ARM.GraphOutputs"(%95) : (!spirv.arm.tensor<3x6x12x5xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<11x4x9x12xi1>, !spirv.arm.tensor<11x4x9x1xi1>) -> !spirv.arm.tensor<11x4x9x12xi1>, sym_name = "logicalxor_any"}> ({
  ^bb0(%arg95: !spirv.arm.tensor<11x4x9x12xi1>, %arg96: !spirv.arm.tensor<11x4x9x1xi1>):
    %94 = "spirv.Tosa.LogicalXor"(%arg95, %arg96) : (!spirv.arm.tensor<11x4x9x12xi1>, !spirv.arm.tensor<11x4x9x1xi1>) -> !spirv.arm.tensor<11x4x9x12xi1>
    "spirv.ARM.GraphOutputs"(%94) : (!spirv.arm.tensor<11x4x9x12xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x2x65533x1xi32>, !spirv.arm.tensor<1x2x65533x2xi32>) -> !spirv.arm.tensor<1x2x65533x2xi32>, sym_name = "maximum_int"}> ({
  ^bb0(%arg93: !spirv.arm.tensor<1x2x65533x1xi32>, %arg94: !spirv.arm.tensor<1x2x65533x2xi32>):
    %93 = "spirv.Tosa.Maximum"(%arg93, %arg94) <{nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<1x2x65533x1xi32>, !spirv.arm.tensor<1x2x65533x2xi32>) -> !spirv.arm.tensor<1x2x65533x2xi32>
    "spirv.ARM.GraphOutputs"(%93) : (!spirv.arm.tensor<1x2x65533x2xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x12x14x7xf16>, !spirv.arm.tensor<11x12x14x7xf16>) -> !spirv.arm.tensor<11x12x14x7xf16>, sym_name = "maximum_fp"}> ({
  ^bb0(%arg91: !spirv.arm.tensor<1x12x14x7xf16>, %arg92: !spirv.arm.tensor<11x12x14x7xf16>):
    %92 = "spirv.Tosa.Maximum"(%arg91, %arg92) <{nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Ignore>}> : (!spirv.arm.tensor<1x12x14x7xf16>, !spirv.arm.tensor<11x12x14x7xf16>) -> !spirv.arm.tensor<11x12x14x7xf16>
    "spirv.ARM.GraphOutputs"(%92) : (!spirv.arm.tensor<11x12x14x7xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<15x2x10x11xi32>, !spirv.arm.tensor<15x1x10x11xi32>) -> !spirv.arm.tensor<15x2x10x11xi32>, sym_name = "minimum_int"}> ({
  ^bb0(%arg89: !spirv.arm.tensor<15x2x10x11xi32>, %arg90: !spirv.arm.tensor<15x1x10x11xi32>):
    %91 = "spirv.Tosa.Minimum"(%arg89, %arg90) <{nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<15x2x10x11xi32>, !spirv.arm.tensor<15x1x10x11xi32>) -> !spirv.arm.tensor<15x2x10x11xi32>
    "spirv.ARM.GraphOutputs"(%91) : (!spirv.arm.tensor<15x2x10x11xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x65531x2x1xf32>, !spirv.arm.tensor<1x1x2x1xf32>) -> !spirv.arm.tensor<1x65531x2x1xf32>, sym_name = "minimum_fp"}> ({
  ^bb0(%arg87: !spirv.arm.tensor<1x65531x2x1xf32>, %arg88: !spirv.arm.tensor<1x1x2x1xf32>):
    %90 = "spirv.Tosa.Minimum"(%arg87, %arg88) <{nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<1x65531x2x1xf32>, !spirv.arm.tensor<1x1x2x1xf32>) -> !spirv.arm.tensor<1x65531x2x1xf32>
    "spirv.ARM.GraphOutputs"(%90) : (!spirv.arm.tensor<1x65531x2x1xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<34x21x39xi32>, !spirv.arm.tensor<34x21x1xi32>) -> !spirv.arm.tensor<34x21x39xi32>, sym_name = "mul_int"}> ({
  ^bb0(%arg85: !spirv.arm.tensor<34x21x39xi32>, %arg86: !spirv.arm.tensor<34x21x1xi32>):
    %88 = "spirv.Constant"() <{value = dense<31> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %89 = "spirv.Tosa.Mul"(%arg85, %arg86, %88) : (!spirv.arm.tensor<34x21x39xi32>, !spirv.arm.tensor<34x21x1xi32>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<34x21x39xi32>
    "spirv.ARM.GraphOutputs"(%89) : (!spirv.arm.tensor<34x21x39xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<57x1x55xf16>, !spirv.arm.tensor<57x37x55xf16>) -> !spirv.arm.tensor<57x37x55xf16>, sym_name = "mul_fp"}> ({
  ^bb0(%arg83: !spirv.arm.tensor<57x1x55xf16>, %arg84: !spirv.arm.tensor<57x37x55xf16>):
    %86 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %87 = "spirv.Tosa.Mul"(%arg83, %arg84, %86) : (!spirv.arm.tensor<57x1x55xf16>, !spirv.arm.tensor<57x37x55xf16>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<57x37x55xf16>
    "spirv.ARM.GraphOutputs"(%87) : (!spirv.arm.tensor<57x37x55xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x52x53xf16>, !spirv.arm.tensor<44x52x53xf16>) -> !spirv.arm.tensor<44x52x53xf16>, sym_name = "pow_fp"}> ({
  ^bb0(%arg81: !spirv.arm.tensor<1x52x53xf16>, %arg82: !spirv.arm.tensor<44x52x53xf16>):
    %85 = "spirv.Tosa.Pow"(%arg81, %arg82) : (!spirv.arm.tensor<1x52x53xf16>, !spirv.arm.tensor<44x52x53xf16>) -> !spirv.arm.tensor<44x52x53xf16>
    "spirv.ARM.GraphOutputs"(%85) : (!spirv.arm.tensor<44x52x53xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<6x10x6x6xi32>, !spirv.arm.tensor<1x10x6x6xi32>) -> !spirv.arm.tensor<6x10x6x6xi32>, sym_name = "sub_int"}> ({
  ^bb0(%arg79: !spirv.arm.tensor<6x10x6x6xi32>, %arg80: !spirv.arm.tensor<1x10x6x6xi32>):
    %84 = "spirv.Tosa.Sub"(%arg79, %arg80) : (!spirv.arm.tensor<6x10x6x6xi32>, !spirv.arm.tensor<1x10x6x6xi32>) -> !spirv.arm.tensor<6x10x6x6xi32>
    "spirv.ARM.GraphOutputs"(%84) : (!spirv.arm.tensor<6x10x6x6xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x10x13x12xf16>, !spirv.arm.tensor<6x10x13x12xf16>) -> !spirv.arm.tensor<6x10x13x12xf16>, sym_name = "sub_fp"}> ({
  ^bb0(%arg77: !spirv.arm.tensor<1x10x13x12xf16>, %arg78: !spirv.arm.tensor<6x10x13x12xf16>):
    %83 = "spirv.Tosa.Sub"(%arg77, %arg78) : (!spirv.arm.tensor<1x10x13x12xf16>, !spirv.arm.tensor<6x10x13x12xf16>) -> !spirv.arm.tensor<6x10x13x12xf16>
    "spirv.ARM.GraphOutputs"(%83) : (!spirv.arm.tensor<6x10x13x12xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x2x15x7xi8>) -> !spirv.arm.tensor<3x2x15x7xi8>, sym_name = "table_int"}> ({
  ^bb0(%arg76: !spirv.arm.tensor<3x2x15x7xi8>):
    %81 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 0 : i32}> : () -> !spirv.arm.tensor<256xi8>
    %82 = "spirv.Tosa.Table"(%arg76, %81) : (!spirv.arm.tensor<3x2x15x7xi8>, !spirv.arm.tensor<256xi8>) -> !spirv.arm.tensor<3x2x15x7xi8>
    "spirv.ARM.GraphOutputs"(%82) : (!spirv.arm.tensor<3x2x15x7xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<5x1x4x4xi32>) -> !spirv.arm.tensor<5x1x4x4xi32>, sym_name = "abs_int"}> ({
  ^bb0(%arg75: !spirv.arm.tensor<5x1x4x4xi32>):
    %80 = "spirv.Tosa.Abs"(%arg75) : (!spirv.arm.tensor<5x1x4x4xi32>) -> !spirv.arm.tensor<5x1x4x4xi32>
    "spirv.ARM.GraphOutputs"(%80) : (!spirv.arm.tensor<5x1x4x4xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x6x14x8xf16>) -> !spirv.arm.tensor<3x6x14x8xf16>, sym_name = "abs_fp"}> ({
  ^bb0(%arg74: !spirv.arm.tensor<3x6x14x8xf16>):
    %79 = "spirv.Tosa.Abs"(%arg74) : (!spirv.arm.tensor<3x6x14x8xf16>) -> !spirv.arm.tensor<3x6x14x8xf16>
    "spirv.ARM.GraphOutputs"(%79) : (!spirv.arm.tensor<3x6x14x8xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<12x56x50xi32>) -> !spirv.arm.tensor<12x56x50xi32>, sym_name = "bitwisenot_int"}> ({
  ^bb0(%arg73: !spirv.arm.tensor<12x56x50xi32>):
    %78 = "spirv.Tosa.BitwiseNot"(%arg73) : (!spirv.arm.tensor<12x56x50xi32>) -> !spirv.arm.tensor<12x56x50xi32>
    "spirv.ARM.GraphOutputs"(%78) : (!spirv.arm.tensor<12x56x50xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<46x55x53xf16>) -> !spirv.arm.tensor<46x55x53xf16>, sym_name = "ceil_fp"}> ({
  ^bb0(%arg72: !spirv.arm.tensor<46x55x53xf16>):
    %77 = "spirv.Tosa.Ceil"(%arg72) : (!spirv.arm.tensor<46x55x53xf16>) -> !spirv.arm.tensor<46x55x53xf16>
    "spirv.ARM.GraphOutputs"(%77) : (!spirv.arm.tensor<46x55x53xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<14x10x7x5xi32>) -> !spirv.arm.tensor<14x10x7x5xi32>, sym_name = "clz_int"}> ({
  ^bb0(%arg71: !spirv.arm.tensor<14x10x7x5xi32>):
    %76 = "spirv.Tosa.Clz"(%arg71) : (!spirv.arm.tensor<14x10x7x5xi32>) -> !spirv.arm.tensor<14x10x7x5xi32>
    "spirv.ARM.GraphOutputs"(%76) : (!spirv.arm.tensor<14x10x7x5xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<44x49x51xf32>) -> !spirv.arm.tensor<44x49x51xf32>, sym_name = "cos_fp"}> ({
  ^bb0(%arg70: !spirv.arm.tensor<44x49x51xf32>):
    %75 = "spirv.Tosa.Cos"(%arg70) : (!spirv.arm.tensor<44x49x51xf32>) -> !spirv.arm.tensor<44x49x51xf32>
    "spirv.ARM.GraphOutputs"(%75) : (!spirv.arm.tensor<44x49x51xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<37x53x47xf32>) -> !spirv.arm.tensor<37x53x47xf32>, sym_name = "exp_fp"}> ({
  ^bb0(%arg69: !spirv.arm.tensor<37x53x47xf32>):
    %74 = "spirv.Tosa.Exp"(%arg69) : (!spirv.arm.tensor<37x53x47xf32>) -> !spirv.arm.tensor<37x53x47xf32>
    "spirv.ARM.GraphOutputs"(%74) : (!spirv.arm.tensor<37x53x47xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<40x52x42xf32>) -> !spirv.arm.tensor<40x52x42xf32>, sym_name = "floor_fp"}> ({
  ^bb0(%arg68: !spirv.arm.tensor<40x52x42xf32>):
    %73 = "spirv.Tosa.Floor"(%arg68) : (!spirv.arm.tensor<40x52x42xf32>) -> !spirv.arm.tensor<40x52x42xf32>
    "spirv.ARM.GraphOutputs"(%73) : (!spirv.arm.tensor<40x52x42xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<45x43x36xf16>) -> !spirv.arm.tensor<45x43x36xf16>, sym_name = "log_fp"}> ({
  ^bb0(%arg67: !spirv.arm.tensor<45x43x36xf16>):
    %72 = "spirv.Tosa.Log"(%arg67) : (!spirv.arm.tensor<45x43x36xf16>) -> !spirv.arm.tensor<45x43x36xf16>
    "spirv.ARM.GraphOutputs"(%72) : (!spirv.arm.tensor<45x43x36xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<54x26x10xi1>) -> !spirv.arm.tensor<54x26x10xi1>, sym_name = "logicalnot_any"}> ({
  ^bb0(%arg66: !spirv.arm.tensor<54x26x10xi1>):
    %71 = "spirv.Tosa.LogicalNot"(%arg66) : (!spirv.arm.tensor<54x26x10xi1>) -> !spirv.arm.tensor<54x26x10xi1>
    "spirv.ARM.GraphOutputs"(%71) : (!spirv.arm.tensor<54x26x10xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x1x65540x1xi8>) -> !spirv.arm.tensor<3x1x65540x1xi8>, sym_name = "negate_int"}> ({
  ^bb0(%arg65: !spirv.arm.tensor<3x1x65540x1xi8>):
    %68 = "spirv.Constant"() <{value = dense<111> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %69 = "spirv.Constant"() <{value = dense<-32> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %70 = "spirv.Tosa.Negate"(%arg65, %68, %69) : (!spirv.arm.tensor<3x1x65540x1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<3x1x65540x1xi8>
    "spirv.ARM.GraphOutputs"(%70) : (!spirv.arm.tensor<3x1x65540x1xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x7x15x13xf16>) -> !spirv.arm.tensor<2x7x15x13xf16>, sym_name = "negate_fp"}> ({
  ^bb0(%arg64: !spirv.arm.tensor<2x7x15x13xf16>):
    %65 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %66 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %67 = "spirv.Tosa.Negate"(%arg64, %65, %66) : (!spirv.arm.tensor<2x7x15x13xf16>, !spirv.arm.tensor<1xf16>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<2x7x15x13xf16>
    "spirv.ARM.GraphOutputs"(%67) : (!spirv.arm.tensor<2x7x15x13xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<38x47x44xf32>) -> !spirv.arm.tensor<38x47x44xf32>, sym_name = "reciprocal_fp"}> ({
  ^bb0(%arg63: !spirv.arm.tensor<38x47x44xf32>):
    %64 = "spirv.Tosa.Reciprocal"(%arg63) : (!spirv.arm.tensor<38x47x44xf32>) -> !spirv.arm.tensor<38x47x44xf32>
    "spirv.ARM.GraphOutputs"(%64) : (!spirv.arm.tensor<38x47x44xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<40x57x56xf32>) -> !spirv.arm.tensor<40x57x56xf32>, sym_name = "rsqrt_fp"}> ({
  ^bb0(%arg62: !spirv.arm.tensor<40x57x56xf32>):
    %63 = "spirv.Tosa.Rsqrt"(%arg62) : (!spirv.arm.tensor<40x57x56xf32>) -> !spirv.arm.tensor<40x57x56xf32>
    "spirv.ARM.GraphOutputs"(%63) : (!spirv.arm.tensor<40x57x56xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<49x38x58xf16>) -> !spirv.arm.tensor<49x38x58xf16>, sym_name = "sin_fp"}> ({
  ^bb0(%arg61: !spirv.arm.tensor<49x38x58xf16>):
    %62 = "spirv.Tosa.Sin"(%arg61) : (!spirv.arm.tensor<49x38x58xf16>) -> !spirv.arm.tensor<49x38x58xf16>
    "spirv.ARM.GraphOutputs"(%62) : (!spirv.arm.tensor<49x38x58xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<4x1x4x5xi1>, !spirv.arm.tensor<4x6x4x5xi8>, !spirv.arm.tensor<4x6x4x5xi8>) -> !spirv.arm.tensor<4x6x4x5xi8>, sym_name = "select_int"}> ({
  ^bb0(%arg58: !spirv.arm.tensor<4x1x4x5xi1>, %arg59: !spirv.arm.tensor<4x6x4x5xi8>, %arg60: !spirv.arm.tensor<4x6x4x5xi8>):
    %61 = "spirv.Tosa.Select"(%arg58, %arg59, %arg60) : (!spirv.arm.tensor<4x1x4x5xi1>, !spirv.arm.tensor<4x6x4x5xi8>, !spirv.arm.tensor<4x6x4x5xi8>) -> !spirv.arm.tensor<4x6x4x5xi8>
    "spirv.ARM.GraphOutputs"(%61) : (!spirv.arm.tensor<4x6x4x5xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<9x2x15x8xi1>, !spirv.arm.tensor<9x2x15x8xf16>, !spirv.arm.tensor<9x1x15x8xf16>) -> !spirv.arm.tensor<9x2x15x8xf16>, sym_name = "select_fp"}> ({
  ^bb0(%arg55: !spirv.arm.tensor<9x2x15x8xi1>, %arg56: !spirv.arm.tensor<9x2x15x8xf16>, %arg57: !spirv.arm.tensor<9x1x15x8xf16>):
    %60 = "spirv.Tosa.Select"(%arg55, %arg56, %arg57) : (!spirv.arm.tensor<9x2x15x8xi1>, !spirv.arm.tensor<9x2x15x8xf16>, !spirv.arm.tensor<9x1x15x8xf16>) -> !spirv.arm.tensor<9x2x15x8xf16>
    "spirv.ARM.GraphOutputs"(%60) : (!spirv.arm.tensor<9x2x15x8xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<51x28x59xi32>, !spirv.arm.tensor<51x1x59xi32>) -> !spirv.arm.tensor<51x28x59xi1>, sym_name = "equal_int"}> ({
  ^bb0(%arg53: !spirv.arm.tensor<51x28x59xi32>, %arg54: !spirv.arm.tensor<51x1x59xi32>):
    %59 = "spirv.Tosa.Equal"(%arg53, %arg54) : (!spirv.arm.tensor<51x28x59xi32>, !spirv.arm.tensor<51x1x59xi32>) -> !spirv.arm.tensor<51x28x59xi1>
    "spirv.ARM.GraphOutputs"(%59) : (!spirv.arm.tensor<51x28x59xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<16x11x5x3xf32>, !spirv.arm.tensor<16x1x5x3xf32>) -> !spirv.arm.tensor<16x11x5x3xi1>, sym_name = "equal_fp"}> ({
  ^bb0(%arg51: !spirv.arm.tensor<16x11x5x3xf32>, %arg52: !spirv.arm.tensor<16x1x5x3xf32>):
    %58 = "spirv.Tosa.Equal"(%arg51, %arg52) : (!spirv.arm.tensor<16x11x5x3xf32>, !spirv.arm.tensor<16x1x5x3xf32>) -> !spirv.arm.tensor<16x11x5x3xi1>
    "spirv.ARM.GraphOutputs"(%58) : (!spirv.arm.tensor<16x11x5x3xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<11x10x10x2xi32>, !spirv.arm.tensor<11x10x10x1xi32>) -> !spirv.arm.tensor<11x10x10x2xi1>, sym_name = "greater_int"}> ({
  ^bb0(%arg49: !spirv.arm.tensor<11x10x10x2xi32>, %arg50: !spirv.arm.tensor<11x10x10x1xi32>):
    %57 = "spirv.Tosa.Greater"(%arg49, %arg50) : (!spirv.arm.tensor<11x10x10x2xi32>, !spirv.arm.tensor<11x10x10x1xi32>) -> !spirv.arm.tensor<11x10x10x2xi1>
    "spirv.ARM.GraphOutputs"(%57) : (!spirv.arm.tensor<11x10x10x2xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<6x3x12x4xf16>, !spirv.arm.tensor<6x3x1x4xf16>) -> !spirv.arm.tensor<6x3x12x4xi1>, sym_name = "greater_fp"}> ({
  ^bb0(%arg47: !spirv.arm.tensor<6x3x12x4xf16>, %arg48: !spirv.arm.tensor<6x3x1x4xf16>):
    %56 = "spirv.Tosa.Greater"(%arg47, %arg48) : (!spirv.arm.tensor<6x3x12x4xf16>, !spirv.arm.tensor<6x3x1x4xf16>) -> !spirv.arm.tensor<6x3x12x4xi1>
    "spirv.ARM.GraphOutputs"(%56) : (!spirv.arm.tensor<6x3x12x4xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<10x17x7x1xi32>, !spirv.arm.tensor<10x17x7x16xi32>) -> !spirv.arm.tensor<10x17x7x16xi1>, sym_name = "greaterequal_int"}> ({
  ^bb0(%arg45: !spirv.arm.tensor<10x17x7x1xi32>, %arg46: !spirv.arm.tensor<10x17x7x16xi32>):
    %55 = "spirv.Tosa.GreaterEqual"(%arg45, %arg46) : (!spirv.arm.tensor<10x17x7x1xi32>, !spirv.arm.tensor<10x17x7x16xi32>) -> !spirv.arm.tensor<10x17x7x16xi1>
    "spirv.ARM.GraphOutputs"(%55) : (!spirv.arm.tensor<10x17x7x16xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x17x6x3xf32>, !spirv.arm.tensor<1x17x6x3xf32>) -> !spirv.arm.tensor<3x17x6x3xi1>, sym_name = "greaterequal_fp"}> ({
  ^bb0(%arg43: !spirv.arm.tensor<3x17x6x3xf32>, %arg44: !spirv.arm.tensor<1x17x6x3xf32>):
    %54 = "spirv.Tosa.GreaterEqual"(%arg43, %arg44) : (!spirv.arm.tensor<3x17x6x3xf32>, !spirv.arm.tensor<1x17x6x3xf32>) -> !spirv.arm.tensor<3x17x6x3xi1>
    "spirv.ARM.GraphOutputs"(%54) : (!spirv.arm.tensor<3x17x6x3xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<18x22x23x12xi1>) -> !spirv.arm.tensor<18x22x1x12xi1>, sym_name = "reduceall_any"}> ({
  ^bb0(%arg42: !spirv.arm.tensor<18x22x23x12xi1>):
    %53 = "spirv.Tosa.ReduceAll"(%arg42) <{axis = 2 : i32}> : (!spirv.arm.tensor<18x22x23x12xi1>) -> !spirv.arm.tensor<18x22x1x12xi1>
    "spirv.ARM.GraphOutputs"(%53) : (!spirv.arm.tensor<18x22x1x12xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<25x13x30x8xi1>) -> !spirv.arm.tensor<25x13x1x8xi1>, sym_name = "reduceany_any"}> ({
  ^bb0(%arg41: !spirv.arm.tensor<25x13x30x8xi1>):
    %52 = "spirv.Tosa.ReduceAny"(%arg41) <{axis = 2 : i32}> : (!spirv.arm.tensor<25x13x30x8xi1>) -> !spirv.arm.tensor<25x13x1x8xi1>
    "spirv.ARM.GraphOutputs"(%52) : (!spirv.arm.tensor<25x13x1x8xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<8x30x12x3xi8>) -> !spirv.arm.tensor<8x30x1x3xi8>, sym_name = "reducemax_int"}> ({
  ^bb0(%arg40: !spirv.arm.tensor<8x30x12x3xi8>):
    %51 = "spirv.Tosa.ReduceMax"(%arg40) <{axis = 2 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<8x30x12x3xi8>) -> !spirv.arm.tensor<8x30x1x3xi8>
    "spirv.ARM.GraphOutputs"(%51) : (!spirv.arm.tensor<8x30x1x3xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<16x20x10xf16>) -> !spirv.arm.tensor<16x20x1xf16>, sym_name = "reducemax_fp"}> ({
  ^bb0(%arg39: !spirv.arm.tensor<16x20x10xf16>):
    %50 = "spirv.Tosa.ReduceMax"(%arg39) <{axis = 2 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<16x20x10xf16>) -> !spirv.arm.tensor<16x20x1xf16>
    "spirv.ARM.GraphOutputs"(%50) : (!spirv.arm.tensor<16x20x1xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x5x5x1xi8>) -> !spirv.arm.tensor<2x5x1x1xi8>, sym_name = "reducemin_int"}> ({
  ^bb0(%arg38: !spirv.arm.tensor<2x5x5x1xi8>):
    %49 = "spirv.Tosa.ReduceMin"(%arg38) <{axis = 2 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<2x5x5x1xi8>) -> !spirv.arm.tensor<2x5x1x1xi8>
    "spirv.ARM.GraphOutputs"(%49) : (!spirv.arm.tensor<2x5x1x1xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<27x10x25x9xf16>) -> !spirv.arm.tensor<27x10x1x9xf16>, sym_name = "reducemin_fp"}> ({
  ^bb0(%arg37: !spirv.arm.tensor<27x10x25x9xf16>):
    %48 = "spirv.Tosa.ReduceMin"(%arg37) <{axis = 2 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<27x10x25x9xf16>) -> !spirv.arm.tensor<27x10x1x9xf16>
    "spirv.ARM.GraphOutputs"(%48) : (!spirv.arm.tensor<27x10x1x9xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x16x25xf16>) -> !spirv.arm.tensor<2x16x1xf16>, sym_name = "reduceproduct_fp"}> ({
  ^bb0(%arg36: !spirv.arm.tensor<2x16x25xf16>):
    %47 = "spirv.Tosa.ReduceProduct"(%arg36) <{axis = 2 : i32}> : (!spirv.arm.tensor<2x16x25xf16>) -> !spirv.arm.tensor<2x16x1xf16>
    "spirv.ARM.GraphOutputs"(%47) : (!spirv.arm.tensor<2x16x1xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<20x24x22xi32>) -> !spirv.arm.tensor<20x1x22xi32>, sym_name = "reducesum_int"}> ({
  ^bb0(%arg35: !spirv.arm.tensor<20x24x22xi32>):
    %46 = "spirv.Tosa.ReduceSum"(%arg35) <{axis = 1 : i32}> : (!spirv.arm.tensor<20x24x22xi32>) -> !spirv.arm.tensor<20x1x22xi32>
    "spirv.ARM.GraphOutputs"(%46) : (!spirv.arm.tensor<20x1x22xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<32x32x33xf32>) -> !spirv.arm.tensor<32x1x33xf32>, sym_name = "reducesum_fp"}> ({
  ^bb0(%arg34: !spirv.arm.tensor<32x32x33xf32>):
    %45 = "spirv.Tosa.ReduceSum"(%arg34) <{axis = 1 : i32}> : (!spirv.arm.tensor<32x32x33xf32>) -> !spirv.arm.tensor<32x1x33xf32>
    "spirv.ARM.GraphOutputs"(%45) : (!spirv.arm.tensor<32x1x33xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>) -> !spirv.arm.tensor<12x13x12x14xi8>, sym_name = "concat_int"}> ({
  ^bb0(%arg30: !spirv.arm.tensor<12x13x3x14xi8>, %arg31: !spirv.arm.tensor<12x13x3x14xi8>, %arg32: !spirv.arm.tensor<12x13x3x14xi8>, %arg33: !spirv.arm.tensor<12x13x3x14xi8>):
    %44 = "spirv.Tosa.Concat"(%arg30, %arg31, %arg32, %arg33) <{axis = 2 : i32}> : (!spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>) -> !spirv.arm.tensor<12x13x12x14xi8>
    "spirv.ARM.GraphOutputs"(%44) : (!spirv.arm.tensor<12x13x12x14xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<40x31x19xf32>, !spirv.arm.tensor<40x15x19xf32>, !spirv.arm.tensor<40x16x19xf32>) -> !spirv.arm.tensor<40x62x19xf32>, sym_name = "concat_fp"}> ({
  ^bb0(%arg27: !spirv.arm.tensor<40x31x19xf32>, %arg28: !spirv.arm.tensor<40x15x19xf32>, %arg29: !spirv.arm.tensor<40x16x19xf32>):
    %43 = "spirv.Tosa.Concat"(%arg27, %arg28, %arg29) <{axis = 1 : i32}> : (!spirv.arm.tensor<40x31x19xf32>, !spirv.arm.tensor<40x15x19xf32>, !spirv.arm.tensor<40x16x19xf32>) -> !spirv.arm.tensor<40x62x19xf32>
    "spirv.ARM.GraphOutputs"(%43) : (!spirv.arm.tensor<40x62x19xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<4x7xi8>) -> !spirv.arm.tensor<21x19xi8>, sym_name = "pad_int"}> ({
  ^bb0(%arg26: !spirv.arm.tensor<4x7xi8>):
    %40 = "spirv.Constant"() <{value = dense<[10, 7, 6, 6]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %41 = "spirv.Constant"() <{value = dense<-76> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %42 = "spirv.Tosa.Pad"(%arg26, %40, %41) : (!spirv.arm.tensor<4x7xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<21x19xi8>
    "spirv.ARM.GraphOutputs"(%42) : (!spirv.arm.tensor<21x19xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x9x2x3xf32>) -> !spirv.arm.tensor<4x9x4x4xf32>, sym_name = "pad_fp"}> ({
  ^bb0(%arg25: !spirv.arm.tensor<2x9x2x3xf32>):
    %37 = "spirv.Constant"() <{value = dense<[1, 1, 0, 0, 1, 1, 0, 1]> : !spirv.arm.tensor<8xi32>}> : () -> !spirv.arm.tensor<8xi32>
    %38 = "spirv.Constant"() <{value = dense<1.21630913E+38> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %39 = "spirv.Tosa.Pad"(%arg25, %37, %38) : (!spirv.arm.tensor<2x9x2x3xf32>, !spirv.arm.tensor<8xi32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<4x9x4x4xf32>
    "spirv.ARM.GraphOutputs"(%39) : (!spirv.arm.tensor<4x9x4x4xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<25x6x29x35xi16>) -> !spirv.arm.tensor<125x6x7x29xi16>, sym_name = "reshape_int"}> ({
  ^bb0(%arg24: !spirv.arm.tensor<25x6x29x35xi16>):
    %35 = "spirv.Constant"() <{value = dense<[125, 6, 7, 29]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %36 = "spirv.Tosa.Reshape"(%arg24, %35) : (!spirv.arm.tensor<25x6x29x35xi16>, !spirv.arm.tensor<4xi32>) -> !spirv.arm.tensor<125x6x7x29xi16>
    "spirv.ARM.GraphOutputs"(%36) : (!spirv.arm.tensor<125x6x7x29xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x2x7x2xf32>) -> !spirv.arm.tensor<2x1x14xf32>, sym_name = "reshape_fp"}> ({
  ^bb0(%arg23: !spirv.arm.tensor<1x2x7x2xf32>):
    %33 = "spirv.Constant"() <{value = dense<[2, 1, 14]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %34 = "spirv.Tosa.Reshape"(%arg23, %33) : (!spirv.arm.tensor<1x2x7x2xf32>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<2x1x14xf32>
    "spirv.ARM.GraphOutputs"(%34) : (!spirv.arm.tensor<2x1x14xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<20x5x28x31xi32>) -> !spirv.arm.tensor<20x5x28x31xi32>, sym_name = "reverse_int"}> ({
  ^bb0(%arg22: !spirv.arm.tensor<20x5x28x31xi32>):
    %32 = "spirv.Tosa.Reverse"(%arg22) <{axis = 2 : i32}> : (!spirv.arm.tensor<20x5x28x31xi32>) -> !spirv.arm.tensor<20x5x28x31xi32>
    "spirv.ARM.GraphOutputs"(%32) : (!spirv.arm.tensor<20x5x28x31xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<21x34x47xf32>) -> !spirv.arm.tensor<21x34x47xf32>, sym_name = "reverse_fp"}> ({
  ^bb0(%arg21: !spirv.arm.tensor<21x34x47xf32>):
    %31 = "spirv.Tosa.Reverse"(%arg21) <{axis = 1 : i32}> : (!spirv.arm.tensor<21x34x47xf32>) -> !spirv.arm.tensor<21x34x47xf32>
    "spirv.ARM.GraphOutputs"(%31) : (!spirv.arm.tensor<21x34x47xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<32x19x41xi8>) -> !spirv.arm.tensor<21x5x2xi8>, sym_name = "slice_int"}> ({
  ^bb0(%arg20: !spirv.arm.tensor<32x19x41xi8>):
    %28 = "spirv.Constant"() <{value = dense<[8, 11, 39]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %29 = "spirv.Constant"() <{value = dense<[21, 5, 2]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %30 = "spirv.Tosa.Slice"(%arg20, %28, %29) : (!spirv.arm.tensor<32x19x41xi8>, !spirv.arm.tensor<3xi32>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<21x5x2xi8>
    "spirv.ARM.GraphOutputs"(%30) : (!spirv.arm.tensor<21x5x2xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<30x45x29xf32>) -> !spirv.arm.tensor<5x12x11xf32>, sym_name = "slice_fp"}> ({
  ^bb0(%arg19: !spirv.arm.tensor<30x45x29xf32>):
    %25 = "spirv.Constant"() <{value = dense<[21, 20, 10]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %26 = "spirv.Constant"() <{value = dense<[5, 12, 11]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %27 = "spirv.Tosa.Slice"(%arg19, %25, %26) : (!spirv.arm.tensor<30x45x29xf32>, !spirv.arm.tensor<3xi32>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<5x12x11xf32>
    "spirv.ARM.GraphOutputs"(%27) : (!spirv.arm.tensor<5x12x11xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<10x28x21xi16>) -> !spirv.arm.tensor<10x28x63xi16>, sym_name = "tile_int"}> ({
  ^bb0(%arg18: !spirv.arm.tensor<10x28x21xi16>):
    %23 = "spirv.Constant"() <{value = dense<[1, 1, 3]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %24 = "spirv.Tosa.Tile"(%arg18, %23) : (!spirv.arm.tensor<10x28x21xi16>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<10x28x63xi16>
    "spirv.ARM.GraphOutputs"(%24) : (!spirv.arm.tensor<10x28x63xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<31x19x5xf16>) -> !spirv.arm.tensor<62x57x10xf16>, sym_name = "tile_fp"}> ({
  ^bb0(%arg17: !spirv.arm.tensor<31x19x5xf16>):
    %21 = "spirv.Constant"() <{value = dense<[2, 3, 2]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %22 = "spirv.Tosa.Tile"(%arg17, %21) : (!spirv.arm.tensor<31x19x5xf16>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<62x57x10xf16>
    "spirv.ARM.GraphOutputs"(%22) : (!spirv.arm.tensor<62x57x10xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<14x28x1x61xi16>) -> !spirv.arm.tensor<1x14x28x61xi16>, sym_name = "transpose_int"}> ({
  ^bb0(%arg16: !spirv.arm.tensor<14x28x1x61xi16>):
    %20 = "spirv.Tosa.Transpose"(%arg16) <{perms = dense<[2, 0, 1, 3]> : !spirv.arm.tensor<4xi32>}> : (!spirv.arm.tensor<14x28x1x61xi16>) -> !spirv.arm.tensor<1x14x28x61xi16>
    "spirv.ARM.GraphOutputs"(%20) : (!spirv.arm.tensor<1x14x28x61xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<42x22x49xi1>) -> !spirv.arm.tensor<49x42x22xi1>, sym_name = "transpose_fp"}> ({
  ^bb0(%arg15: !spirv.arm.tensor<42x22x49xi1>):
    %19 = "spirv.Tosa.Transpose"(%arg15) <{perms = dense<[2, 0, 1]> : !spirv.arm.tensor<3xi32>}> : (!spirv.arm.tensor<42x22x49xi1>) -> !spirv.arm.tensor<49x42x22xi1>
    "spirv.ARM.GraphOutputs"(%19) : (!spirv.arm.tensor<49x42x22xi1>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<31x11x45xi32>, !spirv.arm.tensor<31x15xi32>) -> !spirv.arm.tensor<31x15x45xi32>, sym_name = "gather_int"}> ({
  ^bb0(%arg13: !spirv.arm.tensor<31x11x45xi32>, %arg14: !spirv.arm.tensor<31x15xi32>):
    %18 = "spirv.Tosa.Gather"(%arg13, %arg14) : (!spirv.arm.tensor<31x11x45xi32>, !spirv.arm.tensor<31x15xi32>) -> !spirv.arm.tensor<31x15x45xi32>
    "spirv.ARM.GraphOutputs"(%18) : (!spirv.arm.tensor<31x15x45xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<59x61x19xf32>, !spirv.arm.tensor<59x65xi32>) -> !spirv.arm.tensor<59x65x19xf32>, sym_name = "gather_fp"}> ({
  ^bb0(%arg11: !spirv.arm.tensor<59x61x19xf32>, %arg12: !spirv.arm.tensor<59x65xi32>):
    %17 = "spirv.Tosa.Gather"(%arg11, %arg12) : (!spirv.arm.tensor<59x61x19xf32>, !spirv.arm.tensor<59x65xi32>) -> !spirv.arm.tensor<59x65x19xf32>
    "spirv.ARM.GraphOutputs"(%17) : (!spirv.arm.tensor<59x65x19xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<34x28x54xi32>, !spirv.arm.tensor<34x18xi32>, !spirv.arm.tensor<34x18x54xi32>) -> !spirv.arm.tensor<34x28x54xi32>, sym_name = "scatter_int"}> ({
  ^bb0(%arg8: !spirv.arm.tensor<34x28x54xi32>, %arg9: !spirv.arm.tensor<34x18xi32>, %arg10: !spirv.arm.tensor<34x18x54xi32>):
    %16 = "spirv.Tosa.Scatter"(%arg8, %arg9, %arg10) : (!spirv.arm.tensor<34x28x54xi32>, !spirv.arm.tensor<34x18xi32>, !spirv.arm.tensor<34x18x54xi32>) -> !spirv.arm.tensor<34x28x54xi32>
    "spirv.ARM.GraphOutputs"(%16) : (!spirv.arm.tensor<34x28x54xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<18x34x25xf16>, !spirv.arm.tensor<18x20xi32>, !spirv.arm.tensor<18x20x25xf16>) -> !spirv.arm.tensor<18x34x25xf16>, sym_name = "scatter_fp"}> ({
  ^bb0(%arg5: !spirv.arm.tensor<18x34x25xf16>, %arg6: !spirv.arm.tensor<18x20xi32>, %arg7: !spirv.arm.tensor<18x20x25xf16>):
    %15 = "spirv.Tosa.Scatter"(%arg5, %arg6, %arg7) : (!spirv.arm.tensor<18x34x25xf16>, !spirv.arm.tensor<18x20xi32>, !spirv.arm.tensor<18x20x25xf16>) -> !spirv.arm.tensor<18x34x25xf16>
    "spirv.ARM.GraphOutputs"(%15) : (!spirv.arm.tensor<18x34x25xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x1x31x55xi8>) -> !spirv.arm.tensor<1x1x278x55xi8>, sym_name = "resize_int"}> ({
  ^bb0(%arg4: !spirv.arm.tensor<1x1x31x55xi8>):
    %11 = "spirv.Constant"() <{value = dense<[16, 1, 9, 1]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %12 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %13 = "spirv.Constant"() <{value = dense<[0, 7]> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %14 = "spirv.Tosa.Resize"(%arg4, %11, %12, %13) <{mode = #spirv.tosa_ext_resize_mode_type<NearestNeighbor>}> : (!spirv.arm.tensor<1x1x31x55xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<2xi32>) -> !spirv.arm.tensor<1x1x278x55xi8>
    "spirv.ARM.GraphOutputs"(%14) : (!spirv.arm.tensor<1x1x278x55xi8>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x48x33x63xf32>) -> !spirv.arm.tensor<1x753x297x63xf32>, sym_name = "resize_fp"}> ({
  ^bb0(%arg3: !spirv.arm.tensor<1x48x33x63xf32>):
    %7 = "spirv.Constant"() <{value = dense<[16, 1, 9, 1]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %8 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %9 = "spirv.Constant"() <{value = dense<[0, 8]> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
    %10 = "spirv.Tosa.Resize"(%arg3, %7, %8, %9) <{mode = #spirv.tosa_ext_resize_mode_type<Bilinear>}> : (!spirv.arm.tensor<1x48x33x63xf32>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<2xi32>) -> !spirv.arm.tensor<1x753x297x63xf32>
    "spirv.ARM.GraphOutputs"(%10) : (!spirv.arm.tensor<1x753x297x63xf32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x65538x1x2xi8>) -> !spirv.arm.tensor<1x65538x1x2xi32>, sym_name = "cast_int"}> ({
  ^bb0(%arg2: !spirv.arm.tensor<1x65538x1x2xi8>):
    %6 = "spirv.Tosa.Cast"(%arg2) : (!spirv.arm.tensor<1x65538x1x2xi8>) -> !spirv.arm.tensor<1x65538x1x2xi32>
    "spirv.ARM.GraphOutputs"(%6) : (!spirv.arm.tensor<1x65538x1x2xi32>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<11x5x14x4xf32>) -> !spirv.arm.tensor<11x5x14x4xf16>, sym_name = "cast_fp"}> ({
  ^bb0(%arg1: !spirv.arm.tensor<11x5x14x4xf32>):
    %5 = "spirv.Tosa.Cast"(%arg1) : (!spirv.arm.tensor<11x5x14x4xf32>) -> !spirv.arm.tensor<11x5x14x4xf16>
    "spirv.ARM.GraphOutputs"(%5) : (!spirv.arm.tensor<11x5x14x4xf16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<17x29x19xi16>) -> !spirv.arm.tensor<17x29x19xi16>, sym_name = "rescale_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<17x29x19xi16>):
    %0 = "spirv.Constant"() <{value = dense<1866149760> : !spirv.arm.tensor<1xi32>}> : () -> !spirv.arm.tensor<1xi32>
    %1 = "spirv.Constant"() <{value = dense<31> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %3 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %4 = "spirv.Tosa.Rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = true, per_channel = false, rounding_mode = #spirv.tosa_ext_rounding_mode_type<DoubleRound>, scale32 = true}> : (!spirv.arm.tensor<17x29x19xi16>, !spirv.arm.tensor<1xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16>) -> !spirv.arm.tensor<17x29x19xi16>
    "spirv.ARM.GraphOutputs"(%4) : (!spirv.arm.tensor<17x29x19xi16>) -> ()
  }) : () -> ()
}) : () -> ()

