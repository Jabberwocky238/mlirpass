"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xi8>) -> tensor<2x4xi32>, sym_name = "argmax_int"}> ({
  ^bb0(%arg0: tensor<2x3x4xi8>):
    %0 = "tosa.argmax"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<2x3x4xi8>) -> tensor<2x4xi32>
    "func.return"(%0) : (tensor<2x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4x4x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x2x1xi8>, sym_name = "avg_pool2d_int"}> ({
  ^bb0(%arg0: tensor<1x4x4x1xi8>, %arg1: tensor<1xi8>, %arg2: tensor<1xi8>):
    %0 = "tosa.avg_pool2d"(%arg0, %arg1, %arg2) <{acc_type = i32, kernel = array<i64: 2, 2>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 2, 2>}> : (tensor<1x4x4x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x2x1xi8>
    "func.return"(%0) : (tensor<1x2x2x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4x4x1xi8>, tensor<2x3x3x1xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x2x2xi32>, sym_name = "conv2d_int"}> ({
  ^bb0(%arg0: tensor<1x4x4x1xi8>, %arg1: tensor<2x3x3x1xi8>, %arg2: tensor<2xi32>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tosa.conv2d"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = i32, dilation = array<i64: 1, 1>, local_bound = false, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x4x4x1xi8>, tensor<2x3x3x1xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x2x2xi32>
    "func.return"(%0) : (tensor<1x2x2x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4x4x4x1xi8>, tensor<2x2x2x2x1xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x3x3x3x2xi32>, sym_name = "conv3d_int"}> ({
  ^bb0(%arg0: tensor<1x4x4x4x1xi8>, %arg1: tensor<2x2x2x2x1xi8>, %arg2: tensor<2xi32>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tosa.conv3d"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = i32, dilation = array<i64: 1, 1, 1>, local_bound = false, pad = array<i64: 0, 0, 0, 0, 0, 0>, stride = array<i64: 1, 1, 1>}> : (tensor<1x4x4x4x1xi8>, tensor<2x2x2x2x1xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x3x3x3x2xi32>
    "func.return"(%0) : (tensor<1x3x3x3x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4x4x1xi8>, tensor<3x3x1x2xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x2x2xi32>, sym_name = "depthwise_conv2d_int"}> ({
  ^bb0(%arg0: tensor<1x4x4x1xi8>, %arg1: tensor<3x3x1x2xi8>, %arg2: tensor<2xi32>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = i32, dilation = array<i64: 1, 1>, local_bound = false, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x4x4x1xi8>, tensor<3x3x1x2xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x2x2xi32>
    "func.return"(%0) : (tensor<1x2x2x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x32x32xf32>, tensor<1x32x32xf32>) -> (tensor<1x32x32xf32>, tensor<1x32x32xf32>), sym_name = "fft2d_fp"}> ({
  ^bb0(%arg0: tensor<1x32x32xf32>, %arg1: tensor<1x32x32xf32>):
    %0:2 = "tosa.fft2d"(%arg0, %arg1) <{inverse = true, local_bound = false}> : (tensor<1x32x32xf32>, tensor<1x32x32xf32>) -> (tensor<1x32x32xf32>, tensor<1x32x32xf32>)
    "func.return"(%0#0, %0#1) : (tensor<1x32x32xf32>, tensor<1x32x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xi8>, tensor<1x3x4xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x4xi32>, sym_name = "matmul_int"}> ({
  ^bb0(%arg0: tensor<1x2x3xi8>, %arg1: tensor<1x3x4xi8>, %arg2: tensor<1xi8>, %arg3: tensor<1xi8>):
    %0 = "tosa.matmul"(%arg0, %arg1, %arg2, %arg3) : (tensor<1x2x3xi8>, tensor<1x3x4xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x2x4xi32>
    "func.return"(%0) : (tensor<1x2x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4x4x1xf32>) -> tensor<1x2x2x1xf32>, sym_name = "max_pool2d_fp"}> ({
  ^bb0(%arg0: tensor<1x4x4x1xf32>):
    %0 = "tosa.max_pool2d"(%arg0) <{kernel = array<i64: 2, 2>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 2, 2>}> : (tensor<1x4x4x1xf32>) -> tensor<1x2x2x1xf32>
    "func.return"(%0) : (tensor<1x2x2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x32x32xf32>) -> (tensor<1x32x17xf32>, tensor<1x32x17xf32>), sym_name = "rfft2d_fp"}> ({
  ^bb0(%arg0: tensor<1x32x32xf32>):
    %0:2 = "tosa.rfft2d"(%arg0) <{local_bound = false}> : (tensor<1x32x32xf32>) -> (tensor<1x32x17xf32>, tensor<1x32x17xf32>)
    "func.return"(%0#0, %0#1) : (tensor<1x32x17xf32>, tensor<1x32x17xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x2x1xi8>, tensor<2x3x3x1xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x4x4x2xi32>, sym_name = "transpose_conv2d_int"}> ({
  ^bb0(%arg0: tensor<1x2x2x1xi8>, %arg1: tensor<2x3x3x1xi8>, %arg2: tensor<2xi32>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tosa.transpose_conv2d"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = i32, local_bound = false, out_pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x2x2x1xi8>, tensor<2x3x3x1xi8>, tensor<2xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x4x4x2xi32>
    "func.return"(%0) : (tensor<1x4x4x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8xi8>) -> tensor<4x8xi8>, sym_name = "clamp_int"}> ({
  ^bb0(%arg0: tensor<4x8xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 3 : i8, min_val = -2 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4x8xi8>) -> tensor<4x8xi8>
    "func.return"(%0) : (tensor<4x8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<47x38x51xf32>) -> tensor<47x38x51xf32>, sym_name = "erf_fp"}> ({
  ^bb0(%arg0: tensor<47x38x51xf32>):
    %0 = "tosa.erf"(%arg0) : (tensor<47x38x51xf32>) -> tensor<47x38x51xf32>
    "func.return"(%0) : (tensor<47x38x51xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<28x43x45xf32>) -> tensor<28x43x45xf32>, sym_name = "sigmoid_fp"}> ({
  ^bb0(%arg0: tensor<28x43x45xf32>):
    %0 = "tosa.sigmoid"(%arg0) : (tensor<28x43x45xf32>) -> tensor<28x43x45xf32>
    "func.return"(%0) : (tensor<28x43x45xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<46x50x36xf16>) -> tensor<46x50x36xf16>, sym_name = "tanh_fp"}> ({
  ^bb0(%arg0: tensor<46x50x36xf16>):
    %0 = "tosa.tanh"(%arg0) : (tensor<46x50x36xf16>) -> tensor<46x50x36xf16>
    "func.return"(%0) : (tensor<46x50x36xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x7x3x10xi32>, tensor<4x7x3x1xi32>) -> tensor<4x7x3x10xi32>, sym_name = "add_int"}> ({
  ^bb0(%arg0: tensor<4x7x3x10xi32>, %arg1: tensor<4x7x3x1xi32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<4x7x3x10xi32>, tensor<4x7x3x1xi32>) -> tensor<4x7x3x10xi32>
    "func.return"(%0) : (tensor<4x7x3x10xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4xi16>, tensor<3x4xi16>) -> tensor<3x4xi16>, sym_name = "arithmetic_right_shift_int"}> ({
  ^bb0(%arg0: tensor<1x4xi16>, %arg1: tensor<3x4xi16>):
    %0 = "tosa.arithmetic_right_shift"(%arg0, %arg1) <{round = true}> : (tensor<1x4xi16>, tensor<3x4xi16>) -> tensor<3x4xi16>
    "func.return"(%0) : (tensor<3x4xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x1x7x12xi16>, tensor<4x13x7x12xi16>) -> tensor<4x13x7x12xi16>, sym_name = "bitwiseand_int"}> ({
  ^bb0(%arg0: tensor<4x1x7x12xi16>, %arg1: tensor<4x13x7x12xi16>):
    %0 = "tosa.bitwise_and"(%arg0, %arg1) : (tensor<4x1x7x12xi16>, tensor<4x13x7x12xi16>) -> tensor<4x13x7x12xi16>
    "func.return"(%0) : (tensor<4x13x7x12xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<11x30x23xi32>, tensor<1x30x23xi32>) -> tensor<11x30x23xi32>, sym_name = "bitwiseor_int"}> ({
  ^bb0(%arg0: tensor<11x30x23xi32>, %arg1: tensor<1x30x23xi32>):
    %0 = "tosa.bitwise_or"(%arg0, %arg1) : (tensor<11x30x23xi32>, tensor<1x30x23xi32>) -> tensor<11x30x23xi32>
    "func.return"(%0) : (tensor<11x30x23xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8x13x9xi16>, tensor<4x8x1x9xi16>) -> tensor<4x8x13x9xi16>, sym_name = "bitwisexor_int"}> ({
  ^bb0(%arg0: tensor<4x8x13x9xi16>, %arg1: tensor<4x8x1x9xi16>):
    %0 = "tosa.bitwise_xor"(%arg0, %arg1) : (tensor<4x8x13x9xi16>, tensor<4x8x1x9xi16>) -> tensor<4x8x13x9xi16>
    "func.return"(%0) : (tensor<4x8x13x9xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x65533x1xi32>, tensor<2x65533x1xi32>) -> tensor<2x65533x1xi32>, sym_name = "intdiv_any"}> ({
  ^bb0(%arg0: tensor<1x65533x1xi32>, %arg1: tensor<2x65533x1xi32>):
    %0 = "tosa.intdiv"(%arg0, %arg1) : (tensor<1x65533x1xi32>, tensor<2x65533x1xi32>) -> tensor<2x65533x1xi32>
    "func.return"(%0) : (tensor<2x65533x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x1x7x11xi1>, tensor<2x4x7x11xi1>) -> tensor<2x4x7x11xi1>, sym_name = "logicaland_any"}> ({
  ^bb0(%arg0: tensor<2x1x7x11xi1>, %arg1: tensor<2x4x7x11xi1>):
    %0 = "tosa.logical_and"(%arg0, %arg1) : (tensor<2x1x7x11xi1>, tensor<2x4x7x11xi1>) -> tensor<2x4x7x11xi1>
    "func.return"(%0) : (tensor<2x4x7x11xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<7x1x11x4xi8>, tensor<7x8x11x4xi8>) -> tensor<7x8x11x4xi8>, sym_name = "logicalleftshift_any"}> ({
  ^bb0(%arg0: tensor<7x1x11x4xi8>, %arg1: tensor<7x8x11x4xi8>):
    %0 = "tosa.logical_left_shift"(%arg0, %arg1) : (tensor<7x1x11x4xi8>, tensor<7x8x11x4xi8>) -> tensor<7x8x11x4xi8>
    "func.return"(%0) : (tensor<7x8x11x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6x13x1x19xi8>, tensor<6x13x6x19xi8>) -> tensor<6x13x6x19xi8>, sym_name = "logicalrightshift_any"}> ({
  ^bb0(%arg0: tensor<6x13x1x19xi8>, %arg1: tensor<6x13x6x19xi8>):
    %0 = "tosa.logical_right_shift"(%arg0, %arg1) : (tensor<6x13x1x19xi8>, tensor<6x13x6x19xi8>) -> tensor<6x13x6x19xi8>
    "func.return"(%0) : (tensor<6x13x6x19xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x6x12x5xi1>, tensor<3x6x1x5xi1>) -> tensor<3x6x12x5xi1>, sym_name = "logicalor_any"}> ({
  ^bb0(%arg0: tensor<3x6x12x5xi1>, %arg1: tensor<3x6x1x5xi1>):
    %0 = "tosa.logical_or"(%arg0, %arg1) : (tensor<3x6x12x5xi1>, tensor<3x6x1x5xi1>) -> tensor<3x6x12x5xi1>
    "func.return"(%0) : (tensor<3x6x12x5xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<11x4x9x12xi1>, tensor<11x4x9x1xi1>) -> tensor<11x4x9x12xi1>, sym_name = "logicalxor_any"}> ({
  ^bb0(%arg0: tensor<11x4x9x12xi1>, %arg1: tensor<11x4x9x1xi1>):
    %0 = "tosa.logical_xor"(%arg0, %arg1) : (tensor<11x4x9x12xi1>, tensor<11x4x9x1xi1>) -> tensor<11x4x9x12xi1>
    "func.return"(%0) : (tensor<11x4x9x12xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x65533x1xi32>, tensor<1x2x65533x2xi32>) -> tensor<1x2x65533x2xi32>, sym_name = "maximum_int"}> ({
  ^bb0(%arg0: tensor<1x2x65533x1xi32>, %arg1: tensor<1x2x65533x2xi32>):
    %0 = "tosa.maximum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1x2x65533x1xi32>, tensor<1x2x65533x2xi32>) -> tensor<1x2x65533x2xi32>
    "func.return"(%0) : (tensor<1x2x65533x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<15x2x10x11xi32>, tensor<15x1x10x11xi32>) -> tensor<15x2x10x11xi32>, sym_name = "minimum_int"}> ({
  ^bb0(%arg0: tensor<15x2x10x11xi32>, %arg1: tensor<15x1x10x11xi32>):
    %0 = "tosa.minimum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<15x2x10x11xi32>, tensor<15x1x10x11xi32>) -> tensor<15x2x10x11xi32>
    "func.return"(%0) : (tensor<15x2x10x11xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x4xi32>, tensor<2x1xi32>, tensor<1xi8>) -> tensor<2x4xi32>, sym_name = "mul_int"}> ({
  ^bb0(%arg0: tensor<2x4xi32>, %arg1: tensor<2x1xi32>, %arg2: tensor<1xi8>):
    %0 = "tosa.mul"(%arg0, %arg1, %arg2) : (tensor<2x4xi32>, tensor<2x1xi32>, tensor<1xi8>) -> tensor<2x4xi32>
    "func.return"(%0) : (tensor<2x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x52x53xf16>, tensor<44x52x53xf16>) -> tensor<44x52x53xf16>, sym_name = "pow_fp"}> ({
  ^bb0(%arg0: tensor<1x52x53xf16>, %arg1: tensor<44x52x53xf16>):
    %0 = "tosa.pow"(%arg0, %arg1) : (tensor<1x52x53xf16>, tensor<44x52x53xf16>) -> tensor<44x52x53xf16>
    "func.return"(%0) : (tensor<44x52x53xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6x10x6x6xi32>, tensor<1x10x6x6xi32>) -> tensor<6x10x6x6xi32>, sym_name = "sub_int"}> ({
  ^bb0(%arg0: tensor<6x10x6x6xi32>, %arg1: tensor<1x10x6x6xi32>):
    %0 = "tosa.sub"(%arg0, %arg1) : (tensor<6x10x6x6xi32>, tensor<1x10x6x6xi32>) -> tensor<6x10x6x6xi32>
    "func.return"(%0) : (tensor<6x10x6x6xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2xi8>, tensor<256xi8>) -> tensor<3x2xi8>, sym_name = "table_int"}> ({
  ^bb0(%arg0: tensor<3x2xi8>, %arg1: tensor<256xi8>):
    %0 = "tosa.table"(%arg0, %arg1) : (tensor<3x2xi8>, tensor<256xi8>) -> tensor<3x2xi8>
    "func.return"(%0) : (tensor<3x2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x1x4x4xi32>) -> tensor<5x1x4x4xi32>, sym_name = "abs_int"}> ({
  ^bb0(%arg0: tensor<5x1x4x4xi32>):
    %0 = "tosa.abs"(%arg0) : (tensor<5x1x4x4xi32>) -> tensor<5x1x4x4xi32>
    "func.return"(%0) : (tensor<5x1x4x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<12x56x50xi32>) -> tensor<12x56x50xi32>, sym_name = "bitwisenot_int"}> ({
  ^bb0(%arg0: tensor<12x56x50xi32>):
    %0 = "tosa.bitwise_not"(%arg0) : (tensor<12x56x50xi32>) -> tensor<12x56x50xi32>
    "func.return"(%0) : (tensor<12x56x50xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<46x55x53xf16>) -> tensor<46x55x53xf16>, sym_name = "ceil_fp"}> ({
  ^bb0(%arg0: tensor<46x55x53xf16>):
    %0 = "tosa.ceil"(%arg0) : (tensor<46x55x53xf16>) -> tensor<46x55x53xf16>
    "func.return"(%0) : (tensor<46x55x53xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<14x10x7x5xi32>) -> tensor<14x10x7x5xi32>, sym_name = "clz_int"}> ({
  ^bb0(%arg0: tensor<14x10x7x5xi32>):
    %0 = "tosa.clz"(%arg0) : (tensor<14x10x7x5xi32>) -> tensor<14x10x7x5xi32>
    "func.return"(%0) : (tensor<14x10x7x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<44x49x51xf32>) -> tensor<44x49x51xf32>, sym_name = "cos_fp"}> ({
  ^bb0(%arg0: tensor<44x49x51xf32>):
    %0 = "tosa.cos"(%arg0) : (tensor<44x49x51xf32>) -> tensor<44x49x51xf32>
    "func.return"(%0) : (tensor<44x49x51xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<37x53x47xf32>) -> tensor<37x53x47xf32>, sym_name = "exp_fp"}> ({
  ^bb0(%arg0: tensor<37x53x47xf32>):
    %0 = "tosa.exp"(%arg0) : (tensor<37x53x47xf32>) -> tensor<37x53x47xf32>
    "func.return"(%0) : (tensor<37x53x47xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<40x52x42xf32>) -> tensor<40x52x42xf32>, sym_name = "floor_fp"}> ({
  ^bb0(%arg0: tensor<40x52x42xf32>):
    %0 = "tosa.floor"(%arg0) : (tensor<40x52x42xf32>) -> tensor<40x52x42xf32>
    "func.return"(%0) : (tensor<40x52x42xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<45x43x36xf16>) -> tensor<45x43x36xf16>, sym_name = "log_fp"}> ({
  ^bb0(%arg0: tensor<45x43x36xf16>):
    %0 = "tosa.log"(%arg0) : (tensor<45x43x36xf16>) -> tensor<45x43x36xf16>
    "func.return"(%0) : (tensor<45x43x36xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<54x26x10xi1>) -> tensor<54x26x10xi1>, sym_name = "logicalnot_any"}> ({
  ^bb0(%arg0: tensor<54x26x10xi1>):
    %0 = "tosa.logical_not"(%arg0) : (tensor<54x26x10xi1>) -> tensor<54x26x10xi1>
    "func.return"(%0) : (tensor<54x26x10xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2x3xi8>, sym_name = "negate_int"}> ({
  ^bb0(%arg0: tensor<2x3xi8>, %arg1: tensor<1xi8>, %arg2: tensor<1xi8>):
    %0 = "tosa.negate"(%arg0, %arg1, %arg2) : (tensor<2x3xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2x3xi8>
    "func.return"(%0) : (tensor<2x3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<38x47x44xf32>) -> tensor<38x47x44xf32>, sym_name = "reciprocal_fp"}> ({
  ^bb0(%arg0: tensor<38x47x44xf32>):
    %0 = "tosa.reciprocal"(%arg0) : (tensor<38x47x44xf32>) -> tensor<38x47x44xf32>
    "func.return"(%0) : (tensor<38x47x44xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<40x57x56xf32>) -> tensor<40x57x56xf32>, sym_name = "rsqrt_fp"}> ({
  ^bb0(%arg0: tensor<40x57x56xf32>):
    %0 = "tosa.rsqrt"(%arg0) : (tensor<40x57x56xf32>) -> tensor<40x57x56xf32>
    "func.return"(%0) : (tensor<40x57x56xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<49x38x58xf16>) -> tensor<49x38x58xf16>, sym_name = "sin_fp"}> ({
  ^bb0(%arg0: tensor<49x38x58xf16>):
    %0 = "tosa.sin"(%arg0) : (tensor<49x38x58xf16>) -> tensor<49x38x58xf16>
    "func.return"(%0) : (tensor<49x38x58xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x1xi1>, tensor<2x4xi8>, tensor<2x4xi8>) -> tensor<2x4xi8>, sym_name = "select_int"}> ({
  ^bb0(%arg0: tensor<2x1xi1>, %arg1: tensor<2x4xi8>, %arg2: tensor<2x4xi8>):
    %0 = "tosa.select"(%arg0, %arg1, %arg2) : (tensor<2x1xi1>, tensor<2x4xi8>, tensor<2x4xi8>) -> tensor<2x4xi8>
    "func.return"(%0) : (tensor<2x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<51x28x59xi32>, tensor<51x1x59xi32>) -> tensor<51x28x59xi1>, sym_name = "equal_int"}> ({
  ^bb0(%arg0: tensor<51x28x59xi32>, %arg1: tensor<51x1x59xi32>):
    %0 = "tosa.equal"(%arg0, %arg1) : (tensor<51x28x59xi32>, tensor<51x1x59xi32>) -> tensor<51x28x59xi1>
    "func.return"(%0) : (tensor<51x28x59xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<11x10x10x2xi32>, tensor<11x10x10x1xi32>) -> tensor<11x10x10x2xi1>, sym_name = "greater_int"}> ({
  ^bb0(%arg0: tensor<11x10x10x2xi32>, %arg1: tensor<11x10x10x1xi32>):
    %0 = "tosa.greater"(%arg0, %arg1) : (tensor<11x10x10x2xi32>, tensor<11x10x10x1xi32>) -> tensor<11x10x10x2xi1>
    "func.return"(%0) : (tensor<11x10x10x2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x17x7x1xi32>, tensor<10x17x7x16xi32>) -> tensor<10x17x7x16xi1>, sym_name = "greaterequal_int"}> ({
  ^bb0(%arg0: tensor<10x17x7x1xi32>, %arg1: tensor<10x17x7x16xi32>):
    %0 = "tosa.greater_equal"(%arg0, %arg1) : (tensor<10x17x7x1xi32>, tensor<10x17x7x16xi32>) -> tensor<10x17x7x16xi1>
    "func.return"(%0) : (tensor<10x17x7x16xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xi1>) -> tensor<2x1x4xi1>, sym_name = "reduce_all"}> ({
  ^bb0(%arg0: tensor<2x3x4xi1>):
    %0 = "tosa.reduce_all"(%arg0) <{axis = 1 : i32}> : (tensor<2x3x4xi1>) -> tensor<2x1x4xi1>
    "func.return"(%0) : (tensor<2x1x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xi1>) -> tensor<2x1x4xi1>, sym_name = "reduce_any"}> ({
  ^bb0(%arg0: tensor<2x3x4xi1>):
    %0 = "tosa.reduce_any"(%arg0) <{axis = 1 : i32}> : (tensor<2x3x4xi1>) -> tensor<2x1x4xi1>
    "func.return"(%0) : (tensor<2x1x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xi8>) -> tensor<2x1x4xi8>, sym_name = "reduce_max_int"}> ({
  ^bb0(%arg0: tensor<2x3x4xi8>):
    %0 = "tosa.reduce_max"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<2x3x4xi8>) -> tensor<2x1x4xi8>
    "func.return"(%0) : (tensor<2x1x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xi8>) -> tensor<2x1x4xi8>, sym_name = "reduce_min_int"}> ({
  ^bb0(%arg0: tensor<2x3x4xi8>):
    %0 = "tosa.reduce_min"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<2x3x4xi8>) -> tensor<2x1x4xi8>
    "func.return"(%0) : (tensor<2x1x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>) -> tensor<2x1x4xf32>, sym_name = "reduce_product_fp"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>):
    %0 = "tosa.reduce_product"(%arg0) <{axis = 1 : i32}> : (tensor<2x3x4xf32>) -> tensor<2x1x4xf32>
    "func.return"(%0) : (tensor<2x1x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xi32>) -> tensor<2x1x4xi32>, sym_name = "reduce_sum_int"}> ({
  ^bb0(%arg0: tensor<2x3x4xi32>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 1 : i32}> : (tensor<2x3x4xi32>) -> tensor<2x1x4xi32>
    "func.return"(%0) : (tensor<2x1x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>, tensor<2x4xi8>) -> tensor<2x7xi8>, sym_name = "concat_int"}> ({
  ^bb0(%arg0: tensor<2x3xi8>, %arg1: tensor<2x4xi8>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 1 : i32}> : (tensor<2x3xi8>, tensor<2x4xi8>) -> tensor<2x7xi8>
    "func.return"(%0) : (tensor<2x7xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<65xi8>, sym_name = "concat_split_int"}> ({
  ^bb0(%arg0: tensor<1xi8>, %arg1: tensor<1xi8>, %arg2: tensor<1xi8>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>, %arg5: tensor<1xi8>, %arg6: tensor<1xi8>, %arg7: tensor<1xi8>, %arg8: tensor<1xi8>, %arg9: tensor<1xi8>, %arg10: tensor<1xi8>, %arg11: tensor<1xi8>, %arg12: tensor<1xi8>, %arg13: tensor<1xi8>, %arg14: tensor<1xi8>, %arg15: tensor<1xi8>, %arg16: tensor<1xi8>, %arg17: tensor<1xi8>, %arg18: tensor<1xi8>, %arg19: tensor<1xi8>, %arg20: tensor<1xi8>, %arg21: tensor<1xi8>, %arg22: tensor<1xi8>, %arg23: tensor<1xi8>, %arg24: tensor<1xi8>, %arg25: tensor<1xi8>, %arg26: tensor<1xi8>, %arg27: tensor<1xi8>, %arg28: tensor<1xi8>, %arg29: tensor<1xi8>, %arg30: tensor<1xi8>, %arg31: tensor<1xi8>, %arg32: tensor<1xi8>, %arg33: tensor<1xi8>, %arg34: tensor<1xi8>, %arg35: tensor<1xi8>, %arg36: tensor<1xi8>, %arg37: tensor<1xi8>, %arg38: tensor<1xi8>, %arg39: tensor<1xi8>, %arg40: tensor<1xi8>, %arg41: tensor<1xi8>, %arg42: tensor<1xi8>, %arg43: tensor<1xi8>, %arg44: tensor<1xi8>, %arg45: tensor<1xi8>, %arg46: tensor<1xi8>, %arg47: tensor<1xi8>, %arg48: tensor<1xi8>, %arg49: tensor<1xi8>, %arg50: tensor<1xi8>, %arg51: tensor<1xi8>, %arg52: tensor<1xi8>, %arg53: tensor<1xi8>, %arg54: tensor<1xi8>, %arg55: tensor<1xi8>, %arg56: tensor<1xi8>, %arg57: tensor<1xi8>, %arg58: tensor<1xi8>, %arg59: tensor<1xi8>, %arg60: tensor<1xi8>, %arg61: tensor<1xi8>, %arg62: tensor<1xi8>, %arg63: tensor<1xi8>, %arg64: tensor<1xi8>):
    %0 = "tosa.concat"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63, %arg64) <{axis = 0 : i32}> : (tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<65xi8>
    "func.return"(%0) : (tensor<65xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi8>) -> tensor<?xi8>, sym_name = "concat_split_dynamic"}> ({
  ^bb0(%arg0: tensor<?xi8>):
    %0 = "tosa.concat"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{axis = 0 : i32}> : (tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>, tensor<?xi8>) -> tensor<?xi8>
    "func.return"(%0) : (tensor<?xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xi8>) -> tensor<4x8xi8>, sym_name = "pad_int"}> ({
  ^bb0(%arg0: tensor<1x2xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 3]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<7> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x2xi8>, !tosa.shape<4>, tensor<1xi8>) -> tensor<4x8xi8>
    "func.return"(%2) : (tensor<4x8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<25x6x29x35xi16>) -> tensor<125x6x7x29xi16>, sym_name = "reshape_int"}> ({
  ^bb0(%arg0: tensor<25x6x29x35xi16>):
    %0 = "tosa.const_shape"() <{values = dense<[125, 6, 7, 29]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<25x6x29x35xi16>, !tosa.shape<4>) -> tensor<125x6x7x29xi16>
    "func.return"(%1) : (tensor<125x6x7x29xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<20x5x28x31xi32>) -> tensor<20x5x28x31xi32>, sym_name = "reverse_int"}> ({
  ^bb0(%arg0: tensor<20x5x28x31xi32>):
    %0 = "tosa.reverse"(%arg0) <{axis = 2 : i32}> : (tensor<20x5x28x31xi32>) -> tensor<20x5x28x31xi32>
    "func.return"(%0) : (tensor<20x5x28x31xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<32x19x41xi8>) -> tensor<21x5x2xi8>, sym_name = "slice_int"}> ({
  ^bb0(%arg0: tensor<32x19x41xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[8, 11, 39]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.const_shape"() <{values = dense<[21, 5, 2]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %2 = "tosa.slice"(%arg0, %0, %1) : (tensor<32x19x41xi8>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<21x5x2xi8>
    "func.return"(%2) : (tensor<21x5x2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x28x21xi16>) -> tensor<10x28x63xi16>, sym_name = "tile_int"}> ({
  ^bb0(%arg0: tensor<10x28x21xi16>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 1, 3]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.tile"(%arg0, %0) : (tensor<10x28x21xi16>, !tosa.shape<3>) -> tensor<10x28x63xi16>
    "func.return"(%1) : (tensor<10x28x63xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<14x28x1x61xi16>) -> tensor<1x14x28x61xi16>, sym_name = "transpose_int"}> ({
  ^bb0(%arg0: tensor<14x28x1x61xi16>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 2, 0, 1, 3>}> : (tensor<14x28x1x61xi16>) -> tensor<1x14x28x61xi16>
    "func.return"(%0) : (tensor<1x14x28x61xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<31x11x45xi32>, tensor<31x15xi32>) -> tensor<31x15x45xi32>, sym_name = "gather_int"}> ({
  ^bb0(%arg0: tensor<31x11x45xi32>, %arg1: tensor<31x15xi32>):
    %0 = "tosa.gather"(%arg0, %arg1) : (tensor<31x11x45xi32>, tensor<31x15xi32>) -> tensor<31x15x45xi32>
    "func.return"(%0) : (tensor<31x15x45xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<34x28x54xi32>, tensor<34x18xi32>, tensor<34x18x54xi32>) -> tensor<34x28x54xi32>, sym_name = "scatter_int"}> ({
  ^bb0(%arg0: tensor<34x28x54xi32>, %arg1: tensor<34x18xi32>, %arg2: tensor<34x18x54xi32>):
    %0 = "tosa.scatter"(%arg0, %arg1, %arg2) : (tensor<34x28x54xi32>, tensor<34x18xi32>, tensor<34x18x54xi32>) -> tensor<34x28x54xi32>
    "func.return"(%0) : (tensor<34x28x54xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x31x55xi8>) -> tensor<1x1x278x55xi8>, sym_name = "resize_int"}> ({
  ^bb0(%arg0: tensor<1x1x31x55xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[16, 1, 9, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<[0, 7]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<1x1x31x55xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x1x278x55xi8>
    "func.return"(%3) : (tensor<1x1x278x55xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>) -> tensor<2x3xi32>, sym_name = "cast_int"}> ({
  ^bb0(%arg0: tensor<2x3xi8>):
    %0 = "tosa.cast"(%arg0) : (tensor<2x3xi8>) -> tensor<2x3xi32>
    "func.return"(%0) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi16>) -> tensor<2x3xi16>, sym_name = "rescale_int"}> ({
  ^bb0(%arg0: tensor<2x3xi16>):
    %0 = "tosa.const"() <{values = dense<1073741824> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<30> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<2x3xi16>, tensor<1xi32>, tensor<1xi8>, tensor<1xi16>, tensor<1xi16>) -> tensor<2x3xi16>
    "func.return"(%4) : (tensor<2x3xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2x3xi8>, sym_name = "const_int"}> ({
    %0 = "tosa.const"() <{values = dense<[[1, 2, 3], [4, 5, 6]]> : tensor<2x3xi8>}> : () -> tensor<2x3xi8>
    "func.return"(%0) : (tensor<2x3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<17xi32>, sym_name = "graph_constant"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> {grapharm.graph_constant_id = 7 : i32} : () -> tensor<17xi32>
    "func.return"(%0) : (tensor<17xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2xi4>, sym_name = "const_i4"}> ({
    %0 = "tosa.const"() <{values = dense<[7, -8]> : tensor<2xi4>}> : () -> tensor<2xi4>
    "func.return"(%0) : (tensor<2xi4>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2xi48>, sym_name = "const_i48"}> ({
    %0 = "tosa.const"() <{values = dense<[140737488355327, -140737488355328]> : tensor<2xi48>}> : () -> tensor<2xi48>
    "func.return"(%0) : (tensor<2xi48>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !tosa.shape<0>, sym_name = "const_shape_empty"}> ({
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    "func.return"(%0) : (!tosa.shape<0>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !tosa.shape<33>, sym_name = "graph_constant_shape"}> ({
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]> : tensor<33xindex>}> {grapharm.graph_constant_id = 8 : i32} : () -> !tosa.shape<33>
    "func.return"(%0) : (!tosa.shape<33>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>) -> tensor<2x3xi8>, sym_name = "identity_int"}> ({
  ^bb0(%arg0: tensor<2x3xi8>):
    %0 = "tosa.identity"(%arg0) : (tensor<2x3xi8>) -> tensor<2x3xi8>
    "func.return"(%0) : (tensor<2x3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

