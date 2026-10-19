"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<1xi32>, sym_name = "argmax_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.argmax"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x1xf32>) -> tensor<1xi32>
    "func.return"(%0) : (tensor<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> tensor<i64>, sym_name = "test_argmax_fold_i64_index"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "tosa.argmax"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xi8>) -> tensor<i64>
    "func.return"(%0) : (tensor<i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x10x8x3xf32>) -> tensor<1x6x5x3xf32>, sym_name = "pad_wh_avg_pool2d_nofold"}> ({
  ^bb0(%arg0: tensor<1x10x8x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 0, 1, 0, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x11x9x3xf32>
    %5 = "tosa.avg_pool2d"(%4, %2, %3) <{acc_type = f32, kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>}> : (tensor<1x11x9x3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x6x5x3xf32>
    "func.return"(%5) : (tensor<1x6x5x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x10x8x3xi8>) -> tensor<1x6x5x3xi8>, sym_name = "pad_wh_avg_pool2d_nofold_pad_const"}> ({
  ^bb0(%arg0: tensor<1x10x8x3xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 0, 1, 0, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<10> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<20> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x10x8x3xi8>, !tosa.shape<8>, tensor<1xi8>) -> tensor<1x11x9x3xi8>
    %5 = "tosa.avg_pool2d"(%4, %2, %3) <{acc_type = i32, kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>}> : (tensor<1x11x9x3xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x6x5x3xi8>
    "func.return"(%5) : (tensor<1x6x5x3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x10x8x3xf32>) -> tensor<1x7x5x3xf32>, sym_name = "pad_wh_avg_pool2d_nofold_pad_larger_than_kernel"}> ({
  ^bb0(%arg0: tensor<1x10x8x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 3, 0, 1, 0, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x13x9x3xf32>
    %5 = "tosa.avg_pool2d"(%4, %2, %3) <{acc_type = f32, kernel = array<i64: 2, 2>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>}> : (tensor<1x13x9x3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x7x5x3xf32>
    "func.return"(%5) : (tensor<1x7x5x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x8x4x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>) -> tensor<1x10x8x1xf32>, sym_name = "pad_wh_conv2d_fold"}> ({
  ^bb0(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<1x3x3x3xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 1, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x8x4x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x10x8x3xf32>
    %5 = "tosa.conv2d"(%4, %arg1, %arg2, %2, %3) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x10x8x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x10x8x1xf32>
    "func.return"(%5) : (tensor<1x10x8x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x8x4x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>) -> tensor<3x10x8x1xf32>, sym_name = "pad_bwh_conv2d_nofold"}> ({
  ^bb0(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<1x3x3x3xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 1, 1, 1, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x8x4x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<3x10x8x3xf32>
    %5 = "tosa.conv2d"(%4, %arg1, %arg2, %2, %3) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<3x10x8x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<3x10x8x1xf32>
    "func.return"(%5) : (tensor<3x10x8x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x8x4x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>) -> tensor<1x10x8x1xf32>, sym_name = "pad_wh_conv2d_nofold_pad_const"}> ({
  ^bb0(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<1x3x3x3xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 1, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x8x4x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x10x8x3xf32>
    %5 = "tosa.conv2d"(%4, %arg1, %arg2, %2, %3) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x10x8x3xf32>, tensor<1x3x3x3xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x10x8x1xf32>
    "func.return"(%5) : (tensor<1x10x8x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x8x4x3xf32>, tensor<3x3x3x1xf32>, tensor<3xf32>) -> tensor<1x10x8x3xf32>, sym_name = "pad_wh_depthwise_conv2d_fold"}> ({
  ^bb0(%arg0: tensor<1x8x4x3xf32>, %arg1: tensor<3x3x3x1xf32>, %arg2: tensor<3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 1, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x8x4x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x10x8x3xf32>
    %5 = "tosa.depthwise_conv2d"(%4, %arg1, %arg2, %2, %3) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x10x8x3xf32>, tensor<3x3x3x1xf32>, tensor<3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x10x8x3xf32>
    "func.return"(%5) : (tensor<1x10x8x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x10x8x3xf32>) -> tensor<1x6x5x3xf32>, sym_name = "pad_wh_max_pool2d_fold"}> ({
  ^bb0(%arg0: tensor<1x10x8x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 0, 1, 0, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<-3.40282347E+38> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x11x9x3xf32>
    %3 = "tosa.max_pool2d"(%2) <{kernel = array<i64: 2, 2>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>}> : (tensor<1x11x9x3xf32>) -> tensor<1x6x5x3xf32>
    "func.return"(%3) : (tensor<1x6x5x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x10x8x3xf32>) -> tensor<1x6x5x3xf32>, sym_name = "pad_wh_max_pool2d_nofold_pad_const"}> ({
  ^bb0(%arg0: tensor<1x10x8x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 0, 1, 0, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x11x9x3xf32>
    %3 = "tosa.max_pool2d"(%2) <{kernel = array<i64: 2, 2>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>}> : (tensor<1x11x9x3xf32>) -> tensor<1x6x5x3xf32>
    "func.return"(%3) : (tensor<1x6x5x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x10x8x3xf32>) -> tensor<1x6x4101x3xf32>, sym_name = "pad_wh_max_pool2d_no_fold_8k_limit"}> ({
  ^bb0(%arg0: tensor<1x10x8x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 0, 8193, 0, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x10x8x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x11x8201x3xf32>
    %3 = "tosa.max_pool2d"(%2) <{kernel = array<i64: 2, 2>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 1, 0, 1>, stride = array<i64: 2, 2>}> : (tensor<1x11x8201x3xf32>) -> tensor<1x6x4101x3xf32>
    "func.return"(%3) : (tensor<1x6x4101x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x2x3xi32>) -> tensor<4x2x3xi32>, sym_name = "add_bcast_zero_int"}> ({
  ^bb0(%arg0: tensor<4x2x3xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1x1x1xi32>}> : () -> tensor<1x1x1xi32>
    %1 = "tosa.add"(%arg0, %0) : (tensor<4x2x3xi32>, tensor<1x1x1xi32>) -> tensor<4x2x3xi32>
    "func.return"(%1) : (tensor<4x2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>) -> tensor<2x3xi32>, sym_name = "add_zero_int"}> ({
  ^bb0(%arg0: tensor<2x3xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<2x3xi32>}> : () -> tensor<2x3xi32>
    %1 = "tosa.add"(%arg0, %0) : (tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>
    "func.return"(%1) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "cast_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.cast"(%arg0) : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xi32>, sym_name = "cast_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.cast"(%arg0) : (tensor<?x1xf32>) -> tensor<?x1xi32>
    "func.return"(%0) : (tensor<?x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi32>) -> tensor<4xi32>, sym_name = "clamp_i32_not_noop"}> ({
  ^bb0(%arg0: tensor<4xi32>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 4 : i32, min_val = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi32>) -> tensor<4xi32>
    "func.return"(%0) : (tensor<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4xf32>, sym_name = "clamp_f32_not_noop"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 3.40282347E+38 : f32, min_val = -3.40282347E+38 : f32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xf32>) -> tensor<4xf32>
    "func.return"(%0) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf16>) -> tensor<4xf16>, sym_name = "clamp_f16_is_noop"}> ({
  ^bb0(%arg0: tensor<4xf16>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 0x7C00 : f16, min_val = 0xFC00 : f16, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xf16>) -> tensor<4xf16>
    "func.return"(%0) : (tensor<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4xf32>, sym_name = "clamp_f32_is_noop"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 0x7F800000 : f32, min_val = 0xFF800000 : f32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xf32>) -> tensor<4xf32>
    "func.return"(%0) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi1>) -> tensor<4xi1>, sym_name = "clamp_boolean_is_noop"}> ({
  ^bb0(%arg0: tensor<4xi1>):
    %0 = "tosa.clamp"(%arg0) <{max_val = true, min_val = false, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi1>) -> tensor<4xi1>
    "func.return"(%0) : (tensor<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi1>) -> tensor<?xi1>, sym_name = "clamp_boolean_dynamic_is_noop"}> ({
  ^bb0(%arg0: tensor<?xi1>):
    %0 = "tosa.clamp"(%arg0) <{max_val = true, min_val = false, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?xi1>) -> tensor<?xi1>
    "func.return"(%0) : (tensor<?xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xi8>, sym_name = "clamp_int8_is_noop"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 127 : i8, min_val = -128 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    "func.return"(%0) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi16>) -> tensor<4xi16>, sym_name = "clamp_int16_is_noop"}> ({
  ^bb0(%arg0: tensor<4xi16>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 32767 : i16, min_val = -32768 : i16, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi16>) -> tensor<4xi16>
    "func.return"(%0) : (tensor<4xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xui8>) -> tensor<4xui8>, sym_name = "clamp_uint8_is_noop"}> ({
  ^bb0(%arg0: tensor<4xui8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 255 : ui8, min_val = 0 : ui8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xui8>) -> tensor<4xui8>
    "func.return"(%0) : (tensor<4xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xi8>, sym_name = "clamp_twice_is_single_clamp"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 4 : i8, min_val = -2 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    %1 = "tosa.clamp"(%0) <{max_val = 2 : i8, min_val = -4 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    "func.return"(%1) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xi8>, sym_name = "disjoint_clamp_twice_is_not_single_clamp"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = -5 : i8, min_val = -10 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    %1 = "tosa.clamp"(%0) <{max_val = 5 : i8, min_val = 1 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    "func.return"(%1) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xi8>, sym_name = "clamp_twice_with_nan_propagate_is_single_clamp"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 4 : i8, min_val = -2 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    %1 = "tosa.clamp"(%0) <{max_val = 2 : i8, min_val = -4 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    "func.return"(%1) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xi8>, sym_name = "clamp_twice_with_nan_ignore_is_single_clamp"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 4 : i8, min_val = -2 : i8, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<4xi8>) -> tensor<4xi8>
    %1 = "tosa.clamp"(%0) <{max_val = 2 : i8, min_val = -4 : i8, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<4xi8>) -> tensor<4xi8>
    "func.return"(%1) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xi8>, sym_name = "clamp_twice_with_nan_ignore_propagate_is_single_clamp"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 4 : i8, min_val = -2 : i8, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<4xi8>) -> tensor<4xi8>
    %1 = "tosa.clamp"(%0) <{max_val = 2 : i8, min_val = -4 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    "func.return"(%1) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xi8>, sym_name = "clamp_twice_with_nan_propagate_ignore_is_not_single_clamp"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 4 : i8, min_val = -2 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<4xi8>) -> tensor<4xi8>
    %1 = "tosa.clamp"(%0) <{max_val = 2 : i8, min_val = -4 : i8, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<4xi8>) -> tensor<4xi8>
    "func.return"(%1) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>, sym_name = "clamp_twice_with_unsigned_quantized_is_single_clamp"}> ({
  ^bb0(%arg0: tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 240 : ui8, min_val = 10 : ui8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>
    %1 = "tosa.clamp"(%0) <{max_val = 230 : ui8, min_val = 5 : ui8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>
    "func.return"(%1) : (tensor<?x112x112x32x!quant.uniform<u8:f32, 0.023529412224888802:-128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>, sym_name = "clamp_twice_with_signed_quantized_is_single_clamp"}> ({
  ^bb0(%arg1: tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>):
    %2 = "tosa.clamp"(%arg1) <{max_val = 110 : i8, min_val = -10 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
    %3 = "tosa.clamp"(%2) <{max_val = 120 : i8, min_val = -5 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
    "func.return"(%3) : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>, sym_name = "clamp_twice_with_signed_quantized_non_overlap_is_not_single_clamp"}> ({
  ^bb0(%arg0: tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 50 : i8, min_val = -10 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
    %1 = "tosa.clamp"(%0) <{max_val = 120 : i8, min_val = 60 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>
    "func.return"(%1) : (tensor<?x112x112x32x!quant.uniform<i8:f32, 0.023529412224888802:-128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "concat_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.concat"(%arg0) <{axis = 0 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x?xf32>, sym_name = "concat_fold_cast"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.concat"(%arg0) <{axis = 0 : i32}> : (tensor<?x1xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x11x11x2xf32>) -> tensor<4x6x6x3xf32>, sym_name = "conv2d_stride_2"}> ({
  ^bb0(%arg0: tensor<4x11x11x2xf32>):
    %0 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<3x1x1x2xf32>}> : () -> tensor<3x1x1x2xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.conv2d"(%arg0, %0, %1, %2, %3) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 2, 2>}> : (tensor<4x11x11x2xf32>, tensor<3x1x1x2xf32>, tensor<3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x6x6x3xf32>
    "func.return"(%4) : (tensor<4x6x6x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x10x10x1xf32>) -> tensor<4x9x9x1xf32>, sym_name = "conv2d_weight_2x2"}> ({
  ^bb0(%arg0: tensor<4x10x10x1xf32>):
    %0 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<1x2x2x1xf32>}> : () -> tensor<1x2x2x1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.conv2d"(%arg0, %0, %1, %2, %3) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<4x10x10x1xf32>, tensor<1x2x2x1xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x9x9x1xf32>
    "func.return"(%4) : (tensor<4x9x9x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x11x11x2xf32>, tensor<1x1x2x3xf32>, tensor<6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x6x6x6xf32>, sym_name = "depthwise_conv2d_stride_2"}> ({
  ^bb0(%arg0: tensor<4x11x11x2xf32>, %arg1: tensor<1x1x2x3xf32>, %arg2: tensor<6xf32>, %arg3: tensor<1xf32>, %arg4: tensor<1xf32>):
    %0 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 2, 2>}> : (tensor<4x11x11x2xf32>, tensor<1x1x2x3xf32>, tensor<6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x6x6x6xf32>
    "func.return"(%0) : (tensor<4x6x6x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x10x10x2xf32>, tensor<2x2x2x3xf32>, tensor<6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x9x9x6xf32>, sym_name = "depthwise_conv2d_weight_2x2"}> ({
  ^bb0(%arg0: tensor<4x10x10x2xf32>, %arg1: tensor<2x2x2x3xf32>, %arg2: tensor<6xf32>, %arg3: tensor<1xf32>, %arg4: tensor<1xf32>):
    %0 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<4x10x10x2xf32>, tensor<2x2x2x3xf32>, tensor<6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x9x9x6xf32>
    "func.return"(%0) : (tensor<4x9x9x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x1x1x3xf32>) -> tensor<10x1x1x3xf32>, sym_name = "max_pool2d_is_noop"}> ({
  ^bb0(%arg0: tensor<10x1x1x3xf32>):
    %0 = "tosa.max_pool2d"(%arg0) <{kernel = array<i64: 1, 1>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> {dilation = array<i64: 1, 1>} : (tensor<10x1x1x3xf32>) -> tensor<10x1x1x3xf32>
    "func.return"(%0) : (tensor<10x1x1x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "pad_noop"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<0> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<?x?xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "pad_noop_padding_mismatch_nofold"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 0, 0, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<?x?xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>) -> tensor<?xf32>, sym_name = "pad_noop_type_mismatch_nofold"}> ({
  ^bb0(%arg0: tensor<10xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<10xf32>, !tosa.shape<2>, tensor<1xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xi32>, tensor<2x2xi32>) -> tensor<?x?xi32>, sym_name = "pad_determine_val_i32"}> ({
  ^bb0(%arg0: tensor<?x?xi32>, %arg1: tensor<2x2xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const_shape"() <{values = dense<[1, 0, 0, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %2 = "tosa.pad"(%arg0, %1, %0) : (tensor<?x?xi32>, !tosa.shape<4>, tensor<1xi32>) -> tensor<?x?xi32>
    "func.return"(%2) : (tensor<?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<2x2xi32>) -> tensor<?x?xf32>, sym_name = "pad_determine_val_f32"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<2x2xi32>):
    %0 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const_shape"() <{values = dense<[1, 0, 0, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %2 = "tosa.pad"(%arg0, %1, %0) : (tensor<?x?xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xi32>, tensor<2x2xi32>) -> tensor<?x?xi32>, sym_name = "pad_determine_val_quant"}> ({
  ^bb0(%arg0: tensor<?x?xi32>, %arg1: tensor<2x2xi32>):
    %0 = "tosa.const"() <{values = dense<3> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const_shape"() <{values = dense<[1, 0, 0, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %2 = "tosa.pad"(%arg0, %1, %0) {input_zp = 42 : i32} : (tensor<?x?xi32>, !tosa.shape<4>, tensor<1xi32>) -> tensor<?x?xi32>
    "func.return"(%2) : (tensor<?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>) -> tensor<2x3xf32>, sym_name = "mul_one_float"}> ({
  ^bb0(%arg0: tensor<2x3xf32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %2 = "tosa.mul"(%arg0, %1, %0) : (tensor<2x3xf32>, tensor<2x3xf32>, tensor<1xi8>) -> tensor<2x3xf32>
    "func.return"(%2) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>) -> tensor<2x3xf32>, sym_name = "mul_bcast_one_float"}> ({
  ^bb0(%arg0: tensor<2x3xf32>):
    %0 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.mul"(%0, %arg0, %1) : (tensor<1x1xf32>, tensor<2x3xf32>, tensor<1xi8>) -> tensor<2x3xf32>
    "func.return"(%2) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>) -> tensor<2x3xi32>, sym_name = "mul_one_int"}> ({
  ^bb0(%arg0: tensor<2x3xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<2x3xi32>}> : () -> tensor<2x3xi32>
    %2 = "tosa.mul"(%arg0, %1, %0) : (tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>) -> tensor<2x3xi32>
    "func.return"(%2) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>) -> tensor<2x3xi32>, sym_name = "mul_one_int_and_shift"}> ({
  ^bb0(%arg0: tensor<2x3xi32>):
    %0 = "tosa.const"() <{values = dense<1> : tensor<2x3xi32>}> : () -> tensor<2x3xi32>
    %1 = "tosa.const"() <{values = dense<31> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.mul"(%arg0, %0, %1) : (tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>) -> tensor<2x3xi32>
    "func.return"(%2) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>) -> (tensor<2x3xf32>, tensor<2x3xf32>), sym_name = "mul_zero_broadcast"}> ({
  ^bb0(%arg0: tensor<2x3xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.mul"(%arg0, %0, %1) : (tensor<2x3xf32>, tensor<1x1xf32>, tensor<1xi8>) -> tensor<2x3xf32>
    %3 = "tosa.mul"(%0, %arg0, %1) : (tensor<1x1xf32>, tensor<2x3xf32>, tensor<1xi8>) -> tensor<2x3xf32>
    "func.return"(%2, %3) : (tensor<2x3xf32>, tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x17xf32>) -> tensor<?x17xf32>, sym_name = "mul_zero_dynamic_nofold"}> ({
  ^bb0(%arg0: tensor<?x17xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.mul"(%arg0, %0, %1) : (tensor<?x17xf32>, tensor<1x1xf32>, tensor<1xi8>) -> tensor<?x17xf32>
    "func.return"(%2) : (tensor<?x17xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x17xf32>) -> tensor<?x17xf32>, sym_name = "mul_one_dynamic_fold"}> ({
  ^bb0(%arg0: tensor<?x17xf32>):
    %0 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.mul"(%arg0, %0, %1) : (tensor<?x17xf32>, tensor<1x1xf32>, tensor<1xi8>) -> tensor<?x17xf32>
    "func.return"(%2) : (tensor<?x17xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi1>, tensor<2x3xi32>) -> tensor<2x3xi32>, sym_name = "select_same_value"}> ({
  ^bb0(%arg0: tensor<2x3xi1>, %arg1: tensor<2x3xi32>):
    %0 = "tosa.select"(%arg0, %arg1, %arg1) : (tensor<2x3xi1>, tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>
    "func.return"(%0) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>, sym_name = "select_true_value"}> ({
  ^bb0(%arg0: tensor<2x3xi32>, %arg1: tensor<2x3xi32>):
    %0 = "tosa.const"() <{values = dense<true> : tensor<2x3xi1>}> : () -> tensor<2x3xi1>
    %1 = "tosa.select"(%0, %arg0, %arg1) : (tensor<2x3xi1>, tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>
    "func.return"(%1) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>, sym_name = "select_false_value"}> ({
  ^bb0(%arg0: tensor<2x3xi32>, %arg1: tensor<2x3xi32>):
    %0 = "tosa.const"() <{values = dense<false> : tensor<2x3xi1>}> : () -> tensor<2x3xi1>
    %1 = "tosa.select"(%0, %arg0, %arg1) : (tensor<2x3xi1>, tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>
    "func.return"(%1) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi1>, tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>, sym_name = "select_not_pred"}> ({
  ^bb0(%arg0: tensor<2x3xi1>, %arg1: tensor<2x3xi32>, %arg2: tensor<2x3xi32>):
    %0 = "tosa.logical_not"(%arg0) : (tensor<2x3xi1>) -> tensor<2x3xi1>
    %1 = "tosa.select"(%0, %arg1, %arg2) : (tensor<2x3xi1>, tensor<2x3xi32>, tensor<2x3xi32>) -> tensor<2x3xi32>
    "func.return"(%1) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2xi1>, tensor<1x1xf32>) -> tensor<2x2xf32>, sym_name = "select_broadcast_same_value_no_fold"}> ({
  ^bb0(%arg0: tensor<2x2xi1>, %arg1: tensor<1x1xf32>):
    %0 = "tosa.select"(%arg0, %arg1, %arg1) : (tensor<2x2xi1>, tensor<1x1xf32>, tensor<1x1xf32>) -> tensor<2x2xf32>
    "func.return"(%0) : (tensor<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1xf32>, tensor<2x2xf32>) -> tensor<?x?xf32>, sym_name = "select_broadcast_true_value_no_fold"}> ({
  ^bb0(%arg0: tensor<1x1xf32>, %arg1: tensor<2x2xf32>):
    %0 = "tosa.const"() <{values = dense<true> : tensor<2x2xi1>}> : () -> tensor<2x2xi1>
    %1 = "tosa.select"(%0, %arg0, %arg1) : (tensor<2x2xi1>, tensor<1x1xf32>, tensor<2x2xf32>) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2xf32>, tensor<1x1xf32>) -> tensor<2x2xf32>, sym_name = "select_broadcast_false_value_no_fold"}> ({
  ^bb0(%arg0: tensor<2x2xf32>, %arg1: tensor<1x1xf32>):
    %0 = "tosa.const"() <{values = dense<false> : tensor<2x2xi1>}> : () -> tensor<2x2xi1>
    %1 = "tosa.select"(%0, %arg0, %arg1) : (tensor<2x2xi1>, tensor<2x2xf32>, tensor<1x1xf32>) -> tensor<2x2xf32>
    "func.return"(%1) : (tensor<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>, sym_name = "select_broadcast_false_value_dynamic_operand_no_fold"}> ({
  ^bb0(%arg0: tensor<2x?xf32>, %arg1: tensor<2x2xf32>):
    %0 = "tosa.const"() <{values = dense<false> : tensor<2x2xi1>}> : () -> tensor<2x2xi1>
    %1 = "tosa.select"(%0, %arg0, %arg1) : (tensor<2x2xi1>, tensor<2x?xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>
    "func.return"(%1) : (tensor<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_all_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_all"(%arg0) <{axis = 1 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_all_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_all"(%arg0) <{axis = 0 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_any_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_any"(%arg0) <{axis = 1 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_any_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_any"(%arg0) <{axis = 0 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_max_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_max"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_max_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_max"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_min_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_min"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_min_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_min"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_product_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_product"(%arg0) <{axis = 1 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_product_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_product"(%arg0) <{axis = 0 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_sum_fold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 1 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "reduce_sum_nofold"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 0 : i32}> : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%0) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>) -> tensor<?x10xf32>, sym_name = "reshape_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x10xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 10]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x10xf32>, !tosa.shape<2>) -> tensor<?x10xf32>
    "func.return"(%1) : (tensor<?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x10xf32>) -> tensor<?x?x10xf32>, sym_name = "reshape_canonicalize_dyn_nofold"}> ({
  ^bb0(%arg0: tensor<?x?x10xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 2, 10]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x?x10xf32>, !tosa.shape<3>) -> tensor<?x?x10xf32>
    "func.return"(%1) : (tensor<?x?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>) -> tensor<?x5xf32>, sym_name = "reshape_canonicalize_double"}> ({
  ^bb0(%arg0: tensor<?x10xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[5, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x10xf32>, !tosa.shape<2>) -> tensor<5x?xf32>
    %2 = "tosa.const_shape"() <{values = dense<[-1, 5]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.reshape"(%1, %2) : (tensor<5x?xf32>, !tosa.shape<2>) -> tensor<?x5xf32>
    "func.return"(%3) : (tensor<?x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x5xi32>, sym_name = "reshape_canonicalize_const"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4]> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = "tosa.const_shape"() <{values = dense<[1, 5]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.reshape"(%0, %1) : (tensor<5xi32>, !tosa.shape<2>) -> tensor<1x5xi32>
    "func.return"(%2) : (tensor<1x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x?xi32>, sym_name = "reshape_canonicalize_const_dynamic"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4]> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = "tosa.const_shape"() <{values = dense<[1, 5]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.reshape"(%0, %1) : (tensor<5xi32>, !tosa.shape<2>) -> tensor<1x?xi32>
    "func.return"(%2) : (tensor<1x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (tensor<10xi32>, tensor<1x10xi32>), sym_name = "reshape_canonicalize_const_splat"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const_shape"() <{values = dense<[1, 10]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.reshape"(%0, %1) : (tensor<10xi32>, !tosa.shape<2>) -> tensor<1x10xi32>
    "func.return"(%0, %2) : (tensor<10xi32>, tensor<1x10xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (tensor<3xi32>, tensor<1x3xi32>), sym_name = "reshape_canonicalize_const_sparse"}> ({
    %0 = "tosa.const"() <{values = dense<[1, 2, 3]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = "tosa.const_shape"() <{values = dense<[1, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.reshape"(%0, %1) : (tensor<3xi32>, !tosa.shape<2>) -> tensor<1x3xi32>
    "func.return"(%0, %2) : (tensor<3xi32>, tensor<1x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x3x!quant.uniform<i8:f32, 1.000000e+00>>, sym_name = "reshape_canonicalize_quant_nofold"}> ({
    %0 = "tosa.const"() <{values = dense<[1, 2, 3]> : tensor<3xi8>}> : () -> tensor<3x!quant.uniform<i8:f32, 1.000000e+00>>
    %1 = "tosa.const_shape"() <{values = dense<[1, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.reshape"(%0, %1) : (tensor<3x!quant.uniform<i8:f32, 1.000000e+00>>, !tosa.shape<2>) -> tensor<1x3x!quant.uniform<i8:f32, 1.000000e+00>>
    "func.return"(%2) : (tensor<1x3x!quant.uniform<i8:f32, 1.000000e+00>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2x1x3x!quant.uniform<i8:f32, 1.000000e+00>>, sym_name = "transpose_canonicalize_strip_quant"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<1x2x3xi8>}> : () -> tensor<1x2x3x!quant.uniform<i8:f32, 1.000000e+00>>
    %1 = "tosa.transpose"(%0) <{perms = array<i32: 1, 0, 2>}> : (tensor<1x2x3x!quant.uniform<i8:f32, 1.000000e+00>>) -> tensor<2x1x3x!quant.uniform<i8:f32, 1.000000e+00>>
    "func.return"(%1) : (tensor<2x1x3x!quant.uniform<i8:f32, 1.000000e+00>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x4xf32>) -> tensor<3x4xf32>, sym_name = "slice_fold"}> ({
  ^bb0(%arg0: tensor<3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.const_shape"() <{values = dense<[3, 4]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.slice"(%arg0, %0, %1) : (tensor<3x4xf32>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x4xf32>
    "func.return"(%2) : (tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x4xf32>) -> tensor<?x4xf32>, sym_name = "slice_nofold"}> ({
  ^bb0(%arg0: tensor<?x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.const_shape"() <{values = dense<[3, 4]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.slice"(%arg0, %0, %1) : (tensor<?x4xf32>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<?x4xf32>
    "func.return"(%2) : (tensor<?x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x4xf32>) -> tensor<3x4xf32>, sym_name = "tile_fold"}> ({
  ^bb0(%arg0: tensor<3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<1> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.tile"(%arg0, %0) : (tensor<3x4xf32>, !tosa.shape<2>) -> tensor<3x4xf32>
    "func.return"(%1) : (tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x4xf32>) -> tensor<3x8xf32>, sym_name = "tile_nofold"}> ({
  ^bb0(%arg0: tensor<3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.tile"(%arg0, %0) : (tensor<3x4xf32>, !tosa.shape<2>) -> tensor<3x8xf32>
    "func.return"(%1) : (tensor<3x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x4x5x6xf32>) -> tensor<3x4x5x6xf32>, sym_name = "transpose_no_op"}> ({
  ^bb0(%arg0: tensor<3x4x5x6xf32>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 0, 1, 2, 3>}> : (tensor<3x4x5x6xf32>) -> tensor<3x4x5x6xf32>
    "func.return"(%0) : (tensor<3x4x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4x5x1xf32>) -> tensor<1x4x1x5xf32>, sym_name = "transpose_is_reshape"}> ({
  ^bb0(%arg0: tensor<1x4x5x1xf32>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 3, 1, 0, 2>}> : (tensor<1x4x5x1xf32>) -> tensor<1x4x1x5xf32>
    "func.return"(%0) : (tensor<1x4x1x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x4x?x1xf32>) -> tensor<1x4x1x?xf32>, sym_name = "transpose_is_reshape_unknown_dim"}> ({
  ^bb0(%arg0: tensor<1x4x?x1xf32>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 3, 1, 0, 2>}> : (tensor<1x4x?x1xf32>) -> tensor<1x4x1x?xf32>
    "func.return"(%0) : (tensor<1x4x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1xi1>, sym_name = "single_bit_reshape"}> ({
    %0 = "arith.constant"() <{value = dense<true> : tensor<1x1xi1>}> : () -> tensor<1x1xi1>
    %1 = "tosa.const_shape"() <{values = dense<1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %2 = "tosa.reshape"(%0, %1) : (tensor<1x1xi1>, !tosa.shape<1>) -> tensor<1xi1>
    "func.return"(%2) : (tensor<1xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x15x13x1xi8>) -> tensor<1x15x13x1xi8>, sym_name = "fold_resize_nearest"}> ({
  ^bb0(%arg0: tensor<1x15x13x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<1x15x13x1xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x15x13x1xi8>
    "func.return"(%3) : (tensor<1x15x13x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x15x13x1xi8>) -> tensor<1x15x13x1xi8>, sym_name = "fold_resize_bilinear"}> ({
  ^bb0(%arg0: tensor<1x15x13x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<1x15x13x1xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x15x13x1xi8>
    "func.return"(%3) : (tensor<1x15x13x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12x1xf32>, tensor<1x12x12x1xf32>) -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xf32>), sym_name = "canonicalize_concat_slice_final_axis"}> ({
  ^bb0(%arg0: tensor<1x12x12x1xf32>, %arg1: tensor<1x12x12x1xf32>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 3 : i32}> : (tensor<1x12x12x1xf32>, tensor<1x12x12x1xf32>) -> tensor<1x12x12x2xf32>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %2 = "tosa.const_shape"() <{values = dense<[0, 0, 0, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %3 = "tosa.const_shape"() <{values = dense<[1, 12, 12, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %4 = "tosa.slice"(%0, %1, %3) : (tensor<1x12x12x2xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x12x12x1xf32>
    %5 = "tosa.slice"(%0, %2, %3) : (tensor<1x12x12x2xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x12x12x1xf32>
    "func.return"(%4, %5) : (tensor<1x12x12x1xf32>, tensor<1x12x12x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> (tensor<1x12x12xf32>, tensor<1x12x12xf32>), sym_name = "canonicalize_concat_slice_middle_axis"}> ({
  ^bb0(%arg0: tensor<1x12x12xf32>, %arg1: tensor<1x12x12xf32>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 1 : i32}> : (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> tensor<1x24x12xf32>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %2 = "tosa.const_shape"() <{values = dense<[0, 12, 0]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %3 = "tosa.const_shape"() <{values = dense<[1, 12, 12]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %4 = "tosa.slice"(%0, %1, %3) : (tensor<1x24x12xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x12x12xf32>
    %5 = "tosa.slice"(%0, %2, %3) : (tensor<1x24x12xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x12x12xf32>
    "func.return"(%4, %5) : (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> (tensor<1x12x15xf32>, tensor<1x12x20xf32>), sym_name = "canonicalize_cross_concat_inputs"}> ({
  ^bb0(%arg0: tensor<1x12x12xf32>, %arg1: tensor<1x12x12xf32>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 2 : i32}> : (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> tensor<1x12x24xf32>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %2 = "tosa.const_shape"() <{values = dense<[0, 0, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %3 = "tosa.const_shape"() <{values = dense<[1, 12, 15]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %4 = "tosa.const_shape"() <{values = dense<[1, 12, 20]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %5 = "tosa.slice"(%0, %1, %3) : (tensor<1x12x24xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x12x15xf32>
    %6 = "tosa.slice"(%0, %2, %4) : (tensor<1x12x24xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x12x20xf32>
    "func.return"(%5, %6) : (tensor<1x12x15xf32>, tensor<1x12x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> (tensor<1x6x12xf32>, tensor<1x3x12xf32>), sym_name = "canonicalize_concat_slice_on_non_concat_axis"}> ({
  ^bb0(%arg0: tensor<1x12x12xf32>, %arg1: tensor<1x12x12xf32>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 2 : i32}> : (tensor<1x12x12xf32>, tensor<1x12x12xf32>) -> tensor<1x12x24xf32>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %2 = "tosa.const_shape"() <{values = dense<[1, 6, 12]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %3 = "tosa.const_shape"() <{values = dense<[1, 3, 12]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %4 = "tosa.slice"(%0, %1, %2) : (tensor<1x12x24xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x6x12xf32>
    %5 = "tosa.slice"(%0, %3, %3) : (tensor<1x12x24xf32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<1x3x12xf32>
    "func.return"(%4, %5) : (tensor<1x6x12xf32>, tensor<1x3x12xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x16x16x3xf32>) -> tensor<?x14x18x3xf32>, sym_name = "canonicalize_pad_slice_overlap"}> ({
  ^bb0(%arg0: tensor<?x16x16x3xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const_shape"() <{values = dense<[0, 0, 0, 0, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %2 = "tosa.pad"(%arg0, %1, %0) : (tensor<?x16x16x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<?x16x20x3xf32>
    %3 = "tosa.const_shape"() <{values = dense<[0, 0, 1, 0]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %4 = "tosa.const_shape"() <{values = dense<[-1, 14, 18, 3]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %5 = "tosa.slice"(%2, %3, %4) : (tensor<?x16x20x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<?x14x18x3xf32>
    "func.return"(%5) : (tensor<?x14x18x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x16x16x3xf32>) -> tensor<1x14x14x3xf32>, sym_name = "canonicalize_pad_slice_inside"}> ({
  ^bb0(%arg0: tensor<1x16x16x3xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const_shape"() <{values = dense<[0, 0, 0, 0, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %2 = "tosa.pad"(%arg0, %1, %0) : (tensor<1x16x16x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x16x20x3xf32>
    %3 = "tosa.const_shape"() <{values = dense<[0, 1, 4, 0]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %4 = "tosa.const_shape"() <{values = dense<[1, 14, 10, 3]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %5 = "tosa.slice"(%2, %3, %4) : (tensor<1x16x20x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x14x14x3xf32>
    "func.return"(%5) : (tensor<1x14x14x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x16x16x3xf32>) -> tensor<1x16x20x2xf32>, sym_name = "canonicalize_pad_slice_exact"}> ({
  ^bb0(%arg0: tensor<1x16x16x3xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const_shape"() <{values = dense<[0, 0, 0, 0, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %2 = "tosa.pad"(%arg0, %1, %0) : (tensor<1x16x16x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x16x20x3xf32>
    %3 = "tosa.const_shape"() <{values = dense<0> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %4 = "tosa.const_shape"() <{values = dense<[1, 16, 20, 2]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %5 = "tosa.slice"(%2, %3, %4) : (tensor<1x16x20x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x16x20x2xf32>
    "func.return"(%5) : (tensor<1x16x20x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x16x?x3xf32>) -> tensor<1x16x?x2xf32>, sym_name = "canonicalize_pad_slice_dynamic_noupdate"}> ({
  ^bb0(%arg0: tensor<1x16x?x3xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const_shape"() <{values = dense<[0, 0, 0, 0, 2, 2, 0, 0]> : tensor<8xindex>}> : () -> !tosa.shape<8>
    %2 = "tosa.pad"(%arg0, %1, %0) : (tensor<1x16x?x3xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<1x16x?x3xf32>
    %3 = "tosa.const_shape"() <{values = dense<0> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %4 = "tosa.const_shape"() <{values = dense<[1, 16, 15, 2]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %5 = "tosa.slice"(%2, %3, %4) : (tensor<1x16x?x3xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<1x16x?x2xf32>
    "func.return"(%5) : (tensor<1x16x?x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "fold_negate_negate"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.negate"(%arg0, %0, %1) : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %3 = "tosa.negate"(%2, %0, %1) : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    "func.return"(%3) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>, tensor<1xf32>) -> tensor<?x1xf32>, sym_name = "no_fold_negate_negate_non_const_zp"}> ({
  ^bb0(%arg0: tensor<?x1xf32>, %arg1: tensor<1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.negate"(%arg0, %arg1, %0) : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %2 = "tosa.negate"(%1, %0, %0) : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %3 = "tosa.negate"(%2, %0, %arg1) : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %4 = "tosa.negate"(%3, %0, %0) : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    %5 = "tosa.negate"(%4, %arg1, %0) : (tensor<?x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1xf32>
    "func.return"(%5) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xi8>) -> tensor<?x1xi8>, sym_name = "no_fold_negate_negate_non_zero_zp"}> ({
  ^bb0(%arg0: tensor<?x1xi8>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.negate"(%arg0, %0, %1) : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %3 = "tosa.negate"(%2, %0, %0) : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %4 = "tosa.negate"(%3, %1, %0) : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %5 = "tosa.negate"(%4, %0, %0) : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    %6 = "tosa.negate"(%5, %0, %1) : (tensor<?x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x1xi8>
    "func.return"(%6) : (tensor<?x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>) -> tensor<?x1xf32>, sym_name = "fold_abs_abs"}> ({
  ^bb0(%arg0: tensor<?x1xf32>):
    %0 = "tosa.abs"(%arg0) : (tensor<?x1xf32>) -> tensor<?x1xf32>
    %1 = "tosa.abs"(%0) : (tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%1) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x1x1x1xi32>, sym_name = "reshape_quant_nofold"}> ({
    %0 = "tosa.const"() <{values = dense<127> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.const_shape"() <{values = dense<1> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %2 = "tosa.reshape"(%0, %1) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, !tosa.shape<4>) -> tensor<1x1x1x1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %3 = "tosa.const"() <{values = dense<1073741824> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<30> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = "tosa.rescale"(%2, %3, %4, %5, %6) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<1x1x1x1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi32>) -> tensor<1x1x1x1xi32>
    "func.return"(%7) : (tensor<1x1x1x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, sym_name = "add_quant_nofold"}> ({
    %0 = "tosa.const"() <{values = dense<127> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.add"(%0, %0) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    "func.return"(%1) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, sym_name = "sub_quant_nofold"}> ({
    %0 = "tosa.const"() <{values = dense<127> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.sub"(%0, %0) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    "func.return"(%1) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i1>, sym_name = "greater_quant_fold"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.greater"(%0, %0) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<i1>
    "func.return"(%1) : (tensor<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i1>, sym_name = "greater_equal_quant_fold"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.greater_equal"(%0, %0) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<i1>
    "func.return"(%1) : (tensor<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i1>, sym_name = "equal_quant_fold"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.equal"(%0, %0) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<i1>
    "func.return"(%1) : (tensor<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:3>>, sym_name = "cast_quant_nofold"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.cast"(%0) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:3>>
    "func.return"(%1) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:3>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, sym_name = "reverse_quant_fold"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.reverse"(%0) <{axis = 0 : i32}> : (tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    "func.return"(%1) : (tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, sym_name = "select_quant_fold"}> ({
    %0 = "tosa.const"() <{values = dense<true> : tensor<i1>}> : () -> tensor<i1>
    %1 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %2 = "tosa.const"() <{values = dense<127> : tensor<i8>}> : () -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %3 = "tosa.select"(%0, %1, %2) : (tensor<i1>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    "func.return"(%3) : (tensor<!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, sym_name = "mul_quant_nofold"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %1 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.mul"(%0, %1, %2) : (tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>, tensor<1xi8>) -> tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>
    "func.return"(%3) : (tensor<1x!quant.uniform<i8:f32, 3.0757404601899907E-5:-128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3x600x1200xf32>, sym_name = "fold_reciprocal", sym_visibility = "nested"}> ({
    %0 = "tosa.const"() <{values = dense<1.160000e+02> : tensor<3x600x1200xf32>}> : () -> tensor<3x600x1200xf32>
    %1 = "tosa.reciprocal"(%0) : (tensor<3x600x1200xf32>) -> tensor<3x600x1200xf32>
    "func.return"(%1) : (tensor<3x600x1200xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3x600x1200xi32>, sym_name = "do_not_fold_reciprocal_int", sym_visibility = "nested"}> ({
    %0 = "tosa.const"() <{values = dense<11> : tensor<3x600x1200xi32>}> : () -> tensor<3x600x1200xi32>
    %1 = "tosa.reciprocal"(%0) : (tensor<3x600x1200xi32>) -> tensor<3x600x1200xi32>
    "func.return"(%1) : (tensor<3x600x1200xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x24x2xi32>, sym_name = "do_not_fold_intdiv_division_by_0"}> ({
    %0 = "tosa.const"() <{values = dense<0> : tensor<1x24x2xi32>}> : () -> tensor<1x24x2xi32>
    %1 = "tosa.const"() <{values = dense<20> : tensor<1x24x2xi32>}> : () -> tensor<1x24x2xi32>
    %2 = "tosa.intdiv"(%1, %0) : (tensor<1x24x2xi32>, tensor<1x24x2xi32>) -> tensor<1x24x2xi32>
    "func.return"(%2) : (tensor<1x24x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x60x59x?xf32>) -> tensor<2x60x58x?xf32>, sym_name = "slice_dynamic_size_static_output_canonicalize"}> ({
  ^bb0(%arg0: tensor<2x60x59x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<0> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<[-1, 60, 58, -1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %2 = "tosa.slice"(%arg0, %0, %1) : (tensor<2x60x59x?xf32>, !tosa.shape<4>, !tosa.shape<4>) -> tensor<2x60x58x?xf32>
    "func.return"(%2) : (tensor<2x60x58x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i32>, sym_name = "fold_mul_shift"}> ({
    %0 = "tosa.const"() <{values = dense<-23661> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-33022> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<30> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.mul"(%0, %1, %2) : (tensor<i32>, tensor<i32>, tensor<1xi8>) -> tensor<i32>
    "func.return"(%3) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i32>, sym_name = "fold_mul_no_shift"}> ({
    %0 = "tosa.const"() <{values = dense<-23661> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-33022> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.mul"(%0, %1, %2) : (tensor<i32>, tensor<i32>, tensor<1xi8>) -> tensor<i32>
    "func.return"(%3) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i32>, sym_name = "no_fold_mul_result_exceeds_i32"}> ({
    %0 = "tosa.const"() <{values = dense<23661> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<330222> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.mul"(%0, %1, %2) : (tensor<i32>, tensor<i32>, tensor<1xi8>) -> tensor<i32>
    "func.return"(%3) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i32>, sym_name = "test_fold_i1_to_i32_cast"}> ({
    %0 = "tosa.const"() <{values = dense<true> : tensor<i1>}> : () -> tensor<i1>
    %1 = "tosa.cast"(%0) : (tensor<i1>) -> tensor<i32>
    "func.return"(%1) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i1>, sym_name = "test_fold_i32_to_i1_cast"}> ({
    %0 = "tosa.const"() <{values = dense<10> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.cast"(%0) : (tensor<i32>) -> tensor<i1>
    "func.return"(%1) : (tensor<i1>) -> ()
  }) : () -> ()
}) : () -> ()

