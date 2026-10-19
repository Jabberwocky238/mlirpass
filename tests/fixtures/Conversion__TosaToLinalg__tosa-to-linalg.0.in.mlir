"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "test_abs_scalar"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.abs"(%arg0) : (tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<?xf32>, sym_name = "test_abs_1d_cast_static_to_dynamic"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "tosa.abs"(%arg0) : (tensor<5xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<5xf32>, sym_name = "test_abs_1d_cast_dynamic_to_static"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.abs"(%arg0) : (tensor<?xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "test_abs_1d_dynamic"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.abs"(%arg0) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>) -> tensor<f32>, sym_name = "test_add_0d"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<f32>, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x1xf32>, tensor<1x1xf32>) -> tensor<2x1xf32>, sym_name = "test_add_2d_broadcast"}> ({
  ^bb0(%arg0: tensor<2x1xf32>, %arg1: tensor<1x1xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<2x1xf32>, tensor<1x1xf32>) -> tensor<2x1xf32>
    "func.return"(%0) : (tensor<2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "test_add_1d_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<?xf32>) -> tensor<5xf32>, sym_name = "test_add_1d_broadcast_dynamic_to_static"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<?xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<5xf32>, tensor<?xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "test_add_1d_broadcast_static_to_dynamic"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<?xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<1xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<3xf32>) -> tensor<3xf32>, sym_name = "test_add_1d_broadcast_static_to_static"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<3xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<1xf32>, tensor<3xf32>) -> tensor<3xf32>
    "func.return"(%0) : (tensor<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>, sym_name = "test_add_1d_matching_no_broadcast"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<1xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"(%0) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>, sym_name = "test_add_1d_matching_static"}> ({
  ^bb0(%arg0: tensor<3xf32>, %arg1: tensor<3xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    "func.return"(%0) : (tensor<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "test_add_2d_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "tosa.add"(%arg0, %arg1) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?xi1>, tensor<2x?xf32>, tensor<2x?xf32>) -> tensor<2x?xf32>, sym_name = "test_select_2d_one_dynamic"}> ({
  ^bb0(%arg0: tensor<2x?xi1>, %arg1: tensor<2x?xf32>, %arg2: tensor<2x?xf32>):
    %0 = "tosa.select"(%arg0, %arg1, %arg2) : (tensor<2x?xi1>, tensor<2x?xf32>, tensor<2x?xf32>) -> tensor<2x?xf32>
    "func.return"(%0) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>) -> (), sym_name = "test_simple_f32"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    %0 = "tosa.tanh"(%arg0) : (tensor<1xf32>) -> tensor<1xf32>
    %1 = "tosa.abs"(%arg0) : (tensor<1xf32>) -> tensor<1xf32>
    %2 = "tosa.add"(%0, %0) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %3 = "tosa.sub"(%0, %1) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.mul"(%0, %1, %4) : (tensor<1xf32>, tensor<1xf32>, tensor<1xi8>) -> tensor<1xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.negate"(%0, %6, %7) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %9 = "tosa.pow"(%1, %2) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %10 = "tosa.rsqrt"(%1) : (tensor<1xf32>) -> tensor<1xf32>
    %11 = "tosa.log"(%arg0) : (tensor<1xf32>) -> tensor<1xf32>
    %12 = "tosa.exp"(%arg0) : (tensor<1xf32>) -> tensor<1xf32>
    %13 = "tosa.greater"(%0, %1) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xi1>
    %14 = "tosa.greater_equal"(%0, %1) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xi1>
    %15 = "tosa.equal"(%0, %1) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xi1>
    %16 = "tosa.select"(%13, %0, %1) : (tensor<1xi1>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %17 = "tosa.maximum"(%0, %1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %18 = "tosa.minimum"(%0, %1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %19 = "tosa.ceil"(%0) : (tensor<1xf32>) -> tensor<1xf32>
    %20 = "tosa.floor"(%0) : (tensor<1xf32>) -> tensor<1xf32>
    %21 = "tosa.clamp"(%0) <{max_val = 5.000000e+00 : f32, min_val = 1.000000e+00 : f32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xf32>) -> tensor<1xf32>
    %22 = "tosa.sigmoid"(%0) : (tensor<1xf32>) -> tensor<1xf32>
    %23 = "tosa.cast"(%0) : (tensor<1xf32>) -> tensor<1xi32>
    %24 = "tosa.cast"(%0) : (tensor<1xf32>) -> tensor<1xi1>
    %25 = "tosa.cast"(%0) : (tensor<1xf32>) -> tensor<1xf16>
    %26 = "tosa.reciprocal"(%0) : (tensor<1xf32>) -> tensor<1xf32>
    %27 = "tosa.erf"(%0) : (tensor<1xf32>) -> tensor<1xf32>
    %28 = "tosa.sin"(%arg0) : (tensor<1xf32>) -> tensor<1xf32>
    %29 = "tosa.cos"(%arg0) : (tensor<1xf32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf16>) -> (), sym_name = "test_simple_f16"}> ({
  ^bb0(%arg0: tensor<1xf16>):
    %0 = "tosa.cast"(%arg0) : (tensor<1xf16>) -> tensor<1xf32>
    %1 = "tosa.cast"(%arg0) : (tensor<1xf16>) -> tensor<1xi8>
    %2 = "tosa.cast"(%arg0) : (tensor<1xf16>) -> tensor<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi16>) -> (), sym_name = "test_simple_i16"}> ({
  ^bb0(%arg0: tensor<1xi16>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.mul"(%arg0, %arg0, %0) : (tensor<1xi16>, tensor<1xi16>, tensor<1xi8>) -> tensor<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xui8>) -> (), sym_name = "test_simple_ui8"}> ({
  ^bb0(%arg0: tensor<1xui8>):
    %0 = "tosa.cast"(%arg0) : (tensor<1xui8>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi32>, tensor<1xui32>, tensor<1xui64>) -> (), sym_name = "test_simple_i32"}> ({
  ^bb0(%arg0: tensor<1xi32>, %arg1: tensor<1xui32>, %arg2: tensor<1xui64>):
    %0 = "tosa.add"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %1 = "tosa.sub"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.mul"(%arg0, %arg0, %2) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi8>) -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<2> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.mul"(%arg0, %arg0, %4) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi8>) -> tensor<1xi32>
    %6 = "tosa.intdiv"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %9 = "tosa.negate"(%arg0, %7, %8) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %10 = "tosa.bitwise_and"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %11 = "tosa.bitwise_or"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %12 = "tosa.bitwise_xor"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %13 = "tosa.logical_left_shift"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %14 = "tosa.logical_right_shift"(%arg0, %arg0) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %15 = "tosa.arithmetic_right_shift"(%arg0, %arg0) <{round = false}> : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %16 = "tosa.arithmetic_right_shift"(%arg0, %arg0) <{round = true}> : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %17 = "tosa.clz"(%arg0) : (tensor<1xi32>) -> tensor<1xi32>
    %18 = "tosa.greater"(%0, %1) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi1>
    %19 = "tosa.greater_equal"(%0, %1) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi1>
    %20 = "tosa.select"(%18, %0, %1) : (tensor<1xi1>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %21 = "tosa.maximum"(%0, %1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %22 = "tosa.minimum"(%0, %1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %23 = "tosa.clamp"(%0) <{max_val = 5 : i32, min_val = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xi32>) -> tensor<1xi32>
    %24 = "tosa.clamp"(%arg1) <{max_val = 32 : ui32, min_val = 4 : ui32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xui32>) -> tensor<1xui32>
    %25 = "tosa.cast"(%0) : (tensor<1xi32>) -> tensor<1xi16>
    %26 = "tosa.cast"(%0) : (tensor<1xi32>) -> tensor<1xi64>
    %27 = "tosa.cast"(%0) : (tensor<1xi32>) -> tensor<1xi1>
    %28 = "tosa.cast"(%0) : (tensor<1xi32>) -> tensor<1xf32>
    %29 = "tosa.abs"(%arg0) : (tensor<1xi32>) -> tensor<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> (), sym_name = "test_simple_ui8"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "tosa.cast"(%arg0) : (tensor<1xi8>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> (), sym_name = "test_i8"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 126 : i8, min_val = -127 : i8, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xi8>) -> tensor<1xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi64>) -> (), sym_name = "test_i64"}> ({
  ^bb0(%arg0: tensor<1xi64>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 9223372036854775807 : i64, min_val = -9223372036854775808 : i64, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xi64>) -> tensor<1xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf16>) -> (), sym_name = "test_clamp_f16"}> ({
  ^bb0(%arg0: tensor<1xf16>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 6.000000e+00 : f16, min_val = 0.000000e+00 : f16, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<1xf16>) -> tensor<1xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi1>, tensor<1xi1>) -> (), sym_name = "test_bool"}> ({
  ^bb0(%arg0: tensor<1xi1>, %arg1: tensor<1xi1>):
    %0 = "tosa.logical_and"(%arg0, %arg1) : (tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    %1 = "tosa.logical_or"(%arg0, %arg1) : (tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    %2 = "tosa.logical_xor"(%arg0, %arg1) : (tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    %3 = "tosa.logical_not"(%arg0) : (tensor<1xi1>) -> tensor<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> (), sym_name = "test_negate_quantized"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<7> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.negate"(%arg0, %0, %1) : (tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.negate"(%arg0, %3, %4) : (tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %8 = "tosa.negate"(%arg0, %6, %7) : (tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<50x42xf16>, tensor<1xf16>, tensor<1xf16>) -> tensor<*xf16>, sym_name = "test_negate_no_const_1"}> ({
  ^bb0(%arg0: tensor<50x42xf16>, %arg1: tensor<1xf16>, %arg2: tensor<1xf16>):
    %0 = "tosa.negate"(%arg0, %arg1, %arg2) : (tensor<50x42xf16>, tensor<1xf16>, tensor<1xf16>) -> tensor<50x42xf16>
    %1 = "tensor.cast"(%0) : (tensor<50x42xf16>) -> tensor<*xf16>
    "func.return"(%1) : (tensor<*xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<50x42xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<*xi16>, sym_name = "test_negate_no_const_2"}> ({
  ^bb0(%arg0: tensor<50x42xi16>, %arg1: tensor<1xi16>, %arg2: tensor<1xi16>):
    %0 = "tosa.negate"(%arg0, %arg1, %arg2) : (tensor<50x42xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<50x42xi16>
    %1 = "tensor.cast"(%0) : (tensor<50x42xi16>) -> tensor<*xi16>
    "func.return"(%1) : (tensor<*xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<1xi32>) -> (tensor<1xf32>, tensor<1xi32>), sym_name = "test_identity"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<1xi32>):
    %0 = "tosa.identity"(%arg0) : (tensor<1xf32>) -> tensor<1xf32>
    %1 = "tosa.identity"(%arg1) : (tensor<1xi32>) -> tensor<1xi32>
    "func.return"(%0, %1) : (tensor<1xf32>, tensor<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xbf16>) -> (), sym_name = "reduce_bf16"}> ({
  ^bb0(%arg0: tensor<5x4xbf16>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xbf16>) -> tensor<1x4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>) -> (), sym_name = "reduce_float"}> ({
  ^bb0(%arg0: tensor<5x4xf32>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    %1 = "tosa.reduce_sum"(%arg0) <{axis = 1 : i32}> : (tensor<5x4xf32>) -> tensor<5x1xf32>
    %2 = "tosa.reduce_product"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    %3 = "tosa.reduce_min"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    %4 = "tosa.reduce_max"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x5x4xf32>) -> (), sym_name = "reduce_float_dyn"}> ({
  ^bb0(%arg0: tensor<?x5x4xf32>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 1 : i32}> : (tensor<?x5x4xf32>) -> tensor<?x1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "reduce_float_dyn_rank_1"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 0 : i32}> : (tensor<?xf32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x?x4xf32>) -> (), sym_name = "reduce_float_dyn_nonzero_batch"}> ({
  ^bb0(%arg0: tensor<5x?x4xf32>):
    %0 = "tosa.reduce_product"(%arg0) <{axis = 2 : i32}> : (tensor<5x?x4xf32>) -> tensor<5x?x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> (), sym_name = "reduce_float_dyn_multiple"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "tosa.reduce_max"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<?x?xf32>) -> tensor<?x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi32>) -> (), sym_name = "reduce_int"}> ({
  ^bb0(%arg0: tensor<5x4xi32>):
    %0 = "tosa.reduce_sum"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xi32>) -> tensor<1x4xi32>
    %1 = "tosa.reduce_sum"(%arg0) <{axis = 1 : i32}> : (tensor<5x4xi32>) -> tensor<5x1xi32>
    %2 = "tosa.reduce_product"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xi32>) -> tensor<1x4xi32>
    %3 = "tosa.reduce_min"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xi32>) -> tensor<1x4xi32>
    %4 = "tosa.reduce_max"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xi32>) -> tensor<1x4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi1>) -> (), sym_name = "reduce_bool"}> ({
  ^bb0(%arg0: tensor<5x4xi1>):
    %0 = "tosa.reduce_all"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xi1>) -> tensor<1x4xi1>
    %1 = "tosa.reduce_any"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xi1>) -> tensor<1x4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<2xi8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8_unsigned_output_explicit"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = true, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<2xi8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xui8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8_unsigned_output_implicit"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = true, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<2xi8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi48>) -> (), sym_name = "rescale_i48_unsigned_output_implicit"}> ({
  ^bb0(%arg0: tensor<2xi48>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi48>}> : () -> tensor<1xi48>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = true, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<2xi48>, tensor<1xi16>, tensor<1xi8>, tensor<1xi48>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2xi8>) -> (), sym_name = "rescale_i8_dyn_batch"}> ({
  ^bb0(%arg0: tensor<?x2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<?x2xi8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x2xi8>
    %5 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = true, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<?x2xi8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<?x2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x?x32xi32>) -> (), sym_name = "rescale_dyn"}> ({
  ^bb0(%arg0: tensor<1x?x?x32xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<1376784203> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<38> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %2, %3, %0, %1) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<1x?x?x32xi32>, tensor<1xi32>, tensor<1xi8>, tensor<1xi32>, tensor<1xi8>) -> tensor<1x?x?x32xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xui8>) -> (), sym_name = "rescale_i8_unsigned_input_explicit"}> ({
  ^bb0(%arg0: tensor<2xui8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = true, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<2xui8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8_unsigned_input_implicit"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = true, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<2xi8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xui8>) -> (), sym_name = "rescale_i8_unsigned_input_output_explicit"}> ({
  ^bb0(%arg0: tensor<2xui8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = true, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<2xui8>, tensor<1xi16>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xui8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3xi8>) -> tensor<3xi8>, sym_name = "rescale_per_channel"}> ({
  ^bb0(%arg0: tensor<3xi8>):
    %0 = "tosa.const"() <{values = dense<[42, 43, 44]> : tensor<3xi16>}> : () -> tensor<3xi16>
    %1 = "tosa.const"() <{values = dense<[14, 15, 64]> : tensor<3xi8>}> : () -> tensor<3xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = true, rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>, scale32 = false}> : (tensor<3xi8>, tensor<3xi16>, tensor<3xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<3xi8>
    "func.return"(%4) : (tensor<3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> tensor<2xi8>, sym_name = "rescaleDoubleRound"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<33> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<2xi8>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"(%4) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> tensor<2xi8>, sym_name = "rescaleUnnecessaryDoubleRound"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<2xi8>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"(%4) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> tensor<2xi8>, sym_name = "unsupportedRescaleInexactRound"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<33> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<INEXACT_ROUND>, scale32 = true}> : (tensor<2xi8>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"(%4) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>, sym_name = "rescale_no_const"}> ({
  ^bb0(%arg0: tensor<2xi8>, %arg1: tensor<1xi32>, %arg2: tensor<1xi8>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tosa.rescale"(%arg0, %arg1, %arg2, %arg3, %arg4) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<2xi8>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"(%0) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>, sym_name = "rescale_no_const_per_channel"}> ({
  ^bb0(%arg0: tensor<2xi8>, %arg1: tensor<2xi32>, %arg2: tensor<2xi8>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tosa.rescale"(%arg0, %arg1, %arg2, %arg3, %arg4) <{input_unsigned = false, output_unsigned = false, per_channel = true, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>
    "func.return"(%0) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<1xui8>, tensor<1xui8>) -> tensor<2xui8>, sym_name = "rescale_no_const_per_channel_input_output_zp_ui8"}> ({
  ^bb0(%arg0: tensor<2xi8>, %arg1: tensor<2xi32>, %arg2: tensor<2xi8>, %arg3: tensor<1xui8>, %arg4: tensor<1xui8>):
    %0 = "tosa.rescale"(%arg0, %arg1, %arg2, %arg3, %arg4) <{input_unsigned = false, output_unsigned = true, per_channel = true, rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>, scale32 = true}> : (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<1xui8>, tensor<1xui8>) -> tensor<2xui8>
    "func.return"(%0) : (tensor<2xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi32>) -> (), sym_name = "reverse"}> ({
  ^bb0(%arg0: tensor<5x4xi32>):
    %0 = "tosa.reverse"(%arg0) <{axis = 0 : i32}> : (tensor<5x4xi32>) -> tensor<5x4xi32>
    %1 = "tosa.reverse"(%arg0) <{axis = 1 : i32}> : (tensor<5x4xi32>) -> tensor<5x4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi32>) -> (), sym_name = "reverse_dyn"}> ({
  ^bb0(%arg0: tensor<?xi32>):
    %0 = "tosa.reverse"(%arg0) <{axis = 0 : i32}> : (tensor<?xi32>) -> tensor<?xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>) -> (), sym_name = "tile"}> ({
  ^bb0(%arg0: tensor<2x3xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.tile"(%arg0, %0) : (tensor<2x3xi8>, !tosa.shape<2>) -> tensor<4x3xi8>
    %2 = "tosa.const_shape"() <{values = dense<[1, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.tile"(%arg0, %2) : (tensor<2x3xi8>, !tosa.shape<2>) -> tensor<2x6xi8>
    %4 = "tosa.const_shape"() <{values = dense<[5, 7]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %5 = "tosa.tile"(%arg0, %4) : (tensor<2x3xi8>, !tosa.shape<2>) -> tensor<10x21xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3xi8>) -> (), sym_name = "tile_dyn_input"}> ({
  ^bb0(%arg0: tensor<?x3xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.tile"(%arg0, %0) : (tensor<?x3xi8>, !tosa.shape<2>) -> tensor<?x3xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>) -> (), sym_name = "tile_dyn_multiples"}> ({
  ^bb0(%arg0: tensor<2x3xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.tile"(%arg0, %0) : (tensor<2x3xi8>, !tosa.shape<2>) -> tensor<2x?xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2xi32>, tensor<6xf32>) -> (), sym_name = "argmax"}> ({
  ^bb0(%arg0: tensor<3x2xi32>, %arg1: tensor<6xf32>):
    %0 = "tosa.argmax"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<3x2xi32>) -> tensor<2xi32>
    %1 = "tosa.argmax"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<3x2xi32>) -> tensor<3xi32>
    %2 = "tosa.argmax"(%arg1) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<6xf32>) -> tensor<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x?xi32>) -> (), sym_name = "argmax_dyn_non_axis"}> ({
  ^bb0(%arg0: tensor<3x?xi32>):
    %0 = "tosa.argmax"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<3x?xi32>) -> tensor<?xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x?xi32>) -> (), sym_name = "argmax_dyn_axis"}> ({
  ^bb0(%arg0: tensor<3x?xi32>):
    %0 = "tosa.argmax"(%arg0) <{axis = 1 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<3x?xi32>) -> tensor<3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x2xf32>, tensor<2x3xi32>) -> (), sym_name = "gather_float"}> ({
  ^bb0(%arg0: tensor<2x3x2xf32>, %arg1: tensor<2x3xi32>):
    %0 = "tosa.gather"(%arg0, %arg1) : (tensor<2x3x2xf32>, tensor<2x3xi32>) -> tensor<2x3x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3x2xf32>, tensor<?x3xi32>) -> (), sym_name = "gather_float_dyn"}> ({
  ^bb0(%arg0: tensor<?x3x2xf32>, %arg1: tensor<?x3xi32>):
    %0 = "tosa.gather"(%arg0, %arg1) : (tensor<?x3x2xf32>, tensor<?x3xi32>) -> tensor<?x3x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?xi32>) -> (), sym_name = "gather_float_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?xi32>):
    %0 = "tosa.gather"(%arg0, %arg1) : (tensor<?x?x?xf32>, tensor<?x?xi32>) -> tensor<?x?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x2xi32>, tensor<2x3xi32>) -> (), sym_name = "gather_int"}> ({
  ^bb0(%arg0: tensor<2x3x2xi32>, %arg1: tensor<2x3xi32>):
    %0 = "tosa.gather"(%arg0, %arg1) : (tensor<2x3x2xi32>, tensor<2x3xi32>) -> tensor<2x3x2xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xi8>, tensor<512xi8>) -> (), sym_name = "table8"}> ({
  ^bb0(%arg0: tensor<6xi8>, %arg1: tensor<512xi8>):
    %0 = "tosa.table"(%arg0, %arg1) : (tensor<6xi8>, tensor<512xi8>) -> tensor<6xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xi16>, tensor<513xi16>) -> (), sym_name = "table16"}> ({
  ^bb0(%arg0: tensor<6xi16>, %arg1: tensor<513xi16>):
    %0 = "tosa.table"(%arg0, %arg1) : (tensor<6xi16>, tensor<513xi16>) -> tensor<6xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi8>, tensor<512xi8>) -> (), sym_name = "table8_dyn"}> ({
  ^bb0(%arg0: tensor<?xi8>, %arg1: tensor<512xi8>):
    %0 = "tosa.table"(%arg0, %arg1) : (tensor<?xi8>, tensor<512xi8>) -> tensor<?xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xi8>, tensor<?xi8>) -> (), sym_name = "table8_dyn_table"}> ({
  ^bb0(%arg0: tensor<6xi8>, %arg1: tensor<?xi8>):
    %0 = "tosa.table"(%arg0, %arg1) : (tensor<6xi8>, tensor<?xi8>) -> tensor<6xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4x8xf32>) -> (tensor<5x4x5xf32>, tensor<5x4x5xf32>), sym_name = "test_static_rfft2d"}> ({
  ^bb0(%arg0: tensor<5x4x8xf32>):
    %0:2 = "tosa.rfft2d"(%arg0) : (tensor<5x4x8xf32>) -> (tensor<5x4x5xf32>, tensor<5x4x5xf32>)
    "func.return"(%0#0, %0#1) : (tensor<5x4x5xf32>, tensor<5x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>), sym_name = "test_dynamic_rfft2d"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0:2 = "tosa.rfft2d"(%arg0) : (tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    "func.return"(%0#0, %0#1) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x8x8xf32>, tensor<8x8x8xf32>) -> (tensor<8x8x8xf32>, tensor<8x8x8xf32>), sym_name = "test_static_fft2d"}> ({
  ^bb0(%arg0: tensor<8x8x8xf32>, %arg1: tensor<8x8x8xf32>):
    %0:2 = "tosa.fft2d"(%arg0, %arg1) <{inverse = false}> : (tensor<8x8x8xf32>, tensor<8x8x8xf32>) -> (tensor<8x8x8xf32>, tensor<8x8x8xf32>)
    "func.return"(%0#0, %0#1) : (tensor<8x8x8xf32>, tensor<8x8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>), sym_name = "test_dynamic_fft2d"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>):
    %0:2 = "tosa.fft2d"(%arg0, %arg1) <{inverse = true}> : (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    "func.return"(%0#0, %0#1) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>) -> tensor<1xi64>, sym_name = "test_cast_fp32_i64"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    %0 = "tosa.cast"(%arg0) : (tensor<1xf32>) -> tensor<1xi64>
    "func.return"(%0) : (tensor<1xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_min_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.reduce_min"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_max_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.reduce_max"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "reduce_min_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tosa.reduce_min"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xi8>) -> tensor<1x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "reduce_max_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tosa.reduce_max"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xi8>) -> tensor<1x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_min_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.reduce_min"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_max_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.reduce_max"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "minimum_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.minimum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "maximum_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.maximum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "minimum_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tosa.minimum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xi8>, tensor<5x4xi8>) -> tensor<5x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "maximum_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tosa.maximum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xi8>, tensor<5x4xi8>) -> tensor<5x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "minimum_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.minimum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "maximum_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.maximum"(%arg0, %arg1) <{nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "argmax_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.argmax"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>) -> tensor<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "argmax_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tosa.argmax"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xi8>) -> tensor<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "argmax_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.argmax"(%arg0) <{axis = 0 : i32, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xf32>) -> tensor<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "clamp_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 5.000000e+00 : f32, min_val = 1.000000e+00 : f32, nan_mode = #tosa.nan_mode<PROPAGATE>}> : (tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "clamp_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 5 : i8, min_val = 1 : i8, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xi8>) -> tensor<5x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "clamp_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tosa.clamp"(%arg0) <{max_val = 5.000000e+00 : f32, min_val = 1.000000e+00 : f32, nan_mode = #tosa.nan_mode<IGNORE>}> : (tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>) -> (), sym_name = "test_0d_input"}> ({
  ^bb0(%arg0: tensor<i32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.mul"(%arg0, %arg0, %0) : (tensor<i32>, tensor<i32>, tensor<1xi8>) -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.negate"(%arg0, %2, %3) : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>) -> tensor<2x3xi32>, sym_name = "mul_no_const_shift"}> ({
  ^bb0(%arg0: tensor<2x3xi32>, %arg1: tensor<2x3xi32>, %arg2: tensor<1xi8>):
    %0 = "tosa.mul"(%arg0, %arg1, %arg2) : (tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>) -> tensor<2x3xi32>
    "func.return"(%0) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<4xi64>, sym_name = "negate_i64_no_noop_cast"}> ({
  ^bb0(%arg0: tensor<4xi64>, %arg1: tensor<1xi64>, %arg2: tensor<1xi64>):
    %0 = "tosa.negate"(%arg0, %arg1, %arg2) : (tensor<4xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<4xi64>
    "func.return"(%0) : (tensor<4xi64>) -> ()
  }) : () -> ()
}) : () -> ()

