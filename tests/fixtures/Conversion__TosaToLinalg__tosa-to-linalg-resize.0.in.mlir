"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf32>) -> tensor<3x1x1x7xf32>, sym_name = "unary_resize_nearest_fp32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<3x1x1x7xf32>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xf32>
    "func.return"(%3) : (tensor<3x1x1x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xbf16>) -> tensor<3x1x1x7xbf16>, sym_name = "unary_resize_nearest_bf16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xbf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<3x1x1x7xbf16>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xbf16>
    "func.return"(%3) : (tensor<3x1x1x7xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf16>) -> tensor<3x1x1x7xf16>, sym_name = "unary_resize_nearest_fp16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<3x1x1x7xf16>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xf16>
    "func.return"(%3) : (tensor<3x1x1x7xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf32>) -> tensor<3x1x1x7xf32>, sym_name = "unary_resize_bilinear_fp32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<3x1x1x7xf32>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xf32>
    "func.return"(%3) : (tensor<3x1x1x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xbf16>) -> tensor<3x1x1x7xbf16>, sym_name = "unary_resize_bilinear_bf16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xbf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<3x1x1x7xbf16>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xbf16>
    "func.return"(%3) : (tensor<3x1x1x7xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf16>) -> tensor<3x1x1x7xf16>, sym_name = "unary_resize_bilinear_fp16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<3x1x1x7xf16>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xf16>
    "func.return"(%3) : (tensor<3x1x1x7xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xi8>) -> tensor<3x1x1x7xi8>, sym_name = "unary_resize_nearest_i8"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<3x1x1x7xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xi8>
    "func.return"(%3) : (tensor<3x1x1x7xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xbf16>) -> tensor<3x1x5x7xbf16>, sym_name = "broadcast_resize_nearest_bf16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xbf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<3x1x1x7xbf16>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x5x7xbf16>
    "func.return"(%3) : (tensor<3x1x5x7xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf32>) -> tensor<3x1x5x7xf32>, sym_name = "broadcast_resize_nearest_f32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<3x1x1x7xf32>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x5x7xf32>
    "func.return"(%3) : (tensor<3x1x5x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xi8>) -> tensor<3x4x5x7xi32>, sym_name = "broadcast_resize_bilinear_i8"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<3x1x1x7xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x4x5x7xi32>
    "func.return"(%3) : (tensor<3x4x5x7xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xi8>) -> tensor<3x1x1x7xi32>, sym_name = "unary_resize_bilinear_i32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 2, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<3x1x1x7xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x1x7xi32>
    "func.return"(%3) : (tensor<3x1x1x7xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x15x13x1xi8>) -> (), sym_name = "resize_nearest_int"}> ({
  ^bb0(%arg0: tensor<1x15x13x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[11, 7, 89, 6]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<1x15x13x1xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x23x179x1xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x19x20x1xi8>) -> (), sym_name = "resize_bilinear_int"}> ({
  ^bb0(%arg0: tensor<1x19x20x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[16, 1, 16, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<1x19x20x1xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x289x305x1xi48>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x50x48x1xf32>) -> (), sym_name = "resize_nearest_fp32"}> ({
  ^bb0(%arg0: tensor<1x50x48x1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[64, 2, 64, 2]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<-31> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<31> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<NEAREST_NEIGHBOR>}> : (tensor<1x50x48x1xf32>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x1600x1536x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x23x24x1xf32>) -> (), sym_name = "resize_bilinear_fp"}> ({
  ^bb0(%arg0: tensor<1x23x24x1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[4, 1, 4, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<1x23x24x1xf32>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x89x93x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2x2x1xi8>) -> (), sym_name = "resize_dyn"}> ({
  ^bb0(%arg0: tensor<?x2x2x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[4, 2, 4, 2]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<-1> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<1> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<?x2x2x1xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<?x4x4x1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x19x19x1xi16>) -> (), sym_name = "resize_bilinear_int48"}> ({
  ^bb0(%arg0: tensor<1x19x19x1xi16>):
    %0 = "tosa.const_shape"() <{values = dense<[16, 1, 16, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<1x19x19x1xi16>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<1x289x289x1xi48>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x2x7xi8>) -> tensor<3x1x4x7xi32>, sym_name = "skip_interpolate_bilinear_i8"}> ({
  ^bb0(%arg1: tensor<3x1x2x7xi8>):
    %4 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %5 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %6 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %7 = "tosa.resize"(%arg1, %4, %5, %6) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<3x1x2x7xi8>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x4x7xi32>
    "func.return"(%7) : (tensor<3x1x4x7xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<3x1x2x7xf32>) -> tensor<3x1x4x7xf32>, sym_name = "skip_interpolate_bilinear_f32"}> ({
  ^bb0(%arg0: tensor<3x1x2x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tosa.resize"(%arg0, %0, %1, %2) <{mode = #tosa.resize_mode<BILINEAR>}> : (tensor<3x1x2x7xf32>, !tosa.shape<4>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x1x4x7xf32>
    "func.return"(%3) : (tensor<3x1x4x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

