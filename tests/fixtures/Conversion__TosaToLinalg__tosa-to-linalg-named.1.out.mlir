module {
  func.func @matmul(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x6xf32>) -> tensor<1x5x6xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty() : tensor<1x5x6xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    %4 = linalg.batch_matmul ins(%arg0, %arg1 : tensor<1x5x3xf32>, tensor<1x3x6xf32>) outs(%3 : tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    return %4 : tensor<1x5x6xf32>
  }
}

// -----
module {
  func.func @matmul_quantized(%arg0: tensor<1x5x3xi8>, %arg1: tensor<1x3x6xi8>) -> tensor<1x5x6xi32> {
    %0 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<2> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c0_i32 = arith.constant 0 : i32
    %2 = tensor.empty() : tensor<1x5x6xi32>
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x5x6xi32>) -> tensor<1x5x6xi32>
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %4 = linalg.quantized_batch_matmul ins(%arg0, %arg1, %c1_i32, %c2_i32 : tensor<1x5x3xi8>, tensor<1x3x6xi8>, i32, i32) outs(%3 : tensor<1x5x6xi32>) -> tensor<1x5x6xi32>
    return %4 : tensor<1x5x6xi32>
  }
}

// -----
module {
  func.func @matmul_dyn_batch(%arg0: tensor<?x5x3xf32>, %arg1: tensor<?x3x6xf32>) -> tensor<?x5x6xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x5x3xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty(%dim) : tensor<?x5x6xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<?x5x6xf32>) -> tensor<?x5x6xf32>
    %4 = linalg.batch_matmul ins(%arg0, %arg1 : tensor<?x5x3xf32>, tensor<?x3x6xf32>) outs(%3 : tensor<?x5x6xf32>) -> tensor<?x5x6xf32>
    return %4 : tensor<?x5x6xf32>
  }
}

// -----
module {
  func.func @matmul_dyn_independent_dim(%arg0: tensor<1x5x3xf32>, %arg1: tensor<1x3x?xf32>) -> tensor<1x5x?xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c2 = arith.constant 2 : index
    %dim = tensor.dim %arg1, %c2 : tensor<1x3x?xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty(%dim) : tensor<1x5x?xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x5x?xf32>) -> tensor<1x5x?xf32>
    %4 = linalg.batch_matmul ins(%arg0, %arg1 : tensor<1x5x3xf32>, tensor<1x3x?xf32>) outs(%3 : tensor<1x5x?xf32>) -> tensor<1x5x?xf32>
    return %4 : tensor<1x5x?xf32>
  }
}

// -----
module {
  func.func @matmul_dyn_independent_dim(%arg0: tensor<1x5x?xf32>, %arg1: tensor<1x?x6xf32>) -> tensor<1x5x6xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty() : tensor<1x5x6xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    %4 = linalg.batch_matmul ins(%arg0, %arg1 : tensor<1x5x?xf32>, tensor<1x?x6xf32>) outs(%3 : tensor<1x5x6xf32>) -> tensor<1x5x6xf32>
    return %4 : tensor<1x5x6xf32>
  }
}

// -----
module {
  func.func @matmul_dyn_output(%arg0: tensor<1x1x8xf32>, %arg1: tensor<1x8x1xf32>) -> tensor<?x1x1xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<1x1x8xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty(%dim) : tensor<?x1x1xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<?x1x1xf32>) -> tensor<?x1x1xf32>
    %4 = linalg.batch_matmul ins(%arg0, %arg1 : tensor<1x1x8xf32>, tensor<1x8x1xf32>) outs(%3 : tensor<?x1x1xf32>) -> tensor<?x1x1xf32>
    return %4 : tensor<?x1x1xf32>
  }
}

