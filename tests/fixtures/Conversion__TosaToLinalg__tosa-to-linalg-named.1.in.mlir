"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xf32>, tensor<1x3x6xf32>) -> tensor<1x5x6xf32>, sym_name = "matmul"}> ({
  ^bb0(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x6xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.matmul"(%arg0, %arg1, %0, %1) : (tensor<1x5x3xf32>, tensor<1x3x6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x5x6xf32>
    "func.return"(%2) : (tensor<1x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xi8>, tensor<1x3x6xi8>) -> tensor<1x5x6xi32>, sym_name = "matmul_quantized"}> ({
  ^bb0(%arg0: tensor<1x5x3xi8>, %arg1: tensor<1x3x6xi8>):
    %0 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<2> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.matmul"(%arg0, %arg1, %0, %1) : (tensor<1x5x3xi8>, tensor<1x3x6xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x5x6xi32>
    "func.return"(%2) : (tensor<1x5x6xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x5x3xf32>, tensor<?x3x6xf32>) -> tensor<?x5x6xf32>, sym_name = "matmul_dyn_batch"}> ({
  ^bb0(%arg0: tensor<?x5x3xf32>, %arg1: tensor<?x3x6xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.matmul"(%arg0, %arg1, %0, %1) : (tensor<?x5x3xf32>, tensor<?x3x6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x5x6xf32>
    "func.return"(%2) : (tensor<?x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xf32>, tensor<1x3x?xf32>) -> tensor<1x5x?xf32>, sym_name = "matmul_dyn_independent_dim"}> ({
  ^bb0(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x?xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.matmul"(%arg0, %arg1, %0, %1) : (tensor<1x5x3xf32>, tensor<1x3x?xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x5x?xf32>
    "func.return"(%2) : (tensor<1x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x?xf32>, tensor<1x?x6xf32>) -> tensor<1x5x6xf32>, sym_name = "matmul_dyn_independent_dim"}> ({
  ^bb0(%arg0: tensor<1x5x?xf32>, %arg1: tensor<1x?x6xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.matmul"(%arg0, %arg1, %0, %1) : (tensor<1x5x?xf32>, tensor<1x?x6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x5x6xf32>
    "func.return"(%2) : (tensor<1x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x8xf32>, tensor<1x8x1xf32>) -> tensor<?x1x1xf32>, sym_name = "matmul_dyn_output"}> ({
  ^bb0(%arg0: tensor<1x1x8xf32>, %arg1: tensor<1x8x1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.matmul"(%arg0, %arg1, %0, %1) : (tensor<1x1x8xf32>, tensor<1x8x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x1x1xf32>
    "func.return"(%2) : (tensor<?x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> (), sym_name = "max_pool"}> ({
  ^bb0(%arg7: tensor<1x6x34x62xf32>):
    %7 = "tosa.max_pool2d"(%arg7) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> (), sym_name = "max_pool_padded"}> ({
  ^bb0(%arg6: tensor<1x6x34x62xf32>):
    %6 = "tosa.max_pool2d"(%arg6) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 1>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xf32>) -> tensor<1x4x33x62xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x6x34x62xf32>) -> (), sym_name = "max_pool_dyn"}> ({
  ^bb0(%arg5: tensor<?x6x34x62xf32>):
    %5 = "tosa.max_pool2d"(%arg5) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<?x6x34x62xf32>) -> tensor<?x4x32x62xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi8>) -> (), sym_name = "max_pool_i8"}> ({
  ^bb0(%arg4: tensor<1x6x34x62xi8>):
    %4 = "tosa.max_pool2d"(%arg4) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xi8>) -> tensor<1x4x32x62xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xui8>) -> tensor<1x4x32x62xui8>, sym_name = "max_pool_ui8"}> ({
  ^bb0(%arg3: tensor<1x6x34x62xui8>):
    %3 = "tosa.max_pool2d"(%arg3) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xui8>) -> tensor<1x4x32x62xui8>
    "func.return"(%3) : (tensor<1x4x32x62xui8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi16>) -> (), sym_name = "max_pool_i16"}> ({
  ^bb0(%arg2: tensor<1x6x34x62xi16>):
    %2 = "tosa.max_pool2d"(%arg2) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xi16>) -> tensor<1x4x32x62xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi32>) -> (), sym_name = "max_pool_i32"}> ({
  ^bb0(%arg1: tensor<1x6x34x62xi32>):
    %1 = "tosa.max_pool2d"(%arg1) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xi32>) -> tensor<1x4x32x62xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>, sym_name = "max_pool_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>):
    %0 = "tosa.max_pool2d"(%arg0) <{kernel = array<i64: 2, 5>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 2, 2>, stride = array<i64: 1, 1>}> : (tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    "func.return"(%0) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> tensor<1x5x33x62xf32>, sym_name = "avg_pool_f32"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.avg_pool2d"(%arg0, %0, %1) <{acc_type = f32, kernel = array<i64: 4, 4>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x5x33x62xf32>
    "func.return"(%2) : (tensor<1x5x33x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf16>) -> tensor<1x5x33x62xf16>, sym_name = "avg_pool_f16_f32acc"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "tosa.avg_pool2d"(%arg0, %0, %1) <{acc_type = f32, kernel = array<i64: 4, 4>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xf16>, tensor<1xf16>, tensor<1xf16>) -> tensor<1x5x33x62xf16>
    "func.return"(%2) : (tensor<1x5x33x62xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xi8>) -> tensor<1x5x33x62xi8>, sym_name = "avg_pool_i8"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xi8>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.avg_pool2d"(%arg0, %0, %1) <{acc_type = i32, kernel = array<i64: 4, 4>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x5x33x62xi8>
    "func.return"(%2) : (tensor<1x5x33x62xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x6x34x62xf32>) -> tensor<?x5x33x62xf32>, sym_name = "avg_pool_dyn"}> ({
  ^bb0(%arg0: tensor<?x6x34x62xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.avg_pool2d"(%arg0, %0, %1) <{acc_type = f32, kernel = array<i64: 4, 4>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<?x6x34x62xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x5x33x62xf32>
    "func.return"(%2) : (tensor<?x5x33x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<1xf32>) -> (), sym_name = "conv2d_scalar_bias_f32"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 2, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xi8>, tensor<28x1x1x27xi8>, tensor<28xi8>) -> (), sym_name = "conv2d_i8"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xi8>, %arg1: tensor<28x1x1x27xi8>, %arg2: tensor<28xi8>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = i32, dilation = array<i64: 2, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x49x42x27xi8>, tensor<28x1x1x27xi8>, tensor<28xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x49x42x28xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_f32"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 2, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_dyn"}> ({
  ^bb0(%arg0: tensor<?x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 2, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<?x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x?x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_dyn_w_h"}> ({
  ^bb0(%arg0: tensor<1x?x?x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 2, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x?x?x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x?x?x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x6x5x4xf32>, tensor<4x3x3x4xf32>, tensor<4xf32>) -> (), sym_name = "conv2d_dyn_output"}> ({
  ^bb0(%arg0: tensor<2x6x5x4xf32>, %arg1: tensor<4x3x3x4xf32>, %arg2: tensor<4xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<2x6x5x4xf32>, tensor<4x3x3x4xf32>, tensor<4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x4x3x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x47x40x28xf32>, tensor<28x3x3x28xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_padded_f32"}> ({
  ^bb0(%arg0: tensor<1x47x40x28xf32>, %arg1: tensor<28x3x3x28xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 2, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x47x40x28xf32>, tensor<28x3x3x28xf32>, tensor<28xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12x1xi8>, tensor<1024x3x3x1xi8>, tensor<1024xi32>) -> (), sym_name = "conv2d_quant"}> ({
  ^bb0(%arg0: tensor<1x12x12x1xi8>, %arg1: tensor<1024x3x3x1xi8>, %arg2: tensor<1024xi32>):
    %0 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = i32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x12x12x1xi8>, tensor<1024x3x3x1xi8>, tensor<1024xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x12x12x1024xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf16>, tensor<28x3x3x27xf16>, tensor<28xf16>) -> (), sym_name = "conv2d_f16_f32_acc"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf16>, %arg1: tensor<28x3x3x27xf16>, %arg2: tensor<28xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "tosa.conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 2, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x49x42x27xf16>, tensor<28x3x3x27xf16>, tensor<28xf16>, tensor<1xf16>, tensor<1xf16>) -> tensor<1x45x40x28xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1xf32>) -> (), sym_name = "depthwise_conv_scalar_bias"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv_dyn"}> ({
  ^bb0(%arg0: tensor<?x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<?x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<?x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x11x9x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv_strides"}> ({
  ^bb0(%arg0: tensor<1x11x9x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 2, 2>}> : (tensor<1x11x9x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>) -> (), sym_name = "depthwise_conv_quant"}> ({
  ^bb0(%arg0: tensor<1x12x12x4xi8>, %arg1: tensor<3x3x4x128xi8>, %arg2: tensor<512xi32>):
    %0 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = i32, dilation = array<i64: 1, 1>, pad = array<i64: 1, 1, 1, 1>, stride = array<i64: 1, 1>}> : (tensor<1x12x12x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x12x12x512xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>) -> (), sym_name = "depthwise_conv_quant_dilations"}> ({
  ^bb0(%arg3: tensor<1x14x14x4xi8>, %arg4: tensor<3x3x4x128xi8>, %arg5: tensor<512xi32>):
    %3 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.depthwise_conv2d"(%arg3, %arg4, %arg5, %3, %4) <{acc_type = i32, dilation = array<i64: 2, 2>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x10x10x512xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<2x?x?x3xf32>, tensor<3x6x3x5xf32>, tensor<15xf32>) -> (), sym_name = "depthwise_conv2d_dyn_w_h"}> ({
  ^bb0(%arg0: tensor<2x?x?x3xf32>, %arg1: tensor<3x6x3x5xf32>, %arg2: tensor<15xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 2, 1>, pad = array<i64: 1, 2, 3, 4>, stride = array<i64: 1, 2>}> : (tensor<2x?x?x3xf32>, tensor<3x6x3x5xf32>, tensor<15xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x?x?x15xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xi8>, tensor<3x1x3x11xi8>, tensor<33xi32>) -> (), sym_name = "depthwise_int_conv_zero_zp"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xi8>, %arg1: tensor<3x1x3x11xi8>, %arg2: tensor<33xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = i32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x7x5x3xi8>, tensor<3x1x3x11xi8>, tensor<33xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x5x5x33xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf16>, tensor<3x1x3x11xf16>, tensor<33xf16>) -> (), sym_name = "depthwise_conv2d_f16_f32_acc"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf16>, %arg1: tensor<3x1x3x11xf16>, %arg2: tensor<33xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "tosa.depthwise_conv2d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x7x5x3xf16>, tensor<3x1x3x11xf16>, tensor<33xf16>, tensor<1xf16>, tensor<1xf16>) -> tensor<1x5x5x33xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf32>, tensor<43x3x4x5x27xf32>, tensor<43xf32>) -> (), sym_name = "conv3d_f32"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<43x3x4x5x27xf32>, %arg2: tensor<43xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv3d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1, 1>, pad = array<i64: 0, 0, 0, 0, 0, 0>, stride = array<i64: 1, 1, 1>}> : (tensor<1x49x48x47x27xf32>, tensor<43x3x4x5x27xf32>, tensor<43xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x47x45x43x43xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf32>, tensor<28x3x4x5x27xf32>, tensor<1xf32>) -> (), sym_name = "conv3d_scalar_bias_f32"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<28x3x4x5x27xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.conv3d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1, 1>, pad = array<i64: 0, 0, 0, 0, 0, 0>, stride = array<i64: 1, 1, 1>}> : (tensor<1x49x48x47x27xf32>, tensor<28x3x4x5x27xf32>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x47x45x43x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xi8>, tensor<43x3x4x5x27xi8>, tensor<43xi32>) -> (), sym_name = "conv3d_i8"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xi8>, %arg1: tensor<43x3x4x5x27xi8>, %arg2: tensor<43xi32>):
    %0 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.conv3d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = i32, dilation = array<i64: 1, 1, 1>, pad = array<i64: 0, 0, 0, 0, 0, 0>, stride = array<i64: 1, 1, 1>}> : (tensor<1x49x48x47x27xi8>, tensor<43x3x4x5x27xi8>, tensor<43xi32>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x47x45x43x43xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf16>, tensor<43x3x4x5x27xf16>, tensor<43xf16>) -> (), sym_name = "conv3d_f16_f32_acc"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf16>, %arg1: tensor<43x3x4x5x27xf16>, %arg2: tensor<43xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "tosa.conv3d"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = f32, dilation = array<i64: 1, 1, 1>, pad = array<i64: 0, 0, 0, 0, 0, 0>, stride = array<i64: 1, 1, 1>}> : (tensor<1x49x48x47x27xf16>, tensor<43x3x4x5x27xf16>, tensor<43xf16>, tensor<1xf16>, tensor<1xf16>) -> tensor<1x47x45x43x43xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xi32>) -> (), sym_name = "test_transpose"}> ({
  ^bb0(%arg0: tensor<1x2x3xi32>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 1, 2, 0>}> : (tensor<1x2x3xi32>) -> tensor<2x3x1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x3x4xi32>) -> (), sym_name = "test_transpose_dyn"}> ({
  ^bb0(%arg0: tensor<1x?x3x4xi32>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 1, 3, 0, 2>}> : (tensor<1x?x3x4xi32>) -> tensor<?x4x1x3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> (), sym_name = "test_transpose_dyn_multiple_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 1, 0>}> : (tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> (), sym_name = "test_transpose_dyn_multiple_3d"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.transpose"(%arg0) <{perms = array<i32: 2, 0, 1>}> : (tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32>, sym_name = "max_pool2d_nan_propagate"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf32>):
    %0 = "tosa.max_pool2d"(%arg0) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<PROPAGATE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32>
    "func.return"(%0) : (tensor<1x4x32x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xi8>) -> tensor<1x4x32x62xi8>, sym_name = "max_pool2d_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xi8>):
    %0 = "tosa.max_pool2d"(%arg0) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<IGNORE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xi8>) -> tensor<1x4x32x62xi8>
    "func.return"(%0) : (tensor<1x4x32x62xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32>, sym_name = "max_pool2d_nan_ignore"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf32>):
    %0 = "tosa.max_pool2d"(%arg0) <{kernel = array<i64: 3, 3>, nan_mode = #tosa.nan_mode<IGNORE>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}> : (tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32>
    "func.return"(%0) : (tensor<1x4x32x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

