"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "expand_shape_identity_fold"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0]], static_output_shape = array<i64: 5>}> : (tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "expand_shape_rank0_identity_fold"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64>}> : (tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>) -> tensor<5x4xf32>, sym_name = "collapse_shape_identity_fold"}> ({
  ^bb0(%arg0: tensor<5x4xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1]]}> : (tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"(%0) : (tensor<5x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "collapse_shape_rank0_identity_fold"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = []}> : (tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi32>) -> tensor<2xf32>, sym_name = "tensor_bitcast_chain_ok"}> ({
  ^bb0(%arg0: tensor<2xi32>):
    %0 = "tensor.bitcast"(%arg0) : (tensor<2xi32>) -> tensor<2xui32>
    %1 = "tensor.bitcast"(%0) : (tensor<2xui32>) -> tensor<2xf32>
    "func.return"(%1) : (tensor<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi32>) -> tensor<4xi32>, sym_name = "tensor_bitcast_chain_nop"}> ({
  ^bb0(%arg0: tensor<4xi32>):
    %0 = "tensor.bitcast"(%arg0) : (tensor<4xi32>) -> tensor<4xui32>
    %1 = "tensor.bitcast"(%0) : (tensor<4xui32>) -> tensor<4xi32>
    "func.return"(%1) : (tensor<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xi32>) -> tensor<2xi32>, sym_name = "cast_values"}> ({
  ^bb0(%arg0: tensor<*xi32>):
    %0 = "tensor.cast"(%arg0) : (tensor<*xi32>) -> tensor<*xi32>
    %1 = "tensor.cast"(%0) : (tensor<*xi32>) -> tensor<2xi32>
    %2 = "tensor.cast"(%1) : (tensor<2xi32>) -> tensor<2xi32>
    "func.return"(%2) : (tensor<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xi32>) -> tensor<4x8xi32>, sym_name = "tensor.cast_chain_ok"}> ({
  ^bb0(%arg0: tensor<*xi32>):
    %0 = "tensor.cast"(%arg0) : (tensor<*xi32>) -> tensor<4x?xi32>
    %1 = "tensor.cast"(%0) : (tensor<4x?xi32>) -> tensor<4x8xi32>
    "func.return"(%1) : (tensor<4x8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi32>) -> tensor<4xi32>, sym_name = "tensor.cast_chain_regain"}> ({
  ^bb0(%arg0: tensor<4xi32>):
    %0 = "tensor.cast"(%arg0) : (tensor<4xi32>) -> tensor<?xi32>
    %1 = "tensor.cast"(%0) : (tensor<?xi32>) -> tensor<4xi32>
    "func.return"(%1) : (tensor<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xi32>) -> tensor<?x8xi32>, sym_name = "tensor.cast_chain_keep"}> ({
  ^bb0(%arg0: tensor<?x?xi32>):
    %0 = "tensor.cast"(%arg0) : (tensor<?x?xi32>) -> tensor<4x?xi32>
    %1 = "tensor.cast"(%0) : (tensor<4x?xi32>) -> tensor<?x8xi32>
    "func.return"(%1) : (tensor<?x8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8xi32>) -> tensor<8x4xi32>, sym_name = "tensor.cast_chain_invalid"}> ({
  ^bb0(%arg0: tensor<4x8xi32>):
    %0 = "tensor.cast"(%arg0) : (tensor<4x8xi32>) -> tensor<?x?xi32>
    %1 = "tensor.cast"(%0) : (tensor<?x?xi32>) -> tensor<8x4xi32>
    "func.return"(%1) : (tensor<8x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x?xi32>) -> (tensor<1x2x3xi32>, tensor<1x2x?xi32>), sym_name = "fold_concat"}> ({
  ^bb0(%arg0: tensor<1x2x?xi32>):
    %0 = "tensor.concat"(%arg0) <{dim = 2 : i64}> : (tensor<1x2x?xi32>) -> tensor<1x2x3xi32>
    %1 = "tensor.concat"(%arg0) <{dim = 2 : i64}> : (tensor<1x2x?xi32>) -> tensor<1x2x?xi32>
    "func.return"(%0, %1) : (tensor<1x2x3xi32>, tensor<1x2x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x12xi32>, tensor<?x?xi32>) -> tensor<?x12xi32>, sym_name = "infer_concat_operand_types"}> ({
  ^bb0(%arg0: tensor<?x12xi32>, %arg1: tensor<?x?xi32>):
    %0 = "tensor.concat"(%arg0, %arg1) <{dim = 0 : i64}> : (tensor<?x12xi32>, tensor<?x?xi32>) -> tensor<?x12xi32>
    "func.return"(%0) : (tensor<?x12xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x12xi32>, tensor<?x12xi32>) -> tensor<?x?xi32>, sym_name = "infer_concat_return_type"}> ({
  ^bb0(%arg0: tensor<5x12xi32>, %arg1: tensor<?x12xi32>):
    %0 = "tensor.concat"(%arg0, %arg1) <{dim = 0 : i64}> : (tensor<5x12xi32>, tensor<?x12xi32>) -> tensor<?x?xi32>
    "func.return"(%0) : (tensor<?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (f32, f16, f16, i32, complex<f32>, i32), sym_name = "fold_extract"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = dense<4.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %4 = "tensor.extract"(%3, %arg0) : (tensor<4xf32>, index) -> f32
    %5 = "arith.constant"() <{value = sparse<[[0, 0, 0], [1, 1, 1]], [-5.000000e+00, -2.000000e+00]> : tensor<4x4x4xf16>}> : () -> tensor<4x4x4xf16>
    %6 = "tensor.extract"(%5, %1, %1, %1) : (tensor<4x4x4xf16>, index, index, index) -> f16
    %7 = "arith.constant"() <{value = sparse<1, -2.000000e+00> : tensor<2x2x2xf16>}> : () -> tensor<2x2x2xf16>
    %8 = "tensor.extract"(%7, %0, %0, %0) : (tensor<2x2x2xf16>, index, index, index) -> f16
    %9 = "arith.constant"() <{value = dense<[[[1, -2, 1, 36]], [[0, 2, -1, 64]]]> : tensor<2x1x4xi32>}> : () -> tensor<2x1x4xi32>
    %10 = "tensor.extract"(%9, %1, %0, %2) : (tensor<2x1x4xi32>, index, index, index) -> i32
    %11 = "arith.constant"() <{value = dense<(1.200000e+00,2.300000e+00)> : tensor<complex<f32>>}> : () -> tensor<complex<f32>>
    %12 = "tensor.extract"(%11) : (tensor<complex<f32>>) -> complex<f32>
    %13 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %14 = "arith.constant"() <{value = dense<[[1, 3], [0, 2]]> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %15 = "tensor.insert"(%13, %14, %1, %0) : (i32, tensor<2x2xi32>, index, index) -> tensor<2x2xi32>
    %16 = "tensor.extract"(%15, %1, %0) : (tensor<2x2xi32>, index, index) -> i32
    "func.return"(%4, %6, %8, %10, %12, %16) : (f32, f16, f16, i32, complex<f32>, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "extract_dense_resource_nofold"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense_resource<__elided__> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tensor.extract"(%1, %0) : (tensor<1xi64>, index) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<4xf32>, sym_name = "fold_insert"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = dense<4.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %2 = "tensor.insert"(%1, %0, %arg0) : (f32, tensor<4xf32>, index) -> tensor<4xf32>
    "func.return"(%2) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<9xf32>) -> f32, sym_name = "extract_from_tensor.cast"}> ({
  ^bb0(%arg0: tensor<9xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.cast"(%arg0) : (tensor<9xf32>) -> tensor<?xf32>
    %2 = "tensor.extract"(%1, %0) : (tensor<?xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "extract_from_tensor.from_elements"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.from_elements"(%arg0) : (index) -> tensor<1xindex>
    %2 = "tensor.extract"(%1, %0) : (tensor<1xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "extract_from_tensor.from_elements_0d"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.from_elements"(%arg0) : (index) -> tensor<index>
    %2 = "tensor.extract"(%1) : (tensor<index>) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32), sym_name = "extract_from_tensor.from_elements_3d"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 6.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 9.000000e+00 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %11 = "arith.constant"() <{value = 1.100000e+01 : f32}> : () -> f32
    %12 = "tensor.from_elements"(%0, %1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> tensor<3x2x2xf32>
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 2 : index}> : () -> index
    %16 = "tensor.extract"(%12, %13, %13, %13) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %17 = "tensor.extract"(%12, %13, %13, %14) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %18 = "tensor.extract"(%12, %13, %14, %13) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %19 = "tensor.extract"(%12, %13, %14, %14) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %20 = "tensor.extract"(%12, %14, %13, %13) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %21 = "tensor.extract"(%12, %14, %13, %14) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %22 = "tensor.extract"(%12, %14, %14, %13) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %23 = "tensor.extract"(%12, %14, %14, %14) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %24 = "tensor.extract"(%12, %15, %13, %13) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %25 = "tensor.extract"(%12, %15, %13, %14) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %26 = "tensor.extract"(%12, %15, %14, %13) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %27 = "tensor.extract"(%12, %15, %14, %14) : (tensor<3x2x2xf32>, index, index, index) -> f32
    "func.return"(%16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32), sym_name = "extract_from_tensor.from_elements_variable_3d"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32, %arg5: f32, %arg6: f32, %arg7: f32, %arg8: f32, %arg9: f32, %arg10: f32, %arg11: f32):
    %0 = "tensor.from_elements"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> tensor<3x2x2xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "tensor.extract"(%0, %1, %1, %1) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %5 = "tensor.extract"(%0, %1, %1, %2) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %6 = "tensor.extract"(%0, %1, %2, %1) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %7 = "tensor.extract"(%0, %1, %2, %2) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %8 = "tensor.extract"(%0, %2, %1, %1) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %9 = "tensor.extract"(%0, %2, %1, %2) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %10 = "tensor.extract"(%0, %2, %2, %1) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %11 = "tensor.extract"(%0, %2, %2, %2) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %12 = "tensor.extract"(%0, %3, %1, %1) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %13 = "tensor.extract"(%0, %3, %1, %2) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %14 = "tensor.extract"(%0, %3, %2, %1) : (tensor<3x2x2xf32>, index, index, index) -> f32
    %15 = "tensor.extract"(%0, %3, %2, %2) : (tensor<3x2x2xf32>, index, index, index) -> f32
    "func.return"(%4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3xcomplex<i32>>, sym_name = "extract_from_elements_complex_i"}> ({
    %0 = "arith.constant"() <{value = dense<(1,2)> : tensor<complex<i32>>}> : () -> tensor<complex<i32>>
    %1 = "tensor.extract"(%0) : (tensor<complex<i32>>) -> complex<i32>
    %2 = "arith.constant"() <{value = dense<(3,2)> : tensor<complex<i32>>}> : () -> tensor<complex<i32>>
    %3 = "tensor.extract"(%2) : (tensor<complex<i32>>) -> complex<i32>
    %4 = "tensor.from_elements"(%1, %3, %1) : (complex<i32>, complex<i32>, complex<i32>) -> tensor<3xcomplex<i32>>
    "func.return"(%4) : (tensor<3xcomplex<i32>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3xcomplex<f32>>, sym_name = "extract_from_elements_complex_f"}> ({
    %0 = "arith.constant"() <{value = dense<(1.200000e+00,2.300000e+00)> : tensor<complex<f32>>}> : () -> tensor<complex<f32>>
    %1 = "tensor.extract"(%0) : (tensor<complex<f32>>) -> complex<f32>
    %2 = "arith.constant"() <{value = dense<(3.200000e+00,2.100000e+00)> : tensor<complex<f32>>}> : () -> tensor<complex<f32>>
    %3 = "tensor.extract"(%2) : (tensor<complex<f32>>) -> complex<f32>
    %4 = "tensor.from_elements"(%1, %3, %1) : (complex<f32>, complex<f32>, complex<f32>) -> tensor<3xcomplex<f32>>
    "func.return"(%4) : (tensor<3xcomplex<f32>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "extract_negative_from_tensor.from_elements"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = -1 : index}> : () -> index
    %1 = "tensor.from_elements"(%arg0) : (index) -> tensor<1xindex>
    %2 = "tensor.extract"(%1, %0) : (tensor<1xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "extract_oob_from_tensor.from_elements"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.from_elements"(%arg0) : (index) -> tensor<1xindex>
    %2 = "tensor.extract"(%1, %0) : (tensor<1xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "extract_oob_from_tensor.from_elements"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "tensor.from_elements"(%arg0) : (index) -> tensor<1xindex>
    %2 = "tensor.extract"(%1, %0) : (tensor<1xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, tensor<*xf32>) -> index, sym_name = "extract_from_tensor.generate"}> ({
  ^bb0(%arg0: index, %arg1: tensor<*xf32>):
    %0 = "tensor.rank"(%arg1) : (tensor<*xf32>) -> index
    %1 = "tensor.generate"(%0) ({
    ^bb0(%arg2: index):
      %3 = "tensor.dim"(%arg1, %arg2) : (tensor<*xf32>, index) -> index
      "tensor.yield"(%3) : (index) -> ()
    }) : (index) -> tensor<?xindex>
    %2 = "tensor.extract"(%1, %arg0) : (tensor<?xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, tensor<*xf32>) -> index, sym_name = "extract_from_tensor.generate_2d"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<*xf32>):
    %0 = "tensor.rank"(%arg2) : (tensor<*xf32>) -> index
    %1 = "tensor.generate"(%0, %0) ({
    ^bb0(%arg3: index, %arg4: index):
      %3 = "tensor.dim"(%arg2, %arg3) : (tensor<*xf32>, index) -> index
      %4 = "tensor.dim"(%arg2, %arg4) : (tensor<*xf32>, index) -> index
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "tensor.yield"(%5) : (index) -> ()
    }) : (index, index) -> tensor<?x?xindex>
    %2 = "tensor.extract"(%1, %arg0, %arg1) : (tensor<?x?xindex>, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, tensor<*xf32>, memref<?xindex>) -> index, sym_name = "extract_from_tensor.generate_sideeffects"}> ({
  ^bb0(%arg0: index, %arg1: tensor<*xf32>, %arg2: memref<?xindex>):
    %0 = "tensor.rank"(%arg1) : (tensor<*xf32>) -> index
    %1 = "tensor.generate"(%0) ({
    ^bb0(%arg3: index):
      %3 = "tensor.dim"(%arg1, %arg3) : (tensor<*xf32>, index) -> index
      "memref.store"(%3, %arg2, %arg3) : (index, memref<?xindex>, index) -> ()
      "tensor.yield"(%3) : (index) -> ()
    }) : (index) -> tensor<?xindex>
    %2 = "tensor.extract"(%1, %arg0) : (tensor<?xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> tensor<3x?x?x7x?xindex>, sym_name = "static_tensor.generate"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 5 : index}> : () -> index
    %1 = "tensor.generate"(%arg0, %0, %arg1) ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
      %2 = "arith.constant"() <{value = 32 : index}> : () -> index
      "tensor.yield"(%2) : (index) -> ()
    }) : (index, index, index) -> tensor<3x?x?x7x?xindex>
    "func.return"(%1) : (tensor<3x?x?x7x?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3xindex>, sym_name = "from_elements.constant"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "tensor.from_elements"(%0, %1, %0) : (index, index, index) -> tensor<3xindex>
    "func.return"(%2) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index) -> tensor<?x?x?xf32>, sym_name = "slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.extract_slice"(%arg0, %0, %arg1, %1, %2, %1, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index) -> tensor<?x?xf32>, sym_name = "rank_reducing_slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.extract_slice"(%arg0, %0, %arg1, %1, %2, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 2, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index, index, index, index, index, index) -> tensor<?x?xf32>
    "func.return"(%3) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x6x16x32xi8>) -> tensor<4x6x16x32xi8>, sym_name = "trivial_slice"}> ({
  ^bb0(%arg0: tensor<4x6x16x32xi8>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0>, static_sizes = array<i64: 4, 6, 16, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<4x6x16x32xi8>) -> tensor<4x6x16x32xi8>
    "func.return"(%0) : (tensor<4x6x16x32xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x6x16x32xi8>, tensor<4x6x16x32xi8>) -> tensor<4x6x16x32xi8>, sym_name = "trivial_insert_slice"}> ({
  ^bb0(%arg0: tensor<4x6x16x32xi8>, %arg1: tensor<4x6x16x32xi8>):
    %0 = "tensor.insert_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0>, static_sizes = array<i64: 4, 6, 16, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<4x6x16x32xi8>, tensor<4x6x16x32xi8>) -> tensor<4x6x16x32xi8>
    "func.return"(%0) : (tensor<4x6x16x32xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<0x2xi8>, tensor<3x3xi8>) -> tensor<3x3xi8>, sym_name = "empty_insert_slice"}> ({
  ^bb0(%arg0: tensor<0x2xi8>, %arg1: tensor<3x3xi8>):
    %0 = "tensor.insert_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 0, 2>, static_strides = array<i64: 1, 1>}> : (tensor<0x2xi8>, tensor<3x3xi8>) -> tensor<3x3xi8>
    "func.return"(%0) : (tensor<3x3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x6x16x32xi8>) -> tensor<16x32xi8>, sym_name = "rank_reducing_tensor_of_cast"}> ({
  ^bb0(%arg0: tensor<4x6x16x32xi8>):
    %0 = "tensor.cast"(%arg0) : (tensor<4x6x16x32xi8>) -> tensor<?x?x16x32xi8>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 1, 0, 0>, static_sizes = array<i64: 1, 1, 16, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<?x?x16x32xi8>) -> tensor<16x32xi8>
    "func.return"(%1) : (tensor<16x32xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<?xf32>, sym_name = "out_of_bounds_extract_slice"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<5xf32>, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<10xf32>, sym_name = "out_of_bounds_extract_slice"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<5xf32>) -> tensor<?xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<10xf32>
    "func.return"(%1) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "out_of_bounds_insert_slice"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<10xf32>):
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "tensor.insert_slice"(%arg0, %arg1, %0) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    "func.return"(%1) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>, sym_name = "out_of_bounds_insert_slice"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<10xf32>, %arg2: index):
    %0 = "tensor.cast"(%arg0) : (tensor<5xf32>) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 7>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    "func.return"(%1) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<10xf32>, index) -> tensor<?xf32>, sym_name = "out_of_bounds_insert_slice"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<10xf32>, %arg2: index):
    %0 = "tensor.cast"(%arg1) : (tensor<10xf32>) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 7>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x32xi8>, tensor<4x6x16x32xi8>) -> tensor<4x6x16x32xi8>, sym_name = "rank_reducing_insert_slice_of_cast"}> ({
  ^bb0(%arg0: tensor<16x32xi8>, %arg1: tensor<4x6x16x32xi8>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.cast"(%arg0) : (tensor<16x32xi8>) -> tensor<?x32xi8>
    %2 = "tensor.dim"(%1, %0) : (tensor<?x32xi8>, index) -> index
    %3 = "tensor.insert_slice"(%1, %arg1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 1, 0, 0>, static_sizes = array<i64: 1, 1, -9223372036854775808, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<?x32xi8>, tensor<4x6x16x32xi8>, index) -> tensor<4x6x16x32xi8>
    "func.return"(%3) : (tensor<4x6x16x32xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "insert_slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.insert_slice"(%arg0, %arg3, %0, %arg1, %1, %2, %1, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, tensor<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2xf32, "foo">, tensor<4x4xf32, "foo">) -> tensor<4x4xf32, "foo">, sym_name = "insert_slice_canonicalize_encoding"}> ({
  ^bb0(%arg0: tensor<2x2xf32, "foo">, %arg1: tensor<4x4xf32, "foo">):
    %0 = "tensor.insert_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 2, 2>, static_strides = array<i64: 1, 1>}> : (tensor<2x2xf32, "foo">, tensor<4x4xf32, "foo">) -> tensor<4x4xf32, "foo">
    "func.return"(%0) : (tensor<4x4xf32, "foo">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "slice_to_insert_slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.extract_slice"(%arg0, %0, %arg1, %1, %2, %1, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    %4 = "tensor.insert_slice"(%3, %arg3, %0, %arg1, %1, %2, %1, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, tensor<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%4) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "rank_reducing_insert_slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.insert_slice"(%arg0, %arg3, %0, %arg1, %1, %2, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 1, 3, 2, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?x?xf32>, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>, sym_name = "rank_reducing_slice_to_insert_slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.extract_slice"(%arg0, %0, %arg1, %1, %2, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 2, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index, index, index, index, index, index) -> tensor<?x?xf32>
    %4 = "tensor.insert_slice"(%3, %arg3, %0, %arg1, %1, %2, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 1, 3, 2, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?x?xf32>, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%4) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?xi32>, tensor<i32>, index, index) -> tensor<?x?xi32>, sym_name = "insert_slice_propagate_dest_cast"}> ({
  ^bb0(%arg0: tensor<2x?xi32>, %arg1: tensor<i32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 8 : index}> : () -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<2x?xi32>, index) -> index
    %5 = "tensor.extract"(%arg1) : (tensor<i32>) -> i32
    %6 = "tensor.generate"(%arg2, %3) ({
    ^bb0(%arg4: index, %arg5: index):
      "tensor.yield"(%5) : (i32) -> ()
    }) : (index, index) -> tensor<?x?xi32>
    %7 = "tensor.insert_slice"(%arg0, %6, %arg3, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 2, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<2x?xi32>, tensor<?x?xi32>, index, index) -> tensor<?x?xi32>
    "func.return"(%7) : (tensor<?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>, tensor<i32>) -> tensor<3x9xi32>, sym_name = "insert_slice_output_dest_canonicalize"}> ({
  ^bb0(%arg0: tensor<2x3xi32>, %arg1: tensor<i32>):
    %0 = "arith.constant"() <{value = 9 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "tensor.extract"(%arg1) : (tensor<i32>) -> i32
    %3 = "tensor.generate"(%1, %0) ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%2) : (i32) -> ()
    }) : (index, index) -> tensor<?x?xi32>
    %4 = "tensor.insert_slice"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 1>, static_sizes = array<i64: 2, 3>, static_strides = array<i64: 1, 1>}> : (tensor<2x3xi32>, tensor<?x?xi32>) -> tensor<?x?xi32>
    %5 = "tensor.cast"(%4) : (tensor<?x?xi32>) -> tensor<3x9xi32>
    "func.return"(%5) : (tensor<3x9xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "dim_of_tensor.generate"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "tensor.generate"(%arg0, %arg1) ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
      "tensor.yield"(%0) : (index) -> ()
    }) : (index, index) -> tensor<2x?x4x?x5xindex>
    %2 = "tensor.dim"(%1, %0) : (tensor<2x?x4x?x5xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x?xf32>) -> (index, index), sym_name = "fold_dim_of_tensor.cast"}> ({
  ^bb0(%arg0: tensor<4x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.cast"(%arg0) : (tensor<4x?xf32>) -> tensor<?x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<?x?xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?xf32>, tensor<?x?xf32>, index, index, index, index, index, index) -> tensor<?x?xf32>, sym_name = "insert_slice_cast"}> ({
  ^bb0(%arg0: tensor<1x?xf32>, %arg1: tensor<?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
    %0 = "tensor.cast"(%arg0) : (tensor<1x?xf32>) -> tensor<?x?xf32>
    %1 = "tensor.insert_slice"(%0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index, index, index) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?xf32>, tensor<?x?xf32>, index, index, index, index, index, index) -> tensor<?x?xf32>, sym_name = "insert_slice_cast_no_fold"}> ({
  ^bb0(%arg0: tensor<1x?xf32>, %arg1: tensor<?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
    %0 = "tensor.cast"(%arg0) : (tensor<1x?xf32>) -> tensor<?x5xf32>
    %1 = "tensor.insert_slice"(%0, %arg1, %arg2, %arg3, %arg4, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 2, 1, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 5>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x5xf32>, tensor<?x?xf32>, index, index, index, index, index) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x5x?xf32>, tensor<?x?x?xf32>, index, index) -> tensor<?x?x?xf32>, sym_name = "insert_tensor_cast_on_insert_slice_src"}> ({
  ^bb0(%arg0: tensor<?x5x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 64 : index}> : () -> index
    %1 = "tensor.insert_slice"(%arg0, %arg1, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 2, 0>, static_offsets = array<i64: 0, 1, 2>, static_sizes = array<i64: -9223372036854775808, 5, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x5x?xf32>, tensor<?x?x?xf32>, index, index) -> tensor<?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<4x?x8xf32>, index, index) -> tensor<4x?x8xf32>, sym_name = "fold_extract_insert"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<4x?x8xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.insert_slice"(%arg1, %arg0, %0, %arg2, %arg3, %1) <{operandSegmentSizes = array<i32: 1, 1, 2, 1, 1>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 4, -9223372036854775808, 8>, static_strides = array<i64: 1, 1, -9223372036854775808>}> : (tensor<4x?x8xf32>, tensor<?x?x?xf32>, index, index, index, index) -> tensor<?x?x?xf32>
    %3 = "tensor.extract_slice"(%2, %0, %arg2, %arg3, %1) <{operandSegmentSizes = array<i32: 1, 2, 1, 1>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 4, -9223372036854775808, 8>, static_strides = array<i64: 1, 1, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index, index) -> tensor<4x?x8xf32>
    "func.return"(%3) : (tensor<4x?x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xindex>) -> tensor<1x2x1x1x1xf32>, sym_name = "fold_gather_constant_splat"}> ({
  ^bb0(%arg0: tensor<1x2x3xindex>):
    %0 = "arith.constant"() <{value = dense<1.000000e-01> : tensor<4x4x4xf32>}> : () -> tensor<4x4x4xf32>
    %1 = "tensor.gather"(%0, %arg0) <{gather_dims = array<i64: 0, 1, 2>}> : (tensor<4x4x4xf32>, tensor<1x2x3xindex>) -> tensor<1x2x1x1x1xf32>
    "func.return"(%1) : (tensor<1x2x1x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi32>) -> tensor<4xf32>, sym_name = "fold_reshape_constant_splat"}> ({
  ^bb0(%arg0: tensor<1xi32>):
    %0 = "arith.constant"() <{value = dense<1.000000e-01> : tensor<4x1xf32>}> : () -> tensor<4x1xf32>
    %1 = "tensor.reshape"(%0, %arg0) : (tensor<4x1xf32>, tensor<1xi32>) -> tensor<4xf32>
    "func.return"(%1) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xindex>, tensor<?xindex>, tensor<?xindex>) -> tensor<*xf32>, sym_name = "fold_reshape_chain"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xindex>, %arg2: tensor<?xindex>, %arg3: tensor<?xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %1 = "tensor.reshape"(%0, %arg2) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %2 = "tensor.reshape"(%1, %arg3) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    "func.return"(%2) : (tensor<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<1xindex>) -> tensor<?xf32>, sym_name = "fold_reshape_1d"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<1xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<?xf32>, tensor<1xindex>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<0xindex>) -> tensor<f32>, sym_name = "fold_reshape_0d"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<0xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<f32>, tensor<0xindex>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<4x4xi32>, sym_name = "fold_extract_constant_splat"}> ({
    %0 = "arith.constant"() <{value = dense<42> : tensor<1024x1024xi32>}> : () -> tensor<1024x1024xi32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<1024x1024xi32>) -> tensor<4x4xi32>
    "func.return"(%1) : (tensor<4x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<4x?x8xf32>, tensor<4x?x8xf32>, index, index) -> tensor<?x?x?xf32>, sym_name = "fold_overlapping_insert"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<4x?x8xf32>, %arg2: tensor<4x?x8xf32>, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.insert_slice"(%arg1, %arg0, %0, %arg3, %arg4, %1) <{operandSegmentSizes = array<i32: 1, 1, 2, 1, 1>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 4, -9223372036854775808, 8>, static_strides = array<i64: 1, 1, -9223372036854775808>}> : (tensor<4x?x8xf32>, tensor<?x?x?xf32>, index, index, index, index) -> tensor<?x?x?xf32>
    %3 = "tensor.insert_slice"(%arg2, %2, %arg3, %arg4, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1>, static_offsets = array<i64: 0, -9223372036854775808, 0>, static_sizes = array<i64: 4, -9223372036854775808, 8>, static_strides = array<i64: 1, 1, -9223372036854775808>}> : (tensor<4x?x8xf32>, tensor<?x?x?xf32>, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, index, index) -> tensor<?x6x4x?x5xf32>, sym_name = "compose_expand_of_expand"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (tensor<?x?xf32>, index, index) -> tensor<?x4x?xf32>
    %1 = "tensor.expand_shape"(%0, %arg3, %arg4) <{reassociation = [[0, 1], [2], [3, 4]], static_output_shape = array<i64: -9223372036854775808, 6, 4, -9223372036854775808, 5>}> : (tensor<?x4x?xf32>, index, index) -> tensor<?x6x4x?x5xf32>
    "func.return"(%1) : (tensor<?x6x4x?x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<1x1x1xf32>, sym_name = "compose_expand_of_expand_of_zero_dim"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 1, 1>}> : (tensor<1xf32>) -> tensor<1x1x1xf32>
    "func.return"(%1) : (tensor<1x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x12x32xf32>) -> tensor<?x32xf32>, sym_name = "collapse_of_cast"}> ({
  ^bb0(%arg0: tensor<8x12x32xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<8x12x32xf32>) -> tensor<?x?x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (tensor<?x?x?xf32>) -> tensor<?x?xf32>
    %2 = "tensor.cast"(%1) : (tensor<?x?xf32>) -> tensor<?x32xf32>
    "func.return"(%2) : (tensor<?x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<12x4xf32>) -> tensor<12x4xf32>, sym_name = "fold_collapse_of_expand"}> ({
  ^bb0(%arg0: tensor<12x4xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 3, 4, 4>}> : (tensor<12x4xf32>) -> tensor<3x4x4xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (tensor<3x4x4xf32>) -> tensor<12x4xf32>
    "func.return"(%1) : (tensor<12x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>, sym_name = "fold_collapse_of_expand_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (tensor<?x?xf32>, index, index) -> tensor<?x4x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (tensor<?x4x?xf32>) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, index) -> tensor<?x?xf32>, sym_name = "fold_collapse_of_expand_fully_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2, %arg3) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, index, index, index) -> tensor<?x?x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (tensor<?x?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, index, index) -> tensor<?x?x?xf32>, sym_name = "no_fold_parallel_collapse_of_expand_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2, %arg3, %arg4) <{reassociation = [[0, 1], [2], [3]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index, index) -> tensor<?x?x?x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1], [2, 3]]}> : (tensor<?x?x?x?xf32>) -> tensor<?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x4x4xf32>) -> tensor<3x4x4xf32>, sym_name = "fold_expand_of_collapse"}> ({
  ^bb0(%arg0: tensor<3x4x4xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2]]}> : (tensor<3x4x4xf32>) -> tensor<12x4xf32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 3, 4, 4>}> : (tensor<12x4xf32>) -> tensor<3x4x4xf32>
    "func.return"(%1) : (tensor<3x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x4x?xf32>, index, index) -> tensor<?x4x?xf32>, sym_name = "fold_expand_of_collapse_mixed_subshape"}> ({
  ^bb0(%arg0: tensor<?x4x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2]]}> : (tensor<?x4x?xf32>) -> tensor<?x?xf32>
    %1 = "tensor.expand_shape"(%0, %arg1, %arg2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (tensor<?x?xf32>, index, index) -> tensor<?x4x?xf32>
    "func.return"(%1) : (tensor<?x4x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x4x?x2xf32>, index, index) -> tensor<?x4x?xf32>, sym_name = "fold_expand_of_collapse_mixed_target_subshape"}> ({
  ^bb0(%arg0: tensor<?x4x?x2xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2, 3]]}> : (tensor<?x4x?x2xf32>) -> tensor<?x?xf32>
    %1 = "tensor.expand_shape"(%0, %arg1, %arg2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (tensor<?x?xf32>, index, index) -> tensor<?x4x?xf32>
    "func.return"(%1) : (tensor<?x4x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, index) -> tensor<?x?x?xf32>, sym_name = "no_fold_expand_of_collapse_fully_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2]]}> : (tensor<?x?x?xf32>) -> tensor<?x?xf32>
    %1 = "tensor.expand_shape"(%0, %arg1, %arg2, %arg3) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index) -> tensor<?x?xf32>, sym_name = "no_fold_expand_of_collapse_adjacent_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x?x?xf32>) -> tensor<?xf32>
    %1 = "tensor.expand_shape"(%0, %arg1, %arg2) <{reassociation = [[0, 1]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x64x1xf32>) -> tensor<?x384xf32>, sym_name = "compose_expand_of_collapse_last_two_dims"}> ({
  ^bb0(%arg0: tensor<?x64x1xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<?x64x1xf32>) -> tensor<?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%0, %1) : (tensor<?xf32>, index) -> index
    %3 = "arith.constant"() <{value = 384 : index}> : () -> index
    %4 = "arith.divui"(%2, %3) : (index, index) -> index
    %5 = "tensor.expand_shape"(%0, %4) <{reassociation = [[0, 1]], static_output_shape = array<i64: -9223372036854775808, 384>}> : (tensor<?xf32>, index) -> tensor<?x384xf32>
    "func.return"(%5) : (tensor<?x384xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4x5x6x7x8xf32>) -> tensor<24x5x42x8xf32>, sym_name = "compose_expand_of_collapse"}> ({
  ^bb0(%arg0: tensor<2x3x4x5x6x7x8xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2, 3, 4, 5, 6]]}> : (tensor<2x3x4x5x6x7x8xf32>) -> tensor<40320xf32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0, 1, 2, 3]], static_output_shape = array<i64: 24, 5, 42, 8>}> : (tensor<40320xf32>) -> tensor<24x5x42x8xf32>
    "func.return"(%1) : (tensor<24x5x42x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<24x5x42x8xf32>) -> tensor<2x3x4x5x6x7x8xf32>, sym_name = "compose_expand_of_collapse_7D"}> ({
  ^bb0(%arg0: tensor<24x5x42x8xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2, 3]]}> : (tensor<24x5x42x8xf32>) -> tensor<40320xf32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0, 1, 2, 3, 4, 5, 6]], static_output_shape = array<i64: 2, 3, 4, 5, 6, 7, 8>}> : (tensor<40320xf32>) -> tensor<2x3x4x5x6x7x8xf32>
    "func.return"(%1) : (tensor<2x3x4x5x6x7x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xi64>, index, index, index) -> tensor<?x?xi64>, sym_name = "compose_collapse_of_expand"}> ({
  ^bb0(%arg0: tensor<?x?x?xi64>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2, %arg3) <{reassociation = [[0], [1], [2, 3]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 1>}> : (tensor<?x?x?xi64>, index, index, index) -> tensor<?x?x?x1xi64>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1], [2, 3]]}> : (tensor<?x?x?x1xi64>) -> tensor<?x?xi64>
    "func.return"(%1) : (tensor<?x?xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2048xf32>) -> tensor<4x512xf32>, sym_name = "compose_collapse_of_expand_1D"}> ({
  ^bb0(%arg0: tensor<2048xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1, 2, 3]], static_output_shape = array<i64: 1, 4, 1, 512>}> : (tensor<2048xf32>) -> tensor<1x4x1x512xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2], [3]]}> : (tensor<1x4x1x512xf32>) -> tensor<4x512xf32>
    "func.return"(%1) : (tensor<4x512xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf16>, index, index) -> tensor<8x?x?xf16>, sym_name = "compose_collapse_of_expand_partially_dynamic"}> ({
  ^bb0(%arg0: tensor<?xf16>, %arg1: index, %arg2: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0, 1, 2, 3, 4]], static_output_shape = array<i64: 4, 2, -9223372036854775808, -9223372036854775808, 32>}> : (tensor<?xf16>, index, index) -> tensor<4x2x?x?x32xf16>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (tensor<4x2x?x?x32xf16>) -> tensor<8x?x?xf16>
    "func.return"(%1) : (tensor<8x?x?xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x1xf32>) -> tensor<1x1x1x1xf32>, sym_name = "compose_expand_of_collapse_0_rank_to_expand"}> ({
  ^bb0(%arg0: tensor<1x1x1xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = []}> : (tensor<1x1x1xf32>) -> tensor<f32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [], static_output_shape = array<i64: 1, 1, 1, 1>}> : (tensor<f32>) -> tensor<1x1x1x1xf32>
    "func.return"(%1) : (tensor<1x1x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x1x1xf32>) -> tensor<1x1x1xf32>, sym_name = "compose_expand_of_collapse_0_rank_to_collapse"}> ({
  ^bb0(%arg0: tensor<1x1x1x1xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = []}> : (tensor<1x1x1x1xf32>) -> tensor<f32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [], static_output_shape = array<i64: 1, 1, 1>}> : (tensor<f32>) -> tensor<1x1x1xf32>
    "func.return"(%1) : (tensor<1x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x32x10x64x2xf16>) -> tensor<4x32x10x128xf16>, sym_name = "compose_expand_of_collapse_static"}> ({
  ^bb0(%arg0: tensor<4x32x10x64x2xf16>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (tensor<4x32x10x64x2xf16>) -> tensor<128x10x128xf16>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0, 1], [2], [3]], static_output_shape = array<i64: 4, 32, 10, 128>}> : (tensor<128x10x128xf16>) -> tensor<4x32x10x128xf16>
    "func.return"(%1) : (tensor<4x32x10x128xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x?x10x64x2xf16>, index) -> tensor<4x?x10x128xf16>, sym_name = "compose_expand_of_collapse_dynamic"}> ({
  ^bb0(%arg0: tensor<4x?x10x64x2xf16>, %arg1: index):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (tensor<4x?x10x64x2xf16>) -> tensor<?x10x128xf16>
    %1 = "tensor.expand_shape"(%0, %arg1) <{reassociation = [[0, 1], [2], [3]], static_output_shape = array<i64: 4, -9223372036854775808, 10, 128>}> : (tensor<?x10x128xf16>, index) -> tensor<4x?x10x128xf16>
    "func.return"(%1) : (tensor<4x?x10x128xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x8x128x?xf16>, index) -> tensor<?x128x?xf16>, sym_name = "no_compose_collapse_of_expand_dynamic"}> ({
  ^bb0(%arg0: tensor<?x8x128x?xf16>, %arg1: index):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2, 3]]}> : (tensor<?x8x128x?xf16>) -> tensor<?xf16>
    %1 = "tensor.expand_shape"(%0, %arg1, %arg1) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: -9223372036854775808, 8, -9223372036854775808>}> : (tensor<?xf16>, index, index) -> tensor<?x128x?xf16>
    "func.return"(%1) : (tensor<?x128x?xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "zero_rank_reshape_multi"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1>}> : (tensor<1xf32>) -> tensor<1x1xf32>
    %2 = "tensor.collapse_shape"(%1) <{reassociation = []}> : (tensor<1x1xf32>) -> tensor<f32>
    "func.return"(%2) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?x?xf32>) -> tensor<?x?xf32>, sym_name = "compose_collapse_of_collapse"}> ({
  ^bb0(%arg0: tensor<?x?x?x?x?xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (tensor<?x?x?x?x?xf32>) -> tensor<?x?x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (tensor<?x?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x1xf32>) -> tensor<f32>, sym_name = "compose_collapse_of_collapse_zero_dim"}> ({
  ^bb0(%arg0: tensor<1x1x1xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2]]}> : (tensor<1x1x1xf32>) -> tensor<1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = []}> : (tensor<1xf32>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x512xf32>) -> tensor<2048xf32>, sym_name = "fold_collapse_of_expand_1D"}> ({
  ^bb0(%arg0: tensor<4x512xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1, 2], [3]], static_output_shape = array<i64: 1, 4, 1, 512>}> : (tensor<4x512xf32>) -> tensor<1x4x1x512xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2, 3]]}> : (tensor<1x4x1x512xf32>) -> tensor<2048xf32>
    "func.return"(%1) : (tensor<2048xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2048x1x1xf32>) -> tensor<4x512x1x1xf32>, sym_name = "fold_collapse_of_expand_unit_dims"}> ({
  ^bb0(%arg0: tensor<2048x1x1xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1, 2, 3], [4], [5]], static_output_shape = array<i64: 1, 4, 1, 512, 1, 1>}> : (tensor<2048x1x1xf32>) -> tensor<1x4x1x512x1x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2], [3], [4], [5]]}> : (tensor<1x4x1x512x1x1xf32>) -> tensor<4x512x1x1xf32>
    "func.return"(%1) : (tensor<4x512x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2048x1x2048xf32>) -> tensor<4x512x1x512x4xf32>, sym_name = "compose_collapse_of_expand_unit_dims"}> ({
  ^bb0(%arg0: tensor<2048x1x2048xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1, 2, 3, 4], [5], [6, 7, 8]], static_output_shape = array<i64: 1, 4, 1, 512, 1, 1, 512, 1, 4>}> : (tensor<2048x1x2048xf32>) -> tensor<1x4x1x512x1x1x512x1x4xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2], [3, 4], [5], [6, 7], [8]]}> : (tensor<1x4x1x512x1x1x512x1x4xf32>) -> tensor<4x512x1x512x4xf32>
    "func.return"(%1) : (tensor<4x512x1x512x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>) -> tensor<2x1xf32>, sym_name = "compose_collapse_of_expand_trailing_unit_dims"}> ({
  ^bb0(%arg0: tensor<2xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, 1, 1>}> : (tensor<2xf32>) -> tensor<2x1x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2]]}> : (tensor<2x1x1xf32>) -> tensor<2x1xf32>
    "func.return"(%1) : (tensor<2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1x?x1x1x?x?x1x1xf32>) -> tensor<?x?x?x?xf32>, sym_name = "compose_collapse_of_collapse_unit_dims_dynamic"}> ({
  ^bb0(%arg0: tensor<?x1x?x1x1x?x?x1x1xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2], [3], [4], [5], [6, 7, 8]]}> : (tensor<?x1x?x1x1x?x?x1x1xf32>) -> tensor<?x?x1x1x?x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1], [2, 3, 4], [5]]}> : (tensor<?x?x1x1x?x?xf32>) -> tensor<?x?x?x?xf32>
    "func.return"(%1) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>) -> tensor<2x1xf32>, sym_name = "fold_collapse_of_expand_trailing_unit_dims"}> ({
  ^bb0(%arg0: tensor<2xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, 1, 1>}> : (tensor<2xf32>) -> tensor<2x1x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2]]}> : (tensor<2x1x1xf32>) -> tensor<2x1xf32>
    "func.return"(%1) : (tensor<2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x?x1x1x1xf32>) -> tensor<?xf32>, sym_name = "fold_collapse_of_collapse_trailing_unit_dims_dynamic"}> ({
  ^bb0(%arg0: tensor<1x1x?x1x1x1xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1, 2], [3], [4], [5]]}> : (tensor<1x1x?x1x1x1xf32>) -> tensor<?x1x1x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2, 3]]}> : (tensor<?x1x1x1xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<12x42x1x1xf32>) -> tensor<12x42xf32>, sym_name = "fold_collapse_of_expand_trailing_unit_dims"}> ({
  ^bb0(%arg0: tensor<12x42x1x1xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0], [1], [2], [3, 4]], static_output_shape = array<i64: 12, 42, 1, 1, 1>}> : (tensor<12x42x1x1xf32>) -> tensor<12x42x1x1x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2, 3, 4]]}> : (tensor<12x42x1x1x1xf32>) -> tensor<12x42xf32>
    "func.return"(%1) : (tensor<12x42xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, index) -> tensor<?x?xf32>, sym_name = "fold_collapse_of_expand_unit_dims_in_middle"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2, %arg3) <{reassociation = [[0], [1], [2, 3]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, 1, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index) -> tensor<?x?x1x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2, 3]]}> : (tensor<?x?x1x?xf32>) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x6x8xf32>) -> tensor<2x6x16xf32>, sym_name = "no_fold_collapse_of_expand_incompatible"}> ({
  ^bb0(%arg0: tensor<4x6x8xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1], [2, 3], [4]], static_output_shape = array<i64: 2, 2, 3, 2, 8>}> : (tensor<4x6x8xf32>) -> tensor<2x2x3x2x8xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2], [3, 4]]}> : (tensor<2x2x3x2x8xf32>) -> tensor<2x6x16xf32>
    "func.return"(%1) : (tensor<2x6x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2x2xf32>) -> tensor<12x1xf32>, sym_name = "no_fold_collapse_of_expand_empty_expr"}> ({
  ^bb0(%arg0: tensor<3x2x2xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0], [1], [2, 3]], static_output_shape = array<i64: 3, 2, 2, 1>}> : (tensor<3x2x2xf32>) -> tensor<3x2x2x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2], [3]]}> : (tensor<3x2x2x1xf32>) -> tensor<12x1xf32>
    "func.return"(%1) : (tensor<12x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2x4x2xi32>, sym_name = "reshape_splat_constant_int32"}> ({
    %0 = "arith.constant"() <{value = dense<42> : tensor<2x8xi32>}> : () -> tensor<2x8xi32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 2, 4, 2>}> : (tensor<2x8xi32>) -> tensor<2x4x2xi32>
    "func.return"(%1) : (tensor<2x4x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<2x2x2xf32>, sym_name = "expand_shape_splat"}> ({
  ^bb0(%arg0: f32):
    %0 = "tensor.splat"(%arg0) : (f32) -> tensor<2x4xf32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 2, 2, 2>}> : (tensor<2x4xf32>) -> tensor<2x2x2xf32>
    "func.return"(%1) : (tensor<2x2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> tensor<2x2x?xf32>, sym_name = "expand_shape_splat_dynamic_no_fold"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "tensor.splat"(%arg0, %arg1) : (f32, index) -> tensor<2x?xf32>
    %1 = "tensor.expand_shape"(%0, %arg2) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 2, 2, -9223372036854775808>}> : (tensor<2x?xf32>, index) -> tensor<2x2x?xf32>
    "func.return"(%1) : (tensor<2x2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<2x4xf32>, sym_name = "collapse_shape_splat"}> ({
  ^bb0(%arg0: f32):
    %0 = "tensor.splat"(%arg0) : (f32) -> tensor<2x2x2xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2]]}> : (tensor<2x2x2xf32>) -> tensor<2x4xf32>
    "func.return"(%1) : (tensor<2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index) -> tensor<2x?xf32>, sym_name = "collapse_shape_splat_dynamic_no_fold"}> ({
  ^bb0(%arg0: f32, %arg1: index):
    %0 = "tensor.splat"(%arg0, %arg1) : (f32, index) -> tensor<2x2x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2]]}> : (tensor<2x2x?xf32>) -> tensor<2x?xf32>
    "func.return"(%1) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2x4x2xi16>, sym_name = "reshape_splat_constant_int16"}> ({
    %0 = "arith.constant"() <{value = dense<42> : tensor<2x8xi16>}> : () -> tensor<2x8xi16>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 2, 4, 2>}> : (tensor<2x8xi16>) -> tensor<2x4x2xi16>
    "func.return"(%1) : (tensor<2x4x2xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2x4x2xf32>, sym_name = "reshape_splat_constant_float32"}> ({
    %0 = "arith.constant"() <{value = dense<4.200000e+01> : tensor<2x8xf32>}> : () -> tensor<2x8xf32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 2, 4, 2>}> : (tensor<2x8xf32>) -> tensor<2x4x2xf32>
    "func.return"(%1) : (tensor<2x4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2x4x2xf64>, sym_name = "reshape_splat_constant_float64"}> ({
    %0 = "arith.constant"() <{value = dense<4.200000e+01> : tensor<2x8xf64>}> : () -> tensor<2x8xf64>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 2, 4, 2>}> : (tensor<2x8xf64>) -> tensor<2x4x2xf64>
    "func.return"(%1) : (tensor<2x4x2xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "fold_rank"}> ({
    %0 = "arith.constant"() <{value = dense<[[[1, -2, 1, 36]], [[0, 2, -1, 64]]]> : tensor<2x1x4xi32>}> : () -> tensor<2x1x4xi32>
    %1 = "tensor.rank"(%0) : (tensor<2x1x4xi32>) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x6xf32>, index) -> tensor<5x6xf32>, sym_name = "pad_same_static_shape"}> ({
  ^bb0(%arg0: tensor<5x6xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.pad"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, -9223372036854775808>, static_low = array<i64: -9223372036854775808, 0>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<5x6xf32>, index, index) -> tensor<5x6xf32>
    "func.return"(%1) : (tensor<5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x64x?x?xf32>) -> tensor<?x?x?x?xf32>, sym_name = "pad_fold_static"}> ({
  ^bb0(%arg0: tensor<?x64x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.pad"(%arg0, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, -9223372036854775808, 1, 1>, static_low = array<i64: 0, -9223372036854775808, 1, 1>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<?x64x?x?xf32>, index, index) -> tensor<?x?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x6xf32>, index) -> tensor<5x6xf32>, sym_name = "pad_nofold_same_static_shape"}> ({
  ^bb0(%arg0: tensor<5x6xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.pad"(%arg0, %arg1, %arg1) <{nofold, operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, -9223372036854775808>, static_low = array<i64: -9223372036854775808, 0>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<5x6xf32>, index, index) -> tensor<5x6xf32>
    "func.return"(%1) : (tensor<5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x64x?x?xf32>) -> tensor<?x?x?x?xf32>, sym_name = "pad_after_cast_different_shape"}> ({
  ^bb0(%arg0: tensor<?x64x?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.cast"(%arg0) : (tensor<?x64x?x?xf32>) -> tensor<?x?x?x?xf32>
    %2 = "tensor.pad"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 0, 1, 1>, static_low = array<i64: 0, 0, 1, 1>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    "func.return"(%2) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x64x?x?xf32>, index) -> tensor<?x?x?x?xf32>, sym_name = "pad_after_cast_same_shape"}> ({
  ^bb0(%arg0: tensor<?x64x?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.cast"(%arg0) : (tensor<?x64x?x?xf32>) -> tensor<?x?x?x?xf32>
    %2 = "tensor.pad"(%1, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, -9223372036854775808, 1, 1>, static_low = array<i64: 0, -9223372036854775808, 1, 1>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x?x?x?xf32>, index, index) -> tensor<?x?x?x?xf32>
    "func.return"(%2) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x?xf32>, index) -> tensor<8x32xf32>, sym_name = "pad_of_cast"}> ({
  ^bb0(%arg0: tensor<8x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.cast"(%arg0) : (tensor<8x?xf32>) -> tensor<?x?xf32>
    %3 = "tensor.pad"(%2, %0, %0, %0, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<?x?xf32>, index, index, index, index) -> tensor<8x32xf32>
    "func.return"(%3) : (tensor<8x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index) -> tensor<32x32xf32>, sym_name = "cast_of_pad_more_static"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.pad"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 0>, static_high = array<i64: 0, 0>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %2 = "tensor.cast"(%1) : (tensor<?x?xf32>) -> tensor<32x32xf32>
    "func.return"(%2) : (tensor<32x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<32x?x?xf32>, index) -> tensor<?x32x32xf32>, sym_name = "cast_of_pad_less_static"}> ({
  ^bb0(%arg0: tensor<32x?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.pad"(%arg0, %arg1, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 3, 0>, static_high = array<i64: 0, 0, 0>, static_low = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<32x?x?xf32>, index, index, index) -> tensor<32x?x?xf32>
    %2 = "tensor.cast"(%1) : (tensor<32x?x?xf32>) -> tensor<?x32x32xf32>
    "func.return"(%2) : (tensor<?x32x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>) -> tensor<4x4xf32>, sym_name = "pad_cast_fold"}> ({
  ^bb0(%arg0: tensor<4x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.cast"(%arg0) : (tensor<4x4xf32>) -> tensor<?x?xf32>
    %3 = "tensor.pad"(%2, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<?x?xf32>, index, index, index, index) -> tensor<4x4xf32>
    "func.return"(%3) : (tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x?xf32>) -> tensor<4x4xf32>, sym_name = "fold_pad_source_cast"}> ({
  ^bb0(%arg0: tensor<4x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.cast"(%arg0) : (tensor<4x?xf32>) -> tensor<?x?xf32>
    %2 = "tensor.pad"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x?xf32>) -> tensor<4x4xf32>
    "func.return"(%2) : (tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, f32) -> tensor<2x3x4xf32>, sym_name = "pad_static_zero_cast"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.pad"(%arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, 0, -9223372036854775808>, static_low = array<i64: 0, -9223372036854775808, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : (tensor<?x?x?xf32>, index, index) -> tensor<2x3x4xf32>
    "func.return"(%1) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, f32) -> tensor<2x3x4xf32>, sym_name = "pad_nofold_static_zero"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.pad"(%arg0, %0, %0) <{nofold, operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, 0, -9223372036854775808>, static_low = array<i64: 0, -9223372036854775808, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : (tensor<?x?x?xf32>, index, index) -> tensor<2x3x4xf32>
    "func.return"(%1) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<64x64xf32>, index, index, index, index) -> tensor<8x4xf32>, sym_name = "fold_orthogonal_pad_chains"}> ({
  ^bb0(%arg0: tensor<64x64xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 16, 0>, static_sizes = array<i64: -9223372036854775808, 64>, static_strides = array<i64: 1, 1>}> : (tensor<64x64xf32>, index) -> tensor<?x64xf32>
    %2 = "tensor.pad"(%1, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: -9223372036854775808, 0>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg7: index, %arg8: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x64xf32>, index) -> tensor<8x64xf32>
    %3 = "tensor.extract_slice"(%2, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 4>, static_sizes = array<i64: 8, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index) -> tensor<8x?xf32>
    %4 = "tensor.pad"(%3, %arg4) <{nofold, operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: 0, -9223372036854775808>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg5: index, %arg6: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<8x?xf32>, index) -> tensor<8x4xf32>
    "func.return"(%4) : (tensor<8x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<64x64xf32>, index, index, index, index) -> (tensor<8x4xf32>, tensor<4x64xf32>, tensor<8x4xf32>, tensor<6x4xf32>), sym_name = "dont_fold_pad_chains"}> ({
  ^bb0(%arg0: tensor<64x64xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 16, 0>, static_sizes = array<i64: -9223372036854775808, 64>, static_strides = array<i64: 1, 1>}> : (tensor<64x64xf32>, index) -> tensor<?x64xf32>
    %2 = "tensor.pad"(%1, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: -9223372036854775808, 0>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg13: index, %arg14: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x64xf32>, index) -> tensor<8x64xf32>
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "tensor.extract_slice"(%2, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 4>, static_sizes = array<i64: 8, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index) -> tensor<8x?xf32>
    %5 = "tensor.pad"(%4, %arg4) <{nofold, operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: 0, -9223372036854775808>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg11: index, %arg12: index):
      "tensor.yield"(%3) : (f32) -> ()
    }) : (tensor<8x?xf32>, index) -> tensor<8x4xf32>
    %6 = "tensor.extract_slice"(%2, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 4, 0>, static_sizes = array<i64: -9223372036854775808, 64>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index) -> tensor<?x64xf32>
    %7 = "tensor.pad"(%6, %arg4) <{nofold, operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: -9223372036854775808, 0>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg9: index, %arg10: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x64xf32>, index) -> tensor<4x64xf32>
    %8 = "tensor.extract_slice"(%2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 4>, static_sizes = array<i64: 8, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index, index) -> tensor<8x?xf32>
    %9 = "tensor.pad"(%8, %arg4) <{nofold, operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: 0, -9223372036854775808>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg7: index, %arg8: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<8x?xf32>, index) -> tensor<8x4xf32>
    %10 = "tensor.extract_slice"(%2, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 4>, static_sizes = array<i64: 6, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index) -> tensor<6x?xf32>
    %11 = "tensor.pad"(%10, %arg4) <{nofold, operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: 0, -9223372036854775808>, static_low = array<i64: 0, 0>}> ({
    ^bb0(%arg5: index, %arg6: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<6x?xf32>, index) -> tensor<6x4xf32>
    "func.return"(%5, %7, %9, %11) : (tensor<8x4xf32>, tensor<4x64xf32>, tensor<8x4xf32>, tensor<6x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, f32) -> tensor<7x8xf32>, sym_name = "merge_constant_padding"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: f32):
    %0 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 1, 0>, static_low = array<i64: 1, 1>}> ({
    ^bb0(%arg4: index, %arg5: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : (tensor<2x3xf32>) -> tensor<4x4xf32>
    %1 = "tensor.pad"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 3, 2>, static_low = array<i64: 0, 2>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : (tensor<4x4xf32>) -> tensor<7x8xf32>
    "func.return"(%1) : (tensor<7x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, f32) -> tensor<?x?xf32>, sym_name = "merge_constant_padding_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: f32):
    %0 = "tensor.pad"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_high = array<i64: 1, 0>, static_low = array<i64: -9223372036854775808, 1>}> ({
    ^bb0(%arg5: index, %arg6: index):
      "tensor.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, index) -> tensor<?x?xf32>
    %1 = "tensor.pad"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_high = array<i64: -9223372036854775808, 2>, static_low = array<i64: 0, 2>}> ({
    ^bb0(%arg3: index, %arg4: index):
      "tensor.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, index) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, f32) -> tensor<7x8xf32>, sym_name = "dont_merge_constant_padding_nofold"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: f32):
    %0 = "tensor.pad"(%arg0) <{nofold, operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 1, 0>, static_low = array<i64: 1, 1>}> ({
    ^bb0(%arg4: index, %arg5: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : (tensor<2x3xf32>) -> tensor<4x4xf32>
    %1 = "tensor.pad"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 3, 2>, static_low = array<i64: 0, 2>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : (tensor<4x4xf32>) -> tensor<7x8xf32>
    "func.return"(%1) : (tensor<7x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, f32, f32) -> tensor<7x8xf32>, sym_name = "dont_merge_constant_padding_different_vals"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: f32, %arg2: f32):
    %0 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 1, 0>, static_low = array<i64: 1, 1>}> ({
    ^bb0(%arg5: index, %arg6: index):
      "tensor.yield"(%arg1) : (f32) -> ()
    }) : (tensor<2x3xf32>) -> tensor<4x4xf32>
    %1 = "tensor.pad"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 3, 2>, static_low = array<i64: 0, 2>}> ({
    ^bb0(%arg3: index, %arg4: index):
      "tensor.yield"(%arg2) : (f32) -> ()
    }) : (tensor<4x4xf32>) -> tensor<7x8xf32>
    "func.return"(%1) : (tensor<7x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> tensor<i32>, sym_name = "fold_collapse_shape_from_elements"}> ({
  ^bb0(%arg0: i32):
    %0 = "tensor.from_elements"(%arg0) : (i32) -> tensor<1xi32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = []}> : (tensor<1xi32>) -> tensor<i32>
    "func.return"(%1) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> tensor<1xi32>, sym_name = "fold_expand_shape_from_elements"}> ({
  ^bb0(%arg0: i32):
    %0 = "tensor.from_elements"(%arg0) : (i32) -> tensor<i32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<i32>) -> tensor<1xi32>
    "func.return"(%1) : (tensor<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi32>) -> index, sym_name = "propagate_index_cast"}> ({
  ^bb0(%arg0: tensor<1xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.index_cast"(%arg0) : (tensor<1xi32>) -> tensor<1xindex>
    %2 = "tensor.extract"(%1, %0) : (tensor<1xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<4xf32>, sym_name = "splat_fold"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "tensor.splat"(%0) : (f32) -> tensor<4xf32>
    "func.return"(%1) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<4x?xf32>, sym_name = "splat_dynamic_no_fold"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "tensor.splat"(%0, %arg0) : (f32, index) -> tensor<4x?xf32>
    "func.return"(%1) : (tensor<4x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x512xf32>, index, index) -> tensor<16x512xf32>, sym_name = "cast_extract_slice"}> ({
  ^bb0(%arg0: tensor<128x512xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 512>, static_strides = array<i64: 1, 1>}> : (tensor<128x512xf32>, index, index) -> tensor<?x512xf32>
    %1 = "tensor.cast"(%0) : (tensor<?x512xf32>) -> tensor<16x512xf32>
    "func.return"(%1) : (tensor<16x512xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x512xf32>, index, index) -> tensor<16xf32>, sym_name = "cast_extract_slice_rank_reduce"}> ({
  ^bb0(%arg0: tensor<128x512xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (tensor<128x512xf32>, index, index) -> tensor<?xf32>
    %1 = "tensor.cast"(%0) : (tensor<?xf32>) -> tensor<16xf32>
    "func.return"(%1) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5xf32>, tensor<?x?xf32>, index) -> tensor<?x?xf32>, sym_name = "canonicalize_parallel_insert_slice_indices"}> ({
  ^bb0(%arg0: tensor<1x5xf32>, %arg1: tensor<?x?xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "scf.forall"(%arg2, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg3: index, %arg4: tensor<?x?xf32>):
      %4 = "tensor.cast"(%arg0) : (tensor<1x5xf32>) -> tensor<?x5xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg4, %arg3, %1, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 2, 1, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 5>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x5xf32>, tensor<?x?xf32>, index, index, index, index, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%3) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x2x4xf32>) -> tensor<1x2x2x4xf32>, sym_name = "fold_insert_slice_after_extract_slice"}> ({
  ^bb0(%arg0: tensor<1x2x2x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0>, static_sizes = array<i64: 1, 1, 2, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x2x2x4xf32>) -> tensor<1x2x4xf32>
    %2 = "tensor.insert_slice"(%1, %arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 2, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x2x4xf32>, tensor<1x2x2x4xf32>, index, index) -> tensor<1x2x2x4xf32>
    "func.return"(%2) : (tensor<1x2x2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x2x4xf32>, tensor<1x2x2x4xf32>) -> tensor<1x2x2x4xf32>, sym_name = "dont_fold_mismatched_source_dst"}> ({
  ^bb0(%arg0: tensor<1x2x2x4xf32>, %arg1: tensor<1x2x2x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0>, static_sizes = array<i64: 1, 1, 2, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x2x2x4xf32>) -> tensor<1x2x4xf32>
    %2 = "tensor.insert_slice"(%1, %arg1, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 2, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x2x4xf32>, tensor<1x2x2x4xf32>, index, index) -> tensor<1x2x2x4xf32>
    "func.return"(%2) : (tensor<1x2x2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x2x4xf32>) -> tensor<1x2x2x4xf32>, sym_name = "dont_fold_mismatched_parameters"}> ({
  ^bb0(%arg0: tensor<1x2x2x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0>, static_sizes = array<i64: 1, 1, 2, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x2x2x4xf32>) -> tensor<1x2x4xf32>
    %2 = "tensor.insert_slice"(%1, %arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, 1, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 2, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x2x4xf32>, tensor<1x2x2x4xf32>, index, index) -> tensor<1x2x2x4xf32>
    "func.return"(%2) : (tensor<1x2x2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<4x5x?xf32>, sym_name = "empty_canonicalize"}> ({
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "tensor.empty"(%0) : (index) -> tensor<4x5x?xf32>
    "func.return"(%1) : (tensor<4x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<1x12xf32>, sym_name = "fold_empty_tensor_with_cast"}> ({
  ^bb0(%arg0: index):
    %0 = "tensor.empty"(%arg0) : (index) -> tensor<?x12xf32>
    %1 = "tensor.cast"(%0) : (tensor<?x12xf32>) -> tensor<1x12xf32>
    "func.return"(%1) : (tensor<1x12xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "some_use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "empty_tensor_canonicalize"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.empty"(%arg0) : (index) -> tensor<?x42xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x42xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<?x42xf32>, index) -> index
    "func.call"(%3, %4) <{callee = @some_use}> : (index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index) -> index, sym_name = "dim_of_expand_shape"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "tensor.expand_shape"(%arg0, %arg1, %arg2) <{reassociation = [[0], [1, 2, 3, 4, 5]], static_output_shape = array<i64: -9223372036854775808, 1, -9223372036854775808, 5, 1, 8>}> : (tensor<?x?xf32>, index, index) -> tensor<?x1x?x5x1x8xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<?x1x?x5x1x8xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x7x?xf32>) -> index, sym_name = "dim_of_collapse_shape"}> ({
  ^bb0(%arg0: tensor<?x?x?x7x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2, 3, 4]]}> : (tensor<?x?x?x7x?xf32>) -> tensor<?x?xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<?x?xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x7x?xf32>) -> index, sym_name = "out_of_bound_dim_of_collapse_shape"}> ({
  ^bb0(%arg0: tensor<?x?x?x7x?xf32>):
    %0 = "arith.constant"() <{value = 5 : index}> : () -> index
    %1 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2, 3, 4]]}> : (tensor<?x?x?x7x?xf32>) -> tensor<?x?xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<?x?xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "collapse_expand_fold_to_cast"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, -9223372036854775808>}> : (tensor<?xf32>, index) -> tensor<1x?xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1]]}> : (tensor<1x?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<4x5x?xf32>, sym_name = "invalid_empty_negative_size"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "index.sub"(%0, %1) : (index, index) -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<4x5x?xf32>
    "func.return"(%3) : (tensor<4x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "invalid_slice_ops"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "arith.constant"() <{value = -5 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "tensor.insert_slice"(%1, %arg1, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 mod 64 - 8)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<?x8xi32>, sym_name = "generate_negative_size_verifies"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "affine.max"(%1) <{map = #map}> : (index) -> index
    %3 = "tensor.generate"(%2) ({
    ^bb0(%arg0: index, %arg1: index):
      "tensor.yield"(%0) : (i32) -> ()
    }) : (index) -> tensor<?x8xi32>
    "func.return"(%3) : (tensor<?x8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xindex>) -> index, sym_name = "dim_of_reshape"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %2 = "tensor.insert"(%0, %arg1, %0) : (index, tensor<?xindex>, index) -> tensor<?xindex>
    %3 = "tensor.dim"(%1, %0) : (tensor<*xf32>, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xi32>) -> index, sym_name = "dim_of_reshape_i32"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xi32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xi32>) -> tensor<*xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<*xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xindex>) -> index, sym_name = "dim_of_reshape_for"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %4 = "scf.for"(%0, %2, %1, %1) ({
    ^bb0(%arg2: index, %arg3: index):
      %5 = "tensor.dim"(%3, %arg2) : (tensor<*xf32>, index) -> index
      %6 = "arith.muli"(%arg3, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%6) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xindex>, index) -> index, sym_name = "dim_of_reshape_undominated"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xindex>, %arg2: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %2 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "tensor.dim"(%1, %2) : (tensor<*xf32>, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xi32>) -> tensor<?x?xi32>, sym_name = "reshape_fold_2d"}> ({
  ^bb0(%arg0: tensor<?x?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?x?xi32>, index) -> index
    %3 = "tensor.dim"(%arg0, %1) : (tensor<?x?xi32>, index) -> index
    %4 = "tensor.from_elements"(%2, %3) : (index, index) -> tensor<2xindex>
    %5 = "tensor.reshape"(%arg0, %4) : (tensor<?x?xi32>, tensor<2xindex>) -> tensor<?x?xi32>
    "func.return"(%5) : (tensor<?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xi32>) -> tensor<?x?xi32>, sym_name = "reshape_nofold_2d"}> ({
  ^bb0(%arg0: tensor<?x?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?x?xi32>, index) -> index
    %3 = "tensor.dim"(%arg0, %1) : (tensor<?x?xi32>, index) -> index
    %4 = "tensor.from_elements"(%3, %2) : (index, index) -> tensor<2xindex>
    %5 = "tensor.reshape"(%arg0, %4) : (tensor<?x?xi32>, tensor<2xindex>) -> tensor<?x?xi32>
    "func.return"(%5) : (tensor<?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xi32>, index, index) -> tensor<?x?xi32>, sym_name = "reshape_nofold_2d_ins"}> ({
  ^bb0(%arg0: tensor<?x?xi32>, %arg1: index, %arg2: index):
    %0 = "tensor.from_elements"(%arg1, %arg2) : (index, index) -> tensor<2xindex>
    %1 = "tensor.reshape"(%arg0, %0) : (tensor<?x?xi32>, tensor<2xindex>) -> tensor<?x?xi32>
    "func.return"(%1) : (tensor<?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x?x?xi32>) -> tensor<5x?x?xi32>, sym_name = "reshape_fold_3d_cst"}> ({
  ^bb0(%arg0: tensor<5x?x?xi32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %0) : (tensor<5x?x?xi32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<5x?x?xi32>, index) -> index
    %5 = "tensor.from_elements"(%2, %3, %4) : (index, index, index) -> tensor<3xindex>
    %6 = "tensor.reshape"(%arg0, %5) : (tensor<5x?x?xi32>, tensor<3xindex>) -> tensor<5x?x?xi32>
    "func.return"(%6) : (tensor<5x?x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<7xi32>, sym_name = "dim_out_of_bounds"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "index.constant"() <{value = 28 : index}> : () -> index
    %2 = "arith.constant"() <{value = 29 : index}> : () -> index
    %3 = "bufferization.alloc_tensor"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xi16>
    %4 = "tensor.dim"(%3, %1) : (tensor<?xi16>, index) -> index
    %5 = "memref.alloc"(%2) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?x26x2xi32>
    %6 = "affine.vector_load"(%5, %0, %4) <{map = #map}> : (memref<?x26x2xi32>, index, index) -> vector<7xi32>
    "func.return"(%6) : (vector<7xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2xf32>, tensor<2x2xf32>) -> index, sym_name = "fold_cast_multiple_results"}> ({
  ^bb0(%arg0: tensor<2x2xf32>, %arg1: tensor<2x2xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<2x2xf32>) -> tensor<?x2xf32>
    %1 = "tensor.cast"(%arg1) : (tensor<2x2xf32>) -> tensor<?x2xf32>
    %2:2 = "test.destination_style_op"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<?x2xf32>, tensor<?x2xf32>) -> (tensor<?x2xf32>, index)
    "func.return"(%2#1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x10xf32>) -> tensor<10x1x10xf32>, sym_name = "fold_expand_of_cast"}> ({
  ^bb0(%arg0: tensor<10x10xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "tensor.cast"(%arg0) : (tensor<10x10xf32>) -> tensor<?x?xf32>
    %3 = "tensor.expand_shape"(%2, %1, %0, %1) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, index, index, index) -> tensor<?x?x?xf32>
    %4 = "tensor.cast"(%3) : (tensor<?x?x?xf32>) -> tensor<10x1x10xf32>
    "func.return"(%4) : (tensor<10x1x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>) -> tensor<?x?x?xf32>, sym_name = "sink_expand_of_cast"}> ({
  ^bb0(%arg0: tensor<?x10xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "tensor.cast"(%arg0) : (tensor<?x10xf32>) -> tensor<?x?xf32>
    %3 = "tensor.expand_shape"(%2, %1, %0, %1) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x10xf32>, index, index) -> tensor<?x?x?xf32>, sym_name = "partial_sink_expand_of_cast"}> ({
  ^bb0(%arg0: tensor<10x10xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "tensor.cast"(%arg0) : (tensor<10x10xf32>) -> tensor<?x?xf32>
    %2 = "tensor.expand_shape"(%1, %arg1, %arg2, %0) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%2) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

