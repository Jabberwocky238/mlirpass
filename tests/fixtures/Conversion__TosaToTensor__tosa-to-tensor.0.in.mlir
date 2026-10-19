"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "test_reshape_0d_same_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<f32>, !tosa.shape<0>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<?xf32>, sym_name = "test_reshape_0d_up_s2d_auto"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<-1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<f32>, !tosa.shape<1>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<?xf32>, sym_name = "test_reshape_0d_up_s2d_explicit"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<f32>, !tosa.shape<1>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<1xf32>, sym_name = "test_reshape_0d_up_s2s_auto"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<-1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<f32>, !tosa.shape<1>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<1xf32>, sym_name = "test_reshape_0d_up_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<f32>, !tosa.shape<1>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<f32>, sym_name = "test_reshape_1d_down_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?xf32>, !tosa.shape<0>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>) -> tensor<f32>, sym_name = "test_reshape_1d_down_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<1xf32>, !tosa.shape<0>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<2x?xf32>, sym_name = "test_reshape_1d_up_d2d_auto"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?xf32>, !tosa.shape<2>) -> tensor<2x?xf32>
    "func.return"(%1) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xf32>) -> tensor<2x3xf32>, sym_name = "test_reshape_1d_up_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<6xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<6xf32>, !tosa.shape<2>) -> tensor<2x3xf32>
    "func.return"(%1) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?xf32>) -> tensor<?xf32>, sym_name = "test_reshape_2d_down_d2d_auto"}> ({
  ^bb0(%arg0: tensor<2x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<-1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<2x?xf32>, !tosa.shape<1>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>) -> tensor<6xf32>, sym_name = "test_reshape_2d_down_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<2x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<6> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<2x3xf32>, !tosa.shape<1>) -> tensor<6xf32>
    "func.return"(%1) : (tensor<6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2xf32>) -> tensor<2x?xf32>, sym_name = "test_reshape_2d_same_d2d_auto"}> ({
  ^bb0(%arg0: tensor<?x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x2xf32>, !tosa.shape<2>) -> tensor<2x?xf32>
    "func.return"(%1) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x4xf32>) -> tensor<?x2xf32>, sym_name = "test_reshape_2d_same_s2d_auto"}> ({
  ^bb0(%arg0: tensor<2x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<2x4xf32>, !tosa.shape<2>) -> tensor<?x2xf32>
    "func.return"(%1) : (tensor<?x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x4xf32>) -> tensor<?x2xf32>, sym_name = "test_reshape_2d_same_s2d_explicit"}> ({
  ^bb0(%arg0: tensor<2x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[4, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<2x4xf32>, !tosa.shape<2>) -> tensor<?x2xf32>
    "func.return"(%1) : (tensor<?x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2xf32>) -> tensor<2x3xf32>, sym_name = "test_reshape_2d_same_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<3x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<3x2xf32>, !tosa.shape<2>) -> tensor<2x3xf32>
    "func.return"(%1) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_auto_empty"}> ({
  ^bb0(%arg0: tensor<3x2x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 3, -1]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<3x2x?xf32>, !tosa.shape<3>) -> tensor<?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_auto"}> ({
  ^bb0(%arg0: tensor<2x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<2x?x?xf32>, !tosa.shape<3>) -> tensor<?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3x4xf32>) -> tensor<2x3x?xf32>, sym_name = "test_reshape_3d_same_d2d_auto_identity"}> ({
  ^bb0(%arg0: tensor<?x3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, -1]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x3x4xf32>, !tosa.shape<3>) -> tensor<2x3x?xf32>
    "func.return"(%1) : (tensor<2x3x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_explicit_empty"}> ({
  ^bb0(%arg0: tensor<3x2x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 3, 2]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<3x2x?xf32>, !tosa.shape<3>) -> tensor<?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x?x?xf32>, !tosa.shape<3>) -> tensor<?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3x4xf32>) -> tensor<2x3x?xf32>, sym_name = "test_reshape_3d_same_d2d_explicit_identity"}> ({
  ^bb0(%arg0: tensor<?x3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x3x4xf32>, !tosa.shape<3>) -> tensor<2x3x?xf32>
    "func.return"(%1) : (tensor<2x3x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>, sym_name = "test_reshape_3d_same_d2s_auto"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x?x?xf32>, !tosa.shape<3>) -> tensor<2x3x4xf32>
    "func.return"(%1) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>, sym_name = "test_reshape_3d_same_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x?x?xf32>, !tosa.shape<3>) -> tensor<2x3x4xf32>
    "func.return"(%1) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>) -> tensor<2x3x4xf32>, sym_name = "test_reshape_3d_same_s2s_explicit_identity"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<2x3x4xf32>, !tosa.shape<3>) -> tensor<2x3x4xf32>
    "func.return"(%1) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<1x3x2x1xf32>, sym_name = "test_reshape_3d_up_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 3, 2, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x?x?xf32>, !tosa.shape<4>) -> tensor<1x3x2x1xf32>
    "func.return"(%1) : (tensor<1x3x2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>) -> tensor<f32>, sym_name = "test_reshape_4d_down_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x?x?x?xf32>, !tosa.shape<0>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x2x3xf32>) -> tensor<?x2x3xf32>, sym_name = "test_reshape_5d_down_d2d_auto"}> ({
  ^bb0(%arg0: tensor<?x?x?x2x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 2, 3]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?x?x?x2x3xf32>, !tosa.shape<3>) -> tensor<?x2x3xf32>
    "func.return"(%1) : (tensor<?x2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x?x5x7x11xf32>) -> tensor<?x5x77xf32>, sym_name = "test_reshape_6d_down_d2d_auto"}> ({
  ^bb0(%arg0: tensor<1x2x?x5x7x11xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 5, 77]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<1x2x?x5x7x11xf32>, !tosa.shape<3>) -> tensor<?x5x77xf32>
    "func.return"(%1) : (tensor<?x5x77xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32>, sym_name = "test_reshape_6d_down_s2s_auto"}> ({
  ^bb0(%arg0: tensor<1x2x3x5x7x11xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[6, 5, -1]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<1x2x3x5x7x11xf32>, !tosa.shape<3>) -> tensor<6x5x77xf32>
    "func.return"(%1) : (tensor<6x5x77xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<1x1x1x?xf32>, sym_name = "reshape_bug_fix"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 1, 1, -1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<?xf32>, !tosa.shape<4>) -> tensor<1x1x1x?xf32>
    "func.return"(%1) : (tensor<1x1x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32>, sym_name = "test_reshape_6d_down_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<1x2x3x5x7x11xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[6, 5, 77]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<1x2x3x5x7x11xf32>, !tosa.shape<3>) -> tensor<6x5x77xf32>
    "func.return"(%1) : (tensor<6x5x77xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2xui8>) -> tensor<2x3xui8>, sym_name = "test_reshape_samerank_unsigned"}> ({
  ^bb0(%arg0: tensor<3x2xui8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tosa.reshape"(%arg0, %0) : (tensor<3x2xui8>, !tosa.shape<2>) -> tensor<2x3xui8>
    "func.return"(%1) : (tensor<2x3xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xf32>) -> (), sym_name = "slice"}> ({
  ^bb0(%arg0: tensor<6xf32>):
    %0 = "tosa.const_shape"() <{values = dense<2> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.const_shape"() <{values = dense<1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %2 = "tosa.slice"(%arg0, %0, %1) : (tensor<6xf32>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "slice_dyn"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<2> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tosa.const_shape"() <{values = dense<-1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %2 = "tosa.slice"(%arg0, %0, %1) : (tensor<?xf32>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<4x9xf32>, sym_name = "pad_float"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x2xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<4x9xf32>
    "func.return"(%2) : (tensor<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xi32>) -> tensor<4x9xi32>, sym_name = "pad_int"}> ({
  ^bb0(%arg0: tensor<1x2xi32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x2xi32>, !tosa.shape<4>, tensor<1xi32>) -> tensor<4x9xi32>
    "func.return"(%2) : (tensor<4x9xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xi32>) -> tensor<4x9xi32>, sym_name = "pad_quant"}> ({
  ^bb0(%arg0: tensor<1x2xi32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.pad"(%arg0, %0, %1) {input_zp = 42 : i32} : (tensor<1x2xi32>, !tosa.shape<4>, tensor<1xi32>) -> tensor<4x9xi32>
    "func.return"(%2) : (tensor<4x9xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<4x9xf32>, sym_name = "pad_float_explicit"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "arith.constant"() <{value = dense<4.200000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x2xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<4x9xf32>
    "func.return"(%2) : (tensor<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2xf32>) -> tensor<?x9xf32>, sym_name = "pad_dyn_input"}> ({
  ^bb0(%arg0: tensor<?x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<?x2xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<?x9xf32>
    "func.return"(%2) : (tensor<?x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<?x9xf32>, sym_name = "pad_dyn_padding"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.pad"(%arg0, %0, %1) : (tensor<1x2xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<?x9xf32>
    "func.return"(%2) : (tensor<?x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x1xf32>, tensor<6x1xf32>) -> (), sym_name = "concat"}> ({
  ^bb0(%arg0: tensor<5x1xf32>, %arg1: tensor<6x1xf32>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 0 : i32}> : (tensor<5x1xf32>, tensor<6x1xf32>) -> tensor<11x1xf32>
    %1 = "tosa.concat"(%arg0, %arg0) <{axis = 1 : i32}> : (tensor<5x1xf32>, tensor<5x1xf32>) -> tensor<5x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x?xf32>, tensor<6x?xf32>) -> (), sym_name = "concat_non_axis_dyn"}> ({
  ^bb0(%arg0: tensor<5x?xf32>, %arg1: tensor<6x?xf32>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 0 : i32}> : (tensor<5x?xf32>, tensor<6x?xf32>) -> tensor<11x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3xf32>, tensor<?x3xf32>) -> (), sym_name = "concat_axis_dyn"}> ({
  ^bb0(%arg0: tensor<?x3xf32>, %arg1: tensor<?x3xf32>):
    %0 = "tosa.concat"(%arg0, %arg1) <{axis = 0 : i32}> : (tensor<?x3xf32>, tensor<?x3xf32>) -> tensor<?x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>, tensor<?x1xf32>, tensor<?x1xf32>) -> (), sym_name = "concat_axis_dyn_mixed"}> ({
  ^bb0(%arg0: tensor<?x1xf32>, %arg1: tensor<?x1xf32>, %arg2: tensor<?x1xf32>):
    %0 = "tosa.concat"(%arg0, %arg1, %arg2) <{axis = 0 : i32}> : (tensor<?x1xf32>, tensor<?x1xf32>, tensor<?x1xf32>) -> tensor<5x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>, tensor<?x1xf32>, tensor<?x1xf32>) -> (), sym_name = "concat_non_axis_dyn_mixed"}> ({
  ^bb0(%arg0: tensor<?x1xf32>, %arg1: tensor<?x1xf32>, %arg2: tensor<?x1xf32>):
    %0 = "tosa.concat"(%arg0, %arg1, %arg2) <{axis = 1 : i32}> : (tensor<?x1xf32>, tensor<?x1xf32>, tensor<?x1xf32>) -> tensor<5x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2xi32>, tensor<1xi32>) -> tensor<4x5xi32>, sym_name = "pad_variable_pad_const"}> ({
  ^bb0(%arg0: tensor<2x2xi32>, %arg1: tensor<1xi32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 1, 0, 3]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.pad"(%arg0, %0, %arg1) : (tensor<2x2xi32>, !tosa.shape<4>, tensor<1xi32>) -> tensor<4x5xi32>
    "func.return"(%1) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