// -----
module {
  func.func @max_pool(%arg0: tensor<1x6x34x62xf32>) {
    %cst = arith.constant -3.40282347E+38 : f32
    %0 = tensor.empty() : tensor<1x4x32x62xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    %2 = tensor.empty() : tensor<3x3xf32>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x6x34x62xf32>, tensor<3x3xf32>) outs(%1 : tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    return
  }
  func.func @max_pool_padded(%arg0: tensor<1x6x34x62xf32>) {
    %cst = arith.constant -3.40282347E+38 : f32
    %padded = tensor.pad %arg0 low[0, 0, 0, 0] high[0, 0, 1, 0] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<1x6x34x62xf32> to tensor<1x6x35x62xf32>
    %cst_0 = arith.constant -3.40282347E+38 : f32
    %0 = tensor.empty() : tensor<1x4x33x62xf32>
    %1 = linalg.fill ins(%cst_0 : f32) outs(%0 : tensor<1x4x33x62xf32>) -> tensor<1x4x33x62xf32>
    %2 = tensor.empty() : tensor<3x3xf32>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded, %2 : tensor<1x6x35x62xf32>, tensor<3x3xf32>) outs(%1 : tensor<1x4x33x62xf32>) -> tensor<1x4x33x62xf32>
    return
  }
  func.func @max_pool_dyn(%arg0: tensor<?x6x34x62xf32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x6x34x62xf32>
    %cst = arith.constant -3.40282347E+38 : f32
    %0 = tensor.empty(%dim) : tensor<?x4x32x62xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?x4x32x62xf32>) -> tensor<?x4x32x62xf32>
    %2 = tensor.empty() : tensor<3x3xf32>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<?x6x34x62xf32>, tensor<3x3xf32>) outs(%1 : tensor<?x4x32x62xf32>) -> tensor<?x4x32x62xf32>
    return
  }
  func.func @max_pool_i8(%arg0: tensor<1x6x34x62xi8>) {
    %c-128_i8 = arith.constant -128 : i8
    %0 = tensor.empty() : tensor<1x4x32x62xi8>
    %1 = linalg.fill ins(%c-128_i8 : i8) outs(%0 : tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %2 = tensor.empty() : tensor<3x3xi8>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x6x34x62xi8>, tensor<3x3xi8>) outs(%1 : tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    return
  }
  func.func @max_pool_ui8(%arg0: tensor<1x6x34x62xui8>) -> tensor<1x4x32x62xui8> {
    %0 = builtin.unrealized_conversion_cast %arg0 : tensor<1x6x34x62xui8> to tensor<1x6x34x62xi8>
    %c0_i8 = arith.constant 0 : i8
    %1 = tensor.empty() : tensor<1x4x32x62xi8>
    %2 = linalg.fill ins(%c0_i8 : i8) outs(%1 : tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %3 = tensor.empty() : tensor<3x3xi8>
    %4 = linalg.pooling_nhwc_max_unsigned {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%0, %3 : tensor<1x6x34x62xi8>, tensor<3x3xi8>) outs(%2 : tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %5 = builtin.unrealized_conversion_cast %4 : tensor<1x4x32x62xi8> to tensor<1x4x32x62xui8>
    return %5 : tensor<1x4x32x62xui8>
  }
  func.func @max_pool_i16(%arg0: tensor<1x6x34x62xi16>) {
    %c-32768_i16 = arith.constant -32768 : i16
    %0 = tensor.empty() : tensor<1x4x32x62xi16>
    %1 = linalg.fill ins(%c-32768_i16 : i16) outs(%0 : tensor<1x4x32x62xi16>) -> tensor<1x4x32x62xi16>
    %2 = tensor.empty() : tensor<3x3xi16>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x6x34x62xi16>, tensor<3x3xi16>) outs(%1 : tensor<1x4x32x62xi16>) -> tensor<1x4x32x62xi16>
    return
  }
  func.func @max_pool_i32(%arg0: tensor<1x6x34x62xi32>) {
    %c-2147483648_i32 = arith.constant -2147483648 : i32
    %0 = tensor.empty() : tensor<1x4x32x62xi32>
    %1 = linalg.fill ins(%c-2147483648_i32 : i32) outs(%0 : tensor<1x4x32x62xi32>) -> tensor<1x4x32x62xi32>
    %2 = tensor.empty() : tensor<3x3xi32>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x6x34x62xi32>, tensor<3x3xi32>) outs(%1 : tensor<1x4x32x62xi32>) -> tensor<1x4x32x62xi32>
    return
  }
  func.func @max_pool_all_dynamic(%arg0: tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?x?x?xf32>
    %c2 = arith.constant 2 : index
    %c1_1 = arith.constant 1 : index
    %c0_2 = arith.constant 0 : index
    %0 = arith.addi %dim_0, %c0_2 : index
    %c0_3 = arith.constant 0 : index
    %1 = arith.addi %0, %c0_3 : index
    %2 = arith.subi %c2, %c1_1 : index
    %c1_4 = arith.constant 1 : index
    %3 = arith.muli %c1_4, %2 : index
    %4 = arith.addi %3, %c1_1 : index
    %5 = arith.subi %1, %4 : index
    %c1_5 = arith.constant 1 : index
    %6 = arith.divui %5, %c1_5 : index
    %7 = arith.addi %6, %c1_1 : index
    %c2_6 = arith.constant 2 : index
    %dim_7 = tensor.dim %arg0, %c2_6 : tensor<?x?x?x?xf32>
    %c5 = arith.constant 5 : index
    %c1_8 = arith.constant 1 : index
    %c2_9 = arith.constant 2 : index
    %8 = arith.addi %dim_7, %c2_9 : index
    %c2_10 = arith.constant 2 : index
    %9 = arith.addi %8, %c2_10 : index
    %10 = arith.subi %c5, %c1_8 : index
    %c1_11 = arith.constant 1 : index
    %11 = arith.muli %c1_11, %10 : index
    %12 = arith.addi %11, %c1_8 : index
    %13 = arith.subi %9, %12 : index
    %c1_12 = arith.constant 1 : index
    %14 = arith.divui %13, %c1_12 : index
    %15 = arith.addi %14, %c1_8 : index
    %c3 = arith.constant 3 : index
    %dim_13 = tensor.dim %arg0, %c3 : tensor<?x?x?x?xf32>
    %cst = arith.constant -3.40282347E+38 : f32
    %padded = tensor.pad %arg0 low[0, 0, 2, 0] high[0, 0, 2, 0] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<?x?x?x?xf32> to tensor<?x?x?x?xf32>
    %cst_14 = arith.constant -3.40282347E+38 : f32
    %16 = tensor.empty(%dim, %7, %15, %dim_13) : tensor<?x?x?x?xf32>
    %17 = linalg.fill ins(%cst_14 : f32) outs(%16 : tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    %18 = tensor.empty() : tensor<2x5xf32>
    %19 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded, %18 : tensor<?x?x?x?xf32>, tensor<2x5xf32>) outs(%17 : tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    return %19 : tensor<?x?x?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @avg_pool_f32(%arg0: tensor<1x6x34x62xf32>) -> tensor<1x5x33x62xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %arg0 low[0, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<1x6x34x62xf32> to tensor<1x8x36x62xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty() : tensor<1x5x33x62xf32>
    %3 = linalg.fill ins(%cst_0 : f32) outs(%2 : tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %4 = tensor.empty() : tensor<4x4xf32>
    %5 = linalg.pooling_nhwc_sum {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded, %4 : tensor<1x8x36x62xf32>, tensor<4x4xf32>) outs(%3 : tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %5, %c1 : tensor<1x5x33x62xf32>
    %c2 = arith.constant 2 : index
    %dim_1 = tensor.dim %5, %c2 : tensor<1x5x33x62xf32>
    %c1_2 = arith.constant 1 : index
    %6 = arith.subi %dim, %c1_2 : index
    %7 = arith.subi %dim_1, %c1_2 : index
    %8 = tensor.empty() : tensor<1x5x33x62xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5 : tensor<1x5x33x62xf32>) outs(%8 : tensor<1x5x33x62xf32>) {
    ^bb0(%in: f32, %out: f32):
      %c0 = arith.constant 0 : index
      %c1_3 = arith.constant 1 : index
      %c4 = arith.constant 4 : index
      %10 = linalg.index 1 : index
      %11 = arith.subi %6, %10 : index
      %12 = arith.muli %10, %c1_3 : index
      %13 = arith.muli %11, %c1_3 : index
      %c1_4 = arith.constant 1 : index
      %14 = arith.subi %12, %c1_4 : index
      %15 = arith.minsi %14, %c0 : index
      %16 = arith.addi %c4, %15 : index
      %c1_5 = arith.constant 1 : index
      %17 = arith.subi %13, %c1_5 : index
      %18 = arith.minsi %17, %c0 : index
      %19 = arith.addi %16, %18 : index
      %20 = arith.maxsi %c1_2, %19 : index
      %c1_6 = arith.constant 1 : index
      %c4_7 = arith.constant 4 : index
      %21 = linalg.index 2 : index
      %22 = arith.subi %7, %21 : index
      %23 = arith.muli %21, %c1_6 : index
      %24 = arith.muli %22, %c1_6 : index
      %c1_8 = arith.constant 1 : index
      %25 = arith.subi %23, %c1_8 : index
      %26 = arith.minsi %25, %c0 : index
      %27 = arith.addi %c4_7, %26 : index
      %c1_9 = arith.constant 1 : index
      %28 = arith.subi %24, %c1_9 : index
      %29 = arith.minsi %28, %c0 : index
      %30 = arith.addi %27, %29 : index
      %31 = arith.maxsi %c1_2, %30 : index
      %32 = arith.muli %20, %31 : index
      %33 = arith.index_cast %32 : index to i32
      %34 = arith.sitofp %33 : i32 to f32
      %35 = arith.divf %in, %34 : f32
      linalg.yield %35 : f32
    } -> tensor<1x5x33x62xf32>
    return %9 : tensor<1x5x33x62xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @avg_pool_f16_f32acc(%arg0: tensor<1x6x34x62xf16>) -> tensor<1x5x33x62xf16> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %cst = arith.constant 0.000000e+00 : f16
    %padded = tensor.pad %arg0 low[0, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f16
    } : tensor<1x6x34x62xf16> to tensor<1x8x36x62xf16>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty() : tensor<1x5x33x62xf32>
    %3 = linalg.fill ins(%cst_0 : f32) outs(%2 : tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %4 = tensor.empty() : tensor<4x4xf32>
    %5 = linalg.pooling_nhwc_sum {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded, %4 : tensor<1x8x36x62xf16>, tensor<4x4xf32>) outs(%3 : tensor<1x5x33x62xf32>) -> tensor<1x5x33x62xf32>
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %5, %c1 : tensor<1x5x33x62xf32>
    %c2 = arith.constant 2 : index
    %dim_1 = tensor.dim %5, %c2 : tensor<1x5x33x62xf32>
    %c1_2 = arith.constant 1 : index
    %6 = arith.subi %dim, %c1_2 : index
    %7 = arith.subi %dim_1, %c1_2 : index
    %8 = tensor.empty() : tensor<1x5x33x62xf16>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5 : tensor<1x5x33x62xf32>) outs(%8 : tensor<1x5x33x62xf16>) {
    ^bb0(%in: f32, %out: f16):
      %c0 = arith.constant 0 : index
      %c1_3 = arith.constant 1 : index
      %c4 = arith.constant 4 : index
      %10 = linalg.index 1 : index
      %11 = arith.subi %6, %10 : index
      %12 = arith.muli %10, %c1_3 : index
      %13 = arith.muli %11, %c1_3 : index
      %c1_4 = arith.constant 1 : index
      %14 = arith.subi %12, %c1_4 : index
      %15 = arith.minsi %14, %c0 : index
      %16 = arith.addi %c4, %15 : index
      %c1_5 = arith.constant 1 : index
      %17 = arith.subi %13, %c1_5 : index
      %18 = arith.minsi %17, %c0 : index
      %19 = arith.addi %16, %18 : index
      %20 = arith.maxsi %c1_2, %19 : index
      %c1_6 = arith.constant 1 : index
      %c4_7 = arith.constant 4 : index
      %21 = linalg.index 2 : index
      %22 = arith.subi %7, %21 : index
      %23 = arith.muli %21, %c1_6 : index
      %24 = arith.muli %22, %c1_6 : index
      %c1_8 = arith.constant 1 : index
      %25 = arith.subi %23, %c1_8 : index
      %26 = arith.minsi %25, %c0 : index
      %27 = arith.addi %c4_7, %26 : index
      %c1_9 = arith.constant 1 : index
      %28 = arith.subi %24, %c1_9 : index
      %29 = arith.minsi %28, %c0 : index
      %30 = arith.addi %27, %29 : index
      %31 = arith.maxsi %c1_2, %30 : index
      %32 = arith.muli %20, %31 : index
      %33 = arith.index_cast %32 : index to i32
      %34 = arith.sitofp %33 : i32 to f32
      %35 = arith.divf %in, %34 : f32
      %36 = arith.truncf %35 : f32 to f16
      linalg.yield %36 : f16
    } -> tensor<1x5x33x62xf16>
    return %9 : tensor<1x5x33x62xf16>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @avg_pool_i8(%arg0: tensor<1x6x34x62xi8>) -> tensor<1x5x33x62xi8> {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c0_i8 = arith.constant 0 : i8
    %padded = tensor.pad %arg0 low[0, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %c0_i8 : i8
    } : tensor<1x6x34x62xi8> to tensor<1x8x36x62xi8>
    %c0_i32 = arith.constant 0 : i32
    %2 = tensor.empty() : tensor<1x5x33x62xi32>
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x5x33x62xi32>) -> tensor<1x5x33x62xi32>
    %4 = tensor.empty() : tensor<4x4xi32>
    %5 = linalg.pooling_nhwc_sum {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded, %4 : tensor<1x8x36x62xi8>, tensor<4x4xi32>) outs(%3 : tensor<1x5x33x62xi32>) -> tensor<1x5x33x62xi32>
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %5, %c1 : tensor<1x5x33x62xi32>
    %c2 = arith.constant 2 : index
    %dim_0 = tensor.dim %5, %c2 : tensor<1x5x33x62xi32>
    %c1_1 = arith.constant 1 : index
    %6 = arith.subi %dim, %c1_1 : index
    %7 = arith.subi %dim_0, %c1_1 : index
    %8 = tensor.empty() : tensor<1x5x33x62xi8>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5 : tensor<1x5x33x62xi32>) outs(%8 : tensor<1x5x33x62xi8>) {
    ^bb0(%in: i32, %out: i8):
      %c0 = arith.constant 0 : index
      %c1_2 = arith.constant 1 : index
      %c4 = arith.constant 4 : index
      %10 = linalg.index 1 : index
      %11 = arith.subi %6, %10 : index
      %12 = arith.muli %10, %c1_2 : index
      %13 = arith.muli %11, %c1_2 : index
      %c1_3 = arith.constant 1 : index
      %14 = arith.subi %12, %c1_3 : index
      %15 = arith.minsi %14, %c0 : index
      %16 = arith.addi %c4, %15 : index
      %c1_4 = arith.constant 1 : index
      %17 = arith.subi %13, %c1_4 : index
      %18 = arith.minsi %17, %c0 : index
      %19 = arith.addi %16, %18 : index
      %20 = arith.maxsi %c1_1, %19 : index
      %c1_5 = arith.constant 1 : index
      %c4_6 = arith.constant 4 : index
      %21 = linalg.index 2 : index
      %22 = arith.subi %7, %21 : index
      %23 = arith.muli %21, %c1_5 : index
      %24 = arith.muli %22, %c1_5 : index
      %c1_7 = arith.constant 1 : index
      %25 = arith.subi %23, %c1_7 : index
      %26 = arith.minsi %25, %c0 : index
      %27 = arith.addi %c4_6, %26 : index
      %c1_8 = arith.constant 1 : index
      %28 = arith.subi %24, %c1_8 : index
      %29 = arith.minsi %28, %c0 : index
      %30 = arith.addi %27, %29 : index
      %31 = arith.maxsi %c1_1, %30 : index
      %32 = arith.muli %20, %31 : index
      %33 = arith.index_cast %32 : index to i32
      %c1_i32 = arith.constant 1 : i32
      %c32_i32 = arith.constant 32 : i32
      %34 = arith.subi %33, %c1_i32 : i32
      %35 = math.ctlz %34 : i32
      %36 = arith.subi %c32_i32, %35 : i32
      %37 = arith.extui %36 : i32 to i64
      %c1073741825_i64 = arith.constant 1073741825 : i64
      %38 = arith.shli %c1073741825_i64, %37 : i64
      %39 = arith.extui %33 : i32 to i64
      %40 = arith.divui %38, %39 : i64
      %41 = arith.trunci %40 : i64 to i32
      %42 = arith.trunci %36 : i32 to i8
      %c30_i8 = arith.constant 30 : i8
      %43 = arith.addi %42, %c30_i8 : i8
      %44 = tosa.apply_scale %in, %41, %43 {rounding_mode = SINGLE_ROUND} : (i32, i32, i8) -> i32
      %c-128_i32 = arith.constant -128 : i32
      %c127_i32 = arith.constant 127 : i32
      %45 = arith.maxsi %c-128_i32, %44 : i32
      %46 = arith.minsi %c127_i32, %45 : i32
      %47 = arith.trunci %46 : i32 to i8
      linalg.yield %47 : i8
    } -> tensor<1x5x33x62xi8>
    return %9 : tensor<1x5x33x62xi8>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @avg_pool_dyn(%arg0: tensor<?x6x34x62xf32>) -> tensor<?x5x33x62xf32> {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x6x34x62xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %arg0 low[0, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<?x6x34x62xf32> to tensor<?x8x36x62xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty(%dim) : tensor<?x5x33x62xf32>
    %3 = linalg.fill ins(%cst_0 : f32) outs(%2 : tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    %4 = tensor.empty() : tensor<4x4xf32>
    %5 = linalg.pooling_nhwc_sum {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded, %4 : tensor<?x8x36x62xf32>, tensor<4x4xf32>) outs(%3 : tensor<?x5x33x62xf32>) -> tensor<?x5x33x62xf32>
    %c1 = arith.constant 1 : index
    %dim_1 = tensor.dim %5, %c1 : tensor<?x5x33x62xf32>
    %c2 = arith.constant 2 : index
    %dim_2 = tensor.dim %5, %c2 : tensor<?x5x33x62xf32>
    %c1_3 = arith.constant 1 : index
    %6 = arith.subi %dim_1, %c1_3 : index
    %7 = arith.subi %dim_2, %c1_3 : index
    %8 = tensor.empty(%dim) : tensor<?x5x33x62xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5 : tensor<?x5x33x62xf32>) outs(%8 : tensor<?x5x33x62xf32>) {
    ^bb0(%in: f32, %out: f32):
      %c0_4 = arith.constant 0 : index
      %c1_5 = arith.constant 1 : index
      %c4 = arith.constant 4 : index
      %10 = linalg.index 1 : index
      %11 = arith.subi %6, %10 : index
      %12 = arith.muli %10, %c1_5 : index
      %13 = arith.muli %11, %c1_5 : index
      %c1_6 = arith.constant 1 : index
      %14 = arith.subi %12, %c1_6 : index
      %15 = arith.minsi %14, %c0_4 : index
      %16 = arith.addi %c4, %15 : index
      %c1_7 = arith.constant 1 : index
      %17 = arith.subi %13, %c1_7 : index
      %18 = arith.minsi %17, %c0_4 : index
      %19 = arith.addi %16, %18 : index
      %20 = arith.maxsi %c1_3, %19 : index
      %c1_8 = arith.constant 1 : index
      %c4_9 = arith.constant 4 : index
      %21 = linalg.index 2 : index
      %22 = arith.subi %7, %21 : index
      %23 = arith.muli %21, %c1_8 : index
      %24 = arith.muli %22, %c1_8 : index
      %c1_10 = arith.constant 1 : index
      %25 = arith.subi %23, %c1_10 : index
      %26 = arith.minsi %25, %c0_4 : index
      %27 = arith.addi %c4_9, %26 : index
      %c1_11 = arith.constant 1 : index
      %28 = arith.subi %24, %c1_11 : index
      %29 = arith.minsi %28, %c0_4 : index
      %30 = arith.addi %27, %29 : index
      %31 = arith.maxsi %c1_3, %30 : index
      %32 = arith.muli %20, %31 : index
      %33 = arith.index_cast %32 : index to i32
      %34 = arith.sitofp %33 : i32 to f32
      %35 = arith.divf %in, %34 : f32
      linalg.yield %35 : f32
    } -> tensor<?x5x33x62xf32>
    return %9 : tensor<?x5x33x62xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_scalar_bias_f32(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<1xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<3x3x27x28xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x3x3x27xf32>) outs(%2 : tensor<3x3x27x28xf32>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty() : tensor<1x45x40x28xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<1xf32>) outs(%3 : tensor<1x45x40x28xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x45x40x28xf32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %transposed : tensor<1x49x42x27xf32>, tensor<3x3x27x28xf32>) outs(%4 : tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_i8(%arg0: tensor<1x49x42x27xi8>, %arg1: tensor<28x1x1x27xi8>, %arg2: tensor<28xi8>) {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tensor.empty() : tensor<1x1x27x28xi8>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x1x1x27xi8>) outs(%2 : tensor<1x1x27x28xi8>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty() : tensor<1x49x42x28xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<28xi8>) outs(%3 : tensor<1x49x42x28xi32>) {
    ^bb0(%in: i8, %out: i32):
      %6 = arith.extsi %in : i8 to i32
      linalg.yield %6 : i32
    } -> tensor<1x49x42x28xi32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %transposed : tensor<1x49x42x27xi8>, tensor<1x1x27x28xi8>) outs(%4 : tensor<1x49x42x28xi32>) -> tensor<1x49x42x28xi32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_f32(%arg0: tensor<1x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<3x3x27x28xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x3x3x27xf32>) outs(%2 : tensor<3x3x27x28xf32>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty() : tensor<1x45x40x28xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<28xf32>) outs(%3 : tensor<1x45x40x28xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x45x40x28xf32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %transposed : tensor<1x49x42x27xf32>, tensor<3x3x27x28xf32>) outs(%4 : tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_dyn(%arg0: tensor<?x49x42x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x49x42x27xf32>
    %2 = tensor.empty() : tensor<3x3x27x28xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x3x3x27xf32>) outs(%2 : tensor<3x3x27x28xf32>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty(%dim) : tensor<?x45x40x28xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<28xf32>) outs(%3 : tensor<?x45x40x28xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x45x40x28xf32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %transposed : tensor<?x49x42x27xf32>, tensor<3x3x27x28xf32>) outs(%4 : tensor<?x45x40x28xf32>) -> tensor<?x45x40x28xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_dyn_w_h(%arg0: tensor<1x?x?x27xf32>, %arg1: tensor<28x3x3x27xf32>, %arg2: tensor<28xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<1x?x?x27xf32>
    %c1_0 = arith.constant 1 : index
    %dim_1 = tensor.dim %arg1, %c1_0 : tensor<28x3x3x27xf32>
    %c1_2 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %2 = arith.addi %dim, %c0 : index
    %c0_3 = arith.constant 0 : index
    %3 = arith.addi %2, %c0_3 : index
    %4 = arith.subi %dim_1, %c1_2 : index
    %c2 = arith.constant 2 : index
    %5 = arith.muli %c2, %4 : index
    %6 = arith.addi %5, %c1_2 : index
    %7 = arith.subi %3, %6 : index
    %c1_4 = arith.constant 1 : index
    %8 = arith.divui %7, %c1_4 : index
    %9 = arith.addi %8, %c1_2 : index
    %c2_5 = arith.constant 2 : index
    %dim_6 = tensor.dim %arg0, %c2_5 : tensor<1x?x?x27xf32>
    %c2_7 = arith.constant 2 : index
    %dim_8 = tensor.dim %arg1, %c2_7 : tensor<28x3x3x27xf32>
    %c1_9 = arith.constant 1 : index
    %c0_10 = arith.constant 0 : index
    %10 = arith.addi %dim_6, %c0_10 : index
    %c0_11 = arith.constant 0 : index
    %11 = arith.addi %10, %c0_11 : index
    %12 = arith.subi %dim_8, %c1_9 : index
    %c1_12 = arith.constant 1 : index
    %13 = arith.muli %c1_12, %12 : index
    %14 = arith.addi %13, %c1_9 : index
    %15 = arith.subi %11, %14 : index
    %c1_13 = arith.constant 1 : index
    %16 = arith.divui %15, %c1_13 : index
    %17 = arith.addi %16, %c1_9 : index
    %18 = tensor.empty() : tensor<3x3x27x28xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x3x3x27xf32>) outs(%18 : tensor<3x3x27x28xf32>) permutation = [1, 2, 3, 0] 
    %19 = tensor.empty(%9, %17) : tensor<1x?x?x28xf32>
    %20 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<28xf32>) outs(%19 : tensor<1x?x?x28xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x?x?x28xf32>
    %21 = linalg.conv_2d_nhwc_hwcf {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %transposed : tensor<1x?x?x27xf32>, tensor<3x3x27x28xf32>) outs(%20 : tensor<1x?x?x28xf32>) -> tensor<1x?x?x28xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_dyn_output(%arg0: tensor<2x6x5x4xf32>, %arg1: tensor<4x3x3x4xf32>, %arg2: tensor<4xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<2x6x5x4xf32>
    %2 = tensor.empty() : tensor<3x3x4x4xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<4x3x3x4xf32>) outs(%2 : tensor<3x3x4x4xf32>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty(%dim) : tensor<?x4x3x4xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<4xf32>) outs(%3 : tensor<?x4x3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x4x3x4xf32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %transposed : tensor<2x6x5x4xf32>, tensor<3x3x4x4xf32>) outs(%4 : tensor<?x4x3x4xf32>) -> tensor<?x4x3x4xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_padded_f32(%arg0: tensor<1x47x40x28xf32>, %arg1: tensor<28x3x3x28xf32>, %arg2: tensor<28xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %arg0 low[0, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: index):
      tensor.yield %cst : f32
    } : tensor<1x47x40x28xf32> to tensor<1x49x42x28xf32>
    %2 = tensor.empty() : tensor<3x3x28x28xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x3x3x28xf32>) outs(%2 : tensor<3x3x28x28xf32>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty() : tensor<1x45x40x28xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<28xf32>) outs(%3 : tensor<1x45x40x28xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x45x40x28xf32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%padded, %transposed : tensor<1x49x42x28xf32>, tensor<3x3x28x28xf32>) outs(%4 : tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_quant(%arg0: tensor<1x12x12x1xi8>, %arg1: tensor<1024x3x3x1xi8>, %arg2: tensor<1024xi32>) {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c-22_i8 = arith.constant -22 : i8
    %padded = tensor.pad %arg0 low[0, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: index):
      tensor.yield %c-22_i8 : i8
    } : tensor<1x12x12x1xi8> to tensor<1x14x14x1xi8>
    %2 = tensor.empty() : tensor<3x3x1x1024xi8>
    %transposed = linalg.transpose ins(%arg1 : tensor<1024x3x3x1xi8>) outs(%2 : tensor<3x3x1x1024xi8>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty() : tensor<1x12x12x1024xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<1024xi32>) outs(%3 : tensor<1x12x12x1024xi32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    } -> tensor<1x12x12x1024xi32>
    %c-22_i32 = arith.constant -22 : i32
    %c42_i32 = arith.constant 42 : i32
    %5 = linalg.conv_2d_nhwc_hwcf_q {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%padded, %transposed, %c-22_i32, %c42_i32 : tensor<1x14x14x1xi8>, tensor<3x3x1x1024xi8>, i32, i32) outs(%4 : tensor<1x12x12x1024xi32>) -> tensor<1x12x12x1024xi32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @conv2d_f16_f32_acc(%arg0: tensor<1x49x42x27xf16>, %arg1: tensor<28x3x3x27xf16>, %arg2: tensor<28xf16>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = tensor.empty() : tensor<3x3x27x28xf16>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x3x3x27xf16>) outs(%2 : tensor<3x3x27x28xf16>) permutation = [1, 2, 3, 0] 
    %3 = tensor.empty() : tensor<1x45x40x28xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<28xf16>) outs(%3 : tensor<1x45x40x28xf32>) {
    ^bb0(%in: f16, %out: f32):
      %7 = arith.extf %in : f16 to f32
      linalg.yield %7 : f32
    } -> tensor<1x45x40x28xf32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %transposed : tensor<1x49x42x27xf16>, tensor<3x3x27x28xf16>) outs(%4 : tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf32>
    %6 = tosa.cast %5 : (tensor<1x45x40x28xf32>) -> tensor<1x45x40x28xf16>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_conv(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<1x5x5x3x11xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %4 = tensor.empty() : tensor<1x5x5x33xf32>
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %arg1 : tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>) outs(%3 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %collapsed = tensor.collapse_shape %5 [[0], [1], [2], [3, 4]] : tensor<1x5x5x3x11xf32> into tensor<1x5x5x33xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<33xf32>, tensor<1x5x5x33xf32>) outs(%4 : tensor<1x5x5x33xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %7 = arith.addf %in, %in_0 : f32
      linalg.yield %7 : f32
    } -> tensor<1x5x5x33xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_conv_scalar_bias(%arg0: tensor<1x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<1xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<1x5x5x3x11xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %4 = tensor.empty() : tensor<1x5x5x33xf32>
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %arg1 : tensor<1x7x5x3xf32>, tensor<3x1x3x11xf32>) outs(%3 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %collapsed = tensor.collapse_shape %5 [[0], [1], [2], [3, 4]] : tensor<1x5x5x3x11xf32> into tensor<1x5x5x33xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<1xf32>, tensor<1x5x5x33xf32>) outs(%4 : tensor<1x5x5x33xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %7 = arith.addf %in, %in_0 : f32
      linalg.yield %7 : f32
    } -> tensor<1x5x5x33xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_conv_dyn(%arg0: tensor<?x7x5x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x7x5x3xf32>
    %2 = tensor.empty(%dim) : tensor<?x5x5x3x11xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x3x11xf32>
    %4 = tensor.empty(%dim) : tensor<?x5x5x33xf32>
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %arg1 : tensor<?x7x5x3xf32>, tensor<3x1x3x11xf32>) outs(%3 : tensor<?x5x5x3x11xf32>) -> tensor<?x5x5x3x11xf32>
    %collapsed = tensor.collapse_shape %5 [[0], [1], [2], [3, 4]] : tensor<?x5x5x3x11xf32> into tensor<?x5x5x33xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<33xf32>, tensor<?x5x5x33xf32>) outs(%4 : tensor<?x5x5x33xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %7 = arith.addf %in, %in_0 : f32
      linalg.yield %7 : f32
    } -> tensor<?x5x5x33xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_conv_strides(%arg0: tensor<1x11x9x3xf32>, %arg1: tensor<3x1x3x11xf32>, %arg2: tensor<33xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<1x5x5x3x11xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %4 = tensor.empty() : tensor<1x5x5x33xf32>
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm {dilations = dense<1> : tensor<2xi64>, strides = dense<2> : tensor<2xi64>} ins(%arg0, %arg1 : tensor<1x11x9x3xf32>, tensor<3x1x3x11xf32>) outs(%3 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %collapsed = tensor.collapse_shape %5 [[0], [1], [2], [3, 4]] : tensor<1x5x5x3x11xf32> into tensor<1x5x5x33xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<33xf32>, tensor<1x5x5x33xf32>) outs(%4 : tensor<1x5x5x33xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %7 = arith.addf %in, %in_0 : f32
      linalg.yield %7 : f32
    } -> tensor<1x5x5x33xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_conv_quant(%arg0: tensor<1x12x12x4xi8>, %arg1: tensor<3x3x4x128xi8>, %arg2: tensor<512xi32>) {
    %0 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c-128_i8 = arith.constant -128 : i8
    %padded = tensor.pad %arg0 low[0, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: index):
      tensor.yield %c-128_i8 : i8
    } : tensor<1x12x12x4xi8> to tensor<1x14x14x4xi8>
    %2 = tensor.empty() : tensor<1x12x12x4x128xi32>
    %c0_i32 = arith.constant 0 : i32
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x4x128xi32>
    %4 = tensor.empty() : tensor<1x12x12x512xi32>
    %c-128_i32 = arith.constant -128 : i32
    %c42_i32 = arith.constant 42 : i32
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm_q {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%padded, %arg1, %c-128_i32, %c42_i32 : tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, i32, i32) outs(%3 : tensor<1x12x12x4x128xi32>) -> tensor<1x12x12x4x128xi32>
    %collapsed = tensor.collapse_shape %5 [[0], [1], [2], [3, 4]] : tensor<1x12x12x4x128xi32> into tensor<1x12x12x512xi32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<512xi32>, tensor<1x12x12x512xi32>) outs(%4 : tensor<1x12x12x512xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %7 = arith.addi %in, %in_0 : i32
      linalg.yield %7 : i32
    } -> tensor<1x12x12x512xi32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_conv_quant_dilations(%arg0: tensor<1x14x14x4xi8>, %arg1: tensor<3x3x4x128xi8>, %arg2: tensor<512xi32>) {
    %0 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tensor.empty() : tensor<1x10x10x4x128xi32>
    %c0_i32 = arith.constant 0 : i32
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x4x128xi32>
    %4 = tensor.empty() : tensor<1x10x10x512xi32>
    %c-128_i32 = arith.constant -128 : i32
    %c42_i32 = arith.constant 42 : i32
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm_q {dilations = dense<2> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %arg1, %c-128_i32, %c42_i32 : tensor<1x14x14x4xi8>, tensor<3x3x4x128xi8>, i32, i32) outs(%3 : tensor<1x10x10x4x128xi32>) -> tensor<1x10x10x4x128xi32>
    %collapsed = tensor.collapse_shape %5 [[0], [1], [2], [3, 4]] : tensor<1x10x10x4x128xi32> into tensor<1x10x10x512xi32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<512xi32>, tensor<1x10x10x512xi32>) outs(%4 : tensor<1x10x10x512xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %7 = arith.addi %in, %in_0 : i32
      linalg.yield %7 : i32
    } -> tensor<1x10x10x512xi32>
    return
  }
  func.func @depthwise_conv2d_dyn_w_h(%arg0: tensor<2x?x?x3xf32>, %arg1: tensor<3x6x3x5xf32>, %arg2: tensor<15xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<2x?x?x3xf32>
    %c0 = arith.constant 0 : index
    %dim_0 = tensor.dim %arg1, %c0 : tensor<3x6x3x5xf32>
    %c1_1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    %2 = arith.addi %dim, %c1_2 : index
    %c2 = arith.constant 2 : index
    %3 = arith.addi %2, %c2 : index
    %4 = arith.subi %dim_0, %c1_1 : index
    %c2_3 = arith.constant 2 : index
    %5 = arith.muli %c2_3, %4 : index
    %6 = arith.addi %5, %c1_1 : index
    %7 = arith.subi %3, %6 : index
    %c1_4 = arith.constant 1 : index
    %8 = arith.divui %7, %c1_4 : index
    %9 = arith.addi %8, %c1_1 : index
    %c2_5 = arith.constant 2 : index
    %dim_6 = tensor.dim %arg0, %c2_5 : tensor<2x?x?x3xf32>
    %c1_7 = arith.constant 1 : index
    %dim_8 = tensor.dim %arg1, %c1_7 : tensor<3x6x3x5xf32>
    %c1_9 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %10 = arith.addi %dim_6, %c3 : index
    %c4 = arith.constant 4 : index
    %11 = arith.addi %10, %c4 : index
    %12 = arith.subi %dim_8, %c1_9 : index
    %c1_10 = arith.constant 1 : index
    %13 = arith.muli %c1_10, %12 : index
    %14 = arith.addi %13, %c1_9 : index
    %15 = arith.subi %11, %14 : index
    %c2_11 = arith.constant 2 : index
    %16 = arith.divui %15, %c2_11 : index
    %17 = arith.addi %16, %c1_9 : index
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %arg0 low[0, 1, 3, 0] high[0, 2, 4, 0] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: index):
      tensor.yield %cst : f32
    } : tensor<2x?x?x3xf32> to tensor<2x?x?x3xf32>
    %18 = tensor.empty(%9, %17) : tensor<2x?x?x3x5xf32>
    %cst_12 = arith.constant 0.000000e+00 : f32
    %19 = linalg.fill ins(%cst_12 : f32) outs(%18 : tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x3x5xf32>
    %20 = tensor.empty(%9, %17) : tensor<2x?x?x15xf32>
    %21 = linalg.depthwise_conv_2d_nhwc_hwcm {dilations = dense<[2, 1]> : tensor<2xi64>, strides = dense<[1, 2]> : tensor<2xi64>} ins(%padded, %arg1 : tensor<2x?x?x3xf32>, tensor<3x6x3x5xf32>) outs(%19 : tensor<2x?x?x3x5xf32>) -> tensor<2x?x?x3x5xf32>
    %collapsed = tensor.collapse_shape %21 [[0], [1], [2], [3, 4]] : tensor<2x?x?x3x5xf32> into tensor<2x?x?x15xf32>
    %22 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<15xf32>, tensor<2x?x?x15xf32>) outs(%20 : tensor<2x?x?x15xf32>) {
    ^bb0(%in: f32, %in_13: f32, %out: f32):
      %23 = arith.addf %in, %in_13 : f32
      linalg.yield %23 : f32
    } -> tensor<2x?x?x15xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_int_conv_zero_zp(%arg0: tensor<1x7x5x3xi8>, %arg1: tensor<3x1x3x11xi8>, %arg2: tensor<33xi32>) {
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tensor.empty() : tensor<1x5x5x3x11xi32>
    %c0_i32 = arith.constant 0 : i32
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x3x11xi32>
    %4 = tensor.empty() : tensor<1x5x5x33xi32>
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %arg1 : tensor<1x7x5x3xi8>, tensor<3x1x3x11xi8>) outs(%3 : tensor<1x5x5x3x11xi32>) -> tensor<1x5x5x3x11xi32>
    %collapsed = tensor.collapse_shape %5 [[0], [1], [2], [3, 4]] : tensor<1x5x5x3x11xi32> into tensor<1x5x5x33xi32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<33xi32>, tensor<1x5x5x33xi32>) outs(%4 : tensor<1x5x5x33xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %7 = arith.addi %in, %in_0 : i32
      linalg.yield %7 : i32
    } -> tensor<1x5x5x33xi32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @depthwise_conv2d_f16_f32_acc(%arg0: tensor<1x7x5x3xf16>, %arg1: tensor<3x1x3x11xf16>, %arg2: tensor<33xf16>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = tensor.empty() : tensor<1x5x5x3x11xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %4 = tensor.empty() : tensor<1x5x5x33xf16>
    %5 = linalg.depthwise_conv_2d_nhwc_hwcm {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%arg0, %arg1 : tensor<1x7x5x3xf16>, tensor<3x1x3x11xf16>) outs(%3 : tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf32>
    %6 = tosa.cast %5 : (tensor<1x5x5x3x11xf32>) -> tensor<1x5x5x3x11xf16>
    %collapsed = tensor.collapse_shape %6 [[0], [1], [2], [3, 4]] : tensor<1x5x5x3x11xf16> into tensor<1x5x5x33xf16>
    %7 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2, %collapsed : tensor<33xf16>, tensor<1x5x5x33xf16>) outs(%4 : tensor<1x5x5x33xf16>) {
    ^bb0(%in: f16, %in_0: f16, %out: f16):
      %8 = arith.addf %in, %in_0 : f16
      linalg.yield %8 : f16
    } -> tensor<1x5x5x33xf16>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
module {
  func.func @conv3d_f32(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<43x3x4x5x27xf32>, %arg2: tensor<43xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<3x4x5x27x43xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<43x3x4x5x27xf32>) outs(%2 : tensor<3x4x5x27x43xf32>) permutation = [1, 2, 3, 4, 0] 
    %3 = tensor.empty() : tensor<1x47x45x43x43xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<43xf32>) outs(%3 : tensor<1x47x45x43x43xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x47x45x43x43xf32>
    %5 = linalg.conv_3d_ndhwc_dhwcf {dilations = dense<1> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} ins(%arg0, %transposed : tensor<1x49x48x47x27xf32>, tensor<3x4x5x27x43xf32>) outs(%4 : tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (0)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
module {
  func.func @conv3d_scalar_bias_f32(%arg0: tensor<1x49x48x47x27xf32>, %arg1: tensor<28x3x4x5x27xf32>, %arg2: tensor<1xf32>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<3x4x5x27x28xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<28x3x4x5x27xf32>) outs(%2 : tensor<3x4x5x27x28xf32>) permutation = [1, 2, 3, 4, 0] 
    %3 = tensor.empty() : tensor<1x47x45x43x28xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<1xf32>) outs(%3 : tensor<1x47x45x43x28xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x47x45x43x28xf32>
    %5 = linalg.conv_3d_ndhwc_dhwcf {dilations = dense<1> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} ins(%arg0, %transposed : tensor<1x49x48x47x27xf32>, tensor<3x4x5x27x28xf32>) outs(%4 : tensor<1x47x45x43x28xf32>) -> tensor<1x47x45x43x28xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
module {
  func.func @conv3d_i8(%arg0: tensor<1x49x48x47x27xi8>, %arg1: tensor<43x3x4x5x27xi8>, %arg2: tensor<43xi32>) {
    %0 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<42> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tensor.empty() : tensor<3x4x5x27x43xi8>
    %transposed = linalg.transpose ins(%arg1 : tensor<43x3x4x5x27xi8>) outs(%2 : tensor<3x4x5x27x43xi8>) permutation = [1, 2, 3, 4, 0] 
    %3 = tensor.empty() : tensor<1x47x45x43x43xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<43xi32>) outs(%3 : tensor<1x47x45x43x43xi32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    } -> tensor<1x47x45x43x43xi32>
    %c-128_i32 = arith.constant -128 : i32
    %c42_i32 = arith.constant 42 : i32
    %5 = linalg.conv_3d_ndhwc_dhwcf_q {dilations = dense<1> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} ins(%arg0, %transposed, %c-128_i32, %c42_i32 : tensor<1x49x48x47x27xi8>, tensor<3x4x5x27x43xi8>, i32, i32) outs(%4 : tensor<1x47x45x43x43xi32>) -> tensor<1x47x45x43x43xi32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
module {
  func.func @conv3d_f16_f32_acc(%arg0: tensor<1x49x48x47x27xf16>, %arg1: tensor<43x3x4x5x27xf16>, %arg2: tensor<43xf16>) {
    %0 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    %2 = tensor.empty() : tensor<3x4x5x27x43xf16>
    %transposed = linalg.transpose ins(%arg1 : tensor<43x3x4x5x27xf16>) outs(%2 : tensor<3x4x5x27x43xf16>) permutation = [1, 2, 3, 4, 0] 
    %3 = tensor.empty() : tensor<1x47x45x43x43xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<43xf16>) outs(%3 : tensor<1x47x45x43x43xf32>) {
    ^bb0(%in: f16, %out: f32):
      %7 = arith.extf %in : f16 to f32
      linalg.yield %7 : f32
    } -> tensor<1x47x45x43x43xf32>
    %5 = linalg.conv_3d_ndhwc_dhwcf {dilations = dense<1> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} ins(%arg0, %transposed : tensor<1x49x48x47x27xf16>, tensor<3x4x5x27x43xf16>) outs(%4 : tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf32>
    %6 = tosa.cast %5 : (tensor<1x47x45x43x43xf32>) -> tensor<1x47x45x43x43xf16>
    return
  }
}

// -----
module {
  func.func @test_transpose(%arg0: tensor<1x2x3xi32>) {
    %0 = tensor.empty() : tensor<2x3x1xi32>
    %transposed = linalg.transpose ins(%arg0 : tensor<1x2x3xi32>) outs(%0 : tensor<2x3x1xi32>) permutation = [1, 2, 0] 
    return
  }
}

// -----
module {
  func.func @test_transpose_dyn(%arg0: tensor<1x?x3x4xi32>) {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<1x?x3x4xi32>
    %0 = tensor.empty(%dim) : tensor<?x4x1x3xi32>
    %transposed = linalg.transpose ins(%arg0 : tensor<1x?x3x4xi32>) outs(%0 : tensor<?x4x1x3xi32>) permutation = [1, 3, 0, 2] 
    return
  }
}

// -----
module {
  func.func @test_transpose_dyn_multiple_2d(%arg0: tensor<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %0 = tensor.empty(%dim_0, %dim) : tensor<?x?xf32>
    %transposed = linalg.transpose ins(%arg0 : tensor<?x?xf32>) outs(%0 : tensor<?x?xf32>) permutation = [1, 0] 
    return
  }
}

// -----
module {
  func.func @test_transpose_dyn_multiple_3d(%arg0: tensor<?x?x?xf32>) {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %c2 = arith.constant 2 : index
    %dim_1 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim_1, %dim, %dim_0) : tensor<?x?x?xf32>
    %transposed = linalg.transpose ins(%arg0 : tensor<?x?x?xf32>) outs(%0 : tensor<?x?x?xf32>) permutation = [2, 0, 1] 
    return
  }
}

// -----
module {
  func.func @max_pool2d_nan_propagate(%arg0: tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32> {
    %cst = arith.constant -3.40282347E+38 : f32
    %0 = tensor.empty() : tensor<1x4x32x62xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    %2 = tensor.empty() : tensor<3x3xf32>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x6x34x62xf32>, tensor<3x3xf32>) outs(%1 : tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    return %3 : tensor<1x4x32x62xf32>
  }
}

// -----
module {
  func.func @max_pool2d_nan_ignore_int(%arg0: tensor<1x6x34x62xi8>) -> tensor<1x4x32x62xi8> {
    %c-128_i8 = arith.constant -128 : i8
    %0 = tensor.empty() : tensor<1x4x32x62xi8>
    %1 = linalg.fill ins(%c-128_i8 : i8) outs(%0 : tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    %2 = tensor.empty() : tensor<3x3xi8>
    %3 = linalg.pooling_nhwc_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x6x34x62xi8>, tensor<3x3xi8>) outs(%1 : tensor<1x4x32x62xi8>) -> tensor<1x4x32x62xi8>
    return %3 : tensor<1x4x32x62xi8>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1 + d4, d2 + d5, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
module {
  func.func @max_pool2d_nan_ignore(%arg0: tensor<1x6x34x62xf32>) -> tensor<1x4x32x62xf32> {
    %cst = arith.constant -3.40282347E+38 : f32
    %0 = tensor.empty() : tensor<1x4x32x62xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x4x32x62xf32>) -> tensor<1x4x32x62xf32>
    %2 = tensor.empty() : tensor<3x3xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%arg0, %2 : tensor<1x6x34x62xf32>, tensor<3x3xf32>) outs(%1 : tensor<1x4x32x62xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.maximumf %out, %in : f32
      %5 = arith.cmpf uno, %in, %in : f32
      %6 = arith.select %5, %out, %4 : f32
      linalg.yield %6 : f32
    } -> tensor<1x4x32x62xf32>
    return %3 : tensor<1x4x32x62xf32>
  }
}

