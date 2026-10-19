#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xf32>, tensor<1x3x6xf32>) -> tensor<1x5x6xf32>, sym_name = "matmul"}> ({
  ^bb0(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x6xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.empty"() : () -> tensor<1x5x6xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    %5 = "linalg.batch_matmul"(%arg0, %arg1, %4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %6 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg4, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<1x5x3xf32>, tensor<1x3x6xf32>, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    "func.return"(%5) : (tensor<1x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> ()>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xi8>, tensor<1x3x6xi8>) -> tensor<1x5x6xi32>, sym_name = "matmul_quantized"}> ({
  ^bb0(%arg0: tensor<1x5x3xi8>, %arg1: tensor<1x3x6xi8>):
    %0 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<2> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "tensor.empty"() : () -> tensor<1x5x6xi32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<1x5x6xi32>) -> tensor<1x5x6xi32>
    %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %7 = "linalg.quantized_batch_matmul"(%arg0, %arg1, %5, %6, %4) <{operandSegmentSizes = array<i32: 4, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8, %arg4: i32, %arg5: i32, %arg6: i32):
      %8 = "arith.extsi"(%arg2) : (i8) -> i32
      %9 = "arith.subi"(%8, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.extsi"(%arg3) : (i8) -> i32
      %11 = "arith.subi"(%10, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "arith.muli"(%9, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "arith.addi"(%arg6, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2, #map2, #map3]} : (tensor<1x5x3xi8>, tensor<1x3x6xi8>, i32, i32, tensor<1x5x6xi32>) -> tensor<1x5x6xi32>
    "func.return"(%7) : (tensor<1x5x6xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x5x3xf32>, tensor<?x3x6xf32>) -> tensor<?x5x6xf32>, sym_name = "matmul_dyn_batch"}> ({
  ^bb0(%arg0: tensor<?x5x3xf32>, %arg1: tensor<?x3x6xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x5x3xf32>, index) -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"(%3) : (index) -> tensor<?x5x6xf32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<?x5x6xf32>) -> tensor<?x5x6xf32>
    %7 = "linalg.batch_matmul"(%arg0, %arg1, %6) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %8 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.addf"(%arg4, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<?x5x3xf32>, tensor<?x3x6xf32>, tensor<?x5x6xf32>) -> tensor<?x5x6xf32>
    "func.return"(%7) : (tensor<?x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xf32>, tensor<1x3x?xf32>) -> tensor<1x5x?xf32>, sym_name = "matmul_dyn_independent_dim"}> ({
  ^bb0(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x?xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg1, %2) : (tensor<1x3x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"(%3) : (index) -> tensor<1x5x?xf32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1x5x?xf32>) -> tensor<1x5x?xf32>
    %7 = "linalg.batch_matmul"(%arg0, %arg1, %6) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %8 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.addf"(%arg4, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<1x5x3xf32>, tensor<1x3x?xf32>, tensor<1x5x?xf32>) -> tensor<1x5x?xf32>
    "func.return"(%7) : (tensor<1x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x?xf32>, tensor<1x?x6xf32>) -> tensor<1x5x6xf32>, sym_name = "matmul_dyn_independent_dim"}> ({
  ^bb0(%arg0: tensor<1x5x?xf32>, %arg1: tensor<1x?x6xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.empty"() : () -> tensor<1x5x6xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    %5 = "linalg.batch_matmul"(%arg0, %arg1, %4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %6 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg4, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<1x5x?xf32>, tensor<1x?x6xf32>, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    "func.return"(%5) : (tensor<1x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x8xf32>, tensor<1x8x1xf32>) -> tensor<?x1x1xf32>, sym_name = "matmul_dyn_output"}> ({
  ^bb0(%arg0: tensor<1x1x8xf32>, %arg1: tensor<1x8x1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<1x1x8xf32>, index) -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"(%3) : (index) -> tensor<?x1x1xf32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<?x1x1xf32>) -> tensor<?x1x1xf32>
    %7 = "linalg.batch_matmul"(%arg0, %arg1, %6) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %8 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.addf"(%arg4, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<1x1x8xf32>, tensor<1x8x1xf32>, tensor<?x1x1xf32>) -> tensor<?x1x1xf32>
    "func.return"(%7) : (tensor<?x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> (), sym_name = "max_pool"}> ({
  ^bb0(%arg50: tensor<1x6x34x62xf32>):
    %86 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %87 = "tensor.empty"() : () -> tensor<1x4x32x62xf32>
    %88 = "linalg.fill"(%86, %87) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg54: f32, %arg55: f32):
      "linalg.yield"(%arg54) : (f32) -> ()
    }) : (f32, tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    %89 = "tensor.empty"() : () -> tensor<3x3xf32>
    %90 = "linalg.pooling_nhwc_max"(%arg50, %89, %88) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg51: f32, %arg52: f32, %arg53: f32):
      %91 = "arith.maximumf"(%arg53, %arg51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%91) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xf32>, tensor<3x3xf32>, tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> (), sym_name = "max_pool_padded"}> ({
  ^bb0(%arg40: tensor<1x6x34x62xf32>):
    %78 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %79 = "tensor.pad"(%arg40) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 0, 1, 0>, static_low = array<i64: 0, 0, 0, 0>}> ({
    ^bb0(%arg46: index, %arg47: index, %arg48: index, %arg49: index):
      "tensor.yield"(%78) : (f32) -> ()
    }) : (tensor<1x6x34x62xf32>) -> tensor<1x6x35x62xf32>
    %80 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %81 = "tensor.empty"() : () -> tensor<1x4x33x62xf32>
    %82 = "linalg.fill"(%80, %81) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg44: f32, %arg45: f32):
      "linalg.yield"(%arg44) : (f32) -> ()
    }) : (f32, tensor<1x4x33x62xf32>) -> tensor<1x4x33x62xf32>
    %83 = "tensor.empty"() : () -> tensor<3x3xf32>
    %84 = "linalg.pooling_nhwc_max"(%79, %83, %82) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg41: f32, %arg42: f32, %arg43: f32):
      %85 = "arith.maximumf"(%arg43, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%85) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x35x62xf32>, tensor<3x3xf32>, tensor<1x4x33x62xf32>) -> tensor<1x4x33x62xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x6x34x62xf32>) -> (), sym_name = "max_pool_dyn"}> ({
  ^bb0(%arg34: tensor<?x6x34x62xf32>):
    %70 = "arith.constant"() <{value = 0 : index}> : () -> index
    %71 = "tensor.dim"(%arg34, %70) : (tensor<?x6x34x62xf32>, index) -> index
    %72 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %73 = "tensor.empty"(%71) : (index) -> tensor<?x4x32x62xf32>
    %74 = "linalg.fill"(%72, %73) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32):
      "linalg.yield"(%arg38) : (f32) -> ()
    }) : (f32, tensor<?x4x32x62xf32>) -> tensor<?x4x32x62xf32>
    %75 = "tensor.empty"() : () -> tensor<3x3xf32>
    %76 = "linalg.pooling_nhwc_max"(%arg34, %75, %74) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg35: f32, %arg36: f32, %arg37: f32):
      %77 = "arith.maximumf"(%arg37, %arg35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%77) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x6x34x62xf32>, tensor<3x3xf32>, tensor<?x4x32x62xf32>) -> tensor<?x4x32x62xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi8>) -> (), sym_name = "max_pool_i8"}> ({
  ^bb0(%arg28: tensor<1x6x34x62xi8>):
    %64 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %65 = "tensor.empty"() : () -> tensor<1x4x32x62xi8>
    %66 = "linalg.fill"(%64, %65) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: i8, %arg33: i8):
      "linalg.yield"(%arg32) : (i8) -> ()
    }) : (i8, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %67 = "tensor.empty"() : () -> tensor<3x3xi8>
    %68 = "linalg.pooling_nhwc_max"(%arg28, %67, %66) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg29: i8, %arg30: i8, %arg31: i8):
      %69 = "arith.maxsi"(%arg31, %arg29) : (i8, i8) -> i8
      "linalg.yield"(%69) : (i8) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xi8>, tensor<3x3xi8>, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xui8>) -> tensor<1x4x32x62xui8>, sym_name = "max_pool_ui8"}> ({
  ^bb0(%arg22: tensor<1x6x34x62xui8>):
    %56 = "builtin.unrealized_conversion_cast"(%arg22) : (tensor<1x6x34x62xui8>) -> tensor<1x6x34x62xi8>
    %57 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %58 = "tensor.empty"() : () -> tensor<1x4x32x62xi8>
    %59 = "linalg.fill"(%57, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: i8, %arg27: i8):
      "linalg.yield"(%arg26) : (i8) -> ()
    }) : (i8, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %60 = "tensor.empty"() : () -> tensor<3x3xi8>
    %61 = "linalg.pooling_nhwc_max_unsigned"(%56, %60, %59) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg23: i8, %arg24: i8, %arg25: i8):
      %63 = "arith.maxui"(%arg25, %arg23) : (i8, i8) -> i8
      "linalg.yield"(%63) : (i8) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xi8>, tensor<3x3xi8>, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %62 = "builtin.unrealized_conversion_cast"(%61) : (tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xui8>
    "func.return"(%62) : (tensor<1x4x32x62xui8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi16>) -> (), sym_name = "max_pool_i16"}> ({
  ^bb0(%arg16: tensor<1x6x34x62xi16>):
    %50 = "arith.constant"() <{value = -32768 : i16}> : () -> i16
    %51 = "tensor.empty"() : () -> tensor<1x4x32x62xi16>
    %52 = "linalg.fill"(%50, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i16, %arg21: i16):
      "linalg.yield"(%arg20) : (i16) -> ()
    }) : (i16, tensor<1x4x32x62xi16>) -> tensor<1x4x32x62xi16>
    %53 = "tensor.empty"() : () -> tensor<3x3xi16>
    %54 = "linalg.pooling_nhwc_max"(%arg16, %53, %52) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg17: i16, %arg18: i16, %arg19: i16):
      %55 = "arith.maxsi"(%arg19, %arg17) : (i16, i16) -> i16
      "linalg.yield"(%55) : (i16) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xi16>, tensor<3x3xi16>, tensor<1x4x32x62xi16>) -> tensor<1x4x32x62xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi32>) -> (), sym_name = "max_pool_i32"}> ({
  ^bb0(%arg10: tensor<1x6x34x62xi32>):
    %44 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %45 = "tensor.empty"() : () -> tensor<1x4x32x62xi32>
    %46 = "linalg.fill"(%44, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: i32, %arg15: i32):
      "linalg.yield"(%arg14) : (i32) -> ()
    }) : (i32, tensor<1x4x32x62xi32>) -> tensor<1x4x32x62xi32>
    %47 = "tensor.empty"() : () -> tensor<3x3xi32>
    %48 = "linalg.pooling_nhwc_max"(%arg10, %47, %46) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg11: i32, %arg12: i32, %arg13: i32):
      %49 = "arith.maxsi"(%arg13, %arg11) : (i32, i32) -> i32
      "linalg.yield"(%49) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xi32>, tensor<3x3xi32>, tensor<1x4x32x62xi32>) -> tensor<1x4x32x62xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>, sym_name = "max_pool_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.addi"(%3, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.subi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    %12 = "arith.muli"(%11, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "arith.addi"(%12, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.subi"(%9, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.divui"(%14, %15) : (index, index) -> index
    %17 = "arith.addi"(%16, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "arith.constant"() <{value = 2 : index}> : () -> index
    %19 = "tensor.dim"(%arg0, %18) : (tensor<?x?x?x?xf32>, index) -> index
    %20 = "arith.constant"() <{value = 5 : index}> : () -> index
    %21 = "arith.constant"() <{value = 1 : index}> : () -> index
    %22 = "arith.constant"() <{value = 2 : index}> : () -> index
    %23 = "arith.addi"(%19, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.constant"() <{value = 2 : index}> : () -> index
    %25 = "arith.addi"(%23, %24) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.subi"(%20, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %27 = "arith.constant"() <{value = 1 : index}> : () -> index
    %28 = "arith.muli"(%27, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.addi"(%28, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.subi"(%25, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "arith.constant"() <{value = 1 : index}> : () -> index
    %32 = "arith.divui"(%30, %31) : (index, index) -> index
    %33 = "arith.addi"(%32, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.constant"() <{value = 3 : index}> : () -> index
    %35 = "tensor.dim"(%arg0, %34) : (tensor<?x?x?x?xf32>, index) -> index
    %36 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %37 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 0, 2, 0>, static_low = array<i64: 0, 0, 2, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index):
      "tensor.yield"(%36) : (f32) -> ()
    }) : (tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    %38 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %39 = "tensor.empty"(%1, %17, %33, %35) : (index, index, index, index) -> tensor<?x?x?x?xf32>
    %40 = "linalg.fill"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    %41 = "tensor.empty"() : () -> tensor<2x5xf32>
    %42 = "linalg.pooling_nhwc_max"(%37, %41, %40) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %43 = "arith.maximumf"(%arg3, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%43) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x?x?x?xf32>, tensor<2x5xf32>, tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    "func.return"(%42) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> tensor<1x5x33x62xf32>, sym_name = "avg_pool_f32"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%2) : (f32) -> ()
    }) : (tensor<1x6x34x62xf32>) -> tensor<1x8x36x62xf32>
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"() : () -> tensor<1x5x33x62xf32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %7 = "tensor.empty"() : () -> tensor<4x4xf32>
    %8 = "linalg.pooling_nhwc_sum"(%3, %7, %6) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %53 = "arith.addf"(%arg5, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%53) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x8x36x62xf32>, tensor<4x4xf32>, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "tensor.dim"(%8, %9) : (tensor<1x5x33x62xf32>, index) -> index
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "tensor.dim"(%8, %11) : (tensor<1x5x33x62xf32>, index) -> index
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "arith.subi"(%10, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.subi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "tensor.empty"() : () -> tensor<1x5x33x62xf32>
    %17 = "linalg.generic"(%8, %16) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %18 = "arith.constant"() <{value = 0 : index}> : () -> index
      %19 = "arith.constant"() <{value = 1 : index}> : () -> index
      %20 = "arith.constant"() <{value = 4 : index}> : () -> index
      %21 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %22 = "arith.subi"(%14, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.muli"(%21, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.muli"(%22, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.constant"() <{value = 1 : index}> : () -> index
      %26 = "arith.subi"(%23, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.minsi"(%26, %18) : (index, index) -> index
      %28 = "arith.addi"(%20, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.constant"() <{value = 1 : index}> : () -> index
      %30 = "arith.subi"(%24, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.minsi"(%30, %18) : (index, index) -> index
      %32 = "arith.addi"(%28, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.maxsi"(%13, %32) : (index, index) -> index
      %34 = "arith.constant"() <{value = 1 : index}> : () -> index
      %35 = "arith.constant"() <{value = 4 : index}> : () -> index
      %36 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %37 = "arith.subi"(%15, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.muli"(%36, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.muli"(%37, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.constant"() <{value = 1 : index}> : () -> index
      %41 = "arith.subi"(%38, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.minsi"(%41, %18) : (index, index) -> index
      %43 = "arith.addi"(%35, %42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %44 = "arith.constant"() <{value = 1 : index}> : () -> index
      %45 = "arith.subi"(%39, %44) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "arith.minsi"(%45, %18) : (index, index) -> index
      %47 = "arith.addi"(%43, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "arith.maxsi"(%13, %47) : (index, index) -> index
      %49 = "arith.muli"(%33, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %50 = "arith.index_cast"(%49) : (index) -> i32
      %51 = "arith.sitofp"(%50) : (i32) -> f32
      %52 = "arith.divf"(%arg1, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%52) : (f32) -> ()
    }) : (tensor<1x5x33x62xf32>, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    "func.return"(%17) : (tensor<1x5x33x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf16>) -> tensor<1x5x33x62xf16>, sym_name = "avg_pool_f16_f32acc"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%2) : (f16) -> ()
    }) : (tensor<1x6x34x62xf16>) -> tensor<1x8x36x62xf16>
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"() : () -> tensor<1x5x33x62xf32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %7 = "tensor.empty"() : () -> tensor<4x4xf32>
    %8 = "linalg.pooling_nhwc_sum"(%3, %7, %6) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: f16, %arg4: f32, %arg5: f32):
      %54 = "arith.extf"(%arg3) : (f16) -> f32
      %55 = "arith.addf"(%arg5, %54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%55) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x8x36x62xf16>, tensor<4x4xf32>, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "tensor.dim"(%8, %9) : (tensor<1x5x33x62xf32>, index) -> index
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "tensor.dim"(%8, %11) : (tensor<1x5x33x62xf32>, index) -> index
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "arith.subi"(%10, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.subi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "tensor.empty"() : () -> tensor<1x5x33x62xf16>
    %17 = "linalg.generic"(%8, %16) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f16):
      %18 = "arith.constant"() <{value = 0 : index}> : () -> index
      %19 = "arith.constant"() <{value = 1 : index}> : () -> index
      %20 = "arith.constant"() <{value = 4 : index}> : () -> index
      %21 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %22 = "arith.subi"(%14, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.muli"(%21, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.muli"(%22, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.constant"() <{value = 1 : index}> : () -> index
      %26 = "arith.subi"(%23, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.minsi"(%26, %18) : (index, index) -> index
      %28 = "arith.addi"(%20, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.constant"() <{value = 1 : index}> : () -> index
      %30 = "arith.subi"(%24, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.minsi"(%30, %18) : (index, index) -> index
      %32 = "arith.addi"(%28, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.maxsi"(%13, %32) : (index, index) -> index
      %34 = "arith.constant"() <{value = 1 : index}> : () -> index
      %35 = "arith.constant"() <{value = 4 : index}> : () -> index
      %36 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %37 = "arith.subi"(%15, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.muli"(%36, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.muli"(%37, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.constant"() <{value = 1 : index}> : () -> index
      %41 = "arith.subi"(%38, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.minsi"(%41, %18) : (index, index) -> index
      %43 = "arith.addi"(%35, %42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %44 = "arith.constant"() <{value = 1 : index}> : () -> index
      %45 = "arith.subi"(%39, %44) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "arith.minsi"(%45, %18) : (index, index) -> index
      %47 = "arith.addi"(%43, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "arith.maxsi"(%13, %47) : (index, index) -> index
      %49 = "arith.muli"(%33, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %50 = "arith.index_cast"(%49) : (index) -> i32
      %51 = "arith.sitofp"(%50) : (i32) -> f32
      %52 = "arith.divf"(%arg1, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %53 = "arith.truncf"(%52) : (f32) -> f16
      "linalg.yield"(%53) : (f16) -> ()
    }) : (tensor<1x5x33x62xf32>, tensor<1x5x33x62xf16>) -> tensor<1x5x33x62xf16>
    "func.return"(%17) : (tensor<1x5x33x62xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xi8>) -> tensor<1x5x33x62xi8>, sym_name = "avg_pool_i8"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xi8>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%2) : (i8) -> ()
    }) : (tensor<1x6x34x62xi8>) -> tensor<1x8x36x62xi8>
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "tensor.empty"() : () -> tensor<1x5x33x62xi32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<1x5x33x62xi32>) -> tensor<1x5x33x62xi32>
    %7 = "tensor.empty"() : () -> tensor<4x4xi32>
    %8 = "linalg.pooling_nhwc_sum"(%3, %7, %6) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: i8, %arg4: i32, %arg5: i32):
      %71 = "arith.extsi"(%arg3) : (i8) -> i32
      %72 = "arith.addi"(%arg5, %71) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%72) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x8x36x62xi8>, tensor<4x4xi32>, tensor<1x5x33x62xi32>) -> tensor<1x5x33x62xi32>
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "tensor.dim"(%8, %9) : (tensor<1x5x33x62xi32>, index) -> index
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "tensor.dim"(%8, %11) : (tensor<1x5x33x62xi32>, index) -> index
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "arith.subi"(%10, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.subi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "tensor.empty"() : () -> tensor<1x5x33x62xi8>
    %17 = "linalg.generic"(%8, %16) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i8):
      %18 = "arith.constant"() <{value = 0 : index}> : () -> index
      %19 = "arith.constant"() <{value = 1 : index}> : () -> index
      %20 = "arith.constant"() <{value = 4 : index}> : () -> index
      %21 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %22 = "arith.subi"(%14, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.muli"(%21, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.muli"(%22, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.constant"() <{value = 1 : index}> : () -> index
      %26 = "arith.subi"(%23, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.minsi"(%26, %18) : (index, index) -> index
      %28 = "arith.addi"(%20, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.constant"() <{value = 1 : index}> : () -> index
      %30 = "arith.subi"(%24, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.minsi"(%30, %18) : (index, index) -> index
      %32 = "arith.addi"(%28, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.maxsi"(%13, %32) : (index, index) -> index
      %34 = "arith.constant"() <{value = 1 : index}> : () -> index
      %35 = "arith.constant"() <{value = 4 : index}> : () -> index
      %36 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %37 = "arith.subi"(%15, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.muli"(%36, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.muli"(%37, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.constant"() <{value = 1 : index}> : () -> index
      %41 = "arith.subi"(%38, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.minsi"(%41, %18) : (index, index) -> index
      %43 = "arith.addi"(%35, %42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %44 = "arith.constant"() <{value = 1 : index}> : () -> index
      %45 = "arith.subi"(%39, %44) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "arith.minsi"(%45, %18) : (index, index) -> index
      %47 = "arith.addi"(%43, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "arith.maxsi"(%13, %47) : (index, index) -> index
      %49 = "arith.muli"(%33, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %50 = "arith.index_cast"(%49) : (index) -> i32
      %51 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %52 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %53 = "arith.subi"(%50, %51) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %54 = "math.ctlz"(%53) : (i32) -> i32
      %55 = "arith.subi"(%52, %54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %56 = "arith.extui"(%55) : (i32) -> i64
      %57 = "arith.constant"() <{value = 1073741825 : i64}> : () -> i64
      %58 = "arith.shli"(%57, %56) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %59 = "arith.extui"(%50) : (i32) -> i64
      %60 = "arith.divui"(%58, %59) : (i64, i64) -> i64
      %61 = "arith.trunci"(%60) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %62 = "arith.trunci"(%55) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      %63 = "arith.constant"() <{value = 30 : i8}> : () -> i8
      %64 = "arith.addi"(%62, %63) <{overflowFlags = #arith.overflow<none>}> : (i8, i8) -> i8
      %65 = "tosa.apply_scale"(%arg1, %61, %64) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %66 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %67 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %68 = "arith.maxsi"(%66, %65) : (i32, i32) -> i32
      %69 = "arith.minsi"(%67, %68) : (i32, i32) -> i32
      %70 = "arith.trunci"(%69) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%70) : (i8) -> ()
    }) : (tensor<1x5x33x62xi32>, tensor<1x5x33x62xi8>) -> tensor<1x5x33x62xi8>
    "func.return"(%17) : (tensor<1x5x33x62xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x6x34x62xf32>) -> tensor<?x5x33x62xf32>, sym_name = "avg_pool_dyn"}> ({
  ^bb0(%arg0: tensor<?x6x34x62xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x6x34x62xf32>, index) -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%4) : (f32) -> ()
    }) : (tensor<?x6x34x62xf32>) -> tensor<?x8x36x62xf32>
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "tensor.empty"(%3) : (index) -> tensor<?x5x33x62xf32>
    %8 = "linalg.fill"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    %9 = "tensor.empty"() : () -> tensor<4x4xf32>
    %10 = "linalg.pooling_nhwc_sum"(%5, %9, %8) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %55 = "arith.addf"(%arg5, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%55) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x8x36x62xf32>, tensor<4x4xf32>, tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    %12 = "tensor.dim"(%10, %11) : (tensor<?x5x33x62xf32>, index) -> index
    %13 = "arith.constant"() <{value = 2 : index}> : () -> index
    %14 = "tensor.dim"(%10, %13) : (tensor<?x5x33x62xf32>, index) -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.subi"(%12, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "arith.subi"(%14, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "tensor.empty"(%3) : (index) -> tensor<?x5x33x62xf32>
    %19 = "linalg.generic"(%10, %18) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %20 = "arith.constant"() <{value = 0 : index}> : () -> index
      %21 = "arith.constant"() <{value = 1 : index}> : () -> index
      %22 = "arith.constant"() <{value = 4 : index}> : () -> index
      %23 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %24 = "arith.subi"(%16, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.muli"(%23, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %26 = "arith.muli"(%24, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.constant"() <{value = 1 : index}> : () -> index
      %28 = "arith.subi"(%25, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.minsi"(%28, %20) : (index, index) -> index
      %30 = "arith.addi"(%22, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.constant"() <{value = 1 : index}> : () -> index
      %32 = "arith.subi"(%26, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.minsi"(%32, %20) : (index, index) -> index
      %34 = "arith.addi"(%30, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "arith.maxsi"(%15, %34) : (index, index) -> index
      %36 = "arith.constant"() <{value = 1 : index}> : () -> index
      %37 = "arith.constant"() <{value = 4 : index}> : () -> index
      %38 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %39 = "arith.subi"(%17, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.muli"(%38, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %41 = "arith.muli"(%39, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.constant"() <{value = 1 : index}> : () -> index
      %43 = "arith.subi"(%40, %42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %44 = "arith.minsi"(%43, %20) : (index, index) -> index
      %45 = "arith.addi"(%37, %44) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "arith.constant"() <{value = 1 : index}> : () -> index
      %47 = "arith.subi"(%41, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "arith.minsi"(%47, %20) : (index, index) -> index
      %49 = "arith.addi"(%45, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %50 = "arith.maxsi"(%15, %49) : (index, index) -> index
      %51 = "arith.muli"(%35, %50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %52 = "arith.index_cast"(%51) : (index) -> i32
      %53 = "arith.sitofp"(%52) : (i32) -> f32
      %54 = "arith.divf"(%arg1, %53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%54) : (f32) -> ()
    }) : (tensor<?x5x33x62xf32>, tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    "func.return"(%19) : (tensor<?x5x33x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4 * 2, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<1xf32>) -> (), sym_name = "conv2d_scalar_bias_f32"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    %4 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %3) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %5 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg5, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4 * 2, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xi8>, tensor<28x1x1x27xi8>, tensor<28xi8>) -> (), sym_name = "conv2d_i8"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xi8>, %arg1: tensor<28x1x1x27xi8>, %arg2: tensor<28xi8>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tensor.empty"() : () -> tensor<1x49x42x28xi32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i8, %arg7: i32):
      %9 = "arith.extsi"(%arg6) : (i8) -> i32
      "linalg.yield"(%9) : (i32) -> ()
    }) : (tensor<28xi8>, tensor<1x49x42x28xi32>) -> tensor<1x49x42x28xi32>
    %4 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %3) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: i8, %arg4: i8, %arg5: i32):
      %5 = "arith.extsi"(%arg3) : (i8) -> i32
      %6 = "arith.extsi"(%arg4) : (i8) -> i32
      %7 = "arith.muli"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "arith.addi"(%arg5, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%8) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x42x27xi8>, tensor<28x1x1x27xi8>, tensor<1x49x42x28xi32>) -> tensor<1x49x42x28xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4 * 2, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_f32"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    %4 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %3) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %5 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg5, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4 * 2, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_dyn"}> ({
  ^bb0(%arg0: tensor<?x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x49x42x27xf32>, index) -> index
    %4 = "tensor.empty"(%3) : (index) -> tensor<?x45x40x28xf32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<?x45x40x28xf32>) -> tensor<?x45x40x28xf32>
    %6 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %5) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg5, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<?x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<?x45x40x28xf32>) -> tensor<?x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4 * 2, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x?x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_dyn_w_h"}> ({
  ^bb0(%arg0: tensor<1x?x?x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<1x?x?x27xf32>, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "tensor.dim"(%arg1, %4) : (tensor<28x3x3x27xf32>, index) -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.addi"(%3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.subi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "arith.constant"() <{value = 2 : index}> : () -> index
    %13 = "arith.muli"(%12, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.addi"(%13, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.subi"(%10, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "arith.constant"() <{value = 1 : index}> : () -> index
    %17 = "arith.divui"(%15, %16) : (index, index) -> index
    %18 = "arith.addi"(%17, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "arith.constant"() <{value = 2 : index}> : () -> index
    %20 = "tensor.dim"(%arg0, %19) : (tensor<1x?x?x27xf32>, index) -> index
    %21 = "arith.constant"() <{value = 2 : index}> : () -> index
    %22 = "tensor.dim"(%arg1, %21) : (tensor<28x3x3x27xf32>, index) -> index
    %23 = "arith.constant"() <{value = 1 : index}> : () -> index
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "arith.addi"(%20, %24) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.constant"() <{value = 0 : index}> : () -> index
    %27 = "arith.addi"(%25, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.subi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.constant"() <{value = 1 : index}> : () -> index
    %30 = "arith.muli"(%29, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "arith.addi"(%30, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.subi"(%27, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.constant"() <{value = 1 : index}> : () -> index
    %34 = "arith.divui"(%32, %33) : (index, index) -> index
    %35 = "arith.addi"(%34, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "tensor.empty"(%18, %35) : (index, index) -> tensor<1x?x?x28xf32>
    %37 = "linalg.generic"(%arg2, %36) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<1x?x?x28xf32>) -> tensor<1x?x?x28xf32>
    %38 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %37) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %39 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %40 = "arith.addf"(%arg5, %39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%40) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x?x?x27xf32>, tensor<28x3x3x27xf32>, tensor<1x?x?x28xf32>) -> tensor<1x?x?x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x6x5x4xf32>, tensor<4x3x3x4xf32>, tensor<4xf32>) -> (), sym_name = "conv2d_dyn_output"}> ({
  ^bb0(%arg0: tensor<2x6x5x4xf32>, %arg1: tensor<4x3x3x4xf32>, %arg2: tensor<4xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<2x6x5x4xf32>, index) -> index
    %4 = "tensor.empty"(%3) : (index) -> tensor<?x4x3x4xf32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<4xf32>, tensor<?x4x3x4xf32>) -> tensor<?x4x3x4xf32>
    %6 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %5) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg5, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<2x6x5x4xf32>, tensor<4x3x3x4xf32>, tensor<?x4x3x4xf32>) -> tensor<?x4x3x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4 * 2, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x47x40x28xf32>, tensor<28x3x3x28xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_padded_f32"}> ({
  ^bb0(%arg0: tensor<1x47x40x28xf32>, %arg1: tensor<28x3x3x28xf32>, %arg2: tensor<28xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%2) : (f32) -> ()
    }) : (tensor<1x47x40x28xf32>) -> tensor<1x49x42x28xf32>
    %4 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    %6 = "linalg.conv_2d_nhwc_fhwc"(%3, %arg1, %5) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg5, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x42x28xf32>, tensor<28x3x3x28xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> ()>
#map5 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12x1xi8>, tensor<1024x3x3x1xi8>, tensor<1024xi32>) -> (), sym_name = "conv2d_quant"}> ({
  ^bb0(%arg0: tensor<1x12x12x1xi8>, %arg1: tensor<1024x3x3x1xi8>, %arg2: tensor<1024xi32>):
    %0 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "arith.constant"() <{value = -22 : i8}> : () -> i8
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg10: index, %arg11: index, %arg12: index, %arg13: index):
      "tensor.yield"(%2) : (i8) -> ()
    }) : (tensor<1x12x12x1xi8>) -> tensor<1x14x14x1xi8>
    %4 = "tensor.empty"() : () -> tensor<1x12x12x1024xi32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      "linalg.yield"(%arg8) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1x12x12x1024xi32>) -> tensor<1x12x12x1024xi32>
    %6 = "arith.constant"() <{value = -22 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %8 = "linalg.conv_2d_nhwc_fhwc_q"(%3, %arg1, %6, %7, %5) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 4, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: i8, %arg4: i8, %arg5: i32, %arg6: i32, %arg7: i32):
      %9 = "arith.extsi"(%arg3) : (i8) -> i32
      %10 = "arith.subi"(%9, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %11 = "arith.extsi"(%arg4) : (i8) -> i32
      %12 = "arith.subi"(%11, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "arith.muli"(%10, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.addi"(%arg7, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%14) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4, #map4, #map5]} : (tensor<1x14x14x1xi8>, tensor<1024x3x3x1xi8>, i32, i32, tensor<1x12x12x1024xi32>) -> tensor<1x12x12x1024xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4 * 2, d2 + d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d3, d4, d5, d6)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf16>, tensor<28x3x3x27xf16>, tensor<28xf16>) -> (), sym_name = "conv2d_f16_f32_acc"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf16>, %arg1: tensor<28x3x3x27xf16>, %arg2: tensor<28xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f16, %arg7: f32):
      %10 = "arith.extf"(%arg6) : (f16) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<28xf16>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    %4 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %3) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f16, %arg4: f16, %arg5: f32):
      %6 = "arith.extf"(%arg3) : (f16) -> f32
      %7 = "arith.extf"(%arg4) : (f16) -> f32
      %8 = "arith.mulf"(%6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.addf"(%arg5, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x42x27xf16>, tensor<28x3x3x27xf16>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    %5 = "tosa.cast"(%4) : (tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tensor.empty"() : () -> tensor<1x5x5x33xf32>
    %6 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %4) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %10 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %11 = "arith.addf"(%arg8, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %7 = "tensor.collapse_shape"(%6) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x33xf32>
    %8 = "linalg.generic"(%arg2, %7, %5) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<33xf32>, tensor<1x5x5x33xf32>, tensor<1x5x5x33xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map3 = affine_map<(d0, d1, d2, d3) -> (0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1xf32>) -> (), sym_name = "depthwise_conv_scalar_bias"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tensor.empty"() : () -> tensor<1x5x5x33xf32>
    %6 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %4) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %10 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %11 = "arith.addf"(%arg8, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %7 = "tensor.collapse_shape"(%6) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x33xf32>
    %8 = "linalg.generic"(%arg2, %7, %5) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1x5x5x33xf32>, tensor<1x5x5x33xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv_dyn"}> ({
  ^bb0(%arg0: tensor<?x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x7x5x3xf32>, index) -> index
    %4 = "tensor.empty"(%3) : (index) -> tensor<?x5x5x3x11xf32>
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "linalg.fill"(%5, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x3x11xf32>
    %7 = "tensor.empty"(%3) : (index) -> tensor<?x5x5x33xf32>
    %8 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %6) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %12 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %13 = "arith.addf"(%arg8, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x3x11xf32>
    %9 = "tensor.collapse_shape"(%8) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x33xf32>
    %10 = "linalg.generic"(%arg2, %9, %7) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %11 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<33xf32>, tensor<?x5x5x33xf32>, tensor<?x5x5x33xf32>) -> tensor<?x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 * 2 + d5, d2 * 2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x11x9x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv_strides"}> ({
  ^bb0(%arg0: tensor<1x11x9x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tensor.empty"() : () -> tensor<1x5x5x33xf32>
    %6 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %4) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<2> : tensor<2xi64>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %10 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %11 = "arith.addf"(%arg8, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x11x9x3xf32>, tensor<3x1x3x11xf32>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %7 = "tensor.collapse_shape"(%6) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x33xf32>
    %8 = "linalg.generic"(%arg2, %7, %5) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<33xf32>, tensor<1x5x5x33xf32>, tensor<1x5x5x33xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> ()>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map5 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>) -> (), sym_name = "depthwise_conv_quant"}> ({
  ^bb0(%arg0: tensor<1x12x12x4xi8>, %arg1: tensor<3x3x4x128xi8>, %arg2: tensor<512xi32>):
    %0 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg13: index, %arg14: index, %arg15: index, %arg16: index):
      "tensor.yield"(%2) : (i8) -> ()
    }) : (tensor<1x12x12x4xi8>) -> tensor<1x14x14x4xi8>
    %4 = "tensor.empty"() : () -> tensor<1x12x12x4x128xi32>
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "linalg.fill"(%5, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x4x128xi32>
    %7 = "tensor.empty"() : () -> tensor<1x12x12x512xi32>
    %8 = "arith.constant"() <{value = -128 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %10 = "linalg.depthwise_conv_2d_nhwc_hwcm_q"(%3, %arg1, %8, %9, %6) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 4, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg6: i8, %arg7: i8, %arg8: i32, %arg9: i32, %arg10: i32):
      %14 = "arith.extsi"(%arg6) : (i8) -> i32
      %15 = "arith.subi"(%14, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %16 = "arith.extsi"(%arg7) : (i8) -> i32
      %17 = "arith.subi"(%16, %arg9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %18 = "arith.muli"(%15, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %19 = "arith.addi"(%arg10, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%19) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2, #map2, #map3]} : (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, i32, i32, tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x4x128xi32>
    %11 = "tensor.collapse_shape"(%10) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x512xi32>
    %12 = "linalg.generic"(%arg2, %11, %7) <{indexing_maps = [#map4, #map5, #map5], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %13 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) : (tensor<512xi32>, tensor<1x12x12x512xi32>, tensor<1x12x12x512xi32>) -> tensor<1x12x12x512xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5 * 2, d2 + d6 * 2, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> ()>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map5 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map6 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5 * 2, d2 * 2 + d6, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>) -> (), sym_name = "depthwise_conv_quant_dilations"}> ({
  ^bb0(%arg15: tensor<1x14x14x4xi8>, %arg16: tensor<3x3x4x128xi8>, %arg17: tensor<512xi32>):
    %48 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %49 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %50 = "tensor.empty"() : () -> tensor<1x10x10x4x128xi32>
    %51 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %52 = "linalg.fill"(%51, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32):
      "linalg.yield"(%arg26) : (i32) -> ()
    }) : (i32, tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x4x128xi32>
    %53 = "tensor.empty"() : () -> tensor<1x10x10x512xi32>
    %54 = "arith.constant"() <{value = -128 : i32}> : () -> i32
    %55 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %56 = "linalg.depthwise_conv_2d_nhwc_hwcm_q"(%arg15, %arg16, %54, %55, %52) <{dilations = dense<2> : tensor<2xi64>, operandSegmentSizes = array<i32: 4, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg21: i8, %arg22: i8, %arg23: i32, %arg24: i32, %arg25: i32):
      %60 = "arith.extsi"(%arg21) : (i8) -> i32
      %61 = "arith.subi"(%60, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %62 = "arith.extsi"(%arg22) : (i8) -> i32
      %63 = "arith.subi"(%62, %arg24) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %64 = "arith.muli"(%61, %63) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %65 = "arith.addi"(%arg25, %64) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%65) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2, #map2, #map3]} : (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, i32, i32, tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x4x128xi32>
    %57 = "tensor.collapse_shape"(%56) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x512xi32>
    %58 = "linalg.generic"(%arg17, %57, %53) <{indexing_maps = [#map4, #map5, #map5], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32, %arg20: i32):
      %59 = "arith.addi"(%arg18, %arg19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%59) : (i32) -> ()
    }) : (tensor<512xi32>, tensor<1x10x10x512xi32>, tensor<1x10x10x512xi32>) -> tensor<1x10x10x512xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<2x?x?x3xf32>, tensor<3x6x3x5xf32>, tensor<15xf32>) -> (), sym_name = "depthwise_conv2d_dyn_w_h"}> ({
  ^bb0(%arg0: tensor<2x?x?x3xf32>, %arg1: tensor<3x6x3x5xf32>, %arg2: tensor<15xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<2x?x?x3xf32>, index) -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "tensor.dim"(%arg1, %4) : (tensor<3x6x3x5xf32>, index) -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.addi"(%3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.constant"() <{value = 2 : index}> : () -> index
    %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.subi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "arith.constant"() <{value = 2 : index}> : () -> index
    %13 = "arith.muli"(%12, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.addi"(%13, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.subi"(%10, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "arith.constant"() <{value = 1 : index}> : () -> index
    %17 = "arith.divui"(%15, %16) : (index, index) -> index
    %18 = "arith.addi"(%17, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "arith.constant"() <{value = 2 : index}> : () -> index
    %20 = "tensor.dim"(%arg0, %19) : (tensor<2x?x?x3xf32>, index) -> index
    %21 = "arith.constant"() <{value = 1 : index}> : () -> index
    %22 = "tensor.dim"(%arg1, %21) : (tensor<3x6x3x5xf32>, index) -> index
    %23 = "arith.constant"() <{value = 1 : index}> : () -> index
    %24 = "arith.constant"() <{value = 3 : index}> : () -> index
    %25 = "arith.addi"(%20, %24) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.constant"() <{value = 4 : index}> : () -> index
    %27 = "arith.addi"(%25, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.subi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.constant"() <{value = 1 : index}> : () -> index
    %30 = "arith.muli"(%29, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "arith.addi"(%30, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.subi"(%27, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.constant"() <{value = 2 : index}> : () -> index
    %34 = "arith.divui"(%32, %33) : (index, index) -> index
    %35 = "arith.addi"(%34, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %37 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 2, 4, 0>, static_low = array<i64: 0, 1, 3, 0>}> ({
    ^bb0(%arg11: index, %arg12: index, %arg13: index, %arg14: index):
      "tensor.yield"(%36) : (f32) -> ()
    }) : (tensor<2x?x?x3xf32>) -> tensor<2x?x?x3xf32>
    %38 = "tensor.empty"(%18, %35) : (index, index) -> tensor<2x?x?x3x5xf32>
    %39 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %40 = "linalg.fill"(%39, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x3x5xf32>
    %41 = "tensor.empty"(%18, %35) : (index, index) -> tensor<2x?x?x15xf32>
    %42 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%37, %arg1, %40) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<[1, 2]> : tensor<2xi64>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %46 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %47 = "arith.addf"(%arg8, %46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%47) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map6, #map1, #map3]} : (tensor<2x?x?x3xf32>, tensor<3x6x3x5xf32>, tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x3x5xf32>
    %43 = "tensor.collapse_shape"(%42) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x15xf32>
    %44 = "linalg.generic"(%arg2, %43, %41) <{indexing_maps = [#map4, #map5, #map5], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %45 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%45) : (f32) -> ()
    }) : (tensor<15xf32>, tensor<2x?x?x15xf32>, tensor<2x?x?x15xf32>) -> tensor<2x?x?x15xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xi8>, tensor<3x1x3x11xi8>, tensor<33xi32>) -> (), sym_name = "depthwise_int_conv_zero_zp"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xi8>, %arg1: tensor<3x1x3x11xi8>, %arg2: tensor<33xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tensor.empty"() : () -> tensor<1x5x5x3x11xi32>
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      "linalg.yield"(%arg9) : (i32) -> ()
    }) : (i32, tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x3x11xi32>
    %5 = "tensor.empty"() : () -> tensor<1x5x5x33xi32>
    %6 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %4) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg6: i8, %arg7: i8, %arg8: i32):
      %10 = "arith.extsi"(%arg6) : (i8) -> i32
      %11 = "arith.extsi"(%arg7) : (i8) -> i32
      %12 = "arith.muli"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "arith.addi"(%arg8, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xi8>, tensor<3x1x3x11xi8>, tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x3x11xi32>
    %7 = "tensor.collapse_shape"(%6) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x33xi32>
    %8 = "linalg.generic"(%arg2, %7, %5) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %9 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%9) : (i32) -> ()
    }) : (tensor<33xi32>, tensor<1x5x5x33xi32>, tensor<1x5x5x33xi32>) -> tensor<1x5x5x33xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf16>, tensor<3x1x3x11xf16>, tensor<33xf16>) -> (), sym_name = "depthwise_conv2d_f16_f32_acc"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf16>, %arg1: tensor<3x1x3x11xf16>, %arg2: tensor<33xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tensor.empty"() : () -> tensor<1x5x5x33xf16>
    %6 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %4) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg6: f16, %arg7: f16, %arg8: f32):
      %11 = "arith.extf"(%arg6) : (f16) -> f32
      %12 = "arith.extf"(%arg7) : (f16) -> f32
      %13 = "arith.mulf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %14 = "arith.addf"(%arg8, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%14) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xf16>, tensor<3x1x3x11xf16>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %7 = "tosa.cast"(%6) : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf16>
    %8 = "tensor.collapse_shape"(%7) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf16>) -> tensor<1x5x5x33xf16>
    %9 = "linalg.generic"(%arg2, %8, %5) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f16, %arg4: f16, %arg5: f16):
      %10 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      "linalg.yield"(%10) : (f16) -> ()
    }) : (tensor<33xf16>, tensor<1x5x5x33xf16>, tensor<1x5x5x33xf16>) -> tensor<1x5x5x33xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1 + d5, d2 + d6, d3 + d7, d8)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d5, d6, d7, d8, d4)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf32>, tensor<43x3x4x5x27xf32>, tensor<43xf32>) -> (), sym_name = "conv3d_f32"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<43x3x4x5x27xf32>, %arg2: tensor<43xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<3x4x5x27x43xf32>
    %3 = "linalg.transpose"(%arg1, %2) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (tensor<43x3x4x5x27xf32>, tensor<3x4x5x27x43xf32>) -> tensor<3x4x5x27x43xf32>
    %4 = "tensor.empty"() : () -> tensor<1x47x45x43x43xf32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<43xf32>, tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    %6 = "linalg.conv_3d_ndhwc_dhwcf"(%arg0, %3, %5) <{dilations = dense<1> : tensor<3xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<3xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg5, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x48x47x27xf32>, tensor<3x4x5x27x43xf32>, tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (0)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1 + d5, d2 + d6, d3 + d7, d8)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d5, d6, d7, d8, d4)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf32>, tensor<28x3x4x5x27xf32>, tensor<1xf32>) -> (), sym_name = "conv3d_scalar_bias_f32"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<28x3x4x5x27xf32>, %arg2: tensor<1xf32>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<3x4x5x27x28xf32>
    %3 = "linalg.transpose"(%arg1, %2) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (tensor<28x3x4x5x27xf32>, tensor<3x4x5x27x28xf32>) -> tensor<3x4x5x27x28xf32>
    %4 = "tensor.empty"() : () -> tensor<1x47x45x43x28xf32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1x47x45x43x28xf32>) -> tensor<1x47x45x43x28xf32>
    %6 = "linalg.conv_3d_ndhwc_dhwcf"(%arg0, %3, %5) <{dilations = dense<1> : tensor<3xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<3xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg5, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x48x47x27xf32>, tensor<3x4x5x27x28xf32>, tensor<1x47x45x43x28xf32>) -> tensor<1x47x45x43x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1 + d5, d2 + d6, d3 + d7, d8)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d5, d6, d7, d8, d4)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> ()>
#map5 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xi8>, tensor<43x3x4x5x27xi8>, tensor<43xi32>) -> (), sym_name = "conv3d_i8"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xi8>, %arg1: tensor<43x3x4x5x27xi8>, %arg2: tensor<43xi32>):
    %0 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tensor.empty"() : () -> tensor<3x4x5x27x43xi8>
    %3 = "linalg.transpose"(%arg1, %2) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg10: i8, %arg11: i8):
      "linalg.yield"(%arg10) : (i8) -> ()
    }) : (tensor<43x3x4x5x27xi8>, tensor<3x4x5x27x43xi8>) -> tensor<3x4x5x27x43xi8>
    %4 = "tensor.empty"() : () -> tensor<1x47x45x43x43xi32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      "linalg.yield"(%arg8) : (i32) -> ()
    }) : (tensor<43xi32>, tensor<1x47x45x43x43xi32>) -> tensor<1x47x45x43x43xi32>
    %6 = "arith.constant"() <{value = -128 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %8 = "linalg.conv_3d_ndhwc_dhwcf_q"(%arg0, %3, %6, %7, %5) <{dilations = dense<1> : tensor<3xi64>, operandSegmentSizes = array<i32: 4, 1>, strides = dense<1> : tensor<3xi64>}> ({
    ^bb0(%arg3: i8, %arg4: i8, %arg5: i32, %arg6: i32, %arg7: i32):
      %9 = "arith.extsi"(%arg3) : (i8) -> i32
      %10 = "arith.subi"(%9, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %11 = "arith.extsi"(%arg4) : (i8) -> i32
      %12 = "arith.subi"(%11, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "arith.muli"(%10, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.addi"(%arg7, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%14) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4, #map4, #map5]} : (tensor<1x49x48x47x27xi8>, tensor<3x4x5x27x43xi8>, i32, i32, tensor<1x47x45x43x43xi32>) -> tensor<1x47x45x43x43xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1 + d5, d2 + d6, d3 + d7, d8)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d5, d6, d7, d8, d4)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf16>, tensor<43x3x4x5x27xf16>, tensor<43xf16>) -> (), sym_name = "conv3d_f16_f32_acc"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf16>, %arg1: tensor<43x3x4x5x27xf16>, %arg2: tensor<43xf16>):
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = "tensor.empty"() : () -> tensor<3x4x5x27x43xf16>
    %3 = "linalg.transpose"(%arg1, %2) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg8: f16, %arg9: f16):
      "linalg.yield"(%arg8) : (f16) -> ()
    }) : (tensor<43x3x4x5x27xf16>, tensor<3x4x5x27x43xf16>) -> tensor<3x4x5x27x43xf16>
    %4 = "tensor.empty"() : () -> tensor<1x47x45x43x43xf32>
    %5 = "linalg.generic"(%arg2, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f16, %arg7: f32):
      %12 = "arith.extf"(%arg6) : (f16) -> f32
      "linalg.yield"(%12) : (f32) -> ()
    }) : (tensor<43xf16>, tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    %6 = "linalg.conv_3d_ndhwc_dhwcf"(%arg0, %3, %5) <{dilations = dense<1> : tensor<3xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<3xi64>}> ({
    ^bb0(%arg3: f16, %arg4: f16, %arg5: f32):
      %8 = "arith.extf"(%arg3) : (f16) -> f32
      %9 = "arith.extf"(%arg4) : (f16) -> f32
      %10 = "arith.mulf"(%8, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %11 = "arith.addf"(%arg5, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x48x47x27xf16>, tensor<3x4x5x27x43xf16>, tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    %7 = "tosa.cast"(%6) : (tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xi32>) -> (), sym_name = "test_transpose"}> ({
  ^bb0(%arg0: tensor<1x2x3xi32>):
    %0 = "tensor.empty"() : () -> tensor<2x3x1xi32>
    %1 = "linalg.transpose"(%arg0, %0) <{permutation = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      "linalg.yield"(%arg1) : (i32) -> ()
    }) : (tensor<1x2x3xi32>, tensor<2x3x1xi32>) -> tensor<2x3x1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x3x4xi32>) -> (), sym_name = "test_transpose_dyn"}> ({
  ^bb0(%arg0: tensor<1x?x3x4xi32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<1x?x3x4xi32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?x4x1x3xi32>
    %3 = "linalg.transpose"(%arg0, %2) <{permutation = array<i64: 1, 3, 0, 2>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      "linalg.yield"(%arg1) : (i32) -> ()
    }) : (tensor<1x?x3x4xi32>, tensor<?x4x1x3xi32>) -> tensor<?x4x1x3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> (), sym_name = "test_transpose_dyn_multiple_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.empty"(%3, %1) : (index, index) -> tensor<?x?xf32>
    %5 = "linalg.transpose"(%arg0, %4) <{permutation = array<i64: 1, 0>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> (), sym_name = "test_transpose_dyn_multiple_3d"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<?x?x?xf32>, index) -> index
    %6 = "tensor.empty"(%5, %1, %3) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "linalg.transpose"(%arg0, %6) <{permutation = array<i64: 2, 0, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32>, sym_name = "max_pool2d_nan_propagate"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf32>):
    %0 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<1x4x32x62xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    %3 = "tensor.empty"() : () -> tensor<3x3xf32>
    %4 = "linalg.pooling_nhwc_max"(%arg0, %3, %2) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %5 = "arith.maximumf"(%arg3, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xf32>, tensor<3x3xf32>, tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    "func.return"(%4) : (tensor<1x4x32x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xi8>) -> tensor<1x4x32x62xi8>, sym_name = "max_pool2d_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xi8>):
    %0 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %1 = "tensor.empty"() : () -> tensor<1x4x32x62xi8>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: i8, %arg5: i8):
      "linalg.yield"(%arg4) : (i8) -> ()
    }) : (i8, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %3 = "tensor.empty"() : () -> tensor<3x3xi8>
    %4 = "linalg.pooling_nhwc_max"(%arg0, %3, %2) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg1: i8, %arg2: i8, %arg3: i8):
      %5 = "arith.maxsi"(%arg3, %arg1) : (i8, i8) -> i8
      "linalg.yield"(%5) : (i8) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xi8>, tensor<3x3xi8>, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    "func.return"(%4) : (tensor<1x4x32x62xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32>, sym_name = "max_pool2d_nan_ignore"}> ({
  ^bb0(%arg0: tensor<1x6x34x62xf32>):
    %0 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<1x4x32x62xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    %3 = "tensor.empty"() : () -> tensor<3x3xf32>
    %4 = "linalg.generic"(%arg0, %3, %2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %5 = "arith.maximumf"(%arg3, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.cmpf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %7 = "arith.select"(%6, %arg3, %5) : (i1, f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<1x6x34x62xf32>, tensor<3x3xf32>, tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    "func.return"(%4) : (tensor<1x4x32x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

