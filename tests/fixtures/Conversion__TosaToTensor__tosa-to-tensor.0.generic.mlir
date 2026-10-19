"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "test_reshape_0d_same_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    "func.return"(%arg0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<?xf32>, sym_name = "test_reshape_0d_up_s2d_auto"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<-1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tensor.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    %2 = "tensor.cast"(%1) : (tensor<1xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<?xf32>, sym_name = "test_reshape_0d_up_s2d_explicit"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tensor.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    %2 = "tensor.cast"(%1) : (tensor<1xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<1xf32>, sym_name = "test_reshape_0d_up_s2s_auto"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<-1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tensor.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<1xf32>, sym_name = "test_reshape_0d_up_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tosa.const_shape"() <{values = dense<1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tensor.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<f32>, sym_name = "test_reshape_1d_down_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    %1 = "tensor.cast"(%arg0) : (tensor<?xf32>) -> tensor<1xf32>
    %2 = "tensor.collapse_shape"(%1) <{reassociation = []}> : (tensor<1xf32>) -> tensor<f32>
    "func.return"(%2) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>) -> tensor<f32>, sym_name = "test_reshape_1d_down_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = []}> : (tensor<1xf32>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<2x?xf32>, sym_name = "test_reshape_1d_up_d2d_auto"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?xf32>, index) -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.divsi"(%2, %3) : (index, index) -> index
    %5 = "tensor.expand_shape"(%arg0, %4) <{reassociation = [[0, 1]], static_output_shape = array<i64: 2, -9223372036854775808>}> : (tensor<?xf32>, index) -> tensor<2x?xf32>
    "func.return"(%5) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xf32>) -> tensor<2x3xf32>, sym_name = "test_reshape_1d_up_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<6xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 2, 3>}> : (tensor<6xf32>) -> tensor<2x3xf32>
    "func.return"(%1) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?xf32>) -> tensor<?xf32>, sym_name = "test_reshape_2d_down_d2d_auto"}> ({
  ^bb0(%arg0: tensor<2x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<-1> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (tensor<2x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>) -> tensor<6xf32>, sym_name = "test_reshape_2d_down_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<2x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<6> : tensor<1xindex>}> : () -> !tosa.shape<1>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (tensor<2x3xf32>) -> tensor<6xf32>
    "func.return"(%1) : (tensor<6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2xf32>) -> tensor<2x?xf32>, sym_name = "test_reshape_2d_same_d2d_auto"}> ({
  ^bb0(%arg0: tensor<?x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (tensor<?x2xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1]], static_output_shape = array<i64: 2, -9223372036854775808>}> : (tensor<?xf32>, index) -> tensor<2x?xf32>
    "func.return"(%6) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x4xf32>) -> tensor<?x2xf32>, sym_name = "test_reshape_2d_same_s2d_auto"}> ({
  ^bb0(%arg0: tensor<2x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (tensor<2x4xf32>) -> tensor<8xf32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 2>}> : (tensor<8xf32>) -> tensor<4x2xf32>
    %3 = "tensor.cast"(%2) : (tensor<4x2xf32>) -> tensor<?x2xf32>
    "func.return"(%3) : (tensor<?x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x4xf32>) -> tensor<?x2xf32>, sym_name = "test_reshape_2d_same_s2d_explicit"}> ({
  ^bb0(%arg0: tensor<2x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[4, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (tensor<2x4xf32>) -> tensor<8xf32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 2>}> : (tensor<8xf32>) -> tensor<4x2xf32>
    %3 = "tensor.cast"(%2) : (tensor<4x2xf32>) -> tensor<?x2xf32>
    "func.return"(%3) : (tensor<?x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2xf32>) -> tensor<2x3xf32>, sym_name = "test_reshape_2d_same_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<3x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (tensor<3x2xf32>) -> tensor<6xf32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 2, 3>}> : (tensor<6xf32>) -> tensor<2x3xf32>
    "func.return"(%2) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_auto_empty"}> ({
  ^bb0(%arg0: tensor<3x2x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 3, -1]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<3x2x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 0, 3, -9223372036854775808>}> : (tensor<?xf32>, index) -> tensor<0x3x?xf32>
    %7 = "tensor.cast"(%6) : (tensor<0x3x?xf32>) -> tensor<?x?x?xf32>
    "func.return"(%7) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_auto"}> ({
  ^bb0(%arg0: tensor<2x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<2x?x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 8 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, -9223372036854775808, 4>}> : (tensor<?xf32>, index) -> tensor<2x?x4xf32>
    %7 = "tensor.cast"(%6) : (tensor<2x?x4xf32>) -> tensor<?x?x?xf32>
    "func.return"(%7) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3x4xf32>) -> tensor<2x3x?xf32>, sym_name = "test_reshape_3d_same_d2d_auto_identity"}> ({
  ^bb0(%arg0: tensor<?x3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, -1]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x3x4xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 6 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, 3, -9223372036854775808>}> : (tensor<?xf32>, index) -> tensor<2x3x?xf32>
    "func.return"(%6) : (tensor<2x3x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_explicit_empty"}> ({
  ^bb0(%arg0: tensor<3x2x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[0, 3, 2]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<3x2x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 6 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: -9223372036854775808, 3, 2>}> : (tensor<?xf32>, index) -> tensor<?x3x2xf32>
    %7 = "tensor.cast"(%6) : (tensor<?x3x2xf32>) -> tensor<?x?x?xf32>
    "func.return"(%7) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "test_reshape_3d_same_d2d_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x?x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 12 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: -9223372036854775808, 3, 4>}> : (tensor<?xf32>, index) -> tensor<?x3x4xf32>
    %7 = "tensor.cast"(%6) : (tensor<?x3x4xf32>) -> tensor<?x?x?xf32>
    "func.return"(%7) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3x4xf32>) -> tensor<2x3x?xf32>, sym_name = "test_reshape_3d_same_d2d_explicit_identity"}> ({
  ^bb0(%arg0: tensor<?x3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x3x4xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 12 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.cast"(%arg0) : (tensor<?x3x4xf32>) -> tensor<2x3x?xf32>
    "func.return"(%6) : (tensor<2x3x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>, sym_name = "test_reshape_3d_same_d2s_auto"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x?x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 8 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, -9223372036854775808, 4>}> : (tensor<?xf32>, index) -> tensor<2x?x4xf32>
    %7 = "tensor.cast"(%6) : (tensor<2x?x4xf32>) -> tensor<2x3x4xf32>
    "func.return"(%7) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>, sym_name = "test_reshape_3d_same_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x?x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 12 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: -9223372036854775808, 3, 4>}> : (tensor<?xf32>, index) -> tensor<?x3x4xf32>
    %7 = "tensor.cast"(%6) : (tensor<?x3x4xf32>) -> tensor<2x3x4xf32>
    "func.return"(%7) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>) -> tensor<2x3x4xf32>, sym_name = "test_reshape_3d_same_s2s_explicit_identity"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    "func.return"(%arg0) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<1x3x2x1xf32>, sym_name = "test_reshape_3d_up_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 3, 2, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x?x?xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 6 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2, 3]], static_output_shape = array<i64: -9223372036854775808, 3, 2, 1>}> : (tensor<?xf32>, index) -> tensor<?x3x2x1xf32>
    %7 = "tensor.cast"(%6) : (tensor<?x3x2x1xf32>) -> tensor<1x3x2x1xf32>
    "func.return"(%7) : (tensor<1x3x2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>) -> tensor<f32>, sym_name = "test_reshape_4d_down_d2s_explicit"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>):
    %0 = "tosa.const_shape"() <{values = dense<> : tensor<0xindex>}> : () -> !tosa.shape<0>
    %1 = "tensor.cast"(%arg0) : (tensor<?x?x?x?xf32>) -> tensor<1x1x1x1xf32>
    %2 = "tensor.collapse_shape"(%1) <{reassociation = []}> : (tensor<1x1x1x1xf32>) -> tensor<f32>
    "func.return"(%2) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x2x3xf32>) -> tensor<?x2x3xf32>, sym_name = "test_reshape_5d_down_d2d_auto"}> ({
  ^bb0(%arg0: tensor<?x?x?x2x3xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 2, 3]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2, 3, 4]]}> : (tensor<?x?x?x2x3xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 6 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: -9223372036854775808, 2, 3>}> : (tensor<?xf32>, index) -> tensor<?x2x3xf32>
    "func.return"(%6) : (tensor<?x2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x?x5x7x11xf32>) -> tensor<?x5x77xf32>, sym_name = "test_reshape_6d_down_d2d_auto"}> ({
  ^bb0(%arg0: tensor<1x2x?x5x7x11xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 5, 77]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2, 3, 4, 5]]}> : (tensor<1x2x?x5x7x11xf32>) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 385 : index}> : () -> index
    %5 = "arith.divsi"(%3, %4) : (index, index) -> index
    %6 = "tensor.expand_shape"(%1, %5) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: -9223372036854775808, 5, 77>}> : (tensor<?xf32>, index) -> tensor<?x5x77xf32>
    "func.return"(%6) : (tensor<?x5x77xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32>, sym_name = "test_reshape_6d_down_s2s_auto"}> ({
  ^bb0(%arg0: tensor<1x2x3x5x7x11xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[6, 5, -1]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2], [3], [4, 5]]}> : (tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32>
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
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?xf32>, index) -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "tensor.expand_shape"(%arg0, %2) <{reassociation = [[0, 1, 2, 3]], static_output_shape = array<i64: 1, 1, 1, -9223372036854775808>}> : (tensor<?xf32>, index) -> tensor<1x1x1x?xf32>
    "func.return"(%4) : (tensor<1x1x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32>, sym_name = "test_reshape_6d_down_s2s_explicit"}> ({
  ^bb0(%arg0: tensor<1x2x3x5x7x11xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[6, 5, 77]> : tensor<3xindex>}> : () -> !tosa.shape<3>
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2], [3], [4, 5]]}> : (tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32>
    "func.return"(%1) : (tensor<6x5x77xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2xui8>) -> tensor<2x3xui8>, sym_name = "test_reshape_samerank_unsigned"}> ({
  ^bb0(%arg0: tensor<3x2xui8>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (tensor<3x2xui8>) -> tensor<3x2xi8>
    %1 = "tosa.const_shape"() <{values = dense<[2, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1]]}> : (tensor<3x2xi8>) -> tensor<6xi8>
    %3 = "tensor.expand_shape"(%2) <{reassociation = [[0, 1]], static_output_shape = array<i64: 2, 3>}> : (tensor<6xi8>) -> tensor<2x3xi8>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (tensor<2x3xi8>) -> tensor<2x3xui8>
    "func.return"(%4) : (tensor<2x3xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xf32>) -> (), sym_name = "slice"}> ({
  ^bb0(%arg0: tensor<6xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<6xf32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "slice_dyn"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.subi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %4 = "tensor.extract_slice"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<4x9xf32>, sym_name = "pad_float"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3.140000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "arith.constant"() <{value = 4 : index}> : () -> index
    %8 = "tensor.pad"(%arg0, %4, %6, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%3) : (f32) -> ()
    }) : (tensor<1x2xf32>, index, index, index, index) -> tensor<4x9xf32>
    "func.return"(%8) : (tensor<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xi32>) -> tensor<4x9xi32>, sym_name = "pad_int"}> ({
  ^bb0(%arg0: tensor<1x2xi32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "arith.constant"() <{value = 4 : index}> : () -> index
    %8 = "tensor.pad"(%arg0, %4, %6, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%3) : (i32) -> ()
    }) : (tensor<1x2xi32>, index, index, index, index) -> tensor<4x9xi32>
    "func.return"(%8) : (tensor<4x9xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xi32>) -> tensor<4x9xi32>, sym_name = "pad_quant"}> ({
  ^bb0(%arg0: tensor<1x2xi32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "arith.constant"() <{value = 4 : index}> : () -> index
    %8 = "tensor.pad"(%arg0, %4, %6, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%3) : (i32) -> ()
    }) : (tensor<1x2xi32>, index, index, index, index) -> tensor<4x9xi32>
    "func.return"(%8) : (tensor<4x9xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<4x9xf32>, sym_name = "pad_float_explicit"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "arith.constant"() <{value = dense<4.200000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "arith.constant"() <{value = 4 : index}> : () -> index
    %8 = "tensor.pad"(%arg0, %4, %6, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%3) : (f32) -> ()
    }) : (tensor<1x2xf32>, index, index, index, index) -> tensor<4x9xf32>
    "func.return"(%8) : (tensor<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2xf32>) -> tensor<?x9xf32>, sym_name = "pad_dyn_input"}> ({
  ^bb0(%arg0: tensor<?x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3.140000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "arith.constant"() <{value = 4 : index}> : () -> index
    %8 = "tensor.pad"(%arg0, %4, %6, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%3) : (f32) -> ()
    }) : (tensor<?x2xf32>, index, index, index, index) -> tensor<?x9xf32>
    "func.return"(%8) : (tensor<?x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<?x9xf32>, sym_name = "pad_dyn_padding"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[-1, 2, 3, 4]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3.140000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = -1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "arith.constant"() <{value = 4 : index}> : () -> index
    %8 = "tensor.pad"(%arg0, %4, %6, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%3) : (f32) -> ()
    }) : (tensor<1x2xf32>, index, index, index, index) -> tensor<?x9xf32>
    "func.return"(%8) : (tensor<?x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x1xf32>, tensor<6x1xf32>) -> (), sym_name = "concat"}> ({
  ^bb0(%arg0: tensor<5x1xf32>, %arg1: tensor<6x1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 6 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5 : index}> : () -> index
    %3 = "arith.constant"() <{value = 11 : index}> : () -> index
    %4 = "tensor.empty"() : () -> tensor<11x1xf32>
    %5 = "tensor.insert_slice"(%arg0, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 5, 1>, static_strides = array<i64: 1, 1>}> : (tensor<5x1xf32>, tensor<11x1xf32>) -> tensor<11x1xf32>
    %6 = "tensor.insert_slice"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 5, 0>, static_sizes = array<i64: 6, 1>, static_strides = array<i64: 1, 1>}> : (tensor<6x1xf32>, tensor<11x1xf32>) -> tensor<11x1xf32>
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "arith.constant"() <{value = 2 : index}> : () -> index
    %11 = "tensor.empty"() : () -> tensor<5x2xf32>
    %12 = "tensor.insert_slice"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 5, 1>, static_strides = array<i64: 1, 1>}> : (tensor<5x1xf32>, tensor<5x2xf32>) -> tensor<5x2xf32>
    %13 = "tensor.insert_slice"(%arg0, %12) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 1>, static_sizes = array<i64: 5, 1>, static_strides = array<i64: 1, 1>}> : (tensor<5x1xf32>, tensor<5x2xf32>) -> tensor<5x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x?xf32>, tensor<6x?xf32>) -> (), sym_name = "concat_non_axis_dyn"}> ({
  ^bb0(%arg0: tensor<5x?xf32>, %arg1: tensor<6x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<5x?xf32>, index) -> index
    %3 = "arith.constant"() <{value = 6 : index}> : () -> index
    %4 = "arith.constant"() <{value = 5 : index}> : () -> index
    %5 = "arith.constant"() <{value = 11 : index}> : () -> index
    %6 = "tensor.empty"(%2) : (index) -> tensor<11x?xf32>
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "tensor.dim"(%arg0, %7) : (tensor<5x?xf32>, index) -> index
    %9 = "tensor.insert_slice"(%arg0, %6, %8) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 5, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<5x?xf32>, tensor<11x?xf32>, index) -> tensor<11x?xf32>
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "tensor.dim"(%arg1, %10) : (tensor<6x?xf32>, index) -> index
    %12 = "tensor.insert_slice"(%arg1, %9, %11) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 5, 0>, static_sizes = array<i64: 6, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<6x?xf32>, tensor<11x?xf32>, index) -> tensor<11x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3xf32>, tensor<?x3xf32>) -> (), sym_name = "concat_axis_dyn"}> ({
  ^bb0(%arg0: tensor<?x3xf32>, %arg1: tensor<?x3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?x3xf32>, index) -> index
    %3 = "tensor.dim"(%arg1, %0) : (tensor<?x3xf32>, index) -> index
    %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "tensor.empty"(%4) : (index) -> tensor<?x3xf32>
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "tensor.dim"(%arg0, %6) : (tensor<?x3xf32>, index) -> index
    %8 = "tensor.insert_slice"(%arg0, %5, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 3>, static_strides = array<i64: 1, 1>}> : (tensor<?x3xf32>, tensor<?x3xf32>, index) -> tensor<?x3xf32>
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "tensor.dim"(%arg1, %9) : (tensor<?x3xf32>, index) -> index
    %11 = "tensor.insert_slice"(%arg1, %8, %2, %10) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 3>, static_strides = array<i64: 1, 1>}> : (tensor<?x3xf32>, tensor<?x3xf32>, index, index) -> tensor<?x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>, tensor<?x1xf32>, tensor<?x1xf32>) -> (), sym_name = "concat_axis_dyn_mixed"}> ({
  ^bb0(%arg0: tensor<?x1xf32>, %arg1: tensor<?x1xf32>, %arg2: tensor<?x1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?x1xf32>, index) -> index
    %3 = "tensor.dim"(%arg1, %0) : (tensor<?x1xf32>, index) -> index
    %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "tensor.dim"(%arg2, %0) : (tensor<?x1xf32>, index) -> index
    %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "tensor.empty"() : () -> tensor<5x1xf32>
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "tensor.dim"(%arg0, %8) : (tensor<?x1xf32>, index) -> index
    %10 = "tensor.insert_slice"(%arg0, %7, %9) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (tensor<?x1xf32>, tensor<5x1xf32>, index) -> tensor<5x1xf32>
    %11 = "arith.constant"() <{value = 0 : index}> : () -> index
    %12 = "tensor.dim"(%arg1, %11) : (tensor<?x1xf32>, index) -> index
    %13 = "tensor.insert_slice"(%arg1, %10, %2, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (tensor<?x1xf32>, tensor<5x1xf32>, index, index) -> tensor<5x1xf32>
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "tensor.dim"(%arg2, %14) : (tensor<?x1xf32>, index) -> index
    %16 = "tensor.insert_slice"(%arg2, %13, %4, %15) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (tensor<?x1xf32>, tensor<5x1xf32>, index, index) -> tensor<5x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>, tensor<?x1xf32>, tensor<?x1xf32>) -> (), sym_name = "concat_non_axis_dyn_mixed"}> ({
  ^bb0(%arg0: tensor<?x1xf32>, %arg1: tensor<?x1xf32>, %arg2: tensor<?x1xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?x1xf32>, index) -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 2 : index}> : () -> index
    %8 = "arith.constant"() <{value = 3 : index}> : () -> index
    %9 = "tensor.empty"() : () -> tensor<5x3xf32>
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "tensor.dim"(%arg0, %10) : (tensor<?x1xf32>, index) -> index
    %12 = "tensor.insert_slice"(%arg0, %9, %11) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (tensor<?x1xf32>, tensor<5x3xf32>, index) -> tensor<5x3xf32>
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "tensor.dim"(%arg1, %13) : (tensor<?x1xf32>, index) -> index
    %15 = "tensor.insert_slice"(%arg1, %12, %14) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 1>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (tensor<?x1xf32>, tensor<5x3xf32>, index) -> tensor<5x3xf32>
    %16 = "arith.constant"() <{value = 0 : index}> : () -> index
    %17 = "tensor.dim"(%arg2, %16) : (tensor<?x1xf32>, index) -> index
    %18 = "tensor.insert_slice"(%arg2, %15, %17) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 2>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (tensor<?x1xf32>, tensor<5x3xf32>, index) -> tensor<5x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2xi32>, tensor<1xi32>) -> tensor<4x5xi32>, sym_name = "pad_variable_pad_const"}> ({
  ^bb0(%arg0: tensor<2x2xi32>, %arg1: tensor<1xi32>):
    %0 = "tosa.const_shape"() <{values = dense<[1, 1, 0, 3]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.extract"(%arg1, %1) : (tensor<1xi32>, index) -> i32
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "tensor.pad"(%arg0, %3, %5, %4, %6) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%2) : (i32) -> ()
    }) : (tensor<2x2xi32>, index, index, index, index) -> tensor<4x5xi32>
    "func.return"(%7) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

