module {
  func.func @unary_resize_nearest_fp32(%arg0: tensor<3x1x1x7xf32>) -> tensor<3x1x1x7xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    return %arg0 : tensor<3x1x1x7xf32>
  }
}

// -----
module {
  func.func @unary_resize_nearest_bf16(%arg0: tensor<3x1x1x7xbf16>) -> tensor<3x1x1x7xbf16> {
    %0 = tosa.const_shape  {values = dense<[2, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    return %arg0 : tensor<3x1x1x7xbf16>
  }
}

// -----
module {
  func.func @unary_resize_nearest_fp16(%arg0: tensor<3x1x1x7xf16>) -> tensor<3x1x1x7xf16> {
    %0 = tosa.const_shape  {values = dense<[2, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    return %arg0 : tensor<3x1x1x7xf16>
  }
}

// -----
module {
  func.func @unary_resize_bilinear_fp32(%arg0: tensor<3x1x1x7xf32>) -> tensor<3x1x1x7xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    return %arg0 : tensor<3x1x1x7xf32>
  }
}

// -----
module {
  func.func @unary_resize_bilinear_bf16(%arg0: tensor<3x1x1x7xbf16>) -> tensor<3x1x1x7xbf16> {
    %0 = tosa.const_shape  {values = dense<[2, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    return %arg0 : tensor<3x1x1x7xbf16>
  }
}

// -----
module {
  func.func @unary_resize_bilinear_fp16(%arg0: tensor<3x1x1x7xf16>) -> tensor<3x1x1x7xf16> {
    %0 = tosa.const_shape  {values = dense<[2, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    return %arg0 : tensor<3x1x1x7xf16>
  }
}

// -----
module {
  func.func @unary_resize_nearest_i8(%arg0: tensor<3x1x1x7xi8>) -> tensor<3x1x1x7xi8> {
    %0 = tosa.const_shape  {values = dense<[2, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    return %arg0 : tensor<3x1x1x7xi8>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @broadcast_resize_nearest_bf16(%arg0: tensor<3x1x1x7xbf16>) -> tensor<3x1x5x7xbf16> {
    %0 = tosa.const_shape  {values = dense<[2, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0], [1, 2, 3]] : tensor<3x1x1x7xbf16> into tensor<3x7xbf16>
    %3 = tensor.empty() : tensor<3x1x5x7xbf16>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%collapsed : tensor<3x7xbf16>) outs(%3 : tensor<3x1x5x7xbf16>) {
    ^bb0(%in: bf16, %out: bf16):
      linalg.yield %in : bf16
    } -> tensor<3x1x5x7xbf16>
    return %4 : tensor<3x1x5x7xbf16>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @broadcast_resize_nearest_f32(%arg0: tensor<3x1x1x7xf32>) -> tensor<3x1x5x7xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0], [1, 2, 3]] : tensor<3x1x1x7xf32> into tensor<3x7xf32>
    %3 = tensor.empty() : tensor<3x1x5x7xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%collapsed : tensor<3x7xf32>) outs(%3 : tensor<3x1x5x7xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<3x1x5x7xf32>
    return %4 : tensor<3x1x5x7xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @broadcast_resize_bilinear_i8(%arg0: tensor<3x1x1x7xi8>) -> tensor<3x4x5x7xi32> {
    %0 = tosa.const_shape  {values = dense<[2, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0], [1, 2, 3]] : tensor<3x1x1x7xi8> into tensor<3x7xi8>
    %3 = tensor.empty() : tensor<3x7xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%collapsed : tensor<3x7xi8>) outs(%3 : tensor<3x7xi32>) {
    ^bb0(%in: i8, %out: i32):
      %7 = arith.extsi %in : i8 to i32
      %c2_i32 = arith.constant 2 : i32
      %8 = arith.muli %7, %c2_i32 : i32
      %c3_i32 = arith.constant 3 : i32
      %9 = arith.muli %8, %c3_i32 : i32
      linalg.yield %9 : i32
    } -> tensor<3x7xi32>
    %expanded = tensor.expand_shape %4 [[0], [1, 2, 3]] output_shape [3, 1, 1, 7] : tensor<3x7xi32> into tensor<3x1x1x7xi32>
    %collapsed_0 = tensor.collapse_shape %expanded [[0], [1, 2, 3]] : tensor<3x1x1x7xi32> into tensor<3x7xi32>
    %5 = tensor.empty() : tensor<3x4x5x7xi32>
    %6 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%collapsed_0 : tensor<3x7xi32>) outs(%5 : tensor<3x4x5x7xi32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    } -> tensor<3x4x5x7xi32>
    return %6 : tensor<3x4x5x7xi32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @unary_resize_bilinear_i32(%arg0: tensor<3x1x1x7xi8>) -> tensor<3x1x1x7xi32> {
    %0 = tosa.const_shape  {values = dense<[2, 1, 2, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0], [1, 2, 3]] : tensor<3x1x1x7xi8> into tensor<3x7xi8>
    %3 = tensor.empty() : tensor<3x7xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%collapsed : tensor<3x7xi8>) outs(%3 : tensor<3x7xi32>) {
    ^bb0(%in: i8, %out: i32):
      %5 = arith.extsi %in : i8 to i32
      %c2_i32 = arith.constant 2 : i32
      %6 = arith.muli %5, %c2_i32 : i32
      %c2_i32_0 = arith.constant 2 : i32
      %7 = arith.muli %6, %c2_i32_0 : i32
      linalg.yield %7 : i32
    } -> tensor<3x7xi32>
    %expanded = tensor.expand_shape %4 [[0], [1, 2, 3]] output_shape [3, 1, 1, 7] : tensor<3x7xi32> into tensor<3x1x1x7xi32>
    return %expanded : tensor<3x1x1x7xi32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @resize_nearest_int(%arg0: tensor<1x15x13x1xi8>) {
    %0 = tosa.const_shape  {values = dense<[11, 7, 89, 6]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tensor.empty() : tensor<1x23x179x1xi8>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<1x23x179x1xi8>) {
    ^bb0(%out: i8):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %c0_i8 = arith.constant 0 : i8
      %c14_i32 = arith.constant 14 : i32
      %c12_i32 = arith.constant 12 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c11_i32 = arith.constant 11 : i32
      %c7_i32 = arith.constant 7 : i32
      %c89_i32 = arith.constant 89 : i32
      %c6_i32 = arith.constant 6 : i32
      %c0_i32_0 = arith.constant 0 : i32
      %c0_i32_1 = arith.constant 0 : i32
      %c0_i32_2 = arith.constant 0 : i32
      %c0_i32_3 = arith.constant 0 : i32
      %11 = arith.muli %9, %c7_i32 : i32
      %12 = arith.addi %11, %c0_i32_0 : i32
      %13 = arith.divsi %12, %c11_i32 : i32
      %14 = arith.muli %13, %c11_i32 : i32
      %15 = arith.subi %12, %14 : i32
      %16 = arith.muli %10, %c6_i32 : i32
      %17 = arith.addi %16, %c0_i32_1 : i32
      %18 = arith.divsi %17, %c89_i32 : i32
      %19 = arith.muli %18, %c89_i32 : i32
      %20 = arith.subi %17, %19 : i32
      %c1_i32 = arith.constant 1 : i32
      %21 = arith.shli %15, %c1_i32 : i32
      %22 = arith.cmpi sge, %21, %c11_i32 : i32
      %23 = arith.select %22, %c1_i32, %c0_i32 : i32
      %24 = arith.addi %13, %23 : i32
      %25 = arith.maxsi %c0_i32, %24 : i32
      %26 = arith.minsi %c14_i32, %25 : i32
      %27 = arith.index_cast %26 : i32 to index
      %28 = arith.shli %20, %c1_i32 : i32
      %29 = arith.cmpi sge, %28, %c89_i32 : i32
      %30 = arith.select %29, %c1_i32, %c0_i32 : i32
      %31 = arith.addi %18, %30 : i32
      %32 = arith.maxsi %c0_i32, %31 : i32
      %33 = arith.minsi %c12_i32, %32 : i32
      %34 = arith.index_cast %33 : i32 to index
      %extracted = tensor.extract %arg0[%5, %27, %34, %8] : tensor<1x15x13x1xi8>
      linalg.yield %extracted : i8
    } -> tensor<1x23x179x1xi8>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @resize_bilinear_int(%arg0: tensor<1x19x20x1xi8>) {
    %0 = tosa.const_shape  {values = dense<[16, 1, 16, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tensor.empty() : tensor<1x289x305x1xi48>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<1x289x305x1xi48>) {
    ^bb0(%out: i48):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %c0_i48 = arith.constant 0 : i48
      %c18_i32 = arith.constant 18 : i32
      %c19_i32 = arith.constant 19 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c16_i32 = arith.constant 16 : i32
      %c1_i32 = arith.constant 1 : i32
      %c16_i32_0 = arith.constant 16 : i32
      %c1_i32_1 = arith.constant 1 : i32
      %c0_i32_2 = arith.constant 0 : i32
      %c0_i32_3 = arith.constant 0 : i32
      %c0_i32_4 = arith.constant 0 : i32
      %c0_i32_5 = arith.constant 0 : i32
      %11 = arith.muli %9, %c1_i32 : i32
      %12 = arith.addi %11, %c0_i32_2 : i32
      %13 = arith.divsi %12, %c16_i32 : i32
      %14 = arith.muli %13, %c16_i32 : i32
      %15 = arith.subi %12, %14 : i32
      %16 = arith.muli %10, %c1_i32_1 : i32
      %17 = arith.addi %16, %c0_i32_3 : i32
      %18 = arith.divsi %17, %c16_i32_0 : i32
      %19 = arith.muli %18, %c16_i32_0 : i32
      %20 = arith.subi %17, %19 : i32
      %c1_i32_6 = arith.constant 1 : i32
      %21 = arith.addi %13, %c1_i32_6 : i32
      %22 = arith.maxsi %c0_i32, %13 : i32
      %23 = arith.minsi %c18_i32, %22 : i32
      %24 = arith.maxsi %c0_i32, %21 : i32
      %25 = arith.minsi %c18_i32, %24 : i32
      %26 = arith.index_cast %23 : i32 to index
      %27 = arith.index_cast %25 : i32 to index
      %28 = arith.addi %18, %c1_i32_6 : i32
      %29 = arith.maxsi %c0_i32, %18 : i32
      %30 = arith.minsi %c19_i32, %29 : i32
      %31 = arith.maxsi %c0_i32, %28 : i32
      %32 = arith.minsi %c19_i32, %31 : i32
      %33 = arith.index_cast %30 : i32 to index
      %34 = arith.index_cast %32 : i32 to index
      %extracted = tensor.extract %arg0[%5, %26, %33, %8] : tensor<1x19x20x1xi8>
      %extracted_7 = tensor.extract %arg0[%5, %26, %34, %8] : tensor<1x19x20x1xi8>
      %extracted_8 = tensor.extract %arg0[%5, %27, %33, %8] : tensor<1x19x20x1xi8>
      %extracted_9 = tensor.extract %arg0[%5, %27, %34, %8] : tensor<1x19x20x1xi8>
      %35 = arith.extsi %extracted : i8 to i48
      %36 = arith.extsi %extracted_7 : i8 to i48
      %37 = arith.extsi %extracted_8 : i8 to i48
      %38 = arith.extsi %extracted_9 : i8 to i48
      %39 = arith.extsi %20 : i32 to i48
      %40 = arith.extsi %15 : i32 to i48
      %41 = arith.extsi %c16_i32 : i32 to i48
      %42 = arith.extsi %c16_i32_0 : i32 to i48
      %43 = arith.subi %42, %39 : i48
      %44 = arith.muli %35, %43 : i48
      %45 = arith.muli %36, %39 : i48
      %46 = arith.addi %44, %45 : i48
      %47 = arith.subi %42, %39 : i48
      %48 = arith.muli %37, %47 : i48
      %49 = arith.muli %38, %39 : i48
      %50 = arith.addi %48, %49 : i48
      %51 = arith.subi %41, %40 : i48
      %52 = arith.muli %46, %51 : i48
      %53 = arith.muli %50, %40 : i48
      %54 = arith.addi %52, %53 : i48
      linalg.yield %54 : i48
    } -> tensor<1x289x305x1xi48>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @resize_nearest_fp32(%arg0: tensor<1x50x48x1xf32>) {
    %0 = tosa.const_shape  {values = dense<[64, 2, 64, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<-31> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<31> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tensor.empty() : tensor<1x1600x1536x1xf32>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<1x1600x1536x1xf32>) {
    ^bb0(%out: f32):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %cst = arith.constant 0.000000e+00 : f32
      %c49_i32 = arith.constant 49 : i32
      %c47_i32 = arith.constant 47 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c64_i32 = arith.constant 64 : i32
      %c2_i32 = arith.constant 2 : i32
      %c64_i32_0 = arith.constant 64 : i32
      %c2_i32_1 = arith.constant 2 : i32
      %c-31_i32 = arith.constant -31 : i32
      %c-31_i32_2 = arith.constant -31 : i32
      %c31_i32 = arith.constant 31 : i32
      %c31_i32_3 = arith.constant 31 : i32
      %11 = arith.muli %9, %c2_i32 : i32
      %12 = arith.addi %11, %c-31_i32 : i32
      %13 = arith.floordivsi %12, %c64_i32 : i32
      %14 = arith.remsi %12, %c64_i32 : i32
      %15 = arith.sitofp %14 : i32 to f32
      %16 = arith.uitofp %c64_i32 : i32 to f32
      %17 = arith.divf %15, %16 : f32
      %18 = arith.muli %10, %c2_i32_1 : i32
      %19 = arith.addi %18, %c-31_i32_2 : i32
      %20 = arith.floordivsi %19, %c64_i32_0 : i32
      %21 = arith.remsi %19, %c64_i32_0 : i32
      %22 = arith.sitofp %21 : i32 to f32
      %23 = arith.uitofp %c64_i32_0 : i32 to f32
      %24 = arith.divf %22, %23 : f32
      %c1_i32 = arith.constant 1 : i32
      %cst_4 = arith.constant 5.000000e-01 : f32
      %25 = arith.cmpf oge, %17, %cst_4 : f32
      %26 = arith.select %25, %c1_i32, %c0_i32 : i32
      %27 = arith.addi %13, %26 : i32
      %28 = arith.maxsi %c0_i32, %27 : i32
      %29 = arith.minsi %c49_i32, %28 : i32
      %30 = arith.index_cast %29 : i32 to index
      %cst_5 = arith.constant 5.000000e-01 : f32
      %31 = arith.cmpf oge, %24, %cst_5 : f32
      %32 = arith.select %31, %c1_i32, %c0_i32 : i32
      %33 = arith.addi %20, %32 : i32
      %34 = arith.maxsi %c0_i32, %33 : i32
      %35 = arith.minsi %c47_i32, %34 : i32
      %36 = arith.index_cast %35 : i32 to index
      %extracted = tensor.extract %arg0[%5, %30, %36, %8] : tensor<1x50x48x1xf32>
      linalg.yield %extracted : f32
    } -> tensor<1x1600x1536x1xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @resize_bilinear_fp(%arg0: tensor<1x23x24x1xf32>) {
    %0 = tosa.const_shape  {values = dense<[4, 1, 4, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tensor.empty() : tensor<1x89x93x1xf32>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<1x89x93x1xf32>) {
    ^bb0(%out: f32):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %cst = arith.constant 0.000000e+00 : f32
      %c22_i32 = arith.constant 22 : i32
      %c23_i32 = arith.constant 23 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c4_i32 = arith.constant 4 : i32
      %c1_i32 = arith.constant 1 : i32
      %c4_i32_0 = arith.constant 4 : i32
      %c1_i32_1 = arith.constant 1 : i32
      %c0_i32_2 = arith.constant 0 : i32
      %c0_i32_3 = arith.constant 0 : i32
      %c0_i32_4 = arith.constant 0 : i32
      %c0_i32_5 = arith.constant 0 : i32
      %11 = arith.muli %9, %c1_i32 : i32
      %12 = arith.addi %11, %c0_i32_2 : i32
      %13 = arith.floordivsi %12, %c4_i32 : i32
      %14 = arith.remsi %12, %c4_i32 : i32
      %15 = arith.sitofp %14 : i32 to f32
      %16 = arith.uitofp %c4_i32 : i32 to f32
      %17 = arith.divf %15, %16 : f32
      %18 = arith.muli %10, %c1_i32_1 : i32
      %19 = arith.addi %18, %c0_i32_3 : i32
      %20 = arith.floordivsi %19, %c4_i32_0 : i32
      %21 = arith.remsi %19, %c4_i32_0 : i32
      %22 = arith.sitofp %21 : i32 to f32
      %23 = arith.uitofp %c4_i32_0 : i32 to f32
      %24 = arith.divf %22, %23 : f32
      %c1_i32_6 = arith.constant 1 : i32
      %25 = arith.addi %13, %c1_i32_6 : i32
      %26 = arith.maxsi %c0_i32, %13 : i32
      %27 = arith.minsi %c22_i32, %26 : i32
      %28 = arith.maxsi %c0_i32, %25 : i32
      %29 = arith.minsi %c22_i32, %28 : i32
      %30 = arith.index_cast %27 : i32 to index
      %31 = arith.index_cast %29 : i32 to index
      %32 = arith.addi %20, %c1_i32_6 : i32
      %33 = arith.maxsi %c0_i32, %20 : i32
      %34 = arith.minsi %c23_i32, %33 : i32
      %35 = arith.maxsi %c0_i32, %32 : i32
      %36 = arith.minsi %c23_i32, %35 : i32
      %37 = arith.index_cast %34 : i32 to index
      %38 = arith.index_cast %36 : i32 to index
      %extracted = tensor.extract %arg0[%5, %30, %37, %8] : tensor<1x23x24x1xf32>
      %extracted_7 = tensor.extract %arg0[%5, %30, %38, %8] : tensor<1x23x24x1xf32>
      %extracted_8 = tensor.extract %arg0[%5, %31, %37, %8] : tensor<1x23x24x1xf32>
      %extracted_9 = tensor.extract %arg0[%5, %31, %38, %8] : tensor<1x23x24x1xf32>
      %cst_10 = arith.constant 1.000000e+00 : f32
      %39 = arith.subf %cst_10, %24 : f32
      %40 = arith.mulf %extracted, %39 : f32
      %41 = arith.mulf %extracted_7, %24 : f32
      %42 = arith.addf %40, %41 : f32
      %43 = arith.subf %cst_10, %24 : f32
      %44 = arith.mulf %extracted_8, %43 : f32
      %45 = arith.mulf %extracted_9, %24 : f32
      %46 = arith.addf %44, %45 : f32
      %47 = arith.subf %cst_10, %17 : f32
      %48 = arith.mulf %42, %47 : f32
      %49 = arith.mulf %46, %17 : f32
      %50 = arith.addf %48, %49 : f32
      linalg.yield %50 : f32
    } -> tensor<1x89x93x1xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @resize_dyn(%arg0: tensor<?x2x2x1xi8>) {
    %0 = tosa.const_shape  {values = dense<[4, 2, 4, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<-1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x2x2x1xi8>
    %3 = tensor.empty(%dim) : tensor<?x4x4x1xi32>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<?x4x4x1xi32>) {
    ^bb0(%out: i32):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %c0_i32_0 = arith.constant 0 : i32
      %c1_i32 = arith.constant 1 : i32
      %c1_i32_1 = arith.constant 1 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c4_i32 = arith.constant 4 : i32
      %c2_i32 = arith.constant 2 : i32
      %c4_i32_2 = arith.constant 4 : i32
      %c2_i32_3 = arith.constant 2 : i32
      %c-1_i32 = arith.constant -1 : i32
      %c-1_i32_4 = arith.constant -1 : i32
      %c1_i32_5 = arith.constant 1 : i32
      %c1_i32_6 = arith.constant 1 : i32
      %11 = arith.muli %9, %c2_i32 : i32
      %12 = arith.addi %11, %c-1_i32 : i32
      %13 = arith.divsi %12, %c4_i32 : i32
      %14 = arith.muli %13, %c4_i32 : i32
      %15 = arith.subi %12, %14 : i32
      %16 = arith.muli %10, %c2_i32_3 : i32
      %17 = arith.addi %16, %c-1_i32_4 : i32
      %18 = arith.divsi %17, %c4_i32_2 : i32
      %19 = arith.muli %18, %c4_i32_2 : i32
      %20 = arith.subi %17, %19 : i32
      %c1_i32_7 = arith.constant 1 : i32
      %21 = arith.addi %13, %c1_i32_7 : i32
      %22 = arith.maxsi %c0_i32, %13 : i32
      %23 = arith.minsi %c1_i32, %22 : i32
      %24 = arith.maxsi %c0_i32, %21 : i32
      %25 = arith.minsi %c1_i32, %24 : i32
      %26 = arith.index_cast %23 : i32 to index
      %27 = arith.index_cast %25 : i32 to index
      %28 = arith.addi %18, %c1_i32_7 : i32
      %29 = arith.maxsi %c0_i32, %18 : i32
      %30 = arith.minsi %c1_i32_1, %29 : i32
      %31 = arith.maxsi %c0_i32, %28 : i32
      %32 = arith.minsi %c1_i32_1, %31 : i32
      %33 = arith.index_cast %30 : i32 to index
      %34 = arith.index_cast %32 : i32 to index
      %extracted = tensor.extract %arg0[%5, %26, %33, %8] : tensor<?x2x2x1xi8>
      %extracted_8 = tensor.extract %arg0[%5, %26, %34, %8] : tensor<?x2x2x1xi8>
      %extracted_9 = tensor.extract %arg0[%5, %27, %33, %8] : tensor<?x2x2x1xi8>
      %extracted_10 = tensor.extract %arg0[%5, %27, %34, %8] : tensor<?x2x2x1xi8>
      %35 = arith.extsi %extracted : i8 to i32
      %36 = arith.extsi %extracted_8 : i8 to i32
      %37 = arith.extsi %extracted_9 : i8 to i32
      %38 = arith.extsi %extracted_10 : i8 to i32
      %39 = arith.subi %c4_i32_2, %20 : i32
      %40 = arith.muli %35, %39 : i32
      %41 = arith.muli %36, %20 : i32
      %42 = arith.addi %40, %41 : i32
      %43 = arith.subi %c4_i32_2, %20 : i32
      %44 = arith.muli %37, %43 : i32
      %45 = arith.muli %38, %20 : i32
      %46 = arith.addi %44, %45 : i32
      %47 = arith.subi %c4_i32, %15 : i32
      %48 = arith.muli %42, %47 : i32
      %49 = arith.muli %46, %15 : i32
      %50 = arith.addi %48, %49 : i32
      linalg.yield %50 : i32
    } -> tensor<?x4x4x1xi32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @resize_bilinear_int48(%arg0: tensor<1x19x19x1xi16>) {
    %0 = tosa.const_shape  {values = dense<[16, 1, 16, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tensor.empty() : tensor<1x289x289x1xi48>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<1x289x289x1xi48>) {
    ^bb0(%out: i48):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %c0_i48 = arith.constant 0 : i48
      %c18_i32 = arith.constant 18 : i32
      %c18_i32_0 = arith.constant 18 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c16_i32 = arith.constant 16 : i32
      %c1_i32 = arith.constant 1 : i32
      %c16_i32_1 = arith.constant 16 : i32
      %c1_i32_2 = arith.constant 1 : i32
      %c0_i32_3 = arith.constant 0 : i32
      %c0_i32_4 = arith.constant 0 : i32
      %c0_i32_5 = arith.constant 0 : i32
      %c0_i32_6 = arith.constant 0 : i32
      %11 = arith.muli %9, %c1_i32 : i32
      %12 = arith.addi %11, %c0_i32_3 : i32
      %13 = arith.divsi %12, %c16_i32 : i32
      %14 = arith.muli %13, %c16_i32 : i32
      %15 = arith.subi %12, %14 : i32
      %16 = arith.muli %10, %c1_i32_2 : i32
      %17 = arith.addi %16, %c0_i32_4 : i32
      %18 = arith.divsi %17, %c16_i32_1 : i32
      %19 = arith.muli %18, %c16_i32_1 : i32
      %20 = arith.subi %17, %19 : i32
      %c1_i32_7 = arith.constant 1 : i32
      %21 = arith.addi %13, %c1_i32_7 : i32
      %22 = arith.maxsi %c0_i32, %13 : i32
      %23 = arith.minsi %c18_i32, %22 : i32
      %24 = arith.maxsi %c0_i32, %21 : i32
      %25 = arith.minsi %c18_i32, %24 : i32
      %26 = arith.index_cast %23 : i32 to index
      %27 = arith.index_cast %25 : i32 to index
      %28 = arith.addi %18, %c1_i32_7 : i32
      %29 = arith.maxsi %c0_i32, %18 : i32
      %30 = arith.minsi %c18_i32_0, %29 : i32
      %31 = arith.maxsi %c0_i32, %28 : i32
      %32 = arith.minsi %c18_i32_0, %31 : i32
      %33 = arith.index_cast %30 : i32 to index
      %34 = arith.index_cast %32 : i32 to index
      %extracted = tensor.extract %arg0[%5, %26, %33, %8] : tensor<1x19x19x1xi16>
      %extracted_8 = tensor.extract %arg0[%5, %26, %34, %8] : tensor<1x19x19x1xi16>
      %extracted_9 = tensor.extract %arg0[%5, %27, %33, %8] : tensor<1x19x19x1xi16>
      %extracted_10 = tensor.extract %arg0[%5, %27, %34, %8] : tensor<1x19x19x1xi16>
      %35 = arith.extsi %extracted : i16 to i48
      %36 = arith.extsi %extracted_8 : i16 to i48
      %37 = arith.extsi %extracted_9 : i16 to i48
      %38 = arith.extsi %extracted_10 : i16 to i48
      %39 = arith.extsi %20 : i32 to i48
      %40 = arith.extsi %15 : i32 to i48
      %41 = arith.extsi %c16_i32 : i32 to i48
      %42 = arith.extsi %c16_i32_1 : i32 to i48
      %43 = arith.subi %42, %39 : i48
      %44 = arith.muli %35, %43 : i48
      %45 = arith.muli %36, %39 : i48
      %46 = arith.addi %44, %45 : i48
      %47 = arith.subi %42, %39 : i48
      %48 = arith.muli %37, %47 : i48
      %49 = arith.muli %38, %39 : i48
      %50 = arith.addi %48, %49 : i48
      %51 = arith.subi %41, %40 : i48
      %52 = arith.muli %46, %51 : i48
      %53 = arith.muli %50, %40 : i48
      %54 = arith.addi %52, %53 : i48
      linalg.yield %54 : i48
    } -> tensor<1x289x289x1xi48>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func @skip_interpolate_bilinear_i8(%arg0: tensor<3x1x2x7xi8>) -> tensor<3x1x4x7xi32> {
    %0 = tosa.const_shape  {values = dense<[2, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tensor.empty() : tensor<3x1x4x7xi32>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<3x1x4x7xi32>) {
    ^bb0(%out: i32):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %c0_i32_0 = arith.constant 0 : i32
      %c0_i32_1 = arith.constant 0 : i32
      %c1_i32 = arith.constant 1 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c2_i32 = arith.constant 2 : i32
      %c1_i32_2 = arith.constant 1 : i32
      %c3_i32 = arith.constant 3 : i32
      %c1_i32_3 = arith.constant 1 : i32
      %c0_i32_4 = arith.constant 0 : i32
      %c0_i32_5 = arith.constant 0 : i32
      %c0_i32_6 = arith.constant 0 : i32
      %c0_i32_7 = arith.constant 0 : i32
      %11 = arith.muli %10, %c1_i32_3 : i32
      %12 = arith.addi %11, %c0_i32_5 : i32
      %13 = arith.divsi %12, %c3_i32 : i32
      %14 = arith.muli %13, %c3_i32 : i32
      %15 = arith.subi %12, %14 : i32
      %c1_i32_8 = arith.constant 1 : i32
      %16 = arith.addi %c0_i32, %c1_i32_8 : i32
      %17 = arith.maxsi %c0_i32, %c0_i32 : i32
      %18 = arith.minsi %c0_i32_1, %17 : i32
      %19 = arith.maxsi %c0_i32, %16 : i32
      %20 = arith.minsi %c0_i32_1, %19 : i32
      %21 = arith.index_cast %18 : i32 to index
      %22 = arith.index_cast %20 : i32 to index
      %23 = arith.addi %13, %c1_i32_8 : i32
      %24 = arith.maxsi %c0_i32, %13 : i32
      %25 = arith.minsi %c1_i32, %24 : i32
      %26 = arith.maxsi %c0_i32, %23 : i32
      %27 = arith.minsi %c1_i32, %26 : i32
      %28 = arith.index_cast %25 : i32 to index
      %29 = arith.index_cast %27 : i32 to index
      %extracted = tensor.extract %arg0[%5, %21, %28, %8] : tensor<3x1x2x7xi8>
      %extracted_9 = tensor.extract %arg0[%5, %21, %29, %8] : tensor<3x1x2x7xi8>
      %extracted_10 = tensor.extract %arg0[%5, %22, %28, %8] : tensor<3x1x2x7xi8>
      %extracted_11 = tensor.extract %arg0[%5, %22, %29, %8] : tensor<3x1x2x7xi8>
      %30 = arith.extsi %extracted : i8 to i32
      %31 = arith.extsi %extracted_9 : i8 to i32
      %32 = arith.extsi %extracted_10 : i8 to i32
      %33 = arith.extsi %extracted_11 : i8 to i32
      %34 = arith.subi %c3_i32, %15 : i32
      %35 = arith.muli %30, %34 : i32
      %36 = arith.muli %31, %15 : i32
      %37 = arith.addi %35, %36 : i32
      %38 = arith.subi %c3_i32, %15 : i32
      %39 = arith.muli %32, %38 : i32
      %40 = arith.muli %33, %15 : i32
      %41 = arith.addi %39, %40 : i32
      %42 = arith.muli %37, %c2_i32 : i32
      linalg.yield %42 : i32
    } -> tensor<3x1x4x7xi32>
    return %4 : tensor<3x1x4x7xi32>
  }
  func.func @skip_interpolate_bilinear_f32(%arg0: tensor<3x1x2x7xf32>) -> tensor<3x1x4x7xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tensor.empty() : tensor<3x1x4x7xf32>
    %4 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%3 : tensor<3x1x4x7xf32>) {
    ^bb0(%out: f32):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = linalg.index 2 : index
      %8 = linalg.index 3 : index
      %c0_i32 = arith.constant 0 : i32
      %cst = arith.constant 0.000000e+00 : f32
      %c0_i32_0 = arith.constant 0 : i32
      %c1_i32 = arith.constant 1 : i32
      %9 = arith.index_cast %6 : index to i32
      %10 = arith.index_cast %7 : index to i32
      %c2_i32 = arith.constant 2 : i32
      %c1_i32_1 = arith.constant 1 : i32
      %c3_i32 = arith.constant 3 : i32
      %c1_i32_2 = arith.constant 1 : i32
      %c0_i32_3 = arith.constant 0 : i32
      %c0_i32_4 = arith.constant 0 : i32
      %c0_i32_5 = arith.constant 0 : i32
      %c0_i32_6 = arith.constant 0 : i32
      %11 = arith.muli %10, %c1_i32_2 : i32
      %12 = arith.addi %11, %c0_i32_4 : i32
      %13 = arith.floordivsi %12, %c3_i32 : i32
      %14 = arith.remsi %12, %c3_i32 : i32
      %15 = arith.sitofp %14 : i32 to f32
      %16 = arith.uitofp %c3_i32 : i32 to f32
      %17 = arith.divf %15, %16 : f32
      %c1_i32_7 = arith.constant 1 : i32
      %18 = arith.addi %c0_i32, %c1_i32_7 : i32
      %19 = arith.maxsi %c0_i32, %c0_i32 : i32
      %20 = arith.minsi %c0_i32_0, %19 : i32
      %21 = arith.maxsi %c0_i32, %18 : i32
      %22 = arith.minsi %c0_i32_0, %21 : i32
      %23 = arith.index_cast %20 : i32 to index
      %24 = arith.index_cast %22 : i32 to index
      %25 = arith.addi %13, %c1_i32_7 : i32
      %26 = arith.maxsi %c0_i32, %13 : i32
      %27 = arith.minsi %c1_i32, %26 : i32
      %28 = arith.maxsi %c0_i32, %25 : i32
      %29 = arith.minsi %c1_i32, %28 : i32
      %30 = arith.index_cast %27 : i32 to index
      %31 = arith.index_cast %29 : i32 to index
      %extracted = tensor.extract %arg0[%5, %23, %30, %8] : tensor<3x1x2x7xf32>
      %extracted_8 = tensor.extract %arg0[%5, %23, %31, %8] : tensor<3x1x2x7xf32>
      %extracted_9 = tensor.extract %arg0[%5, %24, %30, %8] : tensor<3x1x2x7xf32>
      %extracted_10 = tensor.extract %arg0[%5, %24, %31, %8] : tensor<3x1x2x7xf32>
      %cst_11 = arith.constant 1.000000e+00 : f32
      %32 = arith.subf %cst_11, %17 : f32
      %33 = arith.mulf %extracted, %32 : f32
      %34 = arith.mulf %extracted_8, %17 : f32
      %35 = arith.addf %33, %34 : f32
      %36 = arith.subf %cst_11, %17 : f32
      %37 = arith.mulf %extracted_9, %36 : f32
      %38 = arith.mulf %extracted_10, %17 : f32
      %39 = arith.addf %37, %38 : f32
      linalg.yield %35 : f32
    } -> tensor<3x1x4x7xf32>
    return %4 : tensor<3x1x4x7xf32>
  }
}

