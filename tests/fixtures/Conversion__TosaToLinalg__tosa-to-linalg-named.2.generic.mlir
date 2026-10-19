#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xf32>, tensor<1x3x6xf32>) -> tensor<1x5x6xf32>, sym_name = "matmul"}> ({
  ^bb0(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x6xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<1x5x6xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    %3 = "linalg.batch_matmul"(%arg0, %arg1, %2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %4 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.addf"(%arg4, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<1x5x3xf32>, tensor<1x3x6xf32>, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    "func.return"(%3) : (tensor<1x5x6xf32>) -> ()
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
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "tensor.empty"() : () -> tensor<1x5x6xi32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<1x5x6xi32>) -> tensor<1x5x6xi32>
    %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "linalg.quantized_batch_matmul"(%arg0, %arg1, %3, %4, %2) <{operandSegmentSizes = array<i32: 4, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8, %arg4: i32, %arg5: i32, %arg6: i32):
      %6 = "arith.extsi"(%arg2) : (i8) -> i32
      %7 = "arith.subi"(%6, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "arith.extsi"(%arg3) : (i8) -> i32
      %9 = "arith.subi"(%8, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.muli"(%7, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %11 = "arith.addi"(%arg6, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%11) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2, #map2, #map3]} : (tensor<1x5x3xi8>, tensor<1x3x6xi8>, i32, i32, tensor<1x5x6xi32>) -> tensor<1x5x6xi32>
    "func.return"(%5) : (tensor<1x5x6xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x5x3xf32>, tensor<?x3x6xf32>) -> tensor<?x5x6xf32>, sym_name = "matmul_dyn_batch"}> ({
  ^bb0(%arg0: tensor<?x5x3xf32>, %arg1: tensor<?x3x6xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x5x3xf32>, index) -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.empty"(%1) : (index) -> tensor<?x5x6xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<?x5x6xf32>) -> tensor<?x5x6xf32>
    %5 = "linalg.batch_matmul"(%arg0, %arg1, %4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %6 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg4, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<?x5x3xf32>, tensor<?x3x6xf32>, tensor<?x5x6xf32>) -> tensor<?x5x6xf32>
    "func.return"(%5) : (tensor<?x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x3xf32>, tensor<1x3x?xf32>) -> tensor<1x5x?xf32>, sym_name = "matmul_dyn_independent_dim"}> ({
  ^bb0(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "tensor.dim"(%arg1, %0) : (tensor<1x3x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.empty"(%1) : (index) -> tensor<1x5x?xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1x5x?xf32>) -> tensor<1x5x?xf32>
    %5 = "linalg.batch_matmul"(%arg0, %arg1, %4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %6 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg4, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<1x5x3xf32>, tensor<1x3x?xf32>, tensor<1x5x?xf32>) -> tensor<1x5x?xf32>
    "func.return"(%5) : (tensor<1x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x?xf32>, tensor<1x?x6xf32>) -> tensor<1x5x6xf32>, sym_name = "matmul_dyn_independent_dim"}> ({
  ^bb0(%arg0: tensor<1x5x?xf32>, %arg1: tensor<1x?x6xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<1x5x6xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    %3 = "linalg.batch_matmul"(%arg0, %arg1, %2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %4 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.addf"(%arg4, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<1x5x?xf32>, tensor<1x?x6xf32>, tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    "func.return"(%3) : (tensor<1x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x8xf32>, tensor<1x8x1xf32>) -> tensor<?x1x1xf32>, sym_name = "matmul_dyn_output"}> ({
  ^bb0(%arg0: tensor<1x1x8xf32>, %arg1: tensor<1x8x1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<1x1x8xf32>, index) -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.empty"(%1) : (index) -> tensor<?x1x1xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<?x1x1xf32>) -> tensor<?x1x1xf32>
    %5 = "linalg.batch_matmul"(%arg0, %arg1, %4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %6 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg4, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<1x1x8xf32>, tensor<1x8x1xf32>, tensor<?x1x1xf32>) -> tensor<?x1x1xf32>
    "func.return"(%5) : (tensor<?x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> (), sym_name = "max_pool"}> ({
  ^bb0(%arg35: tensor<1x6x34x62xf32>):
    %63 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %64 = "tensor.empty"() : () -> tensor<1x4x32x62xf32>
    %65 = "linalg.fill"(%63, %64) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: f32, %arg37: f32):
      "linalg.yield"(%arg36) : (f32) -> ()
    }) : (f32, tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    %66 = "tensor.empty"() : () -> tensor<3x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xf32>) -> (), sym_name = "max_pool_padded"}> ({
  ^bb0(%arg28: tensor<1x6x34x62xf32>):
    %58 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %59 = "tensor.pad"(%arg28) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 0, 1, 0>, static_low = array<i64: 0, 0, 0, 0>}> ({
    ^bb0(%arg31: index, %arg32: index, %arg33: index, %arg34: index):
      "tensor.yield"(%58) : (f32) -> ()
    }) : (tensor<1x6x34x62xf32>) -> tensor<1x6x35x62xf32>
    %60 = "tensor.empty"() : () -> tensor<1x4x33x62xf32>
    %61 = "linalg.fill"(%58, %60) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: f32, %arg30: f32):
      "linalg.yield"(%arg29) : (f32) -> ()
    }) : (f32, tensor<1x4x33x62xf32>) -> tensor<1x4x33x62xf32>
    %62 = "tensor.empty"() : () -> tensor<3x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x6x34x62xf32>) -> (), sym_name = "max_pool_dyn"}> ({
  ^bb0(%arg25: tensor<?x6x34x62xf32>):
    %52 = "arith.constant"() <{value = 0 : index}> : () -> index
    %53 = "tensor.dim"(%arg25, %52) : (tensor<?x6x34x62xf32>, index) -> index
    %54 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %55 = "tensor.empty"(%53) : (index) -> tensor<?x4x32x62xf32>
    %56 = "linalg.fill"(%54, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32):
      "linalg.yield"(%arg26) : (f32) -> ()
    }) : (f32, tensor<?x4x32x62xf32>) -> tensor<?x4x32x62xf32>
    %57 = "tensor.empty"() : () -> tensor<3x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi8>) -> (), sym_name = "max_pool_i8"}> ({
  ^bb0(%arg22: tensor<1x6x34x62xi8>):
    %48 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %49 = "tensor.empty"() : () -> tensor<1x4x32x62xi8>
    %50 = "linalg.fill"(%48, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i8, %arg24: i8):
      "linalg.yield"(%arg23) : (i8) -> ()
    }) : (i8, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %51 = "tensor.empty"() : () -> tensor<3x3xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xui8>) -> tensor<1x4x32x62xui8>, sym_name = "max_pool_ui8"}> ({
  ^bb0(%arg16: tensor<1x6x34x62xui8>):
    %40 = "builtin.unrealized_conversion_cast"(%arg16) : (tensor<1x6x34x62xui8>) -> tensor<1x6x34x62xi8>
    %41 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %42 = "tensor.empty"() : () -> tensor<1x4x32x62xi8>
    %43 = "linalg.fill"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i8, %arg21: i8):
      "linalg.yield"(%arg20) : (i8) -> ()
    }) : (i8, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %44 = "tensor.empty"() : () -> tensor<3x3xi8>
    %45 = "linalg.pooling_nhwc_max_unsigned"(%40, %44, %43) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg17: i8, %arg18: i8, %arg19: i8):
      %47 = "arith.maxui"(%arg19, %arg17) : (i8, i8) -> i8
      "linalg.yield"(%47) : (i8) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x6x34x62xi8>, tensor<3x3xi8>, tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %46 = "builtin.unrealized_conversion_cast"(%45) : (tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xui8>
    "func.return"(%46) : (tensor<1x4x32x62xui8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi16>) -> (), sym_name = "max_pool_i16"}> ({
  ^bb0(%arg13: tensor<1x6x34x62xi16>):
    %36 = "arith.constant"() <{value = -32768 : i16}> : () -> i16
    %37 = "tensor.empty"() : () -> tensor<1x4x32x62xi16>
    %38 = "linalg.fill"(%36, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: i16, %arg15: i16):
      "linalg.yield"(%arg14) : (i16) -> ()
    }) : (i16, tensor<1x4x32x62xi16>) -> tensor<1x4x32x62xi16>
    %39 = "tensor.empty"() : () -> tensor<3x3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x6x34x62xi32>) -> (), sym_name = "max_pool_i32"}> ({
  ^bb0(%arg10: tensor<1x6x34x62xi32>):
    %32 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %33 = "tensor.empty"() : () -> tensor<1x4x32x62xi32>
    %34 = "linalg.fill"(%32, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<1x4x32x62xi32>) -> tensor<1x4x32x62xi32>
    %35 = "tensor.empty"() : () -> tensor<3x3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>, sym_name = "max_pool_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.addi"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.addi"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.subi"(%4, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "arith.muli"(%2, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.addi"(%8, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.subi"(%6, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.divui"(%10, %2) : (index, index) -> index
    %12 = "arith.addi"(%11, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "tensor.dim"(%arg0, %4) : (tensor<?x?x?x?xf32>, index) -> index
    %14 = "arith.constant"() <{value = 5 : index}> : () -> index
    %15 = "arith.addi"(%13, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "arith.addi"(%15, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "arith.subi"(%14, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "arith.muli"(%2, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "arith.addi"(%18, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "arith.subi"(%16, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "arith.divui"(%20, %2) : (index, index) -> index
    %22 = "arith.addi"(%21, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.constant"() <{value = 3 : index}> : () -> index
    %24 = "tensor.dim"(%arg0, %23) : (tensor<?x?x?x?xf32>, index) -> index
    %25 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %26 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 0, 2, 0>, static_low = array<i64: 0, 0, 2, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index):
      "tensor.yield"(%25) : (f32) -> ()
    }) : (tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    %27 = "tensor.empty"(%1, %12, %22, %24) : (index, index, index, index) -> tensor<?x?x?x?xf32>
    %28 = "linalg.fill"(%25, %27) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    %29 = "tensor.empty"() : () -> tensor<2x5xf32>
    %30 = "linalg.pooling_nhwc_max"(%26, %29, %28) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %31 = "arith.maximumf"(%arg3, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%31) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x?x?x?xf32>, tensor<2x5xf32>, tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    "func.return"(%30) : (tensor<?x?x?x?xf32>) -> ()
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
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<1x6x34x62xf32>) -> tensor<1x8x36x62xf32>
    %2 = "tensor.empty"() : () -> tensor<1x5x33x62xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %4 = "tensor.empty"() : () -> tensor<4x4xf32>
    %5 = "linalg.pooling_nhwc_sum"(%1, %4, %3) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %41 = "arith.addf"(%arg5, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%41) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x8x36x62xf32>, tensor<4x4xf32>, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "tensor.dim"(%5, %6) : (tensor<1x5x33x62xf32>, index) -> index
    %8 = "arith.constant"() <{value = 2 : index}> : () -> index
    %9 = "tensor.dim"(%5, %8) : (tensor<1x5x33x62xf32>, index) -> index
    %10 = "arith.subi"(%7, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.subi"(%9, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "linalg.generic"(%5, %2) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      %14 = "arith.constant"() <{value = 4 : index}> : () -> index
      %15 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %16 = "arith.subi"(%10, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %17 = "arith.muli"(%15, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.muli"(%16, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.subi"(%17, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.minsi"(%19, %13) : (index, index) -> index
      %21 = "arith.addi"(%14, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "arith.subi"(%18, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.minsi"(%22, %13) : (index, index) -> index
      %24 = "arith.addi"(%21, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.maxsi"(%6, %24) : (index, index) -> index
      %26 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %27 = "arith.subi"(%11, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %28 = "arith.muli"(%26, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.muli"(%27, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.subi"(%28, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.minsi"(%30, %13) : (index, index) -> index
      %32 = "arith.addi"(%14, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.subi"(%29, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %34 = "arith.minsi"(%33, %13) : (index, index) -> index
      %35 = "arith.addi"(%32, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.maxsi"(%6, %35) : (index, index) -> index
      %37 = "arith.muli"(%25, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.index_cast"(%37) : (index) -> i32
      %39 = "arith.sitofp"(%38) : (i32) -> f32
      %40 = "arith.divf"(%arg1, %39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%40) : (f32) -> ()
    }) : (tensor<1x5x33x62xf32>, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    "func.return"(%12) : (tensor<1x5x33x62xf32>) -> ()
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
    %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %1 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%0) : (f16) -> ()
    }) : (tensor<1x6x34x62xf16>) -> tensor<1x8x36x62xf16>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.empty"() : () -> tensor<1x5x33x62xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %5 = "tensor.empty"() : () -> tensor<4x4xf32>
    %6 = "linalg.pooling_nhwc_sum"(%1, %5, %4) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: f16, %arg4: f32, %arg5: f32):
      %44 = "arith.extf"(%arg3) : (f16) -> f32
      %45 = "arith.addf"(%arg5, %44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%45) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x8x36x62xf16>, tensor<4x4xf32>, tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "tensor.dim"(%6, %7) : (tensor<1x5x33x62xf32>, index) -> index
    %9 = "arith.constant"() <{value = 2 : index}> : () -> index
    %10 = "tensor.dim"(%6, %9) : (tensor<1x5x33x62xf32>, index) -> index
    %11 = "arith.subi"(%8, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "arith.subi"(%10, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "tensor.empty"() : () -> tensor<1x5x33x62xf16>
    %14 = "linalg.generic"(%6, %13) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f16):
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "arith.constant"() <{value = 4 : index}> : () -> index
      %17 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %18 = "arith.subi"(%11, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.muli"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.muli"(%18, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "arith.subi"(%19, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "arith.minsi"(%21, %15) : (index, index) -> index
      %23 = "arith.addi"(%16, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.subi"(%20, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.minsi"(%24, %15) : (index, index) -> index
      %26 = "arith.addi"(%23, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.maxsi"(%7, %26) : (index, index) -> index
      %28 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %29 = "arith.subi"(%12, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.muli"(%28, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.muli"(%29, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %32 = "arith.subi"(%30, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.minsi"(%32, %15) : (index, index) -> index
      %34 = "arith.addi"(%16, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "arith.subi"(%31, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.minsi"(%35, %15) : (index, index) -> index
      %37 = "arith.addi"(%34, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.maxsi"(%7, %37) : (index, index) -> index
      %39 = "arith.muli"(%27, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.index_cast"(%39) : (index) -> i32
      %41 = "arith.sitofp"(%40) : (i32) -> f32
      %42 = "arith.divf"(%arg1, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %43 = "arith.truncf"(%42) : (f32) -> f16
      "linalg.yield"(%43) : (f16) -> ()
    }) : (tensor<1x5x33x62xf32>, tensor<1x5x33x62xf16>) -> tensor<1x5x33x62xf16>
    "func.return"(%14) : (tensor<1x5x33x62xf16>) -> ()
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
    %0 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%0) : (i8) -> ()
    }) : (tensor<1x6x34x62xi8>) -> tensor<1x8x36x62xi8>
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "tensor.empty"() : () -> tensor<1x5x33x62xi32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<1x5x33x62xi32>) -> tensor<1x5x33x62xi32>
    %5 = "tensor.empty"() : () -> tensor<4x4xi32>
    %6 = "linalg.pooling_nhwc_sum"(%1, %5, %4) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: i8, %arg4: i32, %arg5: i32):
      %61 = "arith.extsi"(%arg3) : (i8) -> i32
      %62 = "arith.addi"(%arg5, %61) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%62) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x8x36x62xi8>, tensor<4x4xi32>, tensor<1x5x33x62xi32>) -> tensor<1x5x33x62xi32>
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "tensor.dim"(%6, %7) : (tensor<1x5x33x62xi32>, index) -> index
    %9 = "arith.constant"() <{value = 2 : index}> : () -> index
    %10 = "tensor.dim"(%6, %9) : (tensor<1x5x33x62xi32>, index) -> index
    %11 = "arith.subi"(%8, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "arith.subi"(%10, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "tensor.empty"() : () -> tensor<1x5x33x62xi8>
    %14 = "linalg.generic"(%6, %13) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i8):
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "arith.constant"() <{value = 4 : index}> : () -> index
      %17 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %18 = "arith.subi"(%11, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.muli"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.muli"(%18, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "arith.subi"(%19, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "arith.minsi"(%21, %15) : (index, index) -> index
      %23 = "arith.addi"(%16, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.subi"(%20, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.minsi"(%24, %15) : (index, index) -> index
      %26 = "arith.addi"(%23, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.maxsi"(%7, %26) : (index, index) -> index
      %28 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %29 = "arith.subi"(%12, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.muli"(%28, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.muli"(%29, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %32 = "arith.subi"(%30, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.minsi"(%32, %15) : (index, index) -> index
      %34 = "arith.addi"(%16, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "arith.subi"(%31, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.minsi"(%35, %15) : (index, index) -> index
      %37 = "arith.addi"(%34, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.maxsi"(%7, %37) : (index, index) -> index
      %39 = "arith.muli"(%27, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.index_cast"(%39) : (index) -> i32
      %41 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %42 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %43 = "arith.subi"(%40, %41) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %44 = "math.ctlz"(%43) : (i32) -> i32
      %45 = "arith.subi"(%42, %44) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %46 = "arith.extui"(%45) : (i32) -> i64
      %47 = "arith.constant"() <{value = 1073741825 : i64}> : () -> i64
      %48 = "arith.shli"(%47, %46) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %49 = "arith.extui"(%40) : (i32) -> i64
      %50 = "arith.divui"(%48, %49) : (i64, i64) -> i64
      %51 = "arith.trunci"(%50) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %52 = "arith.trunci"(%45) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      %53 = "arith.constant"() <{value = 30 : i8}> : () -> i8
      %54 = "arith.addi"(%52, %53) <{overflowFlags = #arith.overflow<none>}> : (i8, i8) -> i8
      %55 = "tosa.apply_scale"(%arg1, %51, %54) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %56 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %57 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %58 = "arith.maxsi"(%56, %55) : (i32, i32) -> i32
      %59 = "arith.minsi"(%57, %58) : (i32, i32) -> i32
      %60 = "arith.trunci"(%59) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%60) : (i8) -> ()
    }) : (tensor<1x5x33x62xi32>, tensor<1x5x33x62xi8>) -> tensor<1x5x33x62xi8>
    "func.return"(%14) : (tensor<1x5x33x62xi8>) -> ()
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
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x6x34x62xf32>, index) -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%2) : (f32) -> ()
    }) : (tensor<?x6x34x62xf32>) -> tensor<?x8x36x62xf32>
    %4 = "tensor.empty"(%1) : (index) -> tensor<?x5x33x62xf32>
    %5 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    %6 = "tensor.empty"() : () -> tensor<4x4xf32>
    %7 = "linalg.pooling_nhwc_sum"(%3, %6, %5) <{dilations = dense<1> : vector<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : vector<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %42 = "arith.addf"(%arg5, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%42) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x8x36x62xf32>, tensor<4x4xf32>, tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "tensor.dim"(%7, %8) : (tensor<?x5x33x62xf32>, index) -> index
    %10 = "arith.constant"() <{value = 2 : index}> : () -> index
    %11 = "tensor.dim"(%7, %10) : (tensor<?x5x33x62xf32>, index) -> index
    %12 = "arith.subi"(%9, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "arith.subi"(%11, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "linalg.generic"(%7, %4) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %15 = "arith.constant"() <{value = 4 : index}> : () -> index
      %16 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %17 = "arith.subi"(%12, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.muli"(%16, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.muli"(%17, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.subi"(%18, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "arith.minsi"(%20, %0) : (index, index) -> index
      %22 = "arith.addi"(%15, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.subi"(%19, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.minsi"(%23, %0) : (index, index) -> index
      %25 = "arith.addi"(%22, %24) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %26 = "arith.maxsi"(%8, %25) : (index, index) -> index
      %27 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %28 = "arith.subi"(%13, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.muli"(%27, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.muli"(%28, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.subi"(%29, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %32 = "arith.minsi"(%31, %0) : (index, index) -> index
      %33 = "arith.addi"(%15, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %34 = "arith.subi"(%30, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "arith.minsi"(%34, %0) : (index, index) -> index
      %36 = "arith.addi"(%33, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.maxsi"(%8, %36) : (index, index) -> index
      %38 = "arith.muli"(%26, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.index_cast"(%38) : (index) -> i32
      %40 = "arith.sitofp"(%39) : (i32) -> f32
      %41 = "arith.divf"(%arg1, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%41) : (f32) -> ()
    }) : (tensor<?x5x33x62xf32>, tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    "func.return"(%14) : (tensor<?x5x33x62xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<1xf32>) -> (), sym_name = "conv2d_scalar_bias_f32"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<1xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %1 = "linalg.generic"(%arg2, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xi8>, tensor<28x1x1x27xi8>, tensor<28xi8>) -> (), sym_name = "conv2d_i8"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xi8>, %arg1: tensor<28x1x1x27xi8>, %arg2: tensor<28xi8>):
    %0 = "tensor.empty"() : () -> tensor<1x49x42x28xi32>
    %1 = "linalg.generic"(%arg2, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i8, %arg4: i32):
      %2 = "arith.extsi"(%arg3) : (i8) -> i32
      "linalg.yield"(%2) : (i32) -> ()
    }) : (tensor<28xi8>, tensor<1x49x42x28xi32>) -> tensor<1x49x42x28xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_f32"}> ({
  ^bb0(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %1 = "linalg.generic"(%arg2, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x49x42x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_dyn"}> ({
  ^bb0(%arg0: tensor<?x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x49x42x27xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?x45x40x28xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<?x45x40x28xf32>) -> tensor<?x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x?x27xf32>, tensor<28x3x3x27xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_dyn_w_h"}> ({
  ^bb0(%arg0: tensor<1x?x?x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<1x?x?x27xf32>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<28x3x3x27xf32>, index) -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.addi"(%1, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.addi"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.subi"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.constant"() <{value = 2 : index}> : () -> index
    %8 = "arith.muli"(%7, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.addi"(%8, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.subi"(%5, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.divui"(%10, %0) : (index, index) -> index
    %12 = "arith.addi"(%11, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "tensor.dim"(%arg0, %7) : (tensor<1x?x?x27xf32>, index) -> index
    %14 = "tensor.dim"(%arg1, %7) : (tensor<28x3x3x27xf32>, index) -> index
    %15 = "arith.addi"(%13, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "arith.addi"(%15, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "arith.subi"(%14, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "arith.muli"(%0, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "arith.addi"(%18, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "arith.subi"(%16, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "arith.divui"(%20, %0) : (index, index) -> index
    %22 = "arith.addi"(%21, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "tensor.empty"(%12, %22) : (index, index) -> tensor<1x?x?x28xf32>
    %24 = "linalg.generic"(%arg2, %23) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<1x?x?x28xf32>) -> tensor<1x?x?x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x6x5x4xf32>, tensor<4x3x3x4xf32>, tensor<4xf32>) -> (), sym_name = "conv2d_dyn_output"}> ({
  ^bb0(%arg0: tensor<2x6x5x4xf32>, %arg1: tensor<4x3x3x4xf32>, %arg2: tensor<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<2x6x5x4xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?x4x3x4xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<4xf32>, tensor<?x4x3x4xf32>) -> tensor<?x4x3x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x47x40x28xf32>, tensor<28x3x3x28xf32>, tensor<28xf32>) -> (), sym_name = "conv2d_padded_f32"}> ({
  ^bb0(%arg0: tensor<1x47x40x28xf32>, %arg1: tensor<28x3x3x28xf32>, %arg2: tensor<28xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index, %arg8: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<1x47x40x28xf32>) -> tensor<1x49x42x28xf32>
    %2 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<28xf32>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12x1xi8>, tensor<1024x3x3x1xi8>, tensor<1024xi32>) -> (), sym_name = "conv2d_quant"}> ({
  ^bb0(%arg0: tensor<1x12x12x1xi8>, %arg1: tensor<1024x3x3x1xi8>, %arg2: tensor<1024xi32>):
    %0 = "arith.constant"() <{value = -22 : i8}> : () -> i8
    %1 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index, %arg8: index):
      "tensor.yield"(%0) : (i8) -> ()
    }) : (tensor<1x12x12x1xi8>) -> tensor<1x14x14x1xi8>
    %2 = "tensor.empty"() : () -> tensor<1x12x12x1024xi32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32):
      "linalg.yield"(%arg3) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1x12x12x1024xi32>) -> tensor<1x12x12x1024xi32>
    %4 = "arith.constant"() <{value = -22 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 42 : i32}> : () -> i32
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
    %0 = "tensor.empty"() : () -> tensor<1x45x40x28xf32>
    %1 = "linalg.generic"(%arg2, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f16, %arg7: f32):
      %7 = "arith.extf"(%arg6) : (f16) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<28xf16>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    %2 = "linalg.conv_2d_nhwc_fhwc"(%arg0, %arg1, %1) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f16, %arg4: f16, %arg5: f32):
      %3 = "arith.extf"(%arg3) : (f16) -> f32
      %4 = "arith.extf"(%arg4) : (f16) -> f32
      %5 = "arith.mulf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg5, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x42x27xf16>, tensor<28x3x3x27xf16>, tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %3 = "tensor.empty"() : () -> tensor<1x5x5x33xf32>
    %4 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %2) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %6 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tensor.collapse_shape"(%4) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1xf32>) -> (), sym_name = "depthwise_conv_scalar_bias"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<1xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %3 = "tensor.empty"() : () -> tensor<1x5x5x33xf32>
    %4 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %2) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %6 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tensor.collapse_shape"(%4) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv_dyn"}> ({
  ^bb0(%arg0: tensor<?x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x7x5x3xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?x5x5x3x11xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x3x11xf32>
    %5 = "tensor.empty"(%1) : (index) -> tensor<?x5x5x33xf32>
    %6 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %4) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %8 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.addf"(%arg5, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x7x5x3xf32>, tensor<3x1x3x11xf32>, tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x3x11xf32>
    %7 = "tensor.collapse_shape"(%6) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 * 2 + d5, d2 * 2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x11x9x3xf32>, tensor<3x1x3x11xf32>, tensor<33xf32>) -> (), sym_name = "depthwise_conv_strides"}> ({
  ^bb0(%arg0: tensor<1x11x9x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %3 = "tensor.empty"() : () -> tensor<1x5x5x33xf32>
    %4 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %2) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<2> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %6 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x11x9x3xf32>, tensor<3x1x3x11xf32>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tensor.collapse_shape"(%4) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x33xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> ()>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x12x12x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>) -> (), sym_name = "depthwise_conv_quant"}> ({
  ^bb0(%arg0: tensor<1x12x12x4xi8>, %arg1: tensor<3x3x4x128xi8>, %arg2: tensor<512xi32>):
    %0 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %1 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 1, 1, 0>, static_low = array<i64: 0, 1, 1, 0>}> ({
    ^bb0(%arg10: index, %arg11: index, %arg12: index, %arg13: index):
      "tensor.yield"(%0) : (i8) -> ()
    }) : (tensor<1x12x12x4xi8>) -> tensor<1x14x14x4xi8>
    %2 = "tensor.empty"() : () -> tensor<1x12x12x4x128xi32>
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      "linalg.yield"(%arg8) : (i32) -> ()
    }) : (i32, tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x4x128xi32>
    %5 = "tensor.empty"() : () -> tensor<1x12x12x512xi32>
    %6 = "arith.constant"() <{value = -128 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %8 = "linalg.depthwise_conv_2d_nhwc_hwcm_q"(%1, %arg1, %6, %7, %4) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 4, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: i8, %arg4: i8, %arg5: i32, %arg6: i32, %arg7: i32):
      %10 = "arith.extsi"(%arg3) : (i8) -> i32
      %11 = "arith.subi"(%10, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "arith.extsi"(%arg4) : (i8) -> i32
      %13 = "arith.subi"(%12, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.muli"(%11, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "arith.addi"(%arg7, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%15) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2, #map2, #map3]} : (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, i32, i32, tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x4x128xi32>
    %9 = "tensor.collapse_shape"(%8) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x512xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5 * 2, d2 + d6 * 2, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> ()>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5 * 2, d2 * 2 + d6, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, tensor<512xi32>) -> (), sym_name = "depthwise_conv_quant_dilations"}> ({
  ^bb0(%arg12: tensor<1x14x14x4xi8>, %arg13: tensor<3x3x4x128xi8>, %arg14: tensor<512xi32>):
    %34 = "tensor.empty"() : () -> tensor<1x10x10x4x128xi32>
    %35 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %36 = "linalg.fill"(%35, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32):
      "linalg.yield"(%arg20) : (i32) -> ()
    }) : (i32, tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x4x128xi32>
    %37 = "tensor.empty"() : () -> tensor<1x10x10x512xi32>
    %38 = "arith.constant"() <{value = -128 : i32}> : () -> i32
    %39 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %40 = "linalg.depthwise_conv_2d_nhwc_hwcm_q"(%arg12, %arg13, %38, %39, %36) <{dilations = dense<2> : tensor<2xi64>, operandSegmentSizes = array<i32: 4, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg15: i8, %arg16: i8, %arg17: i32, %arg18: i32, %arg19: i32):
      %42 = "arith.extsi"(%arg15) : (i8) -> i32
      %43 = "arith.subi"(%42, %arg17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %44 = "arith.extsi"(%arg16) : (i8) -> i32
      %45 = "arith.subi"(%44, %arg18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %46 = "arith.muli"(%43, %45) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %47 = "arith.addi"(%arg19, %46) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%47) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2, #map2, #map3]} : (tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, i32, i32, tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x4x128xi32>
    %41 = "tensor.collapse_shape"(%40) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x512xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<2x?x?x3xf32>, tensor<3x6x3x5xf32>, tensor<15xf32>) -> (), sym_name = "depthwise_conv2d_dyn_w_h"}> ({
  ^bb0(%arg0: tensor<2x?x?x3xf32>, %arg1: tensor<3x6x3x5xf32>, %arg2: tensor<15xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<2x?x?x3xf32>, index) -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg1, %2) : (tensor<3x6x3x5xf32>, index) -> index
    %4 = "arith.addi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.subi"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "arith.muli"(%5, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.addi"(%8, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.subi"(%6, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.divui"(%10, %0) : (index, index) -> index
    %12 = "arith.addi"(%11, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "tensor.dim"(%arg0, %5) : (tensor<2x?x?x3xf32>, index) -> index
    %14 = "tensor.dim"(%arg1, %0) : (tensor<3x6x3x5xf32>, index) -> index
    %15 = "arith.constant"() <{value = 3 : index}> : () -> index
    %16 = "arith.addi"(%13, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "arith.constant"() <{value = 4 : index}> : () -> index
    %18 = "arith.addi"(%16, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "arith.subi"(%14, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "arith.muli"(%0, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "arith.addi"(%20, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.subi"(%18, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.divui"(%22, %5) : (index, index) -> index
    %24 = "arith.addi"(%23, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %26 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 2, 4, 0>, static_low = array<i64: 0, 1, 3, 0>}> ({
    ^bb0(%arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "tensor.yield"(%25) : (f32) -> ()
    }) : (tensor<2x?x?x3xf32>) -> tensor<2x?x?x3xf32>
    %27 = "tensor.empty"(%12, %24) : (index, index) -> tensor<2x?x?x3x5xf32>
    %28 = "linalg.fill"(%25, %27) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x3x5xf32>
    %29 = "tensor.empty"(%12, %24) : (index, index) -> tensor<2x?x?x15xf32>
    %30 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%26, %arg1, %28) <{dilations = dense<[2, 1]> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<[1, 2]> : tensor<2xi64>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %32 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %33 = "arith.addf"(%arg5, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map4, #map1, #map3]} : (tensor<2x?x?x3xf32>, tensor<3x6x3x5xf32>, tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x3x5xf32>
    %31 = "tensor.collapse_shape"(%30) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x15xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xi8>, tensor<3x1x3x11xi8>, tensor<33xi32>) -> (), sym_name = "depthwise_int_conv_zero_zp"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xi8>, %arg1: tensor<3x1x3x11xi8>, %arg2: tensor<33xi32>):
    %0 = "tensor.empty"() : () -> tensor<1x5x5x3x11xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x3x11xi32>
    %3 = "tensor.empty"() : () -> tensor<1x5x5x33xi32>
    %4 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %2) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: i8, %arg4: i8, %arg5: i32):
      %6 = "arith.extsi"(%arg3) : (i8) -> i32
      %7 = "arith.extsi"(%arg4) : (i8) -> i32
      %8 = "arith.muli"(%6, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.addi"(%arg5, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%9) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xi8>, tensor<3x1x3x11xi8>, tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x3x11xi32>
    %5 = "tensor.collapse_shape"(%4) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x33xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d5, d2 + d6, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d5, d6, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x7x5x3xf16>, tensor<3x1x3x11xf16>, tensor<33xf16>) -> (), sym_name = "depthwise_conv2d_f16_f32_acc"}> ({
  ^bb0(%arg0: tensor<1x7x5x3xf16>, %arg1: tensor<3x1x3x11xf16>, %arg2: tensor<33xf16>):
    %0 = "tensor.empty"() : () -> tensor<1x5x5x3x11xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %3 = "tensor.empty"() : () -> tensor<1x5x5x33xf16>
    %4 = "linalg.depthwise_conv_2d_nhwc_hwcm"(%arg0, %arg1, %2) <{dilations = dense<1> : tensor<2xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<2xi64>}> ({
    ^bb0(%arg3: f16, %arg4: f16, %arg5: f32):
      %7 = "arith.extf"(%arg3) : (f16) -> f32
      %8 = "arith.extf"(%arg4) : (f16) -> f32
      %9 = "arith.mulf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<1x7x5x3xf16>, tensor<3x1x3x11xf16>, tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %5 = "tosa.cast"(%4) : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf16>
    %6 = "tensor.collapse_shape"(%5) <{reassociation = [[0], [1], [2], [3, 4]]}> : (tensor<1x5x5x3x11xf16>) -> tensor<1x5x5x33xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf32>, tensor<43x3x4x5x27xf32>, tensor<43xf32>) -> (), sym_name = "conv3d_f32"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<43x3x4x5x27xf32>, %arg2: tensor<43xf32>):
    %0 = "tensor.empty"() : () -> tensor<3x4x5x27x43xf32>
    %1 = "linalg.transpose"(%arg1, %0) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<43x3x4x5x27xf32>, tensor<3x4x5x27x43xf32>) -> tensor<3x4x5x27x43xf32>
    %2 = "tensor.empty"() : () -> tensor<1x47x45x43x43xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<43xf32>, tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (0)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xf32>, tensor<28x3x4x5x27xf32>, tensor<1xf32>) -> (), sym_name = "conv3d_scalar_bias_f32"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<28x3x4x5x27xf32>, %arg2: tensor<1xf32>):
    %0 = "tensor.empty"() : () -> tensor<3x4x5x27x28xf32>
    %1 = "linalg.transpose"(%arg1, %0) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<28x3x4x5x27xf32>, tensor<3x4x5x27x28xf32>) -> tensor<3x4x5x27x28xf32>
    %2 = "tensor.empty"() : () -> tensor<1x47x45x43x28xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1x47x45x43x28xf32>) -> tensor<1x47x45x43x28xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x49x48x47x27xi8>, tensor<43x3x4x5x27xi8>, tensor<43xi32>) -> (), sym_name = "conv3d_i8"}> ({
  ^bb0(%arg0: tensor<1x49x48x47x27xi8>, %arg1: tensor<43x3x4x5x27xi8>, %arg2: tensor<43xi32>):
    %0 = "tensor.empty"() : () -> tensor<3x4x5x27x43xi8>
    %1 = "linalg.transpose"(%arg1, %0) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg5: i8, %arg6: i8):
      "linalg.yield"(%arg5) : (i8) -> ()
    }) : (tensor<43x3x4x5x27xi8>, tensor<3x4x5x27x43xi8>) -> tensor<3x4x5x27x43xi8>
    %2 = "tensor.empty"() : () -> tensor<1x47x45x43x43xi32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32):
      "linalg.yield"(%arg3) : (i32) -> ()
    }) : (tensor<43xi32>, tensor<1x47x45x43x43xi32>) -> tensor<1x47x45x43x43xi32>
    %4 = "arith.constant"() <{value = -128 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 42 : i32}> : () -> i32
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
    %0 = "tensor.empty"() : () -> tensor<3x4x5x27x43xf16>
    %1 = "linalg.transpose"(%arg1, %0) <{permutation = array<i64: 1, 2, 3, 4, 0>}> ({
    ^bb0(%arg8: f16, %arg9: f16):
      "linalg.yield"(%arg8) : (f16) -> ()
    }) : (tensor<43x3x4x5x27xf16>, tensor<3x4x5x27x43xf16>) -> tensor<3x4x5x27x43xf16>
    %2 = "tensor.empty"() : () -> tensor<1x47x45x43x43xf32>
    %3 = "linalg.generic"(%arg2, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f16, %arg7: f32):
      %9 = "arith.extf"(%arg6) : (f16) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<43xf16>, tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    %4 = "linalg.conv_3d_ndhwc_dhwcf"(%arg0, %1, %3) <{dilations = dense<1> : tensor<3xi64>, operandSegmentSizes = array<i32: 2, 1>, strides = dense<1> : tensor<3xi64>}> ({
    ^bb0(%arg3: f16, %arg4: f16, %arg5: f32):
      %5 = "arith.extf"(%arg3) : (f16) -> f32
      %6 = "arith.extf"(%arg4) : (f16) -> f32
      %7 = "arith.mulf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg5, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map2, #map3, #map4]} : (tensor<1x49x48x47x27xf16>, tensor<3x4x5x27x43xf16>, tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xi32>) -> (), sym_name = "test_transpose"}> ({
  ^bb0(%arg0: tensor<1x2x3xi32>):
    %0 = "tensor.empty"() : () -> tensor<2x3x1xi32>
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

